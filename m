Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81134AE731
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbiBICok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243523AbiBIBo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:44:56 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55026C0613CB;
        Tue,  8 Feb 2022 17:44:55 -0800 (PST)
X-UUID: 9532a817f7c14ecba7370601d6ee006e-20220209
X-UUID: 9532a817f7c14ecba7370601d6ee006e-20220209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1952052706; Wed, 09 Feb 2022 09:44:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 9 Feb 2022 09:44:50 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 09:44:49 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V5 2/3] dt-bindings: spi: Convert spi-mt65xx to json-schema
Date:   Wed, 9 Feb 2022 09:44:42 +0800
Message-ID: <20220209014443.12443-3-leilk.liu@mediatek.com>
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

Convert Mediatek ARM SOC's SPI Master controller binding
to json-schema format.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/spi/mediatek,spi-mt65xx.yaml     | 101 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-mt65xx.txt    |  68 ------------
 2 files changed, 101 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
new file mode 100644
index 000000000000..ea977fba49a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mediatek,spi-mt65xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI Bus controller for MediaTek ARM SoCs
+
+maintainers:
+  - Leilk Liu <leilk.liu@mediatek.com>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt7629-spi
+          - const: mediatek,mt7622-spi
+      - items:
+          - enum:
+              - mediatek,mt8516-spi
+          - const: mediatek,mt2712-spi
+      - items:
+          - enum:
+              - mediatek,mt6779-spi
+              - mediatek,mt8192-spi
+              - mediatek,mt8195-spi
+          - const: mediatek,mt6765-spi
+      - items:
+          - enum:
+              - mediatek,mt2701-spi
+              - mediatek,mt2712-spi
+              - mediatek,mt6589-spi
+              - mediatek,mt6765-spi
+              - mediatek,mt6893-spi
+              - mediatek,mt7622-spi
+              - mediatek,mt8135-spi
+              - mediatek,mt8173-spi
+              - mediatek,mt8183-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock used for the parent clock
+      - description: clock used for the muxes clock
+      - description: clock used for the clock gate
+
+  clock-names:
+    items:
+      - const: parent-clk
+      - const: sel-clk
+      - const: spi-clk
+
+  mediatek,pad-select:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 4
+    items:
+      enum: [0, 1, 2, 3]
+    description:
+      specify which pins group(ck/mi/mo/cs) spi controller used.
+      This is an array.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@1100a000 {
+      compatible = "mediatek,mt8173-spi";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      reg = <0x1100a000 0x1000>;
+      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+      clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+               <&topckgen CLK_TOP_SPI_SEL>,
+               <&pericfg CLK_PERI_SPI0>;
+      clock-names = "parent-clk", "sel-clk", "spi-clk";
+      cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
+      mediatek,pad-select = <1>, <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
deleted file mode 100644
index 2a24969159cc..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-Binding for MTK SPI controller
-
-Required properties:
-- compatible: should be one of the following.
-    - mediatek,mt2701-spi: for mt2701 platforms
-    - mediatek,mt2712-spi: for mt2712 platforms
-    - mediatek,mt6589-spi: for mt6589 platforms
-    - mediatek,mt6765-spi: for mt6765 platforms
-    - mediatek,mt7622-spi: for mt7622 platforms
-    - "mediatek,mt7629-spi", "mediatek,mt7622-spi": for mt7629 platforms
-    - mediatek,mt8135-spi: for mt8135 platforms
-    - mediatek,mt8173-spi: for mt8173 platforms
-    - mediatek,mt8183-spi: for mt8183 platforms
-    - mediatek,mt6893-spi: for mt6893 platforms
-    - "mediatek,mt8192-spi", "mediatek,mt6765-spi": for mt8192 platforms
-    - "mediatek,mt8195-spi", "mediatek,mt6765-spi": for mt8195 platforms
-    - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
-    - "mediatek,mt6779-spi", "mediatek,mt6765-spi": for mt6779 platforms
-
-- #address-cells: should be 1.
-
-- #size-cells: should be 0.
-
-- reg: Address and length of the register set for the device
-
-- interrupts: Should contain spi interrupt
-
-- clocks: phandles to input clocks.
-  The first should be one of the following. It's PLL.
-   -  <&clk26m>: specify parent clock 26MHZ.
-   -  <&topckgen CLK_TOP_SYSPLL3_D2>: specify parent clock 109MHZ.
-				      It's the default one.
-   -  <&topckgen CLK_TOP_SYSPLL4_D2>: specify parent clock 78MHZ.
-   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
-   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
-  The second should be <&topckgen CLK_TOP_SPI_SEL>. It's clock mux.
-  The third is <&pericfg CLK_PERI_SPI0>. It's clock gate.
-
-- clock-names: shall be "parent-clk" for the parent clock, "sel-clk" for the
-  muxes clock, and "spi-clk" for the clock gate.
-
-Optional properties:
--cs-gpios: see spi-bus.txt.
-
-- mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
-  controller used. This is an array, the element value should be 0~3,
-  only required for MT8173.
-    0: specify GPIO69,70,71,72 for spi pins.
-    1: specify GPIO102,103,104,105 for spi pins.
-    2: specify GPIO128,129,130,131 for spi pins.
-    3: specify GPIO5,6,7,8 for spi pins.
-
-Example:
-
-- SoC Specific Portion:
-spi: spi@1100a000 {
-	compatible = "mediatek,mt8173-spi";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	reg = <0 0x1100a000 0 0x1000>;
-	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
-	clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
-		 <&topckgen CLK_TOP_SPI_SEL>,
-		 <&pericfg CLK_PERI_SPI0>;
-	clock-names = "parent-clk", "sel-clk", "spi-clk";
-	cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
-	mediatek,pad-select = <1>, <0>;
-};
-- 
2.25.1

