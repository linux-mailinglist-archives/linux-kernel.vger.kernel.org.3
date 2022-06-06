Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0080E53EE00
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiFFSnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiFFSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:43:20 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1BC1A40A3;
        Mon,  6 Jun 2022 11:43:17 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id z197so8976307iof.1;
        Mon, 06 Jun 2022 11:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PpScDK9InjEA+0LXDJ1p0bncij3zNYp1MEn2KZze60=;
        b=TJA4Kzj4mPhhq7yKZO16CH4FngoxzHiuGj3USoa6nvm1Dwx3zofbn3ul2Rd+/+GETi
         WzYJQzuNAUT0010vFme/+saV1FV/XOM58IKi7nPcAakio+NRO5XQqK1eVtzsbWToIgAt
         sWscr+gutSzkClMx1093P5QDkJZ/2hzh1pywN3QgdLniQjCogaKcTsEQs9DNeJEXtbx4
         et71qCNWNfbvpEcfKsukraqXDNYsHBveCcxhfvTHpu41E2w1dwSFaH67F0iWz8gPP0J8
         wzE9eJ5QDtsSutumVs9C4cmwdskwYPh1EQWRJod4PzuLXZGbvFVSxx9eXlabavklImwx
         Yd3A==
X-Gm-Message-State: AOAM533YaFWQaL7BgS9cSjXItdeQ5ZGQuf9tlTlWoSamoiG7zzb66fMD
        yd9+bkDPtUrg5Nn59EEAMA==
X-Google-Smtp-Source: ABdhPJyhQvMgE3DYDH7FpUZJUYJ5/OzroiARX1AIg/ONPtV7oOfWFJ8c1at7jLoW/BI2shOWiqRPcA==
X-Received: by 2002:a05:6638:1608:b0:331:c83a:cc24 with SMTP id x8-20020a056638160800b00331c83acc24mr1100640jas.143.1654540997049;
        Mon, 06 Jun 2022 11:43:17 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id i12-20020a02a0cc000000b0032b3a781747sm5894939jah.11.2022.06.06.11.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:43:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Courbot <acourbot@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: Convert pwm-regulator to DT schema
Date:   Mon,  6 Jun 2022 13:43:09 -0500
Message-Id: <20220606184310.1057797-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pwm-regulator binding to DT schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/pwm-regulator.txt      |  92 -------------
 .../bindings/regulator/pwm-regulator.yaml     | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 92 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
