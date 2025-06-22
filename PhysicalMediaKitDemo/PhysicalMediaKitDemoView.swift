//
//  PhysicalMediaKitDemoView.swift
//  PhysicalMediaKitDemo
//
//  Created by Spencer Hartland on 6/12/25.
//

import SwiftUI
import PhysicalMediaKit

fileprivate enum MediaType: String {
    case vinylRecord = "Vinyl Record"
    case compactDisc = "Compact Disc"
    case compactCassette = "Compact Cassette"
}

struct PhysicalMediaKitDemoView: View {
    @State private var albumArtURLString = "https://f4.bcbits.com/img/a3629485078_10.jpg"
    @State private var selectedMediaType: MediaType = .vinylRecord
    @State private var mediaColor: Color = .pink
    @State private var mediaOpacity: Float = 0.5
    @State private var modelScale: Float = 0.8
    
    var body: some View {
        VStack {
            Text("PhysicalMediaKit Demo")
                .font(.body.bold())
            
            Picker("Media Type", selection: $selectedMediaType) {
                Text(MediaType.vinylRecord.rawValue).tag(MediaType.vinylRecord)
                Text(MediaType.compactDisc.rawValue).tag(MediaType.compactDisc)
                Text(MediaType.compactCassette.rawValue).tag(MediaType.compactCassette)
            }
            .pickerStyle(.segmented)
            
            if let albumArtURL = URL(string: albumArtURLString) {
                switch self.selectedMediaType {
                case .vinylRecord:
                    PhysicalMedia.vinylRecord(
                        albumArtURL: albumArtURL,
                        vinylColor: mediaColor,
                        scale: modelScale
                    )
                case .compactDisc:
                    PhysicalMedia.compactDisc(
                        albumArtURL: albumArtURL,
                        scale: modelScale
                    )
                case .compactCassette:
                    PhysicalMedia.compactCassette(
                        albumArtURL: albumArtURL,
                        cassetteColor: mediaColor,
                        scale: modelScale
                    )
                }
            } else {
                Spacer()
                Label("Invalid Album Art URL", systemImage: "globe")
                Spacer()
            }
            
            VStack {
                VStack(alignment: .leading) {
                    Label("Album Artwork URL", systemImage: "globe")
                        .font(.caption.bold())
                    TextField("Album Artwork URL", text: $albumArtURLString, prompt: Text("https:/example.com/artwork"))
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color(UIColor.systemFill))
                        .cornerRadius(8)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                
                if selectedMediaType != .compactDisc {
                    ColorPicker("Media Color", selection: $mediaColor, supportsOpacity: true)
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .font(.caption.bold())
                }
                
                VStack(alignment: .leading) {
                    Text("Model Scale")
                        .font(.caption.bold())
                    Slider(value: $modelScale, in: 0.0...1.0)
                }
                .padding([.top, .horizontal])
                .padding(.bottom, 6)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    PhysicalMediaKitDemoView()
}
