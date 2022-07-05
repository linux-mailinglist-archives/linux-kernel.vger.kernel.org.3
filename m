Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E787566624
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiGEJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGEJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:27:15 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BBBE0D1;
        Tue,  5 Jul 2022 02:27:08 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F0B31A0AE4;
        Tue,  5 Jul 2022 11:27:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE2DF1A08BC;
        Tue,  5 Jul 2022 11:27:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8CA151802204;
        Tue,  5 Jul 2022 17:27:03 +0800 (+08)
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
Subject: [PATCH 11/11] arm64: dts: imx8qm/imx8qxp: add flexspi support
Date:   Tue,  5 Jul 2022 17:11:43 +0800
Message-Id: <1657012303-6464-11-git-send-email-haibo.chen@nxp.com>
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
spi-nor device.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 17 ++++++++-
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 38 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 38 +++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 6446e6df7a9a..1f3d225e64ec 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -11,7 +11,8 @@ lsio_subsys: bus@5d000000 {
 	compatible = "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
+	ranges = <0x5d000000 0x0 0x5d000000 0x1000000>,
+		 <0x08000000 0x0 0x08000000 0x10000000>;
 
 	lsio_mem_clk: clock-lsio-mem {
 		compatible = "fixed-clock";
@@ -107,6 +108,20 @@ lsio_gpio7: gpio@5d0f0000 {
 		power-domains = <&pd IMX_SC_R_GPIO_7>;
 	};
 
+	flexspi0: spi@5d120000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,imx8qxp-fspi";
+		reg = <0x5d120000 0x10000>, <0x08000000 0x10000000>;
+		reg-names = "fspi_base", "fspi_mmap";
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX_SC_R_FSPI_0 IMX_SC_PM_CLK_PER>,
+			 <&clk IMX_SC_R_FSPI_0 IMX_SC_PM_CLK_PER>;
+		clock-names = "fspi", "fspi_en";
+		power-domains = <&pd IMX_SC_R_FSPI_0>;
+		status = "disabled";
+	};
+
 	lsio_mu0: mailbox@5d1b0000 {
 		reg = <0x5d1b0000 0x10000>;
 		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index ce9d3f0b98fc..ce78f494c7d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -67,6 +67,23 @@ ethphy1: ethernet-phy@1 {
 	};
 };
 
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	nxp,fspi-dll-slvdly = <4>;
+	status = "okay";
+
+	flash0: mt35xu512aba@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -107,6 +124,27 @@ IMX8QM_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
+			IMX8QM_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
+			IMX8QM_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
+			IMX8QM_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
+			IMX8QM_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
+			IMX8QM_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
+			IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B     0x06000021
+			IMX8QM_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
+			IMX8QM_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
+			IMX8QM_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
+			IMX8QM_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
+			IMX8QM_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
+			IMX8QM_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
+			IMX8QM_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
+			IMX8QM_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
+			IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 07d8dd8160f6..15d13a9d545f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -53,6 +53,23 @@ ethphy0: ethernet-phy@0 {
 	};
 };
 
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	nxp,fspi-dll-slvdly = <4>;
+	status = "okay";
+
+	flash0: mt35xu512aba@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -241,6 +258,27 @@ IMX8QXP_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
+			IMX8QXP_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
+			IMX8QXP_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
+			IMX8QXP_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
+			IMX8QXP_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
+			IMX8QXP_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
+			IMX8QXP_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B     0x06000021
+			IMX8QXP_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
+			IMX8QXP_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
+			IMX8QXP_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
+			IMX8QXP_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
+			IMX8QXP_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
+			IMX8QXP_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
+			IMX8QXP_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
+			IMX8QXP_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
+			IMX8QXP_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
+		>;
+	};
+
 	pinctrl_ioexp_rst: ioexprstgrp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SDO_LSIO_GPIO1_IO01			0x06000021
-- 
2.25.1

