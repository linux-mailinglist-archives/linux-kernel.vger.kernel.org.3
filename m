Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECF048250A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhLaQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:22:50 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55328
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231481AbhLaQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:22:32 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C5E8F407BF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967748;
        bh=ufHVnFxvHXFMYI5zpuFbDKTqdJFzFRUr3a7SGQCX5b0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=sC5DMxktw+7iBuXyKD90cCTfDNe36IS2P0cJPNkVDq81yyl2x++c/csOpAMJ6JwzY
         bj8uWxLepwk3036XVz/IW5ns6snEbzNAWo2CzURWGS6PkFJRQwItdb6vUK4GGaXI64
         76pPgpbuXUhEo2GtBbh9YEe88LZgCku2auZOouGi82jQZVxp5blbT1NJtNZ9Ps/MVq
         JHI4FPry+gG1iCWDbQABUUa+Stkx8OoA8IM4xZX4ZtdhCHPKhHMXP1SupLpb+gvHg7
         ecxCKqttrZzo56deKfI+l61R09ruLGBfme8qWRyz04WJ2hGoZ97R0VaeJVYhoMvkqW
         KQwLsUS/Tu6kg==
Received: by mail-lj1-f200.google.com with SMTP id g20-20020a2eb5d4000000b0022e0a6d890dso2558626ljn.15
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufHVnFxvHXFMYI5zpuFbDKTqdJFzFRUr3a7SGQCX5b0=;
        b=twZIQ975GmYSc+G9JDs2/EBReKE+1iDJP4z+3Pl5+CbSt39tYLb6LaaO02FNtT5a4c
         CIqKofdIfCXGoE9HZOGVl/AFnOwhAzQAm3iI6IULtxbyTg5NK+FTmL9huTqAbNOaqPwI
         dplQl7YXXHf7aXFya7mu3uJX2Je/pebxOp5Qc9i5IAhFA2b1B9+WV+wvfPoEUj/eJuXk
         YQgi+IB3Pnxvtc5VxeWaGghUW5s8E8Syp2F2sGFEuFTWjMlqu4kV6Fj5yX/+TM/q6GnW
         UXflYdgdTqJPyiTdl/a5ONX9IT68eoKrTQp1XciOkK7N5yDH0FsQ+Nxme5I0fPnq2bL2
         4sPQ==
X-Gm-Message-State: AOAM5311OxRGqcM53e591+arfjVEU2zgkgH0EZGCJWPk5An5ZAjnYt9F
        vj+QSLfMwSG9zEEqdzcu5DMelbCjGPkWhI9/2BJP80+kYSFyfC8ueXa4T+L8xNKcY2wg7/sf/YV
        jZKRLqAu7bMClgf3lRadOJBVkqXkxoAM5bP2ZbRNmtQ==
X-Received: by 2002:a05:6512:22ca:: with SMTP id g10mr32159288lfu.338.1640967745051;
        Fri, 31 Dec 2021 08:22:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOska4FTOUIfT4hXq51bjV5cDXr4jIYpIvzUcIS1mvLPsKyVRkmuVYZq2E7kq8UUDp0EEluQ==
