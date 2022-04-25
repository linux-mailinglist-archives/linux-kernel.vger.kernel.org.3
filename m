Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94BE50E290
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiDYOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiDYOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:05:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E447C8BF21;
        Mon, 25 Apr 2022 07:02:25 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 146A022246;
        Mon, 25 Apr 2022 16:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650895343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jp57dIVExTBYOFH5u8qjTvs5w4CxGPSFpn5RQoFRCE4=;
        b=EqpkE5HtM8/VXMFbhvVPoirUhwzWMTMJAT1wrhnc+6NoVMyPk5q1oco/cfXkezkRWYofRy
        J7/TGBZna99K2MQqUFAasg+ZN9STod4oo4gGfA/aQktce/B1nosGgGw0h/SyrLXJj0ZnaA
        8cnWQHai0YuG9B2H4GaUPUljfIYxTQQ=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: fsl,ls-extirq: convert to YAML
Date:   Mon, 25 Apr 2022 16:02:13 +0200
Message-Id: <20220425140214.32448-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - new patch, because it's reference in patch 2/2

 .../interrupt-controller/fsl,ls-extirq.txt    | 53 -----------
 .../interrupt-controller/fsl,ls-extirq.yaml   | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 53 deletions(-)
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
index 000000000000..39d120ad7549
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -0,0 +1,88 @@
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
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
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
+  interrupt-map-mask:
+    items:
+      - const: 0xffffffff
+      - const: 0
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
+            interrupt-map-mask = <0xffffffff 0x0>;
+    };
-- 
2.30.2

