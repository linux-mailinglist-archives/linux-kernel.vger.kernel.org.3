Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC925AA98C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiIBIKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiIBIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:09:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C609BD745
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:09:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t129so1168953pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2LElPUEHAEER2MM5C7FUO6eiI+hWaYrYRSS3KHq5FLg=;
        b=cR8C1DC+D+tsLv30YXcTmf7bi6JbcnsWyEyeWPRF7XmGmpYvKYcJxo/LxHLDShIBFV
         mvV5iqtHxkekz5lt8cmq768Gpn9dMn3J0hb8ANkjM+DSEx6u8lP3Q1o4xtsixWbsoWr7
         WHjfoEIVAK6vm1m7QhxEwX1GYnkBmylEq0IrjXANuve5WiF2NPMesSnrhqa2JjLOo8ts
         EQ5+bKjEwUYqHTl66+EQTOa1hR6T89wTPgUwioMxlP7Yu5ijPg4Ke+1o/Ds6saHgCuEG
         5tJ8SCMBUOajwc5u72oVADsLSYRFWVjGcs9pL/+0oAJ10FXh4vfzlqqUSGro64CaWRJ4
         u85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2LElPUEHAEER2MM5C7FUO6eiI+hWaYrYRSS3KHq5FLg=;
        b=GeyGYauM+whREJIfjmyqowmrkZf9aDbBmQIxp90Lg/zsYKrF70gprOkMpShVZ+za2O
         5EnH6a/oQH0o8BGRHrXtZUz2JxDaFuaXwIa6GokQj73fe9gKUOmDXNv7+IN+QBfTdVme
         /DmrEyqNCs4nEcaO3ZOKjeeJ5x2zOaFSGklY01/gwxmCZfjqaj9EVpJVb6eVlTRRZMnf
         Y+U23fK6Dslul5Fq7y2SF3E4wzegDq7QJhdaQX+VkcD8+Rn6wGSuPOJJgsSjpBVUlQ3F
         MIl0i8ZfoQ5I5nAn8eF8KGIE+D83eCdZbhTbNuofB3YmWJw8DAv1smgxvNcBS596j1LS
         5Y6Q==
X-Gm-Message-State: ACgBeo16HISkUg5SMvc3KxlHNGNbuHH51ZKEaSEy/EHd4AkEGHsFrUlb
        as9MRZQ04RcNsPsAoLqo1HWbBzGtBXWLHw==
X-Google-Smtp-Source: AA6agR5NdaDl9G5/i9AhTYmp4ut5tnAuOdIL9aMPIAA3Q6WaYW8PNw6CcPphaums+qPsFv4cWoyIcA==
X-Received: by 2002:a63:154:0:b0:42c:251b:8c0 with SMTP id 81-20020a630154000000b0042c251b08c0mr19505299pgb.359.1662106175971;
        Fri, 02 Sep 2022 01:09:35 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b00174849e6914sm943447plh.191.2022.09.02.01.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 01:09:35 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 2/2] arm64: dts: qcom: sc7280: Add device tree for herobrine evoker
Date:   Fri,  2 Sep 2022 16:09:11 +0800
Message-Id: <20220902160845.v5.2.I7dd7a79c4cc5fe91c3feb004473feb3b34b7b2d8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902080912.118592-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220902080912.118592-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Add a basic device tree for the herobrine evoker board.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

Changes in v5:
- Got the version number correct

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sc7280-herobrine-evoker-r0.dts   | 333 ++++++++++++++++++
 2 files changed, 334 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1d86a33de528c..dd18ae8cd81c2 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
