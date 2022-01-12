Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B984D48C264
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352594AbiALKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:36:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37930 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352561AbiALKgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:36:21 -0500
X-UUID: 3fb05f5c6a4f43c9979a826d9750533d-20220112
X-UUID: 3fb05f5c6a4f43c9979a826d9750533d-20220112
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1447400250; Wed, 12 Jan 2022 18:36:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 12 Jan 2022 18:36:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 18:36:14 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH V2 1/3] dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
Date:   Wed, 12 Jan 2022 18:36:07 +0800
Message-ID: <20220112103609.17421-2-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112103609.17421-1-leilk.liu@mediatek.com>
References: <20220112103609.17421-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Mediatek ARM SOC's SPI Slave controller binding
to json-schema format.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../spi/mediatek,spi-slave-mt27xx.yaml        | 73 +++++++++++++++++++
 .../bindings/spi/spi-slave-mt27xx.txt         | 33 ---------
 2 files changed, 73 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
new file mode 100644
index 000000000000..3364fff08cca
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mediatek,spi-slave-mt27xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI Slave controller for MediaTek ARM SoCs
+
+maintainers:
+  - Leilk Liu <leilk.liu@mediatek.com>
+
+allOf:
+  - $ref: /spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2712-spi-slave
+      - items:
+          - enum:
+              - mediatek,mt8195-spi-slave
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock used for the clock gate
+
+  clock-names:
+    items:
+      - const: spi
+
+  assigned-clocks:
+    maxItems: 1
+    description: |
+      The mux clock for the given platform.
+
+  assigned-clock-parents:
+    maxItems: 1
+    description: |
+      The parent of mux clock for the given platform.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2712-clk.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@10013000 {
+      compatible = "mediatek,mt2712-spi-slave";
+      reg = <0x10013000 0x100>;
+      interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+      clocks = <&infracfg CLK_INFRA_AO_SPI1>;
+      clock-names = "spi";
+      assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
+      assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
deleted file mode 100644
index 9192724540fd..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Binding for MTK SPI Slave controller
-
-Required properties:
-- compatible: should be one of the following.
-    - mediatek,mt2712-spi-slave: for mt2712 platforms
-    - mediatek,mt8195-spi-slave: for mt8195 platforms
-- reg: Address and length of the register set for the device.
-- interrupts: Should contain spi interrupt.
-- clocks: phandles to input clocks.
-  It's clock gate, and should be <&infracfg CLK_INFRA_AO_SPI1>.
-- clock-names: should be "spi" for the clock gate.
-
-Optional properties:
-- assigned-clocks: it's mux clock, should be <&topckgen CLK_TOP_SPISLV_SEL>.
-- assigned-clock-parents: parent of mux clock.
-  It's PLL, and should be one of the following.
-   -  <&topckgen CLK_TOP_UNIVPLL1_D2>: specify parent clock 312MHZ.
-				       It's the default one.
-   -  <&topckgen CLK_TOP_UNIVPLL1_D4>: specify parent clock 156MHZ.
-   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
-   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
-
-Example:
-- SoC Specific Portion:
-spis1: spi@10013000 {
-	compatible = "mediatek,mt2712-spi-slave";
-	reg = <0 0x10013000 0 0x100>;
-	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
-	clocks = <&infracfg CLK_INFRA_AO_SPI1>;
-	clock-names = "spi";
-	assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
-	assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
-};
-- 
2.25.1

