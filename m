Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD24482503
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhLaQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:22:39 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55256
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231443AbhLaQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:22:26 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4EFB6407BD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967744;
        bh=0zRbRSZPVwASP0a16oEo2pWqATsRCl0JAUwR0HxpL/0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lyO/ZI8RSSiB7g9ac1cX8wwm1AMJOmuxqoi/ne69AuAbd3N6YxWFRuDjX/Q6DRWGZ
         /m1sO6Q/UV6bJf3jbGfUqg1/xe5VkPExLe2eGHS09VQxLAyQBbjx4t5GnUOyMF/0Ud
         oisiFL9RtR5GmQh0zbDINqQ28cqB+Fftaa/P4ANnBRLzNVxs4JKmrev7eakazjlqXe
         HpUim95FkQAUB3N8BEsgYn62xAg5TAJvx7o11gAJBKHat1xIhFvu3hcrPv176eLD6x
         eLXDcIdazcDDpgLF+ZUCTZOFXQPCMZmBgCA2++g/wc8yYNxw2SxxZPKD3iqH3O2X0K
         elIz9BB2j2Itw==
Received: by mail-lj1-f200.google.com with SMTP id y4-20020a2e95c4000000b0022dbab5f69eso6673221ljh.14
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0zRbRSZPVwASP0a16oEo2pWqATsRCl0JAUwR0HxpL/0=;
        b=ei2XuWM5VFqEjyFpC11DLgQIniURpcrrpKuwj1nr6UmYyEkuRtzrC8sLsuNGkklGVY
         G+yLNmWwidlTw+8ifLZMEYX0RuooktiStq8JvLqbGRLKmjAcbcTXXp3cST1ru7hRs37w
         LWYoiZq1ir3BRSd9uOUhEiUl/Z+QQQ8ZD6rfrO967oLtTlBGY3wQmGmkoxxu2DrdZPta
         dhKkTjrgNx+f3HDBwtE/wtzWOgGBjg2sUiXhlSERrJu4AllYjYgcTcTCBaxntw0UBKzA
         Hj1Iy73xoIGVbkGmKYici0u/PqeRqJi/gPbcEVxhl1Ti8IwkKYtP1Y5e+SneMv3PDmpH
         uLcA==
X-Gm-Message-State: AOAM533LvAQNS+DdwQiMIPpDPhuK92Q/dQSFl8SBbTdQqHfUEGjduq4k
        N6U6Moj38uc7NEUzU4qOO6V7Kr1jJaup7DxrPTrBzgOfVPKU037nKaAc9hgwTHW1c9gVUWPal4y
        GNRys5mJZAAPKr6mKjL0PVu3NcwCoFp9m1skfp3aLog==
X-Received: by 2002:a19:6e42:: with SMTP id q2mr31900482lfk.60.1640967743424;
        Fri, 31 Dec 2021 08:22:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJzyLsqCj4AQ0sO8/bBvRHLsjHNZnA5j2r6mvdL/xiQryLRokbAl1hGcv/N4knNKAVqWS5GA==
