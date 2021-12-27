Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1085B480503
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 22:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhL0Vyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 16:54:43 -0500
Received: from ixit.cz ([94.230.151.217]:48656 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhL0Vym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 16:54:42 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 36CD12243C;
        Mon, 27 Dec 2021 22:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640642080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yw3V8KGmYspILWXnQWSBMCxq7vpVIhCkP8lWTZHJ1PA=;
        b=bzbC0DnjTBYbFFsPfGLxrALpOPpwtA1hooSYC3v+jyrFwlNlXbeDe56Q5wiuGc0ggdIgRV
        NnE7/zQYsykVosx/m91A1EiOMORVV7375fl0mpfgy2UpjGRIMDzo2ESYUx1gPwpet2YoKn
        gYCDgP+aj0GnSU86svseBXKtACwwOi0=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht,
        Caleb Connolly <caleb.connolly@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Date:   Mon, 27 Dec 2021 22:54:33 +0100
Message-Id: <20211227215433.114426-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

Convert Qualcomm SPMI PMIC binding to yaml format.

Additional changes:
 - filled many missing compatibles

Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
depends on patch "arm64: dts: qcom: pms405: assign device specific compatible"
---
 .../bindings/mfd/qcom,spmi-pmic.txt           |  93 -----------
 .../bindings/mfd/qcom,spmi-pmic.yaml          | 152 ++++++++++++++++++
 2 files changed, 152 insertions(+), 93 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
deleted file mode 100644
index 3810a80536f7..000000000000
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ /dev/null
@@ -1,93 +0,0 @@
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
index 000000000000..11aa2c61eded
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -0,0 +1,152 @@
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
+          - qcom,smb2351
+      - const: qcom,spmi-pmic
+
+  reg: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+
+patternProperties:
+  $nodename:
+    pattern: '^pmic@.*$'
+
+  '(labibb|([a-z][a-z0-9]+-)?regulators)':
+    type: object
+
+    required:
+      - compatible
+
+  '@[0-9a-f]+$':
+    type: object
+    description: >
+      Each child node of the PMIC represents a function of it.
+
+    properties:
+      interrupts:
+        description: >
+          Interrupts are specified as a 4-tuple. For more information see
+          Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
+
+      interrupt-names: true
+
+    required:
+      - compatible
+
+    additionalProperties: true
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
2.34.1

