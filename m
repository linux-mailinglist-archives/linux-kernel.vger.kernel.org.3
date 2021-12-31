Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8C4824F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhLaQWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:22:21 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46866
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231350AbhLaQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:22:19 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C68D03FFD0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967737;
        bh=/Ujmj0PRtuAwG4CNFdOUI83O5VMt+iFsu1RsL03powU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p8XdFvg/wT8tEWQy1pC35xGa3g9cSSFDQwHyMbcOn0Ttq8EBcDXWzYpixi1OR6Q2G
         20yUPQOqvgGswy3d9NEwtGSE7fhx8ivVTDjNvzd6xA+4WsoEvZzfG3ypCa1ga2YOws
         0Av9v3+dayvtNM1bGGpXOEu+jBH/y4x9UAQHMwqsvWSi2o3Wcqycf7n2RIvHyUBoIF
         l5ujhfmkOew9qmFlyCjJBnkEjTF3vYOzsnPcV6f+TlyhappVhSl2dwo0PZAEo1cHyi
         uzOMKWdTRhNWa7WV6oFbFsyi5Y13TftqHMV+G3HnbEKAtkN9dHvAUpHN6JrvevZxp6
         nOcgxXtBf4oMw==
Received: by mail-lj1-f199.google.com with SMTP id y8-20020a2e9788000000b0022df5cf52d1so3796102lji.18
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ujmj0PRtuAwG4CNFdOUI83O5VMt+iFsu1RsL03powU=;
        b=nJcUDUGtoXQkjAjtK7BUkJAj8shM/I0AUNOJQQTRHIoYPDzWYniI8RwxgVXVGaFGOo
         R2zm48Tj8M/vqpe65WNnJz56QeUv9OpDAEEcBpj7zHAbs92q3F7qrJlhdmr2TSy8wucQ
         d9Y1yFu1nUcLhPX0A36I/T6TJJXbwOy+YME/FmIi8noGxsEBO6XunrAccUN+3R3QJ0Dn
         vIo0anQJA9hQKptES+P+Nm6RjazZ/2+vj4QQIvlGVTQs4ztTfA7ms0ZMNYPumvmqdrDl
         dzuZ7Tw4d+8PmbGgYiOj0UjjuXLy52i8kq6fRmVDCiOaPByuD23GbDAD1SQuRLzdB1yP
         3sYQ==
X-Gm-Message-State: AOAM5323AqTMYf8UB6kaJ2dSMz4LThhao7RlOpckuYzlkzoXcOheKqD5
        ydZQzYT/6nJ8TbdaDcKA/LOYCEroc2dhv2kLMUoVibrcNp5QzPxLbCcfQbl6bDKaLSYPX/73lCr
        McLWh2ETNZhUpk5J9BajtHHEzEidyIJ5IU73yP7gMdw==
X-Received: by 2002:a05:6512:3485:: with SMTP id v5mr15480998lfr.495.1640967736690;
        Fri, 31 Dec 2021 08:22:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDgfwFuBPFUyCdGa0w6o979Ua6Joufem+3/kUS7x8nc3hDG330S+EXm+MeZsszxwtybHpDeA==
X-Received: by 2002:a05:6512:3485:: with SMTP id v5mr15480982lfr.495.1640967736380;
        Fri, 31 Dec 2021 08:22:16 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm2796514lfa.75.2021.12.31.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:22:15 -0800 (PST)
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
Subject: [PATCH 11/24] ARM: dts: exynos: align pinctrl with dtschema in Exynos4210
Date:   Fri, 31 Dec 2021 17:21:54 +0100
Message-Id: <20211231162207.257478-5-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/exynos4210-i9100.dts        |  30 +--
 arch/arm/boot/dts/exynos4210-origen.dts       |   2 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi     | 226 +++++++++---------
 arch/arm/boot/dts/exynos4210-smdkv310.dts     |   4 +-
 arch/arm/boot/dts/exynos4210-trats.dts        |   6 +-
 .../boot/dts/exynos4210-universal_c210.dts    |  12 +-
 6 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 33894054b8b0..3c0a18b30837 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -672,26 +672,26 @@ &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep0>;
 
