Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06EF57DFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiGVKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiGVKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:25:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFCD9EC75;
        Fri, 22 Jul 2022 03:25:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f11so4214542plr.4;
        Fri, 22 Jul 2022 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XoP7u+DSv5yXz+NKLqpdZlrDfnRAwiLZBsnunnwVC0=;
        b=GkgumqFiUIgk32nRFuZH5Yjlzv/lpSc3krRe+hZp+R/ufq/iOSDr+Lh7w7Z8LUaYeD
         7mOb35Re5JTLdJmePGKtn+7FXYc/g7dNCM6sDjj5bBo0MsxdZtDsIeLps4HevFhRfTY1
         jGUR7gSVViK44Gw0qXmtwowrxCrv4JCIxeVkY3yxC+C4/x7GRZ7V+FiahYi6Iojie7K9
         CSyLe96RLc+Qf2VRh7jHQANzWykJS2otPmO6OfA3qK98bDpd5mGxtdQS+Ag8QOy+FHRk
         5pIHLaDKa0uMXnJiuMrgBRhs1pnhNxEaleAqOCjrTOn9coI9kntarSCzmpW0qmtgoRkj
         PRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XoP7u+DSv5yXz+NKLqpdZlrDfnRAwiLZBsnunnwVC0=;
        b=ZeeGH1TO4SC42bZps9n9qlbAe5c/33e6p5KRebk26eVhxUwdwGfVixvErWscv8GH8G
         tMAfe95c5rs15mGNfZzSpwm48s8d/qU4JP+l85AQWH2dNL3a4s2xuMTeNzJpK4IGOkbd
         S/ZS3TDBzQry2nPVwkEPKJ1jJB5DtAit//cmNvsYUwLRn5bi0AMJzCD9RN7Lwl9xR68W
         G0aOWbS/tTy81RrQf36l8CM9cG18XsbJBb+RajjD61IyfQEaMQl59Asa8dSva8MsMAQB
         NYSRmJu+bWiww93zRG+vy3rtKuqHMlNhVGK5ILgvS9cT/wc6WkJNDS0RUqKFD/DGmK6J
         4QKA==
X-Gm-Message-State: AJIora8EFLhucHk6W6tSt6sF10hnw4nhp4fD5hJJZdmmIX/yNrwNwVbw
        F2SZn5HPw+IdsDERholVCYoeA7DtC2Y=
X-Google-Smtp-Source: AGRyM1vgF4o4g47hZSNCz6XWYo4hl71p6IxKBTxToBFd2MkMDkud3EB0aw6WSC28Jw1HqqyyJM+x0w==
X-Received: by 2002:a17:902:d50a:b0:16c:5490:163c with SMTP id b10-20020a170902d50a00b0016c5490163cmr2705445plg.31.1658485500195;
        Fri, 22 Jul 2022 03:25:00 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-82-239.emome-ip.hinet.net. [42.73.82.239])
        by smtp.gmail.com with ESMTPSA id h189-20020a6283c6000000b00528d620eb58sm3614551pfe.17.2022.07.22.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 03:24:59 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 06/13] dt-bindings: mfd: Add MediaTek MT6370
Date:   Fri, 22 Jul 2022 18:24:00 +0800
Message-Id: <20220722102407.2205-7-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722102407.2205-1-peterwu.pub@gmail.com>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add MediaTek MT6370 binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/mediatek,mt6370.yaml   | 280 +++++++++++++++++++++
 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |  18 ++
 2 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
