Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9188148B85A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350433AbiAKUSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:18:46 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60214
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345958AbiAKUSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:18 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B21D40A56
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932292;
        bh=zWAYz0TMBM83QzhR4FOf0S6bCPqsB90adPzhV3JNC4A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WdIIo/8+csUPmR23EoX6cNhqG67R3TqhLLJkMUnvUsES2fFhVYTZ8LecfchtSI2G5
         XGTaqi+NrEqBaxhHJfknMfyR8eWYnBJ+18MnUrE/rUfVpH/E7RbIufOrpVr/xVMWpJ
         AVTKhAdzxuHKa9wKOd4NaL/9+QaAk6VRkEOMR3kHAgNNzbKXz0hB6X5PEUX566PUwK
         RbszAEavRmBBeWdKWZtanDWoIfUQtVCHZi/A6TnmZh8maXnDHTJVqAeGOWH/J3zPQK
         UIGSEL+mqpTzsmDMgNw5GyxkolRoPZ8hKnAbSixnZARUT77J61l6+aHJZ9MICM/j5r
         DVqHI1rneeBbw==
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso148094edd.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWAYz0TMBM83QzhR4FOf0S6bCPqsB90adPzhV3JNC4A=;
        b=E+dH7OHfSJXllU4Bqmz38shdV7JVqCq/ecF7xXdtHaFlRUtyf/Wp2p0G88HjuizfnF
         laXid4t3Tx3YQVBXGWvorLBPGKHHUAs/5l+H3pNwx4MEyO6aakK8cDECsddgpu0A2vMq
         ZoNuDzs+f3XK9caGb87qjBEXwqsUgKUgXwE9EnG8G+nPZ7g0rL7peg4mDlYL6gsfHTym
         cH+9B++qfqyRXR/o0uYjPNRbFeHVwcJPTSFr0BZNJWvcQ8Lr2jcz+LxfbZquLT0lwE1C
         qqIAI6Yhw18pKp9x22lcXbpOM/owX+meuTHv/mx+nspPsgj/j7+FNpflT6SkxVuygafs
         xdXA==
X-Gm-Message-State: AOAM531kI5YBsmqmn3L84W0ClI0g+JJd6wUAngocy+/WbiKaPNta2i59
        EMSbFoJwIbXStSTdU/Lx9nJ+CZmzEpf//vyEK0gwD4/BeQ7Tcpl9n2u65ROZwSbWfZvcvECwBA6
        Q2toND4/03KHGbqzrtgbk1TrTWEb0ycdKhg7UIo600A==
X-Received: by 2002:a17:907:7602:: with SMTP id jx2mr4991601ejc.92.1641932290901;
        Tue, 11 Jan 2022 12:18:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJ2cOxprxiKRl2ecSnXca4N2ho20qy/QzxTKjI2NFBSwJJOm7uh4Yha4GxE57ek/HmHkdJzQ==
