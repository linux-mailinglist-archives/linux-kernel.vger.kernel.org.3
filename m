Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD74824F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhLaQWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:22:24 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46824
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhLaQWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:22:16 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7D4783FFDB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967735;
        bh=IBwCliN08elg6JKl6akAuq3F+Vje5x6dFIvtyINLuLg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=M4j/6i1LiN+wdFI4xpZxYXmcApnjm8IFjHpXjGhbDRuKm/gH96WrONeq6ghjSqD+J
         6oMxbyiLheTLMYwygsR8vt+Blne9TRABoSHFy2zMFlVxhPSzgoRzNHKY6hAufkjxeR
         0/LKkiMcQd/PQ1x+ZH8oOdYgFKi4Rilx+E0oJA6GRC3c3t7+qp+s2/hoZYSQNjclTb
         jrCCNz/bV44HNfPQatY0liROULPj+Rn5DrMYv9IVeZDgaRF2P7FYyrtpB/gCoV9e/r
         75ipRdBNn1Z7GnlhPOgsGmQItvCtaZV2tZH34EoZCiADMD4aP1TGBThDvomCgUpYUc
         Pw7CyFiKnXrCQ==
Received: by mail-lj1-f197.google.com with SMTP id e7-20020a05651c090700b0022d70efe931so9488091ljq.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBwCliN08elg6JKl6akAuq3F+Vje5x6dFIvtyINLuLg=;
        b=3Bu3VhZTelQs6Xxuthyz+uaBQO1w3Cb9OfZBfj/UmFI83La1RkDlYS6If++rC3ookj
         qBqh6mLGfAf+fsVBq7BFYB7ckbj9E78N5YULrIJMEbwMnUiKWNCJK/Q/halg0qwaP5sm
         MbiMZeFemdOT8JXioo4YtLZYQ+QcZPeQkXwPTOCY3EXJjPqeebF4k1sTEJNbkgA0Wa9a
         WM/qo5G3t8mUrDOJGQxw6mNZz9gMTeKXplCBjv1Wf6U6diY5RhmWbPk1AfM9qSHPD6w4
         wSeLnZoHa+swBwRVrSGkwCLd6eWhYEkJ2RiUXp+pMe+B1rdcKhAoCt/IWQEH0iihqMxv
         H5kw==
X-Gm-Message-State: AOAM530ty+mFeOtTG+kL2y1O9jOnVLgZo5guUjyBFmdXsDE3vYWoEZpu
        oh5qWT7urDrJpqhR15GwpLAZjg1SdedCIN9raeecQ4GFNc7sLAXdj6Kcqlxf7kzLOyu6HqZsml/
        eKZ/MGkQwQty8OfoZTq+ZZwYScE8VoNCzD4LBLyfbaw==
X-Received: by 2002:a05:6512:12c6:: with SMTP id p6mr32707782lfg.221.1640967734731;
        Fri, 31 Dec 2021 08:22:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztJQjPe+a4AXzsabLL4pRqlpw6S2ji7vpTT/q+j4PV9vZ14kDCJ4dRTq3fBj4GO1mMb6C2Eg==
