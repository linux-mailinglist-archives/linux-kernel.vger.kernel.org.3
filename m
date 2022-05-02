Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB7517A25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbiEBWpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345509AbiEBWpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:45:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D54BE08F;
        Mon,  2 May 2022 15:41:38 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D587A22255;
        Tue,  3 May 2022 00:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651531297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DX3XCmwDiLSeYaSRJCeAE6w2gxP2IShyreuN4Ql9ODU=;
        b=jwZRn1yWnisPWOPx3jSWutoY6+aHYA8pOh+Vxq65dMqHXi3QYwZBNdYAuU3ydSSVczbIhK
        ynquARJrdMTcr6h6ZJEWS7LH30DGZgTTyoGexE2+y4vtK8bUDSqudCsf22iV9sfppih3I9
        NPA4tw1G7+eGaZd6XYc7HMYEal/7wc4=
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor.Ambarus@microchip.com,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 07/13] ARM: dts: lan966x: add basic Kontron KSwitch D10 support
Date:   Tue,  3 May 2022 00:41:21 +0200
Message-Id: <20220502224127.2604333-8-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502224127.2604333-1-michael@walle.cc>
References: <20220502224127.2604333-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for the Kontron KSwitch D10 MMT. It comes in two
variants: "6G-2GS" which features 6 Gigabit copper ports and two SFP
cages and "8G" which features 6 Gigbabit copper ports (where two are
2.5G capable).

For now the following is supported and working:
 - Kernel console
 - SFP cages
 - SPI
 - SGPIO
 - Watchdog

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/Makefile                    |  4 +-
 ...lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts | 78 ++++++++++++++++
 .../lan966x-kontron-kswitch-d10-mmt-8g.dts    | 13 +++
 .../dts/lan966x-kontron-kswitch-d10-mmt.dtsi  | 93 +++++++++++++++++++
 4 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index de7ff629d1f8..928bc7eeb73c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -751,7 +751,9 @@ dtb-$(CONFIG_SOC_IMX7ULP) += \
 	imx7ulp-com.dtb \
 	imx7ulp-evk.dtb
 dtb-$(CONFIG_SOC_LAN966) += \
-	lan966x-pcb8291.dtb
+	lan966x-pcb8291.dtb \
+	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
+	lan966x-kontron-kswitch-d10-mmt-8g.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-iot.dtb \
 	ls1021a-moxa-uc-8410a.dtb \
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
new file mode 100644
index 000000000000..7b12cbe11c58
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for the Kontron KSwitch D10 MMT 6G-2GS
+ */
+
+/dts-v1/;
+#include "lan966x-kontron-kswitch-d10-mmt.dtsi"
+
+/ {
+	model = "Kontron KSwitch D10 MMT 6G-2GS";
+	compatible = "kontron,kswitch-d10-mmt-6g-2gs", "kontron,s1921",
+		     "microchip,lan9668", "microchip,lan966";
+
+	aliases {
+		i2c0 = &i2c4;
+		i2c1 = &i2c1;
+	};
+
+	sfp0: sfp0 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c4>;
+		los-gpios = <&sgpio_in 1 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in 1 1 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <2500>;
+		tx-disable-gpios = <&sgpio_out 3 0 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in 0 2 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios = <&sgpio_out 2 0 GPIO_ACTIVE_HIGH>;
+		rate-select1-gpios = <&sgpio_out 2 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp1: sfp1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c1>;
+		los-gpios = <&sgpio_in 1 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in 1 3 GPIO_ACTIVE_LOW>;
+		maximum-power-milliwatt = <2500>;
+		tx-disable-gpios = <&sgpio_out 3 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in 0 3 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios = <&sgpio_out 2 2 GPIO_ACTIVE_HIGH>;
+		rate-select1-gpios = <&sgpio_out 2 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&flx1 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c1: i2c@600 {
+		pinctrl-0 = <&fc1_c_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+};
+
+&flx4 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c4: i2c@600 {
+		pinctrl-0 = <&fc4_b_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+};
+
+&gpio {
+	fc1_c_pins: fc1-c-i2c-pins {
+		/* SCL, SDA */
+		pins = "GPIO_47", "GPIO_48";
+		function = "fc1_c";
+	};
+
+	fc4_b_pins: fc4-b-i2c-pins {
+		/* SCL, SDA */
+		pins = "GPIO_57", "GPIO_58";
+		function = "fc4_b";
+	};
+};
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
new file mode 100644
index 000000000000..4b35f6c46e7f
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for the Kontron KSwitch D10 MMT 8G
+ */
+
+/dts-v1/;
+#include "lan966x-kontron-kswitch-d10-mmt.dtsi"
+
+/ {
+	model = "Kontron KSwitch D10 MMT 8G";
+	compatible = "kontron,kswitch-d10-mmt-8g", "kontron,s1921",
+		     "microchip,lan9668", "microchip,lan966";
+};
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
new file mode 100644
index 000000000000..4c1ebb4aa5b0
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Common part of the device tree for the Kontron KSwitch D10 MMT
+ */
+
+/dts-v1/;
+#include "lan966x.dtsi"
+
+/ {
+	aliases {
+		serial0 = &usart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
+		priority = <200>;
+	};
+};
+
+&flx0 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	usart0: serial@200 {
+		pinctrl-0 = <&usart0_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+};
+
+&flx3 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
+	status = "okay";
+
+	spi3: spi@400 {
+		pinctrl-0 = <&fc3_b_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+		cs-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gpio {
+	fc3_b_pins: fc3-b-pins {
+		/* SCK, MISO, MOSI */
+		pins = "GPIO_51", "GPIO_52", "GPIO_53";
+		function = "fc3_b";
+	};
+
+	sgpio_a_pins: sgpio-a-pins {
+		/* SCK, D0, D1 */
+		pins = "GPIO_32", "GPIO_33", "GPIO_34";
+		function = "sgpio_a";
+	};
+
+	sgpio_b_pins: sgpio-b-pins {
+		/* LD */
+		pins = "GPIO_64";
+		function = "sgpio_b";
+	};
+
+	usart0_pins: usart0-pins {
+		/* RXD, TXD */
+		pins = "GPIO_25", "GPIO_26";
+		function = "fc0_b";
+	};
+};
+
+&sgpio {
+	pinctrl-0 = <&sgpio_a_pins>, <&sgpio_b_pins>;
+	pinctrl-names = "default";
+	bus-frequency = <8000000>;
+	/* arbitrary range because all GPIOs are in software mode */
+	microchip,sgpio-port-ranges = <0 11>;
+	status = "okay";
+
+	sgpio_in: gpio@0 {
+		ngpios = <128>;
+	};
+
+	sgpio_out: gpio@1 {
+		ngpios = <128>;
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.30.2

