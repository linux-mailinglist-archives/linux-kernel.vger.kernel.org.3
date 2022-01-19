Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86482493753
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353188AbiASJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353116AbiASJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:28:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:28:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w204so2011924pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=180cyjRz+Y9+rOwCZ/fWUBjCQvnVUVC7b1b1X/dONts=;
        b=iPbsP82FmRznLy4gTSjHzhizg0qfrWchL2wpnC4bQt/DdyOE73RIyLkDshoXu8HxvI
         z6CpIv3IciEE1kNGHRWNclBsMm37UGGg7AK6NIC71XEKuaM+DdejU0saS951ByUvkCcA
         /WbhPI/t9q5AaIOU2SvNL7j8RUXQEJ10H2x8IUSlxNiQr2KTwkJZDHWAUk16yqprxf2X
         uY1z2zxWrEzx9PT04KGLSIrFG/ezC6poG0j2TjOil1kwHiFvHRLsSvMEs9XBzvX2JOar
         4Mq0bFG3G6inDkPTUhM/CYtnrbbLgf0HmY6cDEp9qdolMzAi+AqrVlG3z4n3vcFrop6o
         wavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=180cyjRz+Y9+rOwCZ/fWUBjCQvnVUVC7b1b1X/dONts=;
        b=zJxLnBa0pL/w9AJBBximJNcYPMgOoOnDxdhIS97qAnoKzt2KETL1cp7x+KU5Nmnmkz
         GjKfnUdNRIMESxBdVYdLZ9C4JjbgTG6v8dP4k6gimiq0YkscbavBI9RvNfVHLzZHmAhO
         UQNCf7jGdFSUaT+4DJfC27aFQj1tvon3uSLdFvy8BuGan01iLj+P6KuedyoEHQcbEKDy
         tHkbcP3VRopoE2Vu5YsVKCqVHhMWJS4z+GxMqbze75aKl4b1AMpI/CGlc2ztjl2EDY/d
         +OShwX2rKaXvuvTyyfQazQTQUcgUlWBC+ImeMFVZi6onwwoKy8cq2UtbuTAEj9o2liqc
         tg0A==
X-Gm-Message-State: AOAM531Yl0oPlh9qoSKKpsbCuUAIGNXvA5LpDZ6M3vzueXyn5YZ6tiKE
        FEj7HA6uBk/uB6wcM550qpQLaA==
X-Google-Smtp-Source: ABdhPJyBFMPVyaih6xzsH/uRKzZ3LYs5/ZwJEyECUWh4k3pJOZxT4zrHCoOs7R1HZJQzH1LdGPcabw==
X-Received: by 2002:a63:eb07:: with SMTP id t7mr26798287pgh.112.1642584537296;
        Wed, 19 Jan 2022 01:28:57 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y8sm1415894pfl.207.2022.01.19.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:28:56 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 4/4] clk: sifive: Move all stuff into SoCs header files from C files
