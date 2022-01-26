Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A601849D138
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbiAZR4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiAZR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BAC06161C;
        Wed, 26 Jan 2022 09:56:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e2so448451wra.2;
        Wed, 26 Jan 2022 09:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d4sAbydBa6W6M0KWJr4NJNHgDhBapvpROJ25McC5A7M=;
        b=dH/+yarGXVmefcsJtqzHVmaS/ryRaddb9xJ/T4F1cQUBQvEyrzGPJddIlrSSDHSN2v
         fNdZWFsiAduXOjwJ7FHH4iPsfuQlWz5GFzbudCKnTsr3Mvo/CQG1tMJykWvyvf3I0JOq
         6ZIiVvyYSe82KMdqPBvd2Shk4AKTioN11GsJuKUGEuOqiWbYpe5AaYSFT+f7ujy+yfh+
         eEN6v8P5KNwMISz2qTRkNeVYZIIf9zjGlHPXOcpxJnENMLCeBFQjPXc9+xQxe+8jDFPu
         OuHqcEPhLIPr1nN4MucfRSKN2b9RWzv6TusGfOR4Fh2fNOiX1KqJ5Y0YS4jNtG/EX+iW
         hVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4sAbydBa6W6M0KWJr4NJNHgDhBapvpROJ25McC5A7M=;
        b=S8TGz/bhHZorlaIjqE1JyjgqgfvPfMkOBVO2oKkjjjmT1IiI4QqknsH65FD/0p68QS
         Q3x2YFWxbN98IVfNBwmMMMpeRInWSsgjiS1k1FJQivfZwPHXDU6Nq7DhN1ikrLrTj8ls
         TUlcGfk1YnAnGcZxoRa4jN07VQVrNcqnQmCBVPoWZ/cCPVU4ZJPbmNnMKK7CyURcYqTp
         LRl0QcULMlGDwT8Letavj1igmZ31M42R1NVeffqkyJAojkqY0MwQ0NLLITe/cSTlUepr
         4hc2kwIyaUB9zvan8nvQXrCj9r+2leqQSl5Bbed3fsDBrQX6T52h7MTf7d7Oz8EIfPXh
         ralA==
X-Gm-Message-State: AOAM530RgmWrOmg34e4uf1wmKb6zOBLKpcEaXnFnf4hsulEOZf97M6W3
        s0ncCu30foMTFiGxzWia5trCdTTQQBgYww==
X-Google-Smtp-Source: ABdhPJzOAYH33Jt1htT3h7kdAWr7wla5FeFPqijenUfwKt46aQWHuV8TZjDIV8UFvOwFZZ5DnJFYyg==
X-Received: by 2002:adf:c3c7:: with SMTP id d7mr24374423wrg.253.1643219774766;
        Wed, 26 Jan 2022 09:56:14 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id 16sm3708753wmj.12.2022.01.26.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:14 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 2/8] clk: mstar: msc313 cpupll clk driver
Date:   Wed, 26 Jan 2022 18:55:58 +0100
Message-Id: <20220126175604.17919-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
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
 drivers/clk/mstar/Kconfig             |   8 +
 drivers/clk/mstar/Makefile            |   2 +-
 drivers/clk/mstar/clk-msc313-cpupll.c | 221 ++++++++++++++++++++++++++
 3 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
index de37e1bce2d2..146eeb637318 100644
--- a/drivers/clk/mstar/Kconfig
+++ b/drivers/clk/mstar/Kconfig
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config MSTAR_MSC313_CPUPLL
+	bool "MStar CPUPLL driver"
+	depends on ARCH_MSTARV7 || COMPILE_TEST
+	default ARCH_MSTARV7
+	help
+	  Support for the CPU PLL present on MStar/Sigmastar SoCs.
+
 config MSTAR_MSC313_MPLL
 	bool "MStar MPLL driver"
 	depends on ARCH_MSTARV7 || COMPILE_TEST
@@ -7,3 +14,4 @@ config MSTAR_MSC313_MPLL
 	help
 	  Support for the MPLL PLL and dividers block present on
 	  MStar/Sigmastar SoCs.
+
diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
index f8dcd25ede1d..21296a04e65a 100644
--- a/drivers/clk/mstar/Makefile
+++ b/drivers/clk/mstar/Makefile
@@ -2,5 +2,5 @@
 #
 # Makefile for mstar specific clk
 #
-
+obj-$(CONFIG_MSTAR_MSC313_CPUPLL) += clk-msc313-cpupll.o
 obj-$(CONFIG_MSTAR_MSC313_MPLL) += clk-msc313-mpll.o
diff --git a/drivers/clk/mstar/clk-msc313-cpupll.c b/drivers/clk/mstar/clk-msc313-cpupll.c
new file mode 100644
index 000000000000..c57b509e8c20
--- /dev/null
+++ b/drivers/clk/mstar/clk-msc313-cpupll.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
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
+#define LPF_LOCK_TIMEOUT	100000000
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
+	ktime_t timeout;
+
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
+	timeout = ktime_add_ns(ktime_get(), LPF_LOCK_TIMEOUT);
+	while (!(ioread16(cpupll->base + REG_LPF_LOCK))) {
+		if (ktime_after(ktime_get(), timeout)) {
+			pr_err("timeout waiting for LPF_LOCK\n");
+			return;
+		}
+		cpu_relax();
+	}
+
+	iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
+
+	msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L, regvalue);
+}
+
+static unsigned long msc313_cpupll_frequencyforreg(u32 reg, unsigned long parent_rate)
+{
+	unsigned long long prescaled = ((unsigned long long)parent_rate) * MULTIPLIER;
+
+	if (prescaled == 0 || reg == 0)
+		return 0;
+	return DIV_ROUND_DOWN_ULL(prescaled, reg);
+}
+
+static u32 msc313_cpupll_regforfrequecy(unsigned long rate, unsigned long parent_rate)
+{
+	unsigned long long prescaled = ((unsigned long long)parent_rate) * MULTIPLIER;
+
+	if (prescaled == 0 || rate == 0)
+		return 0;
+	return DIV_ROUND_UP_ULL(prescaled, rate);
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
+	{ .compatible = "mstar,msc313-cpupll" },
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

