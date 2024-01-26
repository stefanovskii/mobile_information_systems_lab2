import 'package:flutter/material.dart';
import 'package:lab2/model/ClothesClass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Clothes(),
    );
  }
}

class Clothes extends StatefulWidget {
  const Clothes({super.key});

  @override
  State<Clothes> createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {

  List<ClothesClass> clothesList = [];
  String currentTypeAdd = "Sneakers";
  String currentColorAdd = "Blue";
  String currentTypeEdit = "";
  String currentColorEdit = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clothes App"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () => _addClothesDialog(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: const Text("Add Clothes", style: TextStyle(color: Colors.red),)),
          const Text("All clothes: ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.blue),),
          Expanded(child: ListView.builder(
              itemCount: clothesList.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text('${clothesList[index].type} - ${clothesList[index].color}', style: const TextStyle(color: Colors.blue, fontSize: 16),),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(onPressed: () => _editClothesDialog(index), icon: const Icon(Icons.edit_rounded)),
                        IconButton(onPressed: () => _deleteClothes(index), icon: const Icon(Icons.delete_rounded)),
                      ],
                    ),
                  )
                );
              }
          ))
        ],
      ),
    );
  }

  Widget _buildTypeDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currentTypeAdd) {
            currentTypeAdd = value!;
          } else if (currentValue == currentTypeEdit) {
            currentTypeEdit = value!;
          }
        });
      },
      items: ['Sneakers', 'Jeans', 'Hat', 'Shirt']
          .map<DropdownMenuItem<String>>((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Type', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  Widget _buildColorDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currentColorAdd) {
            currentColorAdd = value!;
          } else if (currentValue == currentColorEdit) {
            currentColorEdit = value!;
          }
        });
      },
      items: ['Blue', 'Green', 'Yellow', 'Black', 'White']
          .map<DropdownMenuItem<String>>((String color) {
        return DropdownMenuItem<String>(
          value: color,
          child: Text(color),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Color', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  void _addClothesDialog() {
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Add Clothes'),
            content: Column(
              children: [
                _buildTypeDropdown(currentTypeAdd),
                _buildColorDropdown(currentColorAdd),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        backgroundColor: Colors.green, color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  _addClothes();
                  Navigator.pop(context);
                },
                child: const Text('Confirm',
                    style: TextStyle(
                        backgroundColor: Colors.green, color: Colors.red)),
              ),
            ],
          );
        });
  }

  void _addClothes() {
    if(currentTypeAdd.isNotEmpty && currentColorAdd.isNotEmpty){
      setState(() {
        clothesList.add(ClothesClass(type: currentTypeAdd, color: currentColorAdd));
      });
    }
  }

  void _deleteClothes(int index) {
    setState(() {
      clothesList.removeAt(index);
    });
  }

  void _editClothes(int index) {
    if(currentTypeEdit.isNotEmpty && currentColorEdit.isNotEmpty){
      setState(() {
        clothesList[index].type = currentTypeEdit;
        clothesList[index].color = currentColorEdit;
      });
    }
  }
  
  void _editClothesDialog(int index) {
    currentTypeEdit = clothesList[index].type;
    currentColorEdit = clothesList[index].color;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Clothes'),
          content: Column(
            children: [
              _buildTypeDropdown(currentTypeEdit),
              _buildColorDropdown(currentColorEdit),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                _editClothes(index);
                Navigator.pop(context);
              },
              child: const Text('Save',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

}
