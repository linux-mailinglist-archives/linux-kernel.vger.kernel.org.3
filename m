Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477FD4CD1F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiCDKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbiCDKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:04:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C811A8C88
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:03:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso1185882pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCP8eXeYalFQxUcrQ3/FrtqjgCxxVlX7LiIMyPjqTF0=;
        b=Jc9dBCZDORJggSrN0RW/uspvjH8cNMrEjjjMXBqJ0PbYQYKDFVYRoLEoKWRPDKca68
         CnSI05Xb4QAtvlJ64A1oKAf1SWuZ8hQh0QpaTUn8Y2JXNZ+Tbiol4efbtevDifinpoSP
         5EwNdSEKUbshLSGgDfSug5CpkBAU/7p4HSuKhKPWOAX1A+tfIRWSapYrF+LuvJOp2q1+
         x72bFqjPBR6KPnyFHgANDhyZNBL4MB2uP89QaFicpD4qFGVyFT41XqKMBarGo0ez8SVK
         mkr2IP3BcWCuNhd0oYzK4nI6AIWe4Plo5ezApX/XSlg7x79b4ghVwwlLsSIiiNvTDB6N
         06dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCP8eXeYalFQxUcrQ3/FrtqjgCxxVlX7LiIMyPjqTF0=;
        b=Zjun3In6Qu4dJBR0n3vLuzChu/6UF/SdoA6D2KDS5oz3nADQAQa2yQ3atsTNM7IfTe
         QtOXTpcBL3OTZ85OQaGcopH6qhtEMJBXWwtkMsjRmOGkZcwU5/VBD/AxR4UNl1MKBjbp
         Pk0UV1W6hmcLe48TEWuWtFhC14q48NUx2XRSTB5e0BuKAgDcsiy6ZeA8DtAhRM1B6BnW
         djOMcjXtaZCh9PZZ35dGLydKMeJqM3S9qAKDUOAyszzCvKcWDtCPXhS38YrdmhMdEkaa
         zzFgZ0RRX+pnC9+fj1+ZPIs2ZKfy1PBUEwU31csdep1Rxnej6tAtNYwS9JGIwh05Hp+z
         a3kw==
X-Gm-Message-State: AOAM5302y0/ZpVlVd+T14d860ONj5cXWyQeeWhVINPQfTdaqq0i3jPWH
        ITzt0yR0D0MxOZjffmkDvqMHlA==
X-Google-Smtp-Source: ABdhPJzNRnA1Be/6ZJ5+vZ0VOTKPtHvfX/WC7Z9HwH3W82FFt4erqoky0CLVSrSUxr5M1THWCjlOCw==
X-Received: by 2002:a17:902:f54c:b0:14f:c36f:804 with SMTP id h12-20020a170902f54c00b0014fc36f0804mr40863288plf.119.1646388220795;
        Fri, 04 Mar 2022 02:03:40 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00174800b004f26d3f5b03sm5461605pfc.39.2022.03.04.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:03:40 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v2 5/5] clk: sifive: Move all stuff into SoCs header files from C files
Date:   Fri,  4 Mar 2022 18:03:21 +0800
Message-Id: <a3c7ec5c46c1d8be455d1c347db4855bb56cec53.1646388139.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/clk/sifive/Makefile      |   2 +-
 drivers/clk/sifive/fu540-prci.c  |  88 --------------------
 drivers/clk/sifive/fu540-prci.h  |  91 ++++++++++++++++++++-
 drivers/clk/sifive/fu740-prci.c  | 133 -------------------------------
 drivers/clk/sifive/fu740-prci.h  | 130 +++++++++++++++++++++++++++++-
 drivers/clk/sifive/sifive-prci.c |   5 --
 6 files changed, 214 insertions(+), 235 deletions(-)
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
index 672c782ad604..000000000000
--- a/drivers/clk/sifive/fu540-prci.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2018-2022 SiFive, Inc.
- * Copyright (C) 2018-2019 Wesley Terpstra
- * Copyright (C) 2018-2019 Paul Walmsley
- * Copyright (C) 2020-2022 Zong Li
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
index f27d1a42d946..000000000000
--- a/drivers/clk/sifive/fu740-prci.c
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2022 SiFive, Inc.
- * Copyright (C) 2020-2022 Zong Li
- */
-
-#include <linux/module.h>
-
-#include <dt-bindings/clock/sifive-fu740-prci.h>
-
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

