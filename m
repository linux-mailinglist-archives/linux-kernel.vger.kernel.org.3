Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42E8479137
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhLQQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbhLQQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:16:04 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0FC06175B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:16:03 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u22so4144848lju.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGJMeiOUT5EAa7p/t2no99UvrcKFkTeRZrArWF0eXgU=;
        b=dw12q6WLyAAnrdexTnghrgA2/fuQrQLnsq5p2hDsVX0yp9RVhiN2vlyx/34EcXevWV
         xs753mxfnqY+ehsf1XW34MtyCP3SRJmuuQ9bdhlORqUBbb6hyS13KjJImJQoFB88C7v8
         6W/bwU6oS2LtkD+hWso6VT0Vli6yU2Amz7Q5SEjGbb3YCyc/sfpksW4T0MUNccKdL1/U
         1jvSTuR5kYZzKF7n9I83i6fScHpXsOuNVmVdMWKclkN/CS6ZEpRvHeR9ULZbgRWeUF3M
         dHe9NqTVApmn4DBY2MgGx7zQX9QKmWp8Bp+0xMYpC3JeXlYFthvRWXDZbSHsOvmXhKWQ
         ERMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGJMeiOUT5EAa7p/t2no99UvrcKFkTeRZrArWF0eXgU=;
        b=Wk2ePw9fYn9NG8YFPgPitkxUo1ekv+aHHoHjtw7+Pw6KIFwE2XRoS6cRjgceZHwbDv
         YpkNer/hCH8BYNjhTecRm5Ik0W5g+XXhu/1VmPmC4FgbB914YWkAj5TRF4m9rf4WERLe
         ZmXP9HvQTDk+srlo3/aDvSma+9EU6p9h9GoEEnSSEbd+zp5hbSSRfOhGeiAFqdOYFu7a
         2A31gPaHjrw0XqSi5AVfU6eqLiIDog7hTqd3S6p0q9+ifmWdyBsVBjoycCPPC02d/kgk
         5d/RS4VF7hWIA83uvEwghCCoDIbOX5WPuBQyN5O/0CSB/cAX/NAJ8MzgLeM4wJf2EQ1+
         3cEw==
X-Gm-Message-State: AOAM530V0N2PWzP+rEkQhMVulQjTBbogUAyGydmk14YNNRwZ5jyVFhEy
        B8a9Lt7/CMjT+VaHCwprYk69Bg==
X-Google-Smtp-Source: ABdhPJw1DamsgUMvN5CEgLlSMoetBbjWx1x7A06Nf9fF6HLqisRNVLz5UnyKlspuOukgv/eWbITnIw==
X-Received: by 2002:a2e:a78e:: with SMTP id c14mr3497687ljf.162.1639757761985;
        Fri, 17 Dec 2021 08:16:01 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id k5sm1457148lfj.112.2021.12.17.08.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:16:01 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 7/7] arm64: dts: exynos: Add initial E850-96 board support
Date:   Fri, 17 Dec 2021 18:15:49 +0200
Message-Id: <20211217161549.24836-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217161549.24836-1-semen.protsenko@linaro.org>
References: <20211217161549.24836-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E850-96 is a 96boards development board manufactured by WinLink. It
incorporates Samsung Exynos850 SoC, and is compatible with 96boards
mezzanine boards [1], as it follows 96boards standards.

This patch adds minimal support for E850-96 board. Next features are
enabled in board dts file and verified with minimal BusyBox rootfs:

 * User buttons
 * LEDs
 * Serial console
 * Watchdog timers
 * RTC
 * eMMC

[1] https://www.96boards.org/products/mezzanine/

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - Moved "rtcclk" clock to board dts file
    - Specified "rtc_src" clock for rtc node in board dts file
    - Specified "rtcclk" clock for cmu_hsi node in board dts file
  - Improved comment for RAM memory node

Changes in v3:
  - Ordered the pinctrl_alive phandle alphabetically (forgot to do so in
    v2)

Changes in v2:
  - Removed board_id and board_rev properties
  - Removed BOARD_ID and BOARD_REV constants
  - Put dtb in alphabetical order in Makefile
  - Added "color" and "function" properties to LED nodes
  - Sorted all phandle overrides by phandle name
  - Removed 'broken-cd' property in eMMC node
  - Added memory node

 arch/arm64/boot/dts/exynos/Makefile           |   1 +
 .../boot/dts/exynos/exynos850-e850-96.dts     | 195 ++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts

diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index b41e86df0a84..be9df8e85c59 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -3,4 +3,5 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
 	exynos5433-tm2.dtb	\
 	exynos5433-tm2e.dtb	\
 	exynos7-espresso.dtb	\
+	exynos850-e850-96.dtb	\
 	exynosautov9-sadk.dtb
diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
new file mode 100644
index 000000000000..7b5a61d22cc5
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * WinLink E850-96 board device tree source
+ *
+ * Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ * Copyright (C) 2021 Linaro Ltd.
+ *
+ * Device tree source file for WinLink's E850-96 board which is based on
+ * Samsung Exynos850 SoC.
+ */
+
+/dts-v1/;
+
+#include "exynos850.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "WinLink E850-96 board";
+	compatible = "winlink,e850-96", "samsung,exynos850";
+
+	chosen {
+		stdout-path = &serial_0;
+	};
+
+	/*
+	 * RAM: 4 GiB (eMCP):
+	 *   - 2 GiB at 0x80000000
+	 *   - 2 GiB at 0x880000000
+	 *
+	 * 0xbab00000..0xbfffffff: secure memory (85 MiB).
+	 */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x3ab00000>,
+		      <0x0 0xc0000000 0x40000000>,
+		      <0x8 0x80000000 0x80000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_voldown_pins &key_volup_pins>;
+
+		volume-down-key {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&gpa1 0 GPIO_ACTIVE_LOW>;
+		};
+
+		volume-up-key {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&gpa0 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* HEART_BEAT_LED */
+		user_led1: led-1 {
+			label = "yellow:user1";
+			gpios = <&gpg2 2 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+		};
+
+		/* eMMC_LED */
+		user_led2: led-2 {
+			label = "yellow:user2";
+			gpios = <&gpg2 3 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			linux,default-trigger = "mmc0";
+		};
+
+		/* SD_LED */
+		user_led3: led-3 {
+			label = "white:user3";
+			gpios = <&gpg2 4 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_SD;
+			linux,default-trigger = "mmc2";
+		};
+
+		/* WIFI_LED */
+		wlan_active_led: led-4 {
+			label = "yellow:wlan";
+			gpios = <&gpg2 6 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_WLAN;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		/* BLUETOOTH_LED */
+		bt_active_led: led-5 {
+			label = "blue:bt";
+			gpios = <&gpg2 7 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_BLUETOOTH;
+			linux,default-trigger = "hci0rx";
+			default-state = "off";
+		};
+	};
+
+	/*
+	 * RTC clock (XrtcXTI); external, must be 32.768 kHz.
+	 *
+	 * TODO: Remove this once RTC clock is implemented properly as part of
+	 *       PMIC driver.
+	 */
+	rtcclk: clock-rtcclk {
+		compatible = "fixed-clock";
+		clock-output-names = "rtcclk";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+};
+
+&cmu_hsi {
+	clocks = <&oscclk>, <&rtcclk>,
+		 <&cmu_top CLK_DOUT_HSI_BUS>,
+		 <&cmu_top CLK_DOUT_HSI_MMC_CARD>,
+		 <&cmu_top CLK_DOUT_HSI_USB20DRD>;
+	clock-names = "oscclk", "rtcclk", "dout_hsi_bus",
+		      "dout_hsi_mmc_card", "dout_hsi_usb20drd";
+};
+
+&mmc_0 {
+	status = "okay";
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-highspeed;
+	non-removable;
+	mmc-hs400-enhanced-strobe;
+	card-detect-delay = <200>;
+	clock-frequency = <800000000>;
+	bus-width = <8>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <2 4>;
+	samsung,dw-mshc-hs400-timing = <0 2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk_pins &sd0_cmd_pins &sd0_rdqs_pins &sd0_nreset_pins
+		     &sd0_bus1_pins &sd0_bus4_pins &sd0_bus8_pins>;
+};
+
+&oscclk {
+	clock-frequency = <26000000>;
+};
+
+&pinctrl_alive {
+	key_voldown_pins: key-voldown-pins {
+		samsung,pins = "gpa1-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	key_volup_pins: key-volup-pins {
+		samsung,pins = "gpa0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+};
+
+&rtc {
+	status = "okay";
+	clocks = <&cmu_apm CLK_GOUT_RTC_PCLK>, <&rtcclk>;
+	clock-names = "rtc", "rtc_src";
+};
+
+&serial_0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+};
+
+&usi_uart {
+	samsung,clkreq-on; /* needed for UART mode */
+	status = "okay";
+};
+
+&watchdog_cl0 {
+	status = "okay";
+};
+
+&watchdog_cl1 {
+	status = "okay";
+};
-- 
2.30.2

