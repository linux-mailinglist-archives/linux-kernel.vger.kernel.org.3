Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5279F4D8931
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbiCNQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiCNQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD5021E27;
        Mon, 14 Mar 2022 09:30:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso2070607wmr.1;
        Mon, 14 Mar 2022 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sUiuL/SLTL5qZDZc0QyDeYZA2leqxHPH8yxtrmp6gNU=;
        b=mzBDZbPOnbtPVfj2Q8lifvmkN3ZTae9fpCvwJ5+1nGIW1wYJRW1ceOvOaZ+T57mARS
         HLhTxCDRU5tQEWRTLkTqmwWSgzUbNMBCZaQs6YzyhaJdWqf31pIjl2H09Vvs3HHTemoY
         cN9fT1Z1iZG33dKkr77BC4gqfxGuCdGykN+mvwV7L2Byl7WUr9Nur/D8Tq6XC2OH+rvy
         xaB9BkY6CTkEMa7zc04FXYqKyxgh59Un66jJYwoA5zi/4CE1AzYlRVnA4xHIsIS+//GC
         5CxlyiuVOvd8UGS3X3C4KVpAOXLkWA3KgIZk8+z1NCAyhTv2exTGvNa1yLf75NYgmoRf
         uqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUiuL/SLTL5qZDZc0QyDeYZA2leqxHPH8yxtrmp6gNU=;
        b=PqYEqCylNO6Hiu6ogBsWvXPph5cAQFicyiegbfbO8/44FyS7tKe0qR67z/8TZOWaTB
         r9PGOW7u2ugfh+KiEm0dJeh7xmKeUOOFB7O14kALf20BpmcPrGlzDoc+PC8SwGftPfj8
         eMat0+bkJVBZm1hRd2dGsC/Yy1ob7ZKjUwjCbriBoWI4BRvB6F+uGYZ1nXlL5z/MLGSz
         BV0vlYyNOaRsGggO1KiFdK0o26777J7A20F/bYzJM/uzzMwT8H0gmnrDSz378Eb4P97I
         ZhKpb63p/DZGNG/bwy7vEnfSZ1tW2kuZbAI2cpeKP5qVx7R7kJQFm9ZBHvwOYYE6hw34
         F0Vg==
X-Gm-Message-State: AOAM530iMTIigcAjt07RL7yHPdp2/J6ABkZKUFADKz4YkHl9Pij54e8q
        dAqSUIrgkFiQU6m+kxlRy/k=
X-Google-Smtp-Source: ABdhPJx3oNhVBMlq7IA3vdNtCp52Q09BFBnwfbLHCrliBUGCmAQwSQ3NCqEaxXRQAJuVfv93hTUGkQ==
X-Received: by 2002:a1c:7708:0:b0:381:f18b:29ca with SMTP id t8-20020a1c7708000000b00381f18b29camr30405wmi.140.1647275426193;
        Mon, 14 Mar 2022 09:30:26 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:25 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v1 12/14] ARM: dts: imx6dl-colibri: Add support for Toradex Iris carrier boards
Date:   Mon, 14 Mar 2022 17:29:56 +0100
Message-Id: <20220314162958.40361-13-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314162958.40361-1-max.krummenacher@toradex.com>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
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

Add support for Toradex Iris, small form-factor Pico-ITX Colibri Arm
Computer Module family Carrier Board.

Additional details available at
https://www.toradex.com/products/carrier-board/iris-carrier-board

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/Makefile                   |   2 +
 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts |  46 ++++++
 arch/arm/boot/dts/imx6dl-colibri-iris.dts    | 152 +++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ee27bafa69be..b636bae2b281 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -453,6 +453,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
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

