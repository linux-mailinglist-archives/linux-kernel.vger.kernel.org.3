Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4219C5651D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiGDKOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiGDKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975725F6C;
        Mon,  4 Jul 2022 03:13:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74E8C660198C;
        Mon,  4 Jul 2022 11:13:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929614;
        bh=+wgg9fECSidyt7EvVYtqUuVYu+1qkCxpiZ5rUy1KYKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyuyNGJWkM8GRlMLFsbv0nzoZgrqQ5784x8yG6mYhtKVIE2/D3ADp5nUT3vNbNCN+
         546cM7ZAhjTZWeP1Fu6nw3HW0YGxtbTLLPNbAUcRRzEFYtEO/y873dH3RYcQ4dWumN
         8DGg9BkZt/Ihs07qGseHoHSQNaZ26SBDPxtqYnwqO7s5GfifW3GOJO21C7HaKgcFwI
         qyv2EXQ5IwG6aRpp7JV/tcrnVg4tL1MPOX/ofVW59irVBUJsJ8LYpQELRd115MRnp5
         FYc7Oiwi7TTYxERFg5YPWU1CMCONZ25MpB3U6yvPjNtfEd0yoo6bjqH32BC4TCV26e
         RvE0QUYDDe43A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 06/11] arm64: dts: mediatek: cherry: Document gpios and add default pin config
Date:   Mon,  4 Jul 2022 12:13:16 +0200
Message-Id: <20220704101321.44835-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
References: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-line-names to document GPIO names and add the default basic
pin configuration to allow lower power operation by setting appropriate
state on the unused pins.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  20 ++
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  20 ++
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 199 ++++++++++++++++++
 3 files changed, 239 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 38c27d704ccc..eb80f23273aa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -9,3 +9,23 @@ / {
 	model = "Acer Tomato (rev2) board";
 	compatible = "google,tomato-rev2", "google,tomato", "mediatek,mt8195";
 };
