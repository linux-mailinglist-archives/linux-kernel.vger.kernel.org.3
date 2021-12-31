Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9715A48250B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhLaQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:22:51 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55324
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231477AbhLaQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:22:31 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 262C44005B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967747;
        bh=Iis1HmOcjBti5vv6mBFp24TnjDjgl1zjvIzDTXKgLsU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=P7O5j1PilbxlElSdeh4AhcNKfe3AuC8r/wINJb32u31kBCA5PoLcBpzvrzeF14x1e
         lqBqDkdkIGFDfZlEvIlJGuP79k5Pmp1J65iseIW2cHE+QCOLIIZ4LqwpsqcJTfhyZq
         9KtkcDw+tKKL/vKjANBuY2zhzjIsVY9iwa4R7qcvF9j16fw/59UemwxQgA8OBPf048
         yxeAK/jtejYFGpeT5oTNTeCdOxbhfweFo8CgZ4QRjmAM/qJnIjqw9g01+9jnDIXucL
         Kw5Dq2H/oX9hsNT5aNY4sJxwBNSh1OIefum3FrjE2GMJu8OZ5HMZ+l8oz3EZ9vFuo8
         pIN9uOQ8aB0Rg==
Received: by mail-lf1-f70.google.com with SMTP id cf14-20020a056512280e00b00426460c9af9so4906607lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iis1HmOcjBti5vv6mBFp24TnjDjgl1zjvIzDTXKgLsU=;
        b=MxSnsSdfsVbfLalwllwYs39SGaWCMCKxYWt7AJu/b9HaZD3IQ1Nzu6wxkgBIvoRmjQ
         zMtTWglyfcBeSft0yOnfamLTtPXoabTpKztlDMqKf3ZA+8Ex4sktpvLYTPTwXQ9WGyYj
         xV9RPWWsJhvhaWpGRZ+UoRpJz/p65BwR7aJm9hqpj4EZpWu6cMnxWDio7SyqcAZ5w6vR
         E8An0wXmbA3JG2pFYvbJCoHFJzNj96OuPVqppW6HaY/POr6FRvCIIc9O+GXGy/hKVJli
         tDPsB7fklptdMrpLhXia/QhlWBBiZsexV3kX90X3JPlPAikb5oTNadqPTWIm9yHgsRt+
         ymXw==
X-Gm-Message-State: AOAM532yJX7pVTJuL6qG6hH8fpdExI6wL9LGV2IPe4WvZcMPHrlg3A/Z
        pTPS3jel8yGwi8Lx0CvZ2zpLH1p8C7dYiXWTDWt7c/3uYffIxSkEt44iAnFd/nAt1+JzBXXcL8f
        2HST6b5rZsEh41fC17wFemX8r/3G11rKfn/ZzmAeBgg==
X-Received: by 2002:a2e:8813:: with SMTP id x19mr29909730ljh.2.1640967746087;
        Fri, 31 Dec 2021 08:22:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwd01xYjO7rAcwupA+iRnhkUzXqSqgbx/1ianH6t75Ce4x9ItZ1SXGwnwbc33WHPv98sunIyQ==
X-Received: by 2002:a2e:8813:: with SMTP id x19mr29909715ljh.2.1640967745756;
        Fri, 31 Dec 2021 08:22:25 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm2796514lfa.75.2021.12.31.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:22:25 -0800 (PST)
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
Subject: [PATCH 17/24] arm64: dts: exynos: align pinctrl with dtschema in Exynos5433
Date:   Fri, 31 Dec 2021 17:22:00 +0100
Message-Id: <20211231162207.257478-11-krzysztof.kozlowski@canonical.com>
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

The macros used to define pin configuration do not work well with node
name suffix "-pin" or prefix "pin-", so level of indirection via second
macro is needed.  For similar reason pcie-wlanen has to stop using the
macro.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../boot/dts/exynos/exynos5433-pinctrl.dtsi   | 211 +++++++-------
 .../dts/exynos/exynos5433-tm2-common.dtsi     | 259 +++++++++---------
 2 files changed, 241 insertions(+), 229 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
index 32a6518517e5..4b46af3e164d 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -11,16 +11,25 @@
 
 #include <dt-bindings/pinctrl/samsung.h>
 
-#define PIN(_func, _pin, _pull, _drv)					\
-	_pin {								\
+#define PIN(_pin, _func, _pull, _drv)					\
+	pin- ## _pin {							\
 		samsung,pins = #_pin;					\
 		samsung,pin-function = <EXYNOS_PIN_FUNC_ ##_func>;	\
 		samsung,pin-pud = <EXYNOS_PIN_PULL_ ##_pull>;		\
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_ ##_drv>;		\
 	}
 
