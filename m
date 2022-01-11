Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D647548B86B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbiAKUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:19:05 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60216
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346418AbiAKUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:28 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81685406EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932303;
        bh=Aysi1lffznSBV7a3FSdAWFRztsJckHNRLd9fRdz5dOY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=XqdLMpWKG7DYW4qo0lhLLfZ4qZ1avnJTgiykHX29MOWbXvRfmqP08faiSfzyzOlNf
         6Do+OrQNHhBzce3uPrVhMntaR2IDC1nv9V3x5u79Ytg0uf0v6/lk4HTHsn3uKxPsQP
         vvgTUIC5IgxdNJ6GdZBFpC+f1qYw2LgjQ5JnsZ9wFI3LO1WsmrpU6jYISQuGmvlGIS
         od8UUIoILlMCfkfSdNkZZ6lYKqS3ndIgDxTzsIXCubFRL4QsCPdizbyNp1Ucn6xJaN
         iufiycTgR9oREKYqnZoEyiFRpIPRjs/bCv2EHkaKaXgHnZ5hE7xn85HxxKcpQ7+3k3
         o8A/iVEZ4Q0Sg==
Received: by mail-ed1-f71.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso148511edd.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aysi1lffznSBV7a3FSdAWFRztsJckHNRLd9fRdz5dOY=;
        b=TrkOjQhuWtq0fmbwjqPkjw0xIjFriytW2EI7aSZ5SMzfpLZ0nrvjZJV23wpZrIKsRj
         sOYcRnRK7JoKL5g1+Vy40YHcNZLAc/uN5yg6kRCn4qZjGzIbMT+yaGcLCjz0Mn9YFZ6j
         idLJ04ibOn58YSUpDYx3hk/Kjfyuw6RIdrp0hD25sS/m4kH5tR0615hR3y06AktnAEyU
         1Nm+R8sBBSIMcpZzXvlGwDq+TIZtAAW6TzaYhgglWl0yF0x/54uBO4BKogGxhIcIeGpL
         MFqc/NC/8DoLRH6dA9V9ObzNld7LjV+G4h+Anj4aJTmBl8YvhV47xrwDOnmrbra7OQu9
         GFKw==
X-Gm-Message-State: AOAM5307vmDrZosdI8faQ7ly8In7xVnYHUPjynPPm1SpPFcK7kq/Ai3Y
        xn/h/G00fB1va2mpMHVncK42hweuK+mrU87CdMZtIjE6w1FJgTQzd5BgZWhPrhBOpjBFAD26+4m
        SPXmQ1mWvPH6QZ25TRgw6T7yMTG8ExrDABB5q6XFR9A==
X-Received: by 2002:a17:906:fa17:: with SMTP id lo23mr4854014ejb.563.1641932302867;
        Tue, 11 Jan 2022 12:18:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE9SFOLPErlL0aQcF7IKGMD4Ufr5Rn8iS1EsX8pHeRa+i2ViB3Lt6YCGtI4XcNhtiHWwjelw==