+
+&pio_default {
+	pins-low-power-hdmi-disable {
+		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
+			 <PINMUX_GPIO32__FUNC_GPIO32>,
+			 <PINMUX_GPIO33__FUNC_GPIO33>,
+			 <PINMUX_GPIO34__FUNC_GPIO34>,
+			 <PINMUX_GPIO35__FUNC_GPIO35>;
+		input-enable;
+		bias-pull-down;
+	};
+
+	pins-low-power-pcie0-disable {
+		pinmux = <PINMUX_GPIO19__FUNC_GPIO19>,
+			 <PINMUX_GPIO20__FUNC_GPIO20>,
+			 <PINMUX_GPIO21__FUNC_GPIO21>;
+		input-enable;
+		bias-pull-down;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index 6ecde88c30ef..f9cdda07da88 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -10,3 +10,23 @@ / {
 	compatible = "google,tomato-rev4", "google,tomato-rev3",
 		     "google,tomato", "mediatek,mt8195";
 };
+
+&pio_default {
+	pins-low-power-hdmi-disable {
+		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
+			 <PINMUX_GPIO32__FUNC_GPIO32>,
+			 <PINMUX_GPIO33__FUNC_GPIO33>,
+			 <PINMUX_GPIO34__FUNC_GPIO34>,
+			 <PINMUX_GPIO35__FUNC_GPIO35>;
+		input-enable;
+		bias-pull-down;
+	};
+
+	pins-low-power-pcie0-disable {
+		pinmux = <PINMUX_GPIO19__FUNC_GPIO19>,
+			 <PINMUX_GPIO20__FUNC_GPIO20>,
+			 <PINMUX_GPIO21__FUNC_GPIO21>;
+		input-enable;
+		bias-pull-down;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 3cbdc918f547..f00565466328 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -147,6 +147,161 @@ &mt6359_vufs_ldo_reg {
 };
 
 &pio {
+	mediatek,rsel-resistance-in-si-unit;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pio_default>;
+
+	/* 144 lines */
+	gpio-line-names =
+		"I2S_SPKR_MCLK",
+		"I2S_SPKR_DATAIN",
+		"I2S_SPKR_LRCK",
+		"I2S_SPKR_BCLK",
+		"EC_AP_INT_ODL",
+		/*
+		 * AP_FLASH_WP_L is crossystem ABI. Schematics
+		 * call it AP_FLASH_WP_ODL.
+		 */
+		"AP_FLASH_WP_L",
+		"TCHPAD_INT_ODL",
+		"EDP_HPD_1V8",
+		"AP_I2C_CAM_SDA",
+		"AP_I2C_CAM_SCL",
+		"AP_I2C_TCHPAD_SDA_1V8",
+		"AP_I2C_TCHPAD_SCL_1V8",
+		"AP_I2C_AUD_SDA",
+		"AP_I2C_AUD_SCL",
+		"AP_I2C_TPM_SDA_1V8",
+		"AP_I2C_TPM_SCL_1V8",
+		"AP_I2C_TCHSCR_SDA_1V8",
+		"AP_I2C_TCHSCR_SCL_1V8",
+		"EC_AP_HPD_OD",
+		"",
+		"PCIE_NVME_RST_L",
+		"PCIE_NVME_CLKREQ_ODL",
+		"PCIE_RST_1V8_L",
+		"PCIE_CLKREQ_1V8_ODL",
+		"PCIE_WAKE_1V8_ODL",
+		"CLK_24M_CAM0",
+		"CAM1_SEN_EN",
+		"AP_I2C_PWR_SCL_1V8",
+		"AP_I2C_PWR_SDA_1V8",
+		"AP_I2C_MISC_SCL",
+		"AP_I2C_MISC_SDA",
+		"EN_PP5000_HDMI_X",
+		"AP_HDMITX_HTPLG",
+		"",
+		"AP_HDMITX_SCL_1V8",
+		"AP_HDMITX_SDA_1V8",
+		"AP_RTC_CLK32K",
+		"AP_EC_WATCHDOG_L",
+		"SRCLKENA0",
+		"SRCLKENA1",
+		"PWRAP_SPI0_CS_L",
+		"PWRAP_SPI0_CK",
+		"PWRAP_SPI0_MOSI",
+		"PWRAP_SPI0_MISO",
+		"SPMI_SCL",
+		"SPMI_SDA",
+		"",
+		"",
+		"",
+		"I2S_HP_DATAIN",
+		"I2S_HP_MCLK",
+		"I2S_HP_BCK",
+		"I2S_HP_LRCK",
+		"I2S_HP_DATAOUT",
+		"SD_CD_ODL",
+		"EN_PP3300_DISP_X",
+		"TCHSCR_RST_1V8_L",
+		"TCHSCR_REPORT_DISABLE",
+		"EN_PP3300_WLAN_X",
+		"BT_KILL_1V8_L",
+		"I2S_SPKR_DATAOUT",
+		"WIFI_KILL_1V8_L",
+		"BEEP_ON",
+		"SCP_I2C_SENSOR_SCL_1V8",
+		"SCP_I2C_SENSOR_SDA_1V8",
+		"",
+		"",
+		"",
+		"",
+		"AUD_CLK_MOSI",
+		"AUD_SYNC_MOSI",
+		"AUD_DAT_MOSI0",
+		"AUD_DAT_MOSI1",
+		"AUD_DAT_MISO0",
+		"AUD_DAT_MISO1",
+		"AUD_DAT_MISO2",
+		"SCP_VREQ_VAO",
+		"AP_SPI_GSC_TPM_CLK",
+		"AP_SPI_GSC_TPM_MOSI",
+		"AP_SPI_GSC_TPM_CS_L",
+		"AP_SPI_GSC_TPM_MISO",
+		"EN_PP1000_CAM_X",
+		"AP_EDP_BKLTEN",
+		"",
+		"USB3_HUB_RST_L",
+		"",
+		"WLAN_ALERT_ODL",
+		"EC_IN_RW_ODL",
+		"GSC_AP_INT_ODL",
+		"HP_INT_ODL",
+		"CAM0_RST_L",
+		"CAM1_RST_L",
+		"TCHSCR_INT_1V8_L",
+		"CAM1_DET_L",
+		"RST_ALC1011_L",
+		"",
+		"",
+		"BL_PWM_1V8",
+		"UART_AP_TX_DBG_RX",
+		"UART_DBG_TX_AP_RX",
+		"EN_SPKR",
+		"AP_EC_WARM_RST_REQ",
+		"UART_SCP_TX_DBGCON_RX",
+		"UART_DBGCON_TX_SCP_RX",
+		"",
+		"",
+		"KPCOL0",
+		"",
+		"MT6315_GPU_INT",
+		"MT6315_PROC_BC_INT",
+		"SD_CMD",
+		"SD_CLK",
+		"SD_DAT0",
+		"SD_DAT1",
+		"SD_DAT2",
+		"SD_DAT3",
+		"EMMC_DAT7",
+		"EMMC_DAT6",
+		"EMMC_DAT5",
+		"EMMC_DAT4",
+		"EMMC_RSTB",
+		"EMMC_CMD",
+		"EMMC_CLK",
+		"EMMC_DAT3",
+		"EMMC_DAT2",
+		"EMMC_DAT1",
+		"EMMC_DAT0",
+		"EMMC_DSL",
+		"",
+		"",
+		"MT6360_INT_ODL",
+		"SCP_JTAG0_TRSTN",
+		"AP_SPI_EC_CS_L",
+		"AP_SPI_EC_CLK",
+		"AP_SPI_EC_MOSI",
+		"AP_SPI_EC_MISO",
+		"SCP_JTAG0_TMS",
+		"SCP_JTAG0_TCK",
+		"SCP_JTAG0_TDO",
+		"SCP_JTAG0_TDI",
+		"AP_SPI_FLASH_CS_L",
+		"AP_SPI_FLASH_CLK",
+		"AP_SPI_FLASH_MOSI",
+		"AP_SPI_FLASH_MISO";
+
 	mmc0_pins_default: mmc0-default-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
@@ -210,6 +365,50 @@ pins-rst {
 			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
 		};
 	};
+
+	pio_default: pio-default-pins {
+		pins-wifi-enable {
+			pinmux = <PINMUX_GPIO58__FUNC_GPIO58>;
+			output-high;
+			drive-strength = <14>;
+		};
+
+		pins-low-power-pd {
+			pinmux = <PINMUX_GPIO25__FUNC_GPIO25>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>,
+				 <PINMUX_GPIO46__FUNC_GPIO46>,
+				 <PINMUX_GPIO47__FUNC_GPIO47>,
+				 <PINMUX_GPIO48__FUNC_GPIO48>,
+				 <PINMUX_GPIO65__FUNC_GPIO65>,
+				 <PINMUX_GPIO66__FUNC_GPIO66>,
+				 <PINMUX_GPIO67__FUNC_GPIO67>,
+				 <PINMUX_GPIO68__FUNC_GPIO68>,
+				 <PINMUX_GPIO128__FUNC_GPIO128>,
+				 <PINMUX_GPIO129__FUNC_GPIO129>;
+			input-enable;
+			bias-pull-down;
+		};
+
+		pins-low-power-pupd {
+			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
+				 <PINMUX_GPIO78__FUNC_GPIO78>,
+				 <PINMUX_GPIO79__FUNC_GPIO79>,
+				 <PINMUX_GPIO80__FUNC_GPIO80>,
+				 <PINMUX_GPIO83__FUNC_GPIO83>,
+				 <PINMUX_GPIO85__FUNC_GPIO85>,
+				 <PINMUX_GPIO90__FUNC_GPIO90>,
+				 <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO93__FUNC_GPIO93>,
+				 <PINMUX_GPIO94__FUNC_GPIO94>,
+				 <PINMUX_GPIO95__FUNC_GPIO95>,
+				 <PINMUX_GPIO96__FUNC_GPIO96>,
+				 <PINMUX_GPIO104__FUNC_GPIO104>,
+				 <PINMUX_GPIO105__FUNC_GPIO105>,
+				 <PINMUX_GPIO107__FUNC_GPIO107>;
+			input-enable;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
 };
 
 &pmic {
-- 
2.35.1

