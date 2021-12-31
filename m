Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E44824FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhLaQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:22:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55160
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhLaQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:22:21 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5EBBD40710
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967740;
        bh=+G0od4GU2dk1nsbNVodGYJ7SfD0F6EZnVB5ah+E/Oxg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZV7UvD6KeHq/8YFkdOuEGLoE0haI/Bd5JPZwO1SdKcJjZ4rClYapid1ypbmaRs+BY
         75VHd7I6nWp9CX4jVY6GUDx85jekzGWEaaqNjw71y7OarCaKcPFkG3HcCXBe01eXfk
         4BKlLC/iupgd0lU9hFmpk5qI6xVZS/RikBV3RbyvaIz+MqlJOwAxzSjHENSHWyEyvb
         270E8bnmhsIMPh1sF878eYFL8+5wBHaX86JBSJOnCECuLdNLB2D4S9SyhNgxIQwXnT
         qlfuLstjMmlO5N0LbcWb3Doxy21gNmr7aSl1E0xrqIiTY3HYizXqnaVHPbmtpMIjtT
         1A/Jnq9zn4X+g==
Received: by mail-lj1-f198.google.com with SMTP id r20-20020a2eb894000000b0021a4e932846so9495626ljp.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+G0od4GU2dk1nsbNVodGYJ7SfD0F6EZnVB5ah+E/Oxg=;
        b=tRBFpCWmqfuhsus9mmBJyQcsB5jkeloZe5OGIhWJ6vQbmiJevZGIUWbOY/B6wOIYUS
         iBFLguRYkcv8D4RBgiWljpJvRegm7YHkyL3gB4l63qk1Kx0YGiyo8B2bjCZ1Fmn0CjFK
         T6A9ujm9vvXbS1SL3uZRQaxmWthoscQy7eMFrs+5BvgRx4XM5ole+6Qme3OwTzAdY0XV
         hlVWwK8mOlvUJA6CWuaIeiGL/dt8emZRQ2cyxr5Oi8L34BR/g6SR6Jk1+BeQ6KygYLDT
         r0drkoZrfAZpRnYQpss9X3F2MUtwH/xJVBY4kozgrjnJWCO/ywsWd298uqh+gtHZWVTn
         tfOg==
X-Gm-Message-State: AOAM531AbbMVQiuvGooKA78ZhqrnI+8PE2pEE01YY1o9zwQC2UErWE/z
        MHZyLPC62E1RXUJbT/zTP9Wrki626n3CPhljHvfrVcS3DEcwBp2z5wc9AfDjuqvi38JVKkvlWs0
        PZlUXC+fR5RC8CNAfDgbq6e1J6xtAg08VY+MdoNAiuA==
X-Received: by 2002:a05:6512:3f0c:: with SMTP id y12mr16073188lfa.227.1640967738864;
        Fri, 31 Dec 2021 08:22:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUsmAGq0bVwg9YLNkx//g04hOPkhCZKZOeaUh4IeyeEpkr1GLwCs+GhLkdt4SF/z5DN4MrYw==
X-Received: by 2002:a05:6512:3f0c:: with SMTP id y12mr16073169lfa.227.1640967738463;
        Fri, 31 Dec 2021 08:22:18 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm2796514lfa.75.2021.12.31.08.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:22:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 12/24] ARM: dts: exynos: align pinctrl with dtschema in Exynos4412
Date:   Fri, 31 Dec 2021 17:21:55 +0100
Message-Id: <20211231162207.257478-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the pin controller related nodes with dtschema.  No functional
change expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi   |   4 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts   |   2 +-
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |   2 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi       |  30 +--
 .../boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts      |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts       |   4 +-
 arch/arm/boot/dts/exynos4412-p4note.dtsi      |  44 +--
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi     | 252 +++++++++---------
 arch/arm/boot/dts/exynos4412-smdk4412.dts     |   4 +-
 10 files changed, 176 insertions(+), 176 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
