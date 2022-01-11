Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA648B4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbiAKRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:55:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33264
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344967AbiAKRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:55:12 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 24DCC40047
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923711;
        bh=00nwAyyKUb1y1BKsakD4Pry2fh6sP1JvtjwifpIg4ik=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=l0V0PkkQf0NjI7ZoJLZqiHGxOuFXBkJE/A+9R536bi3h5PSB07mhmTn1hsSWhsvLz
         IV1RYNIOCIQWudatSJX39ucznKX2yG6unXeHGSjOsETzd1BH7pUnOI5G827Hil9otx
         gyTQGrsE0tBwhjNs8/0E5QV9IMoXEtf2CwDIHAdAqZyR/MCNJFU1Qg8q4MgatVzroP
         bu9mk+hAtELhWW+ykqI4df+liqjLBj6YAJcsCLDdlyr1uX4R7wmdS3NdudubZywpBo
         s2Qwg4Gz274aeEEVOxDIQD6EKltXIC9jB8mFaIWfLiPh0HCjHAARck6+tuAHgLiUdB
         Dogqx/L+cX9eQ==
Received: by mail-ed1-f71.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so13992613edd.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00nwAyyKUb1y1BKsakD4Pry2fh6sP1JvtjwifpIg4ik=;
        b=hAH63s1mfF80GrpuV3o7qUxNWC4AZLcMWTUrhy4as6uFtIHcUjGnNE20EDB+81YX22
         F7Oq7sQKqg3XD9aZl3X59M2k5saJCq0P4Gou74h6ewzUYV7gFI8KMH8iLamk156Ef64z
         O9JmMx0IrD2wL4UiX9AWpi9ISrgx0tn2XA2eqtxAvaUtlvpI2nch5qbY0gdC709gf9+j
         jF33FM8WoeAE+QHikhPeQCRW4DGX3aQU9kcDo17acgO6mvrtu6VktYoCycZaMJXwPNj3
         X7OvsUFzg8I/3MXesEmiA6VCDUlvKqyhENxNQEhgCLMj9lGeh79uNOxbWKpMgfPOFZ7j
         3BMg==
X-Gm-Message-State: AOAM531/FLIUFkjOPurV+IFiwjngDCBSUECrbhD4c482aJwwRGqnFd3H
        h8ZLCOClUDprDFUPCLTA85Gj2bb4sts31dE9sFuJ1oOhtS5SgKyzjtR0wQZOeJSK2OB82636/Rl
        fryQP8bpO++vg+8DmnJKHZt6EeThdkqE6d3aYluSmxg==
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr5155568edc.228.1641923709774;
        Tue, 11 Jan 2022 09:55:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6iz+h/3L17VQaGmv4x06QQw3Odv8DjLRkuLfTCsHFYjFDxCI19Lcubysme4JBSoX9Cc62WA==
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr5155542edc.228.1641923709492;
        Tue, 11 Jan 2022 09:55:09 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 7sm3759949ejh.161.2022.01.11.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:55:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] regulator: dt-bindings: maxim,max77802: convert to dtschema
Date:   Tue, 11 Jan 2022 18:54:28 +0100
Message-Id: <20220111175430.224421-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regulators of Maxim MAX77802 PMIC to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/max77802.txt           | 111 ------------------
 .../bindings/regulator/maxim,max77802.yaml    |  97 +++++++++++++++
 2 files changed, 97 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max77802.txt b/Documentation/devicetree/bindings/regulator/max77802.txt
