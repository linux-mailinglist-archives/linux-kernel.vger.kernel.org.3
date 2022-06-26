Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C238D55B3BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiFZTQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiFZTQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:16:35 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DE5DF52;
        Sun, 26 Jun 2022 12:16:33 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id E81EA2007F;
        Sun, 26 Jun 2022 21:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1656270992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WKybZGhV4YjO/putV0v1ehsWG0C62FhaFEQ12u5mHj0=;
        b=wqQEAaYOW66KNmpLo/LganRB/8rOL5P0Ra6pANPWdYmpP/FBD5lHIszIWJH2hqzz3xtzX9
        jfVG2Q1OztvmrXANrXlUKfK+b8wnvP8AIi9OQuq6oeNLvY7zhZKp60cKB+AZLOrP/5Njl5
        IDj4EpW2n5YfIhUM5cGUgJ+K9hkeD7M=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Date:   Sun, 26 Jun 2022 21:16:30 +0200
Message-Id: <20220626191630.176835-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm SPMI PMIC binding to yaml format.

Additional changes:
 - filled many missing compatibles

Co-developed-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v3:
 - added subnodes, there are two not converted to YAML yet, but it works
 - now it prints milion directly unrelated warning to this binding
   (it's related to the included subnodes bindings, can be merged,
    but it'll generate more warnings and preferably anyone can takeover
    from here)
 - add qcom,pmx65

v2:
 - changed author to myself, kept Caleb as co-author
 - moved nodename to properties
 - add nodenames for pm* with deprecated property
 - add ^$ to pattern properties
 - dropped interrupt-names property
 - added reg prop. to the nodes which have register in nodename
 - added compatible pmx55
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
 .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
 2 files changed, 191 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
