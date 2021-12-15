Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB1475CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbhLOQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbhLOQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:09:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFDC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:09:12 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v11so39027344wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/TM1jCLS8+qAZcZQ7qUonc4KZrnXgaUSgc+VrkoQ4U=;
        b=zqUk8XAVjsAivUZ0Lx9e1Vj0c5iix18c9FkkENQNzO/50Lo7m2G7ILg0h5eiCnKO1u
         0r1W6wTD5n7jWGtUCNH8SnDp0CCNfotzkcikiPlFAfd/20NjdDZS3R6CQEDx6rw+KKhF
         Bylms3GV7RIWrmEfe8UGebuO2DfUsdPxGzziV73IneThvWFoAZWsbPOLHZ9SH2bZ3g1i
         SojOkTaPP0on3emm0v9k+FHjcvQ6P711lOFE2+YTBQCA3/q4OC9Fy4Xn1hcftx/T+v/9
         w3MltMaoqIAKwNMHjOG82wiJtTBqS7sBULqh1d/cMcTeEoHgt1yuu59cRC4YOj0Z9smT
         ycbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/TM1jCLS8+qAZcZQ7qUonc4KZrnXgaUSgc+VrkoQ4U=;
        b=7RrdwCvEPS2uEcDyiH7gl1p2OinPh/VTZkauwHkQu83DudQBi7Mj28YJMSpBfJ3/8D
         x1UHpQYdphF9u0o6qj/gCO4FK42UwMbe1z2LuT76kOQi2NhuedLq2vKtNgYizx0uFg6Q
         5GnyMTzzwFXue5+VwJ6mFRvHebSDlIoMboLCcdpINfBw7yNe7j2O/a8TdYfqCreWY02c
         e3SCs/KIrc5vTRLx4UfUOaiXMiSQc/JVz+pvR2f6sFAIKKDHO+EAG67ElR5iJcwZi9VR
         dyYgdZYZHI2zR1tPU7vJOpGvXNn+sasJGg4dCf54/BNEwaYxAvxKnuKGZJiPflVkRIMk
         2t+Q==
X-Gm-Message-State: AOAM530ErBRDJSgjNm01OE4iUinCKcu+WcEZPbS/blMTZRgwEOA2IEWm
        aWruOmG13LvgeKZl1e/ZhNldiA==
X-Google-Smtp-Source: ABdhPJw0KuIM9Be8sqhwKBYTb7ZrWiFZDF0t0/9duCAS7cJSkTttUxepq6ufpajZvP/EJndxWB+vAQ==
X-Received: by 2002:a5d:5689:: with SMTP id f9mr4934736wrv.124.1639584550672;
        Wed, 15 Dec 2021 08:09:10 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id n14sm2935343wrf.69.2021.12.15.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:09:10 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Hao Fang <fanghao11@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/7] clk: samsung: exynos850: Add missing sysreg clocks
Date:   Wed, 15 Dec 2021 18:09:01 +0200
Message-Id: <20211215160906.17451-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215160906.17451-1-semen.protsenko@linaro.org>
References: <20211215160906.17451-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System Register is used to configure system behavior, like USI protocol,
etc. SYSREG clocks should be provided to corresponding syscon nodes, to
make it possible to modify SYSREG registers.

