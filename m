Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9316E467737
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380791AbhLCMZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:25:14 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50564 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380794AbhLCMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:24:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3CLT8J019372;
        Fri, 3 Dec 2021 06:21:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638534089;
        bh=UpLv8JbOoQDBZzN1Kvj0tHpf148cW00g+csa1c7eL58=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GGAtgqb4c8w+boX4OsWyEFkJvh/C8h9ME8tXlNPtSvpwTooOmvxsKjxOBxEA46eat
         SEqrH2I2ud2B6Q3lJjPC/pI9aEDN2aPXpSwQAYujgp3lnrqS9P6pqEsdInYVP/Hb95
         XTsDbNazK2nm6Gu6qkaSkd7iZr5fCHkhPN/A0rkY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3CLTY9109297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 06:21:29 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 06:21:29 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 06:21:29 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3CLBWQ011119;
        Fri, 3 Dec 2021 06:21:26 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 5/5] arch: arm64: ti: Add support J721S2 Common Processor Board
Date:   Fri, 3 Dec 2021 17:51:10 +0530
Message-ID: <20211203122110.16736-6-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203122110.16736-1-a-govindraju@ti.com>
References: <20211203122110.16736-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EVM architecture for J721S2 is similar to that of J721E and J7200. It
is as follows,

+------------------------------------------------------+
|   +-------------------------------------------+      |
|   |                                           |      |
|   |        Add-on Card 1 Options              |      |
|   |                                           |      |
|   +-------------------------------------------+      |
|                                                      |
|                                                      |
|                     +-------------------+            |
|                     |                   |            |
|                     |   SOM             |            |
|  +--------------+   |                   |            |
|  |              |   |                   |            |
|  |  Add-on      |   +-------------------+            |
|  |  Card 2      |                                    |    Power Supply
|  |  Options     |                                    |    |
|  |              |                                    |    |
|  +--------------+                                    | <---
+------------------------------------------------------+
                                 Common Processor Board

Common Processor board is the baseboard that contains most of the actual
connectors, power supply etc. The System on Module (SoM) is plugged on to
the common processor baord. Therefore, add support for peripherals brought
out in the common processor board.

Common Processor Board: https://www.ti.com/tool/J721EXCPXEVM

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 421 ++++++++++++++++++
 2 files changed, 423 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 71f6097d4621..90be511bc4d0 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -17,5 +17,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 
 dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
 
+dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
+
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
new file mode 100644
index 000000000000..a5a24f9f46c5
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Common Processor Board: https://www.ti.com/tool/J721EXCPXEVM
+ */
+
+/dts-v1/;
+
+#include "k3-j721s2-som-p0.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	compatible = "ti,j721s2-evm", "ti,j721s2";
+	model = "Texas Instruments J721S2 EVM";
+
+	chosen {
+		stdout-path = "serial10:115200n8";
+		bootargs = "console=ttyS10,115200n8 earlycon=ns16550a,mmio32,2880000";
+	};
+
+	evm_12v0: fixedregulator-evm12v0 {
+		/* main supply */
+		compatible = "regulator-fixed";
+		regulator-name = "evm_12v0";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: fixedregulator-vsys3v3 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_5v0: fixedregulator-vsys5v0 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&evm_12v0>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: fixedregulator-sd {
+		/* Output of TPS22918 */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&vsys_3v3>;
+		gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	vdd_sd_dv: gpio-regulator-TLV71033 {
+		/* Output of TLV71033 */
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 8 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	transceiver1: can-phy1 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 69 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&wkup_gpio0 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
+	};
+
+};
+
+&main_pmx0 {
+	main_uart8_pins_default: main-uart8-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x040, PIN_INPUT, 14) /* (AC28) MCASP0_AXR0.UART8_CTSn */
+			J721S2_IOPAD(0x044, PIN_OUTPUT, 14) /* (Y26) MCASP0_AXR1.UART8_RTSn */
+			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
+			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
+		>;
+	};
+
+	main_i2c3_pins_default: main-i2c3-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x064, PIN_INPUT_PULLUP, 13) /* (W28) MCAN0_TX.I2C3_SCL */
+			J721S2_IOPAD(0x060, PIN_INPUT_PULLUP, 13) /* (AC27) MCASP2_AXR1.I2C3_SDA */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
+			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
+			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
+			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
+			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
+			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
+			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
+			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
+		>;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
+		>;
+	};
+};
+
+&wkup_pmx0 {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
+			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
+			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
+			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
+			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
+			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
+			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
+			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
+			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
+			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
+			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
+			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
+			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+		>;
+	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0bc, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
+			J721S2_WKUP_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0c0, PIN_INPUT, 7) /* (D26) WKUP_GPIO0_0 */
+			J721S2_WKUP_IOPAD(0x0a8, PIN_INPUT, 7) /* (B25) MCU_SPI0_D1.WKUP_GPIO0_69 */
+		>;
+	};
+
+	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
+		>;
+	};
+};
+
+&main_gpio2 {
+	status = "disabled";
+};
+
+&main_gpio4 {
+	status = "disabled";
+};
+
+&main_gpio6 {
+	status = "disabled";
+};
+
+&wkup_gpio1 {
+	status = "disabled";
+};
+
+&wkup_uart0 {
+	status = "reserved";
+};
+
+&main_uart0 {
+	status = "disabled";
+};
+
+&main_uart1 {
+	status = "disabled";
+};
+
+&main_uart2 {
+	status = "disabled";
+};
+
+&main_uart3 {
+	status = "disabled";
+};
+
+&main_uart4 {
+	status = "disabled";
+};
+
+&main_uart5 {
+	status = "disabled";
+};
+
+&main_uart6 {
+	status = "disabled";
+};
+
+&main_uart7 {
+	status = "disabled";
+};
+
+&main_uart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart8_pins_default>;
+	/* Shared with TFA on this platform */
+	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
+};
+
+&main_uart9 {
+	status = "disabled";
+};
+
+&main_i2c0 {
+	clock-frequency = <400000>;
+
+	exp1: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "PCIE_2L_MODE_SEL", "PCIE_2L_PERSTZ", "PCIE_2L_RC_RSTZ",
+				  "PCIE_2L_EP_RST_EN", "PCIE_1L_MODE_SEL", "PCIE_1L_PERSTZ",
+				  "PCIE_1L_RC_RSTZ", "PCIE_1L_EP_RST_EN", "PCIE_2L_PRSNT#",
+				  "PCIE_1L_PRSNT#", "CDCI1_OE1/OE4", "CDCI1_OE2/OE3", "EXP_MUX1",
+				  "EXP_MUX2", "EXP_MUX3", "GESI_EXP_PHY_RSTz";
+	};
+
+	exp2: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "APPLE_AUTH_RSTZ", "MLB_RSTZ", "GPIO_USD_PWR_EN", "USBC_PWR_EN",
+				  "USBC_MODE_SEL1", "USBC_MODE_SEL0", "MCAN0_EN", "MCAN0_STB#",
+				  "MUX_SPAREMUX_SPARE", "MCASP/TRACE_MUX_S0", "MCASP/TRACE_MUX_S1",
+				  "MLB_MUX_SEL", "MCAN_MUX_SEL", "MCASP2/SPI3_MUX_SEL", "PCIe_CLKREQn_MUX_SEL",
+				  "CDCI2_RSTZ", "ENET_EXP_PWRDN", "ENET_EXP_RESETZ", "ENET_I2CMUX_SEL",
+				  "ENET_EXP_SPARE2", "M2PCIE_RTSZ", "USER_INPUT1", "USER_LED1", "USER_LED2";
+	};
+};
+
+&main_i2c1 {
+	status = "disabled";
+};
+
+&main_i2c2 {
+	status = "disabled";
+};
+
+&main_i2c3 {
+	status = "disabled";
+};
+
+&main_i2c4 {
+	status = "disabled";
+};
+
+&main_i2c5 {
+	status = "disabled";
+};
+
+&main_i2c6 {
+	status = "disabled";
+};
+
+&main_sdhci0 {
+	/* eMMC */
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&main_sdhci1 {
+	/* SD card */
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	pinctrl-names = "default";
+	disable-wp;
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+};
+
+&mcu_cpsw {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+};
+
+&davinci_mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy0>;
+};
+
+&mcu_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan0 {
+	status = "disabled";
+};
+
+&main_mcan1 {
+	status = "disabled";
+};
+
+&main_mcan2 {
+	status = "disabled";
+};
+
+&main_mcan3 {
+	status = "disabled";
+};
+
+&main_mcan4 {
+	status = "disabled";
+};
+
+&main_mcan5 {
+	status = "disabled";
+};
+
+&main_mcan6 {
+	status = "disabled";
+};
+
+&main_mcan7 {
+	status = "disabled";
+};
+
+&main_mcan8 {
+	status = "disabled";
+};
+
+&main_mcan9 {
+	status = "disabled";
+};
+
+&main_mcan10 {
+	status = "disabled";
+};
+
+&main_mcan11 {
+	status = "disabled";
+};
+
+&main_mcan12 {
+	status = "disabled";
+};
+
+&main_mcan13 {
+	status = "disabled";
+};
+
+&main_mcan14 {
+	status = "disabled";
+};
+
+&main_mcan15 {
+	status = "disabled";
+};
+
+&main_mcan17 {
+	status = "disabled";
+};
-- 
2.17.1

