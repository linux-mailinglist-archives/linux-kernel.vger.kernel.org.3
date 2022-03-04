Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE74CD1F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiCDKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiCDKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:04:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11AE1A6379
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:03:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cx5so6976046pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 02:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYFL0iPSwAf6t4Xy8/IdB3oKrUUwcpR0xg3nUHnjLu4=;
        b=V527q47pid75/3NYSmywQBzh9ZFCLttCNjfmNSferZ/tChovUCyQ90/8KnQ+2yPVTZ
         pZSGr4qBXVf+WhdZl5CP9vW7jcHlllns0+Kt7CLYS3j6u6HZlzXRzcBLxkKZr8ngVvO8
         wVh4AePCI/pn/zYghzsXdyysvXNDwOgHWI3wtFUFz2ccPgrE7yVpQ+nLjc9V/U2P6pit
         x1ik+jNj/Gk7fPSG2ZR9N7DC8A+mUPRTb+mH3VEqRI4oSxOEeN05cbtvwDpR1rIJzcus
         8sxqwWDPaM5uOATqnUsMHJo+MDNc3JVO3KxtUcPmc3AnMo29WVPYC0mXuY6XoIRHMLPf
         fm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYFL0iPSwAf6t4Xy8/IdB3oKrUUwcpR0xg3nUHnjLu4=;
        b=nkp+2l9/r1z+tp4xHQZ1mZAKb6gg7WRKIqdDJJ7cv3ldAV4AejBbY1z8NpWUl8kEfM
         XUMD2IycdaYCgxiYLkV0aVD00DJrHm+9ny9o0NjsNJhbwp9014Xs6MZkZEimZq27zHeM
         q01zxOpRDQKsBuLOZBecYL6X9Rq1X1BeHhRajy0Au6mIe2viOtC648IIIU0omkHH+GEc
         5G99EBKPFeErl9t00GX1vrI+R1mpXZa+HG+nCSHkKvznyl+mE6736azqyjUdnIopjuo/
         x0H40Uc6KHRAc1whHab0Zv3ZZSCsK8BNmqbbIms5cl9aX9+qpQZJhF9ozfJwVcUZEnH5
         qmqg==
X-Gm-Message-State: AOAM532OpP59HaPt+PMUqdxe3PmiwJj1I5rshJqpWBgR13hz/OuI5kEf
        pkZyqHRKsiCjM/pz4n2/g1aNyA==
X-Google-Smtp-Source: ABdhPJzG9qXo2I0tXsjIyl0lHwrW+VqTZtgqDaRK+ltqrSu8dN6PjxxF5qvTow6wqB2cl/NTp6epJQ==
X-Received: by 2002:a17:902:b692:b0:151:5474:d3ee with SMTP id c18-20020a170902b69200b001515474d3eemr29418093pls.139.1646388218005;
        Fri, 04 Mar 2022 02:03:38 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00174800b004f26d3f5b03sm5461605pfc.39.2022.03.04.02.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:03:37 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v2 4/5] clk: sifive: Add SoCs prefix in each SoCs-dependent data
Date:   Fri,  4 Mar 2022 18:03:20 +0800
Message-Id: <7728ef662c59449ce954b1b62c6ad5241e07adfb.1646388139.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is prerequisite for moving SoCs C files into SoCs header
files. Currently, fu540-prci.c and fu740-prci.c use same names for
several macro definitions and variables, it would cause redefinition
error when we trying to include all stuff in sifive-prci.c. In this
patch, we also remove the temporary macro definitions which are
added by previous patch.

Signed-off-by: Zong Li <zong.li@sifive.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/clk/sifive/fu540-prci.c | 29 +++++++----------
 drivers/clk/sifive/fu740-prci.c | 56 ++++++++++++++-------------------
 2 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index 9e13119066eb..672c782ad604 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2018-2019 SiFive, Inc.
+ * Copyright (C) 2018-2022 SiFive, Inc.
  * Copyright (C) 2018-2019 Wesley Terpstra
  * Copyright (C) 2018-2019 Paul Walmsley