X-Received: by 2002:a05:6512:22ca:: with SMTP id g10mr32159259lfu.338.1640967744688;
        Fri, 31 Dec 2021 08:22:24 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm2796514lfa.75.2021.12.31.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:22:23 -0800 (PST)
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
Subject: [PATCH 16/24] ARM: dts: exynos: align pinctrl with dtschema in Exynos542x/5800
Date:   Fri, 31 Dec 2021 17:21:59 +0100
Message-Id: <20211231162207.257478-10-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |   2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  36 ++--
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 194 +++++++++---------
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |   6 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   2 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi |   6 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  36 ++--
 7 files changed, 141 insertions(+), 141 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index dfc7f14f5772..327cf7105a35 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -808,7 +808,7 @@ &mmc_2 {
 };
 
 &pinctrl_0 {
-	s2mps11_irq: s2mps11-irq {
+	s2mps11_irq: s2mps11-irq-pins {
 		samsung,pins = "gpx3-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index e8819659081a..915878ee3ec6 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -774,14 +774,14 @@ &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mask_tpm_reset>;
 
-	wifi_en: wifi-en {
+	wifi_en: wifi-en-pins {
 		samsung,pins = "gpx0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	max98090_irq: max98090-irq {
+	max98090_irq: max98090-irq-pins {
 		samsung,pins = "gpx0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -789,7 +789,7 @@ max98090_irq: max98090-irq {
 	};
 
 	/* We need GPX0_6 to be low at sleep time; just keep it low always */
-	mask_tpm_reset: mask-tpm-reset {
+	mask_tpm_reset: mask-tpm-reset-pins {
 		samsung,pins = "gpx0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -797,70 +797,70 @@ mask_tpm_reset: mask-tpm-reset {
 		samsung,pin-val = <0>;
 	};
 
-	tpm_irq: tpm-irq {
+	tpm_irq: tpm-irq-pins {
 		samsung,pins = "gpx1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	trackpad_irq: trackpad-irq {
+	trackpad_irq: trackpad-irq-pins {
 		samsung,pins = "gpx1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	power_key_irq: power-key-irq {
+	power_key_irq: power-key-irq-pins {
 		samsung,pins = "gpx1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	ec_irq: ec-irq {
+	ec_irq: ec-irq-pins {
 		samsung,pins = "gpx1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	tps65090_irq: tps65090-irq {
+	tps65090_irq: tps65090-irq-pins {
 		samsung,pins = "gpx2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	dp_hpd_gpio: dp_hpd_gpio {
+	dp_hpd_gpio: dp-hpd-gpio-pins {
 		samsung,pins = "gpx2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	max77802_irq: max77802-irq {
+	max77802_irq: max77802-irq-pins {
 		samsung,pins = "gpx3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	lid_irq: lid-irq {
+	lid_irq: lid-irq-pins {
 		samsung,pins = "gpx3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	hdmi_hpd_irq: hdmi-hpd-irq {
+	hdmi_hpd_irq: hdmi-hpd-irq-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pmic_dvs_1: pmic-dvs-1 {
+	pmic_dvs_1: pmic-dvs-1-pins {
 		samsung,pins = "gpy7-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -891,7 +891,7 @@ &sd1_cmd {
 };
 
 &pinctrl_2 {
-	pmic_dvs_2: pmic-dvs-2 {
+	pmic_dvs_2: pmic-dvs-2-pins {
 		samsung,pins = "gpj4-2", "gpj4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -907,28 +907,28 @@ &spi2_bus {
 
 &pinctrl_3 {
 	/* Drive SPI chip select at x2 for better integrity */
-	ec_spi_cs: ec-spi-cs {
+	ec_spi_cs: ec-spi-cs-pins {
 		samsung,pins = "gpb1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
-	usb300_vbus_en: usb300-vbus-en {
+	usb300_vbus_en: usb300-vbus-en-pins {
 		samsung,pins = "gph0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	usb301_vbus_en: usb301-vbus-en {
+	usb301_vbus_en: usb301-vbus-en-pins {
 		samsung,pins = "gph0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pmic_selb: pmic-selb {
+	pmic_selb: pmic-selb-pins {
 		samsung,pins = "gph0-2", "gph0-3", "gph0-4", "gph0-5",
 			       "gph0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index b82af7c89654..546ba274f4e5 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/pinctrl/samsung.h>
 
 &pinctrl_0 {
-	gpy7: gpy7 {
+	gpy7: gpy7-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -20,7 +20,7 @@ gpy7: gpy7 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx0: gpx0 {
+	gpx0: gpx0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -31,7 +31,7 @@ gpx0: gpx0 {
 			     <26 0>, <26 1>, <27 0>, <27 1>;
 	};
 
-	gpx1: gpx1 {
+	gpx1: gpx1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -42,7 +42,7 @@ gpx1: gpx1 {
 			     <30 0>, <30 1>, <31 0>, <31 1>;
 	};
 
-	gpx2: gpx2 {
+	gpx2: gpx2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -50,7 +50,7 @@ gpx2: gpx2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx3: gpx3 {
+	gpx3: gpx3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -58,14 +58,14 @@ gpx3: gpx3 {
 		#interrupt-cells = <2>;
 	};
 
-	dp_hpd: dp_hpd {
+	dp_hpd: dp-hpd-pins {
 		samsung,pins = "gpx0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	hdmi_cec: hdmi-cec {
+	hdmi_cec: hdmi-cec-pins {
 		samsung,pins = "gpx3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -74,7 +74,7 @@ hdmi_cec: hdmi-cec {
 };
 
 &pinctrl_1 {
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -82,7 +82,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -90,7 +90,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc2: gpc2 {
+	gpc2: gpc2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -98,7 +98,7 @@ gpc2: gpc2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc3: gpc3 {
+	gpc3: gpc3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -106,7 +106,7 @@ gpc3: gpc3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc4: gpc4 {
+	gpc4: gpc4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -114,7 +114,7 @@ gpc4: gpc4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -122,175 +122,175 @@ gpd1: gpd1 {
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
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpc0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpc0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd0_cd: sd0-cd {
+	sd0_cd: sd0-cd-pins {
 		samsung,pins = "gpc0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd0_bus1: sd0-bus-width1 {
+	sd0_bus1: sd0-bus-width1-pins {
 		samsung,pins = "gpc0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd0_bus4: sd0-bus-width4 {
+	sd0_bus4: sd0-bus-width4-pins {
 		samsung,pins = "gpc0-4", "gpc0-5", "gpc0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd0_bus8: sd0-bus-width8 {
+	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd0_rclk: sd0-rclk {
+	sd0_rclk: sd0-rclk-pins {
 		samsung,pins = "gpc0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpc1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpc1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd1_cd: sd1-cd {
+	sd1_cd: sd1-cd-pins {
 		samsung,pins = "gpc1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd1_int: sd1-int {
+	sd1_int: sd1-int-pins {
 		samsung,pins = "gpd1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	sd1_bus1: sd1-bus-width1 {
+	sd1_bus1: sd1-bus-width1-pins {
 		samsung,pins = "gpc1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd1_bus4: sd1-bus-width4 {
+	sd1_bus4: sd1-bus-width4-pins {
 		samsung,pins = "gpc1-4", "gpc1-5", "gpc1-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd1_bus8: sd1-bus-width8 {
+	sd1_bus8: sd1-bus-width8-pins {
 		samsung,pins = "gpd1-4", "gpd1-5", "gpd1-6", "gpd1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpc2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpc2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd2_cd: sd2-cd {
+	sd2_cd: sd2-cd-pins {
 		samsung,pins = "gpc2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd2_bus1: sd2-bus-width1 {
+	sd2_bus1: sd2-bus-width1-pins {
 		samsung,pins = "gpc2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd2_bus4: sd2-bus-width4 {
+	sd2_bus4: sd2-bus-width4-pins {
 		samsung,pins = "gpc2-4", "gpc2-5", "gpc2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	sd2_wp: sd2-wp {
+	sd2_wp: sd2-wp-pins {
 		samsung,pins = "gpc4-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -299,7 +299,7 @@ sd2_wp: sd2-wp {
 };
 
 &pinctrl_2 {
-	gpe0: gpe0 {
+	gpe0: gpe0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -307,7 +307,7 @@ gpe0: gpe0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe1: gpe1 {
+	gpe1: gpe1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -315,7 +315,7 @@ gpe1: gpe1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -323,7 +323,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -331,7 +331,7 @@ gpf1: gpf1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg0: gpg0 {
+	gpg0: gpg0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -339,7 +339,7 @@ gpg0: gpg0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg1: gpg1 {
+	gpg1: gpg1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -347,7 +347,7 @@ gpg1: gpg1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg2: gpg2 {
+	gpg2: gpg2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -355,7 +355,7 @@ gpg2: gpg2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj4: gpj4 {
+	gpj4: gpj4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -363,7 +363,7 @@ gpj4: gpj4 {
 		#interrupt-cells = <2>;
 	};
 
-	cam_gpio_a: cam-gpio-a {
+	cam_gpio_a: cam-gpio-a-pins {
 		samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
 			       "gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
 			       "gpe1-0", "gpe1-1";
@@ -372,7 +372,7 @@ cam_gpio_a: cam-gpio-a {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	cam_gpio_b: cam-gpio-b {
+	cam_gpio_b: cam-gpio-b-pins {
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3",
 			       "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -380,42 +380,42 @@ cam_gpio_b: cam-gpio-b {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	cam_i2c2_bus: cam-i2c2-bus {
+	cam_i2c2_bus: cam-i2c2-bus-pins {
 		samsung,pins = "gpf0-4", "gpf0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	cam_spi1_bus: cam-spi1-bus {
+	cam_spi1_bus: cam-spi1-bus-pins {
 		samsung,pins = "gpe0-4", "gpe0-5", "gpf0-2", "gpf0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	cam_i2c1_bus: cam-i2c1-bus {
+	cam_i2c1_bus: cam-i2c1-bus-pins {
 		samsung,pins = "gpf0-2", "gpf0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	cam_i2c0_bus: cam-i2c0-bus {
+	cam_i2c0_bus: cam-i2c0-bus-pins {
 		samsung,pins = "gpf0-0", "gpf0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	cam_spi0_bus: cam-spi0-bus {
+	cam_spi0_bus: cam-spi0-bus-pins {
 		samsung,pins = "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	cam_bayrgb_bus: cam-bayrgb-bus {
+	cam_bayrgb_bus: cam-bayrgb-bus-pins {
 		samsung,pins = "gpg0-0", "gpg0-1", "gpg0-2", "gpg0-3",
 			       "gpg0-4", "gpg0-5", "gpg0-6", "gpg0-7",
 			       "gpg1-0", "gpg1-1", "gpg1-2", "gpg1-3",
@@ -428,7 +428,7 @@ cam_bayrgb_bus: cam-bayrgb-bus {
 };
 
 &pinctrl_3 {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -436,7 +436,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -444,7 +444,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa2: gpa2 {
+	gpa2: gpa2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -452,7 +452,7 @@ gpa2: gpa2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb0: gpb0 {
+	gpb0: gpb0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -460,7 +460,7 @@ gpb0: gpb0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb1: gpb1 {
+	gpb1: gpb1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -468,7 +468,7 @@ gpb1: gpb1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb2: gpb2 {
+	gpb2: gpb2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -476,7 +476,7 @@ gpb2: gpb2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb3: gpb3 {
+	gpb3: gpb3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -484,7 +484,7 @@ gpb3: gpb3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb4: gpb4 {
+	gpb4: gpb4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -492,7 +492,7 @@ gpb4: gpb4 {
 		#interrupt-cells = <2>;
 	};
 
-	gph0: gph0 {
+	gph0: gph0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -500,98 +500,98 @@ gph0: gph0 {
 		#interrupt-cells = <2>;
 	};
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa0-0", "gpa0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa0-2", "gpa0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa0-4", "gpa0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa0-6", "gpa0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c2_bus: i2c2-bus {
+	i2c2_bus: i2c2-bus-pins {
 		samsung,pins = "gpa0-6", "gpa0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gpa1-0", "gpa1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	uart2_fctl: uart2-fctl {
+	uart2_fctl: uart2-fctl-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c3_bus: i2c3-bus {
+	i2c3_bus: i2c3-bus-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	uart3_data: uart3-data {
+	uart3_data: uart3-data-pins {
 		samsung,pins = "gpa1-4", "gpa1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpa2-0", "gpa2-1", "gpa2-2", "gpa2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c4_hs_bus: i2c4-hs-bus {
+	i2c4_hs_bus: i2c4-hs-bus-pins {
 		samsung,pins = "gpa2-0", "gpa2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c5_hs_bus: i2c5-hs-bus {
+	i2c5_hs_bus: i2c5-hs-bus-pins {
 		samsung,pins = "gpa2-2", "gpa2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 			       "gpb0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -599,7 +599,7 @@ i2s1_bus: i2s1-bus {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 			       "gpb0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -607,7 +607,7 @@ pcm1_bus: pcm1-bus {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
 			       "gpb1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -615,7 +615,7 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pcm2_bus: pcm2-bus {
+	pcm2_bus: pcm2-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
 			       "gpb1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -623,91 +623,91 @@ pcm2_bus: pcm2-bus {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	spdif_bus: spdif-bus {
+	spdif_bus: spdif-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	spi2_bus: spi2-bus {
+	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpb1-1", "gpb1-3", "gpb1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c6_hs_bus: i2c6-hs-bus {
+	i2c6_hs_bus: i2c6-hs-bus-pins {
 		samsung,pins = "gpb1-3", "gpb1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pwm0_out: pwm0-out {
+	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpb2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pwm1_out: pwm1-out {
+	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpb2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pwm2_out: pwm2-out {
+	pwm2_out: pwm2-out-pins {
 		samsung,pins = "gpb2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pwm3_out: pwm3-out {
+	pwm3_out: pwm3-out-pins {
 		samsung,pins = "gpb2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c7_hs_bus: i2c7-hs-bus {
+	i2c7_hs_bus: i2c7-hs-bus-pins {
 		samsung,pins = "gpb2-2", "gpb2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpb3-0", "gpb3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c1_bus: i2c1-bus {
+	i2c1_bus: i2c1-bus-pins {
 		samsung,pins = "gpb3-2", "gpb3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c8_hs_bus: i2c8-hs-bus {
+	i2c8_hs_bus: i2c8-hs-bus-pins {
 		samsung,pins = "gpb3-4", "gpb3-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c9_hs_bus: i2c9-hs-bus {
+	i2c9_hs_bus: i2c9-hs-bus-pins {
 		samsung,pins = "gpb3-6", "gpb3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	i2c10_hs_bus: i2c10-hs-bus {
+	i2c10_hs_bus: i2c10-hs-bus-pins {
 		samsung,pins = "gpb4-0", "gpb4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
@@ -716,7 +716,7 @@ i2c10_hs_bus: i2c10-hs-bus {
 };
 
 &pinctrl_4 {
-	gpz: gpz {
+	gpz: gpz-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -724,7 +724,7 @@ gpz: gpz {
 		#interrupt-cells = <2>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4", "gpz-5", "gpz-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index a4f0e3ffedbd..b8b1418d36e3 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -377,7 +377,7 @@ &mmc_2 {
 };
 
 &pinctrl_0 {
-	hdmi_hpd_irq: hdmi-hpd-irq {
+	hdmi_hpd_irq: hdmi-hpd-irq-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -386,14 +386,14 @@ hdmi_hpd_irq: hdmi-hpd-irq {
 };
 
 &pinctrl_2 {
-	usb300_vbus_en: usb300-vbus-en {
+	usb300_vbus_en: usb300-vbus-en-pins {
 		samsung,pins = "gpg0-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	usb301_vbus_en: usb301-vbus-en {
+	usb301_vbus_en: usb301-vbus-en-pins {
 		samsung,pins = "gpg1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index e7958dbecfd2..24c428b84192 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -999,7 +999,7 @@ &nocp_mem1_1 {
 };
 
 &pinctrl_0 {
-	s2mps11_irq: s2mps11-irq {
+	s2mps11_irq: s2mps11-irq-pins {
 		samsung,pins = "gpx0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index e35af40a55cb..a6961ff24030 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -480,14 +480,14 @@ &mmc_0 {
 };
 
 &pinctrl_0 {
-	power_key: power-key {
+	power_key: power-key-pins {
 		samsung,pins = "gpx0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	hdmi_hpd_irq: hdmi-hpd-irq {
+	hdmi_hpd_irq: hdmi-hpd-irq-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -496,7 +496,7 @@ hdmi_hpd_irq: hdmi-hpd-irq {
 };
 
 &pinctrl_1 {
-	emmc_nrst_pin: emmc-nrst {
+	emmc_nrst_pin: emmc-nrst-pins {
 		samsung,pins = "gpd1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index eca805b83816..3bc40840573f 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -756,14 +756,14 @@ &pinctrl_0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mask_tpm_reset>;
 
-	wifi_en: wifi-en {
+	wifi_en: wifi-en-pins {
 		samsung,pins = "gpx0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	max98091_irq: max98091-irq {
+	max98091_irq: max98091-irq-pins {
 		samsung,pins = "gpx0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -771,7 +771,7 @@ max98091_irq: max98091-irq {
 	};
 
 	/* We need GPX0_6 to be low at sleep time; just keep it low always */
-	mask_tpm_reset: mask-tpm-reset {
+	mask_tpm_reset: mask-tpm-reset-pins {
 		samsung,pins = "gpx0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -779,70 +779,70 @@ mask_tpm_reset: mask-tpm-reset {
 		samsung,pin-val = <0>;
 	};
 
-	tpm_irq: tpm-irq {
+	tpm_irq: tpm-irq-pins {
 		samsung,pins = "gpx1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	trackpad_irq: trackpad-irq {
+	trackpad_irq: trackpad-irq-pins {
 		samsung,pins = "gpx1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	power_key_irq: power-key-irq {
+	power_key_irq: power-key-irq-pins {
 		samsung,pins = "gpx1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	ec_irq: ec-irq {
+	ec_irq: ec-irq-pins {
 		samsung,pins = "gpx1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	tps65090_irq: tps65090-irq {
+	tps65090_irq: tps65090-irq-pins {
 		samsung,pins = "gpx2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	dp_hpd_gpio: dp_hpd_gpio {
+	dp_hpd_gpio: dp-hpd-gpio-pins {
 		samsung,pins = "gpx2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	max77802_irq: max77802-irq {
+	max77802_irq: max77802-irq-pins {
 		samsung,pins = "gpx3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	lid_irq: lid-irq {
+	lid_irq: lid-irq-pins {
 		samsung,pins = "gpx3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	hdmi_hpd_irq: hdmi-hpd-irq {
+	hdmi_hpd_irq: hdmi-hpd-irq-pins {
 		samsung,pins = "gpx3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pmic_dvs_1: pmic-dvs-1 {
+	pmic_dvs_1: pmic-dvs-1-pins {
 		samsung,pins = "gpy7-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -873,7 +873,7 @@ &sd1_cmd {
 };
 
 &pinctrl_2 {
-	pmic_dvs_2: pmic-dvs-2 {
+	pmic_dvs_2: pmic-dvs-2-pins {
 		samsung,pins = "gpj4-2", "gpj4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -889,28 +889,28 @@ &spi2_bus {
 
 &pinctrl_3 {
 	/* Drive SPI chip select at x2 for better integrity */
-	ec_spi_cs: ec-spi-cs {
+	ec_spi_cs: ec-spi-cs-pins {
 		samsung,pins = "gpb1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
-	usb300_vbus_en: usb300-vbus-en {
+	usb300_vbus_en: usb300-vbus-en-pins {
 		samsung,pins = "gph0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	usb301_vbus_en: usb301-vbus-en {
+	usb301_vbus_en: usb301-vbus-en-pins {
 		samsung,pins = "gph0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pmic_selb: pmic-selb {
+	pmic_selb: pmic-selb-pins {
 		samsung,pins = "gph0-2", "gph0-3", "gph0-4", "gph0-5",
 			       "gph0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-- 
2.32.0

