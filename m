Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220A3480B71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhL1Qjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:39:49 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49294
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236201AbhL1Qjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:39:43 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DBD6C3F1A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709581;
        bh=/nd1b9Jae+geOuYRS/fP3HNJ5JqXGFVL3LmeNMmkpPM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=thqg59fEzO9YJop7YhFr+9cTdo84lBUEX7sI0bTOSEQ5vrTR7eyhuPNqjwoqiSRek
         Obxwv5g7cirN9OZAGky4lKQLKD8iWK6lokb8FRMyvBPyFNf2m7Z5yaJzGhIVWzkf9L
         yX9NUyzXnqJBx69EVTxi6oTjoQwqcYI16fZhOzmJba3wFWwiTe7hv+ApaiIjtqkUG8
         HlzUhY3TuaOM75MnLkgCmdChvjP+QLdacWTJHlDvrmJAV/88RSyiNN3/FJEQGSEARq
         fu68mT9U2krrIGUGEZV2Urm9IDg3PgqR9/qgRAdQw+U2Cg0knP644pEmlcY7GCCgq+
         N7CChkyzqa4pA==
Received: by mail-lf1-f71.google.com with SMTP id g2-20020a19e042000000b00425cfac0e67so4232120lfj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nd1b9Jae+geOuYRS/fP3HNJ5JqXGFVL3LmeNMmkpPM=;
        b=nZHXFqf8IF5KJU6vJQGY1I0NEJtIdOQBzpMOz1EDAtnFaIzAmG/u/fkD6JoW3AwXcT
         g77SZY0RudaEG406oZD95dXw/xpsiGq8LY8RQLzScB/93ZoWoD6UxP7K4BVen8i93dQy
         pdlB/jM2Qi3bfFb7m0iv2wXJI63KyBYzNNDB+WoD9T4rHm9n1dy5XpjRAIFcQ+biNolk
         8Fr6Amahcr2vPnqi9ezYFFCxMEvPvmfxWtTALxskptEIbhsT/VrGjiL6BvckMtTG2L6g
         blBXS5LjNfgnQXBwTuq74/4jZpGX3oSzwxqxkZsXC96uI/S5DHS781g5PvOYu9OytKXS
         4/bA==
X-Gm-Message-State: AOAM5320cWz/4w3AGyUbhW4X5XeOrn0hVChBFxhZ+i6teCklQF8PmkcQ
        uZxE0HWFgG/0GvRu0He8CK+MUMlAggGXfSI19X7e2eTPrKyWHQ8bczVeu1RkIEDUtS+VDdxXfvb
        foXV8fubTWrXCyxJHJ8gKejG7rlVDLP+zLXYmBhpB7Q==
X-Received: by 2002:a2e:f1a:: with SMTP id 26mr19003594ljp.480.1640709581116;
        Tue, 28 Dec 2021 08:39:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwxNFto0SNwbMZEahleTnhZaXIfwwshjO3MvnBn4RSsv/mZhmGKYo00nnozjxHNwUD3q90nw==
X-Received: by 2002:a2e:f1a:: with SMTP id 26mr19003567ljp.480.1640709580801;
        Tue, 28 Dec 2021 08:39:40 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d3sm1972876lfs.204.2021.12.28.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:39:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: mfd: maxim,max77693: convert to dtschema
Date:   Tue, 28 Dec 2021 17:39:30 +0100
Message-Id: <20211228163930.35524-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MFD part of Maxim MAX77693 MUIC to DT schema format.  The
example DTS was copied from existing DTS (exynos4412-midas.dtsi), so
keep the license as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/mfd/max77693.txt      | 194 ------------------
 .../bindings/mfd/maxim,max77693.yaml          | 139 +++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 140 insertions(+), 195 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77693.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Documentation/devicetree/bindings/mfd/max77693.txt
