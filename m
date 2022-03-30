Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF3E4EBD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbiC3JLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbiC3JLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:11:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CDF1D914D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:09:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cm17so44558pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X//uwV8uPz2XnrC/CM7T1N2y6zAgnXQo1iH9qrSe+Pk=;
        b=MqzoU8gKEB3BfGWgORll3R+xR8GKm5c7+dMnyWMQYjnvct6o+0o0Lgz7F0LnuoJkyg
         mwHayXbIdiZY2e9hKx6FR09jI/+eL5ojr6nBXoFzNruYTMESFHzVhYzNJPOGPjL4Ox5K
         IUColEi36xJk44tTR025AawfntB/wvfqi04Xakwz9eUPb0OopCDjb6mJfh7CoO8jrrB5
         TL28b5qGKREIfX0yyrydBbBiIwb4HGa216xV2Um0e5TNJFw1Gy4hFmEiBRbvFoPRNF2p
         qW4C34dCX3xQ5xILJzrbIthNOsBN/gNKybCIaHf1rQ/Qiq3UIHomd804DwevNyH7CY50
         WdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X//uwV8uPz2XnrC/CM7T1N2y6zAgnXQo1iH9qrSe+Pk=;
        b=VVdqSgOXjcmFEhzbwS/iME+oPwORkggtdWBHeRXioqDlMWzdOtJBaG7UamX6lzKWkT
         xRLlTV6nZyjZ0EG0dugpVkuHsVA4eOzidFE+SGlxGJxgJr+nUv153+UymDlrMDnTutHm
         Ectq0brzZ6z/uiCyJFKMKpb6wzlM7qHYmgDA2ZR78A21aMFGxrfyU3unI19xcX8eaqN9
         xd3mFrmDHr0AevSyg7wbnQNIxr9tVWbYKAcs97yypjeulDMjmmmcX2P+Z04RHNZtS3cD
         N2RKiRPZxHzU67ee5t5hcdOfGAMRJrFaXzl0mR1d+oHcgdSfJJBfgCnmsEtp+mMxCyfs
         zEVg==
X-Gm-Message-State: AOAM5313XtJAhB5gRuplSDaSHYXchRNjOKcdc0OR3r/5mfr302VWpNd4
        jKXg1OpGzxuEe8ytUZoDB4QC7g==
X-Google-Smtp-Source: ABdhPJw1bXHKrcS4u2eTGB013KNNZp9qsCL3YWdB0Cad42B35Sc6wkHyQqmK/+5Vdt1uIqp9NxYShQ==
X-Received: by 2002:a17:903:110f:b0:154:c7a4:9371 with SMTP id n15-20020a170903110f00b00154c7a49371mr32264199plh.75.1648631398515;
        Wed, 30 Mar 2022 02:09:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e484-8494-10d3-c3e6-ad02-32e8.emome-ip6.hinet.net. [2001:b400:e484:8494:10d3:c3e6:ad02:32e8])
        by smtp.gmail.com with ESMTPSA id f30-20020a63755e000000b00381f6b7ef30sm18473385pgn.54.2022.03.30.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 02:09:58 -0700 (PDT)
From:   Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
To:     agross@kernel.org
Cc:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Date:   Wed, 30 Mar 2022 17:09:46 +0800
Message-Id: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
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

Initial attempt at Gelarshie device tree.

BUG=b:225756600
TEST=emerge-strongbad chromeos-kernel-5_4

Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sc7180-trogdor-gelarshie-r0.dts  |  15 +
 .../dts/qcom/sc7180-trogdor-gelarshie.dtsi    | 304 ++++++++++++++++++
 3 files changed, 320 insertions(+)
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
index 000000000000..842f6cac6c27
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gelarshie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-mipi-camera.dtsi"
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
+&mdp {
+	chromium-enable-overlays;
+};
+
+&panel {
+	compatible = "edp-panel";
+};
+
+&pm6150_adc {
+	skin-temp-thermistor@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm6150_adc_tm {
+	status = "okay";
+
+	skin-temp-thermistor@1 {
+		reg = <1>;
+		io-channels = <&pm6150_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
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
+	compatible = "google,sc7180-coachz";
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
2.31.0