index c14e37dc3a9b..03dffc690b79 100644
--- a/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
+++ b/arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
@@ -151,13 +151,13 @@ &ldo25_reg {
 };
 
 &pinctrl_0 {
-	camera_flash_host: camera-flash-host {
+	camera_flash_host: camera-flash-host-pins {
 		samsung,pins = "gpj1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-val = <0>;
 	};
 
-	camera_flash_isp: camera-flash-isp {
+	camera_flash_isp: camera-flash-isp-pins {
 		samsung,pins = "gpj1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-val = <1>;
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index 47431307cb3c..a9406280b979 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -192,7 +192,7 @@ &i2s0 {
 };
 
 &pinctrl_1 {
-	ether-reset {
+	ether-reset-pins {
 		samsung,pins = "gpc0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index b3726d4d7d93..a67cb61e3cbb 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -484,7 +484,7 @@ &mshc_0 {
 };
 
 &pinctrl_1 {
-	hsic_reset: hsic-reset {
+	hsic_reset: hsic-reset-pins {
 		samsung,pins = "gpm2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 968c7943653e..23f50c9be527 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -987,19 +987,19 @@ &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
 
-	mhl_int: mhl-int {
+	mhl_int: mhl-int-pins {
 		samsung,pins = "gpf3-5";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	i2c_mhl_bus: i2c-mhl-bus {
+	i2c_mhl_bus: i2c-mhl-bus-pins {
 		samsung,pins = "gpf0-4", "gpf0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	sleep0: sleep-states {
+	sleep0: sleep-state {
 		PIN_SLP(gpa0-0, INPUT, NONE);
 		PIN_SLP(gpa0-1, OUT0, NONE);
 		PIN_SLP(gpa0-2, INPUT, NONE);
@@ -1102,52 +1102,52 @@ &pinctrl_1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep1>;
 
-	gpio_keys: gpio-keys {
+	gpio_keys: gpio-keys-pins {
 		samsung,pins = "gpx0-1", "gpx2-2", "gpx2-7", "gpx3-3";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	bt_shutdown: bt-shutdown {
+	bt_shutdown: bt-shutdown-pins {
 		samsung,pins = "gpl0-6";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	bt_host_wakeup: bt-host-wakeup {
+	bt_host_wakeup: bt-host-wakeup-pins {
 		samsung,pins = "gpx2-6";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	bt_device_wakeup: bt-device-wakeup {
+	bt_device_wakeup: bt-device-wakeup-pins {
 		samsung,pins = "gpx3-1";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	max77686_irq: max77686-irq {
+	max77686_irq: max77686-irq-pins {
 		samsung,pins = "gpx0-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	max77693_irq: max77693-irq {
+	max77693_irq: max77693-irq-pins {
 		samsung,pins = "gpx1-5";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	max77693_fuel_irq: max77693-fuel-irq {
+	max77693_fuel_irq: max77693-fuel-irq-pins {
 		samsung,pins = "gpx2-3";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	sdhci2_cd: sdhci2-cd-irq {
+	sdhci2_cd: sdhci2-cd-irq-pins {
 		samsung,pins = "gpx3-4";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	hdmi_hpd: hdmi-hpd {
+	hdmi_hpd: hdmi-hpd-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
-	sleep1: sleep-states {
+	sleep1: sleep-state {
 		PIN_SLP(gpk0-0, PREV, NONE);
 		PIN_SLP(gpk0-1, PREV, NONE);
 		PIN_SLP(gpk0-2, OUT0, NONE);
@@ -1300,7 +1300,7 @@ &pinctrl_2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep2>;
 
-	sleep2: sleep-states {
+	sleep2: sleep-state {
 		PIN_SLP(gpz-0, INPUT, DOWN);
 		PIN_SLP(gpz-1, INPUT, DOWN);
 		PIN_SLP(gpz-2, INPUT, DOWN);
@@ -1315,7 +1315,7 @@ &pinctrl_3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep3>;
 
-	sleep3: sleep-states {
+	sleep3: sleep-state {
 		PIN_SLP(gpv0-0, INPUT, DOWN);
 		PIN_SLP(gpv0-1, INPUT, DOWN);
 		PIN_SLP(gpv0-2, INPUT, DOWN);
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 5b1d4591b35c..e7669b9e9edb 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -172,24 +172,24 @@ cooling_map1: map1 {
 };
 
 &pinctrl_1 {
-	gpio_power_key: power-key {
+	gpio_power_key: power-key-pins {
 		samsung,pins = "gpx1-3";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	max77686_irq: max77686-irq {
+	max77686_irq: max77686-irq-pins {
 		samsung,pins = "gpx3-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	hdmi_hpd: hdmi-hpd {
+	hdmi_hpd: hdmi-hpd-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
-	emmc_rstn: emmc-rstn {
+	emmc_rstn: emmc-rstn-pins {
 		samsung,pins = "gpk1-2";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 440135d0ff2a..a9fada51eb50 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -112,7 +112,7 @@ &mshc_0 {
 };
 
 &pinctrl_1 {
-	gpio_home_key: home-key {
+	gpio_home_key: home-key-pins {
 		samsung,pins = "gpx2-2";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e6aec5facabf..6db09dba07ff 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -506,14 +506,14 @@ &mshc_0 {
 };
 
 &pinctrl_1 {
-	keypad_rows: keypad-rows {
+	keypad_rows: keypad-rows-pins {
 		samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_cols: keypad-cols {
+	keypad_cols: keypad-cols-pins {
 		samsung,pins = "gpx1-0", "gpx1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 22c3086e0076..b386a9b8e188 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -641,19 +641,19 @@ &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
 
-	tsp_reg_gpio_2: tsp-reg-gpio-2 {
+	tsp_reg_gpio_2: tsp-reg-gpio-2-pins {
 		samsung,pins = "gpb-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	tsp_reg_gpio_3: tsp-reg-gpio-3 {
+	tsp_reg_gpio_3: tsp-reg-gpio-3-pins {
 		samsung,pins = "gpb-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	sleep0: sleep-states {
+	sleep0: sleep-state {
 		PIN_SLP(gpa0-0, INPUT, NONE);
 		PIN_SLP(gpa0-1, OUT0, NONE);
 		PIN_SLP(gpa0-2, INPUT, NONE);
@@ -755,19 +755,19 @@ &pinctrl_1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep1>;
 
-	sd3_wifi: sd3-wifi {
+	sd3_wifi: sd3-wifi-pins {
 		samsung,pins = "gpk3-3", "gpk3-4", "gpk3-5", "gpk3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	bt_shutdown: bt-shutdown {
+	bt_shutdown: bt-shutdown-pins {
 		samsung,pins = "gpl0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	uart_sel: uart-sel {
+	uart_sel: uart-sel-pins {
 		samsung,pins = "gpl2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -775,82 +775,82 @@ uart_sel: uart-sel {
 		/* 0 = CP, 1 = AP (serial output) */
 	};
 
-	tsp_rst: tsp-rst {
+	tsp_rst: tsp-rst-pins {
 		samsung,pins = "gpm0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	tsp_irq: tsp-irq {
+	tsp_irq: tsp-irq-pins {
 		samsung,pins = "gpm2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	wifi_reset: wifi-reset {
+	wifi_reset: wifi-reset-pins {
 		samsung,pins = "gpm3-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	tsp_reg_gpio_1: tsp-reg-gpio-1 {
+	tsp_reg_gpio_1: tsp-reg-gpio-1-pins {
 		samsung,pins = "gpm4-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	ak8975_irq: ak8975-irq {
+	ak8975_irq: ak8975-irq-pins {
 		samsung,pins = "gpm4-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
-	stmpe_adc_irq: stmpe-adc-irq {
+	stmpe_adc_irq: stmpe-adc-irq-pins {
 		samsung,pins = "gpx0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	max77686_irq: max77686-irq {
+	max77686_irq: max77686-irq-pins {
 		samsung,pins = "gpx0-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	gpio_keys: gpio-keys {
+	gpio_keys: gpio-keys-pins {
 		samsung,pins = "gpx2-2", "gpx2-7", "gpx3-3";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	fuel_alert_irq: fuel-alert-irq {
+	fuel_alert_irq: fuel-alert-irq-pins {
 		samsung,pins = "gpx2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	wifi_host_wake: wifi-host-wake {
+	wifi_host_wake: wifi-host-wake-pins {
 		samsung,pins = "gpx2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
-	bt_host_wakeup: bt-host-wakeup {
+	bt_host_wakeup: bt-host-wakeup-pins {
 		samsung,pins = "gpx2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	bt_device_wakeup: bt-device-wakeup {
+	bt_device_wakeup: bt-device-wakeup-pins {
 		samsung,pins = "gpx3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	sdhci2_cd: sdhci2-cd {
+	sdhci2_cd: sdhci2-cd-pins {
 		samsung,pins = "gpx3-4";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	sleep1: sleep-states {
+	sleep1: sleep-state {
 		PIN_SLP(gpk0-0, PREV, NONE);
 		PIN_SLP(gpk0-1, PREV, NONE);
 		PIN_SLP(gpk0-2, PREV, NONE);
@@ -1004,7 +1004,7 @@ &pinctrl_2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep2>;
 
-	sleep2: sleep-states {
+	sleep2: sleep-state {
 		PIN_SLP(gpz-0, INPUT, DOWN);
 		PIN_SLP(gpz-1, INPUT, DOWN);
 		PIN_SLP(gpz-2, INPUT, DOWN);
@@ -1019,7 +1019,7 @@ &pinctrl_3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep3>;
 
-	sleep3: sleep-states {
+	sleep3: sleep-state {
 		PIN_SLP(gpv0-0, INPUT, DOWN);
 		PIN_SLP(gpv0-1, INPUT, DOWN);
 		PIN_SLP(gpv0-2, INPUT, DOWN);
diff --git a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi b/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
index d7d5fdc230d8..88b8afd55664 100644
--- a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
@@ -19,7 +19,7 @@ _pin {								\
 	}
 
 &pinctrl_0 {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -27,7 +27,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -35,7 +35,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -43,7 +43,7 @@ gpb: gpb {
 		#interrupt-cells = <2>;
 	};
 
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -51,7 +51,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -59,7 +59,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd0: gpd0 {
+	gpd0: gpd0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -67,7 +67,7 @@ gpd0: gpd0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -75,7 +75,7 @@ gpd1: gpd1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -83,7 +83,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -91,7 +91,7 @@ gpf1: gpf1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf2: gpf2 {
+	gpf2: gpf2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -99,7 +99,7 @@ gpf2: gpf2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf3: gpf3 {
+	gpf3: gpf3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -107,7 +107,7 @@ gpf3: gpf3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj0: gpj0 {
+	gpj0: gpj0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -115,7 +115,7 @@ gpj0: gpj0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj1: gpj1 {
+	gpj1: gpj1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -123,112 +123,112 @@ gpj1: gpj1 {
 		#interrupt-cells = <2>;
 	};
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa0-0", "gpa0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa0-2", "gpa0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa0-4", "gpa0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa0-6", "gpa0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c2_bus: i2c2-bus {
+	i2c2_bus: i2c2-bus-pins {
 		samsung,pins = "gpa0-6", "gpa0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gpa1-0", "gpa1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart2_fctl: uart2-fctl {
+	uart2_fctl: uart2-fctl-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart_audio_a: uart-audio-a {
+	uart_audio_a: uart-audio-a-pins {
 		samsung,pins = "gpa1-0", "gpa1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c3_bus: i2c3-bus {
+	i2c3_bus: i2c3-bus-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart3_data: uart3-data {
+	uart3_data: uart3-data-pins {
 		samsung,pins = "gpa1-4", "gpa1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart_audio_b: uart-audio-b {
+	uart_audio_b: uart-audio-b-pins {
 		samsung,pins = "gpa1-4", "gpa1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpb-0", "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c4_bus: i2c4-bus {
+	i2c4_bus: i2c4-bus-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb-4", "gpb-6", "gpb-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c5_bus: i2c5-bus {
+	i2c5_bus: i2c5-bus-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -236,7 +236,7 @@ i2s1_bus: i2s1-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -244,7 +244,7 @@ pcm1_bus: pcm1-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	ac97_bus: ac97-bus {
+	ac97_bus: ac97-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
@@ -252,7 +252,7 @@ ac97_bus: ac97-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -260,7 +260,7 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm2_bus: pcm2-bus {
+	pcm2_bus: pcm2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -268,105 +268,105 @@ pcm2_bus: pcm2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spdif_bus: spdif-bus {
+	spdif_bus: spdif-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c6_bus: i2c6-bus {
+	i2c6_bus: i2c6-bus-pins {
 		samsung,pins = "gpc1-3", "gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spi2_bus: spi2-bus {
+	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpc1-1", "gpc1-3", "gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm0_out: pwm0-out {
+	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpd0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm1_out: pwm1-out {
+	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpd0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_ctrl: lcd-ctrl {
+	lcd_ctrl: lcd-ctrl-pins {
 		samsung,pins = "gpd0-0", "gpd0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c7_bus: i2c7-bus {
+	i2c7_bus: i2c7-bus-pins {
 		samsung,pins = "gpd0-2", "gpd0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm2_out: pwm2-out {
+	pwm2_out: pwm2-out-pins {
 		samsung,pins = "gpd0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm3_out: pwm3-out {
+	pwm3_out: pwm3-out-pins {
 		samsung,pins = "gpd0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpd1-0", "gpd1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	mipi0_clk: mipi0-clk {
+	mipi0_clk: mipi0-clk-pins {
 		samsung,pins = "gpd1-0", "gpd1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c1_bus: i2c1-bus {
+	i2c1_bus: i2c1-bus-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	mipi1_clk: mipi1-clk {
+	mipi1_clk: mipi1-clk-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_clk: lcd-clk {
+	lcd_clk: lcd-clk-pins {
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_data16: lcd-data-width16 {
+	lcd_data16: lcd-data-width16-pins {
 		samsung,pins = "gpf0-7", "gpf1-0", "gpf1-1", "gpf1-2",
 				"gpf1-3", "gpf1-6", "gpf1-7", "gpf2-0",
 				"gpf2-1", "gpf2-2", "gpf2-3", "gpf2-7",
@@ -376,7 +376,7 @@ lcd_data16: lcd-data-width16 {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_data18: lcd-data-width18 {
+	lcd_data18: lcd-data-width18-pins {
 		samsung,pins = "gpf0-6", "gpf0-7", "gpf1-0", "gpf1-1",
 				"gpf1-2", "gpf1-3", "gpf1-6", "gpf1-7",
 				"gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
@@ -387,7 +387,7 @@ lcd_data18: lcd-data-width18 {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_data24: lcd-data-width24 {
+	lcd_data24: lcd-data-width24-pins {
 		samsung,pins = "gpf0-4", "gpf0-5", "gpf0-6", "gpf0-7",
 				"gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3",
 				"gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7",
@@ -399,14 +399,14 @@ lcd_data24: lcd-data-width24 {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_ldi: lcd-ldi {
+	lcd_ldi: lcd-ldi-pins {
 		samsung,pins = "gpf3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	cam_port_a_io: cam-port-a-io {
+	cam_port_a_io: cam-port-a-io-pins {
 		samsung,pins = "gpj0-0", "gpj0-1", "gpj0-2", "gpj0-3",
 				"gpj0-4", "gpj0-5", "gpj0-6", "gpj0-7",
 				"gpj1-0", "gpj1-1", "gpj1-2", "gpj1-4";
@@ -415,14 +415,14 @@ cam_port_a_io: cam-port-a-io {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	cam_port_a_clk_active: cam-port-a-clk-active {
+	cam_port_a_clk_active: cam-port-a-clk-active-pins {
 		samsung,pins = "gpj1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	cam_port_a_clk_idle: cam-port-a-clk-idle {
+	cam_port_a_clk_idle: cam-port-a-clk-idle-pins {
 		samsung,pins = "gpj1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -431,7 +431,7 @@ cam_port_a_clk_idle: cam-port-a-clk-idle {
 };
 
 &pinctrl_1 {
-	gpk0: gpk0 {
+	gpk0: gpk0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -439,7 +439,7 @@ gpk0: gpk0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk1: gpk1 {
+	gpk1: gpk1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -447,7 +447,7 @@ gpk1: gpk1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk2: gpk2 {
+	gpk2: gpk2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -455,7 +455,7 @@ gpk2: gpk2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk3: gpk3 {
+	gpk3: gpk3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -463,7 +463,7 @@ gpk3: gpk3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpl0: gpl0 {
+	gpl0: gpl0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -471,7 +471,7 @@ gpl0: gpl0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpl1: gpl1 {
+	gpl1: gpl1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -479,7 +479,7 @@ gpl1: gpl1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpl2: gpl2 {
+	gpl2: gpl2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -487,7 +487,7 @@ gpl2: gpl2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm0: gpm0 {
+	gpm0: gpm0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -495,7 +495,7 @@ gpm0: gpm0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm1: gpm1 {
+	gpm1: gpm1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -503,7 +503,7 @@ gpm1: gpm1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm2: gpm2 {
+	gpm2: gpm2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -511,7 +511,7 @@ gpm2: gpm2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm3: gpm3 {
+	gpm3: gpm3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -519,7 +519,7 @@ gpm3: gpm3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm4: gpm4 {
+	gpm4: gpm4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -527,42 +527,42 @@ gpm4: gpm4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpy0: gpy0 {
+	gpy0: gpy0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpy1: gpy1 {
+	gpy1: gpy1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpy2: gpy2 {
+	gpy2: gpy2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpy3: gpy3 {
+	gpy3: gpy3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpy4: gpy4 {
+	gpy4: gpy4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpy5: gpy5 {
+	gpy5: gpy5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpy6: gpy6 {
+	gpy6: gpy6-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpx0: gpx0 {
+	gpx0: gpx0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -579,7 +579,7 @@ gpx0: gpx0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx1: gpx1 {
+	gpx1: gpx1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -596,7 +596,7 @@ gpx1: gpx1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx2: gpx2 {
+	gpx2: gpx2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -604,7 +604,7 @@ gpx2: gpx2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx3: gpx3 {
+	gpx3: gpx3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -612,203 +612,203 @@ gpx3: gpx3 {
 		#interrupt-cells = <2>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpk0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpk0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_cd: sd0-cd {
+	sd0_cd: sd0-cd-pins {
 		samsung,pins = "gpk0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_bus1: sd0-bus-width1 {
+	sd0_bus1: sd0-bus-width1-pins {
 		samsung,pins = "gpk0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_bus4: sd0-bus-width4 {
+	sd0_bus4: sd0-bus-width4-pins {
 		samsung,pins = "gpk0-3", "gpk0-4", "gpk0-5", "gpk0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_bus8: sd0-bus-width8 {
+	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd4_clk: sd4-clk {
+	sd4_clk: sd4-clk-pins {
 		samsung,pins = "gpk0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd4_cmd: sd4-cmd {
+	sd4_cmd: sd4-cmd-pins {
 		samsung,pins = "gpk0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd4_cd: sd4-cd {
+	sd4_cd: sd4-cd-pins {
 		samsung,pins = "gpk0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd4_bus1: sd4-bus-width1 {
+	sd4_bus1: sd4-bus-width1-pins {
 		samsung,pins = "gpk0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd4_bus4: sd4-bus-width4 {
+	sd4_bus4: sd4-bus-width4-pins {
 		samsung,pins = "gpk0-3", "gpk0-4", "gpk0-5", "gpk0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd4_bus8: sd4-bus-width8 {
+	sd4_bus8: sd4-bus-width8-pins {
 		samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpk1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpk1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_cd: sd1-cd {
+	sd1_cd: sd1-cd-pins {
 		samsung,pins = "gpk1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_bus1: sd1-bus-width1 {
+	sd1_bus1: sd1-bus-width1-pins {
 		samsung,pins = "gpk1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_bus4: sd1-bus-width4 {
+	sd1_bus4: sd1-bus-width4-pins {
 		samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpk2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpk2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_cd: sd2-cd {
+	sd2_cd: sd2-cd-pins {
 		samsung,pins = "gpk2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_bus1: sd2-bus-width1 {
+	sd2_bus1: sd2-bus-width1-pins {
 		samsung,pins = "gpk2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_bus4: sd2-bus-width4 {
+	sd2_bus4: sd2-bus-width4-pins {
 		samsung,pins = "gpk2-3", "gpk2-4", "gpk2-5", "gpk2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_bus8: sd2-bus-width8 {
+	sd2_bus8: sd2-bus-width8-pins {
 		samsung,pins = "gpk3-3", "gpk3-4", "gpk3-5", "gpk3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_clk: sd3-clk {
+	sd3_clk: sd3-clk-pins {
 		samsung,pins = "gpk3-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_cmd: sd3-cmd {
+	sd3_cmd: sd3-cmd-pins {
 		samsung,pins = "gpk3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_cd: sd3-cd {
+	sd3_cd: sd3-cd-pins {
 		samsung,pins = "gpk3-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_bus1: sd3-bus-width1 {
+	sd3_bus1: sd3-bus-width1-pins {
 		samsung,pins = "gpk3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_bus4: sd3-bus-width4 {
+	sd3_bus4: sd3-bus-width4-pins {
 		samsung,pins = "gpk3-3", "gpk3-4", "gpk3-5", "gpk3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	cam_port_b_io: cam-port-b-io {
+	cam_port_b_io: cam-port-b-io-pins {
 		samsung,pins = "gpm0-0", "gpm0-1", "gpm0-2", "gpm0-3",
 				"gpm0-4", "gpm0-5", "gpm0-6", "gpm0-7",
 				"gpm1-0", "gpm1-1", "gpm2-0", "gpm2-1";
@@ -817,77 +817,77 @@ cam_port_b_io: cam-port-b-io {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	cam_port_b_clk_active: cam-port-b-clk-active {
+	cam_port_b_clk_active: cam-port-b-clk-active-pins {
 		samsung,pins = "gpm2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	cam_port_b_clk_idle: cam-port-b-clk-idle {
+	cam_port_b_clk_idle: cam-port-b-clk-idle-pins {
 		samsung,pins = "gpm2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint0: ext-int0 {
+	eint0: ext-int0-pins {
 		samsung,pins = "gpx0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint8: ext-int8 {
+	eint8: ext-int8-pins {
 		samsung,pins = "gpx1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint15: ext-int15 {
+	eint15: ext-int15-pins {
 		samsung,pins = "gpx1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint16: ext-int16 {
+	eint16: ext-int16-pins {
 		samsung,pins = "gpx2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint31: ext-int31 {
+	eint31: ext-int31-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	fimc_is_i2c0: fimc-is-i2c0 {
+	fimc_is_i2c0: fimc-is-i2c0-pins {
 		samsung,pins = "gpm4-0", "gpm4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	fimc_is_i2c1: fimc-is-i2c1 {
+	fimc_is_i2c1: fimc-is-i2c1-pins {
 		samsung,pins = "gpm4-2", "gpm4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	fimc_is_uart: fimc-is-uart {
+	fimc_is_uart: fimc-is-uart-pins {
 		samsung,pins = "gpm3-5", "gpm3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	hdmi_cec: hdmi-cec {
+	hdmi_cec: hdmi-cec-pins {
 		samsung,pins = "gpx3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -896,7 +896,7 @@ hdmi_cec: hdmi-cec {
 };
 
 &pinctrl_2 {
-	gpz: gpz {
+	gpz: gpz-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -904,7 +904,7 @@ gpz: gpz {
 		#interrupt-cells = <2>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4", "gpz-5", "gpz-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -912,7 +912,7 @@ i2s0_bus: i2s0-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm0_bus: pcm0-bus {
+	pcm0_bus: pcm0-bus-pins {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -922,7 +922,7 @@ pcm0_bus: pcm0-bus {
 };
 
 &pinctrl_3 {
-	gpv0: gpv0 {
+	gpv0: gpv0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -930,7 +930,7 @@ gpv0: gpv0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv1: gpv1 {
+	gpv1: gpv1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -938,7 +938,7 @@ gpv1: gpv1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv2: gpv2 {
+	gpv2: gpv2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -946,7 +946,7 @@ gpv2: gpv2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv3: gpv3 {
+	gpv3: gpv3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -954,7 +954,7 @@ gpv3: gpv3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv4: gpv4 {
+	gpv4: gpv4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -962,7 +962,7 @@ gpv4: gpv4 {
 		#interrupt-cells = <2>;
 	};
 
-	c2c_bus: c2c-bus {
+	c2c_bus: c2c-bus-pins {
 		samsung,pins = "gpv0-0", "gpv0-1", "gpv0-2", "gpv0-3",
 				"gpv0-4", "gpv0-5", "gpv0-6", "gpv0-7",
 				"gpv1-0", "gpv1-1", "gpv1-2", "gpv1-3",
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index cc99b955af0c..a40ff394977c 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -133,14 +133,14 @@ key-E {
 };
 
 &pinctrl_1 {
-	keypad_rows: keypad-rows {
+	keypad_rows: keypad-rows-pins {
 		samsung,pins = "gpx2-0", "gpx2-1", "gpx2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_cols: keypad-cols {
+	keypad_cols: keypad-cols-pins {
 		samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
 			       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-- 
2.32.0