deleted file mode 100644
index 1032df14498b..000000000000
--- a/Documentation/devicetree/bindings/mfd/max77693.txt
+++ /dev/null
@@ -1,194 +0,0 @@
-Maxim MAX77693 multi-function device
-
-MAX77693 is a Multifunction device with the following submodules:
-- PMIC,
-- CHARGER,
-- LED,
-- MUIC,
-- HAPTIC
-
-It is interfaced to host controller using i2c.
-This document describes the bindings for the mfd device.
-
-Required properties:
-- compatible : Must be "maxim,max77693".
-- reg : Specifies the i2c slave address of PMIC block.
-- interrupts : This i2c device has an IRQ line connected to the main SoC.
-
-Optional properties:
-- regulators : The regulators of max77693 have to be instantiated under subnode
-  named "regulators" using the following format.
-
-	regulators {
-		regulator-compatible = ESAFEOUT1/ESAFEOUT2/CHARGER
-		standard regulator constraints[*].
-	};
-
-	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
-
-- haptic : The MAX77693 haptic device utilises a PWM controlled motor to provide
-  users with tactile feedback. PWM period and duty-cycle are varied in
-  order to provide the appropriate level of feedback.
-
- Required properties:
-	- compatible : Must be "maxim,max77693-haptic"
-	- haptic-supply : power supply for the haptic motor
-	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
-	- pwms : phandle to the physical PWM(Pulse Width Modulation) device.
-	 PWM properties should be named "pwms". And number of cell is different
-	 for each pwm device.
-	 To get more information, please refer to documentation.
-	[*] refer Documentation/devicetree/bindings/pwm/pwm.txt
-
-- charger : Node configuring the charger driver.
-  If present, required properties:
-  - compatible : Must be "maxim,max77693-charger".
-
-  Optional properties (if not set, defaults will be used):
-  - maxim,constant-microvolt : Battery constant voltage in uV. The charger
-    will operate in fast charge constant current mode till battery voltage
-    reaches this level. Then the charger will switch to fast charge constant
-    voltage mode. Also vsys (system voltage) will be set to this value when
-    DC power is supplied but charger is not enabled.
-    Valid values: 3650000 - 4400000, step by 25000 (rounded down)
-    Default: 4200000
-
-  - maxim,min-system-microvolt : Minimal system voltage in uV.
-    Valid values: 3000000 - 3700000, step by 100000 (rounded down)
-    Default: 3600000
-
-  - maxim,thermal-regulation-celsius : Temperature in Celsius for entering
-    high temperature charging mode. If die temperature exceeds this value
-    the charging current will be reduced by 105 mA/Celsius.
-    Valid values: 70, 85, 100, 115
-    Default: 100
-
-  - maxim,battery-overcurrent-microamp : Overcurrent protection threshold
-    in uA (current from battery to system).
-    Valid values: 2000000 - 3500000, step by 250000 (rounded down)
-    Default: 3500000
-
-  - maxim,charge-input-threshold-microvolt : Threshold voltage in uV for
-    triggering input voltage regulation loop. If input voltage decreases
-    below this value, the input current will be reduced to reach the
-    threshold voltage.
-    Valid values: 4300000, 4700000, 4800000, 4900000
-    Default: 4300000
-
-- led : the LED submodule device node
-
-There are two LED outputs available - FLED1 and FLED2. Each of them can
-control a separate LED or they can be connected together to double
-the maximum current for a single connected LED. One LED is represented
-by one child node.
-
-Required properties:
-- compatible : Must be "maxim,max77693-led".
-
-Optional properties:
-- maxim,boost-mode :
-	In boost mode the device can produce up to 1.2A of total current
-	on both outputs. The maximum current on each output is reduced
-	to 625mA then. If not enabled explicitly, boost setting defaults to
-	LEDS_BOOST_FIXED in case both current sources are used.
-	Possible values:
-		LEDS_BOOST_OFF (0) - no boost,
-		LEDS_BOOST_ADAPTIVE (1) - adaptive mode,
-		LEDS_BOOST_FIXED (2) - fixed mode.
-- maxim,boost-mvout : Output voltage of the boost module in millivolts.
-	Valid values: 3300 - 5500, step by 25 (rounded down)
-	Default: 3300
-- maxim,mvsys-min : Low input voltage level in millivolts. Flash is not fired
-	if chip estimates that system voltage could drop below this level due
-	to flash power consumption.
-	Valid values: 2400 - 3400, step by 33 (rounded down)
-	Default: 2400
-
-Required properties for the LED child node:
-- led-sources : see Documentation/devicetree/bindings/leds/common.txt;
-		device current output identifiers: 0 - FLED1, 1 - FLED2
-- led-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
-	Valid values for a LED connected to one FLED output:
-		15625 - 250000, step by 15625 (rounded down)
-	Valid values for a LED connected to both FLED outputs:
-		15625 - 500000, step by 15625 (rounded down)
-- flash-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
-	Valid values for a single LED connected to one FLED output
-	(boost mode must be turned off):
-		15625 - 1000000, step by 15625 (rounded down)
-	Valid values for a single LED connected to both FLED outputs:
-		15625 - 1250000, step by 15625 (rounded down)
-	Valid values for two LEDs case:
-		15625 - 625000, step by 15625 (rounded down)
-- flash-max-timeout-us : see Documentation/devicetree/bindings/leds/common.txt
-	Valid values: 62500 - 1000000, step by 62500 (rounded down)
-
-Optional properties for the LED child node:
-- label : see Documentation/devicetree/bindings/leds/common.txt
-
-Optional nodes:
-- max77693-muic :
-	Node used only by extcon consumers.
-	Required properties:
-		- compatible : "maxim,max77693-muic"
-
-Example:
-#include <dt-bindings/leds/common.h>
-
-	max77693@66 {
-		compatible = "maxim,max77693";
-		reg = <0x66>;
-		interrupt-parent = <&gpx1>;
-		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			esafeout@1 {
-				regulator-compatible = "ESAFEOUT1";
-				regulator-name = "ESAFEOUT1";
-				regulator-boot-on;
-			};
-			esafeout@2 {
-				regulator-compatible = "ESAFEOUT2";
-				regulator-name = "ESAFEOUT2";
-				};
-			charger@0 {
-				regulator-compatible = "CHARGER";
-				regulator-name = "CHARGER";
-				regulator-min-microamp = <60000>;
-				regulator-max-microamp = <2580000>;
-					regulator-boot-on;
-			};
-		};
-
-		haptic {
-			compatible = "maxim,max77693-haptic";
-			haptic-supply = <&haptic_supply>;
-			pwms = <&pwm 0 40000 0>;
-			pwm-names = "haptic";
-		};
-
-		charger {
-			compatible = "maxim,max77693-charger";
-
-			maxim,constant-microvolt = <4200000>;
-			maxim,min-system-microvolt = <3600000>;
-			maxim,thermal-regulation-celsius = <75>;
-			maxim,battery-overcurrent-microamp = <3000000>;
-			maxim,charge-input-threshold-microvolt = <4300000>;
-		};
-
-		led {
-			compatible = "maxim,max77693-led";
-			maxim,boost-mode = <LEDS_BOOST_FIXED>;
-			maxim,boost-mvout = <5000>;
-			maxim,mvsys-min = <2400>;
-
-			camera_flash: flash-led {
-				label = "max77693-flash";
-				led-sources = <0>, <1>;
-				led-max-microamp = <500000>;
-				flash-max-microamp = <1250000>;
-				flash-max-timeout-us = <1000000>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
new file mode 100644
index 000000000000..bc9c90bd4ff9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77693.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77693 MicroUSB and Companion Power Management IC
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77693 MicroUSB
+  Integrated Circuit (MUIC).
+
+  The Maxim MAX77693 is a MicroUSB and Companion Power Management IC which
+  includes voltage current regulators, charger, LED/flash, haptic motor driver
+  and MicroUSB management IC.
+
+properties:
+  compatible:
+    const: maxim,max77693
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  charger:
+    $ref: ../power/supply/maxim,max77693.yaml
+
+  led:
+    $ref: ../leds/maxim,max77693.yaml
+
+  max77693-muic:
+    type: object
+    properties:
+      compatible:
+        const: maxim,max77693-muic
+
+    required:
+      - compatible
+
+  motor-driver:
+    type: object
+    properties:
+      compatible:
+        const: maxim,max77693-haptic
+
+      haptic-supply:
+        description: Power supply to the haptic motor
+
+      pwms:
+        maxItems: 1
+
+    required:
+      - compatible
+      - haptic-supply
+      - pwms
+
+  regulators:
+    $ref: ../regulator/maxim,max77693.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77693";
+            reg = <0x66>;
+            interrupt-parent = <&gpx1>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+
+            regulators {
+                ESAFEOUT1 {
+                    regulator-name = "ESAFEOUT1";
+                };
+
+                ESAFEOUT2 {
+                    regulator-name = "ESAFEOUT2";
+                };
+
+                CHARGER {
+                    regulator-name = "CHARGER";
+                    regulator-min-microamp = <60000>;
+                    regulator-max-microamp = <2580000>;
+                };
+            };
+
+            motor-driver {
+                compatible = "maxim,max77693-haptic";
+                haptic-supply = <&ldo26_reg>;
+                pwms = <&pwm 0 38022 0>;
+            };
+
+            charger {
+                compatible = "maxim,max77693-charger";
+
+                maxim,constant-microvolt = <4350000>;
+                maxim,min-system-microvolt = <3600000>;
+                maxim,thermal-regulation-celsius = <100>;
+                maxim,battery-overcurrent-microamp = <3500000>;
+                maxim,charge-input-threshold-microvolt = <4300000>;
+            };
+
+            led {
+                compatible = "maxim,max77693-led";
+                maxim,boost-mode = <LEDS_BOOST_FIXED>;
+                maxim,boost-mvout = <5000>;
+                maxim,mvsys-min = <2400>;
+
+                flash-led {
+                    label = "max77693-flash";
+                    function = LED_FUNCTION_FLASH;
+                    color = <LED_COLOR_ID_WHITE>;
+                    led-sources = <0>, <1>;
+                    led-max-microamp = <500000>;
+                    flash-max-microamp = <1250000>;
+                    flash-max-timeout-us = <1000000>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ead08768fb78..e5f2758531bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11692,9 +11692,9 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	Documentation/devicetree/bindings/mfd/max14577.txt
-F:	Documentation/devicetree/bindings/mfd/max77693.txt
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
 F:	drivers/*/max77693*.c
-- 
2.32.0

