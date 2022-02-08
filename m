Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416514AE113
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385091AbiBHSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385080AbiBHSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:41:42 -0500
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 10:41:39 PST
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491C7C06157B;
        Tue,  8 Feb 2022 10:41:38 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1644345293; bh=C2NGAAeRS1YCWvvrFSmpGAh3DydYiDjAFK9L9+leUpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JeiGA/04kSmNIliiS6qURc5WrrHFeD5HM19cMIol+99SI2mbVyrpdy+Au3LNMAU3A
         4EOxX3eNiNUzgrgZg6dlGaGdtZkhflANXmGEEc9hAYJTGBp0d5XGdE4hKt12o+amcp
         G26rMrDeEEQKZMT/r0AjxOMfNnGcnEkP5lqJM2XU=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH v4 2/3] clk: clk-apple-nco: Add driver for Apple NCO
Date:   Tue,  8 Feb 2022 19:34:10 +0100
Message-Id: <20220208183411.61090-3-povik+lin@cutebit.org>
In-Reply-To: <20220208183411.61090-1-povik+lin@cutebit.org>
References: <20220208183411.61090-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,SPF_FAIL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a common clock driver for NCO blocks found on Apple SoCs where they
are typically the generators of audio clocks.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 drivers/clk/Kconfig         |   9 +
 drivers/clk/Makefile        |   1 +
 drivers/clk/clk-apple-nco.c | 333 ++++++++++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/clk/clk-apple-nco.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3cdf33470a75..b945d3bb95d6 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -59,6 +59,15 @@ config LMK04832
 	  Say yes here to build support for Texas Instruments' LMK04832 Ultra
 	  Low-Noise JESD204B Compliant Clock Jitter Cleaner With Dual Loop PLLs
 
+config COMMON_CLK_APPLE_NCO
+	bool "Clock driver for Apple SoC NCOs"
+	depends on ARCH_APPLE || COMPILE_TEST
+	default ARCH_APPLE
+	help
+	  This driver supports NCO (Numerically Controlled Oscillator) blocks
+	  found on Apple SoCs such as t8103 (M1). The blocks are typically
+	  generators of audio clocks.
+
 config COMMON_CLK_MAX77686
 	tristate "Clock driver for Maxim 77620/77686/77802 MFD"
 	depends on MFD_MAX77686 || MFD_MAX77620 || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 6a98291350b6..45b6d8c51d61 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -18,6 +18,7 @@ endif
 
 # hardware specific clock types
 # please keep this section sorted lexicographically by file path name
