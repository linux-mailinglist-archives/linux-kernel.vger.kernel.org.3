Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0B579067
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiGSCDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiGSCDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:03:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071183B97E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:03:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s21so13373471pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecs-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fZ0Gmt6v5R6MiQs+xFw8D1gMT8Qi6uxK+rMdfCNfnpY=;
        b=8FNTbMfDWTRTh8bRe2Uh4tjhWnT7540552aFh67Tf0Y9hy9sfY/TBS2lBSn4E0J4v/
         ddyQJixNrORS84rosuxaJihCHc1UPEZ74sCPxerdPQ9lOK3F/0j4KT47L+gRAkOyvsvd
         jAtiki1txNdyaj/ChYtklZVXhrXBLFuz0Moy69YfvyXrs9DmaOqIF71PYz9nFg8ZvfX/
         SoqsvRm9n37jP75eInU8YMeCLflb9Fjo1GPl4ZTv4kD1bCLCP0RUd3fpF+I0mZPfctYS
         uWcvIzoX6akk69KH5h3vR4TNhDY+cNp/WtwJHatNN9ov71WELlvKVUlnhffMLikTARnT
         ScNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fZ0Gmt6v5R6MiQs+xFw8D1gMT8Qi6uxK+rMdfCNfnpY=;
        b=stE+DsMY0Z+dtHpXXh98Iz5VkBoi22I3YMszT8BRr/hINTV59T7NyUD2Wg4yIrNCGj
         5o1+mxK2Y/cbBhp+Mpq5TGB/D+yf1juabrzWSyKXDGts2bypS0ABP8GOek4ciNhU4LKR
         iKN1sdrlsuylFWa60d/t8EwRn16upPQDFyZZCUBKCwN4MnaJMF5RHBqKsqyUSThcZqGt
         riFktCY6+eD/TFMG9zgEc2H6pLdSYnrEx5nY2lYfWqXRG+vADaDpqt2G/xWf1HcKKs/y
         ygK6Mb8oblVu9K2jfze10tbT3ovHMyeOckQSWslpAbqiB4Rc0OOsqbCcA3rb2V1qA12W
         Eanw==
X-Gm-Message-State: AJIora86ZT8trnEwMWtUqYlTsHqcfZe3S+/gUH5Sr+j8757sfu7cKVSj
        2UT9BZHODgcrFJBqgzPLExjp5DHT8+32vA==
X-Google-Smtp-Source: AGRyM1vV+/2E1xhPNFd512JXXFoGr7NdWT2haWswKduMIvJBN/NNbUuN1udRSFxlvBprV5Mdi0uN2w==
X-Received: by 2002:a17:902:d50b:b0:16c:474:ce67 with SMTP id b11-20020a170902d50b00b0016c0474ce67mr31431060plg.112.1658196221192;
        Mon, 18 Jul 2022 19:03:41 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id hk11-20020a17090b224b00b001ef87c5b7f4sm12327705pjb.30.2022.07.18.19.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 19:03:40 -0700 (PDT)
From:   Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Add sc7180-trogdor-pazquel
Date:   Tue, 19 Jul 2022 02:03:33 +0000
Message-Id: <20220719020327.1.I3aa6575984116a740e0fd15d13562424af73fd07@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pazquel is a trogdor variant.
There are 4 types:LTE+TI/LTE+Parade/Wifi+TI/Wifi+Parade.
The current builds is relatively stable.

Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>

---

 arch/arm64/boot/dts/qcom/Makefile             |   4 +
 .../sc7180-trogdor-pazquel-lte-parade.dts     |  22 ++
 .../qcom/sc7180-trogdor-pazquel-lte-ti.dts    |  22 ++
 .../qcom/sc7180-trogdor-pazquel-parade.dts    |  17 ++
 .../dts/qcom/sc7180-trogdor-pazquel-ti.dts    |  17 ++
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 225 ++++++++++++++++++
 6 files changed, 307 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f7232052d2862..b09fc3a2f03c7 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -74,6 +74,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-r9.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-limozeen-nots-r9.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-parade.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-lte-ti.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-parade.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pazquel-ti.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
