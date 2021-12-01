Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5971546489A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347687AbhLAHeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:36 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:24263 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347528AbhLAHdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343832; x=1669879832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2e9ie0CHzuDB2vZHAHfkI3ejd1Yq4faTgnkrOP7rJlk=;
  b=FQaj9mShQY6UShktFiKh9rotiNQ6eeZPsQ0Ni9Wsa7JNZSGmsLSXdQT0
   9YY4PTD3vczio61r9xDSAbqnribheByP/nQankoGJ36boXR1zgh0cZX1P
   04BuPdELfs98IXBFXYXGsV75l13AZ3KMmI3EDef9+iqYUxMSYGIJDj9YE
   4NVlluCTE9Msp3Ov9+SB0uZ1a5pJFN8qTfcGCwDZHhSd6fGOJm8Xmx+ZC
   hnfUgJgLxq7rfE0AQye67LT9nCuBJR+WzUUaLao6nxEiaN4oWExBGN9pJ
   vIzlLxkck2qt3l9MPYHNMcqASFYgfJjele1QSLoTqhQo/yaCvvqGssRH+
   g==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773248"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 08:30:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 08:30:06 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 08:30:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343806; x=1669879806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2e9ie0CHzuDB2vZHAHfkI3ejd1Yq4faTgnkrOP7rJlk=;
  b=WrNjcm2OAkO9bnjewFINNXVqoBiONXXQfHUjpL73bvai36mKaf2NqQnf
   fyuAK0EuEenUBzVxGhFzGpts3ezL5+zkvnU9bAOhi0uKCzVFbHxg1WXpU
   VzQ/ZWPQWwoXhiatGSu2s0SNbmSWVMo4QxG4DspGBiOo/5lHqsOG+CTVR
   jzV5wb/0EHyeDNUsfRzvQ9LziX5Xen8BZuORTq0ydjBjzTjrQxhyT1P+j
   PA2ZWg0jPKpS8Hl7mZdWfP+TdhDyWQU78390qXNcjdBmKPI6PbBizYtZs
   KjVpkguwK8JXbLVsWm4ul87/o8sz8IDRtIpW7f5xh5LTeT3ifIBp0wWqg
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773239"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 08:30:04 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2BD81280075;
        Wed,  1 Dec 2021 08:30:04 +0100 (CET)
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
Subject: [PATCH v3 7/7] arm64: dts: freescale: add initial device tree for TQMa8Mx with i.MX8M
Date:   Wed,  1 Dec 2021 08:29:48 +0100
Message-Id: <20211201072949.53947-8-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for TQMa8Mx module on MBa8Mx board.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* Fixed name for audio-codec
* Use matrix instead of array for 'fsl,pins'
* Removed TODO regarding unsupported USB over-current polarity

Changes in v2:
* Renamed codec -> audio_codec
* Moved VPU enable from MB+SOM DT to SOM DT
* Fixed pinctrl node names
* Removed empty chosen node
* Removed regulator-always-on on non-switchable regulators
* Enable GPU node
* Add "fixed-clock" subnode for pcf85063
  See commit 4c8a7b80d5f3 ("rtc: pcf85063: add support for fixed clock")
  for details

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 349 +++++++++++++++++
 .../boot/dts/freescale/imx8mq-tqma8mq.dtsi    | 360 ++++++++++++++++++
 3 files changed, 710 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index fa9499237e1e..db24ba3e3c6b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r4.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mq-tqma8mq-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-mnt-reform2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
