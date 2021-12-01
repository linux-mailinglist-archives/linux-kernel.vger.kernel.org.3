Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D045464897
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347848AbhLAHeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:11 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:24300 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347625AbhLAHde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343813; x=1669879813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kvAdfKNAIogugWplbIBdAVZ++lLpbbwM6QsPjkcPCY4=;
  b=KKSBd0BW0g0C0XBC53b4mVnON34gRvSWjwLx2VtjwusJ1Qzvsofp/0rR
   zRnWB8QsUpirltHaYyo8X+tljX3nvrvt6AE8Kin8N6Tpfiwl0GOA5KCQJ
   baNp34U/+qN1VHYh7OkrC6py2KXxLc+99GeTcYfZ+/6G5HJxP90G2Qq7L
   QS20xxNQPjOYlerOo4U9xEQQ5zFAdfLdlVYO5L8QzS6YSqZAwWsxjsAPN
   33NX8ITt0la97dPgD6VoH8qRFiQDkE4S82Vuo9N+odm6KZwOzC/bxw+MN
   pHzoZnom+P9whD9NEV5UhT9eDzawOTGj2F2RKu/HAg2mcG3DnE5kMa51I
   A==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773245"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 08:30:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 08:30:05 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 08:30:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343805; x=1669879805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kvAdfKNAIogugWplbIBdAVZ++lLpbbwM6QsPjkcPCY4=;
  b=NORUg9sjPD30BfNeSYsg1IZZM4zz6Z8QQ78erZ6KpInxrgqhsj7GC7Mh
   It0hW/XPUJUfvCOY1AMNu65R5VK4psz7cO8A8IlnujorKguOaqwDKfasK
   390IHC7x4lPtXFAuqREUitHSKdmS2dax6MUltEA1zpvRHOsoCqk5CYyX9
   ua6ZZNniAZmSbs/6cfkl+gNWPviOb9GHOXKZIKyPpU35NuVxiMehH94j2
   dm+820ffz21lcIqpRvSWwaI7ivacs3evucSFHRiDWLV480cQB53DwIJIu
   ukec8zqMqTLu/P3T4CxahRuz5w/PCV2Bmye4n/+jKN3us9P36s8VTUF2D
   g==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773233"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 08:30:04 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B77FE28007C;
        Wed,  1 Dec 2021 08:30:03 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/7] arm64: dts: freescale: add initial device tree for TQMa8MQNL with i.MX8MN
Date:   Wed,  1 Dec 2021 08:29:46 +0100
Message-Id: <20211201072949.53947-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for TQMa8MQNL module on MBa8Mx board.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* Fixed name for audio-codec
* Use matrix instead of array for 'fsl,pins'

Changes in v2:
* Renamed codec -> audio_codec
* Fixed pinctrl node names
* Removed empty chosen node
* Removed regulator-always-on on non-switchable regulators
* Changed spi-tx-bus-width for spi-nor flash similar to commit 04aa946d57b2
  ("arm64: dts: imx8: change the spi-nor tx")

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts | 237 +++++++++++++
 .../boot/dts/freescale/imx8mn-tqma8mqnl.dtsi  | 322 ++++++++++++++++++
 3 files changed, 560 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 33c21322bf15..fa9499237e1e 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -50,6 +50,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mn-tqma8mqnl-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-venice-gw7902.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
