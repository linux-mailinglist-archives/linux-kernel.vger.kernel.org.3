Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31A8467935
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381378AbhLCORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357861AbhLCORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:17:36 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC9C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:14:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:3191:9890:620a:6f4])
        by michel.telenet-ops.be with bizsmtp
        id RqEA2600C3eLghq06qEACG; Fri, 03 Dec 2021 15:14:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt9KD-002Lvw-Om; Fri, 03 Dec 2021 15:14:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mt9KC-000lod-NM; Fri, 03 Dec 2021 15:14:08 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2] dt-bindings: display: bridge: sil,sii9022: Convert to json-schema
Date:   Fri,  3 Dec 2021 15:14:07 +0100
Message-Id: <3b2619682694050696e5c85269ccc4f864590e66.1638540704.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Silicon Image sii902x HDMI bridge Device Tree binding
documentation to json-schema.

Add missing sil,sii9022-cpi and sil,sii9022-tpi compatible values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
RFC as I do not know the meaning of the various ports subnodes.

v2:
  - Rework sil,i2s-data-lanes,
  - Add schema reference to ports.
---
 .../bindings/display/bridge/sii902x.txt       |  78 ----------
 .../bindings/display/bridge/sil,sii9022.yaml  | 133 ++++++++++++++++++
 2 files changed, 133 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/sii902x.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
deleted file mode 100644
index 3bc760cc31cbbeee..0000000000000000
--- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-sii902x HDMI bridge bindings
-
-Required properties:
-	- compatible: "sil,sii9022"
-	- reg: i2c address of the bridge
-
-Optional properties:
-	- interrupts: describe the interrupt line used to inform the host
-	  about hotplug events.
-	- reset-gpios: OF device-tree gpio specification for RST_N pin.
-	- iovcc-supply: I/O Supply Voltage (1.8V or 3.3V)
-	- cvcc12-supply: Digital Core Supply Voltage (1.2V)
-
-	HDMI audio properties:
-	- #sound-dai-cells: <0> or <1>. <0> if only i2s or spdif pin
-	   is wired, <1> if the both are wired. HDMI audio is
-	   configured only if this property is found.
-	- sil,i2s-data-lanes: Array of up to 4 integers with values of 0-3
-	   Each integer indicates which i2s pin is connected to which
-	   audio fifo. The first integer selects i2s audio pin for the
-	   first audio fifo#0 (HDMI channels 1&2), second for fifo#1
-	   (HDMI channels 3&4), and so on. There is 4 fifos and 4 i2s
-	   pins (SD0 - SD3). Any i2s pin can be connected to any fifo,
-	   but there can be no gaps. E.g. an i2s pin must be mapped to
-	   fifo#0 and fifo#1 before mapping a channel to fifo#2. Default
-	   value is <0>, describing SD0 pin beiging routed to hdmi audio
-	   fifo #0.
-	- clocks: phandle and clock specifier for each clock listed in
-           the clock-names property
-	- clock-names: "mclk"
-	   Describes SII902x MCLK input. MCLK can be used to produce
-	   HDMI audio CTS values. This property follows
-	   Documentation/devicetree/bindings/clock/clock-bindings.txt
-	   consumer binding.
-
-	If HDMI audio is configured the sii902x device becomes an I2S
-	and/or spdif audio codec component (e.g a digital audio sink),
-	that can be used in configuring a full audio devices with
-	simple-card or audio-graph-card binding. See their binding
-	documents on how to describe the way the sii902x device is
-	connected to the rest of the audio system:
-	Documentation/devicetree/bindings/sound/simple-card.yaml
-	Documentation/devicetree/bindings/sound/audio-graph-card.yaml
-	Note: In case of the audio-graph-card binding the used port
-	index should be 3.
-
-Optional subnodes:
-	- video input: this subnode can contain a video input port node
-	  to connect the bridge to a display controller output (See this
-	  documentation [1]).
-
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-	hdmi-bridge@39 {
-		compatible = "sil,sii9022";
-		reg = <0x39>;
-		reset-gpios = <&pioA 1 0>;
-		iovcc-supply = <&v3v3_hdmi>;
-		cvcc12-supply = <&v1v2_hdmi>;
-
-		#sound-dai-cells = <0>;
-		sil,i2s-data-lanes = < 0 1 2 >;
-		clocks = <&mclk>;
-		clock-names = "mclk";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				bridge_in: endpoint {
-					remote-endpoint = <&dc_out>;
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
new file mode 100644
index 0000000000000000..b39537f4fe8694ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/sil,sii9022.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Image sii902x HDMI bridge
+
+maintainers:
+  - Boris Brezillon <bbrezillon@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sil,sii9022-cpi
+              - sil,sii9022-tpi
+          - const: sil,sii9022
+      - const: sil,sii9022
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt line used to inform the host about hotplug events.
+
+  reset-gpios:
+    maxItems: 1
+
+  iovcc-supply:
+    description: I/O Supply Voltage (1.8V or 3.3V)
+
+  cvcc12-supply:
+    description: Digital Core Supply Voltage (1.2V)
+
+  '#sound-dai-cells':
+    enum: [ 0, 1 ]
+    description: |
+      <0> if only i2s or spdif pin is wired,
+      <1> if both are wired.
+      HDMI audio is configured only if this property is found.
+      If HDMI audio is configured the sii902x device becomes an I2S and/or
+      spdif audio codec component (e.g. a digital audio sink), that can be used
+      in configuring a full audio devices with simple-card or audio-graph-card
+      binding. See their binding documents on how to describe the way the
+      sii902x device is connected to the rest of the audio system:
+      Documentation/devicetree/bindings/sound/simple-card.yaml
+      Documentation/devicetree/bindings/sound/audio-graph-card.yaml
+      Note: In case of the audio-graph-card binding the used port index should
+      be 3.
+
+  sil,i2s-data-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4
+    uniqueItems: true
+    items:
+      enum: [ 0, 1, 2, 3 ]
+    description:
+      Each integer indicates which i2s pin is connected to which audio fifo.
+      The first integer selects i2s audio pin for the first audio fifo#0 (HDMI
+      channels 1&2), second for fifo#1 (HDMI channels 3&4), and so on. There
+      are 4 fifos and 4 i2s pins (SD0 - SD3). Any i2s pin can be connected to
+      any fifo, but there can be no gaps. E.g. an i2s pin must be mapped to
+      fifo#0 and fifo#1 before mapping a channel to fifo#2. Default value is
+      <0>, describing SD0 pin being routed to hdmi audio fifo #0.
+
+  clocks:
+    maxItems: 1
+    description: MCLK input. MCLK can be used to produce HDMI audio CTS values.
+
+  clock-names:
+    const: mclk
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        type: object
+        description: FIXME
+
+      port@1:
+        type: object
+        description: FIXME
+
+      port@2:
+        type: object
+        description: FIXME
+
+      port@3:
+        type: object
+        description: FIXME
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hdmi-bridge@39 {
+            compatible = "sil,sii9022";
+            reg = <0x39>;
+            reset-gpios = <&pioA 1 0>;
+            iovcc-supply = <&v3v3_hdmi>;
+            cvcc12-supply = <&v1v2_hdmi>;
+
+            #sound-dai-cells = <0>;
+            sil,i2s-data-lanes = < 0 1 2 >;
+            clocks = <&mclk>;
+            clock-names = "mclk";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    bridge_in: endpoint {
+                        remote-endpoint = <&dc_out>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.25.1

