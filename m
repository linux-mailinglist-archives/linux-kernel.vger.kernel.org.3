Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C022483F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiADJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:41:36 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36517 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiADJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641289293; x=1672825293;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=DgJ6Xuh2PHoRZ8rZsp93rnKZTsUZWQyUENbe2AOtC+o=;
  b=kNBCgbvi71wSy0ZWjQRAecmG3R1rS2jK6qtK6PGhK4FW1yg630+1J//9
   doIThN7YtqI2Bn4QnPIeupY/kdZIviOCQcjk3QJ+BIcuFeQ1TvOk/juhF
   dWo3ew/P7wSgK2Z+2gL4V52WbC/7HZqrt3F1xgqU8FA73yEkKX40aRGow
   g0pdmm2uW5Fng7QkXAnMjOQv6QzQNU1EhuawQv7wmRD/GmLtVs3PECC4x
   l8GOApqgxpKFgDghhHjjQC8j7q6PLtRGfwN4OBt8lHiqoNmsrXQVEWP30
   KfvmrTShFhq74+kldmoZDq+R7cN7NV7igk7yhZZTKmCpVX50PRL6zASC7
   w==;
IronPort-SDR: aVH4hRmGIOv+FA2MA8xoCKCgDyax0yQephhlbpQ7sspddauNsTOR4ftGbXa22v6vnptc0CiNRv
 yiZwsAnq5hXmn/JFlKr4GWaQYfhozM8fewbpB36Co+J/yRqta4NCpo1QL2koZIM4XYpaLaQFo4
 MuKkr3hu/J136RpBJ3+Nnut2UDTTom5h8yEil9EKI7r5JVnwb05QkL/WTwr5V5rGcaRouG/pW8
 6InPNxE7l+cbGuwsFmtUL+sMqzWmocxN9q9AB9crcDQYK0vOBCPmN7wogrFTB2NH1EALeGKtpe
 XQHDI3Qw349uBUFBtQKSqR6C
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="144257295"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jan 2022 02:41:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 4 Jan 2022 02:41:32 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 4 Jan 2022 02:41:29 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>
CC:     <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Manohar.Puri@microchip.com>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v2] ARM: dts: add DT for lan966x SoC and 2-port board pcb8291
Date:   Tue, 4 Jan 2022 15:11:13 +0530
Message-ID: <20220104094113.3338-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic DT for Microchip lan966x SoC and associated board
pcb8291(2-port EVB). Adds peripherals required to allow booting: IRQs,
clocks, timers, memory, flexcoms, GPIOs. Also adds other peripherals like
crypto(AES,SHA), DMA and watchdog.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v1 -> v2:
- Moved flx3 usart0 node to dtsi file.
- Removed status="okay" for dma0 to maintain consistency across nodes
  (which means enabling dma0 by default)

 arch/arm/boot/dts/Makefile            |   2 +
 arch/arm/boot/dts/lan966x.dtsi        | 243 ++++++++++++++++++++++++++
 arch/arm/boot/dts/lan966x_pcb8291.dts |  49 ++++++
 3 files changed, 294 insertions(+)
 create mode 100644 arch/arm/boot/dts/lan966x.dtsi
 create mode 100644 arch/arm/boot/dts/lan966x_pcb8291.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..dc1bd216ed58 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -723,6 +723,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 dtb-$(CONFIG_SOC_IMX7ULP) += \
 	imx7ulp-com.dtb \
 	imx7ulp-evk.dtb