- * Copyright (C) 2020 Zong Li
+ * Copyright (C) 2020-2022 Zong Li
  *
  * The FU540 PRCI implements clock and reset control for the SiFive
  * FU540-C000 chip.  This driver assumes that it has sole control
@@ -22,26 +22,21 @@
 
 #include "sifive-prci.h"
 
-#define PRCI_CLK_COREPLL	0
-#define PRCI_CLK_DDRPLL		1
-#define PRCI_CLK_GEMGXLPLL	2
-#define PRCI_CLK_TLCLK		3
-
 /* PRCI integration data for each WRPLL instance */
 
-static struct __prci_wrpll_data __prci_corepll_data = {
+static struct __prci_wrpll_data sifive_fu540_prci_corepll_data = {
 	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
 	.disable_bypass = sifive_prci_coreclksel_use_corepll,
 };
 
-static struct __prci_wrpll_data __prci_ddrpll_data = {
+static struct __prci_wrpll_data sifive_fu540_prci_ddrpll_data = {
 	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
 };
 
-static struct __prci_wrpll_data __prci_gemgxlpll_data = {
+static struct __prci_wrpll_data sifive_fu540_prci_gemgxlpll_data = {
 	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
 };
@@ -67,25 +62,25 @@ static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops = {
 
 /* List of clock controls provided by the PRCI */
 struct __prci_clock __prci_init_clocks_fu540[] = {
-	[PRCI_CLK_COREPLL] = {
+	[FU540_PRCI_CLK_COREPLL] = {
 		.name = "corepll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
-		.pwd = &__prci_corepll_data,
+		.pwd = &sifive_fu540_prci_corepll_data,
 	},
-	[PRCI_CLK_DDRPLL] = {
+	[FU540_PRCI_CLK_DDRPLL] = {
 		.name = "ddrpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_ro_clk_ops,
-		.pwd = &__prci_ddrpll_data,
+		.pwd = &sifive_fu540_prci_ddrpll_data,
 	},
-	[PRCI_CLK_GEMGXLPLL] = {
+	[FU540_PRCI_CLK_GEMGXLPLL] = {
 		.name = "gemgxlpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
-		.pwd = &__prci_gemgxlpll_data,
+		.pwd = &sifive_fu540_prci_gemgxlpll_data,
 	},
-	[PRCI_CLK_TLCLK] = {
+	[FU540_PRCI_CLK_TLCLK] = {
 		.name = "tlclk",
 		.parent_name = "corepll",
 		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
index 7141a22d90e3..f27d1a42d946 100644
--- a/drivers/clk/sifive/fu740-prci.c
+++ b/drivers/clk/sifive/fu740-prci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2020 SiFive, Inc.
- * Copyright (C) 2020 Zong Li
+ * Copyright (C) 2020-2022 SiFive, Inc.
+ * Copyright (C) 2020-2022 Zong Li
  */
 
 #include <linux/module.h>
@@ -10,50 +10,40 @@
 
 #include "sifive-prci.h"
 
-#define PRCI_CLK_COREPLL	0
-#define PRCI_CLK_DDRPLL		1
-#define PRCI_CLK_GEMGXLPLL	2
-#define PRCI_CLK_DVFSCOREPLL	3
-#define PRCI_CLK_HFPCLKPLL	4
-#define PRCI_CLK_CLTXPLL	5
-#define PRCI_CLK_TLCLK		6
-#define PRCI_CLK_PCLK		7
-#define PRCI_CLK_PCIE_AUX	8
-
 /* PRCI integration data for each WRPLL instance */
 
-static struct __prci_wrpll_data __prci_corepll_data = {
+static struct __prci_wrpll_data sifive_fu740_prci_corepll_data = {
 	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
 	.disable_bypass = sifive_prci_coreclksel_use_final_corepll,
 };
 
-static struct __prci_wrpll_data __prci_ddrpll_data = {
+static struct __prci_wrpll_data sifive_fu740_prci_ddrpll_data = {
 	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
 };
 
-static struct __prci_wrpll_data __prci_gemgxlpll_data = {
+static struct __prci_wrpll_data sifive_fu740_prci_gemgxlpll_data = {
 	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
 };
 
-static struct __prci_wrpll_data __prci_dvfscorepll_data = {
+static struct __prci_wrpll_data sifive_fu740_prci_dvfscorepll_data = {
 	.cfg0_offs = PRCI_DVFSCOREPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_DVFSCOREPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_corepllsel_use_corepll,
 	.disable_bypass = sifive_prci_corepllsel_use_dvfscorepll,
 };
 
-static struct __prci_wrpll_data __prci_hfpclkpll_data = {
+static struct __prci_wrpll_data sifive_fu740_prci_hfpclkpll_data = {
 	.cfg0_offs = PRCI_HFPCLKPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_HFPCLKPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_hfpclkpllsel_use_hfclk,
 	.disable_bypass = sifive_prci_hfpclkpllsel_use_hfpclkpll,
 };
 
-static struct __prci_wrpll_data __prci_cltxpll_data = {
+static struct __prci_wrpll_data sifive_fu740_prci_cltxpll_data = {
 	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
 	.cfg1_offs = PRCI_CLTXPLLCFG1_OFFSET,
 };
@@ -89,53 +79,53 @@ static const struct clk_ops sifive_fu740_prci_pcie_aux_clk_ops = {
 
 /* List of clock controls provided by the PRCI */
 struct __prci_clock __prci_init_clocks_fu740[] = {
-	[PRCI_CLK_COREPLL] = {
+	[FU740_PRCI_CLK_COREPLL] = {
 		.name = "corepll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_corepll_data,
+		.pwd = &sifive_fu740_prci_corepll_data,
 	},
-	[PRCI_CLK_DDRPLL] = {
+	[FU740_PRCI_CLK_DDRPLL] = {
 		.name = "ddrpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu740_prci_wrpll_ro_clk_ops,
-		.pwd = &__prci_ddrpll_data,
+		.pwd = &sifive_fu740_prci_ddrpll_data,
 	},
-	[PRCI_CLK_GEMGXLPLL] = {
+	[FU740_PRCI_CLK_GEMGXLPLL] = {
 		.name = "gemgxlpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_gemgxlpll_data,
+		.pwd = &sifive_fu740_prci_gemgxlpll_data,
 	},
-	[PRCI_CLK_DVFSCOREPLL] = {
+	[FU740_PRCI_CLK_DVFSCOREPLL] = {
 		.name = "dvfscorepll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_dvfscorepll_data,
+		.pwd = &sifive_fu740_prci_dvfscorepll_data,
 	},
-	[PRCI_CLK_HFPCLKPLL] = {
+	[FU740_PRCI_CLK_HFPCLKPLL] = {
 		.name = "hfpclkpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_hfpclkpll_data,
+		.pwd = &sifive_fu740_prci_hfpclkpll_data,
 	},
-	[PRCI_CLK_CLTXPLL] = {
+	[FU740_PRCI_CLK_CLTXPLL] = {
 		.name = "cltxpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_cltxpll_data,
+		.pwd = &sifive_fu740_prci_cltxpll_data,
 	},
-	[PRCI_CLK_TLCLK] = {
+	[FU740_PRCI_CLK_TLCLK] = {
 		.name = "tlclk",
 		.parent_name = "corepll",
 		.ops = &sifive_fu740_prci_tlclksel_clk_ops,
 	},
-	[PRCI_CLK_PCLK] = {
+	[FU740_PRCI_CLK_PCLK] = {
 		.name = "pclk",
 		.parent_name = "hfpclkpll",
 		.ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
 	},
-	[PRCI_CLK_PCIE_AUX] = {
+	[FU740_PRCI_CLK_PCIE_AUX] = {
 		.name = "pcie_aux",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu740_prci_pcie_aux_clk_ops,
-- 
2.31.1

