Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E290482C33
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiABQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiABQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49670C061784;
        Sun,  2 Jan 2022 08:57:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w20so56682671wra.9;
        Sun, 02 Jan 2022 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99BhoIF0QsN7W+XiT4N4CxnrOHTqsGHcxK8UH/KZtro=;
        b=KOCIaEpm6tDeeo+B3T5cmjoKL3Bp9mqtD8XEwbpDj3cEgII7DlQyr+k8jQU7P2Y5eP
         dntEqXwFmilgB7IXS1YkgFUzx6mm//HWpjqvxezqhs+N90CZ6+Iz44rhfiiZNNtw9umC
         uHhMdiy0lKf1VNuHKQ93MPpu6XL/0LngHEUO8qPP6qRgph6vj3GTlL7P0jC8se7UnyTW
         aPY5fehD1PDiVwXUAfJkixhwqZcFwyHbJrEDAGp5Z4TeA3G48oT8dWrVzN3YlGxgMN1w
         1Mx7CaRYCw2+5C2ToTju5E062yYGTDuXPuhQrF2ZvhTi+PjOaqt58QBVDk1Lw+Z5AhVI
         1OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99BhoIF0QsN7W+XiT4N4CxnrOHTqsGHcxK8UH/KZtro=;
        b=0rlMr3PAaXMF3+ldGs4h8E4EzGd0M0SVexDCG7OQX/VB+/xvB0xcF3YupNDZNz4UAW
         Qbf74D48lZaxbGE0NUp0fJF6C6yJiK30geGKfSyR7glnIDCBd09rUB+c2ElmyxmvHFuP
         bLrrEuged5j8BrbqTAJz7BcI7do8Kzr15ppXT/ptS/ruNJ8PW76qe1EeC9VTQYs3n0R8
         rr13eqVq5B7mfcBXJu5dGY0hzJLMSoo5bX07+cpUTmIAI/+mN8WgMgw5wKYgyWc9xXDR
         0HIEPIzBGuNVf/m+3V8p+6nfkJGimz2Qo7CQORyC84+6i7qo6e3fAFc2QOlcaEdqJGvt
         L1Aw==
X-Gm-Message-State: AOAM531e1tDo+QnRJmY3JlO3uhRh71FEIFhdQnjMpBwoE3AXVj5yRofO
        wNSQ+bP0iv/m9OJvZg49fqg=
X-Google-Smtp-Source: ABdhPJxZrIuZ8nYgJgBvNM3coNHMtx4YqOjsLdm514ouixXAU2jO9pHfR9M5MCRnmUy3TqGbnW0UFg==
X-Received: by 2002:a5d:588f:: with SMTP id n15mr36520972wrf.159.1641142656878;
        Sun, 02 Jan 2022 08:57:36 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id w6sm32567801wrs.52.2022.01.02.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:36 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 2/9] clk: mstar: msc313 cpupll clk driver
Date:   Sun,  2 Jan 2022 17:57:23 +0100
Message-Id: <20220102165730.50190-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add a driver for the CPU pll/ARM pll/MIPS pll that is present
in MStar SoCs.

Currently there is no documentation for this block so it's possible
this driver isn't entirely correct.

Only tested on the version of this IP in the MStar/SigmaStar
ARMv7 SoCs.

Co-authored-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/clk/mstar/Kconfig             |   7 +
 drivers/clk/mstar/Makefile            |   1 +
 drivers/clk/mstar/clk-msc313-cpupll.c | 227 ++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
index de37e1bce2d2..a44ca2b180ff 100644
--- a/drivers/clk/mstar/Kconfig
+++ b/drivers/clk/mstar/Kconfig
@@ -7,3 +7,10 @@ config MSTAR_MSC313_MPLL
 	help
 	  Support for the MPLL PLL and dividers block present on
 	  MStar/Sigmastar SoCs.