X-Received: by 2002:a19:6e42:: with SMTP id q2mr31900465lfk.60.1640967743180;
        Fri, 31 Dec 2021 08:22:23 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm2796514lfa.75.2021.12.31.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:22:22 -0800 (PST)
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
Subject: [PATCH 15/24] ARM: dts: exynos: align pinctrl with dtschema in Exynos5410
Date:   Fri, 31 Dec 2021 17:21:58 +0100
Message-Id: <20211231162207.257478-9-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/exynos5410-odroidxu.dts |  10 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi | 170 +++++++++++-----------
 arch/arm/boot/dts/exynos5410-smdk5410.dts |   4 +-
 3 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 9f2200dd5b43..ca121859b124 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -547,14 +547,14 @@ &mmc_2 {
 };
 
 &pinctrl_0 {
-	emmc_nrst_pin: emmc-nrst {
+	emmc_nrst_pin: emmc-nrst-pins {
 		samsung,pins = "gpd1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	sd2_wp: sd2-wp {
+	sd2_wp: sd2-wp-pins {
 		samsung,pins = "gpm5-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		/* Pin is floating so be sure to disable write-protect */
@@ -562,14 +562,14 @@ sd2_wp: sd2-wp {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	pmic_dvs_2: pmic-dvs-2 {
+	pmic_dvs_2: pmic-dvs-2-pins {
 		samsung,pins = "gpx0-0", "gpx0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	pmic_dvs_1: pmic-dvs-1 {
+	pmic_dvs_1: pmic-dvs-1-pins {
 		samsung,pins = "gpx0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -577,7 +577,7 @@ pmic_dvs_1: pmic-dvs-1 {
 		samsung,pin-val = <1>;
 	};
 
-	max77802_irq: max77802-irq {
+	max77802_irq: max77802-irq-pins {
 		samsung,pins = "gpx0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index 9599ba8ba798..6c7814b4372e 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -9,7 +9,7 @@
 #include <dt-bindings/pinctrl/samsung.h>
 
 &pinctrl_0 {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -17,7 +17,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -25,7 +25,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa2: gpa2 {
+	gpa2: gpa2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -33,7 +33,7 @@ gpa2: gpa2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb0: gpb0 {
+	gpb0: gpb0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -41,7 +41,7 @@ gpb0: gpb0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb1: gpb1 {
+	gpb1: gpb1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -49,7 +49,7 @@ gpb1: gpb1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb2: gpb2 {
+	gpb2: gpb2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -57,7 +57,7 @@ gpb2: gpb2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb3: gpb3 {
+	gpb3: gpb3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -65,7 +65,7 @@ gpb3: gpb3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -73,7 +73,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc3: gpc3 {
+	gpc3: gpc3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -81,7 +81,7 @@ gpc3: gpc3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -89,7 +89,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc2: gpc2 {
+	gpc2: gpc2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -97,12 +97,12 @@ gpc2: gpc2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm5: gpm5 {
+	gpm5: gpm5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -110,7 +110,7 @@ gpd1: gpd1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe0: gpe0 {
+	gpe0: gpe0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -118,7 +118,7 @@ gpe0: gpe0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpe1: gpe1 {
+	gpe1: gpe1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -126,7 +126,7 @@ gpe1: gpe1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -134,7 +134,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -142,7 +142,7 @@ gpf1: gpf1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg0: gpg0 {
+	gpg0: gpg0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -150,7 +150,7 @@ gpg0: gpg0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg1: gpg1 {
+	gpg1: gpg1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -158,7 +158,7 @@ gpg1: gpg1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg2: gpg2 {
+	gpg2: gpg2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -166,7 +166,7 @@ gpg2: gpg2 {
 		#interrupt-cells = <2>;
 	};
 
-	gph0: gph0 {
+	gph0: gph0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -174,7 +174,7 @@ gph0: gph0 {
 		#interrupt-cells = <2>;
 	};
 
-	gph1: gph1 {
+	gph1: gph1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -182,52 +182,52 @@ gph1: gph1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpm7: gpm7 {
+	gpm7: gpm7-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
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
 
-	gpy7: gpy7 {
+	gpy7: gpy7-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpx0: gpx0 {
+	gpx0: gpx0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -244,7 +244,7 @@ gpx0: gpx0 {
 			     <27 1>;
 	};
 
-	gpx1: gpx1 {
+	gpx1: gpx1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -261,7 +261,7 @@ gpx1: gpx1 {
 			     <31 1>;
 	};
 
-	gpx2: gpx2 {
+	gpx2: gpx2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -269,7 +269,7 @@ gpx2: gpx2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpx3: gpx3 {
+	gpx3: gpx3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -277,210 +277,210 @@ gpx3: gpx3 {
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
 
-	sd0_bus8: sd0-bus-width8 {
+	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
@@ -489,7 +489,7 @@ sd0_bus8: sd0-bus-width8 {
 };
 
 &pinctrl_1 {
-	gpj0: gpj0 {
+	gpj0: gpj0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -497,7 +497,7 @@ gpj0: gpj0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj1: gpj1 {
+	gpj1: gpj1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -505,7 +505,7 @@ gpj1: gpj1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj2: gpj2 {
+	gpj2: gpj2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -513,7 +513,7 @@ gpj2: gpj2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj3: gpj3 {
+	gpj3: gpj3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -521,7 +521,7 @@ gpj3: gpj3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpj4: gpj4 {
+	gpj4: gpj4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -529,7 +529,7 @@ gpj4: gpj4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk0: gpk0 {
+	gpk0: gpk0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -537,7 +537,7 @@ gpk0: gpk0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk1: gpk1 {
+	gpk1: gpk1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -545,7 +545,7 @@ gpk1: gpk1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk2: gpk2 {
+	gpk2: gpk2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -553,7 +553,7 @@ gpk2: gpk2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpk3: gpk3 {
+	gpk3: gpk3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -561,28 +561,28 @@ gpk3: gpk3 {
 		#interrupt-cells = <2>;
 	};
 
-	usb3_1_oc: usb3-1-oc {
+	usb3_1_oc: usb3-1-oc-pins {
 		samsung,pins = "gpk2-4", "gpk2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	usb3_1_vbusctrl: usb3-1-vbusctrl {
+	usb3_1_vbusctrl: usb3-1-vbusctrl-pins {
 		samsung,pins = "gpk2-6", "gpk2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	usb3_0_oc: usb3-0-oc {
+	usb3_0_oc: usb3-0-oc-pins {
 		samsung,pins = "gpk3-0", "gpk3-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	usb3_0_vbusctrl: usb3-0-vbusctrl {
+	usb3_0_vbusctrl: usb3-0-vbusctrl-pins {
 		samsung,pins = "gpk3-2", "gpk3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -591,7 +591,7 @@ usb3_0_vbusctrl: usb3-0-vbusctrl {
 };
 
 &pinctrl_2 {
-	gpv0: gpv0 {
+	gpv0: gpv0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -599,7 +599,7 @@ gpv0: gpv0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv1: gpv1 {
+	gpv1: gpv1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -607,7 +607,7 @@ gpv1: gpv1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv2: gpv2 {
+	gpv2: gpv2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -615,7 +615,7 @@ gpv2: gpv2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv3: gpv3 {
+	gpv3: gpv3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -623,7 +623,7 @@ gpv3: gpv3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpv4: gpv4 {
+	gpv4: gpv4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -633,7 +633,7 @@ gpv4: gpv4 {
 };
 
 &pinctrl_3 {
-	gpz: gpz {
+	gpz: gpz-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -641,7 +641,7 @@ gpz: gpz {
 		#interrupt-cells = <2>;
 	};
 
-	audi2s0_bus: audi2s0-bus {
+	audi2s0_bus: audi2s0-bus-pins {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4";
 		samsung,pin-function = <2>;
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 2a3ade77a2de..5b2e567809ae 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -66,14 +66,14 @@ &mmc_2 {
 };
 
 &pinctrl_0 {
-	srom_ctl: srom-ctl {
+	srom_ctl: srom-ctl-pins {
 		samsung,pins = "gpy0-3", "gpy0-4", "gpy0-5",
 			       "gpy1-0", "gpy1-1", "gpy1-2", "gpy1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
-	srom_ebi: srom-ebi {
+	srom_ebi: srom-ebi-pins {
 		samsung,pins = "gpy3-0", "gpy3-1", "gpy3-2", "gpy3-3",
 			       "gpy3-4", "gpy3-5", "gpy3-6", "gpy3-7",
 			       "gpy5-0", "gpy5-1", "gpy5-2", "gpy5-3",
-- 
2.32.0

