Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DCA4ACDC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbiBHBMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbiBHBAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:00:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B916C061355;
        Mon,  7 Feb 2022 17:00:43 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m4so47375367ejb.9;
        Mon, 07 Feb 2022 17:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AnqRCRHjum3Lv75PRk6QZY+wEi1sAnkZbU7KAtSshc=;
        b=auyI6aPbNuUFdfUjxJxiRmUGahJ4TwWMZw3ksVpVMn9npSrgLIyDrJJwWZ14iZifK2
         ch5nLC62ZL++VH40QcNEGFUYdWmnWLxBNo6hoSjfZK5KoN+4gMTciMQkJB/jgvwX/mlw
         LojDYK00XTV7JY4I7ePApg/rziod7t1VZz5xPzpQRPAtylQ/LO4FY1cyuFUOz0vRG3fB
         TmKaqYEFk4ZUyybFxDqq8lInJsN+C2fuid9Be8+ZN+LRaoccx70rrV5riPWBocCWNqYh
         UCnfwRBEBIKPekmYn4x5BA4vgs6IbHBiVTmmlHIYttGFe3e6OrPR7Mm20rwe1YLzs2r8
         JaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AnqRCRHjum3Lv75PRk6QZY+wEi1sAnkZbU7KAtSshc=;
        b=eFDOuMFQRmxD1uBu36SoSi3J48x2Adh+SVZdPHM66Krmxg0Amb+pl+244lXETRo+nl
         qKwC/pd+VuVJ/xGMBJHPH9hPKa8sL+mKiCI4RVY2aruDSCxooAwMn/Zu8O3LoVVjuM2D
         ExYak1/Ib/YR/UQ5n84qhM8lUjConPtTwgf5lQEttgTrwd0pImZZDByN13UBN+Om8XCB
         9bvvH7AfFGzCwctOLR/v1BOFFDCDgmOpUM2RGBFgF7qbyyBpmbdqSsVW1V8IoXwuUOqm
         0yUj2OiFkGEZUPzP7eUkFo5aoO7vUEqfPDuEWMdFc61ldkXtX5L3F9C7x2/q1wBPFjXQ
         coBQ==
X-Gm-Message-State: AOAM532wHizztS+kNON2K+zcFvMPTf39O3qfMmaWxmMCyMOuh2M9vkxj
        qOtytaZr1S17uXahj+nix/RbGl5qJ4OUyXO6uBg=
X-Google-Smtp-Source: ABdhPJwNFE50vrDF3pdDDcyR9PGwiJlGOk1zd+59R/0BBV5d0q7msHi0nA7wLrhOTCG/pSfZPUyDKg==
X-Received: by 2002:a17:906:e20d:: with SMTP id gf13mr1702834ejb.414.1644282041605;
        Mon, 07 Feb 2022 17:00:41 -0800 (PST)
Received: from localhost (92.40.202.227.threembb.co.uk. [92.40.202.227])
        by smtp.gmail.com with ESMTPSA id p19sm4197644ejc.42.2022.02.07.17.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 17:00:41 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: ingenic: Mark critical clocks in Ingenic SoCs
Date:   Tue,  8 Feb 2022 01:00:47 +0000
Message-Id: <20220208010048.211691-3-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
References: <20220208010048.211691-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the CPU, L2 cache, and memory as critical to ensure they
are not disabled.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/jz4725b-cgu.c | 2 ++
 drivers/clk/ingenic/jz4740-cgu.c  | 2 ++
 drivers/clk/ingenic/jz4760-cgu.c  | 2 ++
 drivers/clk/ingenic/jz4770-cgu.c  | 1 +
 drivers/clk/ingenic/jz4780-cgu.c  | 3 +++
 drivers/clk/ingenic/x1000-cgu.c   | 3 +++
 drivers/clk/ingenic/x1830-cgu.c   | 3 +++
 7 files changed, 16 insertions(+)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 744d136b721b..639fa4e29b05 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -87,6 +87,7 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	[JZ4725B_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -114,6 +115,7 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	[JZ4725B_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 43ffb62c42bb..2b6f7a9fcea8 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -102,6 +102,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	[JZ4740_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -129,6 +130,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	[JZ4740_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4760-cgu.c b/drivers/clk/ingenic/jz4760-cgu.c
index 8fdd383560fb..7920df2cee1a 100644
--- a/drivers/clk/ingenic/jz4760-cgu.c
+++ b/drivers/clk/ingenic/jz4760-cgu.c
@@ -143,6 +143,7 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 
 	[JZ4760_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4760_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -175,6 +176,7 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 	},
 	[JZ4760_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4760_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 7ef91257630e..02b266c2a537 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -149,6 +149,7 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 
 	[JZ4770_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4770_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index e357c228e0f1..014674486038 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -341,12 +341,14 @@ static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
 
 	[JZ4780_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CLOCKCONTROL, 0, 1, 4, 22, -1, -1 },
 	},
 
 	[JZ4780_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CLOCKCONTROL, 4, 1, 4, -1, -1, -1 },
 	},
@@ -380,6 +382,7 @@ static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
 
 	[JZ4780_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 3c4d5a77ccbd..1bd421cc2ab3 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -251,6 +251,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 30 },
@@ -258,6 +259,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
 	},
@@ -290,6 +292,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, X1000_CLK_SCLKA, X1000_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-cgu.c
index e01ec2dc7a1a..b08e318aa095 100644
--- a/drivers/clk/ingenic/x1830-cgu.c
+++ b/drivers/clk/ingenic/x1830-cgu.c
@@ -225,6 +225,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
 		.gate = { CGU_REG_CLKGR1, 15 },
@@ -232,6 +233,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
 	},
@@ -264,6 +266,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, X1830_CLK_SCLKA, X1830_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
-- 
2.34.1

