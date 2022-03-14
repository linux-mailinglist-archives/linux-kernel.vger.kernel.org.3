Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074BB4D8930
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbiCNQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243078AbiCNQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65427FE8;
        Mon, 14 Mar 2022 09:30:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l10so9671115wmb.0;
        Mon, 14 Mar 2022 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuVI0nPhGtQzp4CrtyVyV4ed7h4ZcDvX7476/A1+K3w=;
        b=BJM1L64z93lfJaq5ARjBD2zPT+o3YIM2ZT8AWwwuy8IY86hKQeF9Aev0rlGdEnhpH/
         jSh5x5FXVGYtCl3RoUM1UbwSmnWEgZn2AesZhJHG4yw7JiL62m0HQetjRtwaY9NerHCI
         9mzBsMAW+1gp7cl/GY7DxqgAzUY2qRdRe9qwdthKh5RcyboL7nFrFsVXPhCbl8gfqP56
         mn4LyOhQp2hYsmH/2EEaBuDYtlonFD4v+qAOtW7AttiMg/o1Ep1CKIbcFrlxo17fAORM
         KXiZgvyvovxoJ5XylyQlj/BoBp/i4yxC98yf9bj2eCVxd+7QkmwR/VQXX8tk4iZTDH6y
         zO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuVI0nPhGtQzp4CrtyVyV4ed7h4ZcDvX7476/A1+K3w=;
        b=xUKRH/NgP+yGreK0gAZlwgXQ55p0F7MKAG6K1HQBI0POfgLEKw3rMF+0RL8IpiqEc3
         D5KfdGoK7LZQiJvDt6Z0tci7pRGKKwGkoSt7nEwvEcAcdndIGXNvbI5Y615v6r/AthKy
         CHhdWt4Jz8iqo9Z7aPXCyEUT0Gy6oO5IIvkRnW+W/+/sAkvrcE0CX+hz7NCrLo1I5+k/
         jbDZAGn5qduOoAgL/WM6a0+m5EF2k3F/q9C5c6Cc9ZSiQeoCYN/Ab14nm2oVnCHdkhDz
         bNxh7iCSNfwn8gWFyaPPzAkydgW/zLjpgkRfLU3oVy/1PvZjoMbOQv4gDmp7IK43q9K2
         CP9w==
X-Gm-Message-State: AOAM532GjEqSdXOodV6Fnt2Ow6wZQUdKDx5U+A2nprFTqeTVbxAlhKjj
        zWDSYasp+X/8K0mT5ZAGslc=
X-Google-Smtp-Source: ABdhPJyL/rCC47v7tOuZQq1uNrbhEHitNTUFBF+E9bWYFtmGL+8VEoCbg/ucrkd/XwVNcBFMuPC+0Q==
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id q18-20020a1cf312000000b0038708bf0bd3mr34440wmq.112.1647275427159;
        Mon, 14 Mar 2022 09:30:27 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:26 -0700 (PDT)
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
Subject: [PATCH v1 13/14] ARM: dts: imx6dl-colibri: Add support for Toradex Aster carrier board
Date:   Mon, 14 Mar 2022 17:29:57 +0100
Message-Id: <20220314162958.40361-14-max.krummenacher@toradex.com>
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

Add support for Toradex Aster, small form-factor with header compatible
with Arduino Uno and Raspberry Pi (RPi) maker boards.

Additional detail available at
https://www.toradex.com/products/carrier-boards/aster-carrier-board

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/imx6dl-colibri-aster.dts | 113 +++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-aster.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b636bae2b281..4802c8b0ee1a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -452,6 +452,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-aristainetos_7.dtb \
 	imx6dl-aristainetos2_4.dtb \
 	imx6dl-aristainetos2_7.dtb \
+	imx6dl-colibri-aster.dtb \
 	imx6dl-colibri-eval-v3.dtb \
 	imx6dl-colibri-iris.dtb \
 	imx6dl-colibri-iris-v2.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-colibri-aster.dts b/arch/arm/boot/dts/imx6dl-colibri-aster.dts
new file mode 100644
index 000000000000..74e8a6cd8bed
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-aster.dts
@@ -0,0 +1,113 @@
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
+	model = "Toradex Colibri iMX6DL/S on Colibri Aster Board";
+	compatible = "toradex,colibri_imx6dl-aster", "toradex,colibri_imx6dl",
+		     "fsl,imx6dl";
+
+	aliases {
+		i2c0 = &i2c2;
+		i2c1 = &i2c3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+/* Colibri SSP */
+&ecspi4 {
+	cs-gpios = <
+		&gpio5 2 GPIO_ACTIVE_HIGH
+		&gpio5 4 GPIO_ACTIVE_HIGH
+	>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi4 &pinctrl_csi_gpio_2>;
+	status = "okay";
+};
+
+/* Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 */
+&i2c3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&pinctrl_csi_gpio_1
+		&pinctrl_gpio_2
+		&pinctrl_gpio_aster
+		&pinctrl_usbh_oc_1
+		&pinctrl_usbc_id_1
+		&pinctrl_weim_gpio_5
+	>;
+
+	pinctrl_gpio_aster: gpioaster {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1b0b0
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x1b0b0
+			MX6QDL_PAD_NANDF_D6__GPIO2_IO06		0x1b0b0
+			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08		0x1b0b0
+			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11		0x1b0b0
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

