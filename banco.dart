import 'dart:io';

// Clase para representar a un cliente
class Cliente {
  String identificacion;
  String nombre;
  String correo;

  Cliente(this.identificacion, this.nombre, this.correo);
}

// Clase para cuenta de ahorro
class CuentaAhorros {
  String codigo;
  DateTime fechaCreacion;
  double saldo;
  Cliente propietario;

  CuentaAhorros(this.codigo, this.fechaCreacion, this.saldo, this.propietario);
}

// Clase de banco que contiene operaciones de las cuentas
class Banco {
  List<CuentaAhorros> cuentas = [];
  int contador = 0;

  // crear una cuenta de ahorros
  void crearCuenta(Cliente cliente) {
    int anioActual = DateTime.now().year;
    contador++;
    String codigo = '$anioActual-$contador';
    CuentaAhorros cuenta = CuentaAhorros(codigo, DateTime.now(), 0.0, cliente);
    cuentas.add(cuenta);
    print('Cuenta creada con éxito! Código: $codigo');
  }

  // consignar dinero a una cuenta
  void consignar(String codigo, double monto) {
    for (var cuenta in cuentas) {
      if (cuenta.codigo == codigo) {
        cuenta.saldo += monto;
        print('Se han consignado \$${monto} a la cuenta $codigo. Nuevo Saldo: \$${cuenta.saldo}');
        return;
      }
    }
    print('Cuenta no encontrada.');
  }

  // para retirar dinero de una cuenta
  void retirar(String codigo, double monto) {
    for (var cuenta in cuentas) {
      if (cuenta.codigo == codigo) {
        if (cuenta.saldo >= monto) {
          cuenta.saldo -= monto;
          print('Se han retirado \$${monto} de la cuenta $codigo. Nuevo Saldo: \$${cuenta.saldo}');
        } else {
          print('Saldo insuficiente.');
        }
        return;
      }
    }
    print('Cuenta no encontrada.');
  }

  // para consultar información de una cuenta
  void consultarCuenta(String codigo) {
    for (var cuenta in cuentas) {
      if (cuenta.codigo == codigo) {
        print('Código: ${cuenta.codigo}');
        print('Fecha de creación: ${cuenta.fechaCreacion}');
        print('Saldo: \$${cuenta.saldo}');
        print('Propietario: ${cuenta.propietario.nombre} (${cuenta.propietario.identificacion})');
        return;
      }
    }
    print('Cuenta no encontrada.');
  }

  //para listar todas las cuentas
  void listarCuentas() {
    for (var cuenta in cuentas) {
      print('Código: ${cuenta.codigo}, Saldo: \$${cuenta.saldo}, Propietario: ${cuenta.propietario.nombre}');
    }
  }

  // mostrar el menú y gestionar las opciones
  void menu() {
    while (true) {
      print('MENÚ BANCO ADSO 2874057 ');
      print('1. crea tu cuenta');
      print('2. ingresar dinero');
      print('3. Retirar dinero');
      print('4. Consultar tu Cuenta Por Código');
      print('5. Lista de Cuentas');
      print('6. salir');
      stdout.write('Ingrese Opción (1-6): ');
      
      String? opcion = stdin.readLineSync();
      switch (opcion) {
        case '1':
          stdout.write('Ingrese identificación: ');
          String id = stdin.readLineSync()!;
          stdout.write('Ingrese nombre completo: ');
          String nombre = stdin.readLineSync()!;
          stdout.write('Ingrese correo electrónico: ');
          String correo = stdin.readLineSync()!;
          Cliente cliente = Cliente(id, nombre, correo);
          crearCuenta(cliente);
          break;
        case '2':
          stdout.write('Ingrese código de cuenta: ');
          String codigo = stdin.readLineSync()!;
          stdout.write('Ingrese cantidad a consignar: ');
          double monto = double.parse(stdin.readLineSync()!);
          consignar(codigo, monto);
          break;
        case '3':
          stdout.write('Ingrese código de cuenta: ');
          String codigoRetiro = stdin.readLineSync()!;
          stdout.write('Ingrese cantidad a retirar: ');
          double montoRetiro = double.parse(stdin.readLineSync()!);
          retirar(codigoRetiro, montoRetiro);
          break;
        case '4':
          stdout.write('Ingrese código de cuenta: ');
          String codigoConsulta = stdin.readLineSync()!;
          consultarCuenta(codigoConsulta);
          break;
        case '5':
          listarCuentas();
          break;
        case '6':
          print('cerrar y salir ##.');
          return;
        default:
          print('intente nuevamente.');
      }
    }
  }
}

void main() {
  Banco banco = Banco();
  banco.menu();
}