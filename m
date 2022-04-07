Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F9E4F784B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbiDGH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbiDGH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:56:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75C1EA291
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:54:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f3so4764842pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E21S/+1Oc88PYlTNz8REwkook2wml8IdpHgAuGAbnss=;
        b=r6de84Y5A/+xd0WJ9MQ07QDQwrn9ZKZ5irlqPr8RKVA6SnJaU/hnxbGDdOpJTCf6VB
         +rAa0NyzT+M+1bzItfFsMQMZ14o0nasgt+lIB3gt9oC/i4TU5bPfLfTi47wXYoNJgxbu
         9weCjJ+Ta8jLZaghQjKHD1RPNhYp8Ydh3cZJi5Z7xDB8BhpopH1hCXRMj5Do6dBjnLGR
         KAOgdFop6UASgEk56MRiuW2uKNhIPNLWlW5Mx/DD5EMi29SrKMzafqu9grG9EZULeFkx
         nYQqcqM2z7X8VyPtiadyC0WVVtn7JIxLmE4gCmjN5aDMIsl3VdWmjZODbEJz57E9izZY
         TuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E21S/+1Oc88PYlTNz8REwkook2wml8IdpHgAuGAbnss=;
        b=cLwwUtY/21iTb1+5JsaYP3EBsG5hdR/5BNjAnSexY8V7kYfZnaDYivLi271EU+NYNj
         vq84ssIGQt9COYtC7tXWNrknLu+idqqef50QVpwsRRDaFzyn6dQTn/cZ0UKGDpqIM26l
         jZsa55CBgLKDk41UuC3f/lBURHTNRRvXisE7Pu/SwXuVE966OHfdQ64SW1gHxZJ3Hilk
         xU3RQplP4NlkVAoAtYI9YSZFCkb392VVNPplno/bGz9kAIYs6qFXReLRFnxddvszL5wU
         WBuENEuqdnOFSk+GHwZm9xM8HKFqxkuNuKHw+Hzqv8MS365X3ZtQhfiTKveGkxGpAoU+
         SJPA==
X-Gm-Message-State: AOAM533Q2Kwe9o0HEx274miuOBhvW0jm3RSCC5bCXQ7kDNw6hlQxdrVb
        ihYr/ngUAYFnHDM6Q5kpo8bLfvZh3OTptgSu
X-Google-Smtp-Source: ABdhPJxBI/vpow02/PorOX05No+RlPCkBnixIq0FwwudE/CbCLnMAQZr7jvSIPhkUmYS6u6TEwyoZQ==
X-Received: by 2002:aa7:8b14:0:b0:4f7:83b1:2e0b with SMTP id f20-20020aa78b14000000b004f783b12e0bmr12937905pfd.37.1649318075348;
        Thu, 07 Apr 2022 00:54:35 -0700 (PDT)
Received: from localhost.localdomain (203-75-29-53.hinet-ip.hinet.net. [203.75.29.53])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm19957157pfb.196.2022.04.07.00.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:54:34 -0700 (PDT)
From:   Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
To:     agross@kernel.org
Cc:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2]arm64: dts: qcom: Add sc7180-gelarshie
Date:   Thu,  7 Apr 2022 15:54:26 +0800
Message-Id: <20220407075427.41141-1-chenxiangrui@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree for Gelarshie, a trogdor variant

Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sc7180-trogdor-gelarshie-r0.dts  |  15 +
 .../dts/qcom/sc7180-trogdor-gelarshie.dtsi    | 280 ++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f9e6343acd03..cf8f88b065c3 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-gelarshie-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
