Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407A4F43AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355271AbiDEUQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457570AbiDEQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:10:53 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3AFD1B;
        Tue,  5 Apr 2022 09:08:53 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 31CE422260;
        Tue,  5 Apr 2022 18:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649174931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2p3sjpS/Bg3o28UgK7piCHL/zRE/gDoVsSlTwfbWAqQ=;
        b=hMCfN8z+XOdJahCnW0raIQnxmiUTsWCzvdBExcEKDAWdGV9SsNa0GQ6pXixZKAW/h3fW5d
        kj1MS2BRgUJGDEZW4WOmVLXQGm9txK+i09wtdOT6D4zgrw77uGgppPHxW+9rXXWKPhD8Vn
        GUoS/bPfLvQfqyeLsvp7zUkgSBz/oNM=
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
        Tudor.Ambarus@microchip.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 7/7] ARM: dts: lan966x: add basic Kontron KSwitch D10 support
Date:   Tue,  5 Apr 2022 18:08:37 +0200
Message-Id: <20220405160837.4093563-8-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405160837.4093563-1-michael@walle.cc>
References: <20220405160837.4093563-1-michael@walle.cc>
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
 - SFP cages I2C bus and mux
 - SPI
 - SGPIO
 - Watchdog

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/Makefile                    |  4 +-
 ...lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts | 77 +++++++++++++++++++
 .../lan966x-kontron-kswitch-d10-mmt-8g.dts    | 13 ++++
 .../dts/lan966x-kontron-kswitch-d10-mmt.dtsi  | 75 ++++++++++++++++++
 4 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dts
 create mode 100644 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..54beef7c1810 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -742,7 +742,9 @@ dtb-$(CONFIG_SOC_IMX7ULP) += \
 	imx7ulp-com.dtb \
 	imx7ulp-evk.dtb
 dtb-$(CONFIG_SOC_LAN966) += \
-	lan966x-pcb8291.dtb
+	lan966x-pcb8291.dtb \
+	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
+	lan966x-kontron-kswitch-d10-mmt-8g.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
new file mode 100644
index 000000000000..9cf0b791a355
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dts
@@ -0,0 +1,77 @@
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
+	i2cmux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mux-gpios = <&sgpio_out 3 2 GPIO_ACTIVE_HIGH>,
+			    <&sgpio_out 3 3 GPIO_ACTIVE_HIGH>;
+		i2c-parent = <&i2c4>;
+
+		i2c4_0: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4_1: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	sfp0: sfp0 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c4_0>;
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
+		i2c-bus = <&i2c4_1>;
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
index 000000000000..4178fb0bd9c5
--- /dev/null
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -0,0 +1,75 @@
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
+&gpio {
+	usart0_pins: usart0-pins {
+		/* RXD, TXD */
+		pins = "GPIO_25", "GPIO_26";
+		function = "fc0_b";
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

