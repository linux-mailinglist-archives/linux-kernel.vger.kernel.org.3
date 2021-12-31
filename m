Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88E482524
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhLaQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:23:29 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47224
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhLaQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:23:26 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB2CF4000D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967802;
        bh=qOaRUROfrpI3SIhXN7Ou45B8JkhhBysAxr+Auoc3w68=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=HKVESjQ2TaU21X4Xt1wQJlMXFsX/Ea9Z2ppsD4EpvCClCQvpNQX2N6FKCEzoWWjU5
         hs4HMg4XSNpN1WAnKdgnewYdSzwsO5WqO0ik9lrzLRLMxiqtODK9cvQSyuUgshgIWB
         qG4i5CDg6eiJTG7wocekU4snIs90zuQFoGBkhGedmmFGsqBA+GsgP+rAOLItWnutsC
         6l2PMqxEGeRIRJfUMjwwl6Hrwp+2AQotx/txzzm0Gn43jQx2WrMwT3FowKdpgcfIYz
         8xo+I91YsBwpmXrn+K86fFx1YMxmNtkjexYSIhMrDe25RGvN+RmyGDUh7yP4AwjUgA
         L8E/VBBH8e3xA==
Received: by mail-lj1-f200.google.com with SMTP id bn28-20020a05651c179c00b002222b4cc6d8so9428901ljb.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOaRUROfrpI3SIhXN7Ou45B8JkhhBysAxr+Auoc3w68=;
        b=CXAzLULUiEio0eUJ5lMVLQDAs6zx3GsEdmVZ20rItROunwH6oBRuRmHUnoKZoVopA5
         SY6tSu9y84Cw8oOwTjbTejF926oM5vJXQdZpndLpT5IGOpy948k5nYqYhFVr710lpIpT
         /05IiZti3MC5vTmgr5FlV036MJ/3lbDFt9FRcQLuGbHJ5BcndXBfX3Pw1MuBObi+jtoj
         uv/ZwmZdrtsl9ava/ehk+WQnu3W+2s7FCRvHzzfnT9aC26aIoVbtNRWYuOJTL24vjkwa
         g+TQk1tUIuOtuO9cdMJeV6tJ8ivbcTkQRCxZBTMv/H9CqnmBoycwFfkzC6HC/UYNugs+
         xpiw==
X-Gm-Message-State: AOAM5328xwXKKr4irno3DM8tJZQtL4fFDH+QO2xX8nRHSJjQzjJ+wafg
        XMD/PtZY6bxil7BrDM0tF/QBexNJExpzU6eEJ+ospUZErPN8jNS8dbwizhTQDCc1BU5G6Lr1TeE
        UhMr0GhUf0tX+nkLaXvJpJBFLFgCngvackE7ru6SSfA==
X-Received: by 2002:a05:6512:2250:: with SMTP id i16mr33893396lfu.24.1640967800125;
        Fri, 31 Dec 2021 08:23:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0ZiY7sKOsNJuX98oxRTQ6pDaxhxb09ysi3wM+qhdvrslJk9aT8xHnyZi+VmZQ1gOCRq2OtA==
