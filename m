Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A044C485F3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 04:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiAFDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 22:31:44 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:10288 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiAFDbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 22:31:43 -0500
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 22:31:43 EST
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Thu, 6 Jan 2022
 11:31:42 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
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
Subject: [PATCH] dt-bindings: nand: meson: fix controller clock
Date:   Thu, 6 Jan 2022 11:31:30 +0800
Message-ID: <20220106033130.37623-1-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change-Id: I1425b491d8b95061e1ce358ef33143433fc94d24
---
 .../bindings/mtd/amlogic,meson-nand.txt        | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
index 5794ab1147c1..37f16fe4fe66 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -14,11 +14,6 @@ Required properties:
 - clock-names: Should contain the following:
 	"core" - NFC module gate clock
 	"device" - device clock from eMMC sub clock controller
-	"rx" - rx clock phase
-	"tx" - tx clock phase
-
-- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
-				controller port C
 
 Optional children nodes:
 Children nodes represent the available nand chips.
@@ -28,11 +23,6 @@ see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindi
 
 Example demonstrate on AXG SoC:
 
-	sd_emmc_c_clkc: mmc@7000 {
-		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
-		reg = <0x0 0x7000 0x0 0x800>;
-	};
-
 	nand-controller@7800 {
 		compatible = "amlogic,meson-axg-nfc";
 		reg = <0x0 0x7800 0x0 0x100>;
@@ -41,11 +31,9 @@ Example demonstrate on AXG SoC:
 		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
 
 		clocks = <&clkc CLKID_SD_EMMC_C>,
-			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
-			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
-			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
-		clock-names = "core", "device", "rx", "tx";
-		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
+			<&clkc CLKID_FCLK_DIV2>;
+		clock-names = "core", "device";
+		sd_emmc_c_clkc = <0xffe07000>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&nand_pins>;
-- 
2.34.1

