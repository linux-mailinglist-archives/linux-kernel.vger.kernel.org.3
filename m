Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC22B4B64CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiBOHyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:54:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiBOHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:53:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC84BF52C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:53:49 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C88823F1CA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644911628;
        bh=XacKxQlnhLB/tFHLL/W/7DTa1Jm3YdVqOa9RNHplNoI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=OlpkbuOf8AOFYDH97K47eff+ZjmqBt3A9WCE50LKhcSVrVhacvTpJnbqzq9mL5Gv8
         j5zTO1QWk+QLlx2I4/azzq0KY1g7Ty1jd/v1JbO67m/JJA48xqCbLvmOUz6HqI2jvg
         /lTPYHlzj++wcD8qHn1GMq/Yk98ow0hju3LHz4HGtOKh5GBHHOA2GhKVznvTJ/zsMD
         BmHKP+3u5+pmvNowBvKN8yjNp6iyL5s/U3hcVFXmPN0Ys598v86xid5KZFc93C4Sjg
         sWNoKV/PPu4uKhnDZSFkUtjs9kZQd8OHAfOTnAJW7qclWM0eiCO8tyQOQ57xZgVIhr
         2AsN5V88aRUNQ==
Received: by mail-ed1-f69.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso11892419edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XacKxQlnhLB/tFHLL/W/7DTa1Jm3YdVqOa9RNHplNoI=;
        b=klPq7+nuZ/BRsQY83ptKTk0J4i/3cILGVhNarywBba/gUgB7sRQTYUVCXyuVTc4D1x
         9FK2o3fMV9fCUS2SpvsEPXQLOZjnTMiIFfF8fR+w1PAyRyTeib9/PWB2L92VJYF4gsSL
         2voGlbnebF/H9rON1Cya7cf9ibVBZ6TEw05kLARay8lQtNBhraV4b/hReGdlS421oi4f
         rEv8AQBTL65FKAxinix8/FyBfFSpgpxPro7pzX9+2HVUBU/uo1WxTABkGNULWyC98bMU
         iaMgIwOc9NubTCRDzYOKY4DZHWlAUCD8UhsfdB3Yc7aBm2TEcWvYf8OXhfCz8/lvA/6s
         pTww==
X-Gm-Message-State: AOAM533TugUXVkX7o2IYHRop3sfdNN1MXGWS0gd4MlhUIUl6huAI0o0o
        tg6zY9TYOvSJg56V//mwKyJapIODvfWCLQbeU9DKIx0vKKNg/E0oAUQ/OitLMhVGJmYGpoQJMWx
        ArgB8kbw/0t+EIyHylPp4JKHKUqOCV3dlzOPWmtE7AA==
X-Received: by 2002:a05:6402:424a:: with SMTP id g10mr2592193edb.309.1644911628322;
        Mon, 14 Feb 2022 23:53:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVxj0K1eWTx4Tc9HX521PDPmxuQGRc7ltC1jyf9OP+BzIyMMiW9xPIlrvgthlUYPLXnBOi3A==
X-Received: by 2002:a05:6402:424a:: with SMTP id g10mr2592177edb.309.1644911628112;
        Mon, 14 Feb 2022 23:53:48 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h11sm4663713edb.68.2022.02.14.23.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 23:53:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 1/2] regulator: dt-bindings: maxim,max77802: convert to dtschema
Date:   Tue, 15 Feb 2022 08:53:43 +0100
Message-Id: <20220215075344.31421-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
References: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
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

Convert the regulators of Maxim MAX77802 PMIC to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/max77802.txt           | 111 ------------------
 .../bindings/regulator/maxim,max77802.yaml    |  85 ++++++++++++++
 2 files changed, 85 insertions(+), 111 deletions(-)
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
index 000000000000..f2b4dd15a0f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
@@ -0,0 +1,85 @@
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
+  and their meaning is::
+    1 - Normal regulator voltage output mode.
+    3 - Low Power which reduces the quiescent current down to only 1uA
+
+  The standard "regulator-mode" property can only be used for regulators that
+  support changing their mode to Low Power Mode during suspend. These
+  regulators are:: bucks 2-4 and LDOs 1-35. Also, it only takes effect if the
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
+additionalProperties: false
-- 
2.32.0

