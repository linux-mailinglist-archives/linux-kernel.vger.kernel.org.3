Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22A48B866
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbiAKUTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:19:02 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60222
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346414AbiAKUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:28 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C4C2C40A9C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932301;
        bh=3im6DR0tfQSvVQYJAITaAc2sEgTm9ctnw8/dFQunAY0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EY9oUbCyFsfXJ3jXUrvifmCoF6dNLNdpaYqolLGZekEH+oor4ouhzkH9nT2xLFZbH
         ngoQ/ziELdL3dp/5oyQVP1M1BZIWk356QREgZXrRUcAXdyur9KU+wR+3frFQTSkJdH
         ynJqiq8kB2sTyGNDuCHkFYqGPKs5VYdrhf/YPc7llFcxpR0+J8ypquQBRmmjpimLHw
         AWKPueBkxGXCmpMbZkPJX0R6D7LJObv+Uqwut4GhLuZfvZJ/hnR4lDuOr5iSQjDDE5
         iK1VCKw6pPj7nI0MkJ8LolxHaf16xcyLeVbqTUUNj6QazwyWtrGRGfjFl84b3EQSvC
         lpmbpzAIlXRDA==
Received: by mail-ed1-f69.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso148455edd.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3im6DR0tfQSvVQYJAITaAc2sEgTm9ctnw8/dFQunAY0=;
        b=QGpuNtjjfoQ5Pe2singA9mqH3hhk1O0sZlm+Khq3DTkYLiiH5X+yA/ANjxTbYdgRjL
         VQW1AY+Sl97SLPCBqlQN6eMlXnL95hDtAzl3/zACDZBDwnGTD2YMrerq289Lk+uJtWBq
         bQb8BsuJWxKnm2Snn6rdjGUf3a2ju9ekdA1r32Ipa+91/HAf4t2ov2CmNLnsN/6bgX1b
         Dr/oq9vsDV2KBlQCtV/1sT9k1Kj0c7H5k2ya0sxR1Tt/yTlmFSISTQZpD8WEh4rHVwI8
         qZhMO8fGM2kTSr5xeGY8B6nWzxc2K2DDOyFImuU55p/9N9bUpU+OEpb368F9T3/7Nym4
         5haA==
X-Gm-Message-State: AOAM530rIkc1LALqQCaP2o5BqAjgRQ4QVxN64gOnqbyLbAI1f/fP9A1Z
        HpzBMtb9CHNsCJTOS/KwU+vZXtf9BieLs+EL8cEnL7JUDGES9fGACMLlWYf2D5O5e8XjTXCtJDb
        oOXRIQghK7uQRn6moTJz0w8mJrKPCIN3QJehncyg6vQ==
X-Received: by 2002:a05:6402:1047:: with SMTP id e7mr4254580edu.274.1641932301355;
        Tue, 11 Jan 2022 12:18:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuNNnKbwjenV7EEj0Vko4eTPjFtdB7emwJIo+qGaPlmYoH4ymm0zVXP0Saautd3Wo4zKleIw==
X-Received: by 2002:a05:6402:1047:: with SMTP id e7mr4254562edu.274.1641932301205;
        Tue, 11 Jan 2022 12:18:21 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:20 -0800 (PST)
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
Subject: [PATCH v2 21/28] ARM: dts: s3c24xx: align pinctrl with dtschema
Date:   Tue, 11 Jan 2022 21:17:15 +0100
Message-Id: <20220111201722.327219-15-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi | 60 +++++++++++++-------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
index 92439ee5d7de..20a7d72827c2 100644
--- a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
@@ -12,66 +12,66 @@ &pinctrl_0 {
 	 * Pin banks
 	 */
 
-	gpa: gpa {
+	gpa: gpa-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpc: gpc {
+	gpc: gpc-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpd: gpd {
+	gpd: gpd-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
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
 	};
 
-	gpm: gpm {
+	gpm: gpm-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
@@ -80,92 +80,92 @@ gpm: gpm {
 	 * Pin groups
 	 */
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gph-0", "gph-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gph-8", "gph-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gph-2", "gph-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gph-10", "gph-11";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gph-4", "gph-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	uart2_fctl: uart2-fctl {
+	uart2_fctl: uart2-fctl-pins {
 		samsung,pins = "gph-6", "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	uart3_data: uart3-data {
+	uart3_data: uart3-data-pins {
 		samsung,pins = "gph-6", "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	extuart_clk: extuart-clk {
+	extuart_clk: extuart-clk-pins {
 		samsung,pins = "gph-12";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpe-14", "gpe-15";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpe-11", "gpe-12", "gpe-13";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpe-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpe-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd0_bus1: sd0-bus1 {
+	sd0_bus1: sd0-bus1-pins {
 		samsung,pins = "gpe-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd0_bus4: sd0-bus4 {
+	sd0_bus4: sd0-bus4-pins {
 		samsung,pins = "gpe-8", "gpe-9", "gpe-10";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpl-8";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpl-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd1_bus1: sd1-bus1 {
+	sd1_bus1: sd1-bus1-pins {
 		samsung,pins = "gpl-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	sd1_bus4: sd1-bus4 {
+	sd1_bus4: sd1-bus4-pins {
 		samsung,pins = "gpl-1", "gpl-2", "gpl-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
-- 
2.32.0

