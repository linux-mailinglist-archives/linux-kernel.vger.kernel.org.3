Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA44A4D18
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380954AbiAaRZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380899AbiAaRZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:25:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF25C061714;
        Mon, 31 Jan 2022 09:25:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E658060F86;
        Mon, 31 Jan 2022 17:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A895C340F0;
        Mon, 31 Jan 2022 17:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643649903;
        bh=GWt14oCB7kecCTZgjQrn1WAh69bfid1Sk5vtbelrnmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyDq3jyKIZ4FjQgufmjxiaPi0jCMpu4b+yKmQvoo+siOBiuxGYsBvflzxRBQpkEgC
         6iBH2ebDKyQ5d3GIidwaWJWl2nNP5BN267NPuaH+zh47n3p8XnPUd5DqQyC/BCzFjs
         lKtH3ZilZLNavVQ7mLfTkTqgGOT9Ed+yFNSJab68n3rt6I91K9Rv2I8ZdxoIO/bZCn
         eIcQM4o+mXnh3NiS1dsF0iu0FPP34wiXDvNz5rGF46zRVkdTwRLsosJ397vg1WjZmR
         lsSpIkoraU207v7wAvpMVHV2WIabThAacEp6T1bYsBUROVkbbMBWWqHyCllneUC5n+
         +x4Zd2K91Dbyg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: spmi: convert Qualcomm SPMI PMIC ARB to dtschema
Date:   Mon, 31 Jan 2022 22:54:48 +0530
Message-Id: <20220131172450.2528065-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131172450.2528065-1-vkoul@kernel.org>
References: <20220131172450.2528065-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm SPMI PMIC  arb binding to dtschema format.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/spmi/qcom,spmi-pmic-arb.txt      |  65 ----------
 .../bindings/spmi/qcom,spmi-pmic-arb.yaml     | 114 ++++++++++++++++++
 2 files changed, 114 insertions(+), 65 deletions(-)
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
index 000000000000..0c094a03fb10
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/qcom,spmi-pmic-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SPMI Controller (PMIC Arbiter)
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  The SPMI PMIC Arbiter is found on Snapdragon chipsets. It is an SPMI
+  controller with wrapping arbitration logic to allow for multiple on-chip
+  devices to control a single SPMI master.
+
+  The PMIC Arbiter can also act as an interrupt controller, providing
+  interrupts to slave devices. See
+  Documentation/devicetree/bindings/spmi/spmi.yaml for the generic SPMI
+  controller binding requirements for child nodes. See
+  Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+  generic interrupt controller binding documentation.
+
+allOf:
+  - $ref: spmi.yaml#
+
+properties:
+
+  $nodename:
+    pattern: "spmi@[0-9a-f]"
+
+  compatible:
+    const: qcom,spmi-pmic-arb
+
+  reg:
+    minItems: 3
+    items:
+      - description: SPMI core registers
+      - description: SPMI interrupt controller registers
+      - description: SPMI configuration registers
+      - description: SPMI tx-channel per virtual slave registers, for V2 PMIC Arbiter
+      - description: SPMI rx-channel (called observer) per virtual slave registers, for V2 PMIC Arbiter
+
+  reg-names:
+    minItems: 3
+    items:
+      - const: core
+      - const: intr
+      - const: cnfg
+      - const: chnls
+      - const: obsrvr
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: periph_irq
+
+  qcom,ee:
+    description: |
+      indicates the active Execution Environment identifier. Valid values 0 to 5
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  qcom,channel:
+    description: |
+      PMIC Arb which provides channels to use for accesses. Valid values 0 to 5
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - qcom,ee
+  - qcom,channel
+
+patternProperties:
+  "@[0-9a-f]$":
+    type: object
+
+    description: |
+      PMIC properties, which are specific to the used SPMI PMIC device(s).
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spmi: spmi@fff24000 {
+        compatible = "qcom,spmi-pmic-arb";
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg-names = "core", "intr", "cnfg";
+        reg = <0x0 0xfc4cf000 0x0 0x1000>,
+              <0x0 0xfc4cb000 0x0 0x1000>,
+              <0x0 0xfc4ca000 0x0 0x1000>;
+
+        interrupt-names = "periph_irq";
+        interrupts = <0 190 0>;
+
+        qcom,ee = <0>;
+        qcom,channel = <0>;
+
+        pmic@0 {
+          reg = <0 0>;
+          /* pmic properties */
+        };
+      };
+    };
-- 
2.31.1