-	sleep0: sleep-states {
-		gpa0-0 {
+	sleep0: sleep-state {
+		gpa0-0-pin {
 			samsung,pins = "gpa0-0";
 			samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
 			samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
 		};
 
-		gpa0-1 {
+		gpa0-1-pin {
 			samsung,pins = "gpa0-1";
 			samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT0>;
 			samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
 		};
 
-		gpa0-2 {
+		gpa0-2-pin {
 			samsung,pins = "gpa0-2";
 			samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
 			samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
 		};
 
-		gpa0-3 {
+		gpa0-3-pin {
 			samsung,pins = "gpa0-3";
 			samsung,pin-con-pdn = <EXYNOS_PIN_PDN_OUT1>;
 			samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
@@ -700,19 +700,19 @@ gpa0-3 {
 };
 
 &pinctrl_1 {
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
 
-	usb_sel: usb-sel {
+	usb_sel: usb-sel-pins {
 		samsung,pins = "gpl0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -720,7 +720,7 @@ usb_sel: usb-sel {
 		samsung,pin-val = <0>;
 	};
 
-	bt_en: bt-en {
+	bt_en: bt-en-pins {
 		samsung,pins = "gpl0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -728,7 +728,7 @@ bt_en: bt-en {
 		samsung,pin-val = <0>;
 	};
 
-	bt_res: bt-res {
+	bt_res: bt-res-pins {
 		samsung,pins = "gpl1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -736,7 +736,7 @@ bt_res: bt-res {
 		samsung,pin-val = <0>;
 	};
 
-	otg_gp: otg-gp {
+	otg_gp: otg-gp-pins {
 		samsung,pins = "gpx3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -744,23 +744,23 @@ otg_gp: otg-gp {
 		samsung,pin-val = <0>;
 	};
 
-	mag_mhl_gpio: mag-mhl {
+	mag_mhl_gpio: mag-mhl-pins {
 		samsung,pins = "gpd0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	max8997_irq: max8997-irq {
+	max8997_irq: max8997-irq-pins {
 		samsung,pins = "gpx0-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	max17042_fuel_irq: max17042-fuel-irq {
+	max17042_fuel_irq: max17042-fuel-irq-pins {
 		samsung,pins = "gpx2-3";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	tsp224_irq: tsp224-irq {
+	tsp224_irq: tsp224-irq-pins {
 		samsung,pins = "gpx0-4";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 	};
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 435fda60e86d..a08ce2f37ea2 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -316,7 +316,7 @@ EN32KHZ_AP {
 };
 
 &pinctrl_1 {
-	max8997_irq: max8997-irq {
+	max8997_irq: max8997-irq-pins {
 		samsung,pins = "gpx0-3", "gpx0-4";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 520c5934a8d4..6373009bb727 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -14,7 +14,7 @@
 #include <dt-bindings/pinctrl/samsung.h>
 
 &pinctrl_0 {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -22,7 +22,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -30,7 +30,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -38,7 +38,7 @@ gpb: gpb {
 		#interrupt-cells = <2>;
 	};
 
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -46,7 +46,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -54,7 +54,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd0: gpd0 {
+	gpd0: gpd0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -62,7 +62,7 @@ gpd0: gpd0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -70,7 +70,7 @@ gpd1: gpd1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe0: gpe0 {
+	gpe0: gpe0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -78,7 +78,7 @@ gpe0: gpe0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe1: gpe1 {
+	gpe1: gpe1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -86,7 +86,7 @@ gpe1: gpe1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe2: gpe2 {
+	gpe2: gpe2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -94,7 +94,7 @@ gpe2: gpe2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe3: gpe3 {
+	gpe3: gpe3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -102,7 +102,7 @@ gpe3: gpe3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe4: gpe4 {
+	gpe4: gpe4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -110,7 +110,7 @@ gpe4: gpe4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -118,7 +118,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -126,7 +126,7 @@ gpf1: gpf1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf2: gpf2 {
+	gpf2: gpf2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -134,7 +134,7 @@ gpf2: gpf2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf3: gpf3 {
+	gpf3: gpf3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -142,112 +142,112 @@ gpf3: gpf3 {
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
 		samsung,pins = "gpb-2", "gpb-3";
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
 		samsung,pins = "gpb-6", "gpb-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -255,7 +255,7 @@ i2s1_bus: i2s1-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -263,7 +263,7 @@ pcm1_bus: pcm1-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	ac97_bus: ac97-bus {
+	ac97_bus: ac97-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
@@ -271,7 +271,7 @@ ac97_bus: ac97-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -279,7 +279,7 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm2_bus: pcm2-bus {
+	pcm2_bus: pcm2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -287,105 +287,105 @@ pcm2_bus: pcm2-bus {
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
 		samsung,pins = "gpc1-1", "gpc1-2", "gpc1-3", "gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c7_bus: i2c7-bus {
+	i2c7_bus: i2c7-bus-pins {
 		samsung,pins = "gpd0-2", "gpd0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpd1-0", "gpd1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c1_bus: i2c1-bus {
+	i2c1_bus: i2c1-bus-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
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
 
-	lcd_ctrl: lcd-ctrl {
+	lcd_ctrl: lcd-ctrl-pins {
 		samsung,pins = "gpd0-0", "gpd0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_sync: lcd-sync {
+	lcd_sync: lcd-sync-pins {
 		samsung,pins = "gpf0-0", "gpf0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_en: lcd-en {
+	lcd_en: lcd-en-pins {
 		samsung,pins = "gpe3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
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
@@ -395,7 +395,7 @@ lcd_data16: lcd-data-width16 {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_data18: lcd-data-width18 {
+	lcd_data18: lcd-data-width18-pins {
 		samsung,pins = "gpf0-6", "gpf0-7", "gpf1-0", "gpf1-1",
 				"gpf1-2", "gpf1-3", "gpf1-6", "gpf1-7",
 				"gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
@@ -406,7 +406,7 @@ lcd_data18: lcd-data-width18 {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	lcd_data24: lcd-data-width24 {
+	lcd_data24: lcd-data-width24-pins {
 		samsung,pins = "gpf0-4", "gpf0-5", "gpf0-6", "gpf0-7",
 				"gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3",
 				"gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7",
@@ -420,7 +420,7 @@ lcd_data24: lcd-data-width24 {
 };
 
 &pinctrl_1 {
-	gpj0: gpj0 {
+	gpj0: gpj0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -428,7 +428,7 @@ gpj0: gpj0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj1: gpj1 {
+	gpj1: gpj1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -436,7 +436,7 @@ gpj1: gpj1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk0: gpk0 {
+	gpk0: gpk0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -444,7 +444,7 @@ gpk0: gpk0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk1: gpk1 {
+	gpk1: gpk1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -452,7 +452,7 @@ gpk1: gpk1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk2: gpk2 {
+	gpk2: gpk2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -460,7 +460,7 @@ gpk2: gpk2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk3: gpk3 {
+	gpk3: gpk3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -468,7 +468,7 @@ gpk3: gpk3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpl0: gpl0 {
+	gpl0: gpl0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -476,7 +476,7 @@ gpl0: gpl0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpl1: gpl1 {
+	gpl1: gpl1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -484,7 +484,7 @@ gpl1: gpl1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpl2: gpl2 {
+	gpl2: gpl2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -492,42 +492,42 @@ gpl2: gpl2 {
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
 
@@ -544,7 +544,7 @@ gpx0: gpx0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx1: gpx1 {
+	gpx1: gpx1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -561,7 +561,7 @@ gpx1: gpx1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx2: gpx2 {
+	gpx2: gpx2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -569,7 +569,7 @@ gpx2: gpx2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx3: gpx3 {
+	gpx3: gpx3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -577,238 +577,238 @@ gpx3: gpx3 {
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
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
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
 
-	cam_port_a_io: cam-port-a-io {
+	cam_port_a_io: cam-port-a-io-pins {
 		samsung,pins = "gpj0-0", "gpj0-1", "gpj0-2", "gpj0-3",
 				"gpj0-4", "gpj0-5", "gpj0-6", "gpj0-7",
 				"gpj1-0", "gpj1-1", "gpj1-2", "gpj1-4";
@@ -817,21 +817,21 @@ cam_port_a_io: cam-port-a-io {
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
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	hdmi_cec: hdmi-cec {
+	hdmi_cec: hdmi-cec-pins {
 		samsung,pins = "gpx3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -840,12 +840,12 @@ hdmi_cec: hdmi-cec {
 };
 
 &pinctrl_2 {
-	gpz: gpz {
+	gpz: gpz-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4", "gpz-5", "gpz-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -853,7 +853,7 @@ i2s0_bus: i2s0-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm0_bus: pcm0-bus {
+	pcm0_bus: pcm0-bus-pins {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index d5797a67bf48..a5dfd7fd49b3 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -152,14 +152,14 @@ key-e {
 };
 
 &pinctrl_1 {
-	keypad_rows: keypad-rows {
+	keypad_rows: keypad-rows-pins {
 		samsung,pins = "gpx2-0", "gpx2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	keypad_cols: keypad-cols {
+	keypad_cols: keypad-cols-pins {
 		samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
 			       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 9c4ff7521348..01f44d95f671 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -464,19 +464,19 @@ EN32KHZ_CP {
 };
 
 &pinctrl_1 {
-	bt_shutdown: bt-shutdown {
+	bt_shutdown: bt-shutdown-pins {
 		samsung,pins = "gpl1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
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
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 9f93e7464aed..170d54a0bb5c 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -533,37 +533,37 @@ &ohci {
 };
 
 &pinctrl_1 {
-	bt_shutdown: bt-shutdown {
+	bt_shutdown: bt-shutdown-pins {
 		samsung,pins = "gpe1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
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
 
-	lp3974_irq: lp3974-irq {
+	lp3974_irq: lp3974-irq-pins {
 		samsung,pins = "gpx0-7", "gpx2-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	hdmi_hpd: hdmi-hpd {
+	hdmi_hpd: hdmi-hpd-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 };
 
 &pinctrl_0 {
-	i2c_ddc_bus: i2c-ddc-bus {
+	i2c_ddc_bus: i2c-ddc-bus-pins {
 		samsung,pins = "gpe4-2", "gpe4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-- 
2.32.0