X-Received: by 2002:a17:906:fa17:: with SMTP id lo23mr4854000ejb.563.1641932302574;
        Tue, 11 Jan 2022 12:18:22 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:22 -0800 (PST)
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
Subject: [PATCH v2 22/28] ARM: dts: s3c64xx: align pinctrl with dtschema
Date:   Tue, 11 Jan 2022 21:17:16 +0100
Message-Id: <20220111201722.327219-16-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/s3c6410-mini6410.dts |   4 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi | 210 ++++++++++++-------------
 2 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 285555b9ed94..17097da36f5e 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -193,12 +193,12 @@ &uart3 {
 };
 
 &pinctrl0 {
-	gpio_leds: gpio-leds {
+	gpio_leds: gpio-leds-pins {
 		samsung,pins = "gpk-4", "gpk-5", "gpk-6", "gpk-7";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	gpio_keys: gpio-keys {
+	gpio_keys: gpio-keys-pins {
 		samsung,pins = "gpn-0", "gpn-1", "gpn-2", "gpn-3",
 				"gpn-4", "gpn-5", "gpl-11", "gpl-12";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
index 8e9594d64b57..0a3186d57cb5 100644
--- a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
@@ -16,111 +16,111 @@ &pinctrl0 {
 	 * Pin banks
 	 */
 
-	gpa: gpa {
+	gpa: gpa-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpc: gpc {
+	gpc: gpc-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpd: gpd {
+	gpd: gpd-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpe: gpe {
+	gpe: gpe-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpf: gpf {
+	gpf: gpf-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpg: gpg {
+	gpg: gpg-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gph: gph {
+	gph: gph-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpi: gpi {
+	gpi: gpi-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpj: gpj {
+	gpj: gpj-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpk: gpk {
+	gpk: gpk-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpl: gpl {
+	gpl: gpl-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpm: gpm {
+	gpm: gpm-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpn: gpn {
+	gpn: gpn-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpo: gpo {
+	gpo: gpo-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpp: gpp {
+	gpp: gpp-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpq: gpq {
+	gpq: gpq-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
@@ -131,225 +131,225 @@ gpq: gpq {
 	 * Pin groups
 	 */
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa-0", "gpa-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa-2", "gpa-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa-4", "gpa-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa-6", "gpa-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart3_data: uart3-data {
+	uart3_data: uart3-data-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ext_dma_0: ext-dma-0 {
+	ext_dma_0: ext-dma-0-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ext_dma_1: ext-dma-1 {
+	ext_dma_1: ext-dma-1-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_data_0: irda-data-0 {
+	irda_data_0: irda-data-0-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_data_1: irda-data-1 {
+	irda_data_1: irda-data-1-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_sdbw: irda-sdbw {
+	irda_sdbw: irda-sdbw-pins {
 		samsung,pins = "gpb-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpb-5", "gpb-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	i2c1_bus: i2c1-bus {
+	i2c1_bus: i2c1-bus-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_6>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpc-0", "gpc-1", "gpc-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi0_cs: spi0-cs {
+	spi0_cs: spi0-cs-pins {
 		samsung,pins = "gpc-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpc-4", "gpc-5", "gpc-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi1_cs: spi1-cs {
+	spi1_cs: spi1-cs-pins {
 		samsung,pins = "gpc-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpg-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpg-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_bus1: sd0-bus1 {
+	sd0_bus1: sd0-bus1-pins {
 		samsung,pins = "gpg-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_bus4: sd0-bus4 {
+	sd0_bus4: sd0-bus4-pins {
 		samsung,pins = "gpg-2", "gpg-3", "gpg-4", "gpg-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_cd: sd0-cd {
+	sd0_cd: sd0-cd-pins {
 		samsung,pins = "gpg-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gph-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gph-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus1: sd1-bus1 {
+	sd1_bus1: sd1-bus1-pins {
 		samsung,pins = "gph-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus4: sd1-bus4 {
+	sd1_bus4: sd1-bus4-pins {
 		samsung,pins = "gph-2", "gph-3", "gph-4", "gph-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus8: sd1-bus8 {
+	sd1_bus8: sd1-bus8-pins {
 		samsung,pins = "gph-2", "gph-3", "gph-4", "gph-5",
 				"gph-6", "gph-7", "gph-8", "gph-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_cd: sd1-cd {
+	sd1_cd: sd1-cd-pins {
 		samsung,pins = "gpg-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpc-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpc-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_bus1: sd2-bus1 {
+	sd2_bus1: sd2-bus1-pins {
 		samsung,pins = "gph-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_bus4: sd2-bus4 {
+	sd2_bus4: sd2-bus4-pins {
 		samsung,pins = "gph-6", "gph-7", "gph-8", "gph-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpd-0", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s0_cdclk: i2s0-cdclk {
+	i2s0_cdclk: i2s0-cdclk-pins {
 		samsung,pins = "gpd-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpe-0", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s1_cdclk: i2s1-cdclk {
+	i2s1_cdclk: i2s1-cdclk-pins {
 		samsung,pins = "gpe-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpc-4", "gpc-5", "gpc-6", "gph-6",
 				"gph-8", "gph-9";
@@ -357,50 +357,50 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s2_cdclk: i2s2-cdclk {
+	i2s2_cdclk: i2s2-cdclk-pins {
 		/* S3C6410-only */
 		samsung,pins = "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm0_bus: pcm0-bus {
+	pcm0_bus: pcm0-bus-pins {
 		samsung,pins = "gpd-0", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm0_extclk: pcm0-extclk {
+	pcm0_extclk: pcm0-extclk-pins {
 		samsung,pins = "gpd-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpe-0", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm1_extclk: pcm1-extclk {
+	pcm1_extclk: pcm1-extclk-pins {
 		samsung,pins = "gpe-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ac97_bus_0: ac97-bus-0 {
+	ac97_bus_0: ac97-bus-0-pins {
 		samsung,pins = "gpd-0", "gpd-1", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ac97_bus_1: ac97-bus-1 {
+	ac97_bus_1: ac97-bus-1-pins {
 		samsung,pins = "gpe-0", "gpe-1", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_port: cam-port {
+	cam_port: cam-port-pins {
 		samsung,pins = "gpf-0", "gpf-1", "gpf-2", "gpf-4",
 				"gpf-5", "gpf-6", "gpf-7", "gpf-8",
 				"gpf-9", "gpf-10", "gpf-11", "gpf-12";
@@ -408,242 +408,242 @@ cam_port: cam-port {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_rst: cam-rst {
+	cam_rst: cam-rst-pins {
 		samsung,pins = "gpf-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_field: cam-field {
+	cam_field: cam-field-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpb-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm_extclk: pwm-extclk {
+	pwm_extclk: pwm-extclk-pins {
 		samsung,pins = "gpf-13";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm0_out: pwm0-out {
+	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpf-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm1_out: pwm1-out {
+	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpf-15";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	clkout0: clkout-0 {
+	clkout0: clkout-0-pins {
 		samsung,pins = "gpf-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col0_0: keypad-col0-0 {
+	keypad_col0_0: keypad-col0-0-pins {
 		samsung,pins = "gph-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col1_0: keypad-col1-0 {
+	keypad_col1_0: keypad-col1-0-pins {
 		samsung,pins = "gph-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col2_0: keypad-col2-0 {
+	keypad_col2_0: keypad-col2-0-pins {
 		samsung,pins = "gph-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col3_0: keypad-col3-0 {
+	keypad_col3_0: keypad-col3-0-pins {
 		samsung,pins = "gph-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col4_0: keypad-col4-0 {
+	keypad_col4_0: keypad-col4-0-pins {
 		samsung,pins = "gph-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col5_0: keypad-col5-0 {
+	keypad_col5_0: keypad-col5-0-pins {
 		samsung,pins = "gph-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col6_0: keypad-col6-0 {
+	keypad_col6_0: keypad-col6-0-pins {
 		samsung,pins = "gph-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col7_0: keypad-col7-0 {
+	keypad_col7_0: keypad-col7-0-pins {
 		samsung,pins = "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col0_1: keypad-col0-1 {
+	keypad_col0_1: keypad-col0-1-pins {
 		samsung,pins = "gpl-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col1_1: keypad-col1-1 {
+	keypad_col1_1: keypad-col1-1-pins {
 		samsung,pins = "gpl-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col2_1: keypad-col2-1 {
+	keypad_col2_1: keypad-col2-1-pins {
 		samsung,pins = "gpl-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col3_1: keypad-col3-1 {
+	keypad_col3_1: keypad-col3-1-pins {
 		samsung,pins = "gpl-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col4_1: keypad-col4-1 {
+	keypad_col4_1: keypad-col4-1-pins {
 		samsung,pins = "gpl-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col5_1: keypad-col5-1 {
+	keypad_col5_1: keypad-col5-1-pins {
 		samsung,pins = "gpl-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col6_1: keypad-col6-1 {
+	keypad_col6_1: keypad-col6-1-pins {
 		samsung,pins = "gpl-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col7_1: keypad-col7-1 {
+	keypad_col7_1: keypad-col7-1-pins {
 		samsung,pins = "gpl-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row0_0: keypad-row0-0 {
+	keypad_row0_0: keypad-row0-0-pins {
 		samsung,pins = "gpk-8";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row1_0: keypad-row1-0 {
+	keypad_row1_0: keypad-row1-0-pins {
 		samsung,pins = "gpk-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row2_0: keypad-row2-0 {
+	keypad_row2_0: keypad-row2-0-pins {
 		samsung,pins = "gpk-10";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row3_0: keypad-row3-0 {
+	keypad_row3_0: keypad-row3-0-pins {
 		samsung,pins = "gpk-11";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row4_0: keypad-row4-0 {
+	keypad_row4_0: keypad-row4-0-pins {
 		samsung,pins = "gpk-12";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row5_0: keypad-row5-0 {
+	keypad_row5_0: keypad-row5-0-pins {
 		samsung,pins = "gpk-13";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row6_0: keypad-row6-0 {
+	keypad_row6_0: keypad-row6-0-pins {
 		samsung,pins = "gpk-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row7_0: keypad-row7-0 {
+	keypad_row7_0: keypad-row7-0-pins {
 		samsung,pins = "gpk-15";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row0_1: keypad-row0-1 {
+	keypad_row0_1: keypad-row0-1-pins {
 		samsung,pins = "gpn-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row1_1: keypad-row1-1 {
+	keypad_row1_1: keypad-row1-1-pins {
 		samsung,pins = "gpn-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row2_1: keypad-row2-1 {
+	keypad_row2_1: keypad-row2-1-pins {
 		samsung,pins = "gpn-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row3_1: keypad-row3-1 {
+	keypad_row3_1: keypad-row3-1-pins {
 		samsung,pins = "gpn-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row4_1: keypad-row4-1 {
+	keypad_row4_1: keypad-row4-1-pins {
 		samsung,pins = "gpn-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row5_1: keypad-row5-1 {
+	keypad_row5_1: keypad-row5-1-pins {
 		samsung,pins = "gpn-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row6_1: keypad-row6-1 {
+	keypad_row6_1: keypad-row6-1-pins {
 		samsung,pins = "gpn-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row7_1: keypad-row7-1 {
+	keypad_row7_1: keypad-row7-1-pins {
 		samsung,pins = "gpn-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_ctrl: lcd-ctrl {
+	lcd_ctrl: lcd-ctrl-pins {
 		samsung,pins = "gpj-8", "gpj-9", "gpj-10", "gpj-11";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data16: lcd-data-width16 {
+	lcd_data16: lcd-data-width16-pins {
 		samsung,pins = "gpi-3", "gpi-4", "gpi-5", "gpi-6",
 				"gpi-7", "gpi-10", "gpi-11", "gpi-12",
 				"gpi-13", "gpi-14", "gpi-15", "gpj-3",
@@ -652,7 +652,7 @@ lcd_data16: lcd-data-width16 {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data18: lcd-data-width18 {
+	lcd_data18: lcd-data-width18-pins {
 		samsung,pins = "gpi-2", "gpi-3", "gpi-4", "gpi-5",
 				"gpi-6", "gpi-7", "gpi-10", "gpi-11",
 				"gpi-12", "gpi-13", "gpi-14", "gpi-15",
@@ -662,7 +662,7 @@ lcd_data18: lcd-data-width18 {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data24: lcd-data-width24 {
+	lcd_data24: lcd-data-width24-pins {
 		samsung,pins = "gpi-0", "gpi-1", "gpi-2", "gpi-3",
 				"gpi-4", "gpi-5", "gpi-6", "gpi-7",
 				"gpi-8", "gpi-9", "gpi-10", "gpi-11",
@@ -673,7 +673,7 @@ lcd_data24: lcd-data-width24 {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	hsi_bus: hsi-bus {
+	hsi_bus: hsi-bus-pins {
 		samsung,pins = "gpk-0", "gpk-1", "gpk-2", "gpk-3",
 				"gpk-4", "gpk-5", "gpk-6", "gpk-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-- 
2.32.0