deleted file mode 100644
index eb78e3ae7703..000000000000
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-          Qualcomm SPMI PMICs multi-function device bindings
-
-The Qualcomm SPMI series presently includes PM8941, PM8841 and PMA8084
-PMICs.  These PMICs use a QPNP scheme through SPMI interface.
-QPNP is effectively a partitioning scheme for dividing the SPMI extended
-register space up into logical pieces, and set of fixed register
-locations/definitions within these regions, with some of these regions
-specifically used for interrupt handling.
-
-The QPNP PMICs are used with the Qualcomm Snapdragon series SoCs, and are
-interfaced to the chip via the SPMI (System Power Management Interface) bus.
-Support for multiple independent functions are implemented by splitting the
-16-bit SPMI slave address space into 256 smaller fixed-size regions, 256 bytes
-each. A function can consume one or more of these fixed-size register regions.
-
-Required properties:
-- compatible:      Should contain one of:
-                   "qcom,pm660",
-                   "qcom,pm660l",
-                   "qcom,pm7325",
-                   "qcom,pm8004",
-                   "qcom,pm8005",
-                   "qcom,pm8019",
-                   "qcom,pm8028",
-                   "qcom,pm8110",
-                   "qcom,pm8150",
-                   "qcom,pm8150b",
-                   "qcom,pm8150c",
-                   "qcom,pm8150l",
-                   "qcom,pm8226",
-                   "qcom,pm8350c",
-                   "qcom,pm8841",
-                   "qcom,pm8901",
-                   "qcom,pm8909",
-                   "qcom,pm8916",
-                   "qcom,pm8941",
-                   "qcom,pm8950",
-                   "qcom,pm8953",
-                   "qcom,pm8994",
-                   "qcom,pm8998",
-                   "qcom,pma8084",
-                   "qcom,pmd9635",
-                   "qcom,pmi8950",
-                   "qcom,pmi8962",
-                   "qcom,pmi8994",
-                   "qcom,pmi8998",
-                   "qcom,pmk8002",
-                   "qcom,pmk8350",
-                   "qcom,pmr735a",
-                   "qcom,smb2351",
-                   or generalized "qcom,spmi-pmic".
-- reg:             Specifies the SPMI USID slave address for this device.
-                   For more information see:
-                   Documentation/devicetree/bindings/spmi/spmi.yaml
-
-Required properties for peripheral child nodes:
-- compatible:      Should contain "qcom,xxx", where "xxx" is a peripheral name.
-
-Optional properties for peripheral child nodes:
-- interrupts:      Interrupts are specified as a 4-tuple. For more information
-                   see:
-                   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
-- interrupt-names: Corresponding interrupt name to the interrupts property
-
-Each child node of SPMI slave id represents a function of the PMIC. In the
-example below the rtc device node represents a peripheral of pm8941
-SID = 0. The regulator device node represents a peripheral of pm8941 SID = 1.
-
-Example:
-
-	spmi {
-		compatible = "qcom,spmi-pmic-arb";
-
-		pm8941@0 {
-			compatible = "qcom,pm8941", "qcom,spmi-pmic";
-			reg = <0x0 SPMI_USID>;
-
-			rtc {
-				compatible = "qcom,rtc";
-				interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
-				interrupt-names = "alarm";
-			};
-		};
-
-		pm8941@1 {
-			compatible = "qcom,pm8941", "qcom,spmi-pmic";
-			reg = <0x1 SPMI_USID>;
-
-			regulator {
-				compatible = "qcom,regulator";
-				regulator-name = "8941_boost";
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
new file mode 100644
index 000000000000..32daebc3a0bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SPMI PMICs multi-function device
+
+description: |
+  Some Qualcomm PMICs used with the Snapdragon series SoCs are interfaced
+  to the chip via the SPMI (System Power Management Interface) bus.
+  Support for multiple independent functions are implemented by splitting the
+  16-bit SPMI peripheral address space into 256 smaller fixed-size regions, 256 bytes
+  each. A function can consume one or more of these fixed-size register regions.
+
+  The Qualcomm SPMI series includes the PM8941, PM8841, PMA8084, PM8998 and other
+  PMICs.  These PMICs use a "QPNP" scheme through SPMI interface.
+  QPNP is effectively a partitioning scheme for dividing the SPMI extended
+  register space up into logical pieces, and set of fixed register
+  locations/definitions within these regions, with some of these regions
+  specifically used for interrupt handling.
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+properties:
+  $nodename:
+    oneOf:
+      - pattern: '^pmic@.*$'
+      - pattern: '^pm(a|s)?[0-9]*@.*$'
+        deprecated: true
+
+  compatible:
+    items:
+      - enum:
+          - qcom,pm660
+          - qcom,pm660l
+          - qcom,pm6150
+          - qcom,pm6150l
+          - qcom,pm6350
+          - qcom,pm7325
+          - qcom,pm8004
+          - qcom,pm8005
+          - qcom,pm8009
+          - qcom,pm8019
+          - qcom,pm8110
+          - qcom,pm8150
+          - qcom,pm8150b
+          - qcom,pm8150l
+          - qcom,pm8226
+          - qcom,pm8350
+          - qcom,pm8350b
+          - qcom,pm8350c
+          - qcom,pm8841
+          - qcom,pm8909
+          - qcom,pm8916
+          - qcom,pm8941
+          - qcom,pm8950
+          - qcom,pm8994
+          - qcom,pm8998
+          - qcom,pma8084
+          - qcom,pmd9635
+          - qcom,pmi8950
+          - qcom,pmi8962
+          - qcom,pmi8994
+          - qcom,pmi8998
+          - qcom,pmk8350
+          - qcom,pmm8155au
+          - qcom,pmr735a
+          - qcom,pmr735b
+          - qcom,pms405
+          - qcom,pmx55
+          - qcom,pmx65
+          - qcom,smb2351
+      - const: qcom,spmi-pmic
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  labibb:
+    type: object
+    $ref: /schemas/regulator/qcom-labibb-regulator.yaml#
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+
+patternProperties:
+  "^adc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
+
+  "^adc-tm@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/thermal/qcom-spmi-adc-tm5.yaml#
+
+  "^audio-codec@[0-9a-f]+$":
+    type: object
+    additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec binding not converted yet
+
+  "extcon@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/extcon/qcom,pm8941-misc.yaml#
+
+  "gpio(s)?@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
+
+  "pon@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/power/reset/qcom,pon.yaml#
+
+  "pwm@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/leds/leds-qcom-lpg.yaml#
+
+  "^rtc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/rtc/qcom-pm8xxx-rtc.yaml#
+
+  "^temp-alarm@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/thermal/qcom,spmi-temp-alarm.yaml#
+
+  "^vibrator@[0-9a-f]+$":
+    type: object
+    additionalProperties: true # FIXME qcom,pm8916-vib binding not converted yet
+
+  "^mpps@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/pinctrl/qcom,pmic-mpp.yaml#
+
+  "(.*)?(wled|leds)@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/leds/backlight/qcom-wled.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/spmi/spmi.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spmi@c440000 {
+        compatible = "qcom,spmi-pmic-arb";
+        reg = <0x0c440000 0x1100>,
+              <0x0c600000 0x2000000>,
+              <0x0e600000 0x100000>,
+              <0x0e700000 0xa0000>,
+              <0x0c40a000 0x26000>;
+        reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+        interrupt-names = "periph_irq";
+        interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
+        qcom,ee = <0>;
+        qcom,channel = <0>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        interrupt-controller;
+        #interrupt-cells = <4>;
+        cell-index = <0>;
+
+        pmi8998_lsid0: pmic@2 {
+            compatible = "qcom,pmi8998", "qcom,spmi-pmic";
+            reg = <0x2 SPMI_USID>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            pmi8998_gpio: gpios@c000 {
+                compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
+                reg = <0xc000>;
+                gpio-controller;
+                gpio-ranges = <&pmi8998_gpio 0 0 14>;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+        };
+    };
-- 
2.35.1