new file mode 100644
index 000000000000..d7660eab68b9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2019-2021 TQ-Systems GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mq-tqma8mq.dtsi"
+#include "mba8mx.dtsi"
+
+/ {
+	model = "TQ-Systems GmbH i.MX8MQ TQMa8MQ on MBa8Mx";
+	compatible = "tq,imx8mq-tqma8mq-mba8mx", "tq,imx8mq-tqma8mq", "fsl,imx8mq";
+
+	aliases {
+		eeprom0 = &eeprom3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		rtc0 = &pcf85063;
+		rtc1 = &snvs_rtc;
+	};
+
+	extcon_usbotg: extcon-usbotg0 {
+		compatible = "linux,extcon-usb-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbcon0>;
+		id-gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+	};
+
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	pcie1_refclk: pcie1-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	reg_otg_vbus: regulator-otg-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_regotgvbus>;
+		regulator-name = "MBA8MQ_OTG_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&btn2 {
+	gpios = <&gpio3 17 GPIO_ACTIVE_LOW>;
+};
+
+&gpio_leds {
+	led3 {
+		label = "led3";
+		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&i2c1 {
+	expander2: gpio@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_vcc_3v3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_expander>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		mpcie-rst-hog {
+			gpio-hog;
+			gpios = <13 0>;
+			output-high;
+			line-name = "MPCIE_RST#";
+		};
+	};
+};
+
+&irqsteer {
+	status = "okay";
+};
+
+&led2 {
+	gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie0 {
+	reset-gpio = <&expander0 14 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
+		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
+		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
+		 <&pcie0_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	epdev_on-supply = <&reg_vcc_3v3>;
+	hard-wired = <1>;
+	status = "okay";
+};
+
+/*
+ * miniPCIe, also usable for cards with USB. Therefore configure the reset as
+ * static gpio hog.
+ */
+&pcie1 {
+	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
+		 <&clk IMX8MQ_CLK_PCIE2_AUX>,
+		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
+		 <&pcie1_refclk>;
+	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	epdev_on-supply = <&reg_vcc_3v3>;
+	hard-wired = <1>;
+	status = "okay";
+};
+
+&sai3 {
+	assigned-clocks = <&clk IMX8MQ_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
+	clocks = <&clk IMX8MQ_CLK_SAI3_IPG>, <&clk IMX8MQ_CLK_DUMMY>,
+		<&clk IMX8MQ_CLK_SAI3_ROOT>, <&clk IMX8MQ_CLK_DUMMY>,
+		<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_AUDIO_PLL1_OUT>,
+		<&clk IMX8MQ_AUDIO_PLL2_OUT>;
+};
+
+&tlv320aic3x04 {
+	clock-names = "mclk";
+	clocks = <&clk IMX8MQ_CLK_SAI3_ROOT>;
+};
+
+&uart1 {
+	assigned-clocks = <&clk IMX8MQ_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
+};
+
+&uart2 {
+	assigned-clocks = <&clk IMX8MQ_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
+};
+
+/* console */
+&uart3 {
+	assigned-clocks = <&clk IMX8MQ_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MQ_CLK_25M>;
+};
+
+&usb3_phy0 {
+	vbus-supply = <&reg_otg_vbus>;
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	/* we implement dual role but not full featured OTG */
+	extcon = <&extcon_usbotg>;
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	/* OC not supported due to non matching active polarity */
+	disable-over-current;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <MX8MQ_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x0000004e>,
+			   <MX8MQ_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x0000004e>,
+			   <MX8MQ_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x0000004e>,
+			   <MX8MQ_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x0000004e>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <MX8MQ_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x0000004e>,
+			   <MX8MQ_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x0000004e>,
+			   <MX8MQ_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x0000004e>,
+			   <MX8MQ_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x0000004e>;
+	};
+
+	pinctrl_expander: expandergrp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9		0xd6>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC		0x3>,
+			   <MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO		0x23>,
+			   <MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f>,
+			   <MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f>,
+			   <MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f>,
+			   <MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f>,
+			   <MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91>,
+			   <MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91>,
+			   <MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91>,
+			   <MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91>,
+			   <MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f>,
+			   <MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91>,
+			   <MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91>,
+			   <MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f>;
+	};
+
+	pinctrl_gpiobutton: gpiobuttongrp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x41>,
+			   <MX8MQ_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x41>,
+			   <MX8MQ_IOMUXC_NAND_WE_B_GPIO3_IO17		0x41>;
+	};
+
+	pinctrl_gpioled: gpioledgrp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x41>,
+			   <MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x41>,
+			   <MX8MQ_IOMUXC_NAND_READY_B_GPIO3_IO16	0x41>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL		0x40000067>,
+			   <MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA		0x40000067>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <MX8MQ_IOMUXC_I2C2_SCL_GPIO5_IO16		0x40000067>,
+			   <MX8MQ_IOMUXC_I2C2_SDA_GPIO5_IO17		0x40000067>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL		0x40000067>,
+			   <MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA		0x40000067>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <MX8MQ_IOMUXC_I2C3_SCL_GPIO5_IO18		0x40000067>,
+			   <MX8MQ_IOMUXC_I2C3_SDA_GPIO5_IO19		0x40000067>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO14_PWM3_OUT		0x16>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO15_PWM4_OUT		0x16>;
+	};
+
+	pinctrl_regotgvbus: reggotgvbusgrp {
+		/* USB1 OTG PWR as GPIO */
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x06>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0xc1>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <MX8MQ_IOMUXC_SAI3_MCLK_SAI3_MCLK		0xd6>,
+			   <MX8MQ_IOMUXC_SAI3_RXC_SAI3_RX_BCLK		0xd6>,
+			   <MX8MQ_IOMUXC_SAI3_RXFS_SAI3_RX_SYNC		0xd6>,
+			   <MX8MQ_IOMUXC_SAI3_RXD_SAI3_RX_DATA0		0xd6>,
+			   <MX8MQ_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC		0xd6>,
+			   <MX8MQ_IOMUXC_SAI3_TXD_SAI3_TX_DATA0		0xd6>,
+			   <MX8MQ_IOMUXC_SAI3_TXC_SAI3_TX_BCLK		0xd6>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x79>,
+			   <MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x79>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x79>,
+			   <MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x79>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX		0x79>,
+			   <MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX		0x79>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <MX8MQ_IOMUXC_UART4_RXD_UART4_DCE_RX		0x79>,
+			   <MX8MQ_IOMUXC_UART4_TXD_UART4_DCE_TX		0x79>;
+	};
+
+	pinctrl_usbcon0: usb0congrp {
+		/* ID: floating / high: device, low: host -> use PU */
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO10_GPIO1_IO10		0xe6>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x83>,
+			   <MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xc3>,
+			   <MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3>,
+			   <MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3>,
+			   <MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3>,
+			   <MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3>,
+			   <MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc1>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x85>,
+			   <MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xc5>,
+			   <MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5>,
+			   <MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5>,
+			   <MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5>,
+			   <MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5>,
+			   <MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc1>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x9f>,
+			   <MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD		0xc7>,
+			   <MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7>,
+			   <MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7>,
+			   <MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7>,
+			   <MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7>,
+			   <MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0xc1>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
+		fsl,pins = <MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12		0x41>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
new file mode 100644
index 000000000000..8aedcddfeab8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2019-2021 TQ-Systems GmbH
+ */
+
+#include "imx8mq.dtsi"
+
+/ {
+	model = "TQ-Systems GmbH i.MX8MQ TQMa8MQ";
+	compatible = "tq,imx8mq-tqma8mq", "fsl,imx8mq";
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
+		regulator-name = "TQMA8MX_VCC1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_vcc3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "TQMA8MX_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_vdd_arm: regulator-vdd-arm {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_dvfs>;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-name = "TQMa8Mx_DVFS";
+		regulator-type = "voltage";
+		regulator-settling-time-us = <150000>;
+		gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		states = <900000 0x1 1000000 0x0>;
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
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&gpu {
+	status = "okay";
+};
+
+&pgc_gpu {
+	power-supply = <&sw1a_reg>;
+};
+
+&pgc_vpu {
+	power-supply = <&sw1c_reg>;
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
+	pfuze100: pmic@8 {
+		compatible = "fsl,pfuze100";
+		fsl,pfuze-support-disable-sw;
+		reg = <0x8>;
+
+		regulators {
+			/* VDD_GPU */
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <825000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			/* VDD_VPU */
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <825000>;
+				regulator-max-microvolt = <1100000>;
+			};
+
+			/* NVCC_DRAM */
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			/* VDD_DRAM */
+			sw3a_reg: sw3ab {
+				regulator-min-microvolt = <825000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
+			/* 1.8 V for QSPI NOR, e-MMC IO, must not be changed */
+			nvcc_1v8_reg: sw4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-always-on;
+			};
+
+			/* not used */
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			/* VDD_PHY_0V9 */
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <975000>;
+				regulator-always-on;
+			};
+
+			/* VDD_PHY_1V8 */
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1675000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-always-on;
+			};
+
+			/* VDDA_1V8 */
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1625000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+			};
+
+			/* VDD_PHY_3V3 */
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <3075000>;
+				regulator-max-microvolt = <3625000>;
+				regulator-always-on;
+			};
+
+			/* not used */
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+
+	sensor0: temperature-sensor-eeprom@1b {
+		compatible = "nxp,se97", "jedec,jc-42.4-temp";
+		reg = <0x1b>;
+	};
+
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-names = "irq";
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		quartz-load-femtofarads = <7000>;
+
+		clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
+	eeprom1: eeprom@53 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <16>;
+		read-only;
+	};
+
+	eeprom0: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+};
+
+&pcie0 {
+	/* 3.3V supply, only way to switch on internal 1.8V supply using GPR */
+	vph-supply = <&vgen5_reg>;
+};
+
+&pcie1 {
+	/* 3.3V supply, only way to switch on internal 1.8V supply using GPR */
+	vph-supply = <&vgen5_reg>;
+};
+
+&qspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	assigned-clocks = <&clk IMX8MQ_CLK_QSPI>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_266M>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <84000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc1v8>;
+	status = "okay";
+};
+
+&vpu {
+	status = "okay";
+};
+
+/* Attention: wdog reset forcing POR needs baseboard support */
+&wdog1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_dvfs: dvfsgrp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x16>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL		0x4000007f>,
+			   <MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA		0x4000007f>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <MX8MQ_IOMUXC_I2C1_SCL_GPIO5_IO14		0x40000074>,
+			   <MX8MQ_IOMUXC_I2C1_SDA_GPIO5_IO15		0x40000074>;
+	};
+
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x97>,
+			   <MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x82>,
+			   <MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x97>,
+			   <MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x97>,
+			   <MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x97>,
+			   <MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x97>;
+	};
+
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x41>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK		0x83>,
+			   <MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3>,
+			   <MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE	0x83>,
+			   <MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B	0xc1>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK		0x85>,
+			   <MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5>,
+			   <MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE	0x85>,
+			   <MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B	0xc1>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK		0x87>,
+			   <MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7>,
+			   <MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE	0x87>,
+			   <MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B	0xc1>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6>;
+	};
+};
-- 
2.25.1

