Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA14AE740
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbiBICqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiBIBoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:44:55 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C082C06173B;
        Tue,  8 Feb 2022 17:44:54 -0800 (PST)
X-UUID: 6638f119a89f4a0896225e435273151e-20220209
X-UUID: 6638f119a89f4a0896225e435273151e-20220209
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 61713781; Wed, 09 Feb 2022 09:44:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Feb 2022 09:44:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 09:44:48 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/3] dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
Date:   Wed, 9 Feb 2022 09:44:41 +0800
Message-ID: <20220209014443.12443-2-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209014443.12443-1-leilk.liu@mediatek.com>
References: <20220209014443.12443-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Mediatek ARM SOC's SPI Slave controller binding
to json-schema format.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../spi/mediatek,spi-slave-mt27xx.yaml        | 58 +++++++++++++++++++
 .../bindings/spi/spi-slave-mt27xx.txt         | 33 -----------
 2 files changed, 58 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
new file mode 100644
index 000000000000..7977799a8ee1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
@@ -0,0 +1,58 @@
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
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt2712-spi-slave
+      - mediatek,mt8195-spi-slave
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: spi
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

