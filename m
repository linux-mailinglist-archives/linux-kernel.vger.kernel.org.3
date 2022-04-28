Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A94F513A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350313AbiD1Qrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiD1Qrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:47:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CCBB1AB0;
        Thu, 28 Apr 2022 09:44:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso4695701wmh.2;
        Thu, 28 Apr 2022 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+OlFWTbdzDsv9ToIL/R1210CLuDsQYdcda5qA/W19rg=;
        b=GbfNWAoyM2WevW9mfDQ6B0o1VRET7tZQdeALnKgHhzIXdqO2GH/F6b/gSelnw0iPJH
         zTqVqE7u662EulQa/xmQHrq9g0IQt4BHv/nFna4/zucTVpg6qBB2RBq8gU1Q5BgyLYOW
         yxjlFqYFozouqqROp8zejWKsmPSq908+Ryyv3FVbmEuVlcp8A5rVX73QcDcSduIGheyr
         XPQwVMmzDYjyWzdThF6euRPQjQzW/3ubwWUpX+xdEJdQ1+l5YIt2y9jM6/4p84UskSZP
         IWBO5kpAhR21fzktbxTuFi+ohIkcCc9zR90Ab8YEwLsSav5e4MVgA4fhy4JB/3IoXEX/
         iKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+OlFWTbdzDsv9ToIL/R1210CLuDsQYdcda5qA/W19rg=;
        b=s718pZuAkh5nBfGcZa6LR2Ep7x0I6c5TvWaU1kmDse76klA3OqWTLNZ3Dxq8nlMAzo
         b5zeMhq+Uwu0t2a0unEPRY0JxV0HOUpV9t0DEjW492xacVUZ6XELoCNCYwvC9VkEVz/K
         UHX2g1FiNL9JpJfEDd7EHtbbpnK9EQMeKSqAg1gaIK/UTVyIjE9+3/Bi4il8lABNr3kq
         vYAcox9Wrqzp1sgXkA1lZDi9+evmDNPNsl8QTW28yNYhNZ4cixcm9VQZwLkoARTINvPq
         R6erUJ578nhi+vAQ3EuVE0p5E95SLGBh6Oe4jYKuZB7PWAX8Y6dRrYmsqxli0iPyY/3f
         tSqQ==
X-Gm-Message-State: AOAM531ay3jf6yqucYeLQ2HFMO6Y3INp2d2HbJ14isJ+jiuwb+5JtSGm
        T9r6v559Bg9fwWnKDCo1udY=
X-Google-Smtp-Source: ABdhPJxGuFltFCqoZbiB2CsQt6fjOfYm865SzHsHBG1LG0V6RbJwHElh59p0lhayuwW11XVzzcDwLA==
X-Received: by 2002:a7b:cb48:0:b0:394:b64:8b88 with SMTP id v8-20020a7bcb48000000b003940b648b88mr5624216wmj.183.1651164262619;
        Thu, 28 Apr 2022 09:44:22 -0700 (PDT)
Received: from localhost (92.40.203.206.threembb.co.uk. [92.40.203.206])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm4453035wma.43.2022.04.28.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:44:22 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 2/3] clk: ingenic: Mark critical clocks in Ingenic SoCs
Date:   Thu, 28 Apr 2022 17:44:53 +0100
Message-Id: <20220428164454.17908-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
References: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider CPU, L2 cache, and memory clocks as critical to prevent
them -- and the parent clocks -- from being automatically gated,
since nothing calls clk_get() on these clocks.

Gating the CPU clock hangs the processor, and gating memory makes
external DRAM inaccessible. Normal kernel code can't hope to deal
with either situation so those clocks have to be critical.

