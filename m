Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7858E4FC092
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbiDKP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347936AbiDKPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D33CA52;
        Mon, 11 Apr 2022 08:23:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i7-20020a1c3b07000000b0038eb92fa965so782876wma.4;
        Mon, 11 Apr 2022 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fG802aYqjZQsNd2LU8/4lQJsCL20w0snxQCWOmggROM=;
        b=kXUGhXo5i53QIYrBX8V5hTkrA4GemC0gIItbzNmM/wYPTT3ze5TtPs5jXXpTC877gz
         1vaMGG62L8I+dSy/42WX6fj9/+sJwK8lXGZ6eA5XMP6TFnBgxR3LtisHl7LExG7LPgaF
         2v0cnCDEnEiPLTYqzeLz8PaK3FN0UK1sGCceM31oP7i4RUyVdglzqrVYgINAaToNSXEp
         ajk1diOE2CGPh1e6MR0FJus2iAjOKhH1ADNIQ/nK2II2pqmZFbUOmUogJL9oUCiuXD2m
         pcSxMI0Ku6R4Q5PUhq4P9olV/a6OR13v2O1W85Gyzmr+MgP4oPvQKg3a3TS94Xca1WW9
         7l2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fG802aYqjZQsNd2LU8/4lQJsCL20w0snxQCWOmggROM=;
        b=Zl4f2UWgRt6JqidA7ht1lDMZN5yyt06ly/lltfYVWH8N7PzwTI6SciW5L8ib4Lngfc
         SVm6fFn3oL0v6DMIyJJqi7w1U0G82P5BHmLTH93zvHoewKYg9ww7cPtBObGv3GfiZAmc
         AUbf3uQfeadUz3U44zRl0Ggsi+3AIrprQcTH5ZR0UUWcOdb88EOByAQb4mfOfSUqjJZe
         l0H6gQtE2nH/uo3I6fJAJRzu4S82hCNVzd1gQksIMdWXkMEyHMvXrVr/5UYlDPeKmevj
         uATRTbE/S6ijERhHYE6Fy1DF5QWKWSJ+xGRqp5lLK2ZDDGVcpm2Mju9bmhOY1dmw4Kzo
         nOgg==
X-Gm-Message-State: AOAM530pwsYsPGX7BHQER92OfHlNW+sfWyB5eVIZaLlpjXdJbViqIag2
        ux+kEDKcPpp9lE+EU3TDxWU=
X-Google-Smtp-Source: ABdhPJzxSIjR3A8dQJu/+p52Fco5Zpa+wrJeYWcIdW831NGRIoLm9U3brnqmQbkF2OjZsfEggZAndw==
X-Received: by 2002:a1c:202:0:b0:38e:ab4b:ce72 with SMTP id 2-20020a1c0202000000b0038eab4bce72mr13477180wmc.152.1649690579179;
        Mon, 11 Apr 2022 08:22:59 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:58 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v2 12/14] ARM: dts: imx6dl-colibri: Add support for Toradex Iris carrier boards
Date:   Mon, 11 Apr 2022 17:22:32 +0200
Message-Id: <20220411152234.12678-13-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Add support for Toradex Iris, small form-factor Pico-ITX Colibri Arm
Computer Module family Carrier Board.

Additional details available at
https://www.toradex.com/products/carrier-board/iris-carrier-board

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/Makefile                   |   2 +
 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts |  46 ++++++
 arch/arm/boot/dts/imx6dl-colibri-iris.dts    | 152 +++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ae3cac8e653b..cb4cf5453a9f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -459,6 +459,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-aristainetos2_4.dtb \
 	imx6dl-aristainetos2_7.dtb \
 	imx6dl-colibri-eval-v3.dtb \
+	imx6dl-colibri-iris.dtb \
+	imx6dl-colibri-iris-v2.dtb \
 	imx6dl-cubox-i.dtb \
 	imx6dl-cubox-i-emmc-som-v15.dtb \
 	imx6dl-cubox-i-som-v15.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts b/arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts
new file mode 100644
index 000000000000..3a6d3889760d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx6dl-colibri-iris.dts"
+
+/ {
+	model = "Toradex Colibri iMX6DL/S on Colibri Iris V2 Board";
+	compatible = "toradex,colibri_imx6dl-iris-v2", "toradex,colibri_imx6dl",
+		     "fsl,imx6dl";
+
+	reg_3v3_vmmc: regulator-3v3-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_vmmc>;
+		regulator-name = "3v3_vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <100>;
+		enable-active-high;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_iris	&pinctrl_usbh_oc_1 &pinctrl_usbc_id_1>;
+
+	pinctrl_enable_3v3_vmmc: enable3v3vmmcgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11	0x1b0b0
+		>;
+	};
+};
+
+/* Colibri MMC */
+&usdhc1 {
+	cap-power-off-card;
+	/* uncomment the following to enable SD card UHS mode if you have a V1.1 module */
+	/* /delete-property/ no-1-8-v; */
+	vmmc-supply = <&reg_3v3_vmmc>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6dl-colibri-iris.dts b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
new file mode 100644
index 000000000000..cf77d894f6d7
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6dl.dtsi"
+#include "imx6qdl-colibri.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6DL/S on Colibri Iris Board";
+	compatible = "toradex,colibri_imx6dl-iris", "toradex,colibri_imx6dl",
+		     "fsl,imx6dl";
+
+	aliases {
+		i2c0 = &i2c2;
+		i2c1 = &i2c3;
+	};
+
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &snvs_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+/* Colibri SSP */
+&ecspi4 {
+	status = "okay";
+};
+
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_forceoff &pinctrl_uart23_forceoff>;
+
+	/*
+	 * uart-a-on-x13-enable turns the UART transceiver for UART_A on. If one
+	 * wants to turn the transceiver off, that property has to be deleted
+	 * and the gpio handled in userspace.
+	 * The same applies to uart-b-c-on-x14-enable where the UART_B and
+	 * UART_C transceiver is turned on.
+	 */
+	uart-a-on-x13-enable-hog {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_HIGH>; /* SODIMM 102 */
+		output-high;
+	};
+
+	uart-b-c-on-x14-enable-hog {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_HIGH>; /* SODIMM 104 */
+		output-high;
+	};
+};
+
+/*
+ * Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 (e.g. RTC on carrier board)
+ */
+&i2c3 {
+	status = "okay";
+
+	rtc_i2c: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&pinctrl_gpio_iris
+		&pinctrl_usbh_oc_1
+		&pinctrl_usbc_id_1
+	>;
+
+	pinctrl_gpio_iris: gpioirisgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A17__GPIO2_IO21	0x1b0b0
+			MX6QDL_PAD_EIM_A18__GPIO2_IO20	0x1b0b0
+			MX6QDL_PAD_EIM_A19__GPIO2_IO19	0x1b0b0
+			MX6QDL_PAD_EIM_A20__GPIO2_IO18	0x1b0b0
+			MX6QDL_PAD_EIM_A23__GPIO6_IO06	0x1b0b0
+			MX6QDL_PAD_EIM_D27__GPIO3_IO27	0x1b0b0
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03	0x1b0b0
+			MX6QDL_PAD_SD2_DAT0__GPIO1_IO15	0x1b0b0
+		>;
+	};
+
+	pinctrl_uart1_forceoff: uart1forceoffgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D4__GPIO2_IO04 0x1b0b0
+		>;
+	};
+
+	pinctrl_uart23_forceoff: uart23forceoffgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08 0x1b0b0
+		>;
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+&reg_usb_host_vbus {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_host_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+/* Colibri MMC */
+&usdhc1 {
+	status = "okay";
+};
-- 
2.20.1

