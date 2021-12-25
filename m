Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3547F450
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhLYTTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 14:19:01 -0500
Received: from ixit.cz ([94.230.151.217]:56110 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232653AbhLYTTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 14:19:00 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 91F142243C;
        Sat, 25 Dec 2021 20:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640459937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T8OjGOdlVg2ZEdX1g4mS/t35gyVDcyzmM4q91LVcSQo=;
        b=Cm4m8t1ZOhV6tG1UQAHi8BConpEzRosKmE/UJBcBXyYHy/j1ozOtbQ+XPPdnVUYLQqBsOo
        /XuNlAyI/aH53uqd7y1mqhSTdy42zvF/NCKFWqZBcx+2ci4mYPO5qGiKez1lGP42Sq8iJ1
        5ltDp5aOTIPN5JhFpS2Fo88qbqJoP2k=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: spmi: convert QCOM PMIC SPMI bindings to yaml
Date:   Sat, 25 Dec 2021 20:18:55 +0100
Message-Id: <20211225191856.64587-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm PMIC SPMI binding to yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>

---
v2:
 - add #address and #size-cells
 - add reg and remove spmi include from example

 .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 120 ++++++++++++++++++
 2 files changed, 120 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
deleted file mode 100644
index ca645e21fe47..000000000000
--- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-Qualcomm SPMI Controller (PMIC Arbiter)
-
-The SPMI PMIC Arbiter is found on Snapdragon chipsets.  It is an SPMI
-controller with wrapping arbitration logic to allow for multiple on-chip
-devices to control a single SPMI master.
-
-The PMIC Arbiter can also act as an interrupt controller, providing interrupts
-to slave devices.
-
-See Documentation/devicetree/bindings/spmi/spmi.yaml for the generic SPMI
-controller binding requirements for child nodes.
-
-See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
-generic interrupt controller binding documentation.
-
-Required properties:
-- compatible : should be "qcom,spmi-pmic-arb".
-- reg-names  : must contain:
-     "core" - core registers
-     "intr" - interrupt controller registers
-     "cnfg" - configuration registers
-   Registers used only for V2 PMIC Arbiter:
-     "chnls"  - tx-channel per virtual slave registers.
-     "obsrvr" - rx-channel (called observer) per virtual slave registers.
-
-- reg : address + size pairs describing the PMIC arb register sets; order must
-        correspond with the order of entries in reg-names
-- #address-cells : must be set to 2
-- #size-cells : must be set to 0
-- qcom,ee : indicates the active Execution Environment identifier (0-5)
-- qcom,channel : which of the PMIC Arb provided channels to use for accesses (0-5)
-- interrupts : interrupt list for the PMIC Arb controller, must contain a
-               single interrupt entry for the peripheral interrupt
-- interrupt-names : corresponding interrupt names for the interrupts
-                    listed in the 'interrupts' property, must contain:
-     "periph_irq" - summary interrupt for PMIC peripherals
-- interrupt-controller : boolean indicator that the PMIC arbiter is an interrupt controller
-- #interrupt-cells :  must be set to 4. Interrupts are specified as a 4-tuple:
-    cell 1: slave ID for the requested interrupt (0-15)
-    cell 2: peripheral ID for requested interrupt (0-255)
-    cell 3: the requested peripheral interrupt (0-7)
-    cell 4: interrupt flags indicating level-sense information, as defined in
-            dt-bindings/interrupt-controller/irq.h
-
-Example:
-
-	spmi {
-		compatible = "qcom,spmi-pmic-arb";
-		reg-names = "core", "intr", "cnfg";
-		reg = <0xfc4cf000 0x1000>,
-		      <0xfc4cb000 0x1000>,
-		      <0xfc4ca000 0x1000>;
-
-		interrupt-names = "periph_irq";
-		interrupts = <0 190 0>;
-
-		qcom,ee = <0>;
-		qcom,channel = <0>;
-
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <4>;
-	};
diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
new file mode 100644
index 000000000000..55d379c85fd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SPMI Controller (PMIC Arbiter)
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  The SPMI PMIC Arbiter is found on Snapdragon chipsets. It is an SPMI
+  controller with wrapping arbitration logic to allow for multiple on-chip
+  devices to control a single SPMI master.
+
+  The PMIC Arbiter can also act as an interrupt controller, providing interrupts
+  to slave devices.
+
+allOf:
+  - $ref: spmi.yaml
+
+properties:
+  compatible:
+    const: qcom,spmi-pmic-arb
+
+  reg:
+    oneOf:
+      - items: # V1
+          - description: core registers
+          - description: interrupt controller registers
+          - description: configuration registers
+      - items: # V2
+          - description: core registers
+          - description: tx-channel per virtual slave regosters
+          - description: rx-channel (called observer) per virtual slave registers
+          - description: interrupt controller registers
+          - description: configuration registers
+
+  reg-names:
+    oneOf:
+      - items:
+          - const: core
+          - const: intr
+          - const: cnfg
+      - items:
+          - const: core
+          - const: chnls
+          - const: obsrvr
+          - const: intr
+          - const: cnfg
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: periph_irq
+
+  interrupt-controller: true
+
+  '#address-cells': true
+
+  '#interrupt-cells':
+    const: 4
+    description: |
+      cell 1: slave ID for the requested interrupt (0-15)
+      cell 2: peripheral ID for requested interrupt (0-255)
+      cell 3: the requested peripheral interrupt (0-7)
+      cell 4: interrupt flags indicating level-sense information,
+              as defined in dt-bindings/interrupt-controller/irq.h
+
+  '#size-cells': true
+
+  qcom,ee:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description: >
+      indicates the active Execution Environment identifier
+
+  qcom,channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 5
+    description: >
+      which of the PMIC Arb provided channels to use for accesses
+
+required:
+  - compatible
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - '#interrupt-cells'
+  - qcom,ee
+  - qcom,channel
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spmi@fc4cf000 {
+        compatible = "qcom,spmi-pmic-arb";
+        reg-names = "core", "intr", "cnfg";
+        reg = <0xfc4cf000 0x1000>,
+              <0xfc4cb000 0x1000>,
+              <0xfc4ca000 0x1000>;
+
+        interrupt-names = "periph_irq";
+        interrupts = <0 190 0>;
+
+        qcom,ee = <0>;
+        qcom,channel = <0>;
+
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        interrupt-controller;
+        #interrupt-cells = <4>;
+    };
+
-- 
2.34.1