deleted file mode 100644
index b82943d83677..000000000000
--- a/Documentation/devicetree/bindings/regulator/max77802.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-Binding for Maxim MAX77802 regulators
-
-This is a part of device tree bindings of MAX77802 multi-function device.
-More information can be found in bindings/mfd/max77802.txt file.
-
-The MAX77802 PMIC has 10 high-efficiency Buck and 32 Low-dropout (LDO)
-regulators that can be controlled over I2C.
-
-Following properties should be present in main device node of the MFD chip.
-
-Optional properties:
-- inb1-supply:  The input supply for BUCK1
-- inb2-supply:  The input supply for BUCK2
-- inb3-supply:  The input supply for BUCK3
-- inb4-supply:  The input supply for BUCK4
-- inb5-supply:  The input supply for BUCK5
-- inb6-supply:  The input supply for BUCK6
-- inb7-supply:  The input supply for BUCK7
-- inb8-supply:  The input supply for BUCK8
-- inb9-supply:  The input supply for BUCK9
-- inb10-supply: The input supply for BUCK10
-- inl1-supply:  The input supply for LDO8 and LDO15
-- inl2-supply:  The input supply for LDO17, LDO27, LDO30 and LDO35
-- inl3-supply:  The input supply for LDO3, LDO5, LDO6 and LDO7
-- inl4-supply:  The input supply for LDO10, LDO11, LDO13 and LDO14
-- inl5-supply:  The input supply for LDO9 and LDO19
-- inl6-supply:  The input supply for LDO4, LDO21, LDO24 and LDO33
-- inl7-supply:  The input supply for LDO18, LDO20, LDO28 and LDO29
-- inl9-supply:  The input supply for LDO12, LDO23, LDO25, LDO26, LDO32 and LDO34
-- inl10-supply: The input supply for LDO1 and LDO2
-
-Optional nodes:
-- regulators : The regulators of max77802 have to be instantiated
-  under subnode named "regulators" using the following format.
-
-	regulator-name {
-		standard regulator constraints....
-	};
-	refer Documentation/devicetree/bindings/regulator/regulator.txt
-
-The regulator node name should be initialized with a string to get matched
-with their hardware counterparts as follow. The valid names are:
-
-	-LDOn 	:	for LDOs, where n can lie in ranges 1-15, 17-21, 23-30
-			and 32-35.
-			example: LDO1, LDO2, LDO35.
-	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 10.
-			example: BUCK1, BUCK5, BUCK10.
-
-The max77802 regulator supports two different operating modes: Normal and Low
-Power Mode. Some regulators support the modes to be changed at startup or by
-the consumers during normal operation while others only support to change the
-mode during system suspend. The standard regulator suspend states binding can
-be used to configure the regulator operating mode.
-
-The regulators that support the standard "regulator-initial-mode" property,
-changing their mode during normal operation are: LDOs 1, 3, 20 and 21.
-
-The possible values for "regulator-initial-mode" and "regulator-mode" are:
-	1: Normal regulator voltage output mode.
-	3: Low Power which reduces the quiescent current down to only 1uA
-
-The valid modes list is defined in the dt-bindings/regulator/maxim,max77802.h
-header and can be included by device tree source files.
-
-The standard "regulator-mode" property can only be used for regulators that
-support changing their mode to Low Power Mode during suspend. These regulators
-are: BUCKs 2-4 and LDOs 1-35. Also, it only takes effect if the regulator has
-been enabled for the given suspend state using "regulator-on-in-suspend" and
-has not been disabled for that state using "regulator-off-in-suspend".
-
-Example:
-
-	max77802@9 {
-		compatible = "maxim,max77802";
-		interrupt-parent = <&wakeup_eint>;
-		interrupts = <26 0>;
-		reg = <0x09>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		inb1-supply = <&parent_reg>;
-
-		regulators {
-			ldo1_reg: LDO1 {
-				regulator-name = "vdd_1v0";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-initial-mode = <MAX77802_OPMODE_LP>;
-			};
-
-			ldo11_reg: LDO11 {
-				regulator-name = "vdd_ldo11";
-				regulator-min-microvolt = <1900000>;
-				regulator-max-microvolt = <1900000>;
-				regulator-always-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-mode = <MAX77802_OPMODE_LP>;
-				};
-			};
-
-			buck1_reg: BUCK1 {
-				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
new file mode 100644
index 000000000000..a40c93259a13
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77802.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77802 Power Management IC regulators
+
+maintainers:
+  - Javier Martinez Canillas <javier@dowhile0.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77802 Power Management
+  Integrated Circuit (PMIC).
+
+  The Maxim MAX77686 provides 10 high-efficiency Buck and 32 Low-DropOut (LDO)
+  regulators.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77802.yaml for
+  additional information and example.
+
+  Certain regulators support "regulator-initial-mode" and "regulator-mode".
+  The valid modes list is defined in the dt-bindings/regulator/maxim,max77802.h
+  and their meaning is:
+    1 - Normal regulator voltage output mode.
+    3 - Low Power which reduces the quiescent current down to only 1uA
+
+  The standard "regulator-mode" property can only be used for regulators that
+  support changing their mode to Low Power Mode during suspend. These
+  regulators are: bucks 2-4 and LDOs 1-35. Also, it only takes effect if the
+  regulator has been enabled for the given suspend state using
+  "regulator-on-in-suspend" and has not been disabled for that state using
+  "regulator-off-in-suspend".
+
+patternProperties:
+  # LDO1, LDO3, LDO20, LDO21
+  "^LDO([13]|2[01])$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      LDOs supporting the regulator-initial-mode property and changing their
+      mode during normal operation.
+
+    required:
+      - regulator-name
+
+  # LDO2, LDO4-15, LDO17-19, LDO23-30, LDO32-35
+  "^LDO([24-9]|1[0-5789]|2[3-9]|3[02345])$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      LDOs supporting the regulator-mode property (changing mode to Low Power
+      Mode during suspend).
+
+    properties:
+      regulator-initial-mode: false
+
+    required:
+      - regulator-name
+
+  # buck2-4
+  "^BUCK[2-4]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      bucks supporting the regulator-mode property (changing mode to Low Power
+      Mode during suspend).
+
+    properties:
+      regulator-initial-mode: false
+
+    required:
+      - regulator-name
+
+  # buck1, buck5-10
+  "^BUCK([15-9]|10)$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      regulator-initial-mode: false
+
+    patternProperties:
+      regulator-state-(standby|mem|disk):
+        type: object
+        properties:
+          regulator-mode: false
+
+    required:
+      - regulator-name
+
+additionalProperties: false
-- 
2.32.0

