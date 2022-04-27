Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A45112F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359189AbiD0H5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359141AbiD0H5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:57:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B75145845;
        Wed, 27 Apr 2022 00:53:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E55DB2224D;
        Wed, 27 Apr 2022 09:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651046026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c8md0w7nTqGQ2WYhNmFqixpQ0s9YgN3QXjIFu39VBh0=;
        b=uO9TCJkvgR02p9dHf+IqBSj/GTs0FSB18noOSS5R5pUmXa9F/CkDd1wtBqpVwk4uuBq0EM
        /qPRAVeQwT86SD7HzkgVp+bcv3Kz07zr/lFy/WYLcUB5Cj7GtSfAKmkxnM2LEum0wG+nkm
        ef4VyieYBshjzDGdfwn1A7zS7fLdUEE=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: interrupt-controller: fsl,ls-extirq: convert to YAML
Date:   Wed, 27 Apr 2022 09:53:37 +0200
Message-Id: <20220427075338.1156449-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427075338.1156449-1-michael@walle.cc>
References: <20220427075338.1156449-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fsl,ls-extirq binding to the new YAML format.

In contrast to the original binding documentation, there are three
compatibles which are used in their corresponding device trees which
have a specific compatible and the (already documented) fallback
compatible:
 - "fsl,ls1046a-extirq", "fsl,ls1043a-extirq"
 - "fsl,ls2080a-extirq", "fsl,ls1088a-extirq"
 - "fsl,lx2160a-extirq", "fsl,ls1088a-extirq"

Depending on the number of the number of the external IRQs which is
usually 12 except for the LS1021A where there are only 6, the
interrupt-map-mask was reduced from 0xffffffff to 0xf and 0x7
respectively and the number of interrupt-map entries have to
match.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v2:
 - drop $ref to interrupt-controller.yaml
 - use a more strict interrupt-map-mask and make it conditional on SoC

changes since v1:
 - new patch

 .../interrupt-controller/fsl,ls-extirq.txt    |  53 --------
 .../interrupt-controller/fsl,ls-extirq.yaml   | 118 ++++++++++++++++++
 2 files changed, 118 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
deleted file mode 100644
index 4d47df1a5c91..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-* Freescale Layerscape external IRQs
-
-Some Layerscape SOCs (LS1021A, LS1043A, LS1046A
-LS1088A, LS208xA, LX216xA) support inverting
-the polarity of certain external interrupt lines.
-
-The device node must be a child of the node representing the
-Supplemental Configuration Unit (SCFG).
-
-Required properties:
-- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
-  "fsl,ls1043a-extirq": for LS1043A, LS1046A.
-  "fsl,ls1088a-extirq": for LS1088A, LS208xA, LX216xA.
-- #interrupt-cells: Must be 2. The first element is the index of the
-  external interrupt line. The second element is the trigger type.
-- #address-cells: Must be 0.
-- interrupt-controller: Identifies the node as an interrupt controller
-- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in
-  the SCFG or the External Interrupt Control Register (IRQCR) in
-  the ISC.
-- interrupt-map: Specifies the mapping from external interrupts to GIC
-  interrupts.
-- interrupt-map-mask: Must be <0xffffffff 0>.
-
-Example:
-	scfg: scfg@1570000 {
-		compatible = "fsl,ls1021a-scfg", "syscon";
-		reg = <0x0 0x1570000 0x0 0x10000>;
-		big-endian;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x1570000 0x10000>;
-
-		extirq: interrupt-controller@1ac {
-			compatible = "fsl,ls1021a-extirq";
-			#interrupt-cells = <2>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x1ac 4>;
-			interrupt-map =
-				<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
-				<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
-				<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
-				<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
-				<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
-				<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-map-mask = <0xffffffff 0x0>;
-		};
-	};
-
-
-	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
-			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
new file mode 100644
index 000000000000..887e565b9573
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,ls-extirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape External Interrupt Controller
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+  - Li Yang <leoyang.li@nxp.com>
+
+description: |
+  Some Layerscape SOCs (LS1021A, LS1043A, LS1046A LS1088A, LS208xA,
+  LX216xA) support inverting the polarity of certain external interrupt
+  lines.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,ls1021a-extirq
+          - fsl,ls1043a-extirq
+          - fsl,ls1088a-extirq
+      - items:
+          - enum:
+              - fsl,ls1046a-extirq
+          - const: fsl,ls1043a-extirq
+      - items:
+          - enum:
+              - fsl,ls2080a-extirq
+              - fsl,lx2160a-extirq
+          - const: fsl,ls1088a-extirq
+
+  '#interrupt-cells':
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+    description:
+      Specifies the Interrupt Polarity Control Register (INTPCR) in the
+      SCFG or the External Interrupt Control Register (IRQCR) in the ISC.
+
+  interrupt-map:
+    description: Specifies the mapping from external interrupts to GIC interrupts.
+
+  interrupt-map-mask: true
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - reg
+  - interrupt-map
+  - interrupt-map-mask
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,ls1021a-extirq
+    then:
+      properties:
+        interrupt-map:
+          minItems: 6
+          maxItems: 6
+        interrupt-map-mask:
+          items:
+            - const: 0x7
+            - const: 0
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,ls1043a-extirq
+              - fsl,ls1046a-extirq
+              - fsl,ls1088a-extirq
+              - fsl,ls2080a-extirq
+              - fsl,lx2160a-extirq
+    then:
+      properties:
+        interrupt-map:
+          minItems: 12
+          maxItems: 12
+        interrupt-map-mask:
+          items:
+            - const: 0xf
+            - const: 0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    interrupt-controller@1ac {
+            compatible = "fsl,ls1021a-extirq";
+            #interrupt-cells = <2>;
+            #address-cells = <0>;
+            interrupt-controller;
+            reg = <0x1ac 4>;
+            interrupt-map =
+                    <0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+                    <1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+                    <2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+                    <3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+                    <4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                    <5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-map-mask = <0x7 0x0>;
+    };
-- 
2.30.2

