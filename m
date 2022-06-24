Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152FE559A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiFXNN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiFXNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:13:27 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7364FD;
        Fri, 24 Jun 2022 06:13:25 -0700 (PDT)
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 24 Jun 2022
 21:13:23 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>, Rob Herring <robh@kernel.org>,
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
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: nand: meson: fix meson nfc clock
Date:   Fri, 24 Jun 2022 21:12:51 +0800
Message-ID: <20220624131257.29906-2-liang.yang@amlogic.com>
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

EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK'
which is defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is
the divider and bit6~7 is the mux for fix pll and xtal. At the beginning,
a common MMC and NAND sub-clock was discussed and planed to be implemented
as NFC clock provider, but now this series of patches of a common MMC and
NAND sub-clock are never being accepted and the current binding was never
valid. the reasons for giving up are:
1. EMMC and NAND, which are mutually exclusive anyway
2. coupling the EMMC and NAND.
3. it seems that a common MMC and NAND sub-clock is over engineered.
and let us see the link fot more information:
https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@amlogic.com
so The meson nfc can't work now, let us rework the clock.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 .../bindings/mtd/amlogic,meson-nand.txt       | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
index 5794ab1147c1..5d5cdfef417f 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -7,18 +7,19 @@ Required properties:
 - compatible : contains one of:
   - "amlogic,meson-gxl-nfc"
   - "amlogic,meson-axg-nfc"
+
+- reg        : Offset and length of the register set
+
+- reg-names  : "nfc" is the register set for NFC controller and "emmc"
+		is the register set for MCI controller.
+
 - clocks     :
 	A list of phandle + clock-specifier pairs for the clocks listed
 	in clock-names.
 
 - clock-names: Should contain the following:
 	"core" - NFC module gate clock
-	"device" - device clock from eMMC sub clock controller
-	"rx" - rx clock phase
-	"tx" - tx clock phase
-
-- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
-				controller port C
+	"device" - parent clock for internal NFC
 
 Optional children nodes:
 Children nodes represent the available nand chips.
@@ -28,24 +29,18 @@ see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindi
 
 Example demonstrate on AXG SoC:
 
-	sd_emmc_c_clkc: mmc@7000 {
-		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
-		reg = <0x0 0x7000 0x0 0x800>;
-	};
-
 	nand-controller@7800 {
 		compatible = "amlogic,meson-axg-nfc";
-		reg = <0x0 0x7800 0x0 0x100>;
+		reg = <0x0 0x7800 0x0 0x100>,
+		      <0x0 0x7000 0x0 0x800>;
+		reg-names = "nfc", "emmc";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
 
 		clocks = <&clkc CLKID_SD_EMMC_C>,
-			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
-			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
-			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
-		clock-names = "core", "device", "rx", "tx";
-		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
+			 <&clkc CLKID_FCLK_DIV2>;
+		clock-names = "core", "device";
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&nand_pins>;
-- 
2.34.1

