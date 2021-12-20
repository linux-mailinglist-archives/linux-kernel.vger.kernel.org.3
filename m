Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7D47A963
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhLTMSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:18:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56984 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232443AbhLTMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:18:45 -0500
X-UUID: f32c6f6f6d8347a98e6a9a9fa020654a-20211220
X-UUID: f32c6f6f6d8347a98e6a9a9fa020654a-20211220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1539896202; Mon, 20 Dec 2021 20:18:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 20 Dec 2021 20:18:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Dec 2021 20:18:37 +0800
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
Subject: [PATCH v7 3/4] dt-bindings: pinctrl: mt8195: add wrapping node of pin configurations
Date:   Mon, 20 Dec 2021 20:18:24 +0800
Message-ID: <20211220121825.6446-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20211220121825.6446-1-tinghan.shen@mediatek.com>
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mt8195, the pinctrl node has pinctrl groups to group pin
configurations by users' need. In each pinctrl group, it has
subnode(s) to list pins needed and pin configurations. By supporting
multiple subnodes, we can configure different pin characteristics
(driving/pull-up/pull-down/etc.) in a pinctrl group.

Update pinctrl-mt8195.yaml to add subnode in pinctrl groups and an
example to illustrate the usage.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../bindings/pinctrl/pinctrl-mt8195.yaml      | 338 ++++++++++--------
 1 file changed, 188 insertions(+), 150 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 5e2bb2bf3a55..567f71cab7b4 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -55,137 +55,159 @@ properties:
       Identifying i2c pins pull up/down type which is RSEL. It can support
       RSEL define or si unit value(ohm) to set different resistance.
 
-#PIN CONFIGURATION NODES
+# PIN CONFIGURATION NODES
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
+      '^pins':
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
+            gpio-pins {
+              pins {
+                pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
+              }
             };
-          };
-          An example of using si unit resistance value(ohm):
-          &pio {
-            mediatek,rsel_resistance_in_si_unit;
-          }
-          pincontroller {
-            i2c0_pin {
-              pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
-              bias-pull-up = <1000>;
+            /* GPIO8 set as multifunction SDA0 */
+            i2c0-pins {
+              pins {
+                pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+              }
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
+                  pins {
+                    pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                    bias-pull-down = <MTK_PULL_SET_RSEL_001>;
+                  }
+                };
+              };
+              An example of using si unit resistance value(ohm):
+              &pio {
+                mediatek,rsel_resistance_in_si_unit;
+              }
+              pincontroller {
+                i2c0_pin {
+                  pins {
+                    pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                    bias-pull-down = <75000>;
+                  }
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
+                i2c0-pins {
+                  pins {
+                    pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                    bias-pull-up = <MTK_PULL_SET_RSEL_001>;
+                  }
+                };
+              };
+              An example of using si unit resistance value(ohm):
+              &pio {
+                mediatek,rsel_resistance_in_si_unit;
+              }
+              pincontroller {
+                i2c0-pins {
+                  pins {
+                    pinmux = <PINMUX_GPIO8__FUNC_SDA0>;
+                    bias-pull-up = <1000>;
+                  }
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
@@ -201,30 +223,46 @@ additionalProperties: false
 
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
+        pins {
+          pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
+          output-low;
+        };
+      };
+
+      spi0-pins {
+        pins-spi {
+          pinmux = <PINMUX_GPIO132__FUNC_SPIM0_CSB>,
+                   <PINMUX_GPIO134__FUNC_SPIM0_MO>,
+                   <PINMUX_GPIO133__FUNC_SPIM0_CLK>;
+          bias-disable;
+        };
+        pins-spi-mi {
+          pinmux = <PINMUX_GPIO135__FUNC_SPIM0_MI>;
+          bias-pull-down;
+        };
+      };
+    };
-- 
2.18.0