new file mode 100644
index 0000000000000..ccbe50b6249ab
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Evoker board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7280-herobrine.dtsi"
+
+/ {
+	model = "Google Evoker";
+	compatible = "google,evoker", "qcom,sc7280";
+};
+
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_codec {
+	status = "okay";
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
+ap_tp_i2c: &i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	trackpad: trackpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_odl>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+
+		hid-descr-addr = <0x20>;
+		vcc-supply = <&pp3300_z1>;
+
+		wakeup-source;
+	};
+};
+
+ts_i2c: &i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth6915";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
+
+		vcc33-supply = <&ts_avdd>;
+	};
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
+
+&ap_sar_sensor0 {
+	status = "okay";
+};
+
+&ap_sar_sensor1 {
+	status = "okay";
+};
+
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
+/* For nvme */
+&pcie1 {
+	status = "okay";
+};
+
+/* For nvme */
+&pcie1_phy {
+	status = "okay";
+};
+
+&pwmleds {
+	status = "okay";
+};
+
+/* For eMMC */
+&sdhc_1 {
+	status = "okay";
+};
+
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+&ts_rst_conn {
+	bias-disable;
+};
+
+/* PINCTRL - BOARD-SPECIFIC */
+
+/*
+ * Methodology for gpio-line-names:
+ * - If a pin goes to herobrine board and is named it gets that name.
+ * - If a pin goes to herobrine board and is not named, it gets no name.
+ * - If a pin is totally internal to Qcard then it gets Qcard name.
+ * - If a pin is not hooked up on Qcard, it gets no name.
+ */
+
+&pm8350c_gpios {
+	gpio-line-names = "FLASH_STROBE_1",		/* 1 */
+			  "AP_SUSPEND",
+			  "PM8008_1_RST_N",
+			  "",
+			  "",
+			  "",
+			  "PMIC_EDP_BL_EN",
+			  "PMIC_EDP_BL_PWM",
+			  "";
+};
+
+&tlmm {
+	gpio-line-names = "AP_TP_I2C_SDA",		/* 0 */
+			  "AP_TP_I2C_SCL",
+			  "SSD_RST_L",
+			  "PE_WAKE_ODL",
+			  "AP_SAR_SDA",
+			  "AP_SAR_SCL",
+			  "PRB_SC_GPIO_6",
+			  "TP_INT_ODL",
+			  "HP_I2C_SDA",
+			  "HP_I2C_SCL",
+
+			  "GNSS_L1_EN",			/* 10 */
+			  "GNSS_L5_EN",
+			  "SPI_AP_MOSI",
+			  "SPI_AP_MISO",
+			  "SPI_AP_CLK",
+			  "SPI_AP_CS0_L",
+			  /*
+			   * AP_FLASH_WP is crossystem ABI. Schematics
+			   * call it BIOS_FLASH_WP_OD.
+			   */
+			  "AP_FLASH_WP",
+			  "",
+			  "AP_EC_INT_L",
+			  "",
+
+			  "UF_CAM_RST_L",		/* 20 */
+			  "WF_CAM_RST_L",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "",
+			  "PM8008_IRQ_1",
+			  "HOST2WLAN_SOL",
+			  "WLAN2HOST_SOL",
+			  "MOS_BT_UART_CTS",
+			  "MOS_BT_UART_RFR",
+
+			  "MOS_BT_UART_TX",		/* 30 */
+			  "MOS_BT_UART_RX",
+			  "PRB_SC_GPIO_32",
+			  "HUB_RST_L",
+			  "",
+			  "",
+			  "AP_SPI_FP_MISO",
+			  "AP_SPI_FP_MOSI",
+			  "AP_SPI_FP_CLK",
+			  "AP_SPI_FP_CS_L",
+
+			  "AP_EC_SPI_MISO",		/* 40 */
+			  "AP_EC_SPI_MOSI",
+			  "AP_EC_SPI_CLK",
+			  "AP_EC_SPI_CS_L",
+			  "LCM_RST_L",
+			  "EARLY_EUD_N",
+			  "",
+			  "DP_HOT_PLUG_DET",
+			  "IO_BRD_MLB_ID0",
+			  "IO_BRD_MLB_ID1",
+
+			  "IO_BRD_MLB_ID2",		/* 50 */
+			  "SSD_EN",
+			  "TS_I2C_SDA_CONN",
+			  "TS_I2C_CLK_CONN",
+			  "TS_RST_CONN",
+			  "TS_INT_CONN",
+			  "AP_I2C_TPM_SDA",
+			  "AP_I2C_TPM_SCL",
+			  "PRB_SC_GPIO_58",
+			  "PRB_SC_GPIO_59",
+
+			  "EDP_HOT_PLUG_DET_N",		/* 60 */
+			  "FP_TO_AP_IRQ_L",
+			  "",
+			  "AMP_EN",
+			  "CAM0_MCLK_GPIO_64",
+			  "CAM1_MCLK_GPIO_65",
+			  "WF_CAM_MCLK",
+			  "PRB_SC_GPIO_67",
+			  "FPMCU_BOOT0",
+			  "UF_CAM_SDA",
+
+			  "UF_CAM_SCL",			/* 70 */
+			  "",
+			  "",
+			  "WF_CAM_SDA",
+			  "WF_CAM_SCL",
+			  "",
+			  "",
+			  "EN_FP_RAILS",
+			  "FP_RST_L",
+			  "PCIE1_CLKREQ_ODL",
+
+			  "EN_PP3300_DX_EDP",		/* 80 */
+			  "SC_GPIO_81",
+			  "FORCED_USB_BOOT",
+			  "WCD_RESET_N",
+			  "MOS_WLAN_EN",
+			  "MOS_BT_EN",
+			  "MOS_SW_CTRL",
+			  "MOS_PCIE0_RST",
+			  "MOS_PCIE0_CLKREQ_N",
+			  "MOS_PCIE0_WAKE_N",
+
+			  "MOS_LAA_AS_EN",		/* 90 */
+			  "SD_CD_ODL",
+			  "",
+			  "",
+			  "MOS_BT_WLAN_SLIMBUS_CLK",
+			  "MOS_BT_WLAN_SLIMBUS_DAT0",
+			  "HP_MCLK",
+			  "HP_BCLK",
+			  "HP_DOUT",
+			  "HP_DIN",
+
+			  "HP_LRCLK",			/* 100 */
+			  "HP_IRQ",
+			  "",
+			  "",
+			  "GSC_AP_INT_ODL",
+			  "EN_PP3300_CODEC",
+			  "AMP_BCLK",
+			  "AMP_DIN",
+			  "AMP_LRCLK",
+			  "UIM1_DATA_GPIO_109",
+
+			  "UIM1_CLK_GPIO_110",		/* 110 */
+			  "UIM1_RESET_GPIO_111",
+			  "PRB_SC_GPIO_112",
+			  "UIM0_DATA",
+			  "UIM0_CLK",
+			  "UIM0_RST",
+			  "UIM0_PRESENT_ODL",
+			  "SDM_RFFE0_CLK",
+			  "SDM_RFFE0_DATA",
+			  "WF_CAM_EN",
+
+			  "FASTBOOT_SEL_0",		/* 120 */
+			  "SC_GPIO_121",
+			  "FASTBOOT_SEL_1",
+			  "SC_GPIO_123",
+			  "FASTBOOT_SEL_2",
+			  "SM_RFFE4_CLK_GRFC_8",
+			  "SM_RFFE4_DATA_GRFC_9",
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "PRB_SC_GPIO_129",
+
+			  "LCM_ID0",			/* 130 */
+			  "LCM_ID1",
+			  "",
+			  "SDR_QLINK_REQ",
+			  "SDR_QLINK_EN",
+			  "QLINK0_WMSS_RESET_N",
+			  "SMR526_QLINK1_REQ",
+			  "SMR526_QLINK1_EN",
+			  "SMR526_QLINK1_WMSS_RESET_N",
+			  "PRB_SC_GPIO_139",
+
+			  "SAR1_IRQ_ODL",		/* 140 */
+			  "SAR0_IRQ_ODL",
+			  "PRB_SC_GPIO_142",
+			  "",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1",
+
+			  "DMIC01_CLK",			/* 150 */
+			  "DMIC01_DATA",
+			  "DMIC23_CLK",
+			  "DMIC23_DATA",
+			  "",
+			  "",
+			  "EC_IN_RW_ODL",
+			  "HUB_EN",
+			  "WCD_SWR_TX_DATA2",
+			  "",
+
+			  "",				/* 160 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  "",				/* 170 */
+			  "MOS_BLE_UART_TX",
+			  "MOS_BLE_UART_RX",
+			  "",
+			  "",
+			  "";
+};
-- 
2.34.1