new file mode 100644
index 000000000000..027d6d563a5f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gelarshie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-gelarshie.dtsi"
+
+/ {
+	model = "Google Gelarshie (rev0+)";
+	compatible = "google,gelarshie", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
new file mode 100644
index 000000000000..8758cafb2d89
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gelarshie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7180.dtsi"
+
+ap_ec_spi: &spi6 {};
+ap_h1_spi: &spi0 {};
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+
+/* Deleted nodes from trogdor.dtsi */
+
+/delete-node/ &alc5682;
+/delete-node/ &pp3300_codec;
+
+/ {
+	/* BOARD-SPECIFIC TOP LEVEL NODES */
+
+	adau7002: audio-codec-1 {
+		compatible = "adi,adau7002";
+		IOVDD-supply = <&pp1800_l15a>;
+		wakeup-delay-ms = <80>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&backlight {
+	pwms = <&cros_ec_pwm 0>;
+};
+
+&camcc {
+	status = "okay";
+};
+
+&cros_ec {
+	cros_ec_proximity: proximity {
+		compatible = "google,cros-ec-mkbp-proximity";
+		label = "proximity-wifi";
+	};
+};
+
+ap_ts_pen_1v8: &i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&pp3300_ts>;
+	};
+};
+
+&i2c7 {
+	status = "disabled";
+};
+
+&i2c9 {
+	status = "disabled";
+};
+
+&panel {
+	compatible = "edp-panel";
+};
+
+&pp1800_uf_cam {
+	status = "okay";
+};
+
+&pp1800_wf_cam {
+	status = "okay";
+};
+
+&pp2800_uf_cam {
+	status = "okay";
+};
+
+&pp2800_wf_cam {
+	status = "okay";
+};
+
+&pp3300_dx_edp {
+	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+};
+
+&sdhc_2 {
+	status = "okay";
+};
+
+&sn65dsi86_out {
+	data-lanes = <0 1 2 3>;
+};
+
+&sound {
+	compatible = "google,sc7180-gelarshie";
+	model = "sc7180-adau7002-max98357a";
+	audio-routing = "PDM_DAT", "DMIC";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dmic_clk_en>;
+};
+
+&sound_multimedia0_codec {
+	sound-dai = <&adau7002>;
+};
+
+/* PINCTRL - modifications to sc7180-trogdor.dtsi */
+
+&en_pp3300_dx_edp {
+	pinmux  {
+		pins = "gpio67";
+	};
+
+	pinconf {
+		pins = "gpio67";
+	};
+};
+
+&ts_reset_l {
+	pinconf {
+		/*
+		 * We want reset state by default and it will be up to the
+		 * driver to disable this when it's ready.
+		 */
+		output-low;
+	};
+};
+
+/* PINCTRL - board-specific pinctrl */
+
+&tlmm {
+	gpio-line-names = "HUB_RST_L",
+			  "AP_RAM_ID0",
+			  "AP_SKU_ID2",
+			  "AP_RAM_ID1",
+			  "WF_CAM_EN2",
+			  "AP_RAM_ID2",
+			  "UF_CAM_EN",
+			  "WF_CAM_EN",
+			  "TS_RESET_L",
+			  "TS_INT_L",
+			  "",
+			  "EDP_BRIJ_IRQ",
+			  "AP_EDP_BKLTEN",
+			  "UF_CAM_MCLK",
+			  "WF_CAM_MCLK",
+			  "EDP_BRIJ_I2C_SDA",
+			  "EDP_BRIJ_I2C_SCL",
+			  "UF_CAM_SDA",
+			  "UF_CAM_SCL",
+			  "WF_CAM_SDA",
+			  "WF_CAM_SCL",
+			  "",
+			  "",
+			  "AMP_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "WF_CAM_RST_L",
+			  "UF_CAM_RST_L",
+			  "AP_BRD_ID2",
+			  "BRIJ_SUSPEND",
+			  "AP_BRD_ID0",
+			  "AP_H1_SPI_MISO",
+			  "AP_H1_SPI_MOSI",
+			  "AP_H1_SPI_CLK",
+			  "AP_H1_SPI_CS_L",
+			  "BT_UART_CTS",
+			  "BT_UART_RTS",
+			  "BT_UART_TXD",
+			  "BT_UART_RXD",
+			  "H1_AP_INT_ODL",
+			  "",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "",
+			  "",
+			  "FORCED_USB_BOOT",
+			  "AMP_BCLK",
+			  "AMP_LRCLK",
+			  "AMP_DIN",
+			  "",
+			  "HP_BCLK",
+			  "HP_LRCLK",
+			  "HP_DOUT",
+			  "",
+			  "",
+			  "AP_SKU_ID0",
+			  "AP_EC_SPI_MISO",
+			  "AP_EC_SPI_MOSI",
+			  "AP_EC_SPI_CLK",
+			  "AP_EC_SPI_CS_L",
+			  "AP_SPI_CLK",
+			  "AP_SPI_MOSI",
+			  "AP_SPI_MISO",
+			  /*
+			   * AP_FLASH_WP_L is crossystem ABI. Schematics
+			   * call it BIOS_FLASH_WP_L.
+			   */
+			  "AP_FLASH_WP_L",
+			  "EN_PP3300_DX_EDP",
+			  "AP_SPI_CS0_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "WLAN_SW_CTRL",
+			  "BOOT_CONFIG_0",
+			  "REPORT_SWITCH",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "DMIC_CLK_EN",
+			  "HUB_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SKU_ID1",
+			  "AP_RST_REQ",
+			  "",
+			  "AP_BRD_ID1",
+			  "AP_EC_INT_L",
+			  "BOOT_CONFIG_1",
+			  "",
+			  "",
+			  "BOOT_CONFIG_4",
+			  "BOOT_CONFIG_2",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "EDP_BRIJ_EN",
+			  "",
+			  "",
+			  "BOOT_CONFIG_3",
+			  "WCI2_LTE_COEX_TXD",
+			  "WCI2_LTE_COEX_RXD",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "FORCED_USB_BOOT_POL",
+			  "AP_TS_PEN_I2C_SDA",
+			  "AP_TS_PEN_I2C_SCL",
+			  "DP_HOT_PLUG_DET",
+			  "EC_IN_RW_ODL";
+
+	dmic_clk_en: dmic_clk_en {
+		pinmux {
+			pins = "gpio83";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio83";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+};
-- 
2.25.1