X-Received: by 2002:a05:6512:2250:: with SMTP id i16mr33893374lfu.24.1640967799760;
        Fri, 31 Dec 2021 08:23:19 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y20sm1510835ljn.69.2021.12.31.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:23:18 -0800 (PST)
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
Subject: [PATCH 23/24] ARM: dts: s5pv210: align pinctrl with dtschema
Date:   Fri, 31 Dec 2021 17:23:08 +0100
Message-Id: <20211231162309.257587-6-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/s5pv210-aquila.dts      |   2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi      |  40 ++--
 arch/arm/boot/dts/s5pv210-fascinate4g.dts |  12 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts     |  16 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi    | 226 +++++++++++-----------
 5 files changed, 148 insertions(+), 148 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 6423348034b6..54de3bc77c30 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -391,7 +391,7 @@ timing0: timing {
 };
 
 &pinctrl0 {
-	t_flash_detect: t-flash-detect {
+	t_flash_detect: t-flash-detect-pins {
 		samsung,pins = "gph3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 160f8cd9a68d..c8f1c324a6c2 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -645,21 +645,21 @@ &mfc {
 };
 
 &pinctrl0 {
-	bt_reset: bt-reset {
+	bt_reset: bt-reset-pins {
 		samsung,pins = "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	wlan_bt_en: wlan-bt-en {
+	wlan_bt_en: wlan-bt-en-pins {
 		samsung,pins = "gpb-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-val = <1>;
 	};
 
-	codec_ldo: codec-ldo {
+	codec_ldo: codec-ldo-pins {
 		samsung,pins = "gpf3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
@@ -671,19 +671,19 @@ prox_i2c_pins: gp2a-i2c-pins {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	wlan_gpio_rst: wlan-gpio-rst {
+	wlan_gpio_rst: wlan-gpio-rst-pins {
 		samsung,pins = "gpg1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	bt_wake: bt-wake {
+	bt_wake: bt-wake-pins {
 		samsung,pins = "gpg3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	gp2a_irq: gp2a-irq {
+	gp2a_irq: gp2a-irq-pins {
 		samsung,pins = "gph0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
@@ -698,67 +698,67 @@ pmic_dvs_pins: pmic-dvs-pins {
 		samsung,pin-val = <0>;
 	};
 
-	pmic_irq: pmic-irq {
+	pmic_irq: pmic-irq-pins {
 		samsung,pins = "gph0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	wifi_host_wake: wifi-host-wake {
+	wifi_host_wake: wifi-host-wake-pins {
 		samsung,pins = "gph2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	bt_host_wake: bt-host-wake {
+	bt_host_wake: bt-host-wake-pins {
 		samsung,pins = "gph2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	musb_irq: musq-irq {
+	musb_irq: musq-irq-pins {
 		samsung,pins = "gph2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	tf_detect: tf-detect {
+	tf_detect: tf-detect-pins {
 		samsung,pins = "gph3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	wifi_wake: wifi-wake {
+	wifi_wake: wifi-wake-pins {
 		samsung,pins = "gph3-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	magnetometer_i2c_pins: yas529-i2c-pins {
+	magnetometer_i2c_pins: yas529-i2c-pins-pins {
 		samsung,pins = "gpj0-0", "gpj0-1";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	ts_irq: ts-irq {
+	ts_irq: ts-irq-pins {
 		samsung,pins = "gpj0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	vibrator_ena: vibrator-ena {
+	vibrator_ena: vibrator-ena-pins {
 		samsung,pins = "gpj1-1";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	gp2a_power: gp2a-power {
+	gp2a_power: gp2a-power-pins {
 		samsung,pins = "gpj1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
@@ -771,7 +771,7 @@ touchkey_i2c_pins: touchkey-i2c-pins {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	touchkey_vdd_ena: touchkey-vdd-ena {
+	touchkey_vdd_ena: touchkey-vdd-ena-pins {
 		samsung,pins = "gpj3-2";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
@@ -789,13 +789,13 @@ accel_i2c_pins: accel-i2c-pins {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pmic_i2c_pins: pmic-i2c-pins {
+	pmic_i2c_pins: pmic-i2c-pins-pins {
 		samsung,pins = "gpj4-0", "gpj4-3";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	touchkey_irq: touchkey-irq {
+	touchkey_irq: touchkey-irq-pins {
 		samsung,pins = "gpj4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
@@ -820,7 +820,7 @@ sound_i2c_pins: sound-i2c-pins {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	panel_rst: panel-rst {
+	panel_rst: panel-rst-pins {
 		samsung,pins = "mp05-5";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index 7427c84f1126..dfb2ee65e4a8 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -126,39 +126,39 @@ &pinctrl0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep_cfg>;
 
-	headset_det: headset-det {
+	headset_det: headset-det-pins {
 		samsung,pins = "gph0-6", "gph3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	fg_irq: fg-irq {
+	fg_irq: fg-irq-pins {
 		samsung,pins = "gph3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	headset_micbias_ena: headset-micbias-ena {
+	headset_micbias_ena: headset-micbias-ena-pins {
 		samsung,pins = "gpj2-5";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	earpath_sel: earpath-sel {
+	earpath_sel: earpath-sel-pins {
 		samsung,pins = "gpj2-6";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	main_micbias_ena: main-micbias-ena {
+	main_micbias_ena: main-micbias-ena-pins {
 		samsung,pins = "gpj4-2";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	/* Based on vendor kernel v2.6.35.7 */
-	sleep_cfg: sleep-cfg {
+	sleep_cfg: sleep-state {
 		PIN_SLP(gpa0-0, PREV, NONE);
 		PIN_SLP(gpa0-1, PREV, NONE);
 		PIN_SLP(gpa0-2, PREV, NONE);
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index eeec2bdece11..a78caaa1f3c5 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -150,53 +150,53 @@ &pinctrl0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep_cfg>;
 
-	fm_i2c_pins: fm-i2c-pins {
+	fm_i2c_pins: fm-i2c-pins-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	headset_det: headset-det {
+	headset_det: headset-det-pins {
 		samsung,pins = "gph0-6", "gph3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	fm_irq: fm-irq {
+	fm_irq: fm-irq-pins {
 		samsung,pins = "gpj2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	fm_rst: fm-rst {
+	fm_rst: fm-rst-pins {
 		samsung,pins = "gpj2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	earpath_sel: earpath-sel {
+	earpath_sel: earpath-sel-pins {
 		samsung,pins = "gpj2-6";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	massmemory_en: massmemory-en {
+	massmemory_en: massmemory-en-pins {
 		samsung,pins = "gpj2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	micbias_reg_ena: micbias-reg-ena {
+	micbias_reg_ena: micbias-reg-ena-pins {
 		samsung,pins = "gpj4-2";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	/* Based on CyanogenMod 3.0.101 kernel */
-	sleep_cfg: sleep-cfg {
+	sleep_cfg: sleep-state {
 		PIN_SLP(gpa0-0, PREV, NONE);
 		PIN_SLP(gpa0-1, PREV, NONE);
 		PIN_SLP(gpa0-2, PREV, NONE);
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index b8c5172c31dd..ae34e7e57892 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -26,7 +26,7 @@ _pin {								\
 	}
 
 &pinctrl0 {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -34,7 +34,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -42,7 +42,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -50,7 +50,7 @@ gpb: gpb {
 		#interrupt-cells = <2>;
 	};
 
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -58,7 +58,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -66,7 +66,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd0: gpd0 {
+	gpd0: gpd0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -74,7 +74,7 @@ gpd0: gpd0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -82,7 +82,7 @@ gpd1: gpd1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe0: gpe0 {
+	gpe0: gpe0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -90,7 +90,7 @@ gpe0: gpe0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe1: gpe1 {
+	gpe1: gpe1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -98,7 +98,7 @@ gpe1: gpe1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -106,7 +106,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -114,7 +114,7 @@ gpf1: gpf1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf2: gpf2 {
+	gpf2: gpf2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -122,7 +122,7 @@ gpf2: gpf2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf3: gpf3 {
+	gpf3: gpf3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -130,7 +130,7 @@ gpf3: gpf3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg0: gpg0 {
+	gpg0: gpg0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -138,7 +138,7 @@ gpg0: gpg0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg1: gpg1 {
+	gpg1: gpg1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -146,7 +146,7 @@ gpg1: gpg1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg2: gpg2 {
+	gpg2: gpg2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -154,7 +154,7 @@ gpg2: gpg2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg3: gpg3 {
+	gpg3: gpg3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -162,7 +162,7 @@ gpg3: gpg3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj0: gpj0 {
+	gpj0: gpj0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -170,7 +170,7 @@ gpj0: gpj0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj1: gpj1 {
+	gpj1: gpj1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -178,7 +178,7 @@ gpj1: gpj1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj2: gpj2 {
+	gpj2: gpj2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -186,7 +186,7 @@ gpj2: gpj2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj3: gpj3 {
+	gpj3: gpj3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -194,7 +194,7 @@ gpj3: gpj3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj4: gpj4 {
+	gpj4: gpj4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -202,47 +202,47 @@ gpj4: gpj4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpi: gpi {
+	gpi: gpi-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	mp01: mp01 {
+	mp01: mp01-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	mp02: mp02 {
+	mp02: mp02-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	mp03: mp03 {
+	mp03: mp03-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	mp04: mp04 {
+	mp04: mp04-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	mp05: mp05 {
+	mp05: mp05-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	mp06: mp06 {
+	mp06: mp06-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	mp07: mp07 {
+	mp07: mp07-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gph0: gph0 {
+	gph0: gph0-gpio-bank {
 		gpio-controller;
 		interrupt-controller;
 		interrupt-parent = <&vic0>;
@@ -252,7 +252,7 @@ gph0: gph0 {
 		#interrupt-cells = <2>;
 	};
 
-	gph1: gph1 {
+	gph1: gph1-gpio-bank {
 		gpio-controller;
 		interrupt-controller;
 		interrupt-parent = <&vic0>;
@@ -262,7 +262,7 @@ gph1: gph1 {
 		#interrupt-cells = <2>;
 	};
 
-	gph2: gph2 {
+	gph2: gph2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -270,7 +270,7 @@ gph2: gph2 {
 		#interrupt-cells = <2>;
 	};
 
-	gph3: gph3 {
+	gph3: gph3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -278,77 +278,77 @@ gph3: gph3 {
 		#interrupt-cells = <2>;
 	};
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa0-0", "gpa0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa0-2", "gpa0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa0-4", "gpa0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa0-6", "gpa0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gpa1-0", "gpa1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart2_fctl: uart2-fctl {
+	uart2_fctl: uart2-fctl-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart3_data: uart3-data {
+	uart3_data: uart3-data-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	uart_audio: uart-audio {
+	uart_audio: uart-audio-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpb-0", "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb-4", "gpb-6", "gpb-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpi-0", "gpi-1", "gpi-2", "gpi-3",
 				"gpi-4", "gpi-5", "gpi-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -356,7 +356,7 @@ i2s0_bus: i2s0-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -364,7 +364,7 @@ i2s1_bus: i2s1-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
@@ -372,7 +372,7 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -380,7 +380,7 @@ pcm1_bus: pcm1-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	ac97_bus: ac97-bus {
+	ac97_bus: ac97-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
@@ -388,7 +388,7 @@ ac97_bus: ac97-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -396,7 +396,7 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm2_bus: pcm2-bus {
+	pcm2_bus: pcm2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -404,371 +404,371 @@ pcm2_bus: pcm2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spdif_bus: spdif-bus {
+	spdif_bus: spdif-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	spi2_bus: spi2-bus {
+	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpc1-1", "gpc1-2", "gpc1-3", "gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpd1-0", "gpd1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c1_bus: i2c1-bus {
+	i2c1_bus: i2c1-bus-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c2_bus: i2c2-bus {
+	i2c2_bus: i2c2-bus-pins {
 		samsung,pins = "gpd1-4", "gpd1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm0_out: pwm0-out {
+	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpd0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm1_out: pwm1-out {
+	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpd0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm2_out: pwm2-out {
+	pwm2_out: pwm2-out-pins {
 		samsung,pins = "gpd0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pwm3_out: pwm3-out {
+	pwm3_out: pwm3-out-pins {
 		samsung,pins = "gpd0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row0: keypad-row-0 {
+	keypad_row0: keypad-row-0-pins {
 		samsung,pins = "gph3-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row1: keypad-row-1 {
+	keypad_row1: keypad-row-1-pins {
 		samsung,pins = "gph3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row2: keypad-row-2 {
+	keypad_row2: keypad-row-2-pins {
 		samsung,pins = "gph3-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row3: keypad-row-3 {
+	keypad_row3: keypad-row-3-pins {
 		samsung,pins = "gph3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row4: keypad-row-4 {
+	keypad_row4: keypad-row-4-pins {
 		samsung,pins = "gph3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row5: keypad-row-5 {
+	keypad_row5: keypad-row-5-pins {
 		samsung,pins = "gph3-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row6: keypad-row-6 {
+	keypad_row6: keypad-row-6-pins {
 		samsung,pins = "gph3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_row7: keypad-row-7 {
+	keypad_row7: keypad-row-7-pins {
 		samsung,pins = "gph3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col0: keypad-col-0 {
+	keypad_col0: keypad-col-0-pins {
 		samsung,pins = "gph2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col1: keypad-col-1 {
+	keypad_col1: keypad-col-1-pins {
 		samsung,pins = "gph2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col2: keypad-col-2 {
+	keypad_col2: keypad-col-2-pins {
 		samsung,pins = "gph2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col3: keypad-col-3 {
+	keypad_col3: keypad-col-3-pins {
 		samsung,pins = "gph2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col4: keypad-col-4 {
+	keypad_col4: keypad-col-4-pins {
 		samsung,pins = "gph2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col5: keypad-col-5 {
+	keypad_col5: keypad-col-5-pins {
 		samsung,pins = "gph2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col6: keypad-col-6 {
+	keypad_col6: keypad-col-6-pins {
 		samsung,pins = "gph2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_col7: keypad-col-7 {
+	keypad_col7: keypad-col-7-pins {
 		samsung,pins = "gph2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpg0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpg0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_cd: sd0-cd {
+	sd0_cd: sd0-cd-pins {
 		samsung,pins = "gpg0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_bus1: sd0-bus-width1 {
+	sd0_bus1: sd0-bus-width1-pins {
 		samsung,pins = "gpg0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_bus4: sd0-bus-width4 {
+	sd0_bus4: sd0-bus-width4-pins {
 		samsung,pins = "gpg0-3", "gpg0-4", "gpg0-5", "gpg0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_bus8: sd0-bus-width8 {
+	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpg1-3", "gpg1-4", "gpg1-5", "gpg1-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpg1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpg1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_cd: sd1-cd {
+	sd1_cd: sd1-cd-pins {
 		samsung,pins = "gpg1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_bus1: sd1-bus-width1 {
+	sd1_bus1: sd1-bus-width1-pins {
 		samsung,pins = "gpg1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd1_bus4: sd1-bus-width4 {
+	sd1_bus4: sd1-bus-width4-pins {
 		samsung,pins = "gpg1-3", "gpg1-4", "gpg1-5", "gpg1-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpg2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpg2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_cd: sd2-cd {
+	sd2_cd: sd2-cd-pins {
 		samsung,pins = "gpg2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_bus1: sd2-bus-width1 {
+	sd2_bus1: sd2-bus-width1-pins {
 		samsung,pins = "gpg2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_bus4: sd2-bus-width4 {
+	sd2_bus4: sd2-bus-width4-pins {
 		samsung,pins = "gpg2-3", "gpg2-4", "gpg2-5", "gpg2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd2_bus8: sd2-bus-width8 {
+	sd2_bus8: sd2-bus-width8-pins {
 		samsung,pins = "gpg3-3", "gpg3-4", "gpg3-5", "gpg3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_clk: sd3-clk {
+	sd3_clk: sd3-clk-pins {
 		samsung,pins = "gpg3-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_cmd: sd3-cmd {
+	sd3_cmd: sd3-cmd-pins {
 		samsung,pins = "gpg3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_cd: sd3-cd {
+	sd3_cd: sd3-cd-pins {
 		samsung,pins = "gpg3-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_bus1: sd3-bus-width1 {
+	sd3_bus1: sd3-bus-width1-pins {
 		samsung,pins = "gpg3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd3_bus4: sd3-bus-width4 {
+	sd3_bus4: sd3-bus-width4-pins {
 		samsung,pins = "gpg3-3", "gpg3-4", "gpg3-5", "gpg3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	eint0: ext-int0 {
+	eint0: ext-int0-pins {
 		samsung,pins = "gph0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint8: ext-int8 {
+	eint8: ext-int8-pins {
 		samsung,pins = "gph1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint15: ext-int15 {
+	eint15: ext-int15-pins {
 		samsung,pins = "gph1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint16: ext-int16 {
+	eint16: ext-int16-pins {
 		samsung,pins = "gph2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	eint31: ext-int31 {
+	eint31: ext-int31-pins {
 		samsung,pins = "gph3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	cam_port_a_io: cam-port-a-io {
+	cam_port_a_io: cam-port-a-io-pins {
 		samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
 				"gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
 				"gpe1-0", "gpe1-1", "gpe1-2", "gpe1-4";
@@ -777,21 +777,21 @@ cam_port_a_io: cam-port-a-io {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	cam_port_a_clk_active: cam-port-a-clk-active {
+	cam_port_a_clk_active: cam-port-a-clk-active-pins {
 		samsung,pins = "gpe1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	cam_port_a_clk_idle: cam-port-a-clk-idle {
+	cam_port_a_clk_idle: cam-port-a-clk-idle-pins {
 		samsung,pins = "gpe1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	cam_port_b_io: cam-port-b-io {
+	cam_port_b_io: cam-port-b-io-pins {
 		samsung,pins = "gpj0-0", "gpj0-1", "gpj0-2", "gpj0-3",
 				"gpj0-4", "gpj0-5", "gpj0-6", "gpj0-7",
 				"gpj1-0", "gpj1-1", "gpj1-2", "gpj1-4";
@@ -800,42 +800,42 @@ cam_port_b_io: cam-port-b-io {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	cam_port_b_clk_active: cam-port-b-clk-active {
+	cam_port_b_clk_active: cam-port-b-clk-active-pins {
 		samsung,pins = "gpj1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	cam_port_b_clk_idle: cam-port-b-clk-idle {
+	cam_port_b_clk_idle: cam-port-b-clk-idle-pins {
 		samsung,pins = "gpj1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-		lcd_ctrl: lcd-ctrl {
+	lcd_ctrl: lcd-ctrl-pins {
 		samsung,pins = "gpd0-0", "gpd0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_sync: lcd-sync {
+	lcd_sync: lcd-sync-pins {
 		samsung,pins = "gpf0-0", "gpf0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_clk: lcd-clk {
+	lcd_clk: lcd-clk-pins {
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_data24: lcd-data-width24 {
+	lcd_data24: lcd-data-width24-pins {
 		samsung,pins =  "gpf0-4", "gpf0-5", "gpf0-6", "gpf0-7",
 				"gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3",
 				"gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7",
-- 
2.32.0

