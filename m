Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0CF4B5E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiBNXOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:14:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiBNXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:14:47 -0500
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3241B10FC;
        Mon, 14 Feb 2022 15:14:38 -0800 (PST)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nJkYA-00AkNe-57; Mon, 14 Feb 2022 23:14:30 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/4] arm64: dts: imx8mm-venice-gw73xx-0x: add dt overlays for serial modes
Date:   Mon, 14 Feb 2022 15:14:21 -0800
Message-Id: <20220214231424.30927-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220214231424.30927-1-tharvey@gateworks.com>
References: <20220214231424.30927-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8mm-venice-gw73xx-0x som+baseboard combination has a multi-protocol
RS-232/RS-485/RS-422 transceiver to an off-board connector which
can be configured in a number of ways via UART and GPIO configuration.

The default configuration per the imx8mm-venice-gw73xx-0x dts is for
UART2 TX/RX and UART4 TX/RX to be available as RS-232:
 J15.1 UART2 TX out
 J15.2 UART2 RX in
 J15.3 UART4 TX out
 J15.4 UART4 RX in
 J15.5 GND

Add dt overlays to allow additional the modes of operation:

rs232-rts (UART2 RS-232 with RTS/CTS hardware flow control)
 J15.1 TX out
 J15.2 RX in
 J15.3 RTS out
 J15.4 CTS in
 J15.5 GND

rs485 (UART2 RS-485 half duplex)
 J15.1 TXRX-
 J15.2 N/C
 J15.3 TXRX+
 J15.4 N/C
 J15.5 GND

rs422 (UART2 RS-422 full duplex)
 J15.1 TX-
 J15.2 RX+
 J15.3 TX+
 J15.4 RX-
 J15.5 GND

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3: use overlay target for simplicity
v2: fixed typo: s/uast/uart/
---
 arch/arm64/boot/dts/freescale/Makefile        |  8 +++
 .../imx8mm-venice-gw73xx-0x-rs232-rts.dts     | 53 ++++++++++++++++
 .../imx8mm-venice-gw73xx-0x-rs422.dts         | 61 +++++++++++++++++++
 .../imx8mm-venice-gw73xx-0x-rs485.dts         | 61 +++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 55b47cc11490..ea798b7bb286 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -99,6 +99,14 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 
+imx8mm-venice-gw73xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
+imx8mm-venice-gw73xx-0x-rs422-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs422.dtbo
+imx8mm-venice-gw73xx-0x-rs485-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs485.dtbo
+
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtb
+
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
new file mode 100644
index 000000000000..2fa635e1c1a8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Gateworks Corporation
+ *
+ * GW73xx RS232 with RTS/CTS hardware flow control:
+ *  - GPIO4_0 rs485_en needs to be driven low (in-active)
+ *  - UART4_TX becomes RTS
+ *  - UART4_RX becomes CTS
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mm-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "gw,imx8mm-gw73xx-0x";
+};
+
+&gpio4 {
+	rs485_en {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "rs485_en";
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	rts-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
+	cts-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x140
+			MX8MM_IOMUXC_UART4_RXD_GPIO5_IO28	0x140
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
new file mode 100644
index 000000000000..3e6404340d52
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 Gateworks Corporation
+ *
+ * GW73xx RS422 (RS485 full duplex):
+ *  - GPIO1_0 rs485_term selects on-chip termination
+ *  - GPIO4_0 rs485_en needs to be driven high (active)
+ *  - GPIO4_2 rs485_hd needs to be driven low (in-active)
+ *  - UART4_TX is DE for RS485 transmitter
+ *  - RS485_EN needs to be pulled high
+ *  - RS485_HALF needs to be low
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mm-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "gw,imx8mm-gw73xx-0x";
+};
+
+&gpio4 {
+	rs485_en {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "rs485_en";
+	};
+
+	rs485_hd {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "rs485_hd";
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	rts-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x140
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
new file mode 100644
index 000000000000..2c71ab9854cb
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 Gateworks Corporation
+ *
+ * GW73xx RS485 HD:
+ *  - GPIO1_0 rs485_term selects on-chip termination
+ *  - GPIO4_0 rs485_en needs to be driven high (active)
+ *  - GPIO4_2 rs485_hd needs to be driven high (active)
+ *  - UART4_TX is DE for RS485 transmitter
+ *  - RS485_EN needs to be pulled high
+ *  - RS485_HALF needs to be pulled high
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mm-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "gw,imx8mm-gw73xx-0x";
+};
+
+&gpio4 {
+	rs485_en {
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "rs485_en";
+	};
+
+	rs485_hd {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "rs485_hd";
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	rts-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX     0x140
+			MX8MM_IOMUXC_UART4_TXD_GPIO5_IO29	0x140
+		>;
+	};
+};
-- 
2.17.1