deleted file mode 100644
index 3d78d507e29f..000000000000
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-Bindings for the Generic PWM Regulator
-======================================
-
-Currently supports 2 modes of operation:
-
-Voltage Table:		When in this mode, a voltage table (See below) of
-			predefined voltage <=> duty-cycle values must be
-			provided via DT. Limitations are that the regulator can
-			only operate at the voltages supplied in the table.
-			Intermediary duty-cycle values which would normally
-			allow finer grained voltage selection are ignored and
-			rendered useless.  Although more control is given to
-			the user if the assumptions made in continuous-voltage
-			mode do not reign true.
-
-Continuous Voltage:	This mode uses the regulator's maximum and minimum
-			supplied voltages specified in the
-			regulator-{min,max}-microvolt properties to calculate
-			appropriate duty-cycle values.  This allows for a much
-			more fine grained solution when compared with
-			voltage-table mode above.  This solution does make an
-			assumption that a %50 duty-cycle value will cause the
-			regulator voltage to run at half way between the
-			supplied max_uV and min_uV values.
-
-Required properties:
---------------------
-- compatible:		Should be "pwm-regulator"
-
-- pwms:			PWM specification (See: ../pwm/pwm.txt)
-
-Only required for Voltage Table Mode:
-- voltage-table: 	Voltage and Duty-Cycle table consisting of 2 cells
-			    First cell is voltage in microvolts (uV)
-			    Second cell is duty-cycle in percent (%)
-
-Optional properties for Continuous mode:
-- pwm-dutycycle-unit:	Integer value encoding the duty cycle unit. If not
-			defined, <100> is assumed, meaning that
-			pwm-dutycycle-range contains values expressed in
-			percent.
-
-- pwm-dutycycle-range:	Should contain 2 entries. The first entry is encoding
-			the dutycycle for regulator-min-microvolt and the
-			second one the dutycycle for regulator-max-microvolt.
-			Duty cycle values are expressed in pwm-dutycycle-unit.
-			If not defined, <0 100> is assumed.
-
-NB: To be clear, if voltage-table is provided, then the device will be used
-in Voltage Table Mode.  If no voltage-table is provided, then the device will
-be used in Continuous Voltage Mode.
-
-Optional properties:
---------------------
-- enable-gpios:		GPIO to use to enable/disable the regulator
-
-Any property defined as part of the core regulator binding can also be used.
-(See: ../regulator/regulator.txt)
-
-Continuous Voltage With Enable GPIO Example:
-	pwm_regulator {
-		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 8448 0>;
-		enable-gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
-		regulator-min-microvolt = <1016000>;
-		regulator-max-microvolt = <1114000>;
-		regulator-name = "vdd_logic";
-		/* unit == per-mille */
-		pwm-dutycycle-unit = <1000>;
-		/*
-		 * Inverted PWM logic, and the duty cycle range is limited
-		 * to 30%-70%.
-		 */
-		pwm-dutycycle-range = <700 300>; /* */
-	};
-
-Voltage Table Example:
-	pwm_regulator {
-		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 8448 0>;
-		regulator-min-microvolt = <1016000>;
-		regulator-max-microvolt = <1114000>;
-		regulator-name = "vdd_logic";
-
-			      /* Voltage Duty-Cycle */
-		voltage-table = <1114000 0>,
-				<1095000 10>,
-				<1076000 20>,
-				<1056000 30>,
-				<1036000 40>,
-				<1016000 50>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
new file mode 100644
index 000000000000..0332fec48a88
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/pwm-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for the Generic PWM Regulator
+
+maintainers:
+  - Brian Norris <briannorris@chromium.org>
+  - Lee Jones <lee.jones@linaro.org>
+  - Alexandre Courbot <acourbot@nvidia.com>
+
+description: |
+  Currently supports 2 modes of operation:
+
+  Voltage Table:
+    When in this mode, a voltage table (See below) of predefined voltage <=>
+    duty-cycle values must be provided via DT. Limitations are that the
+    regulator can only operate at the voltages supplied in the table.
+    Intermediary duty-cycle values which would normally allow finer grained
+    voltage selection are ignored and rendered useless.  Although more control
+    is given to the user if the assumptions made in continuous-voltage mode do
+    not reign true.
+
+  Continuous Voltage:
+    This mode uses the regulator's maximum and minimum supplied voltages
+    specified in the regulator-{min,max}-microvolt properties to calculate
+    appropriate duty-cycle values.  This allows for a much more fine grained
+    solution when compared with voltage-table mode above.  This solution does
+    make an assumption that a %50 duty-cycle value will cause the regulator
+    voltage to run at half way between the supplied max_uV and min_uV values.
+
+  If voltage-table is provided, then the device will be used in Voltage Table
+  Mode.  If no voltage-table is provided, then the device will be used in
+  Continuous Voltage Mode.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: pwm-regulator
+
+  pwms:
+    maxItems: 1
+
+  voltage-table:
+    description: Voltage and Duty-Cycle table.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: voltage in microvolts (uV)
+        - description: duty-cycle in percent (%)
+
+  enable-gpios:
+    description: Regulator enable GPIO
+    maxItems: 1
+
+   # Optional properties for Continuous mode:
+  pwm-dutycycle-unit:
+    description:
+      Integer value encoding the duty cycle unit. If not
+        defined, <100> is assumed, meaning that
+        pwm-dutycycle-range contains values expressed in
+        percent.
+    default: 100
+
+  pwm-dutycycle-range:
+    description:
+      Should contain 2 entries. The first entry is encoding
+        the dutycycle for regulator-min-microvolt and the
+        second one the dutycycle for regulator-max-microvolt.
+        Duty cycle values are expressed in pwm-dutycycle-unit.
+        If not defined, <0 100> is assumed.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: the dutycycle for regulator-min-microvolt
+      - description: the dutycycle for regulator-max-microvolt
+    default: [ 0 100 ]
+
+required:
+  - compatible
+  - pwms
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    // Continuous Voltage With Enable GPIO Example:
+    regulator {
+        compatible = "pwm-regulator";
+        pwms = <&pwm1 0 8448 0>;
+        enable-gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
+        regulator-min-microvolt = <1016000>;
+        regulator-max-microvolt = <1114000>;
+        regulator-name = "vdd_logic";
+        /* unit == per-mille */
+        pwm-dutycycle-unit = <1000>;
+        /*
+        * Inverted PWM logic, and the duty cycle range is limited
+        * to 30%-70%.
+        */
+        pwm-dutycycle-range = <700 300>; /* */
+    };
+
+  - |
+    // Voltage Table Example:
+    regulator {
+        compatible = "pwm-regulator";
+        pwms = <&pwm1 0 8448 0>;
+        regulator-min-microvolt = <1016000>;
+        regulator-max-microvolt = <1114000>;
+        regulator-name = "vdd_logic";
+
+                /* Voltage Duty-Cycle */
+        voltage-table = <1114000 0>,
+            <1095000 10>,
+            <1076000 20>,
+            <1056000 30>,
+            <1036000 40>,
+            <1016000 50>;
+    };
+...
-- 
2.34.1