+dtb-$(CONFIG_SOC_LAN966) += \
+	lan966x_pcb8291.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
new file mode 100644
index 000000000000..bc9084752409
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * lan966x.dtsi - Device Tree Include file for Microchip LAN966x family SoC
+ *
+ * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
+ *
+ * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/dma/at91.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/microchip,lan966x.h>
+
+/ {
+	model = "Microchip LAN966x family SoC";
+	compatible = "microchip,lan966x";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			clock-frequency = <600000000>;
+			reg = <0x0>;
+		};
+	};
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;  /* 1GB */
+	};
+
+	clocks {
+		sys_clk: sys_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <162500000>;
+		};
+
+		cpu_clk: cpu_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <600000000>;
+		};
+
+		ddr_clk: ddr_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <300000000>;
+		};
+
+		nic_clk: nic_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+	};
+
+	clks: clock-controller@e00c00a8 {
+		compatible = "microchip,lan966x-gck";
+		#clock-cells = <1>;
+		clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+		clock-names = "cpu", "ddr", "sys";
+		reg = <0xe00c00a8 0x38>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <37500000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		flx0: flexcom@e0040000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0040000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0040000 0x800>;
+			status = "disabled";
+		};
+
+		flx1: flexcom@e0044000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0044000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0044000 0x800>;
+			status = "disabled";
+		};
+
+		trng: trng@e0048000 {
+			compatible = "atmel,at91sam9g45-trng";
+			reg = <0xe0048000 0x100>;
+			clocks = <&nic_clk>;
+			status = "disabled";
+		};
+
+		aes: aes@e004c000 {
+			compatible = "atmel,at91sam9g46-aes";
+			reg = <0xe004c000 0x100>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(13)>,
+			       <&dma0 AT91_XDMAC_DT_PERID(12)>;
+			dma-names = "rx", "tx";
+			clocks = <&nic_clk>;
+			clock-names = "aes_clk";
+		};
+
+		flx2: flexcom@e0060000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0060000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0060000 0x800>;
+			status = "disabled";
+		};
+
+		flx3: flexcom@e0064000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0064000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0064000 0x800>;
+			status = "disabled";
+
+			usart0: serial@200 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&nic_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+		};
+
+		dma0: dma-controller@e0068000 {
+			compatible = "microchip,sama7g5-dma";
+			reg = <0xe0068000 0x1000>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&nic_clk>;
+			clock-names = "dma_clk";
+		};
+
+		sha: sha@e006c000 {
+			compatible = "atmel,at91sam9g46-sha";
+			reg = <0xe006c000 0xec>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(14)>;
+			dma-names = "tx";
+			clocks = <&nic_clk>;
+			clock-names = "sha_clk";
+		};
+
+		flx4: flexcom@e0070000 {
+			compatible = "atmel,sama5d2-flexcom";
+			reg = <0xe0070000 0x100>;
+			clocks = <&clks GCK_ID_FLEXCOM4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe0070000 0x800>;
+			status = "disabled";
+		};
+
+		timer0: timer@e008c000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xe008c000 0x400>;
+			clocks = <&nic_clk>;
+			clock-names = "timer";
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		watchdog: watchdog@e0090000 {
+			compatible = "snps,dw-wdt";
+			reg = <0xe0090000 0x1000>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&nic_clk>;
+		};
+
+		can0: can@e081c000 {
+			compatible = "bosch,m_can";
+			reg = <0xe081c000 0xfc>, <0x00100000 0x4000>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&clks GCK_ID_MCAN0>, <&clks GCK_ID_MCAN0>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&clks GCK_ID_MCAN0>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x0 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
+		gpio: pinctrl@e2004064 {
+			compatible = "microchip,lan966x-pinctrl";
+			reg = <0xe2004064 0xb4>,
+			    <0xe2010024 0x138>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&gpio 0 0 78>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+		};
+
+		gic: interrupt-controller@e8c11000 {
+			compatible = "arm,gic-400", "arm,cortex-a7-gic";
+			#interrupt-cells = <3>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			reg = <0xe8c11000 0x1000>,
+			      <0xe8c12000 0x2000>,
+			      <0xe8c14000 0x2000>,
+			      <0xe8c16000 0x2000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/lan966x_pcb8291.dts b/arch/arm/boot/dts/lan966x_pcb8291.dts
new file mode 100644
index 000000000000..3ff86f15ea3d
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x_pcb8291.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * lan966x_pcb8291.dts - Device Tree file for PCB8291
+ */
+/dts-v1/;
+#include "lan966x.dtsi"
+
+/ {
+	model = "Microchip EVB - LAN9662";
+	compatible = "microchip,lan9662-pcb8291", "microchip,lan9662", "microchip,lan966";
+};
+
+&gpio {
+	fc_shrd7_pins: fc_shrd7-pins {
+		pins = "GPIO_49";
+		function = "fc_shrd7";
+	};
+
+	fc_shrd8_pins: fc_shrd8-pins {
+		pins = "GPIO_54";
+		function = "fc_shrd8";
+	};
+
+	fc3_b_pins: fcb3-spi-pins {
+		/* SCK, RXD, TXD */
+		pins = "GPIO_51", "GPIO_52", "GPIO_53";
+		function = "fc3_b";
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&flx3 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	usart0: serial@200 {
+		pinctrl-0 = <&fc3_b_pins>, <&fc_shrd7_pins>, <&fc_shrd8_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+};
+
+&trng {
+	status = "okay";
+};
+
-- 
2.17.1