new file mode 100644
index 0000000000000..f0d2a441822c4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade,LTE)";
+	compatible = "google,pazquel-sku4", "google,pazquel-sku6", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
new file mode 100644
index 0000000000000..7863191d92f5f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+#include "sc7180-trogdor-lte-sku.dtsi"
+
+/ {
+	model = "Google Pazquel (TI,LTE)";
+	compatible = "google,pazquel-sku0", "google,pazquel-sku2", "qcom,sc7180";
+};
+
+&ap_sar_sensor_i2c {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
new file mode 100644
index 0000000000000..fc53b221b3b60
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+
+/ {
+	model = "Google Pazquel (Parade)";
+	compatible = "google,pazquel-sku5", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
new file mode 100644
index 0000000000000..4431b83c2acbe
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+#include "sc7180-trogdor-pazquel.dtsi"
+
+/ {
+	model = "Google Pazquel (TI)";
+	compatible = "google,pazquel-sku1", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
new file mode 100644
index 0000000000000..53cd11e5f0ad3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Pazquel board device tree source
+ *
+ * Copyright 2021 Google LLC.
+ */
+
+ap_ec_spi: &spi6 {};
+ap_h1_spi: &spi0 {};
+
+#include "sc7180-trogdor.dtsi"
+/* Must come after sc7180-trogdor.dtsi to modify cros_ec */
+#include <arm/cros-ec-keyboard.dtsi>
+
+&ap_sar_sensor {
+	compatible = "semtech,sx9324";
+	semtech,ph0-pin = <1 3 3>;
+	semtech,ph1-pin = <3 1 3>;
+	semtech,ph2-pin = <1 3 3>;
+	semtech,ph3-pin = <0 0 0>;
+	semtech,ph01-resolution = <1024>;
+	semtech,ph23-resolution = <1024>;
+	semtech,startup-sensor = <1>;
+	semtech,ph01-proxraw-strength = <3>;
+	semtech,ph23-proxraw-strength = <1>;
+	semtech,avg-pos-strength = <128>;
+	semtech,input-analog-gain = <0>;
+	semtech,cs-idle-sleep = "gnd";
+
+	/delete-property/ svdd-supply;
+	vdd-supply = <&pp1800_prox>;
+};
+
+/delete-node/&trackpad;
+&ap_tp_i2c {
+	trackpad: trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_odl>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+
+		vcc-supply = <&pp3300_fp_tp>;
+		post-power-on-delay-ms = <100>;
+		hid-descr-addr = <0x0001>;
+
+		wakeup-source;
+	};
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+	>;
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&panel {
+	compatible = "edp-panel";
+};
+
+&pp3300_dx_edp {
+	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+};
+
+&en_pp3300_dx_edp {
+	pinmux {
+		pins = "gpio67";
+	};
+
+	pinconf {
+		pins = "gpio67";
+	};
+};
+
+/* PINCTRL - board-specific pinctrl */
+
+&tlmm {
+	gpio-line-names = "TP_INT_ODL",
+			  "AP_RAM_ID0",
+			  "AP_SKU_ID2",
+			  "AP_RAM_ID1",
+			  "",
+			  "AP_RAM_ID2",
+			  "AP_TP_I2C_SDA",
+			  "AP_TP_I2C_SCL",
+			  "TS_RESET_L",
+			  "TS_INT_L",
+			  "",
+			  "EDP_BRIJ_IRQ",
+			  "AP_EDP_BKLTEN",
+			  "",
+			  "",
+			  "EDP_BRIJ_I2C_SDA",
+			  "EDP_BRIJ_I2C_SCL",
+			  "HUB_RST_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AMP_EN",
+			  "P_SENSOR_INT_L",
+			  "AP_SAR_SENSOR_SDA",
+			  "AP_SAR_SENSOR_SCL",
+			  "",
+			  "HP_IRQ",
+			  "",
+			  "",
+			  "AP_BRD_ID2",
+			  "BRIJ_SUSPEND",
+			  "AP_BRD_ID0",
+			  "AP_H1_SPI_MISO",
+			  "AP_H1_SPI_MOSI",
+			  "AP_H1_SPI_CLK",
+			  "AP_H1_SPI_CS_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "H1_AP_INT_ODL",
+			  "",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "HP_I2C_SDA",
+			  "HP_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "AMP_BCLK",
+			  "AMP_LRCLK",
+			  "AMP_DIN",
+			  "",
+			  "HP_BCLK",
+			  "HP_LRCLK",
+			  "HP_DOUT",
+			  "HP_DIN",
+			  "HP_MCLK",
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
+			  "",
+			  "",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RST",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK",
+			  "UIM1_RST",
+			  "",
+			  "CODEC_PWR_EN",
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
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "EDP_BRIJ_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_TS_PEN_I2C_SDA",
+			  "AP_TS_PEN_I2C_SCL",
+			  "DP_HOT_PLUG_DET",
+			  "EC_IN_RW_ODL";
+};
-- 
2.17.1

