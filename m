Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE0471635
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 21:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhLKUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 15:40:29 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:34804 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231294AbhLKUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 15:40:26 -0500
X-UUID: f98cefd0190a4dbb975fdfcf09791ece-20211212
X-UUID: f98cefd0190a4dbb975fdfcf09791ece-20211212
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 916565421; Sun, 12 Dec 2021 04:40:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 12 Dec 2021 04:40:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 12 Dec 2021 04:40:17 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <broonie@kernel.org>
CC:     <bgolaszewski@baylibre.com>, <sean.wang@mediatek.com>,
        <bayi.cheng@mediatek.com>, <gch981213@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v6 3/4] dt-bindings: pinctrl: mt8195: add 'pins' wrapping node
Date:   Sun, 12 Dec 2021 04:40:13 +0800
Message-ID: <20211211204014.8014-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20211211204014.8014-1-tinghan.shen@mediatek.com>
References: <20211211204014.8014-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mt8195 pinctrl driver requires a 'pins' subnode to wrap pin properties.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../bindings/pinctrl/pinctrl-mt8195.yaml      | 307 +++++++++---------
 1 file changed, 160 insertions(+), 147 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 5e2bb2bf3a55..2035bf164740 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -59,133 +59,143 @@ properties:
 patternProperties:
   '-pins$':
     type: object
-    description: |
-      A pinctrl node should contain at least one subnodes representing the
-      pinctrl groups available on the machine. Each subnode will list the
-      pins it needs, and how they should be configured, with regard to muxer
-      configuration, pullups, drive strength, input enable/disable and
-      input schmitt.
-      An example of using macro:
-      pincontroller {
-        /* GPIO0 set as multifunction GPIO0 */
-        gpio_pin {
-          pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
-        };
-        /* GPIO8 set as multifunction SDA0 */
-        i2c0_pin {
-          pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
-        };
-      };
-    $ref: "pinmux-node.yaml"
-
-    properties:
-      pinmux:
-        description: |
-          Integer array, represents gpio pin number and mux setting.
-          Supported pin number and mux varies for different SoCs, and are defined
-          as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
-
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-
-      bias-pull-down:
-        description: |
-          For pull down type is normal, it don't need add RSEL & R1R0 define
-          and resistance value.
-          For pull down type is PUPD/R0/R1 type, it can add R1R0 define to
-          set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
-          "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" & "MTK_PUPD_SET_R1R0_11"
-          define in mt8195.
-          For pull down type is RSEL, it can add RSEL define & resistance value(ohm)
-          to set different resistance by identifying property "mediatek,rsel_resistance_in_si_unit".
-          It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-          & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" & "MTK_PULL_SET_RSEL_100"
-          & "MTK_PULL_SET_RSEL_101" & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-          define in mt8195. It can also support resistance value(ohm) "75000" & "5000" in mt8195.
-          oneOf:
-            - enum: [100, 101, 102, 103]
-            - description: mt8195 pull down PUPD/R0/R1 type define value.
-            - enum: [200, 201, 202, 203, 204, 205, 206, 207]
-            - description: mt8195 pull down RSEL type define value.
-            - enum: [75000, 5000]
-            - description: mt8195 pull down RSEL type si unit value(ohm).
-
-          An example of using RSEL define:
-          pincontroller {
-            i2c0_pin {
-              pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
-              bias-pull-down = <MTK_PULL_SET_RSEL_001>;
-            };
-          };
-          An example of using si unit resistance value(ohm):
-          &pio {
-            mediatek,rsel_resistance_in_si_unit;
-          }
-          pincontroller {
-            i2c0_pin {
-              pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
-              bias-pull-down = <75000>;
-            };
-          };
-
-      bias-pull-up:
+    additionalProperties: false
+    patternProperties:
+      'pins':
+        type: object
+        additionalProperties: false
         description: |
