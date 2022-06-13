Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E232549A72
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbiFMRv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbiFMRvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:51:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888186D847;
        Mon, 13 Jun 2022 06:32:55 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28CC6660166E;
        Mon, 13 Jun 2022 14:32:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655127174;
        bh=XC6mbmI2Sdraxdxu+7GeoF3Pci77VFnyTCm4GVX4HXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiDOMNHdykH0Qx4WRodEeUDtufIXcYwVE/dENbHY4b7AT/BsD9w5ffUL717d9O9lD
         ecOgkFyFsb+xRE4tGK9fJ4r6i9JYLnFTBZxi5RzGd5axThIxcxY2hVFs8jemsEtZZn
         JaRsJMWOpbx2rDjzZAwq1C2DoRbv0Ml4zqMMvBrhgD9mi/TxHSH6ht1jcMsqKDxrG5
         Gj4ana9j2NQFpq/uN/lPc1a+OOS3BQkr2mEWNW53SKa4FrpHqf2Yi3tzQTI5BZXRz0
         JA3fkkjoYrZRJ+CG8V/McuMxBDZxw1bewjf/cCSyI1mMusQ0kx5xNZTdH2xSSUvw1w
         JqjRENC51ZFkQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 2/2] clocksource/drivers/timer-mediatek: Implement CPUXGPT timers
Date:   Mon, 13 Jun 2022 15:32:48 +0200
Message-Id: <20220613133248.34652-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220613133248.34652-1-angelogioacchino.delregno@collabora.com>
References: <20220613133248.34652-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some MediaTek platforms with a buggy TrustZone ATF firmware will not
initialize the AArch64 System Timer correctly: in these cases, the
System Timer address is correctly programmed, as well as the CNTFRQ_EL0
register (reading 13MHz, as it should be), but the assigned hardware
timers are never started before (or after) booting Linux.

In this condition, any call to function get_cycles() will be returning
zero, as CNTVCT_EL0 will always read zero.

One common critical symptom of that is trying to use the udelay()
function (calling __delay()), which executes the following loop:

            start = get_cycles();
            while ((get_cycles() - start) < cycles)
                    cpu_relax();

which, when CNTVCT_EL0 always reads zero, translates to:

            while((0 - 0) < 0)  ==> while(0 < 0)

... generating an infinite loop, even though zero is never less
than zero, but always equal to it (this has to be researched,
but it's out of the scope of this commit).

To fix this issue on the affected MediaTek platforms, the solution
is to simply start the timers that are designed to be System Timer(s).
These timers, downstream, are called "CPUXGPT" and there is one
timer per CPU core; luckily, it is not necessary to set a start bit
on each CPUX General Purpose Timer, but it's conveniently enough to:
 - Set the clock divider (input = 26MHz, divider = 2, output = 13MHz);
 - Set the ENABLE bit on a global register (starts all CPUX timers).

The only small hurdle with this setup is that it's all done through
the MCUSYS wrapper, where it is needed, for each read or write, to
select a register address (by writing it to an index register) and
then to perform any R/W on a "CON" register.

For example, writing "0x1" to the CPUXGPT register offset 0x4:
- Write 0x4 to mcusys INDEX register
- Write 0x1 to mcusys CON register

Reading from CPUXGPT register offset 0x4:
- Write 0x4 to mcusys INDEX register
- Read mcusys CON register.

Finally, starting this timer makes platforms affected by this issue
to work correctly.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clocksource/timer-mediatek.c | 119 +++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 7bcb4a3f26fb..a3e90047f9ac 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -22,6 +22,19 @@
 
 #define TIMER_SYNC_TICKS        (3)
 
+/* cpux mcusys wrapper */
+#define CPUX_CON_REG		0x0
+#define CPUX_IDX_REG		0x4
+
+/* cpux */
+#define CPUX_IDX_GLOBAL_CTRL	0x0
+ #define CPUX_ENABLE		BIT(0)
+ #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
+ #define CPUX_CLK_DIV1		BIT(8)
+ #define CPUX_CLK_DIV2		BIT(9)
+ #define CPUX_CLK_DIV4		BIT(10)
+#define CPUX_IDX_GLOBAL_IRQ	0x30
+
 /* gpt */
 #define GPT_IRQ_EN_REG          0x00
 #define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
@@ -72,6 +85,57 @@
 
 static void __iomem *gpt_sched_reg __read_mostly;
 
+static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	return readl(timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	writel(val, timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_disable_irq(struct timer_of *to)
+{
+	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
+	u32 val;
+
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
+	val &= ~(*irq_mask);
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
+}
+
+static void mtk_cpux_enable_irq(struct timer_of *to)
+{
+	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
+	u32 val;
+
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
+	val |= *irq_mask;
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
+}
+
+static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	/* Clear any irq */
+	mtk_cpux_disable_irq(to_timer_of(clkevt));
+
+	/*
+	 * Disabling CPUXGPT timer will crash the platform, especially
+	 * if Trusted Firmware is using it (usually, for sleep states),
+	 * so we only mask the IRQ and call it a day.
+	 */
+	return 0;
+}
+
+static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
+{
+	mtk_cpux_enable_irq(to_timer_of(clkevt));
+	return 0;
+}
+
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
@@ -281,6 +345,60 @@ static struct timer_of to = {
 	},
 };
 
+static int __init mtk_cpux_init(struct device_node *node)
+{
+	static struct timer_of to_cpux;
+	u32 freq, val;
+	int ret;
+
+	/*
+	 * There are per-cpu interrupts for the CPUX General Purpose Timer
+	 * but since this timer feeds the AArch64 System Timer we can rely
+	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
+	 */
+	to_cpux.flags = TIMER_OF_BASE | TIMER_OF_CLOCK;
+	to_cpux.clkevt.name = "mtk-cpuxgpt";
+	to_cpux.clkevt.rating = 10;
+	to_cpux.clkevt.cpumask = cpu_possible_mask;
+	to_cpux.clkevt.set_state_shutdown = mtk_cpux_clkevt_shutdown;
+	to_cpux.clkevt.tick_resume = mtk_cpux_clkevt_resume;
+
+	/* If this fails, bad things are about to happen... */
+	ret = timer_of_init(node, &to_cpux);
+	if (ret) {
+		WARN(1, "Cannot start CPUX timers.\n");
+		return ret;
+	}
+
+	/*
+	 * Check if we're given a clock with the right frequency for this
+	 * timer, otherwise warn but keep going with the setup anyway, as
+	 * that makes it possible to still boot the kernel, even though
+	 * it may not work correctly (random lockups, etc).
+	 * The reason behind this is that having an early UART may not be
+	 * possible for everyone and this gives a chance to retrieve kmsg
+	 * for eventual debugging even on consumer devices.
+	 */
+	freq = timer_of_rate(&to_cpux);
+	if (freq > 13000000)
+		WARN(1, "Requested unsupported timer frequency %u\n", freq);
+
+	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+	val &= ~CPUX_CLK_DIV_MASK;
+	val |= CPUX_CLK_DIV2;
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+
+	/* Enable all CPUXGPT timers */
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+
+	clockevents_config_and_register(&to_cpux.clkevt, timer_of_rate(&to_cpux),
+					TIMER_SYNC_TICKS, 0xffffffff);
+
+	return 0;
+}
+
 static int __init mtk_syst_init(struct device_node *node)
 {
 	int ret;
@@ -339,3 +457,4 @@ static int __init mtk_gpt_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
 TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
+TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
-- 
2.35.1

