Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16949374F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353164AbiASJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353090AbiASJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:28:55 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143D9C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:28:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id h13so1047225plf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FKdc1OBmlG1JQadHHjFpqdKo835b3NH4iwg4oWKtqI=;
        b=K1Oj4gAOHf0U8SSTSv/5jSms13s5leT2cgP3Dy/D8Jy02nDfpJtM3PJ9+ptae1A/xz
         tpf3bY3OjMW76aL8FG32V3lSq1MtuIp0CpkMJZK5dct5ABrlUagcEfx/84YEKG/vkWoH
         1Jp61pAL8uyIqPdFdkbpFv3YwFuo4h/QMZ3j+XZUHeG2eZBUV2tZqlD2X4GKRDfpi4Qf
         b4g/leXqyXL8Wyk4B1DJX8DFIkc73XkvYL+pOcD7XeVMxnNsXfPU22icFQ1CsML4M0lH
         vZFfEh9UUa89LWnBEhF+06RDWd36VkCRhfbV4wAAUH8CXUcWpSpwJsfpYtqmFXbyWE+H
         ee8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FKdc1OBmlG1JQadHHjFpqdKo835b3NH4iwg4oWKtqI=;
        b=nY/JSCtquMswA87bmFm5jTSOu7djaHmnmqAL10rGYfHl0MkUA3Mj2pORGKSLqvlCLH
         YhifdWvbZhCO6zJMRw53/zkljcl9LsXIZhH5WGgIVAXv4DCKT6qt01H6pRdFJHWtm4QO
         iD+qK2x36GkCWhmmeJg9BtiQb78/BhrGMUr6+Zhs9F+qbqRPoXOMd8uqyLb+Bsspbifk
         dzZjrx7GcRUse0owKJGxRwW3OfE5XRmt7Fy7V/LYuMtj6yEEadx0m+OjvQsUonSclhrr
         LQW+ij6OYa27MJOPLAQpr66cFr70DCHmYWGS+BkL+3b92Js0k0NzyWTaCZtaMyPyG0xl
         v5vQ==
X-Gm-Message-State: AOAM532lV54NYlHfImPwHqdPooI3p1hlerv0rJlf03p8xO+ftqo15kht
        TsQMj0OlNECPmDMrtiRKtz3iLA==
X-Google-Smtp-Source: ABdhPJzyNVaPauojnHiNjYFy6EdkZASjO4VtluS2MJaV7bDz+isUQv8h6HypQPK0ex8E+zNBM/dTYA==
X-Received: by 2002:a17:902:9343:b0:148:a2e8:2c49 with SMTP id g3-20020a170902934300b00148a2e82c49mr31720515plp.152.1642584534538;
        Wed, 19 Jan 2022 01:28:54 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y8sm1415894pfl.207.2022.01.19.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:28:53 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 3/4] clk: sifive: Add SoCs prefix in each SoCs-dependent data
Date:   Wed, 19 Jan 2022 17:28:40 +0800
Message-Id: <1c979637ffcb85f11e9dcb5c368e2f364cabfd11.1642582832.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642582832.git.zong.li@sifive.com>
References: <cover.1642582832.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is prerequisite for moving SoCs C files into SoCs header
files. Currently, fu540-prci.c and fu740-prci.c use same names for
several macro definitions and variables, it would cause redefinition
error when we trying to include all stuff in sifive-prci.c

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/clk/sifive/fu540-prci.c | 24 ++++++++---------
 drivers/clk/sifive/fu740-prci.c | 46 ++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index 29bab915003c..d686f5cf3f71 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2018-2019 SiFive, Inc.
+ * Copyright (C) 2018-2021 SiFive, Inc.
  * Copyright (C) 2018-2019 Wesley Terpstra
  * Copyright (C) 2018-2019 Paul Walmsley
- * Copyright (C) 2020 Zong Li
+ * Copyright (C) 2020-2021 Zong Li
  *
  * The FU540 PRCI implements clock and reset control for the SiFive
  * FU540-C000 chip.  This driver assumes that it has sole control
@@ -25,19 +25,19 @@
 
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
@@ -63,25 +63,25 @@ static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops = {
 
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
index 53f6e00a03b9..bd66559fe2f8 100644
--- a/drivers/clk/sifive/fu740-prci.c
+++ b/drivers/clk/sifive/fu740-prci.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2020 SiFive, Inc.
- * Copyright (C) 2020 Zong Li
+ * Copyright (C) 2020-2021 SiFive, Inc.
+ * Copyright (C) 2020-2021 Zong Li
  */
 
 #include <linux/module.h>
@@ -13,38 +13,38 @@
 
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
@@ -80,53 +80,53 @@ static const struct clk_ops sifive_fu740_prci_pcie_aux_clk_ops = {
 
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

