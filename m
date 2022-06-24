Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC4559A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiFXNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiFXNNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:13:54 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB444D636
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:13:39 -0700 (PDT)
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 24 Jun 2022
 21:13:38 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/5] dt-bindings: nand: meson: convert txt to yaml
Date:   Fri, 24 Jun 2022 21:12:54 +0800
Message-ID: <20220624131257.29906-5-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624131257.29906-1-liang.yang@amlogic.com>
References: <20220624131257.29906-1-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert the amlogic,meson-name.txt to amlogic,meson-nand.yaml

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 .../bindings/mtd/amlogic,meson-nand.txt       | 55 ------------
 .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
deleted file mode 100644
index 5d5cdfef417f..000000000000
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
-
-This file documents the properties in addition to those available in
-the MTD NAND bindings.
-
-Required properties:
-- compatible : contains one of:
-  - "amlogic,meson-gxl-nfc"
-  - "amlogic,meson-axg-nfc"
-
-- reg        : Offset and length of the register set
-
-- reg-names  : "nfc" is the register set for NFC controller and "emmc"
-		is the register set for MCI controller.
-
-- clocks     :
-	A list of phandle + clock-specifier pairs for the clocks listed
-	in clock-names.
-
-- clock-names: Should contain the following:
-	"core" - NFC module gate clock
-	"device" - parent clock for internal NFC
-
-Optional children nodes:
-Children nodes represent the available nand chips.
-
-Other properties:
-see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindings.
-
-Example demonstrate on AXG SoC:
-
-	nand-controller@7800 {
-		compatible = "amlogic,meson-axg-nfc";
-		reg = <0x0 0x7800 0x0 0x100>,
-		      <0x0 0x7000 0x0 0x800>;
-		reg-names = "nfc", "emmc";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
-
-		clocks = <&clkc CLKID_SD_EMMC_C>,
-			 <&clkc CLKID_FCLK_DIV2>;
-		clock-names = "core", "device";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&nand_pins>;
-
-		nand@0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			nand-on-flash-bbt;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
new file mode 100644
index 000000000000..42634e9c0d3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/amlogic,meson-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
+
+allOf:
+  - $ref: "nand-controller.yaml"
+
+maintainers:
+  - liang.yang@amlogic.com
+
+properties:
+  compatible:
+    enum:
+      - "amlogic,meson-gxl-nfc"
+      - "amlogic,meson-axg-nfc"
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: device
+
+patternProperties:
+  "^nand@[0-7]$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
+
+      nand-ecc-mode:
+        const: hw
+
+      nand-ecc-step-size:
+        const: 1024
+
+      nand-ecc-strength:
+        enum: [8, 16, 24, 30, 40, 50, 60]
+        description: |
+          The ECC configurations that can be supported are as follows.
+            meson-gxl-nfc 8, 16, 24, 30, 40, 50, 60
+            meson-axg-nfc 8
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
+    #include <dt-bindings/clock/axg-clkc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    nand-controller@ffe07800 {
+      compatible = "amlogic,meson-axg-nfc";
+      reg = <0xffe07800 0x100>, <0xffe07000 0x800>;
+      reg-names = "nfc", "emmc";
+      interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&clkc CLKID_SD_EMMC_C>,  <&clkc CLKID_FCLK_DIV2>;
+      clock-names = "core", "device";
+
+      pinctrl-0 = <&nand_pins>;
+      pinctrl-names = "default";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      nand@0 {
+        reg = <0>;
+      };
+    };
+
+...
-- 
2.34.1