+obj-$(CONFIG_COMMON_CLK_APPLE_NCO)  	+= clk-apple-nco.o
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
diff --git a/drivers/clk/clk-apple-nco.c b/drivers/clk/clk-apple-nco.c
new file mode 100644
index 000000000000..d985a7be8947
--- /dev/null
+++ b/drivers/clk/clk-apple-nco.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Driver for an SoC block (Numerically Controlled Oscillator)
+ * found on t8103 (M1) and other Apple chips
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define NCO_CHANNEL_STRIDE	0x4000
+#define NCO_CHANNEL_REGSIZE	20
+
+#define REG_CTRL	0
+#define CTRL_ENABLE	BIT(31)
+#define REG_DIV		4
+#define DIV_FINE	GENMASK(1, 0)
+#define DIV_COARSE	GENMASK(12, 2)
+#define REG_INC1	8
+#define REG_INC2	12
+#define REG_ACCINIT	16
+
+/*
+ * Theory of operation (postulated)
+ *
+ * The REG_DIV register indirectly expresses a base integer divisor, roughly
+ * corresponding to twice the desired ratio of input to output clock. This
+ * base divisor is adjusted on a cycle-by-cycle basis based on the state of a
+ * 32-bit phase accumulator to achieve a desired precise clock ratio over the
+ * long term.
+ *
+ * Specifically an output clock cycle is produced after (REG_DIV divisor)/2
+ * or (REG_DIV divisor + 1)/2 input cycles, the latter taking effect when top
+ * bit of the 32-bit accumulator is set. The accumulator is incremented each
+ * produced output cycle, by the value from either REG_INC1 or REG_INC2, which
+ * of the two is selected depending again on the accumulator's current top bit.
+ *
+ * Because the NCO hardware implements counting of input clock cycles in part
+ * in a Galois linear-feedback shift register, the higher bits of divisor
+ * are programmed into REG_DIV by picking an appropriate LFSR state. See
+ * applnco_compute_tables/applnco_div_translate for details on this.
+ */
+
+#define LFSR_POLY	0xa01
+#define LFSR_INIT	0x7ff
+#define LFSR_LEN	11
+#define LFSR_PERIOD	((1 << LFSR_LEN) - 1)
+#define LFSR_TBLSIZE	(1 << LFSR_LEN)
+
+/* The minimal attainable coarse divisor (first value in table) */
+#define COARSE_DIV_OFFSET 2
+
+struct applnco_tables {
+	u16 fwd[LFSR_TBLSIZE];
+	u16 inv[LFSR_TBLSIZE];
+};
+
+struct applnco_channel {
+	void __iomem *base;
+	struct applnco_tables *tbl;
+	struct clk_hw hw;
+
+	spinlock_t lock;
+};
+
+#define to_applnco_channel(_hw) container_of(_hw, struct applnco_channel, hw)
+
+static void applnco_enable_nolock(struct clk_hw *hw)
+{
+	struct applnco_channel *chan = to_applnco_channel(hw);
+	u32 val;
+
+	val = readl_relaxed(chan->base + REG_CTRL);
+	writel_relaxed(val | CTRL_ENABLE, chan->base + REG_CTRL);
+}
+
+static void applnco_disable_nolock(struct clk_hw *hw)
+{
+	struct applnco_channel *chan = to_applnco_channel(hw);
+	u32 val;
+
+	val = readl_relaxed(chan->base + REG_CTRL);
+	writel_relaxed(val & ~CTRL_ENABLE, chan->base + REG_CTRL);
+}
+
+static int applnco_is_enabled(struct clk_hw *hw)
+{
+	struct applnco_channel *chan = to_applnco_channel(hw);
+
+	return (readl_relaxed(chan->base + REG_CTRL) & CTRL_ENABLE) != 0;
+}
+
+static void applnco_compute_tables(struct applnco_tables *tbl)
+{
+	int i;
+	u32 state = LFSR_INIT;
+
+	/*
+	 * Go through the states of a Galois LFSR and build
+	 * a coarse divisor translation table.
+	 */
+	for (i = LFSR_PERIOD; i > 0; i--) {
+		if (state & 1)
+			state = (state >> 1) ^ (LFSR_POLY >> 1);
+		else
+			state = (state >> 1);
+		tbl->fwd[i] = state;
+		tbl->inv[state] = i;
+	}
+
+	/* Zero value is special-cased */
+	tbl->fwd[0] = 0;
+	tbl->inv[0] = 0;
+}
+
+static bool applnco_div_out_of_range(unsigned int div)
+{
+	unsigned int coarse = div / 4;
+
+	return coarse < COARSE_DIV_OFFSET ||
+		coarse >= COARSE_DIV_OFFSET + LFSR_TBLSIZE;
+}
+
+static u32 applnco_div_translate(struct applnco_tables *tbl, unsigned int div)
+{
+	unsigned int coarse = div / 4;
+
+	if (WARN_ON(applnco_div_out_of_range(div)))
+		return 0;
+
+	return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
+			FIELD_PREP(DIV_FINE, div % 4);
+}
+
+static unsigned int applnco_div_translate_inv(struct applnco_tables *tbl, u32 regval)
+{
+	unsigned int coarse, fine;
+
+	coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
+	fine = FIELD_GET(DIV_FINE, regval);
+
+	return coarse * 4 + fine;
+}
+
+static int applnco_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct applnco_channel *chan = to_applnco_channel(hw);
+	unsigned long flags;
+	u32 div, inc1, inc2;
+	bool was_enabled;
+
+	div = 2 * parent_rate / rate;
+	inc1 = 2 * parent_rate - div * rate;
+	inc2 = inc1 - rate;
+
+	if (applnco_div_out_of_range(div))
+		return -EINVAL;
+
+	div = applnco_div_translate(chan->tbl, div);
+
+	spin_lock_irqsave(&chan->lock, flags);
+	was_enabled = applnco_is_enabled(hw);
+	applnco_disable_nolock(hw);
+
+	writel_relaxed(div,  chan->base + REG_DIV);
+	writel_relaxed(inc1, chan->base + REG_INC1);
+	writel_relaxed(inc2, chan->base + REG_INC2);
+
+	/* Presumably a neutral initial value for accumulator */
+	writel_relaxed(1 << 31, chan->base + REG_ACCINIT);
+
+	if (was_enabled)
+		applnco_enable_nolock(hw);
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return 0;
+}
+
+static unsigned long applnco_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct applnco_channel *chan = to_applnco_channel(hw);
+	u32 div, inc1, inc2, incbase;
+
+	div = applnco_div_translate_inv(chan->tbl,
+			readl_relaxed(chan->base + REG_DIV));
+
+	inc1 = readl_relaxed(chan->base + REG_INC1);
+	inc2 = readl_relaxed(chan->base + REG_INC2);
+
+	/*
+	 * We don't support wraparound of accumulator
+	 * nor the edge case of both increments being zero
+	 */
+	if (inc1 >= (1 << 31) || inc2 < (1 << 31) || (inc1 == 0 && inc2 == 0))
+		return 0;
+
+	/* Scale both sides of division by incbase to maintain precision */
+	incbase = inc1 - inc2;
+
+	return div64_u64(((u64) parent_rate) * 2 * incbase,
+			((u64) div) * incbase + inc1);
+}
+
+static long applnco_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	unsigned long lo = *parent_rate / (COARSE_DIV_OFFSET + LFSR_TBLSIZE) + 1;
+	unsigned long hi = *parent_rate / COARSE_DIV_OFFSET;
+
+	return clamp(rate, lo, hi);
+}
+
+static int applnco_enable(struct clk_hw *hw)
+{
+	struct applnco_channel *chan = to_applnco_channel(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	applnco_enable_nolock(hw);
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return 0;
+}
+
+static void applnco_disable(struct clk_hw *hw)
+{
+	struct applnco_channel *chan = to_applnco_channel(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	applnco_disable_nolock(hw);
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+
+static const struct clk_ops applnco_ops = {
+	.set_rate = applnco_set_rate,
+	.recalc_rate = applnco_recalc_rate,
+	.round_rate = applnco_round_rate,
+	.enable = applnco_enable,
+	.disable = applnco_disable,
+	.is_enabled = applnco_is_enabled,
+};
+
+static int applnco_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct clk_parent_data pdata = { .index = 0 };
+	struct clk_init_data init;
+	struct clk_hw_onecell_data *onecell_data;
+	void __iomem *base;
+	struct resource *res;
+	struct applnco_tables *tbl;
+	unsigned int nchannels;
+	int ret, i;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (resource_size(res) < NCO_CHANNEL_REGSIZE)
+		return -EINVAL;
+	nchannels = (resource_size(res) - NCO_CHANNEL_REGSIZE)
+			/ NCO_CHANNEL_STRIDE + 1;
+
+	onecell_data = devm_kzalloc(&pdev->dev, struct_size(onecell_data, hws,
+							nchannels), GFP_KERNEL);
+	if (!onecell_data)
+		return -ENOMEM;
+	onecell_data->num = nchannels;
+
+	tbl = devm_kzalloc(&pdev->dev, sizeof(*tbl), GFP_KERNEL);
+	if (!tbl)
+		return -ENOMEM;
+	applnco_compute_tables(tbl);
+
+	for (i = 0; i < nchannels; i++) {
+		struct applnco_channel *chan;
+
+		chan = devm_kzalloc(&pdev->dev, sizeof(*chan), GFP_KERNEL);
+		if (!chan)
+			return -ENOMEM;
+		chan->base = base + NCO_CHANNEL_STRIDE * i;
+		chan->tbl = tbl;
+		spin_lock_init(&chan->lock);
+
+		memset(&init, 0, sizeof(init));
+		init.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+						"%s-%d", np->name, i);
+		init.ops = &applnco_ops;
+		init.parent_data = &pdata;
+		init.num_parents = 1;
+		init.flags = 0;
+
+		chan->hw.init = &init;
+		ret = devm_clk_hw_register(&pdev->dev, &chan->hw);
+		if (ret)
+			return ret;
+
+		onecell_data->hws[i] = &chan->hw;
+	}
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
+							onecell_data);
+}
+
+static const struct of_device_id applnco_ids[] = {
+	{ .compatible = "apple,nco" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, applnco_ids)
+
+static struct platform_driver applnco_driver = {
+	.driver = {
+		.name = "apple-nco",
+		.of_match_table = applnco_ids,
+	},
+	.probe = applnco_probe,
+};
+module_platform_driver(applnco_driver);
+
+MODULE_AUTHOR("Martin Povišer <povik+lin@cutebit.org>");
+MODULE_DESCRIPTION("Clock driver for NCO blocks on Apple SoCs");
+MODULE_LICENSE("GPL");
-- 
2.33.0