-          For pull up type is normal, it don't need add RSEL & R1R0 define
-          and resistance value.
-          For pull up type is PUPD/R0/R1 type, it can add R1R0 define to
-          set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
-          "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" & "MTK_PUPD_SET_R1R0_11"
-          define in mt8195.
-          For pull up type is RSEL, it can add RSEL define & resistance value(ohm)
-          to set different resistance by identifying property "mediatek,rsel_resistance_in_si_unit".
-          It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
-          & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011" & "MTK_PULL_SET_RSEL_100"
-          & "MTK_PULL_SET_RSEL_101" & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
-          define in mt8195. It can also support resistance value(ohm)
-          "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" & "75000" in mt8195.
-          oneOf:
-            - enum: [100, 101, 102, 103]
-            - description: mt8195 pull up PUPD/R0/R1 type define value.
-            - enum: [200, 201, 202, 203, 204, 205, 206, 207]
-            - description: mt8195 pull up RSEL type define value.
-            - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000, 75000]
-            - description: mt8195 pull up RSEL type si unit value(ohm).
-          An example of using RSEL define:
+          A pinctrl node should contain at least one subnodes representing the
+          pinctrl groups available on the machine. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to muxer
+          configuration, pullups, drive strength, input enable/disable and
+          input schmitt.
+          An example of using macro:
           pincontroller {
-            i2c0_pin {
-              pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
-              bias-pull-up = <MTK_PULL_SET_RSEL_001>;
+            /* GPIO0 set as multifunction GPIO0 */
+            gpio_pin {
+              pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
             };
-          };
-          An example of using si unit resistance value(ohm):
-          &pio {
-            mediatek,rsel_resistance_in_si_unit;
-          }
-          pincontroller {
+            /* GPIO8 set as multifunction SDA0 */
             i2c0_pin {
               pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
-              bias-pull-up = <1000>;
             };
           };
-
-      bias-disable: true
-
-      output-high: true
-
-      output-low: true
-
-      input-enable: true
-
-      input-disable: true
-
-      input-schmitt-enable: true
-
-      input-schmitt-disable: true
-
-    required:
-      - pinmux
-
-    additionalProperties: false
+        $ref: "pinmux-node.yaml"
+
+        properties:
+          pinmux:
+            description: |
+              Integer array, represents gpio pin number and mux setting.
+              Supported pin number and mux varies for different SoCs, and are
+              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
+              directly.
+
+          drive-strength:
+            enum: [2, 4, 6, 8, 10, 12, 14, 16]
+
+          bias-pull-down:
+            description: |
+              For pull down type is normal, it don't need add RSEL & R1R0 define
+              and resistance value.
+              For pull down type is PUPD/R0/R1 type, it can add R1R0 define to
+              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8195.
+              For pull down type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel_resistance_in_si_unit".
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
+              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
+              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
+              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
+              define in mt8195. It can also support resistance value(ohm)
+              "75000" & "5000" in mt8195.
+              oneOf:
+                - enum: [100, 101, 102, 103]
+                - description: mt8195 pull down PUPD/R0/R1 type define value.
+                - enum: [200, 201, 202, 203, 204, 205, 206, 207]
+                - description: mt8195 pull down RSEL type define value.
+                - enum: [75000, 5000]
+                - description: mt8195 pull down RSEL type si unit value(ohm).
+
+              An example of using RSEL define:
+              pincontroller {
+                i2c0_pin {
+                  pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                  bias-pull-down = <MTK_PULL_SET_RSEL_001>;
+                };
+              };
+              An example of using si unit resistance value(ohm):
+              &pio {
+                mediatek,rsel_resistance_in_si_unit;
+              }
+              pincontroller {
+                i2c0_pin {
+                  pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                  bias-pull-down = <75000>;
+                };
+              };
+
+          bias-pull-up:
+            description: |
+              For pull up type is normal, it don't need add RSEL & R1R0 define
+              and resistance value.
+              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to
+              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
+              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
+              "MTK_PUPD_SET_R1R0_11" define in mt8195.
+              For pull up type is RSEL, it can add RSEL define & resistance
+              value(ohm) to set different resistance by identifying property
+              "mediatek,rsel_resistance_in_si_unit".
+              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
+              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
+              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
+              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
+              define in mt8195. It can also support resistance value(ohm)
+              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" &
+              "75000" in mt8195.
+              oneOf:
+                - enum: [100, 101, 102, 103]
+                - description: mt8195 pull up PUPD/R0/R1 type define value.
+                - enum: [200, 201, 202, 203, 204, 205, 206, 207]
+                - description: mt8195 pull up RSEL type define value.
+                - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000, 75000]
+                - description: mt8195 pull up RSEL type si unit value(ohm).
+              An example of using RSEL define:
+              pincontroller {
+                i2c0_pin {
+                  pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                  bias-pull-up = <MTK_PULL_SET_RSEL_001>;
+                };
+              };
+              An example of using si unit resistance value(ohm):
+              &pio {
+                mediatek,rsel_resistance_in_si_unit;
+              }
+              pincontroller {
+                i2c0_pin {
+                  pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                  bias-pull-up = <1000>;
+                };
+              };
+
+          bias-disable: true
+
+          output-high: true
+
+          output-low: true
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+        required:
+          - pinmux
 
 required:
   - compatible
@@ -201,30 +211,33 @@ additionalProperties: false
 
 examples:
   - |
-            #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
-            #include <dt-bindings/interrupt-controller/arm-gic.h>
-            pio: pinctrl@10005000 {
-                    compatible = "mediatek,mt8195-pinctrl";
-                    reg = <0x10005000 0x1000>,
-                          <0x11d10000 0x1000>,
-                          <0x11d30000 0x1000>,
-                          <0x11d40000 0x1000>,
-                          <0x11e20000 0x1000>,
-                          <0x11eb0000 0x1000>,
-                          <0x11f40000 0x1000>,
-                          <0x1000b000 0x1000>;
-                    reg-names = "iocfg0", "iocfg_bm", "iocfg_bl",
-                          "iocfg_br", "iocfg_lm", "iocfg_rb",
-                          "iocfg_tl", "eint";
-                    gpio-controller;
-                    #gpio-cells = <2>;
-                    gpio-ranges = <&pio 0 0 144>;
-                    interrupt-controller;
-                    interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH 0>;
-                    #interrupt-cells = <2>;
-
-                    pio-pins {
-                      pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
-                      output-low;
-                    };
-            };
+    #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #
+    pio: pinctrl@10005000 {
+      compatible = "mediatek,mt8195-pinctrl";
+      reg = <0x10005000 0x1000>,
+            <0x11d10000 0x1000>,
+            <0x11d30000 0x1000>,
+            <0x11d40000 0x1000>,
+            <0x11e20000 0x1000>,
+            <0x11eb0000 0x1000>,
+            <0x11f40000 0x1000>,
+            <0x1000b000 0x1000>;
+      reg-names = "iocfg0", "iocfg_bm", "iocfg_bl",
+                  "iocfg_br", "iocfg_lm", "iocfg_rb",
+                  "iocfg_tl", "eint";
+      gpio-controller;
+      #gpio-cells = <2>;
+      gpio-ranges = <&pio 0 0 144>;
+      interrupt-controller;
+      interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH 0>;
+      #interrupt-cells = <2>;
+
+      pio-pins {
+        pins_bus {
+          pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
+          output-low;
+        };
+      };
+    };
-- 
2.18.0