new file mode 100644
index 000000000000..3f1e49bfe38f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2020-2021 TQ-Systems GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mn-tqma8mqnl.dtsi"
+#include "mba8mx.dtsi"
+
+/ {
+	model = "TQ-Systems GmbH i.MX8MN TQMa8MxNL on MBa8Mx";
+	compatible = "tq,imx8mn-tqma8mqnl-mba8mx", "tq,imx8mn-tqma8mqnl", "fsl,imx8mn";
+
+	aliases {
+		eeprom0 = &eeprom3;
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc1;
+		rtc0 = &pcf85063;
+		rtc1 = &snvs_rtc;
+	};
+
+	reg_usdhc2_vmmc: regulator-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100>;
+		off-on-delay-us = <12000>;
+	};
+};
+
+/* Located on TQMa8MxML-ADAP */
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0hub_sel>;
+
+	sel-usb-hub-hog {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
+&i2c1 {
+	expander2: gpio@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_vcc_3v3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_expander2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&sai3 {
+	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
+	clocks = <&clk IMX8MN_CLK_SAI3_IPG>, <&clk IMX8MN_CLK_DUMMY>,
+		 <&clk IMX8MN_CLK_SAI3_ROOT>, <&clk IMX8MN_CLK_DUMMY>,
+		 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_AUDIO_PLL1_OUT>,
+		 <&clk IMX8MN_AUDIO_PLL2_OUT>;
+};
+
+&tlv320aic3x04 {
+	clock-names = "mclk";
+	clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
+};
+
+&usbotg1 {
+	dr_mode = "host";
+	disable-over-current;
+	power-active-high;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <MX8MN_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x00000146>,
+			   <MX8MN_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x00000146>,
+			   <MX8MN_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x00000146>,
+			   <MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x00000146>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x00000146>,
+			   <MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x00000146>,
+			   <MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x00000146>,
+			   <MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x00000146>;
+	};
+
+	pinctrl_expander2: expander2grp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x94>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <MX8MN_IOMUXC_ENET_MDC_ENET1_MDC		0x40000002>,
+			   <MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO		0x40000002>,
+			   <MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x14>,
+			   <MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x14>,
+			   <MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x14>,
+			   <MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x14>,
+			   <MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x90>,
+			   <MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x90>,
+			   <MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x90>,
+			   <MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x90>,
+			   <MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x14>,
+			   <MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x90>,
+			   <MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x90>,
+			   <MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x14>;
+	};
+
+	pinctrl_gpiobutton: gpiobuttongrp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x84>,
+			   <MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x84>,
+			   <MX8MN_IOMUXC_SD1_CLK_GPIO2_IO0		0x84>;
+	};
+
+	pinctrl_gpioled: gpioledgrp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x84>,
+			   <MX8MN_IOMUXC_NAND_DQS_GPIO3_IO14		0x84>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001C4>,
+			   <MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001C4>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16		0x400001C4>,
+			   <MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17		0x400001C4>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001C4>,
+			   <MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001C4>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18		0x400001C4>,
+			   <MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19		0x400001C4>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO14_PWM3_OUT		0x14>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO15_PWM4_OUT		0x14>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <MX8MN_IOMUXC_SAI3_MCLK_SAI3_MCLK		0x94>,
+			   <MX8MN_IOMUXC_SAI3_RXC_SAI3_RX_BCLK		0x94>,
+			   <MX8MN_IOMUXC_SAI3_RXFS_SAI3_RX_SYNC		0x94>,
+			   <MX8MN_IOMUXC_SAI3_RXD_SAI3_RX_DATA0		0x94>,
+			   <MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC		0x94>,
+			   <MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0		0x94>,
+			   <MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK		0x94>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX		0x16>,
+			   <MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX		0x16>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX		0x16>,
+			   <MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX		0x16>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <MX8MN_IOMUXC_UART3_RXD_UART3_DCE_RX		0x16>,
+			   <MX8MN_IOMUXC_UART3_TXD_UART3_DCE_TX		0x16>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <MX8MN_IOMUXC_UART4_RXD_UART4_DCE_RX		0x16>,
+			   <MX8MN_IOMUXC_UART4_TXD_UART4_DCE_TX		0x16>;
+	};
+
+	pinctrl_usb0hub_sel: usb0hub-selgrp {
+		/* SEL_USB_HUB_B */
+		fsl,pins = <MX8MN_IOMUXC_SD1_CMD_GPIO2_IO1		0x84>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO12_USB1_OTG_PWR	0x84>,
+			   <MX8MN_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x84>,
+			   <MX8MN_IOMUXC_GPIO1_IO10_USB1_OTG_ID		0x1C4>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4>,
+			   <MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x84>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4>,
+			   <MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x84>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4>,
+			   <MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4>,
+			   <MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x84>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+		fsl,pins = <MX8MN_IOMUXC_SD2_CD_B_GPIO2_IO12		0x84>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
new file mode 100644
index 000000000000..9ea28941068d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2020-2021 TQ-Systems GmbH
+ */
+
+#include "imx8mn.dtsi"
+
+/ {
+	model = "TQ-Systems i.MX8MN TQMa8MxNL";
+	compatible = "tq,imx8mn-tqma8mqnl", "fsl,imx8mn";
+
+	memory@40000000 {
+		device_type = "memory";
+		/*  our minimum RAM config will be 1024 MiB */
+		reg = <0x00000000 0x40000000 0 0x40000000>;
+	};
+
+	/* e-MMC IO, needed for HS modes */
+	reg_vcc1v8: regulator-vcc1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "TQMA8MXNL_VCC1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_vcc3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "TQMA8MXNL_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* global autoconfigured region for contiguous allocations */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			/* 640 MiB */
+			size = <0 0x28000000>;
+			/*  1024 - 128 MiB, our minimum RAM config will be 1024 MiB */
+			alloc-ranges = <0 0x40000000 0 0x78000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2_reg>;
+};
+
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <84000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	sensor0: temperature-sensor-eeprom@1b {
+		compatible = "nxp,se97", "jedec,jc-42.4-temp";
+		reg = <0x1b>;
+	};
+
+	pca9450: pmic@25 {
+		compatible = "nxp,pca9450a";
+		reg = <0x25>;
+
+		/* PMIC PCA9450 PMIC_nINT GPIO1_IO08 */
+		pinctrl-0 = <&pinctrl_pmic>;
+		pinctrl-names = "default";
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			/* V_0V85_SOC: 0.85 .. 0.95 */
+			buck1_reg: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			/* VDD_ARM */
+			buck2_reg: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+				regulator-ramp-delay = <3125>;
+			};
+
+			/* V_0V85_GPU / DRAM: shall be equal to BUCK1 for i.MX8MN */
+			buck3_reg: BUCK3 {
+				regulator-name = "BUCK3";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			/* VCC3V3 -> VMMC, ... must not be changed */
+			buck4_reg: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V8 -> VQMMC, SPI-NOR, ... must not be changed */
+			buck5_reg: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V1 -> RAM, ... must not be changed */
+			buck6_reg: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V8_SNVS */
+			ldo1_reg: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_0V8_SNVS */
+			ldo2_reg: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V8_ANA */
+			ldo3_reg: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_0V9_MIPI */
+			ldo4_reg: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* VCC SD IO - switched using SD2 VSELECT */
+			ldo5_reg: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <7000>;
+	};
+
+	eeprom1: eeprom@53 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		read-only;
+		reg = <0x53>;
+		pagesize = <16>;
+	};
+
+	eeprom0: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc1v8>;
+	status = "okay";
+};
+
+/*
+ * Attention:
+ * wdog reset is routed to PMIC, PMIC must be preconfigured to force POR
+ * without LDO for SNVS. GPIO1_IO02 must not be used as GPIO.
+ */
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <MX8MN_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x84>,
+			   <MX8MN_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x84>,
+			   <MX8MN_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x84>,
+			   <MX8MN_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x84>,
+			   <MX8MN_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x84>,
+			   <MX8MN_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x84>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <MX8MN_IOMUXC_I2C1_SCL_I2C1_SCL		0x400001c4>,
+			   <MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c4>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <MX8MN_IOMUXC_I2C1_SCL_GPIO5_IO14	0x400001c4>,
+			   <MX8MN_IOMUXC_I2C1_SDA_GPIO5_IO15	0x400001c4>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x84>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x84>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d4>,
+			   <MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2>,
+			   <MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x84>,
+			   <MX8MN_IOMUXC_NAND_READY_B_USDHC3_RESET_B	0x84>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d2>,
+			   <MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2>,
+			   <MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x84>,
+			   <MX8MN_IOMUXC_NAND_READY_B_USDHC3_RESET_B	0x84>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d6>,
+			   <MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2>,
+			   <MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4>,
+			   <MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x84>,
+			   <MX8MN_IOMUXC_NAND_READY_B_USDHC3_RESET_B	0x84>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x84>;
+	};
+};
-- 
2.25.1