+
+config MSTAR_MSC313_CPUPLL
+	bool "MStar CPUPLL driver"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	default ARCH_MSTARV7
+	help
+	  Support for the CPU PLL present on MStar/Sigmastar SoCs.
diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
index f8dcd25ede1d..9f05b73a0619 100644
--- a/drivers/clk/mstar/Makefile
+++ b/drivers/clk/mstar/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_MSTAR_MSC313_MPLL) += clk-msc313-mpll.o
+obj-$(CONFIG_MSTAR_MSC313_CPUPLL) += clk-msc313-cpupll.o
diff --git a/drivers/clk/mstar/clk-msc313-cpupll.c b/drivers/clk/mstar/clk-msc313-cpupll.c
new file mode 100644
index 000000000000..2229b16475eb
--- /dev/null
+++ b/drivers/clk/mstar/clk-msc313-cpupll.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+/*
+ * This IP is not documented outside of the messy vendor driver.
+ * Below is what we think the registers look like based on looking at
+ * the vendor code and poking at the hardware:
+ *
+ * 0x140 -- LPF low. Seems to store one half of the clock transition
+ * 0x144 /
+ * 0x148 -- LPF high. Seems to store one half of the clock transition
+ * 0x14c /
+ * 0x150 -- vendor code says "toggle lpf enable"
+ * 0x154 -- mu?
+ * 0x15c -- lpf_update_count?
+ * 0x160 -- vendor code says "switch to LPF". Clock source config? Register bank?
+ * 0x164 -- vendor code says "from low to high" which seems to mean transition from LPF low to
+ * LPF high.
+ * 0x174 -- Seems to be the PLL lock status bit
+ * 0x180 -- Seems to be the current frequency, this might need to be populated by software?
+ * 0x184 /  The vendor driver uses these to set the initial value of LPF low
+ *
+ * Frequency seems to be calculated like this:
+ * (parent clock (432mhz) / register_magic_value) * 16 * 524288
+ * Only the lower 24 bits of the resulting value will be used. In addition, the
+ * PLL doesn't seem to be able to lock on frequencies lower than 220 MHz, as
+ * divisor 0xfb586f (220 MHz) works but 0xfb7fff locks up.
+ *
+ * Vendor values:
+ * frequency - register value
+ *
+ * 400000000  - 0x0067AE14
+ * 600000000  - 0x00451EB8,
+ * 800000000  - 0x0033D70A,
+ * 1000000000 - 0x002978d4,
+ */
+
+#define REG_LPF_LOW_L		0x140
+#define REG_LPF_LOW_H		0x144
+#define REG_LPF_HIGH_BOTTOM	0x148
+#define REG_LPF_HIGH_TOP	0x14c
+#define REG_LPF_TOGGLE		0x150
+#define REG_LPF_MYSTERYTWO	0x154
+#define REG_LPF_UPDATE_COUNT	0x15c
+#define REG_LPF_MYSTERYONE	0x160
+#define REG_LPF_TRANSITIONCTRL	0x164
+#define REG_LPF_LOCK		0x174
+#define REG_CURRENT		0x180
+
+#define MULTIPLIER_1		16
+#define MULTIPLIER_2		524288
+#define MULTIPLIER		(MULTIPLIER_1 * MULTIPLIER_2)
+
+struct msc313_cpupll {
+	void __iomem *base;
+	struct clk_hw clk_hw;
+};
+
+#define to_cpupll(_hw) container_of(_hw, struct msc313_cpupll, clk_hw)
+
+static u32 msc313_cpupll_reg_read32(struct msc313_cpupll *cpupll, unsigned int reg)
+{
+	u32 value;
+
+	value = ioread16(cpupll->base + reg + 4) << 16;
+	value |= ioread16(cpupll->base + reg);
+
+	return value;
+}
+
+static void msc313_cpupll_reg_write32(struct msc313_cpupll *cpupll, unsigned int reg, u32 value)
+{
+	u16 l = value & 0xffff, h = (value >> 16) & 0xffff;
+
+	iowrite16(l, cpupll->base + reg);
+	iowrite16(h, cpupll->base + reg + 4);
+}
+
+static void msc313_cpupll_setfreq(struct msc313_cpupll *cpupll, u32 regvalue)
+{
+	msc313_cpupll_reg_write32(cpupll, REG_LPF_HIGH_BOTTOM, regvalue);
+
+	iowrite16(0x1, cpupll->base + REG_LPF_MYSTERYONE);
+	iowrite16(0x6, cpupll->base + REG_LPF_MYSTERYTWO);
+	iowrite16(0x8, cpupll->base + REG_LPF_UPDATE_COUNT);
+	iowrite16(BIT(12), cpupll->base + REG_LPF_TRANSITIONCTRL);
+
+	iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
+	iowrite16(1, cpupll->base + REG_LPF_TOGGLE);
+
+	while (!(ioread16(cpupll->base + REG_LPF_LOCK)))
+		cpu_relax();
+
+	iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
+
+	msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L, regvalue);
+}
+
+static unsigned long msc313_cpupll_frequencyforreg(u32 reg, unsigned long parent_rate)
+{
+	unsigned long long prescaled = ((unsigned long long)parent_rate) * MULTIPLIER;
+	unsigned long long scaled;
+
+	if (prescaled == 0 || reg == 0)
+		return 0;
+	scaled = DIV_ROUND_DOWN_ULL(prescaled, reg);
+
+	return scaled;
+}
+
+static u32 msc313_cpupll_regforfrequecy(unsigned long rate, unsigned long parent_rate)
+{
+	unsigned long long prescaled = ((unsigned long long)parent_rate) * MULTIPLIER;
+	unsigned long long scaled;
+	u32 reg;
+
+	if (prescaled == 0 || rate == 0)
+		return 0;
+
+	scaled = DIV_ROUND_UP_ULL(prescaled, rate);
+	reg = scaled;
+
+	return reg;
+}
+
+static unsigned long msc313_cpupll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct msc313_cpupll *cpupll = to_cpupll(hw);
+
+	return msc313_cpupll_frequencyforreg(msc313_cpupll_reg_read32(cpupll, REG_LPF_LOW_L),
+					     parent_rate);
+}
+
+static long msc313_cpupll_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	u32 reg = msc313_cpupll_regforfrequecy(rate, *parent_rate);
+	long rounded = msc313_cpupll_frequencyforreg(reg, *parent_rate);
+
+	/*
+	 * This is my poor attempt at making sure the resulting
+	 * rate doesn't overshoot the requested rate.
+	 */
+	for (; rounded >= rate && reg > 0; reg--)
+		rounded = msc313_cpupll_frequencyforreg(reg, *parent_rate);
+
+	return rounded;
+}
+
+static int msc313_cpupll_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+{
+	struct msc313_cpupll *cpupll = to_cpupll(hw);
+	u32 reg = msc313_cpupll_regforfrequecy(rate, parent_rate);
+
+	msc313_cpupll_setfreq(cpupll, reg);
+
+	return 0;
+}
+
+static const struct clk_ops msc313_cpupll_ops = {
+	.recalc_rate	= msc313_cpupll_recalc_rate,
+	.round_rate	= msc313_cpupll_round_rate,
+	.set_rate	= msc313_cpupll_set_rate,
+};
+
+static const struct of_device_id msc313_cpupll_of_match[] = {
+	{
+		.compatible = "mstar,msc313-cpupll",
+	},
+	{}
+};
+
+static const struct clk_parent_data cpupll_parent = {
+	.index	= 0,
+};
+
+static int msc313_cpupll_probe(struct platform_device *pdev)
+{
+	struct clk_init_data clk_init = {};
+	struct device *dev = &pdev->dev;
+	struct msc313_cpupll *cpupll;
+	int ret;
+
+	cpupll = devm_kzalloc(&pdev->dev, sizeof(*cpupll), GFP_KERNEL);
+	if (!cpupll)
+		return -ENOMEM;
+
+	cpupll->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cpupll->base))
+		return PTR_ERR(cpupll->base);
+
+	/* LPF might not contain the current frequency so fix that up */
+	msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L,
+				  msc313_cpupll_reg_read32(cpupll, REG_CURRENT));
+
+	clk_init.name = dev_name(dev);
+	clk_init.ops = &msc313_cpupll_ops;
+	clk_init.flags = CLK_IS_CRITICAL;
+	clk_init.parent_data = &cpupll_parent;
+	clk_init.num_parents = 1;
+	cpupll->clk_hw.init = &clk_init;
+
+	ret = devm_clk_hw_register(dev, &cpupll->clk_hw);
+	if (ret)
+		return ret;
+
+	return of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_simple_get, &cpupll->clk_hw);
+}
+
+static struct platform_driver msc313_cpupll_driver = {
+	.driver = {
+		.name = "mstar-msc313-cpupll",
+		.of_match_table = msc313_cpupll_of_match,
+	},
+	.probe = msc313_cpupll_probe,
+};
+builtin_platform_driver(msc313_cpupll_driver);
-- 
2.34.1