new file mode 100644
index 0000000..410e2d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
@@ -0,0 +1,280 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mediatek,mt6370.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6370 SubPMIC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  MT6370 is a highly-integrated smart power management IC, which includes a
+  single cell Li-Ion/Li-Polymer switching battery charger, a USB Type-C &
+  Power Delivery (PD) controller, dual flash LED current sources, a RGB LED
+  driver, a backlight WLED driver, a display bias driver and a general LDO for
+  portable devices.
+
+properties:
+  compatible:
+    const: mediatek,mt6370
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  adc:
+    type: object
+    description: |
+      Provides 9 channels for system monitoring, including VBUSDIV5 (lower
+      accuracy, higher measure range), VBUSDIV2 (higher accuracy, lower
+      measure range), VBAT, VSYS, CHG_VDDP, TS_BAT, IBUS, IBAT, and TEMP_JC.
+
+    properties:
+      compatible:
+        const: mediatek,mt6370-adc
+
+      "#io-channel-cells":
+        const: 1
+
+    required:
+      - compatible
+      - "#io-channel-cells"
+
+  backlight:
+    type: object
+    $ref: /schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
+
+  charger:
+    type: object
+    $ref: /schemas/power/supply/mediatek,mt6370-charger.yaml#
+
+  tcpc:
+    type: object
+    $ref: /schemas/usb/mediatek,mt6370-tcpc.yaml#
+
+  indicator:
+    type: object
+    $ref: /schemas/leds/mediatek,mt6370-indicator.yaml#
+
+  flashlight:
+    type: object
+    $ref: /schemas/leds/mediatek,mt6370-flashlight.yaml#
+
+  regulators:
+    type: object
+    description: |
+      List all supported regulators, which support the control for DisplayBias
+      voltages and one general purpose LDO which commonly used to drive the
+      vibrator.
+
+    patternProperties:
+      "^(dsvbst|vibldo)$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+      "^(dsvpos|dsvneg)$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+        properties:
+          enable-gpios:
+            maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - regulators
+  - adc
+  - backlight
+  - indicator
+  - tcpc
+  - charger
+  - flashlight
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+        pmic@34 {
+        compatible = "mediatek,mt6370";
+        reg = <0x34>;
+        wakeup-source;
+        interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        mt6370_adc: adc {
+          compatible = "mediatek,mt6370-adc";
+          #io-channel-cells = <1>;
+        };
+
+        backlight {
+          compatible = "mediatek,mt6370-backlight";
+          mediatek,bled-channel-use = /bits/ 8 <15>;
+        };
+
+        charger {
+          compatible = "mediatek,mt6370-charger";
+          interrupts = <48>, <68>, <6>;
+          interrupt-names = "attach_i", "uvp_d_evt", "mivr";
+          io-channels = <&mt6370_adc MT6370_CHAN_IBUS>;
+
+          mt6370_otg_vbus: usb-otg-vbus-regulator {
+            regulator-name = "mt6370-usb-otg-vbus";
+            regulator-min-microvolt = <4350000>;
+            regulator-max-microvolt = <5800000>;
+            regulator-min-microamp = <500000>;
+            regulator-max-microamp = <3000000>;
+          };
+        };
+
+        indicator {
+          compatible = "mediatek,mt6370-indicator";
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          multi-led@0 {
+            reg = <0>;
+            function = LED_FUNCTION_INDICATOR;
+            color = <LED_COLOR_ID_RGB>;
+            led-max-microamp = <24000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            led@0 {
+              reg = <0>;
+              color = <LED_COLOR_ID_RED>;
+            };
+            led@1 {
+              reg = <1>;
+              color = <LED_COLOR_ID_GREEN>;
+            };
+            led@2 {
+              reg = <2>;
+              color = <LED_COLOR_ID_BLUE>;
+            };
+          };
+          led@3 {
+            reg = <3>;
+            function = LED_FUNCTION_INDICATOR;
+            color = <LED_COLOR_ID_WHITE>;
+            led-max-microamp = <6000>;
+          };
+        };
+
+        flashlight {
+          compatible = "mediatek,mt6370-flashlight";
+          #address-cells = <1>;
+          #size-cells = <0>;
+          led@0 {
+            reg = <0>;
+            led-sources = <0>;
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            function-enumerator = <1>;
+            led-max-microamp = <200000>;
+            flash-max-microamp = <500000>;
+            flash-max-timeout-us = <1248000>;
+          };
+          led@1 {
+            reg = <1>;
+            led-sources = <1>;
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            function-enumerator = <2>;
+            led-max-microamp = <200000>;
+            flash-max-microamp = <500000>;
+            flash-max-timeout-us = <1248000>;
+          };
+        };
+
+        tcpc {
+          compatible = "mediatek,mt6370-tcpc";
+          interrupts-extended = <&gpio26 4 IRQ_TYPE_LEVEL_LOW>;
+
+          connector {
+            compatible = "usb-c-connector";
+            label = "USB-C";
+            vbus-supply = <&mt6370_otg_vbus>;
+            data-role = "dual";
+            power-role = "dual";
+            try-power-role = "sink";
+            source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            op-sink-microwatt = <10000000>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                reg = <0>;
+                endpoint {
+                  remote-endpoint = <&usb_hs>;
+                };
+              };
+              port@1 {
+                reg = <1>;
+                endpoint {
+                  remote-endpoint = <&usb_ss>;
+                };
+              };
+              port@2 {
+                reg = <2>;
+                endpoint {
+                  remote-endpoint = <&dp_aux>;
+                };
+              };
+            };
+          };
+        };
+
+        regulators {
+          dsvbst {
+            regulator-name = "mt6370-dsv-vbst";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6200000>;
+          };
+          dsvpos {
+            regulator-name = "mt6370-dsv-vpos";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6000000>;
+            regulator-boot-on;
+          };
+          dsvneg {
+            regulator-name = "mt6370-dsv-vneg";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6000000>;
+            regulator-boot-on;
+          };
+          vibldo {
+            regulator-name = "mt6370-vib-ldo";
+            regulator-min-microvolt = <1600000>;
+            regulator-max-microvolt = <4000000>;
+          };
+        };
+      };
+    };
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6370_adc.h b/include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
new file mode 100644
index 0000000..6ee7255
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef __DT_BINDINGS_MEDIATEK_MT6370_ADC_H__
+#define __DT_BINDINGS_MEDIATEK_MT6370_ADC_H__
+
+/* ADC Channel Index */
+#define MT6370_CHAN_VBUSDIV5	0
+#define MT6370_CHAN_VBUSDIV2	1
+#define MT6370_CHAN_VSYS	2
+#define MT6370_CHAN_VBAT	3
+#define MT6370_CHAN_TS_BAT	4
+#define MT6370_CHAN_IBUS	5
+#define MT6370_CHAN_IBAT	6
+#define MT6370_CHAN_CHG_VDDP	7
+#define MT6370_CHAN_TEMP_JC	8
+#define MT6370_CHAN_MAX		9
+
+#endif
-- 
2.7.4