Date:   Wed, 19 Jan 2022 17:28:41 +0800
Message-Id: <70c9317814b06c7ce37688b158178b188d3fd604.1642582832.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642582832.git.zong.li@sifive.com>
References: <cover.1642582832.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve PRCI driver to reduce the complexity, we remove the SoCs C files
by putting all stuff in each SoCs header files, and include these
SoCs-specific header files in core of PRCI. It can also avoid the W=1
kernel build warnings about variable defined but not used
[-Wunused-const-variable=], like commit 487dc7bb6a0c ("clk: sifive:
fu540-prci: Declare static const variable 'prci_clk_fu540' where it's
used") does.

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/sifive/Makefile      |   2 +-
 drivers/clk/sifive/fu540-prci.c  |  89 --------------------
 drivers/clk/sifive/fu540-prci.h  |  91 ++++++++++++++++++++-
 drivers/clk/sifive/fu740-prci.c  | 134 -------------------------------
 drivers/clk/sifive/fu740-prci.h  | 130 +++++++++++++++++++++++++++++-
 drivers/clk/sifive/sifive-prci.c |   5 --
 6 files changed, 214 insertions(+), 237 deletions(-)
 delete mode 100644 drivers/clk/sifive/fu540-prci.c
 delete mode 100644 drivers/clk/sifive/fu740-prci.c

diff --git a/drivers/clk/sifive/Makefile b/drivers/clk/sifive/Makefile
index 7b06fc04e6b3..efdf01f1c8d5 100644
--- a/drivers/clk/sifive/Makefile
+++ b/drivers/clk/sifive/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= sifive-prci.o fu540-prci.o fu740-prci.o
+obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= sifive-prci.o
diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
deleted file mode 100644
index d686f5cf3f71..000000000000
--- a/drivers/clk/sifive/fu540-prci.c
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2018-2021 SiFive, Inc.
- * Copyright (C) 2018-2019 Wesley Terpstra
- * Copyright (C) 2018-2019 Paul Walmsley
- * Copyright (C) 2020-2021 Zong Li
- *
- * The FU540 PRCI implements clock and reset control for the SiFive
- * FU540-C000 chip.  This driver assumes that it has sole control
- * over all PRCI resources.
- *
- * This driver is based on the PRCI driver written by Wesley Terpstra:
- * https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d221b2ee56bb60
- *
- * References:
- * - SiFive FU540-C000 manual v1p0, Chapter 7 "Clocking and Reset"
- */
-
-#include <linux/module.h>
-
-#include <dt-bindings/clock/sifive-fu540-prci.h>
-
-#include "fu540-prci.h"
-#include "sifive-prci.h"
-
-/* PRCI integration data for each WRPLL instance */
-
-static struct __prci_wrpll_data sifive_fu540_prci_corepll_data = {
-	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
-	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
-	.disable_bypass = sifive_prci_coreclksel_use_corepll,
-};
-
-static struct __prci_wrpll_data sifive_fu540_prci_ddrpll_data = {
-	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
-};
-
-static struct __prci_wrpll_data sifive_fu540_prci_gemgxlpll_data = {
-	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
-};
-
-/* Linux clock framework integration */
-
-static const struct clk_ops sifive_fu540_prci_wrpll_clk_ops = {
-	.set_rate = sifive_prci_wrpll_set_rate,
-	.round_rate = sifive_prci_wrpll_round_rate,
-	.recalc_rate = sifive_prci_wrpll_recalc_rate,
-	.enable = sifive_prci_clock_enable,
-	.disable = sifive_prci_clock_disable,
-	.is_enabled = sifive_clk_is_enabled,
-};
-
-static const struct clk_ops sifive_fu540_prci_wrpll_ro_clk_ops = {
-	.recalc_rate = sifive_prci_wrpll_recalc_rate,
-};
-
-static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops = {
-	.recalc_rate = sifive_prci_tlclksel_recalc_rate,
-};
-
-/* List of clock controls provided by the PRCI */
-struct __prci_clock __prci_init_clocks_fu540[] = {
-	[FU540_PRCI_CLK_COREPLL] = {
-		.name = "corepll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu540_prci_wrpll_clk_ops,
-		.pwd = &sifive_fu540_prci_corepll_data,
-	},
-	[FU540_PRCI_CLK_DDRPLL] = {
-		.name = "ddrpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu540_prci_wrpll_ro_clk_ops,
-		.pwd = &sifive_fu540_prci_ddrpll_data,
-	},
-	[FU540_PRCI_CLK_GEMGXLPLL] = {
-		.name = "gemgxlpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu540_prci_wrpll_clk_ops,
-		.pwd = &sifive_fu540_prci_gemgxlpll_data,
-	},
-	[FU540_PRCI_CLK_TLCLK] = {
-		.name = "tlclk",
-		.parent_name = "corepll",
-		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
-	},
-};
diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
index c220677dc010..e0173324f3c5 100644
--- a/drivers/clk/sifive/fu540-prci.h
+++ b/drivers/clk/sifive/fu540-prci.h
@@ -1,16 +1,99 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2020 SiFive, Inc.
- * Zong Li
+ * Copyright (C) 2018-2021 SiFive, Inc.
+ * Copyright (C) 2018-2019 Wesley Terpstra
+ * Copyright (C) 2018-2019 Paul Walmsley
+ * Copyright (C) 2020-2021 Zong Li
+ *
+ * The FU540 PRCI implements clock and reset control for the SiFive
+ * FU540-C000 chip.  This driver assumes that it has sole control
+ * over all PRCI resources.
+ *
+ * This driver is based on the PRCI driver written by Wesley Terpstra:
+ * https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d221b2ee56bb60
+ *
+ * References:
+ * - SiFive FU540-C000 manual v1p0, Chapter 7 "Clocking and Reset"
  */
 
 #ifndef __SIFIVE_CLK_FU540_PRCI_H
 #define __SIFIVE_CLK_FU540_PRCI_H
 
+
+#include <linux/module.h>
+
+#include <dt-bindings/clock/sifive-fu540-prci.h>
+
 #include "sifive-prci.h"
 
-#define NUM_CLOCK_FU540	4
+/* PRCI integration data for each WRPLL instance */
+
+static struct __prci_wrpll_data sifive_fu540_prci_corepll_data = {
+	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
+	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
+	.disable_bypass = sifive_prci_coreclksel_use_corepll,
+};
+
+static struct __prci_wrpll_data sifive_fu540_prci_ddrpll_data = {
+	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
+};
+
+static struct __prci_wrpll_data sifive_fu540_prci_gemgxlpll_data = {
+	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
+};
+
+/* Linux clock framework integration */
+
+static const struct clk_ops sifive_fu540_prci_wrpll_clk_ops = {
+	.set_rate = sifive_prci_wrpll_set_rate,
+	.round_rate = sifive_prci_wrpll_round_rate,
+	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+	.enable = sifive_prci_clock_enable,
+	.disable = sifive_prci_clock_disable,
+	.is_enabled = sifive_clk_is_enabled,
+};
+
+static const struct clk_ops sifive_fu540_prci_wrpll_ro_clk_ops = {
+	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops = {
+	.recalc_rate = sifive_prci_tlclksel_recalc_rate,
+};
+
+/* List of clock controls provided by the PRCI */
+static struct __prci_clock __prci_init_clocks_fu540[] = {
+	[FU540_PRCI_CLK_COREPLL] = {
+		.name = "corepll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu540_prci_wrpll_clk_ops,
+		.pwd = &sifive_fu540_prci_corepll_data,
+	},
+	[FU540_PRCI_CLK_DDRPLL] = {
+		.name = "ddrpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu540_prci_wrpll_ro_clk_ops,
+		.pwd = &sifive_fu540_prci_ddrpll_data,
+	},
+	[FU540_PRCI_CLK_GEMGXLPLL] = {
+		.name = "gemgxlpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu540_prci_wrpll_clk_ops,
+		.pwd = &sifive_fu540_prci_gemgxlpll_data,
+	},
+	[FU540_PRCI_CLK_TLCLK] = {
+		.name = "tlclk",
+		.parent_name = "corepll",
+		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
+	},
+};
 
-extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
+static const struct prci_clk_desc prci_clk_fu540 = {
+	.clks = __prci_init_clocks_fu540,
+	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
+};
 
 #endif /* __SIFIVE_CLK_FU540_PRCI_H */
diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
deleted file mode 100644
index bd66559fe2f8..000000000000
--- a/drivers/clk/sifive/fu740-prci.c
+++ /dev/null
@@ -1,134 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2021 SiFive, Inc.
- * Copyright (C) 2020-2021 Zong Li
- */
-
-#include <linux/module.h>
-
-#include <dt-bindings/clock/sifive-fu740-prci.h>
-
-#include "fu540-prci.h"
-#include "sifive-prci.h"
-
-/* PRCI integration data for each WRPLL instance */
-
-static struct __prci_wrpll_data sifive_fu740_prci_corepll_data = {
-	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
-	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
-	.disable_bypass = sifive_prci_coreclksel_use_final_corepll,
-};
-
-static struct __prci_wrpll_data sifive_fu740_prci_ddrpll_data = {
-	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
-};
-
-static struct __prci_wrpll_data sifive_fu740_prci_gemgxlpll_data = {
-	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
-};
-
-static struct __prci_wrpll_data sifive_fu740_prci_dvfscorepll_data = {
-	.cfg0_offs = PRCI_DVFSCOREPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_DVFSCOREPLLCFG1_OFFSET,
-	.enable_bypass = sifive_prci_corepllsel_use_corepll,
-	.disable_bypass = sifive_prci_corepllsel_use_dvfscorepll,
-};
-
-static struct __prci_wrpll_data sifive_fu740_prci_hfpclkpll_data = {
-	.cfg0_offs = PRCI_HFPCLKPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_HFPCLKPLLCFG1_OFFSET,
-	.enable_bypass = sifive_prci_hfpclkpllsel_use_hfclk,
-	.disable_bypass = sifive_prci_hfpclkpllsel_use_hfpclkpll,
-};
-
-static struct __prci_wrpll_data sifive_fu740_prci_cltxpll_data = {
-	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
-	.cfg1_offs = PRCI_CLTXPLLCFG1_OFFSET,
-};
-
-/* Linux clock framework integration */
-
-static const struct clk_ops sifive_fu740_prci_wrpll_clk_ops = {
-	.set_rate = sifive_prci_wrpll_set_rate,
-	.round_rate = sifive_prci_wrpll_round_rate,
-	.recalc_rate = sifive_prci_wrpll_recalc_rate,
-	.enable = sifive_prci_clock_enable,
-	.disable = sifive_prci_clock_disable,
-	.is_enabled = sifive_clk_is_enabled,
-};
-
-static const struct clk_ops sifive_fu740_prci_wrpll_ro_clk_ops = {
-	.recalc_rate = sifive_prci_wrpll_recalc_rate,
-};
-
-static const struct clk_ops sifive_fu740_prci_tlclksel_clk_ops = {
-	.recalc_rate = sifive_prci_tlclksel_recalc_rate,
-};
-
-static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
-	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
-};
-
-static const struct clk_ops sifive_fu740_prci_pcie_aux_clk_ops = {
-	.enable = sifive_prci_pcie_aux_clock_enable,
-	.disable = sifive_prci_pcie_aux_clock_disable,
-	.is_enabled = sifive_prci_pcie_aux_clock_is_enabled,
-};
-
-/* List of clock controls provided by the PRCI */
-struct __prci_clock __prci_init_clocks_fu740[] = {
-	[FU740_PRCI_CLK_COREPLL] = {
-		.name = "corepll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &sifive_fu740_prci_corepll_data,
-	},
-	[FU740_PRCI_CLK_DDRPLL] = {
-		.name = "ddrpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_ro_clk_ops,
-		.pwd = &sifive_fu740_prci_ddrpll_data,
-	},
-	[FU740_PRCI_CLK_GEMGXLPLL] = {
-		.name = "gemgxlpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &sifive_fu740_prci_gemgxlpll_data,
-	},
-	[FU740_PRCI_CLK_DVFSCOREPLL] = {
-		.name = "dvfscorepll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &sifive_fu740_prci_dvfscorepll_data,
-	},
-	[FU740_PRCI_CLK_HFPCLKPLL] = {
-		.name = "hfpclkpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &sifive_fu740_prci_hfpclkpll_data,
-	},
-	[FU740_PRCI_CLK_CLTXPLL] = {
-		.name = "cltxpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &sifive_fu740_prci_cltxpll_data,
-	},
-	[FU740_PRCI_CLK_TLCLK] = {
-		.name = "tlclk",
-		.parent_name = "corepll",
-		.ops = &sifive_fu740_prci_tlclksel_clk_ops,
-	},
-	[FU740_PRCI_CLK_PCLK] = {
-		.name = "pclk",
-		.parent_name = "hfpclkpll",
-		.ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
-	},
-	[FU740_PRCI_CLK_PCIE_AUX] = {
-		.name = "pcie_aux",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_pcie_aux_clk_ops,
-	},
-};
diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
index 511a0bf7ba2b..f31cd30fc395 100644
--- a/drivers/clk/sifive/fu740-prci.h
+++ b/drivers/clk/sifive/fu740-prci.h
@@ -1,17 +1,139 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2020 SiFive, Inc.
- * Zong Li
+ * Copyright (C) 2020-2021 SiFive, Inc.
+ * Copyright (C) 2020-2021 Zong Li
  */
 
 #ifndef __SIFIVE_CLK_FU740_PRCI_H
 #define __SIFIVE_CLK_FU740_PRCI_H
 
+#include <linux/module.h>
+
+#include <dt-bindings/clock/sifive-fu740-prci.h>
+
 #include "sifive-prci.h"
 
-#define NUM_CLOCK_FU740	9
+/* PRCI integration data for each WRPLL instance */
+
+static struct __prci_wrpll_data sifive_fu740_prci_corepll_data = {
+	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
+	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
+	.disable_bypass = sifive_prci_coreclksel_use_final_corepll,
+};
+
+static struct __prci_wrpll_data sifive_fu740_prci_ddrpll_data = {
+	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
+};
+
+static struct __prci_wrpll_data sifive_fu740_prci_gemgxlpll_data = {
+	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
+};
+
+static struct __prci_wrpll_data sifive_fu740_prci_dvfscorepll_data = {
+	.cfg0_offs = PRCI_DVFSCOREPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_DVFSCOREPLLCFG1_OFFSET,
+	.enable_bypass = sifive_prci_corepllsel_use_corepll,
+	.disable_bypass = sifive_prci_corepllsel_use_dvfscorepll,
+};
+
+static struct __prci_wrpll_data sifive_fu740_prci_hfpclkpll_data = {
+	.cfg0_offs = PRCI_HFPCLKPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_HFPCLKPLLCFG1_OFFSET,
+	.enable_bypass = sifive_prci_hfpclkpllsel_use_hfclk,
+	.disable_bypass = sifive_prci_hfpclkpllsel_use_hfpclkpll,
+};
+
+static struct __prci_wrpll_data sifive_fu740_prci_cltxpll_data = {
+	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_CLTXPLLCFG1_OFFSET,
+};
+
+/* Linux clock framework integration */
+
+static const struct clk_ops sifive_fu740_prci_wrpll_clk_ops = {
+	.set_rate = sifive_prci_wrpll_set_rate,
+	.round_rate = sifive_prci_wrpll_round_rate,
+	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+	.enable = sifive_prci_clock_enable,
+	.disable = sifive_prci_clock_disable,
+	.is_enabled = sifive_clk_is_enabled,
+};
 
-extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
+static const struct clk_ops sifive_fu740_prci_wrpll_ro_clk_ops = {
+	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu740_prci_tlclksel_clk_ops = {
+	.recalc_rate = sifive_prci_tlclksel_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
+	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu740_prci_pcie_aux_clk_ops = {
+	.enable = sifive_prci_pcie_aux_clock_enable,
+	.disable = sifive_prci_pcie_aux_clock_disable,
+	.is_enabled = sifive_prci_pcie_aux_clock_is_enabled,
+};
+
+/* List of clock controls provided by the PRCI */
+static struct __prci_clock __prci_init_clocks_fu740[] = {
+	[FU740_PRCI_CLK_COREPLL] = {
+		.name = "corepll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &sifive_fu740_prci_corepll_data,
+	},
+	[FU740_PRCI_CLK_DDRPLL] = {
+		.name = "ddrpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_ro_clk_ops,
+		.pwd = &sifive_fu740_prci_ddrpll_data,
+	},
+	[FU740_PRCI_CLK_GEMGXLPLL] = {
+		.name = "gemgxlpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &sifive_fu740_prci_gemgxlpll_data,
+	},
+	[FU740_PRCI_CLK_DVFSCOREPLL] = {
+		.name = "dvfscorepll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &sifive_fu740_prci_dvfscorepll_data,
+	},
+	[FU740_PRCI_CLK_HFPCLKPLL] = {
+		.name = "hfpclkpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &sifive_fu740_prci_hfpclkpll_data,
+	},
+	[FU740_PRCI_CLK_CLTXPLL] = {
+		.name = "cltxpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &sifive_fu740_prci_cltxpll_data,
+	},
+	[FU740_PRCI_CLK_TLCLK] = {
+		.name = "tlclk",
+		.parent_name = "corepll",
+		.ops = &sifive_fu740_prci_tlclksel_clk_ops,
+	},
+	[FU740_PRCI_CLK_PCLK] = {
+		.name = "pclk",
+		.parent_name = "hfpclkpll",
+		.ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
+	},
+	[FU740_PRCI_CLK_PCIE_AUX] = {
+		.name = "pcie_aux",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_pcie_aux_clk_ops,
+	},
+};
 
 static const struct prci_clk_desc prci_clk_fu740 = {
 	.clks = __prci_init_clocks_fu740,
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 80a288c59e56..916d2fc28b9c 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -12,11 +12,6 @@
 #include "fu540-prci.h"
 #include "fu740-prci.h"
 
-static const struct prci_clk_desc prci_clk_fu540 = {
-	.clks = __prci_init_clocks_fu540,
-	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
-};
-
 /*
  * Private functions
  */
-- 
2.31.1

