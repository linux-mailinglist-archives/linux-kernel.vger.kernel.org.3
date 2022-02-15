Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546354B64C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiBOHs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:48:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbiBOHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:48:50 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AD985A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:48:34 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D40384033F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644911313;
        bh=8sh020teaLYrd9nDSk37Pr3otsotqKSg87zVukWRX9w=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MWaWuXOlpHYoV/paUqIzmZKFaSN3sdrcN3TYbiOdBe35fJ7OxJDJvlE3VI71ybbUP
         9/a5HJf8vypO70srOaEskua6MenVIlTibRsH0ckSTkkirq4hKuqUzspElWyFn1JtUu
         JUnqTPiRcOmQKDOOFoqdaQ5rNnvrOdJMpCpikkguGMmMR6u5X1mkVURobMizWwQyYp
         UuF090CrXiWIHk2A44WJABJr9LDSxSZXRP4wmJANUlQSbAu7exgO78bzEHz9CuqeSA
         V7NuMoUfK5AN3yGvpJK6Tx8nDvWLencnl8FI75XANt7WDn1h4Og2Fu7B8J5tU/bHTt
         82zl0O+x1MDbg==
Received: by mail-ej1-f70.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso1939705ejc.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8sh020teaLYrd9nDSk37Pr3otsotqKSg87zVukWRX9w=;
        b=oPDvZpRkGwn/E3aWGjVwSkeuAJZEGuk6DoZsYywfSSiWzGNMO+/gGqMhSNoCghjreU
         Z74blpN+1mRU+x1elXN4HsRbX7EfmJOMIiF6R7nrhqIYaj65pCm/1oOslZAvuB1WBeXL
         2cD/Bv+zRiIA3XBUh1VGNotGfy43TbLOwD7xvGrJQYx8k5lbAd5+u6cR7bDfxwm9ALcb
         OOIMAtUH1uanBXIQ0ndnxS6xZGnoU/NbOe+QdcxNzmGVdTkwqTEg8tNVARTUrWwslvtx
         vpE0wuPHDwFnlBnvEj6Jn88s4/ETk0l/CraeUgZVyjVzy9/Tg6gRGq7EEmzYAzofs7Br
         mrDg==
X-Gm-Message-State: AOAM531lDcW15t0I6h9g9vUIhsmXrXBItZYKA0NGLamV3cJqnH+rkVEj
        Te3njoCfvNCqpBISOb3CoAidZtxsjD1R/Qhhphwv8/bJsY/eWrsgXX6s0UCiyV1Jo/+dhZ8WoqZ
        FBr3SJfk7ka7JTN7XCYEhuGTt0GbQswgHIWpt6HJxXQ==
X-Received: by 2002:aa7:d316:: with SMTP id p22mr2649937edq.380.1644911313278;
        Mon, 14 Feb 2022 23:48:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxq0wlwyoWqJqzvOaBZwsjovEzsmN9+cJ4SW1gKdNWwJhmK0WASlOEPNpXLQlx+/oNxTv+q6g==
X-Received: by 2002:aa7:d316:: with SMTP id p22mr2649933edq.380.1644911313102;
        Mon, 14 Feb 2022 23:48:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c29sm1188357ejj.149.2022.02.14.23.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 23:48:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/3] dt-bindings: mfd: maxim,max14577: convert to dtschema
Date:   Tue, 15 Feb 2022 08:47:59 +0100
Message-Id: <20220215074759.29402-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MFD part of Maxim MAX14577/MAX77836 MUIC to DT schema
format.  The example DTS was copied from existing DTS
(exynos3250-rinato.dts), so keep the license as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
index 000000000000..27870b8760a6
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
+    $ref: /schemas/power/supply/maxim,max14577.yaml
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
+    $ref: /schemas/regulator/maxim,max14577.yaml
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
+                    regulator-name = "SAFEOUT";
+                };
+
+                CHARGER {
+                    regulator-name = "CHARGER";
+                    regulator-min-microamp = <45000>;
+                    regulator-max-microamp = <475000>;
+                    regulator-boot-on;
+                };
+
+                LDO1 {
+                    regulator-name = "MOT_2.7V";
+                    regulator-min-microvolt = <1100000>;
+                    regulator-max-microvolt = <2700000>;
+                };
+
+                LDO2 {
+                    regulator-name = "UNUSED_LDO2";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <3950000>;
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
index dbce6642e127..6783a9dc85a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11851,11 +11851,11 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