X-Received: by 2002:a17:907:7602:: with SMTP id jx2mr4991577ejc.92.1641932290577;
        Tue, 11 Jan 2022 12:18:10 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:08 -0800 (PST)
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
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2 14/28] ARM: dts: exynos: align pinctrl with dtschema in Exynos5260
Date:   Tue, 11 Jan 2022 21:17:08 +0100
Message-Id: <20220111201722.327219-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the pin controller related nodes with dtschema.  No functional
change expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi  | 148 ++++++++++-----------
 arch/arm/boot/dts/exynos5260-xyref5260.dts |   2 +-
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
index 17e2f3e0d71e..150607f8103d 100644
--- a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/pinctrl/samsung.h>
 
 &pinctrl_0 {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -20,7 +20,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -28,7 +28,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa2: gpa2 {
+	gpa2: gpa2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -36,7 +36,7 @@ gpa2: gpa2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb0: gpb0 {
+	gpb0: gpb0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -44,7 +44,7 @@ gpb0: gpb0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb1: gpb1 {
+	gpb1: gpb1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -52,7 +52,7 @@ gpb1: gpb1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb2: gpb2 {
+	gpb2: gpb2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -60,7 +60,7 @@ gpb2: gpb2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb3: gpb3 {
+	gpb3: gpb3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -68,7 +68,7 @@ gpb3: gpb3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb4: gpb4 {
+	gpb4: gpb4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -76,7 +76,7 @@ gpb4: gpb4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb5: gpb5 {
+	gpb5: gpb5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -84,7 +84,7 @@ gpb5: gpb5 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd0: gpd0 {
+	gpd0: gpd0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -92,7 +92,7 @@ gpd0: gpd0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -100,7 +100,7 @@ gpd1: gpd1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd2: gpd2 {
+	gpd2: gpd2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -108,7 +108,7 @@ gpd2: gpd2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe0: gpe0 {
+	gpe0: gpe0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -116,7 +116,7 @@ gpe0: gpe0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe1: gpe1 {
+	gpe1: gpe1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -124,7 +124,7 @@ gpe1: gpe1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -132,7 +132,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -140,7 +140,7 @@ gpf1: gpf1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk0: gpk0 {
+	gpk0: gpk0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -148,7 +148,7 @@ gpk0: gpk0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx0: gpx0 {
+	gpx0: gpx0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -164,7 +164,7 @@ gpx0: gpx0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx1: gpx1 {
+	gpx1: gpx1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -180,7 +180,7 @@ gpx1: gpx1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx2: gpx2 {
+	gpx2: gpx2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -188,7 +188,7 @@ gpx2: gpx2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx3: gpx3 {
+	gpx3: gpx3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -196,63 +196,63 @@ gpx3: gpx3 {
 		#interrupt-cells = <2>;
 	};
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa0-0", "gpa0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa0-2", "gpa0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa1-0", "gpa1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gpa1-4", "gpa1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpa2-0", "gpa2-2", "gpa2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	usb3_vbus0_en: usb3-vbus0-en {
+	usb3_vbus0_en: usb3-vbus0-en-pins {
 		samsung,pins = "gpa2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 				"gpb0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -260,7 +260,7 @@ i2s1_bus: i2s1-bus {
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 				"gpb0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -268,105 +268,105 @@ pcm1_bus: pcm1-bus {
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	spdif1_bus: spdif1-bus {
+	spdif1_bus: spdif1-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	spi2_bus: spi2-bus {
+	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-2", "gpb1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c0_hs_bus: i2c0-hs-bus {
+	i2c0_hs_bus: i2c0-hs-bus-pins {
 		samsung,pins = "gpb3-0", "gpb3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c1_hs_bus: i2c1-hs-bus {
+	i2c1_hs_bus: i2c1-hs-bus-pins {
 		samsung,pins = "gpb3-2", "gpb3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c2_hs_bus: i2c2-hs-bus {
+	i2c2_hs_bus: i2c2-hs-bus-pins {
 		samsung,pins = "gpb3-4", "gpb3-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c3_hs_bus: i2c3-hs-bus {
+	i2c3_hs_bus: i2c3-hs-bus-pins {
 		samsung,pins = "gpb3-6", "gpb3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c4_bus: i2c4-bus {
+	i2c4_bus: i2c4-bus-pins {
 		samsung,pins = "gpb4-0", "gpb4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c5_bus: i2c5-bus {
+	i2c5_bus: i2c5-bus-pins {
 		samsung,pins = "gpb4-2", "gpb4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c6_bus: i2c6-bus {
+	i2c6_bus: i2c6-bus-pins {
 		samsung,pins = "gpb4-4", "gpb4-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c7_bus: i2c7-bus {
+	i2c7_bus: i2c7-bus-pins {
 		samsung,pins = "gpb4-6", "gpb4-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c8_bus: i2c8-bus {
+	i2c8_bus: i2c8-bus-pins {
 		samsung,pins = "gpb5-0", "gpb5-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c9_bus: i2c9-bus {
+	i2c9_bus: i2c9-bus-pins {
 		samsung,pins = "gpb5-2", "gpb5-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c10_bus: i2c10-bus {
+	i2c10_bus: i2c10-bus-pins {
 		samsung,pins = "gpb5-4", "gpb5-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	i2c11_bus: i2c11-bus {
+	i2c11_bus: i2c11-bus-pins {
 		samsung,pins = "gpb5-6", "gpb5-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	cam_gpio_a: cam-gpio-a {
+	cam_gpio_a: cam-gpio-a-pins {
 		samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
 			"gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
 			"gpe1-0", "gpe1-1";
@@ -375,7 +375,7 @@ cam_gpio_a: cam-gpio-a {
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	cam_gpio_b: cam-gpio-b {
+	cam_gpio_b: cam-gpio-b-pins {
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3",
 			"gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -383,28 +383,28 @@ cam_gpio_b: cam-gpio-b {
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	cam_i2c1_bus: cam-i2c1-bus {
+	cam_i2c1_bus: cam-i2c1-bus-pins {
 		samsung,pins = "gpf0-2", "gpf0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	cam_i2c0_bus: cam-i2c0-bus {
+	cam_i2c0_bus: cam-i2c0-bus-pins {
 		samsung,pins = "gpf0-0", "gpf0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	cam_spi0_bus: cam-spi0-bus {
+	cam_spi0_bus: cam-spi0-bus-pins {
 		samsung,pins = "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV1>;
 	};
 
-	cam_spi1_bus: cam-spi1-bus {
+	cam_spi1_bus: cam-spi1-bus-pins {
 		samsung,pins = "gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -413,7 +413,7 @@ cam_spi1_bus: cam-spi1-bus {
 };
 
 &pinctrl_1 {
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -421,7 +421,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -429,7 +429,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc2: gpc2 {
+	gpc2: gpc2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -437,7 +437,7 @@ gpc2: gpc2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc3: gpc3 {
+	gpc3: gpc3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -445,7 +445,7 @@ gpc3: gpc3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc4: gpc4 {
+	gpc4: gpc4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -453,112 +453,112 @@ gpc4: gpc4 {
 		#interrupt-cells = <2>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpc0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpc0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd0_bus1: sd0-bus-width1 {
+	sd0_bus1: sd0-bus-width1-pins {
 		samsung,pins = "gpc0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd0_bus4: sd0-bus-width4 {
+	sd0_bus4: sd0-bus-width4-pins {
 		samsung,pins = "gpc0-3", "gpc0-4", "gpc0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd0_bus8: sd0-bus-width8 {
+	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd0_rdqs: sd0-rdqs {
+	sd0_rdqs: sd0-rdqs-pins {
 		samsung,pins = "gpc0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpc1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpc1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd1_bus1: sd1-bus-width1 {
+	sd1_bus1: sd1-bus-width1-pins {
 		samsung,pins = "gpc1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd1_bus4: sd1-bus-width4 {
+	sd1_bus4: sd1-bus-width4-pins {
 		samsung,pins = "gpc1-3", "gpc1-4", "gpc1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd1_bus8: sd1-bus-width8 {
+	sd1_bus8: sd1-bus-width8-pins {
 		samsung,pins = "gpc4-0", "gpc4-1", "gpc4-2", "gpc4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpc2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpc2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd2_cd: sd2-cd {
+	sd2_cd: sd2-cd-pins {
 		samsung,pins = "gpc2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd2_bus1: sd2-bus-width1 {
+	sd2_bus1: sd2-bus-width1-pins {
 		samsung,pins = "gpc2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5260_PIN_DRV_LV6>;
 	};
 
-	sd2_bus4: sd2-bus-width4 {
+	sd2_bus4: sd2-bus-width4-pins {
 		samsung,pins = "gpc2-4", "gpc2-5", "gpc2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
@@ -567,7 +567,7 @@ sd2_bus4: sd2-bus-width4 {
 };
 
 &pinctrl_2 {
-	gpz0: gpz0 {
+	gpz0: gpz0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -575,7 +575,7 @@ gpz0: gpz0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpz1: gpz1 {
+	gpz1: gpz1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 0dc2ec16aa0a..82d8441c8908 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -38,7 +38,7 @@ xrtcxti: xrtcxti {
 };
 
 &pinctrl_0 {
-	hdmi_hpd_irq: hdmi-hpd-irq {
+	hdmi_hpd_irq: hdmi-hpd-irq-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
-- 
2.32.0