While at it, add also missing PMU and GPIO clocks, which looks necessary
and might be needed for corresponding Exynos850 features soon.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 568ac97c8120..4799771d09bc 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -426,11 +426,14 @@ CLK_OF_DECLARE(exynos850_cmu_top, "samsung,exynos850-cmu-top",
 #define CLK_CON_DIV_DIV_CLK_APM_I3C			0x1808
 #define CLK_CON_GAT_CLKCMU_CMGP_BUS			0x2000
 #define CLK_CON_GAT_GATE_CLKCMU_CHUB_BUS		0x2014
+#define CLK_CON_GAT_GOUT_APM_APBIF_GPIO_ALIVE_PCLK	0x2018
+#define CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK	0x2020
 #define CLK_CON_GAT_GOUT_APM_APBIF_RTC_PCLK		0x2024
 #define CLK_CON_GAT_GOUT_APM_APBIF_TOP_RTC_PCLK		0x2028
 #define CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_PCLK	0x2034
 #define CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_SCLK	0x2038
 #define CLK_CON_GAT_GOUT_APM_SPEEDY_APM_PCLK		0x20bc
+#define CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK		0x20c0
 
 static const unsigned long apm_clk_regs[] __initconst = {
 	PLL_CON0_MUX_CLKCMU_APM_BUS_USER,
@@ -445,11 +448,14 @@ static const unsigned long apm_clk_regs[] __initconst = {
 	CLK_CON_DIV_DIV_CLK_APM_I3C,
 	CLK_CON_GAT_CLKCMU_CMGP_BUS,
 	CLK_CON_GAT_GATE_CLKCMU_CHUB_BUS,
+	CLK_CON_GAT_GOUT_APM_APBIF_GPIO_ALIVE_PCLK,
+	CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK,
 	CLK_CON_GAT_GOUT_APM_APBIF_RTC_PCLK,
 	CLK_CON_GAT_GOUT_APM_APBIF_TOP_RTC_PCLK,
 	CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_PCLK,
 	CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_SCLK,
 	CLK_CON_GAT_GOUT_APM_SPEEDY_APM_PCLK,
+	CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK,
 };
 
 /* List of parent clocks for Muxes in CMU_APM */
@@ -512,6 +518,14 @@ static const struct samsung_gate_clock apm_gate_clks[] __initconst = {
 	     CLK_CON_GAT_GOUT_APM_I3C_APM_PMIC_I_SCLK, 21, 0, 0),
 	GATE(CLK_GOUT_SPEEDY_PCLK, "gout_speedy_pclk", "dout_apm_bus",
 	     CLK_CON_GAT_GOUT_APM_SPEEDY_APM_PCLK, 21, 0, 0),
+	/* TODO: Should be enabled in GPIO driver (or made CLK_IS_CRITICAL) */
+	GATE(CLK_GOUT_GPIO_ALIVE_PCLK, "gout_gpio_alive_pclk", "dout_apm_bus",
+	     CLK_CON_GAT_GOUT_APM_APBIF_GPIO_ALIVE_PCLK, 21, CLK_IGNORE_UNUSED,
+	     0),
+	GATE(CLK_GOUT_PMU_ALIVE_PCLK, "gout_pmu_alive_pclk", "dout_apm_bus",
+	     CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_SYSREG_APM_PCLK, "gout_sysreg_apm_pclk", "dout_apm_bus",
+	     CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK, 21, 0, 0),
 };
 
 static const struct samsung_cmu_info apm_cmu_info __initconst = {
@@ -541,6 +555,7 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 #define CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S0	0x200c
 #define CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S1	0x2010
 #define CLK_CON_GAT_GOUT_CMGP_GPIO_PCLK		0x2018
+#define CLK_CON_GAT_GOUT_CMGP_SYSREG_CMGP_PCLK	0x2040
 #define CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_IPCLK	0x2044
 #define CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_PCLK	0x2048
 #define CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_IPCLK	0x204c
@@ -556,6 +571,7 @@ static const unsigned long cmgp_clk_regs[] __initconst = {
 	CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S0,
 	CLK_CON_GAT_GOUT_CMGP_ADC_PCLK_S1,
 	CLK_CON_GAT_GOUT_CMGP_GPIO_PCLK,
+	CLK_CON_GAT_GOUT_CMGP_SYSREG_CMGP_PCLK,
 	CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_IPCLK,
 	CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_PCLK,
 	CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_IPCLK,
@@ -610,6 +626,9 @@ static const struct samsung_gate_clock cmgp_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_CMGP_USI1_PCLK, "gout_cmgp_usi1_pclk",
 	     "gout_clkcmu_cmgp_bus",
 	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_SYSREG_CMGP_PCLK, "gout_sysreg_cmgp_pclk",
+	     "gout_clkcmu_cmgp_bus",
+	     CLK_CON_GAT_GOUT_CMGP_SYSREG_CMGP_PCLK, 21, 0, 0),
 };
 
 static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
@@ -910,10 +929,12 @@ CLK_OF_DECLARE(exynos850_cmu_peri, "samsung,exynos850-cmu-peri",
 #define CLK_CON_DIV_DIV_CLK_CORE_BUSP		0x1800
 #define CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK	0x2038
 #define CLK_CON_GAT_GOUT_CORE_GIC_CLK		0x2040
+#define CLK_CON_GAT_GOUT_CORE_GPIO_CORE_PCLK	0x2044
 #define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_I_ACLK	0x20e8
 #define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN	0x20ec
 #define CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK	0x2128
 #define CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK	0x212c
+#define CLK_CON_GAT_GOUT_CORE_SYSREG_CORE_PCLK	0x2130
 
 static const unsigned long core_clk_regs[] __initconst = {
 	PLL_CON0_MUX_CLKCMU_CORE_BUS_USER,
@@ -924,10 +945,12 @@ static const unsigned long core_clk_regs[] __initconst = {
 	CLK_CON_DIV_DIV_CLK_CORE_BUSP,
 	CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK,
 	CLK_CON_GAT_GOUT_CORE_GIC_CLK,
+	CLK_CON_GAT_GOUT_CORE_GPIO_CORE_PCLK,
 	CLK_CON_GAT_GOUT_CORE_MMC_EMBD_I_ACLK,
 	CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN,
 	CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK,
 	CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK,
+	CLK_CON_GAT_GOUT_CORE_SYSREG_CORE_PCLK,
 };
 
 /* List of parent clocks for Muxes in CMU_CORE */
@@ -972,6 +995,12 @@ static const struct samsung_gate_clock core_gate_clks[] __initconst = {
 	     CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK, 21, 0, 0),
 	GATE(CLK_GOUT_SSS_PCLK, "gout_sss_pclk", "dout_core_busp",
 	     CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK, 21, 0, 0),
+	/* TODO: Should be enabled in GPIO driver (or made CLK_IS_CRITICAL) */
+	GATE(CLK_GOUT_GPIO_CORE_PCLK, "gout_gpio_core_pclk", "dout_core_busp",
+	     CLK_CON_GAT_GOUT_CORE_GPIO_CORE_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_SYSREG_CORE_PCLK, "gout_sysreg_core_pclk",
+	     "dout_core_busp",
+	     CLK_CON_GAT_GOUT_CORE_SYSREG_CORE_PCLK, 21, 0, 0),
 };
 
 static const struct samsung_cmu_info core_cmu_info __initconst = {
-- 
2.30.2

