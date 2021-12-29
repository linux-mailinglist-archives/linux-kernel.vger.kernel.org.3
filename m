Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321A14813FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhL2OPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:15:49 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41096
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240237AbhL2OPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:15:43 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 00D954000E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640787342;
        bh=QHqw1S0TFvvvkO/nTuql74lpAGezNX5L1cEqNCQ3zIg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=P3d9egAZwSCpfv9hncglqbU4mtrp+Pp4nhRiRCRTRi2/yZvIFCbF1QfrQ/V/IvdsN
         qUsx1TeEu6Pam1EpUsUldUrtCckI/qFOQQ7jQQ53JPKO1pDqN6INdxBu8VgpTvmwqI
         PfHgzPjc0Yicso0716FNRjjrcQAlcXiCKSvpdzdi4Go8DM2G6ChH3spWYv5guMxgGS
         3aOb63t7RnBlFh21CPWoEFsy/+JESVSmJQncdppiX0BSVFqBhBS43Fs/TbjVCwm8Gb
         +b5urMV0ezJeamEjBwD6vG8jaARcwNwOhdrzIIn6WILW8/XHs0gKxUxuLaxK8p0ej/
         8Vm0VXN8+tZaw==
Received: by mail-lj1-f197.google.com with SMTP id k20-20020a2e9214000000b0022d6b13bc8aso7295233ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 06:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHqw1S0TFvvvkO/nTuql74lpAGezNX5L1cEqNCQ3zIg=;
        b=yF9zBPvqrRMugepvQIdJIKqybYwKI0EUKNXzEm2CffiIzQ6s36JjsHheDVVx/F2byf
         SMWiHjXJGGiSxG4OmC7Qz+4M30Ohq7jBs7sEMYqYg1rGFav2K1UPIUklBQCWnSWfzAgS
         7wchSZAQOeqBKfXK89gzSaheeopndAWjm/TW9D0Wzlb9t4zqMQG9aQtcJbY4YbuH8lxU
         5MeADOSmPOtOai+PZgIrRRh5PPlaT9HUFzRgm7GWYIUaeqfl5SSL18ACm38NocgR21cC
         zLIPLvZ0Hmk5n/DDlWVWFZhGaVBeP29rV3JQtgtGXZ5HleStV3ojO0T6IWSFJUcCaX5M
         vcJw==
X-Gm-Message-State: AOAM533rA565ODp2iLAWqKZcrimDP8UifBHztsgPJphMQjOcV9D4py8J
        3YocLhczELf7a01Z1eILYwElNthhFtp0Hb0C6PraTgYWFt6jMYjYGAARYBT8kzQTdu9XeK4vKQ4
        zJyzd4DoSkusT6IDxiDf3XGCCfvtZKHTCSpc4lnZCOw==
X-Received: by 2002:a2e:8051:: with SMTP id p17mr18820311ljg.231.1640787341197;
        Wed, 29 Dec 2021 06:15:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx35P8eRibVJR1f07nmNJJ02YFr9k9trcfOSQbzXcQ1Vu81UtP7wH5W7PkJP8YQiZAhGDx55Q==
X-Received: by 2002:a2e:8051:: with SMTP id p17mr18820286ljg.231.1640787340948;
        Wed, 29 Dec 2021 06:15:40 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a16sm1316164ljm.98.2021.12.29.06.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 06:15:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: mfd: maxim,max14577: convert to dtschema
Date:   Wed, 29 Dec 2021 15:15:24 +0100
Message-Id: <20211229141524.34174-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
References: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MFD part of Maxim MAX14577/MAX77836 MUIC to DT schema
format.  The example DTS was copied from existing DTS
(exynos3250-rinato.dts), so keep the license as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/mfd/max14577.txt      | 147 -------------
 .../bindings/mfd/maxim,max14577.yaml          | 195 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 196 insertions(+), 148 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
