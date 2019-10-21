import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/presentation/ui/constants.dart';
import 'package:flutter_catalog/presentation/ui/themes.dart';
import 'package:flutter_catalog/presentation/widgets/my_app_routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/my_app_settings.dart';

class MyMainApp extends StatelessWidget {
  //Constructor / const: can be  determined entirely at compile time
  const MyMainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Esperar para que se complete una operacion asincrona
    return FutureBuilder<SharedPreferences>(
      //Datos se conservan en el disco de forma asincrona
      future: SharedPreferences.getInstance(),
      //AsyncSnapshot: representacion inmutable de la interaccion mas reciente con un calculo asincrono
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        //!exrp: invierte la siguiente expresion (cambia F a V y viceversa)
        //snapshot.hasData: Devuelve si esta snapshot contiene un valor de datos no nulo
        //“snapshot.hasData” and “snapshot.data != null” does the same as per the code
        if (!snapshot.hasData) {
          return _MySplashScreen();
        }
        /*
        ChangeNotifierProvider: es el widget que proporciona una instancia de
        un ChangeNotifier a sus descendientes. Viene del paquete provider.
        */
        //ChangeNotifierProvider.value to provider an existing ChangeNotifier:
        return ChangeNotifierProvider<MyAppSettings>.value(
          value: MyAppSettings(snapshot.data),
          child: _MyMainApp(),
        );
      },
    );
  }
}

///MySplashScreen
class _MySplashScreen extends StatelessWidget {
  const _MySplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: Center(child: kAppIcon),
    );
  }
}

///MyMainApp
class _MyMainApp extends StatelessWidget {
  const _MyMainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Catalog',
      theme: Provider.of<MyAppSettings>(context).isDarkMode
          ? kDartTheme
          : kLightTheme,
      //Go to 'my_app_routes.dart'
      routes: kAppRoutingTable,
    );
  }
}
