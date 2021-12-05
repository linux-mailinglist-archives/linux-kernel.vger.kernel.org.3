Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08429468BE1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhLEPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhLEPiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:38:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8817CC061714;
        Sun,  5 Dec 2021 07:34:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l25so32655655eda.11;
        Sun, 05 Dec 2021 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hNwLtr0M037Sc95+A42/EguVlJcbKDerRZrdXqTDvs=;
        b=Dc6XsrUpB9JobxPbrNg+UPsUG4hql3eCPna+GiSfyh7H3IMDj64x8oN9ZMa+Mwzwon
         lkzxg1NyOPYgAJAz9EfWFDnfHWn3nv2LRGQkG/uSZiWw9ME8b1WFQIGrQ0+FJHg+OQgY
         XY9l/Ap6/aPtJjhlWQqNrVJrR4cd3xqx5IfFBNF2w5vhyLI5gtmxXmEE9uY+pRikW/eM
         iya+0afAWNd3ZxFweQb5apv/fTA2gAJ27AGfUYXdPoBUfT59XVhpNyleFVK3p8sHqU39
         i1KmNMhj3f4A6eywtfG7rnuJYy2lUhz0dG14VBhIxQyAieMg/hUDMnuwsjdm9hsiJAfO
         /pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hNwLtr0M037Sc95+A42/EguVlJcbKDerRZrdXqTDvs=;
        b=k5bnQAGgztlLrM4clDn8kglrPILGhsFpO0jwjBgF2JmLU4zVtBpSn+0U4oZJQw9sr3
         re3RVnWP0VLHOU+z/+Qoy9K9AEwxU9sx+c+Zuv5X8yrkyXIEr5px9y9K7FJZ0qHFAd2X
         DALAQRQtpRvXu39To6bf83mqrc2wEvvydyb/elX/6EbA+mltJmNazjzRyKJCba9jJPrx
         jJiA7b0/dvXdtcqH5N5VLKBItXFaRF652PkTwj7Vdr/mVVJ2DIOMgFJifV7ca4KjK7mn
         WPYzx7Y85E+Opc1YhzzGvkkZcMGY9TpMkmHBKsJ8U+s2KhzWPhb9ftE1BxF+3iNlKcC6
         yhsA==
X-Gm-Message-State: AOAM531O4dvu25+g+z6311Pk7QB6c4EBYshKK5H4JAnzTlYfNvY/Oick
        uUWyPHWLLrgDdYCm9AUKgPI=
X-Google-Smtp-Source: ABdhPJy8YjbO/XsJk4NW2I9skHwKa+Kd6lu61g1KNRTMr/bLo+PewwaSQvT8cQUQkOlzc7C6R5Ew7w==
X-Received: by 2002:a17:907:a0d4:: with SMTP id hw20mr39450666ejc.16.1638718493940;
        Sun, 05 Dec 2021 07:34:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id sa17sm5529941ejc.123.2021.12.05.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:34:53 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 4/6] clk: samsung: Add initial Exynos7885 clock driver
Date:   Sun,  5 Dec 2021 16:32:58 +0100
Message-Id: <20211205153302.76418-5-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205153302.76418-1-virag.david003@gmail.com>
References: <20211205153302.76418-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an initial implementation adding basic clocks, such as UART,
USI, I2C, WDT, ect. and their parent clocks. It is heavily based on the
Exynos850 clock driver at 'drivers/clk/samsung/clk-exynos850.c' which
was made by Sam Protsenko, thus the copyright and author lines were
kept.

Bus clocks are enabled by default as well to avoid hangs while trying to
access CMU registers.

Only the parts of CMU_TOP needed for CMU_CORE and CMU_PERI, a bit of
CMU_CORE, and most of CMU_PERI is implemented as of now.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/clk/samsung/Makefile         |   1 +
 drivers/clk/samsung/clk-exynos7885.c | 680 +++++++++++++++++++++++++++
 2 files changed, 681 insertions(+)
 create mode 100644 drivers/clk/samsung/clk-exynos7885.c

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index c46cf11e4d0b..149258b232a9 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) += clk-exynos-audss.o
 obj-$(CONFIG_EXYNOS_CLKOUT)	+= clk-exynos-clkout.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
+obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7885.o
 obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
 obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
 obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