deleted file mode 100644
index be11943a0560..000000000000
--- a/Documentation/devicetree/bindings/mfd/max14577.txt
+++ /dev/null
@@ -1,147 +0,0 @@
-Maxim MAX14577/77836 Multi-Function Device
-
-MAX14577 is a Multi-Function Device with Micro-USB Interface Circuit, Li+
-Battery Charger and SFOUT LDO output for powering USB devices. It is
-interfaced to host controller using I2C.
-
-MAX77836 additionally contains PMIC (with two LDO regulators) and Fuel Gauge.
-For the description of Fuel Gauge low SOC alert interrupt see:
-../power/supply/max17040_battery.txt
-
-
-Required properties:
-- compatible : Must be "maxim,max14577" or "maxim,max77836".
-- reg : I2C slave address for the max14577 chip (0x25 for max14577/max77836)
-- interrupts : IRQ line for the chip.
-
-
-Required nodes:
- - charger :
-	Node for configuring the charger driver.
-	Required properties:
-		- compatible : "maxim,max14577-charger"
-			or "maxim,max77836-charger"
-		- maxim,fast-charge-uamp : Current in uA for Fast Charge;
-			Valid values:
-			- for max14577: 90000 - 950000;
-			- for max77836: 45000 - 475000;
-		- maxim,eoc-uamp : Current in uA for End-Of-Charge mode;
-			Valid values:
-			- for max14577: 50000 - 200000;
-			- for max77836: 5000 - 100000;
-		- maxim,ovp-uvolt : OverVoltage Protection Threshold in uV;
-			In an overvoltage condition, INT asserts and charging
-			stops. Valid values:
-			- 6000000, 6500000, 7000000, 7500000;
-		- maxim,constant-uvolt : Battery Constant Voltage in uV;
-			Valid values:
-			- 4000000 - 4280000 (step by 20000);
-			- 4350000;
-
-
-Optional nodes:
-- max14577-muic/max77836-muic :
-	Node used only by extcon consumers.
-	Required properties:
-		- compatible : "maxim,max14577-muic" or "maxim,max77836-muic"
-
-- regulators :
-	Required properties:
-		- compatible : "maxim,max14577-regulator"
-			or "maxim,max77836-regulator"
-
-	May contain a sub-node per regulator from the list below. Each
-	sub-node should contain the constraints and initialization information
-	for that regulator. See regulator.txt for a description of standard
-	properties for these sub-nodes.
-
-	List of valid regulator names:
-	- for max14577: CHARGER, SAFEOUT.
-	- for max77836: CHARGER, SAFEOUT, LDO1, LDO2.
-
-	The SAFEOUT is a fixed voltage regulator so there is no need to specify
-	voltages for it.
-
-
-Example:
-
-#include <dt-bindings/interrupt-controller/irq.h>
-
-max14577@25 {
-	compatible = "maxim,max14577";
-	reg = <0x25>;
-	interrupt-parent = <&gpx1>;
-	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
-
-	muic: max14577-muic {
-		compatible = "maxim,max14577-muic";
-	};
-
-	regulators {
-		compatible = "maxim,max14577-regulator";
-
-		SAFEOUT {
-			regulator-name = "SAFEOUT";
-		};
-		CHARGER {
-			regulator-name = "CHARGER";
-			regulator-min-microamp = <90000>;
-			regulator-max-microamp = <950000>;
-			regulator-boot-on;
-		};
-	};
-
-	charger {
-		compatible = "maxim,max14577-charger";
-
-		maxim,constant-uvolt = <4350000>;
-		maxim,fast-charge-uamp = <450000>;
-		maxim,eoc-uamp = <50000>;
-		maxim,ovp-uvolt = <6500000>;
-	};
-};
-
-
-max77836@25 {
-	compatible = "maxim,max77836";
-	reg = <0x25>;
-	interrupt-parent = <&gpx1>;
-	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
-
-	muic: max77836-muic {
-		compatible = "maxim,max77836-muic";
-	};
-
-	regulators {
-		compatible = "maxim,max77836-regulator";
-
-		SAFEOUT {
-			regulator-name = "SAFEOUT";
-		};
-		CHARGER {
-			regulator-name = "CHARGER";
-			regulator-min-microamp = <90000>;
-			regulator-max-microamp = <950000>;
-			regulator-boot-on;
-		};
-		LDO1 {
-			regulator-name = "LDO1";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-		};
-		LDO2 {
-			regulator-name = "LDO2";
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <3950000>;
-		};
-	};
-
-	charger {
-		compatible = "maxim,max77836-charger";
-
-		maxim,constant-uvolt = <4350000>;
-		maxim,fast-charge-uamp = <225000>;
-		maxim,eoc-uamp = <7500>;
-		maxim,ovp-uvolt = <6500000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml b/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
new file mode 100644
index 000000000000..512fd671595c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
@@ -0,0 +1,195 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max14577.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX14577/MAX77836 MicroUSB and Companion Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX14577/MAX77836 MicroUSB
+  Integrated Circuit (MUIC).
+
+  The Maxim MAX14577 is a MicroUSB and Companion Power Management IC which
+  includes voltage safeout regulators, charger and MicroUSB management IC.
+
+  The Maxim MAX77836 is a MicroUSB and Companion Power Management IC which
+  includes voltage safeout and LDO regulators, charger, fuel-gauge and MicroUSB
+  management IC.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max14577
+      - maxim,max77836
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  charger:
+    $ref: ../power/supply/maxim,max14577.yaml
+
+  extcon:
+    type: object
+    properties:
+      compatible:
+        enum:
+          - maxim,max14577-muic
+          - maxim,max77836-muic
+
+    required:
+      - compatible
+
+  regulators:
+    $ref: ../regulator/maxim,max14577.yaml
+
+required:
+  - compatible
+  - interrupts
+  - reg
+  - charger
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max14577
+    then:
+      properties:
+        charger:
+          properties:
+            compatible:
+              const: maxim,max14577-charger
+        extcon:
+          properties:
+            compatible:
+              const: maxim,max14577-muic
+        regulator:
+          properties:
+            compatible:
+              const: maxim,max14577-regulator
+    else:
+      properties:
+        charger:
+          properties:
+            compatible:
+              const: maxim,max77836-charger
+        extcon:
+          properties:
+            compatible:
+              const: maxim,max77836-muic
+        regulator:
+          properties:
+            compatible:
+              const: maxim,max77836-regulator
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@25 {
+            compatible = "maxim,max14577";
+            reg = <0x25>;
+            interrupt-parent = <&gpx1>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+
+            extcon {
+                compatible = "maxim,max14577-muic";
+            };
+
+            regulators {
+                compatible = "maxim,max14577-regulator";
+
+                SAFEOUT {
+                    regulator-name = "SAFEOUT";
+                };
+
+                CHARGER {
+                    regulator-name = "CHARGER";
+                    regulator-min-microamp = <90000>;
+                    regulator-max-microamp = <950000>;
+                    regulator-boot-on;
+                };
+            };
+
+            charger {
+                compatible = "maxim,max14577-charger";
+
+                maxim,constant-uvolt = <4350000>;
+                maxim,fast-charge-uamp = <450000>;
+                maxim,eoc-uamp = <50000>;
+                maxim,ovp-uvolt = <6500000>;
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@25 {
+            compatible = "maxim,max77836";
+            interrupt-parent = <&gpx1>;
+            interrupts = <5 IRQ_TYPE_NONE>;
+            reg = <0x25>;
+            wakeup-source;
+
+            extcon {
+                compatible = "maxim,max77836-muic";
+            };
+
+            regulators {
+                compatible = "maxim,max77836-regulator";
+
+                SAFEOUT {
+                  regulator-name = "SAFEOUT";
+                };
+
+                CHARGER {
+                  regulator-name = "CHARGER";
+                  regulator-min-microamp = <45000>;
+                  regulator-max-microamp = <475000>;
+                  regulator-boot-on;
+                };
+
+                LDO1 {
+                  regulator-name = "MOT_2.7V";
+                  regulator-min-microvolt = <1100000>;
+                  regulator-max-microvolt = <2700000>;
+                };
+
+                LDO2 {
+                  regulator-name = "UNUSED_LDO2";
+                  regulator-min-microvolt = <800000>;
+                  regulator-max-microvolt = <3950000>;
+                };
+            };
+
+            charger {
+                compatible = "maxim,max77836-charger";
+
+                maxim,constant-uvolt = <4350000>;
+                maxim,fast-charge-uamp = <225000>;
+                maxim,eoc-uamp = <7500>;
+                maxim,ovp-uvolt = <6500000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 13e21c229c5d..af392bd04874 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11692,11 +11692,11 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
-F:	Documentation/devicetree/bindings/mfd/max14577.txt
 F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
-- 
2.32.0