+#define PIN_IN(_pin, _pull, _drv)					\
+	PIN(_pin, INPUT, _pull, _drv)
+
+#define PIN_OT(_pin, _pull, _drv)					\
+	PIN(_pin, OUTPUT, _pull, _drv)
+
+#define PIN_F2(_pin, _pull, _drv)					\
+	PIN(_pin, 2, _pull, _drv)
+
 &pinctrl_alive {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -37,7 +46,7 @@ gpa0: gpa0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -54,7 +63,7 @@ gpa1: gpa1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa2: gpa2 {
+	gpa2: gpa2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -62,7 +71,7 @@ gpa2: gpa2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpa3: gpa3 {
+	gpa3: gpa3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -70,7 +79,7 @@ gpa3: gpa3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -78,7 +87,7 @@ gpf1: gpf1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf2: gpf2 {
+	gpf2: gpf2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -86,7 +95,7 @@ gpf2: gpf2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf3: gpf3 {
+	gpf3: gpf3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -94,7 +103,7 @@ gpf3: gpf3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf4: gpf4 {
+	gpf4: gpf4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -102,7 +111,7 @@ gpf4: gpf4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf5: gpf5 {
+	gpf5: gpf5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -112,7 +121,7 @@ gpf5: gpf5 {
 };
 
 &pinctrl_aud {
-	gpz0: gpz0 {
+	gpz0: gpz0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -120,7 +129,7 @@ gpz0: gpz0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpz1: gpz1 {
+	gpz1: gpz1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -128,7 +137,7 @@ gpz1: gpz1 {
 		#interrupt-cells = <2>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpz0-0", "gpz0-1", "gpz0-2", "gpz0-3",
 				"gpz0-4", "gpz0-5", "gpz0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -136,14 +145,14 @@ i2s0_bus: i2s0-bus {
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	pcm0_bus: pcm0-bus {
+	pcm0_bus: pcm0-bus-pins {
 		samsung,pins = "gpz1-0", "gpz1-1", "gpz1-2", "gpz1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	uart_aud_bus: uart-aud-bus {
+	uart_aud_bus: uart-aud-bus-pins {
 		samsung,pins = "gpz1-3", "gpz1-2", "gpz1-1", "gpz1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -152,7 +161,7 @@ uart_aud_bus: uart-aud-bus {
 };
 
 &pinctrl_cpif {
-	gpv6: gpv6 {
+	gpv6: gpv6-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -162,7 +171,7 @@ gpv6: gpv6 {
 };
 
 &pinctrl_ese {
-	gpj2: gpj2 {
+	gpj2: gpj2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -172,7 +181,7 @@ gpj2: gpj2 {
 };
 
 &pinctrl_finger {
-	gpd5: gpd5 {
+	gpd5: gpd5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -180,14 +189,14 @@ gpd5: gpd5 {
 		#interrupt-cells = <2>;
 	};
 
-	spi2_bus: spi2-bus {
+	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpd5-0", "gpd5-2", "gpd5-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	hs_i2c6_bus: hs-i2c6-bus {
+	hs_i2c6_bus: hs-i2c6-bus-pins {
 		samsung,pins = "gpd5-3", "gpd5-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
@@ -196,7 +205,7 @@ hs_i2c6_bus: hs-i2c6-bus {
 };
 
 &pinctrl_fsys {
-	gph1: gph1 {
+	gph1: gph1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -204,7 +213,7 @@ gph1: gph1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpr4: gpr4 {
+	gpr4: gpr4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -212,7 +221,7 @@ gpr4: gpr4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpr0: gpr0 {
+	gpr0: gpr0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -220,7 +229,7 @@ gpr0: gpr0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpr1: gpr1 {
+	gpr1: gpr1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -228,7 +237,7 @@ gpr1: gpr1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpr2: gpr2 {
+	gpr2: gpr2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -236,7 +245,7 @@ gpr2: gpr2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpr3: gpr3 {
+	gpr3: gpr3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -244,139 +253,139 @@ gpr3: gpr3 {
 		#interrupt-cells = <2>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpr0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpr0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd0_rdqs: sd0-rdqs {
+	sd0_rdqs: sd0-rdqs-pins {
 		samsung,pins = "gpr0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd0_qrdy: sd0-qrdy {
+	sd0_qrdy: sd0-qrdy-pins {
 		samsung,pins = "gpr0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd0_bus1: sd0-bus-width1 {
+	sd0_bus1: sd0-bus-width1-pins {
 		samsung,pins = "gpr1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd0_bus4: sd0-bus-width4 {
+	sd0_bus4: sd0-bus-width4-pins {
 		samsung,pins = "gpr1-1", "gpr1-2", "gpr1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd0_bus8: sd0-bus-width8 {
+	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpr1-4", "gpr1-5", "gpr1-6", "gpr1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpr2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpr2-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd1_bus1: sd1-bus-width1 {
+	sd1_bus1: sd1-bus-width1-pins {
 		samsung,pins = "gpr3-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd1_bus4: sd1-bus-width4 {
+	sd1_bus4: sd1-bus-width4-pins {
 		samsung,pins = "gpr3-1", "gpr3-2", "gpr3-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd1_bus8: sd1-bus-width8 {
+	sd1_bus8: sd1-bus-width8-pins {
 		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	pcie_bus: pcie_bus {
+	pcie_bus: pcie-bus-pins {
 		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpr4-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpr4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd2_cd: sd2-cd {
+	sd2_cd: sd2-cd-pins {
 		samsung,pins = "gpr4-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd2_bus1: sd2-bus-width1 {
+	sd2_bus1: sd2-bus-width1-pins {
 		samsung,pins = "gpr4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd2_bus4: sd2-bus-width4 {
+	sd2_bus4: sd2-bus-width4-pins {
 		samsung,pins = "gpr4-4", "gpr4-5", "gpr4-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
-	sd2_clk_output: sd2-clk-output {
+	sd2_clk_output: sd2-clk-output-pins {
 		samsung,pins = "gpr4-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR3>;
 	};
 
-	sd2_cmd_output: sd2-cmd-output {
+	sd2_cmd_output: sd2-cmd-output-pins {
 		samsung,pins = "gpr4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -385,7 +394,7 @@ sd2_cmd_output: sd2-cmd-output {
 };
 
 &pinctrl_imem {
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -395,7 +404,7 @@ gpf0: gpf0 {
 };
 
 &pinctrl_nfc {
-	gpj0: gpj0 {
+	gpj0: gpj0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -403,7 +412,7 @@ gpj0: gpj0 {
 		#interrupt-cells = <2>;
 	};
 
-	hs_i2c4_bus: hs-i2c4-bus {
+	hs_i2c4_bus: hs-i2c4-bus-pins {
 		samsung,pins = "gpj0-1", "gpj0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
@@ -412,7 +421,7 @@ hs_i2c4_bus: hs-i2c4-bus {
 };
 
 &pinctrl_peric {
-	gpv7: gpv7 {
+	gpv7: gpv7-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -420,7 +429,7 @@ gpv7: gpv7 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb0: gpb0 {
+	gpb0: gpb0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -428,7 +437,7 @@ gpb0: gpb0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -436,7 +445,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -444,7 +453,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc2: gpc2 {
+	gpc2: gpc2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -452,7 +461,7 @@ gpc2: gpc2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc3: gpc3 {
+	gpc3: gpc3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -460,7 +469,7 @@ gpc3: gpc3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg0: gpg0 {
+	gpg0: gpg0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -468,7 +477,7 @@ gpg0: gpg0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd0: gpd0 {
+	gpd0: gpd0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -476,7 +485,7 @@ gpd0: gpd0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd1: gpd1 {
+	gpd1: gpd1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -484,7 +493,7 @@ gpd1: gpd1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd2: gpd2 {
+	gpd2: gpd2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -492,7 +501,7 @@ gpd2: gpd2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd4: gpd4 {
+	gpd4: gpd4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -500,7 +509,7 @@ gpd4: gpd4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd8: gpd8 {
+	gpd8: gpd8-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -508,7 +517,7 @@ gpd8: gpd8 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd6: gpd6 {
+	gpd6: gpd6-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -516,7 +525,7 @@ gpd6: gpd6 {
 		#interrupt-cells = <2>;
 	};
 
-	gpd7: gpd7 {
+	gpd7: gpd7-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -524,7 +533,7 @@ gpd7: gpd7 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg1: gpg1 {
+	gpg1: gpg1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -532,7 +541,7 @@ gpg1: gpg1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg2: gpg2 {
+	gpg2: gpg2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -540,7 +549,7 @@ gpg2: gpg2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg3: gpg3 {
+	gpg3: gpg3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -548,21 +557,21 @@ gpg3: gpg3 {
 		#interrupt-cells = <2>;
 	};
 
-	hs_i2c8_bus: hs-i2c8-bus {
+	hs_i2c8_bus: hs-i2c8-bus-pins {
 		samsung,pins = "gpb0-1", "gpb0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	hs_i2c9_bus: hs-i2c9-bus {
+	hs_i2c9_bus: hs-i2c9-bus-pins {
 		samsung,pins = "gpb0-3", "gpb0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpd4-0", "gpd4-1", "gpd4-2",
 				"gpd4-3", "gpd4-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
@@ -570,7 +579,7 @@ i2s1_bus: i2s1-bus {
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpd4-0", "gpd4-1", "gpd4-2",
 				"gpd4-3", "gpd4-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
@@ -578,193 +587,193 @@ pcm1_bus: pcm1-bus {
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	spdif_bus: spdif-bus {
+	spdif_bus: spdif-bus-pins {
 		samsung,pins = "gpd4-3", "gpd4-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_spi_pin0: fimc-is-spi-pin0 {
+	fimc_is_spi_pin0: fimc-is-spi-pin0-pins {
 		samsung,pins = "gpc3-3", "gpc3-2", "gpc3-1", "gpc3-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_spi_pin1: fimc-is-spi-pin1 {
+	fimc_is_spi_pin1: fimc-is-spi-pin1-pins {
 		samsung,pins = "gpc3-7", "gpc3-6", "gpc3-5", "gpc3-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	uart0_bus: uart0-bus {
+	uart0_bus: uart0-bus-pins {
 		samsung,pins = "gpd0-3", "gpd0-2", "gpd0-1", "gpd0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	hs_i2c2_bus: hs-i2c2-bus {
+	hs_i2c2_bus: hs-i2c2-bus-pins {
 		samsung,pins = "gpd0-3", "gpd0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	uart2_bus: uart2-bus {
+	uart2_bus: uart2-bus-pins {
 		samsung,pins = "gpd1-5", "gpd1-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	uart1_bus: uart1-bus {
+	uart1_bus: uart1-bus-pins {
 		samsung,pins = "gpd1-3", "gpd1-2", "gpd1-1", "gpd1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
-	hs_i2c3_bus: hs-i2c3-bus {
+	hs_i2c3_bus: hs-i2c3-bus-pins {
 		samsung,pins = "gpd1-3", "gpd1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	hs_i2c0_bus: hs-i2c0-bus {
+	hs_i2c0_bus: hs-i2c0-bus-pins {
 		samsung,pins = "gpd2-1", "gpd2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	hs_i2c1_bus: hs-i2c1-bus {
+	hs_i2c1_bus: hs-i2c1-bus-pins {
 		samsung,pins = "gpd2-3", "gpd2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	pwm0_out: pwm0-out {
+	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpd2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	pwm1_out: pwm1-out {
+	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpd2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	pwm2_out: pwm2-out {
+	pwm2_out: pwm2-out-pins {
 		samsung,pins = "gpd2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	pwm3_out: pwm3-out {
+	pwm3_out: pwm3-out-pins {
 		samsung,pins = "gpd2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpd6-2", "gpd6-4", "gpd6-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	hs_i2c7_bus: hs-i2c7-bus {
+	hs_i2c7_bus: hs-i2c7-bus-pins {
 		samsung,pins = "gpd2-7", "gpd2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpd8-0", "gpd6-0", "gpd6-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	hs_i2c10_bus: hs-i2c10-bus {
+	hs_i2c10_bus: hs-i2c10-bus-pins {
 		samsung,pins = "gpg3-1", "gpg3-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	hs_i2c11_bus: hs-i2c11-bus {
+	hs_i2c11_bus: hs-i2c11-bus-pins {
 		samsung,pins = "gpg3-3", "gpg3-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	spi3_bus: spi3-bus {
+	spi3_bus: spi3-bus-pins {
 		samsung,pins = "gpg3-4", "gpg3-6", "gpg3-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	spi4_bus: spi4-bus {
+	spi4_bus: spi4-bus-pins {
 		samsung,pins = "gpv7-1", "gpv7-3", "gpv7-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_uart: fimc-is-uart {
+	fimc_is_uart: fimc-is-uart-pins {
 		samsung,pins = "gpc1-1", "gpc0-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_ch0_i2c: fimc-is-ch0_i2c {
+	fimc_is_ch0_i2c: fimc-is-ch0-i2c-pins {
 		samsung,pins = "gpc2-1", "gpc2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_ch0_mclk: fimc-is-ch0_mclk {
+	fimc_is_ch0_mclk: fimc-is-ch0-mclk-pins {
 		samsung,pins = "gpd7-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_ch1_i2c: fimc-is-ch1-i2c {
+	fimc_is_ch1_i2c: fimc-is-ch1-i2c-pins {
 		samsung,pins = "gpc2-3", "gpc2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_ch1_mclk: fimc-is-ch1-mclk {
+	fimc_is_ch1_mclk: fimc-is-ch1-mclk-pins {
 		samsung,pins = "gpd7-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_ch2_i2c: fimc-is-ch2-i2c {
+	fimc_is_ch2_i2c: fimc-is-ch2-i2c-pins {
 		samsung,pins = "gpc2-5", "gpc2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
 	};
 
-	fimc_is_ch2_mclk: fimc-is-ch2-mclk {
+	fimc_is_ch2_mclk: fimc-is-ch2-mclk-pins {
 		samsung,pins = "gpd7-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -773,7 +782,7 @@ fimc_is_ch2_mclk: fimc-is-ch2-mclk {
 };
 
 &pinctrl_touch {
-	gpj1: gpj1 {
+	gpj1: gpj1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -781,7 +790,7 @@ gpj1: gpj1 {
 		#interrupt-cells = <2>;
 	};
 
-	hs_i2c5_bus: hs-i2c5-bus {
+	hs_i2c5_bus: hs-i2c5-bus-pins {
 		samsung,pins = "gpj1-1", "gpj1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index cbcc01a66aab..be1b6b7da059 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1011,80 +1011,80 @@ &pinctrl_alive {
 	pinctrl-0 = <&initial_alive>;
 
 	initial_alive: initial-state {
-		PIN(INPUT, gpa0-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpa0-1, NONE, FAST_SR1);
-		PIN(INPUT, gpa0-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpa0-3, NONE, FAST_SR1);
-		PIN(INPUT, gpa0-4, NONE, FAST_SR1);
-		PIN(INPUT, gpa0-5, DOWN, FAST_SR1);
-		PIN(INPUT, gpa0-6, NONE, FAST_SR1);
-		PIN(INPUT, gpa0-7, NONE, FAST_SR1);
-
-		PIN(INPUT, gpa1-0, UP, FAST_SR1);
-		PIN(INPUT, gpa1-1, UP, FAST_SR1);
-		PIN(INPUT, gpa1-2, NONE, FAST_SR1);
-		PIN(INPUT, gpa1-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpa1-4, DOWN, FAST_SR1);
-		PIN(INPUT, gpa1-5, NONE, FAST_SR1);
-		PIN(INPUT, gpa1-6, NONE, FAST_SR1);
-		PIN(INPUT, gpa1-7, NONE, FAST_SR1);
-
-		PIN(INPUT, gpa2-0, NONE, FAST_SR1);
-		PIN(INPUT, gpa2-1, NONE, FAST_SR1);
-		PIN(INPUT, gpa2-2, NONE, FAST_SR1);
-		PIN(INPUT, gpa2-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpa2-4, NONE, FAST_SR1);
-		PIN(INPUT, gpa2-5, DOWN, FAST_SR1);
-		PIN(INPUT, gpa2-6, DOWN, FAST_SR1);
-		PIN(INPUT, gpa2-7, NONE, FAST_SR1);
-
-		PIN(INPUT, gpa3-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpa3-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpa3-2, NONE, FAST_SR1);
-		PIN(INPUT, gpa3-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpa3-4, NONE, FAST_SR1);
-		PIN(INPUT, gpa3-5, DOWN, FAST_SR1);
-		PIN(INPUT, gpa3-6, DOWN, FAST_SR1);
-		PIN(INPUT, gpa3-7, DOWN, FAST_SR1);
-
-		PIN(INPUT, gpf1-0, NONE, FAST_SR1);
-		PIN(INPUT, gpf1-1, NONE, FAST_SR1);
-		PIN(INPUT, gpf1-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpf1-4, UP, FAST_SR1);
-		PIN(OUTPUT, gpf1-5, NONE, FAST_SR1);
-		PIN(INPUT, gpf1-6, DOWN, FAST_SR1);
-		PIN(INPUT, gpf1-7, DOWN, FAST_SR1);
-
-		PIN(INPUT, gpf2-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpf2-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpf2-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpf2-3, DOWN, FAST_SR1);
-
-		PIN(INPUT, gpf3-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpf3-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpf3-2, NONE, FAST_SR1);
-		PIN(INPUT, gpf3-3, DOWN, FAST_SR1);
-
-		PIN(INPUT, gpf4-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpf4-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpf4-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpf4-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpf4-4, DOWN, FAST_SR1);
-		PIN(INPUT, gpf4-5, DOWN, FAST_SR1);
-		PIN(INPUT, gpf4-6, DOWN, FAST_SR1);
-		PIN(INPUT, gpf4-7, DOWN, FAST_SR1);
-
-		PIN(INPUT, gpf5-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpf5-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpf5-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpf5-3, DOWN, FAST_SR1);
-		PIN(OUTPUT, gpf5-4, NONE, FAST_SR1);
-		PIN(INPUT, gpf5-5, DOWN, FAST_SR1);
-		PIN(INPUT, gpf5-6, DOWN, FAST_SR1);
-		PIN(INPUT, gpf5-7, DOWN, FAST_SR1);
+		PIN_IN(gpa0-0, DOWN, FAST_SR1);
+		PIN_IN(gpa0-1, NONE, FAST_SR1);
+		PIN_IN(gpa0-2, DOWN, FAST_SR1);
+		PIN_IN(gpa0-3, NONE, FAST_SR1);
+		PIN_IN(gpa0-4, NONE, FAST_SR1);
+		PIN_IN(gpa0-5, DOWN, FAST_SR1);
+		PIN_IN(gpa0-6, NONE, FAST_SR1);
+		PIN_IN(gpa0-7, NONE, FAST_SR1);
+
+		PIN_IN(gpa1-0, UP, FAST_SR1);
+		PIN_IN(gpa1-1, UP, FAST_SR1);
+		PIN_IN(gpa1-2, NONE, FAST_SR1);
+		PIN_IN(gpa1-3, DOWN, FAST_SR1);
+		PIN_IN(gpa1-4, DOWN, FAST_SR1);
+		PIN_IN(gpa1-5, NONE, FAST_SR1);
+		PIN_IN(gpa1-6, NONE, FAST_SR1);
+		PIN_IN(gpa1-7, NONE, FAST_SR1);
+
+		PIN_IN(gpa2-0, NONE, FAST_SR1);
+		PIN_IN(gpa2-1, NONE, FAST_SR1);
+		PIN_IN(gpa2-2, NONE, FAST_SR1);
+		PIN_IN(gpa2-3, DOWN, FAST_SR1);
+		PIN_IN(gpa2-4, NONE, FAST_SR1);
+		PIN_IN(gpa2-5, DOWN, FAST_SR1);
+		PIN_IN(gpa2-6, DOWN, FAST_SR1);
+		PIN_IN(gpa2-7, NONE, FAST_SR1);
+
+		PIN_IN(gpa3-0, DOWN, FAST_SR1);
+		PIN_IN(gpa3-1, DOWN, FAST_SR1);
+		PIN_IN(gpa3-2, NONE, FAST_SR1);
+		PIN_IN(gpa3-3, DOWN, FAST_SR1);
+		PIN_IN(gpa3-4, NONE, FAST_SR1);
+		PIN_IN(gpa3-5, DOWN, FAST_SR1);
+		PIN_IN(gpa3-6, DOWN, FAST_SR1);
+		PIN_IN(gpa3-7, DOWN, FAST_SR1);
+
+		PIN_IN(gpf1-0, NONE, FAST_SR1);
+		PIN_IN(gpf1-1, NONE, FAST_SR1);
+		PIN_IN(gpf1-2, DOWN, FAST_SR1);
+		PIN_IN(gpf1-4, UP, FAST_SR1);
+		PIN_OT(gpf1-5, NONE, FAST_SR1);
+		PIN_IN(gpf1-6, DOWN, FAST_SR1);
+		PIN_IN(gpf1-7, DOWN, FAST_SR1);
+
+		PIN_IN(gpf2-0, DOWN, FAST_SR1);
+		PIN_IN(gpf2-1, DOWN, FAST_SR1);
+		PIN_IN(gpf2-2, DOWN, FAST_SR1);
+		PIN_IN(gpf2-3, DOWN, FAST_SR1);
+
+		PIN_IN(gpf3-0, DOWN, FAST_SR1);
+		PIN_IN(gpf3-1, DOWN, FAST_SR1);
+		PIN_IN(gpf3-2, NONE, FAST_SR1);
+		PIN_IN(gpf3-3, DOWN, FAST_SR1);
+
+		PIN_IN(gpf4-0, DOWN, FAST_SR1);
+		PIN_IN(gpf4-1, DOWN, FAST_SR1);
+		PIN_IN(gpf4-2, DOWN, FAST_SR1);
+		PIN_IN(gpf4-3, DOWN, FAST_SR1);
+		PIN_IN(gpf4-4, DOWN, FAST_SR1);
+		PIN_IN(gpf4-5, DOWN, FAST_SR1);
+		PIN_IN(gpf4-6, DOWN, FAST_SR1);
+		PIN_IN(gpf4-7, DOWN, FAST_SR1);
+
+		PIN_IN(gpf5-0, DOWN, FAST_SR1);
+		PIN_IN(gpf5-1, DOWN, FAST_SR1);
+		PIN_IN(gpf5-2, DOWN, FAST_SR1);
+		PIN_IN(gpf5-3, DOWN, FAST_SR1);
+		PIN_OT(gpf5-4, NONE, FAST_SR1);
+		PIN_IN(gpf5-5, DOWN, FAST_SR1);
+		PIN_IN(gpf5-6, DOWN, FAST_SR1);
+		PIN_IN(gpf5-7, DOWN, FAST_SR1);
 	};
 
-	te_irq: te-irq {
+	te_irq: te-irq-pins {
 		samsung,pins = "gpf1-3";
 		samsung,pin-function = <0xf>;
 	};
@@ -1095,8 +1095,8 @@ &pinctrl_cpif {
 	pinctrl-0 = <&initial_cpif>;
 
 	initial_cpif: initial-state {
-		PIN(INPUT, gpv6-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpv6-1, DOWN, FAST_SR1);
+		PIN_IN(gpv6-0, DOWN, FAST_SR1);
+		PIN_IN(gpv6-1, DOWN, FAST_SR1);
 	};
 };
 
@@ -1104,13 +1104,16 @@ &pinctrl_ese {
 	pinctrl-names = "default";
 	pinctrl-0 = <&initial_ese>;
 
-	pcie_wlanen: pcie-wlanen {
-		PIN(INPUT, gpj2-0, UP, FAST_SR4);
+	pcie_wlanen: pcie-wlanen-pins {
+		samsung,pins = "gpj2-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
 	initial_ese: initial-state {
-		PIN(INPUT, gpj2-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpj2-2, DOWN, FAST_SR1);
+		PIN_IN(gpj2-1, DOWN, FAST_SR1);
+		PIN_IN(gpj2-2, DOWN, FAST_SR1);
 	};
 };
 
@@ -1119,11 +1122,11 @@ &pinctrl_fsys {
 	pinctrl-0 = <&initial_fsys>;
 
 	initial_fsys: initial-state {
-		PIN(INPUT, gpr3-0, NONE, FAST_SR1);
-		PIN(INPUT, gpr3-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpr3-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpr3-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpr3-7, NONE, FAST_SR1);
+		PIN_IN(gpr3-0, NONE, FAST_SR1);
+		PIN_IN(gpr3-1, DOWN, FAST_SR1);
+		PIN_IN(gpr3-2, DOWN, FAST_SR1);
+		PIN_IN(gpr3-3, DOWN, FAST_SR1);
+		PIN_IN(gpr3-7, NONE, FAST_SR1);
 	};
 };
 
@@ -1132,14 +1135,14 @@ &pinctrl_imem {
 	pinctrl-0 = <&initial_imem>;
 
 	initial_imem: initial-state {
-		PIN(INPUT, gpf0-0, UP, FAST_SR1);
-		PIN(INPUT, gpf0-1, UP, FAST_SR1);
-		PIN(INPUT, gpf0-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpf0-3, UP, FAST_SR1);
-		PIN(INPUT, gpf0-4, DOWN, FAST_SR1);
-		PIN(INPUT, gpf0-5, NONE, FAST_SR1);
-		PIN(INPUT, gpf0-6, DOWN, FAST_SR1);
-		PIN(INPUT, gpf0-7, UP, FAST_SR1);
+		PIN_IN(gpf0-0, UP, FAST_SR1);
+		PIN_IN(gpf0-1, UP, FAST_SR1);
+		PIN_IN(gpf0-2, DOWN, FAST_SR1);
+		PIN_IN(gpf0-3, UP, FAST_SR1);
+		PIN_IN(gpf0-4, DOWN, FAST_SR1);
+		PIN_IN(gpf0-5, NONE, FAST_SR1);
+		PIN_IN(gpf0-6, DOWN, FAST_SR1);
+		PIN_IN(gpf0-7, UP, FAST_SR1);
 	};
 };
 
@@ -1148,7 +1151,7 @@ &pinctrl_nfc {
 	pinctrl-0 = <&initial_nfc>;
 
 	initial_nfc: initial-state {
-		PIN(INPUT, gpj0-2, DOWN, FAST_SR1);
+		PIN_IN(gpj0-2, DOWN, FAST_SR1);
 	};
 };
 
@@ -1157,53 +1160,53 @@ &pinctrl_peric {
 	pinctrl-0 = <&initial_peric>;
 
 	initial_peric: initial-state {
-		PIN(INPUT, gpv7-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpv7-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpv7-2, NONE, FAST_SR1);
-		PIN(INPUT, gpv7-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpv7-4, DOWN, FAST_SR1);
-		PIN(INPUT, gpv7-5, DOWN, FAST_SR1);
+		PIN_IN(gpv7-0, DOWN, FAST_SR1);
+		PIN_IN(gpv7-1, DOWN, FAST_SR1);
+		PIN_IN(gpv7-2, NONE, FAST_SR1);
+		PIN_IN(gpv7-3, DOWN, FAST_SR1);
+		PIN_IN(gpv7-4, DOWN, FAST_SR1);
+		PIN_IN(gpv7-5, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpb0-4, DOWN, FAST_SR1);
+		PIN_IN(gpb0-4, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpc0-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpc0-5, DOWN, FAST_SR1);
-		PIN(INPUT, gpc0-7, DOWN, FAST_SR1);
+		PIN_IN(gpc0-2, DOWN, FAST_SR1);
+		PIN_IN(gpc0-5, DOWN, FAST_SR1);
+		PIN_IN(gpc0-7, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpc1-1, DOWN, FAST_SR1);
+		PIN_IN(gpc1-1, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpc3-4, NONE, FAST_SR1);
-		PIN(INPUT, gpc3-5, NONE, FAST_SR1);
-		PIN(INPUT, gpc3-6, NONE, FAST_SR1);
-		PIN(INPUT, gpc3-7, NONE, FAST_SR1);
+		PIN_IN(gpc3-4, NONE, FAST_SR1);
+		PIN_IN(gpc3-5, NONE, FAST_SR1);
+		PIN_IN(gpc3-6, NONE, FAST_SR1);
+		PIN_IN(gpc3-7, NONE, FAST_SR1);
 
-		PIN(OUTPUT, gpg0-0, NONE, FAST_SR1);
-		PIN(2, gpg0-1, DOWN, FAST_SR1);
+		PIN_OT(gpg0-0, NONE, FAST_SR1);
+		PIN_F2(gpg0-1, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpd2-5, DOWN, FAST_SR1);
+		PIN_IN(gpd2-5, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpd4-0, NONE, FAST_SR1);
-		PIN(INPUT, gpd4-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpd4-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpd4-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpd4-4, DOWN, FAST_SR1);
+		PIN_IN(gpd4-0, NONE, FAST_SR1);
+		PIN_IN(gpd4-1, DOWN, FAST_SR1);
+		PIN_IN(gpd4-2, DOWN, FAST_SR1);
+		PIN_IN(gpd4-3, DOWN, FAST_SR1);
+		PIN_IN(gpd4-4, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpd6-3, DOWN, FAST_SR1);
+		PIN_IN(gpd6-3, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpd8-1, UP, FAST_SR1);
+		PIN_IN(gpd8-1, UP, FAST_SR1);
 
-		PIN(INPUT, gpg1-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpg1-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpg1-2, DOWN, FAST_SR1);
-		PIN(INPUT, gpg1-3, DOWN, FAST_SR1);
-		PIN(INPUT, gpg1-4, DOWN, FAST_SR1);
+		PIN_IN(gpg1-0, DOWN, FAST_SR1);
+		PIN_IN(gpg1-1, DOWN, FAST_SR1);
+		PIN_IN(gpg1-2, DOWN, FAST_SR1);
+		PIN_IN(gpg1-3, DOWN, FAST_SR1);
+		PIN_IN(gpg1-4, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpg2-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpg2-1, DOWN, FAST_SR1);
+		PIN_IN(gpg2-0, DOWN, FAST_SR1);
+		PIN_IN(gpg2-1, DOWN, FAST_SR1);
 
-		PIN(INPUT, gpg3-0, DOWN, FAST_SR1);
-		PIN(INPUT, gpg3-1, DOWN, FAST_SR1);
-		PIN(INPUT, gpg3-5, DOWN, FAST_SR1);
+		PIN_IN(gpg3-0, DOWN, FAST_SR1);
+		PIN_IN(gpg3-1, DOWN, FAST_SR1);
+		PIN_IN(gpg3-5, DOWN, FAST_SR1);
 	};
 };
 
@@ -1212,7 +1215,7 @@ &pinctrl_touch {
 	pinctrl-0 = <&initial_touch>;
 
 	initial_touch: initial-state {
-		PIN(INPUT, gpj1-2, DOWN, FAST_SR1);
+		PIN_IN(gpj1-2, DOWN, FAST_SR1);
 	};
 };
 
-- 
2.32.0