X-Received: by 2002:a05:6512:12c6:: with SMTP id p6mr32707764lfg.221.1640967734472;
        Fri, 31 Dec 2021 08:22:14 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm2796514lfa.75.2021.12.31.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:22:13 -0800 (PST)
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
Subject: [PATCH 10/24] ARM: dts: exynos: align pinctrl with dtschema in Exynos3250
Date:   Fri, 31 Dec 2021 17:21:53 +0100
Message-Id: <20211231162207.257478-4-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/exynos3250-artik5.dtsi  |  10 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 140 +++++++++++-----------
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index 829c05b2c405..7b429622a288 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -356,7 +356,7 @@ &mshc_1 {
 };
 
 &pinctrl_1 {
-	bten: bten {
+	bten: bten-pins {
 		samsung,pins ="gpx1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -364,7 +364,7 @@ bten: bten {
 		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
-	wlanen: wlanen {
+	wlanen: wlanen-pins {
 		samsung,pins = "gpx2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -372,12 +372,12 @@ wlanen: wlanen {
 		samsung,pin-val = <1>;
 	};
 
-	s2mps14_irq: s2mps14-irq {
+	s2mps14_irq: s2mps14-irq-pins {
 		samsung,pins = "gpx3-5";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	bthostwake: bthostwake {
+	bthostwake: bthostwake-pins {
 		samsung,pins = "gpx3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
@@ -385,7 +385,7 @@ bthostwake: bthostwake {
 		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	btwake: btwake {
+	btwake: btwake-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index a616cb1aca29..cc30d154ec94 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/pinctrl/samsung.h>
 
 #define PIN_IN(_pin, _pull, _drv)					\
-	_pin {								\
+	pin- ## _pin {							\
 		samsung,pins = #_pin;					\
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;		\
 		samsung,pin-pud = <EXYNOS_PIN_PULL_ ##_pull>;		\
@@ -20,14 +20,14 @@ _pin {								\
 	}
 
 #define PIN_SLP(_pin, _mode, _pull)					\
-	_pin {								\
+	pin- ## _pin {							\
 		samsung,pins = #_pin;					\
 		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_ ##_mode>;	\
 		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_ ##_pull>;	\
 	}
 
 &pinctrl_0 {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -35,7 +35,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -43,7 +43,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -51,7 +51,7 @@ gpb: gpb {
 		#interrupt-cells = <2>;
 	};
 
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -59,7 +59,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -67,7 +67,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd0: gpd0 {
+	gpd0: gpd0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -75,7 +75,7 @@ gpd0: gpd0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -83,84 +83,84 @@ gpd1: gpd1 {
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
 
-	i2c3_bus: i2c3-bus {
+	i2c3_bus: i2c3-bus-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
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
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -168,7 +168,7 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	pcm2_bus: pcm2-bus {
+	pcm2_bus: pcm2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -176,63 +176,63 @@ pcm2_bus: pcm2-bus {
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
-	i2c6_bus: i2c6-bus {
+	i2c6_bus: i2c6-bus-pins {
 		samsung,pins = "gpc1-3", "gpc1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
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
@@ -241,22 +241,22 @@ i2c1_bus: i2c1-bus {
 };
 
 &pinctrl_1 {
-	gpe0: gpe0 {
+	gpe0: gpe0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpe1: gpe1 {
+	gpe1: gpe1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpe2: gpe2 {
+	gpe2: gpe2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpk0: gpk0 {
+	gpk0: gpk0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -264,7 +264,7 @@ gpk0: gpk0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk1: gpk1 {
+	gpk1: gpk1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -272,7 +272,7 @@ gpk1: gpk1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk2: gpk2 {
+	gpk2: gpk2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -280,7 +280,7 @@ gpk2: gpk2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpl0: gpl0 {
+	gpl0: gpl0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -288,7 +288,7 @@ gpl0: gpl0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm0: gpm0 {
+	gpm0: gpm0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -296,7 +296,7 @@ gpm0: gpm0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm1: gpm1 {
+	gpm1: gpm1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -304,7 +304,7 @@ gpm1: gpm1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm2: gpm2 {
+	gpm2: gpm2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -312,7 +312,7 @@ gpm2: gpm2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm3: gpm3 {
+	gpm3: gpm3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -320,7 +320,7 @@ gpm3: gpm3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm4: gpm4 {
+	gpm4: gpm4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -328,7 +328,7 @@ gpm4: gpm4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx0: gpx0 {
+	gpx0: gpx0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -345,7 +345,7 @@ gpx0: gpx0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx1: gpx1 {
+	gpx1: gpx1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -362,7 +362,7 @@ gpx1: gpx1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx2: gpx2 {
+	gpx2: gpx2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -370,7 +370,7 @@ gpx2: gpx2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx3: gpx3 {
+	gpx3: gpx3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -378,126 +378,126 @@ gpx3: gpx3 {
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
 
-	sd0_rdqs: sd0-rdqs {
+	sd0_rdqs: sd0-rdqs-pins {
 		samsung,pins = "gpk0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
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
 		samsung,pins = "gpk0-4", "gpk0-5", "gpk0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	sd0_bus8: sd0-bus-width8 {
+	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpl0-0", "gpl0-1", "gpl0-2", "gpl0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
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
 		samsung,pins = "gpk1-4", "gpk1-5", "gpk1-6";
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
 		samsung,pins = "gpk2-4", "gpk2-5", "gpk2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
-	cam_port_b_io: cam-port-b-io {
+	cam_port_b_io: cam-port-b-io-pins {
 		samsung,pins = "gpm0-0", "gpm0-1", "gpm0-2", "gpm0-3",
 				"gpm0-4", "gpm0-5", "gpm0-6", "gpm0-7",
 				"gpm1-0", "gpm1-1", "gpm2-0", "gpm2-1";
@@ -506,35 +506,35 @@ cam_port_b_io: cam-port-b-io {
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
-- 
2.32.0

