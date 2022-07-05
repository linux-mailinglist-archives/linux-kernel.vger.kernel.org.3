Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF5566620
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiGEJ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiGEJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:27:09 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D110C12A94;
        Tue,  5 Jul 2022 02:27:05 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BD981A0AD0;
        Tue,  5 Jul 2022 11:27:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 09BA61A08BC;
        Tue,  5 Jul 2022 11:27:04 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9ABDE1820F45;
        Tue,  5 Jul 2022 17:27:01 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com,
        zhengxunli@mxic.com.tw
Subject: [PATCH 10/11] arm64: dts: imx8ulp: add flexspi support
Date:   Tue,  5 Jul 2022 17:11:42 +0800
Message-Id: <1657012303-6464-10-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add flexspi support, and enable the 8 bit TX/RX for the
mx25uw51345gxdi00 spi-nor flash.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 34 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 20 ++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 33e84c4e9ed8..69209b87d432 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -21,6 +21,23 @@ memory@80000000 {
 	};
 };
 
+&flexspi2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_flexspi2_ptd>;
+	pinctrl-1 = <&pinctrl_flexspi2_ptd>;
+	status = "okay";
+
+	mx25uw51345gxdi00: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &lpuart5 {
 	/* console */
 	pinctrl-names = "default", "sleep";
@@ -39,6 +56,23 @@ &usdhc0 {
 };
 
 &iomuxc1 {
+	pinctrl_flexspi2_ptd: flexspi2ptdgrp {
+		fsl,pins = <
+
+			MX8ULP_PAD_PTD12__FLEXSPI2_A_SS0_B	0x42
+			MX8ULP_PAD_PTD13__FLEXSPI2_A_SCLK	0x42
+			MX8ULP_PAD_PTD14__FLEXSPI2_A_DATA3	0x42
+			MX8ULP_PAD_PTD15__FLEXSPI2_A_DATA2	0x42
+			MX8ULP_PAD_PTD16__FLEXSPI2_A_DATA1	0x42
+			MX8ULP_PAD_PTD17__FLEXSPI2_A_DATA0	0x42
+			MX8ULP_PAD_PTD18__FLEXSPI2_A_DQS	0x42
+			MX8ULP_PAD_PTD19__FLEXSPI2_A_DATA7	0x42
+			MX8ULP_PAD_PTD20__FLEXSPI2_A_DATA6	0x42
+			MX8ULP_PAD_PTD21__FLEXSPI2_A_DATA5	0x42
+			MX8ULP_PAD_PTD22__FLEXSPI2_A_DATA4	0x42
+		>;
+	};
+
 	pinctrl_lpuart5: lpuart5grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTF14__LPUART5_TX	0x3
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 09f7364dd1d0..4f92c4d6e8c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -141,7 +141,8 @@ soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x40000000>;
+		ranges = <0x0 0x0 0x0 0x40000000>,
+			 <0x60000000 0x0 0x60000000 0x1000000>;
 
 		per_bridge3: bus@29000000 {
 			compatible = "simple-bus";
@@ -272,6 +273,23 @@ pcc4: clock-controller@29800000 {
 				#clock-cells = <1>;
 			};
 
+			flexspi2: spi@29810000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x29810000 0x10000>, <0x60000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_FLEXSPI2>,
+					 <&pcc4 IMX8ULP_CLK_FLEXSPI2>;
+				clock-names = "fspi", "fspi_en";
+				assigned-clocks = <&pcc4 IMX8ULP_CLK_FLEXSPI2>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV1>;
+				status = "disabled";
+			};
+
+
+
 			lpi2c6: i2c@29840000 {
 				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x29840000 0x10000>;
-- 
2.25.1