new file mode 100644
index 000000000000..088f36e64609
--- /dev/null
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -0,0 +1,680 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Linaro Ltd.
+ * Copyright (C) 2021 Dávid Virág <virag.david003@gmail.com>
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ * Author: Dávid Virág <virag.david003@gmail.com>
+ *
+ * Common Clock Framework support for Exynos7885 SoC.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/exynos7885.h>
+
+#include "clk.h"
+
+/* Gate register bits */
+#define GATE_MANUAL		BIT(20)
+#define GATE_ENABLE_HWACG	BIT(28)
+
+/* Gate register offsets range */
+#define GATE_OFF_START		0x2000
+#define GATE_OFF_END		0x2fff
+
+/**
+ * exynos7885_init_clocks - Set clocks initial configuration
+ * @np:			CMU device tree node with "reg" property (CMU addr)
+ * @reg_offs:		Register offsets array for clocks to init
+ * @reg_offs_len:	Number of register offsets in reg_offs array
+ *
+ * Set manual control mode for all gate clocks.
+ */
+static void __init exynos7885_init_clocks(struct device_node *np,
+		const unsigned long *reg_offs, size_t reg_offs_len)
+{
+	void __iomem *reg_base;
+	size_t i;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: failed to map registers\n", __func__);
+
+	for (i = 0; i < reg_offs_len; ++i) {
+		void __iomem *reg = reg_base + reg_offs[i];
+		u32 val;
+
+		/* Modify only gate clock registers */
+		if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OFF_END)
+			continue;
+
+		val = readl(reg);
+		val |= GATE_MANUAL;
+		val &= ~GATE_ENABLE_HWACG;
+		writel(val, reg);
+	}
+
+	iounmap(reg_base);
+}
+
+/**
+ * exynos7885_register_cmu - Register specified Exynos7885 CMU domain
+ * @dev:	Device object; may be NULL if this function is not being
+ *		called from platform driver probe function
+ * @np:		CMU device tree node
+ * @cmu:	CMU data
+ *
+ * Register specified CMU domain, which includes next steps:
+ *
+ * 1. Enable parent clock of @cmu CMU
+ * 2. Set initial registers configuration for @cmu CMU clocks
+ * 3. Register @cmu CMU clocks using Samsung clock framework API
+ */
+static void __init exynos7885_register_cmu(struct device *dev,
+		struct device_node *np, const struct samsung_cmu_info *cmu)
+{
+	/* Keep CMU parent clock running (needed for CMU registers access) */
+	if (cmu->clk_name) {
+		struct clk *parent_clk;
+
+		if (dev)
+			parent_clk = clk_get(dev, cmu->clk_name);
+		else
+			parent_clk = of_clk_get_by_name(np, cmu->clk_name);
+
+		if (IS_ERR(parent_clk)) {
+			pr_err("%s: could not find bus clock %s; err = %ld\n",
+			       __func__, cmu->clk_name, PTR_ERR(parent_clk));
+		} else {
+			clk_prepare_enable(parent_clk);
+		}
+	}
+
+	exynos7885_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
+	samsung_cmu_register_one(np, cmu);
+}
+
+/* ---- CMU_TOP ------------------------------------------------------------- */
+
+/* Register Offset definitions for CMU_TOP (0x12060000) */
+#define PLL_LOCKTIME_PLL_SHARED0		0x0000
+#define PLL_LOCKTIME_PLL_SHARED1		0x0004
+#define PLL_CON0_PLL_SHARED0			0x0100
+#define PLL_CON0_PLL_SHARED1			0x0120
+#define CLK_CON_MUX_MUX_CLKCMU_CORE_BUS		0x1014
+#define CLK_CON_MUX_MUX_CLKCMU_CORE_CCI		0x1018
+#define CLK_CON_MUX_MUX_CLKCMU_CORE_G3D		0x101c
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_BUS		0x1058
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0	0x105c
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1	0x1060
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART0	0x1064
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART1	0x1068
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_UART2	0x106c
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI0	0x1070
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI1	0x1074
+#define CLK_CON_MUX_MUX_CLKCMU_PERI_USI2	0x1078
+#define CLK_CON_DIV_CLKCMU_CORE_BUS		0x181c
+#define CLK_CON_DIV_CLKCMU_CORE_CCI		0x1820
+#define CLK_CON_DIV_CLKCMU_CORE_G3D		0x1824
+#define CLK_CON_DIV_CLKCMU_PERI_BUS		0x1874
+#define CLK_CON_DIV_CLKCMU_PERI_SPI0		0x1878
+#define CLK_CON_DIV_CLKCMU_PERI_SPI1		0x187c
+#define CLK_CON_DIV_CLKCMU_PERI_UART0		0x1880
+#define CLK_CON_DIV_CLKCMU_PERI_UART1		0x1884
+#define CLK_CON_DIV_CLKCMU_PERI_UART2		0x1888
+#define CLK_CON_DIV_CLKCMU_PERI_USI0		0x188c
+#define CLK_CON_DIV_CLKCMU_PERI_USI1		0x1890
+#define CLK_CON_DIV_CLKCMU_PERI_USI2		0x1894
+#define CLK_CON_DIV_PLL_SHARED0_DIV2		0x189c
+#define CLK_CON_DIV_PLL_SHARED0_DIV3		0x18a0
+#define CLK_CON_DIV_PLL_SHARED0_DIV4		0x18a4
+#define CLK_CON_DIV_PLL_SHARED0_DIV5		0x18a8
+#define CLK_CON_DIV_PLL_SHARED1_DIV2		0x18ac
+#define CLK_CON_DIV_PLL_SHARED1_DIV3		0x18b0
+#define CLK_CON_DIV_PLL_SHARED1_DIV4		0x18b4
+#define CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1	0x2004
+#define CLK_CON_GAT_GATE_CLKCMU_CORE_BUS	0x201c
+#define CLK_CON_GAT_GATE_CLKCMU_CORE_CCI	0x2020
+#define CLK_CON_GAT_GATE_CLKCMU_CORE_G3D	0x2024
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_BUS	0x207c
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0	0x2080
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1	0x2084
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_UART0	0x2088
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_UART2	0x208c
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI0	0x2090
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI1	0x2094
+#define CLK_CON_GAT_GATE_CLKCMU_PERI_USI2	0x2098
+
+static const unsigned long top_clk_regs[] __initconst = {
+	PLL_LOCKTIME_PLL_SHARED0,
+	PLL_LOCKTIME_PLL_SHARED1,
+	PLL_CON0_PLL_SHARED0,
+	PLL_CON0_PLL_SHARED1,
+	CLK_CON_MUX_MUX_CLKCMU_CORE_BUS,
+	CLK_CON_MUX_MUX_CLKCMU_CORE_CCI,
+	CLK_CON_MUX_MUX_CLKCMU_CORE_G3D,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_BUS,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_UART0,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_UART1,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_UART2,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_USI0,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_USI1,
+	CLK_CON_MUX_MUX_CLKCMU_PERI_USI2,
+	CLK_CON_DIV_CLKCMU_CORE_BUS,
+	CLK_CON_DIV_CLKCMU_CORE_CCI,
+	CLK_CON_DIV_CLKCMU_CORE_G3D,
+	CLK_CON_DIV_CLKCMU_PERI_BUS,
+	CLK_CON_DIV_CLKCMU_PERI_SPI0,
+	CLK_CON_DIV_CLKCMU_PERI_SPI1,
+	CLK_CON_DIV_CLKCMU_PERI_UART0,
+	CLK_CON_DIV_CLKCMU_PERI_UART1,
+	CLK_CON_DIV_CLKCMU_PERI_UART2,
+	CLK_CON_DIV_CLKCMU_PERI_USI0,
+	CLK_CON_DIV_CLKCMU_PERI_USI1,
+	CLK_CON_DIV_CLKCMU_PERI_USI2,
+	CLK_CON_DIV_PLL_SHARED0_DIV2,
+	CLK_CON_DIV_PLL_SHARED0_DIV3,
+	CLK_CON_DIV_PLL_SHARED0_DIV4,
+	CLK_CON_DIV_PLL_SHARED0_DIV5,
+	CLK_CON_DIV_PLL_SHARED1_DIV2,
+	CLK_CON_DIV_PLL_SHARED1_DIV3,
+	CLK_CON_DIV_PLL_SHARED1_DIV4,
+	CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1,
+	CLK_CON_GAT_GATE_CLKCMU_CORE_BUS,
+	CLK_CON_GAT_GATE_CLKCMU_CORE_CCI,
+	CLK_CON_GAT_GATE_CLKCMU_CORE_G3D,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_BUS,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_UART0,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_UART2,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_USI0,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_USI1,
+	CLK_CON_GAT_GATE_CLKCMU_PERI_USI2,
+};
+
+static const struct samsung_pll_clock top_pll_clks[] __initconst = {
+	PLL(pll_1417x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
+	    PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
+	    NULL),
+	PLL(pll_1417x, CLK_FOUT_SHARED1_PLL, "fout_shared1_pll", "oscclk",
+	    PLL_LOCKTIME_PLL_SHARED1, PLL_CON0_PLL_SHARED1,
+	    NULL),
+};
+
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_CORE */
+PNAME(mout_core_bus_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared0_div3" };
+PNAME(mout_core_cci_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared0_div3" };
+PNAME(mout_core_g3d_p)		= { "dout_shared0_div2", "dout_shared1_div2",
+				    "dout_shared0_div3", "dout_shared0_div3" };
+
+/* List of parent clocks for Muxes in CMU_TOP: for CMU_PERI */
+PNAME(mout_peri_bus_p)		= { "dout_shared0_div4", "dout_shared1_div4" };
+PNAME(mout_peri_spi0_p)		= { "oscclk", "dout_shared0_div4" };
+PNAME(mout_peri_spi1_p)		= { "oscclk", "dout_shared0_div4" };
+PNAME(mout_peri_uart0_p)	= { "oscclk", "dout_shared0_div4" };
+PNAME(mout_peri_uart1_p)	= { "oscclk", "dout_shared0_div4" };
+PNAME(mout_peri_uart2_p)	= { "oscclk", "dout_shared0_div4" };
+PNAME(mout_peri_usi0_p)		= { "oscclk", "dout_shared0_div4" };
+PNAME(mout_peri_usi1_p)		= { "oscclk", "dout_shared0_div4" };
+PNAME(mout_peri_usi2_p)		= { "oscclk", "dout_shared0_div4" };
+
+
+static const struct samsung_mux_clock top_mux_clks[] __initconst = {
+	/* CORE */
+	MUX(CLK_MOUT_CORE_BUS, "mout_core_bus", mout_core_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CORE_BUS, 0, 2),
+	MUX(CLK_MOUT_CORE_CCI, "mout_core_cci", mout_core_cci_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CORE_CCI, 0, 2),
+	MUX(CLK_MOUT_CORE_G3D, "mout_core_g3d", mout_core_g3d_p,
+	    CLK_CON_MUX_MUX_CLKCMU_CORE_G3D, 0, 2),
+
+	/* PERI */
+	MUX(CLK_MOUT_PERI_BUS, "mout_peri_bus", mout_peri_bus_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_BUS, 0, 1),
+	MUX(CLK_MOUT_PERI_SPI0, "mout_peri_spi0", mout_peri_spi0_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_SPI0, 0, 1),
+	MUX(CLK_MOUT_PERI_SPI1, "mout_peri_spi1", mout_peri_spi1_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_SPI1, 0, 1),
+	MUX(CLK_MOUT_PERI_UART0, "mout_peri_uart0", mout_peri_uart0_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_UART0, 0, 1),
+	MUX(CLK_MOUT_PERI_UART1, "mout_peri_uart1", mout_peri_uart1_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_UART1, 0, 1),
+	MUX(CLK_MOUT_PERI_UART2, "mout_peri_uart2", mout_peri_uart2_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_UART2, 0, 1),
+	MUX(CLK_MOUT_PERI_USI0, "mout_peri_usi0", mout_peri_usi0_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_USI0, 0, 1),
+	MUX(CLK_MOUT_PERI_USI1, "mout_peri_usi1", mout_peri_usi1_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_USI1, 0, 1),
+	MUX(CLK_MOUT_PERI_USI2, "mout_peri_usi2", mout_peri_usi2_p,
+	    CLK_CON_MUX_MUX_CLKCMU_PERI_USI2, 0, 1),
+};
+
+static const struct samsung_div_clock top_div_clks[] __initconst = {
+	/* TOP */
+	DIV(CLK_DOUT_SHARED0_DIV2, "dout_shared0_div2", "fout_shared0_pll",
+	    CLK_CON_DIV_PLL_SHARED0_DIV2, 0, 1),
+	DIV(CLK_DOUT_SHARED0_DIV3, "dout_shared0_div3", "fout_shared0_pll",
+	    CLK_CON_DIV_PLL_SHARED0_DIV3, 0, 2),
+	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "fout_shared0_pll",
+	    CLK_CON_DIV_PLL_SHARED0_DIV4, 0, 1),
+	DIV(CLK_DOUT_SHARED0_DIV5, "dout_shared0_div5", "fout_shared0_pll",
+	    CLK_CON_DIV_PLL_SHARED0_DIV5, 0, 3),
+	DIV(CLK_DOUT_SHARED1_DIV2, "dout_shared1_div2", "fout_shared1_pll",
+	    CLK_CON_DIV_PLL_SHARED1_DIV2, 0, 1),
+	DIV(CLK_DOUT_SHARED1_DIV3, "dout_shared1_div3", "fout_shared1_pll",
+	    CLK_CON_DIV_PLL_SHARED1_DIV3, 0, 2),
+	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "fout_shared1_pll",
+	    CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
+
+	/* CORE */
+	DIV(CLK_DOUT_CORE_BUS, "dout_core_bus", "gout_core_bus",
+	    CLK_CON_DIV_CLKCMU_CORE_BUS, 0, 3),
+	DIV(CLK_DOUT_CORE_CCI, "dout_core_cci", "gout_core_cci",
+	    CLK_CON_DIV_CLKCMU_CORE_CCI, 0, 3),
+	DIV(CLK_DOUT_CORE_G3D, "dout_core_g3d", "gout_core_g3d",
+	    CLK_CON_DIV_CLKCMU_CORE_G3D, 0, 3),
+
+	/* PERI */
+	DIV(CLK_DOUT_PERI_BUS, "dout_peri_bus", "gout_peri_bus",
+	    CLK_CON_DIV_CLKCMU_PERI_BUS, 0, 4),
+	DIV(CLK_DOUT_PERI_SPI0, "dout_peri_spi0", "gout_peri_spi0",
+	    CLK_CON_DIV_CLKCMU_PERI_SPI0, 0, 6),
+	DIV(CLK_DOUT_PERI_SPI1, "dout_peri_spi1", "gout_peri_spi1",
+	    CLK_CON_DIV_CLKCMU_PERI_SPI1, 0, 6),
+	DIV(CLK_DOUT_PERI_UART0, "dout_peri_uart0", "gout_peri_uart0",
+	    CLK_CON_DIV_CLKCMU_PERI_UART0, 0, 4),
+	DIV(CLK_DOUT_PERI_UART1, "dout_peri_uart1", "gout_peri_uart1",
+	    CLK_CON_DIV_CLKCMU_PERI_UART1, 0, 4),
+	DIV(CLK_DOUT_PERI_UART2, "dout_peri_uart2", "gout_peri_uart2",
+	    CLK_CON_DIV_CLKCMU_PERI_UART2, 0, 4),
+	DIV(CLK_DOUT_PERI_USI0, "dout_peri_usi0", "gout_peri_usi0",
+	    CLK_CON_DIV_CLKCMU_PERI_USI0, 0, 4),
+	DIV(CLK_DOUT_PERI_USI1, "dout_peri_usi1", "gout_peri_usi1",
+	    CLK_CON_DIV_CLKCMU_PERI_USI1, 0, 4),
+	DIV(CLK_DOUT_PERI_USI2, "dout_peri_usi2", "gout_peri_usi2",
+	    CLK_CON_DIV_CLKCMU_PERI_USI2, 0, 4),
+};
+
+static const struct samsung_gate_clock top_gate_clks[] __initconst = {
+	/* CORE */
+	GATE(CLK_GOUT_CORE_BUS, "gout_core_bus", "mout_core_bus",
+	     CLK_CON_GAT_GATE_CLKCMU_CORE_BUS, 21, 0, 0),
+	GATE(CLK_GOUT_CORE_CCI, "gout_core_cci", "mout_core_cci",
+	     CLK_CON_GAT_GATE_CLKCMU_CORE_CCI, 21, 0, 0),
+	GATE(CLK_GOUT_CORE_G3D, "gout_core_g3d", "mout_core_g3d",
+	     CLK_CON_GAT_GATE_CLKCMU_CORE_G3D, 21, 0, 0),
+
+	/* PERI */
+	GATE(CLK_GOUT_PERI_BUS, "gout_peri_bus", "mout_peri_bus",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_BUS, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_SPI0, "gout_peri_spi0", "mout_peri_spi0",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_SPI0, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_SPI1, "gout_peri_spi1", "mout_peri_spi1",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_SPI1, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_UART0, "gout_peri_uart0", "mout_peri_uart0",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_UART0, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_UART1, "gout_peri_uart1", "mout_peri_uart1",
+	     CLK_CON_GAT_GATE_CLKCMUC_PERI_UART1, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_UART2, "gout_peri_uart2", "mout_peri_uart2",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_UART2, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_USI0, "gout_peri_usi0", "mout_peri_usi0",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_USI0, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_USI1, "gout_peri_usi1", "mout_peri_usi1",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_USI1, 21, 0, 0),
+	GATE(CLK_GOUT_PERI_USI2, "gout_peri_usi2", "mout_peri_usi2",
+	     CLK_CON_GAT_GATE_CLKCMU_PERI_USI2, 21, 0, 0),
+};
+
+static const struct samsung_cmu_info top_cmu_info __initconst = {
+	.pll_clks		= top_pll_clks,
+	.nr_pll_clks		= ARRAY_SIZE(top_pll_clks),
+	.mux_clks		= top_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(top_mux_clks),
+	.div_clks		= top_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(top_div_clks),
+	.gate_clks		= top_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(top_gate_clks),
+	.nr_clk_ids		= TOP_NR_CLK,
+	.clk_regs		= top_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
+};
+
+static void __init exynos7885_cmu_top_init(struct device_node *np)
+{
+	exynos7885_register_cmu(NULL, np, &top_cmu_info);
+}
+
+/* Register CMU_TOP early, as it's a dependency for other early domains */
+CLK_OF_DECLARE(exynos7885_cmu_top, "samsung,exynos7885-cmu-top",
+	       exynos7885_cmu_top_init);
+
+/* ---- CMU_PERI ------------------------------------------------------------ */
+
+/* Register Offset definitions for CMU_PERI (0x10010000) */
+#define PLL_CON0_MUX_CLKCMU_PERI_BUS_USER	0x0100
+#define PLL_CON0_MUX_CLKCMU_PERI_SPI0_USER	0x0120
+#define PLL_CON0_MUX_CLKCMU_PERI_SPI1_USER	0x0140
+#define PLL_CON0_MUX_CLKCMU_PERI_UART0_USER	0x0160
+#define PLL_CON0_MUX_CLKCMU_PERI_UART1_USER	0x0180
+#define PLL_CON0_MUX_CLKCMU_PERI_UART2_USER	0x01a0
+#define PLL_CON0_MUX_CLKCMU_PERI_USI0_USER	0x01c0
+#define PLL_CON0_MUX_CLKCMU_PERI_USI1_USER	0x01e0
+#define PLL_CON0_MUX_CLKCMU_PERI_USI2_USER	0x0200
+#define CLK_CON_GAT_GOUT_PERI_GPIO_TOP_PCLK	0x2024
+#define CLK_CON_GAT_GOUT_PERI_HSI2C_0_PCLK	0x2028
+#define CLK_CON_GAT_GOUT_PERI_HSI2C_1_PCLK	0x202c
+#define CLK_CON_GAT_GOUT_PERI_HSI2C_2_PCLK	0x2030
+#define CLK_CON_GAT_GOUT_PERI_HSI2C_3_PCLK	0x2034
+#define CLK_CON_GAT_GOUT_PERI_I2C_0_PCLK	0x2038
+#define CLK_CON_GAT_GOUT_PERI_I2C_1_PCLK	0x203c
+#define CLK_CON_GAT_GOUT_PERI_I2C_2_PCLK	0x2040
+#define CLK_CON_GAT_GOUT_PERI_I2C_3_PCLK	0x2044
+#define CLK_CON_GAT_GOUT_PERI_I2C_4_PCLK	0x2048
+#define CLK_CON_GAT_GOUT_PERI_I2C_5_PCLK	0x204c
+#define CLK_CON_GAT_GOUT_PERI_I2C_6_PCLK	0x2050
+#define CLK_CON_GAT_GOUT_PERI_I2C_7_PCLK	0x2054
+#define CLK_CON_GAT_GOUT_PERI_PWM_MOTOR_PCLK	0x2058
+#define CLK_CON_GAT_GOUT_PERI_SPI_0_PCLK	0x205c
+#define CLK_CON_GAT_GOUT_PERI_SPI_0_EXT_CLK	0x2060
+#define CLK_CON_GAT_GOUT_PERI_SPI_1_PCLK	0x2064
+#define CLK_CON_GAT_GOUT_PERI_SPI_1_EXT_CLK	0x2068
+#define CLK_CON_GAT_GOUT_PERI_UART_0_EXT_UCLK	0x206c
+#define CLK_CON_GAT_GOUT_PERI_UART_0_PCLK	0x2070
+#define CLK_CON_GAT_GOUT_PERI_UART_1_EXT_UCLK	0x2074
+#define CLK_CON_GAT_GOUT_PERI_UART_1_PCLK	0x2078
+#define CLK_CON_GAT_GOUT_PERI_UART_2_EXT_UCLK	0x207c
+#define CLK_CON_GAT_GOUT_PERI_UART_2_PCLK	0x2080
+#define CLK_CON_GAT_GOUT_PERI_USI0_PCLK		0x2084
+#define CLK_CON_GAT_GOUT_PERI_USI0_SCLK		0x2088
+#define CLK_CON_GAT_GOUT_PERI_USI1_PCLK		0x208c
+#define CLK_CON_GAT_GOUT_PERI_USI1_SCLK		0x2090
+#define CLK_CON_GAT_GOUT_PERI_USI2_PCLK		0x2094
+#define CLK_CON_GAT_GOUT_PERI_USI2_SCLK		0x2098
+#define CLK_CON_GAT_GOUT_PERI_MCT_PCLK		0x20a0
+#define CLK_CON_GAT_GOUT_PERI_SYSREG_PERI_PCLK	0x20b0
+#define CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER0_PCLK	0x20b4
+#define CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER1_PCLK	0x20b8
+
+static const unsigned long peri_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_PERI_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_SPI0_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_SPI1_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_UART0_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_UART1_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_UART2_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_USI0_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_USI1_USER,
+	PLL_CON0_MUX_CLKCMU_PERI_USI2_USER,
+	CLK_CON_GAT_GOUT_PERI_GPIO_TOP_PCLK,
+	CLK_CON_GAT_GOUT_PERI_HSI2C_0_PCLK,
+	CLK_CON_GAT_GOUT_PERI_HSI2C_1_PCLK,
+	CLK_CON_GAT_GOUT_PERI_HSI2C_2_PCLK,
+	CLK_CON_GAT_GOUT_PERI_HSI2C_3_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_0_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_1_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_2_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_3_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_4_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_5_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_6_PCLK,
+	CLK_CON_GAT_GOUT_PERI_I2C_7_PCLK,
+	CLK_CON_GAT_GOUT_PERI_PWM_MOTOR_PCLK,
+	CLK_CON_GAT_GOUT_PERI_SPI_0_PCLK,
+	CLK_CON_GAT_GOUT_PERI_SPI_0_EXT_CLK,
+	CLK_CON_GAT_GOUT_PERI_SPI_1_PCLK,
+	CLK_CON_GAT_GOUT_PERI_SPI_1_EXT_CLK,
+	CLK_CON_GAT_GOUT_PERI_UART_0_EXT_UCLK,
+	CLK_CON_GAT_GOUT_PERI_UART_0_PCLK,
+	CLK_CON_GAT_GOUT_PERI_UART_1_EXT_UCLK,
+	CLK_CON_GAT_GOUT_PERI_UART_1_PCLK,
+	CLK_CON_GAT_GOUT_PERI_UART_2_EXT_UCLK,
+	CLK_CON_GAT_GOUT_PERI_UART_2_PCLK,
+	CLK_CON_GAT_GOUT_PERI_USI0_PCLK,
+	CLK_CON_GAT_GOUT_PERI_USI0_SCLK,
+	CLK_CON_GAT_GOUT_PERI_USI1_PCLK,
+	CLK_CON_GAT_GOUT_PERI_USI1_SCLK,
+	CLK_CON_GAT_GOUT_PERI_USI2_PCLK,
+	CLK_CON_GAT_GOUT_PERI_USI2_SCLK,
+	CLK_CON_GAT_GOUT_PERI_MCT_PCLK,
+	CLK_CON_GAT_GOUT_PERI_SYSREG_PERI_PCLK,
+	CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER0_PCLK,
+	CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER1_PCLK,
+};
+
+/* List of parent clocks for Muxes in CMU_PERI */
+PNAME(mout_peri_bus_user_p)	= { "oscclk", "dout_peri_bus" };
+PNAME(mout_peri_spi0_user_p)	= { "oscclk", "dout_peri_spi0" };
+PNAME(mout_peri_spi1_user_p)	= { "oscclk", "dout_peri_spi1" };
+PNAME(mout_peri_uart0_user_p)	= { "oscclk", "dout_peri_uart0" };
+PNAME(mout_peri_uart1_user_p)	= { "oscclk", "dout_peri_uart1" };
+PNAME(mout_peri_uart2_user_p)	= { "oscclk", "dout_peri_uart2" };
+PNAME(mout_peri_usi0_user_p)	= { "oscclk", "dout_peri_usi0" };
+PNAME(mout_peri_usi1_user_p)	= { "oscclk", "dout_peri_usi1" };
+PNAME(mout_peri_usi2_user_p)	= { "oscclk", "dout_peri_usi2" };
+
+static const struct samsung_mux_clock peri_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_PERI_BUS_USER, "mout_peri_bus_user", mout_peri_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_PERI_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_SPI0_USER, "mout_peri_spi0_user", mout_peri_spi0_user_p,
+	    PLL_CON0_MUX_CLKCMU_PERI_SPI0_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_SPI1_USER, "mout_peri_spi1_user", mout_peri_spi1_user_p,
+	    PLL_CON0_MUX_CLKCMU_PERI_SPI1_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_UART0_USER, "mout_peri_uart0_user",
+	    mout_peri_uart0_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART0_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_UART1_USER, "mout_peri_uart1_user",
+	    mout_peri_uart1_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART1_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_UART2_USER, "mout_peri_uart2_user",
+	    mout_peri_uart2_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART2_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_USI0_USER, "mout_peri_usi0_user",
+	    mout_peri_usi0_user_p, PLL_CON0_MUX_CLKCMU_PERI_USI0_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_USI1_USER, "mout_peri_usi1_user",
+	    mout_peri_usi1_user_p, PLL_CON0_MUX_CLKCMU_PERI_USI1_USER, 4, 1),
+	MUX(CLK_MOUT_PERI_USI2_USER, "mout_peri_usi2_user",
+	    mout_peri_usi2_user_p, PLL_CON0_MUX_CLKCMU_PERI_USI2_USER, 4, 1),
+};
+
+static const struct samsung_gate_clock peri_gate_clks[] __initconst = {
+	/* TODO: Should be enabled in GPIO driver (or made CLK_IS_CRITICAL) */
+	GATE(CLK_GOUT_GPIO_TOP_PCLK, "gout_gpio_top_pclk",
+	     "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_GPIO_TOP_PCLK, 21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI2C0_PCLK, "gout_hsi2c0_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_HSI2C_0_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI2C1_PCLK, "gout_hsi2c1_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_HSI2C_1_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI2C2_PCLK, "gout_hsi2c2_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_HSI2C_2_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI2C3_PCLK, "gout_hsi2c3_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_HSI2C_3_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C0_PCLK, "gout_i2c0_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_0_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C1_PCLK, "gout_i2c1_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_1_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C2_PCLK, "gout_i2c2_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_2_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C3_PCLK, "gout_i2c3_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_3_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C4_PCLK, "gout_i2c4_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_4_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C5_PCLK, "gout_i2c5_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_5_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C6_PCLK, "gout_i2c6_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_6_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_I2C7_PCLK, "gout_i2c7_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_I2C_7_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_PWM_MOTOR_PCLK, "gout_pwm_motor_pclk",
+	     "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_PWM_MOTOR_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_SPI0_PCLK, "gout_spi0_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_SPI_0_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_SPI0_EXT_CLK, "gout_spi0_ipclk", "mout_peri_spi0_user",
+	     CLK_CON_GAT_GOUT_PERI_SPI_0_EXT_CLK, 21, 0, 0),
+	GATE(CLK_GOUT_SPI1_PCLK, "gout_spi1_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_SPI_1_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_SPI1_EXT_CLK, "gout_spi1_ipclk", "mout_peri_spi1_user",
+	     CLK_CON_GAT_GOUT_PERI_SPI_1_EXT_CLK, 21, 0, 0),
+	GATE(CLK_GOUT_UART0_EXT_UCLK, "gout_uart0_ext_uclk", "mout_peri_uart0_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_0_EXT_UCLK, 21, 0, 0),
+	GATE(CLK_GOUT_UART0_PCLK, "gout_uart0_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_0_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_UART1_EXT_UCLK, "gout_uart1_ext_uclk", "mout_peri_uart1_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_1_EXT_UCLK, 21, 0, 0),
+	GATE(CLK_GOUT_UART1_PCLK, "gout_uart1_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_1_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_UART2_EXT_UCLK, "gout_uart2_ext_uclk", "mout_peri_uart2_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_2_EXT_UCLK, 21, 0, 0),
+	GATE(CLK_GOUT_UART2_PCLK, "gout_uart2_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_UART_2_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_USI0_PCLK, "gout_usi0_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_USI0_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_USI0_SCLK, "gout_usi0_sclk", "mout_peri_usi0_user",
+	     CLK_CON_GAT_GOUT_PERI_USI0_SCLK, 21, 0, 0),
+	GATE(CLK_GOUT_USI1_PCLK, "gout_usi1_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_USI1_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_USI1_SCLK, "gout_usi1_sclk", "mout_peri_usi1_user",
+	     CLK_CON_GAT_GOUT_PERI_USI1_SCLK, 21, 0, 0),
+	GATE(CLK_GOUT_USI2_PCLK, "gout_usi2_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_USI2_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_USI2_SCLK, "gout_usi2_sclk", "mout_peri_usi2_user",
+	     CLK_CON_GAT_GOUT_PERI_USI2_SCLK, 21, 0, 0),
+	GATE(CLK_GOUT_MCT_PCLK, "gout_mct_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_MCT_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_SYSREG_PERI_PCLK, "gout_sysreg_peri_pclk",
+	     "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_SYSREG_PERI_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_WDT0_PCLK, "gout_wdt0_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER0_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_WDT1_PCLK, "gout_wdt1_pclk", "mout_peri_bus_user",
+	     CLK_CON_GAT_GOUT_PERI_WDT_CLUSTER1_PCLK, 21, 0, 0),
+};
+
+static const struct samsung_cmu_info peri_cmu_info __initconst = {
+	.mux_clks		= peri_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(peri_mux_clks),
+	.gate_clks		= peri_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(peri_gate_clks),
+	.nr_clk_ids		= PERI_NR_CLK,
+	.clk_regs		= peri_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(peri_clk_regs),
+	.clk_name		= "dout_peri_bus",
+};
+
+static void __init exynos7885_cmu_peri_init(struct device_node *np)
+{
+	exynos7885_register_cmu(NULL, np, &peri_cmu_info);
+}
+
+/* Register CMU_PERI early, as it's needed for MCT timer */
+CLK_OF_DECLARE(exynos7885_cmu_peri, "samsung,exynos7885-cmu-peri",
+	       exynos7885_cmu_peri_init);
+
+/* ---- CMU_CORE ------------------------------------------------------------ */
+
+/* Register Offset definitions for CMU_CORE (0x12000000) */
+#define PLL_CON0_MUX_CLKCMU_CORE_BUS_USER	0x0100
+#define PLL_CON0_MUX_CLKCMU_CORE_CCI_USER	0x0120
+#define PLL_CON0_MUX_CLKCMU_CORE_G3D_USER	0x0140
+#define CLK_CON_MUX_MUX_CLK_CORE_GIC		0x1000
+#define CLK_CON_DIV_DIV_CLK_CORE_BUSP		0x1800
+#define CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK	0x2054
+#define CLK_CON_GAT_GOUT_CORE_GIC400_CLK	0x2058
+
+static const unsigned long core_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_CORE_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_CORE_CCI_USER,
+	PLL_CON0_MUX_CLKCMU_CORE_G3D_USER,
+	CLK_CON_MUX_MUX_CLK_CORE_GIC,
+	CLK_CON_DIV_DIV_CLK_CORE_BUSP,
+	CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK,
+	CLK_CON_GAT_GOUT_CORE_GIC400_CLK,
+};
+
+/* List of parent clocks for Muxes in CMU_CORE */
+PNAME(mout_core_bus_user_p)		= { "oscclk", "dout_core_bus" };
+PNAME(mout_core_cci_user_p)		= { "oscclk", "dout_core_cci" };
+PNAME(mout_core_g3d_user_p)		= { "oscclk", "dout_core_g3d" };
+PNAME(mout_core_gic_p)			= { "dout_core_busp", "oscclk" };
+
+static const struct samsung_mux_clock core_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_CORE_BUS_USER, "mout_core_bus_user", mout_core_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_CORE_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_CORE_CCI_USER, "mout_core_cci_user", mout_core_cci_user_p,
+	    PLL_CON0_MUX_CLKCMU_CORE_CCI_USER, 4, 1),
+	MUX(CLK_MOUT_CORE_G3D_USER, "mout_core_g3d_user", mout_core_g3d_user_p,
+	    PLL_CON0_MUX_CLKCMU_CORE_G3D_USER, 4, 1),
+	MUX(CLK_MOUT_CORE_GIC, "mout_core_gic", mout_core_gic_p,
+	    CLK_CON_MUX_MUX_CLK_CORE_GIC, 0, 1),
+};
+
+static const struct samsung_div_clock core_div_clks[] __initconst = {
+	DIV(CLK_DOUT_CORE_BUSP, "dout_core_busp", "mout_core_bus_user",
+	    CLK_CON_DIV_DIV_CLK_CORE_BUSP, 0, 2),
+};
+
+static const struct samsung_gate_clock core_gate_clks[] __initconst = {
+	/* CCI (interconnect) clock must be always running */
+	GATE(CLK_GOUT_CCI_ACLK, "gout_cci_aclk", "mout_core_cci_user",
+	     CLK_CON_GAT_GOUT_CORE_CCI_550_ACLK, 21, CLK_IS_CRITICAL, 0),
+	/* GIC (interrupt controller) clock must be always running */
+	GATE(CLK_GOUT_GIC400_CLK, "gout_gic400_clk", "mout_core_gic",
+	     CLK_CON_GAT_GOUT_CORE_GIC400_CLK, 21, CLK_IS_CRITICAL, 0),
+};
+
+static const struct samsung_cmu_info core_cmu_info __initconst = {
+	.mux_clks		= core_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(core_mux_clks),
+	.div_clks		= core_div_clks,
+	.nr_div_clks		= ARRAY_SIZE(core_div_clks),
+	.gate_clks		= core_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(core_gate_clks),
+	.nr_clk_ids		= CORE_NR_CLK,
+	.clk_regs		= core_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
+	.clk_name		= "dout_core_bus",
+};
+
+/* ---- platform_driver ----------------------------------------------------- */
+
+static int __init exynos7885_cmu_probe(struct platform_device *pdev)
+{
+	const struct samsung_cmu_info *info;
+	struct device *dev = &pdev->dev;
+
+	info = of_device_get_match_data(dev);
+	exynos7885_register_cmu(dev, dev->of_node, info);
+
+	return 0;
+}
+
+static const struct of_device_id exynos7885_cmu_of_match[] = {
+	{
+		.compatible = "samsung,exynos7885-cmu-core",
+		.data = &core_cmu_info,
+	}, {
+	},
+};
+
+static struct platform_driver exynos7885_cmu_driver __refdata = {
+	.driver	= {
+		.name = "exynos7885-cmu",
+		.of_match_table = exynos7885_cmu_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = exynos7885_cmu_probe,
+};
+
+static int __init exynos7885_cmu_init(void)
+{
+	return platform_driver_register(&exynos7885_cmu_driver);
+}
+core_initcall(exynos7885_cmu_init);
-- 
2.34.1