The L2 cache is required only if caches are running, and could be
gated if the kernel takes care to flush and disable caches before
gating the clock. There's no mechanism to do this, and probably no
reason to do it, so it's simpler to mark the L2 cache as critical.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4725b-cgu.c | 10 ++++++++++
 drivers/clk/ingenic/jz4740-cgu.c  | 10 ++++++++++
 drivers/clk/ingenic/jz4760-cgu.c  | 10 ++++++++++
 drivers/clk/ingenic/jz4770-cgu.c  |  5 +++++
 drivers/clk/ingenic/jz4780-cgu.c  | 15 +++++++++++++++
 drivers/clk/ingenic/x1000-cgu.c   | 15 +++++++++++++++
 drivers/clk/ingenic/x1830-cgu.c   | 11 +++++++++++
 7 files changed, 76 insertions(+)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 15d61793f53b..590e9c85cb25 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -87,6 +87,11 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	[JZ4725B_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		/*
+		 * Disabling the CPU clock or any parent clocks will hang the
+		 * system; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -114,6 +119,11 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	[JZ4725B_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		/*
+		 * Disabling MCLK or its parents will render DRAM
+		 * inaccessible; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 43ffb62c42bb..3e0a30574ebb 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -102,6 +102,11 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	[JZ4740_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		/*
+		 * Disabling the CPU clock or any parent clocks will hang the
+		 * system; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -129,6 +134,11 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	[JZ4740_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		/*
+		 * Disabling MCLK or its parents will render DRAM
+		 * inaccessible; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4760-cgu.c b/drivers/clk/ingenic/jz4760-cgu.c
index 8fdd383560fb..ecd395ac8a28 100644
--- a/drivers/clk/ingenic/jz4760-cgu.c
+++ b/drivers/clk/ingenic/jz4760-cgu.c
@@ -143,6 +143,11 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 
 	[JZ4760_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		/*
+		 * Disabling the CPU clock or any parent clocks will hang the
+		 * system; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4760_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -175,6 +180,11 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 	},
 	[JZ4760_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		/*
+		 * Disabling MCLK or its parents will render DRAM
+		 * inaccessible; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4760_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 7ef91257630e..6ae1740367f9 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -149,6 +149,11 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 
 	[JZ4770_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		/*
+		 * Disabling the CPU clock or any parent clocks will hang the
+		 * system; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4770_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index e357c228e0f1..b1dadc0a5e75 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -341,12 +341,22 @@ static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
 
 	[JZ4780_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV,
+		/*
+		 * Disabling the CPU clock or any parent clocks will hang the
+		 * system; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CLOCKCONTROL, 0, 1, 4, 22, -1, -1 },
 	},
 
 	[JZ4780_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		/*
+		 * The L2 cache clock is critical if caches are enabled and
+		 * disabling it or any parent clocks will hang the system.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CLOCKCONTROL, 4, 1, 4, -1, -1, -1 },
 	},
@@ -380,6 +390,11 @@ static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
 
 	[JZ4780_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV,
+		/*
+		 * Disabling DDR clock or its parents will render DRAM
+		 * inaccessible; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 3c4d5a77ccbd..b2ce3fb83f54 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -251,6 +251,11 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
+		/*
+		 * Disabling the CPU clock or any parent clocks will hang the
+		 * system; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 30 },
@@ -258,6 +263,11 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		/*
+		 * The L2 cache clock is critical if caches are enabled and
+		 * disabling it or any parent clocks will hang the system.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
 	},
@@ -290,6 +300,11 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		/*
+		 * Disabling DDR clock or its parents will render DRAM
+		 * inaccessible; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, X1000_CLK_SCLKA, X1000_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-cgu.c
index e01ec2dc7a1a..0fd46e50a513 100644
--- a/drivers/clk/ingenic/x1830-cgu.c
+++ b/drivers/clk/ingenic/x1830-cgu.c
@@ -225,6 +225,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
 		.gate = { CGU_REG_CLKGR1, 15 },
@@ -232,6 +233,11 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		/*
+		 * The L2 cache clock is critical if caches are enabled and
+		 * disabling it or any parent clocks will hang the system.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
 	},
@@ -264,6 +270,11 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		/*
+		 * Disabling DDR clock or its parents will render DRAM
+		 * inaccessible; mark it critical.
+		 */
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, X1830_CLK_SCLKA, X1830_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
-- 
2.35.1

