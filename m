Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5BA47822B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhLQBa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhLQBaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:30:21 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F143CC061757
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:30:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g11so1489876lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EaeJHVapfeG+0ow4kbqvK0MBEVKM2dNg2z2A86xtXI=;
        b=qCLFxkn1Oxg3mgj5UDpi8TECWroR+JgiKV/Js3+lYAk4UXybclOAziiyNnicrX+o36
         7pHNQjXCJ949VL0WqCUY7MSS7YZGOLGcO4gy+FwwBzGJC5CGVPH+tJzYHOTN7c/PwraY
         /cco9CyY3KAmBLWmz+G6u9R+SyQ5iOP1IsajXVzwTLFQeVO2C838MXr4wQUhfmhUUiRP
         KXyCmus6zkuhS9bzdTDlJEIJ2gojIXNR2bThpq4SI9dqkhSh6IiLnNhxrx7U58839XGY
         5iqjUTHj8H18ESB2zxnZUh2MsX+LScrjHpw9sFtf3IQJVgyHdLIpGQpbpqg8qtN6HUCo
         4YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EaeJHVapfeG+0ow4kbqvK0MBEVKM2dNg2z2A86xtXI=;
        b=hlxU6IHJUGakApZKC2wufQsdaAyoCdjOgEVnuSoytCNSxkOaLwDXMTf19aZ/Cd1ykb
         k8hNrujOUSPYPwGVUKIVrdVKtC71I75ZygCm8pucPZKY2W1CSFK+yUabnif51O7Tzx8x
         U/hSvaq+MyI16URUozFjl10Pi5TgKaISjKkUzlS9rK0A7DuXOMSNRTjWSeMn1nvFyObD
         x/V1D0Hm+0VvMxjjYW8zKHgfpV/OyimqNoUaAEwgbYoNi5SSpVEIycmkuZsQV+qgDF6C
         U2p1kzNHwzIJAmsTb7mC8O2nBCwTg8agjg35ikCEn4wISmqSL5YOIGmoQgMILxEWN5ro
         CkGA==
X-Gm-Message-State: AOAM532JFQzwKq0+VNbvTi2bAZHgZjvDifUmf3gD+vjz2by/kgMwmDIF
        nmhek+2aBPL0fG10FzrQOGNOrQ==
X-Google-Smtp-Source: ABdhPJyBeQGZz7+zmb0FO0BdsfqamVmyBShDesR+suzc3yUz9WoSpS+we4qdDYL/DsrOkkvER/cBQQ==
X-Received: by 2002:a05:6512:c0b:: with SMTP id z11mr721871lfu.343.1639704619194;
        Thu, 16 Dec 2021 17:30:19 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id bt18sm53317lfb.50.2021.12.16.17.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:30:18 -0800 (PST)
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
Subject: [PATCH v2 7/7] arm64: dts: exynos: Add initial E850-96 board support
Date:   Fri, 17 Dec 2021 03:30:05 +0200
Message-Id: <20211217013005.16646-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217013005.16646-1-semen.protsenko@linaro.org>
References: <20211217013005.16646-1-semen.protsenko@linaro.org>
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
Changes in v2:
  - Removed board_id and board_rev properties
  - Removed BOARD_ID and BOARD_REV constants
  - Put dtb in alphabetical order in Makefile
  - Added "color" and "function" properties to LED nodes
  - Sorted all phandle overrides by phandle name
  - Removed 'broken-cd' property in eMMC node
  - Added memory node

 arch/arm64/boot/dts/exynos/Makefile           |   1 +
 .../boot/dts/exynos/exynos850-e850-96.dts     | 175 ++++++++++++++++++
 2 files changed, 176 insertions(+)
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
index 000000000000..952a47c417d4
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -0,0 +1,175 @@
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
+	 * 4 GiB eMCP:
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
+&rtc {
+	status = "okay";
+};
+
+&rtcclk {
+	clock-frequency = <32768>;
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
-- 
2.30.2

