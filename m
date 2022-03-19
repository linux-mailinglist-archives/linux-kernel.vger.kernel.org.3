Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C94DEAE5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbiCSUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiCSUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:48:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199C264F54;
        Sat, 19 Mar 2022 13:47:01 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8D2E422450;
        Sat, 19 Mar 2022 21:46:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647722819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEf5Qdy2CZeKPC3PR1yIdltyKRL+/rUuvVCQ5taspNg=;
        b=EC8mOIwEdpG6mVzMc3/1mn5D5CdVRIZ1Ze3UZVxGWgMNVJK67buWy9yGT17eWNxZYKiS2l
        7I5/7LwSjZXNmHhR2jGwqwiO3tBG4hL3BtovkBlHMELZnv5zS2OaCLz9XbrEfPMxSfS2FJ
        pdU8ajepRCBPPpwRpmSlrKC5yt5xUSo=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 6/6] dt-bindings: pinctrl: convert ocelot-pinctrl to YAML format
Date:   Sat, 19 Mar 2022 21:46:28 +0100
Message-Id: <20220319204628.1759635-7-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220319204628.1759635-1-michael@walle.cc>
References: <20220319204628.1759635-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ocelot-pinctrl device tree binding to the new YAML format.

Additionally to the original binding documentation, add interrupt
properties which are optional and already used on several SoCs like
SparX-5, Luton, Ocelot and LAN966x but were not documented before.

Also, on the sparx5 and the lan966x SoCs there are two items for the
reg property.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  |  42 -------
 .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml | 108 ++++++++++++++++++
 2 files changed, 108 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
deleted file mode 100644
index 5d84fd299ccf..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Microsemi Ocelot pin controller Device Tree Bindings
-----------------------------------------------------
-
-Required properties:
- - compatible		: Should be "mscc,ocelot-pinctrl",
-			  "mscc,jaguar2-pinctrl", "microchip,sparx5-pinctrl",
-			  "mscc,luton-pinctrl", "mscc,serval-pinctrl",
-			  "microchip,lan966x-pinctrl" or "mscc,servalt-pinctrl"
- - reg			: Address and length of the register set for the device
- - gpio-controller	: Indicates this device is a GPIO controller
- - #gpio-cells		: Must be 2.
-			  The first cell is the pin number and the
-			  second cell specifies GPIO flags, as defined in
-			  <dt-bindings/gpio/gpio.h>.
- - gpio-ranges		: Range of pins managed by the GPIO controller.
-
-
-The ocelot-pinctrl driver uses the generic pin multiplexing and generic pin
-configuration documented in pinctrl-bindings.txt.
-
-The following generic properties are supported:
- - function
- - pins
-
-Example:
-	gpio: pinctrl@71070034 {
-		compatible = "mscc,ocelot-pinctrl";
-		reg = <0x71070034 0x28>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&gpio 0 0 22>;
-
-		uart_pins: uart-pins {
-				pins = "GPIO_6", "GPIO_7";
-				function = "uart";
-		};
-
-		uart2_pins: uart2-pins {
-				pins = "GPIO_12", "GPIO_13";
-				function = "uart2";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
new file mode 100644
index 000000000000..7149a6655623
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/mscc,ocelot-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsemi Ocelot pin controller
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,lan966x-pinctrl
+      - microchip,sparx5-pinctrl
+      - mscc,jaguar2-pinctrl
+      - mscc,luton-pinctrl
+      - mscc,ocelot-pinctrl
+      - mscc,serval-pinctrl
+      - mscc,servalt-pinctrl
+
+  reg:
+    items:
+      - description: Base address
+      - description: Extended pin configuration registers
+    minItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-ranges: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+patternProperties:
+  '-pins$':
+    type: object
+    allOf:
+      - $ref: "pinmux-node.yaml"
+      - $ref: "pincfg-node.yaml"
+
+    properties:
+      function: true
+      pins: true
+      output-high: true
+      output-low: true
+      drive-strength: true
+
+    required:
+      - function
+      - pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,lan966x-pinctrl
+              - microchip,sparx5-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio: pinctrl@71070034 {
+        compatible = "mscc,ocelot-pinctrl";
+        reg = <0x71070034 0x28>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&gpio 0 0 22>;
+
+        uart_pins: uart-pins {
+            pins = "GPIO_6", "GPIO_7";
+            function = "uart";
+        };
+
+        uart2_pins: uart2-pins {
+            pins = "GPIO_12", "GPIO_13";
+            function = "uart2";
+        };
+    };
+
+...
-- 
2.30.2

