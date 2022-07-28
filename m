Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD0583C61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiG1Kpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbiG1Kou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8466121;
        Thu, 28 Jul 2022 03:44:18 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUijbmuihWTeVNbA5g9DMVIAYjdoHnt02Ca1Ax6ff94=;
        b=Yu7C1wUl+SQiJCTHYlgT52JIvpguVQXSScArsPm/16qjhnpV8jJuhBYyOCcK7YYaMB1H4p
        AEo8EwnbXFpQsI1f6QK102XF2hc/iz0MyHOH4S04vNPOXeOodqVDf9s4kVqrB+9E/RrWuN
        7TlPOY5EkA0sXt9JdbtSDA/mFgJum5xzk3P8BOpySBRJ7IKhpbmjbW6PdmV24VCGxgHXzt
        1Pj9Sk2XJDsEQLPFLN59Bbh+MkR5hq5ruEej2ARw3NoqTDFPhebnkBoGfRn8PD8RynCKMR
        mtCA+1i9pf9/bu1Bn5Mi4ZtZkAQCXy0zH+gNN3vKp60gUC9cT46ye4fbJMz2+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUijbmuihWTeVNbA5g9DMVIAYjdoHnt02Ca1Ax6ff94=;
        b=G0D/pXdP7L3v9yAgv8u5/wDwCsSgkSHZwyWwOlLsxnQC6Rt/vzEduRslyvC8/19+r8Z1/C
        6dQTNFjftJdLA3CQ==
From:   "tip-bot2 for AngeloGioacchino Del Regno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-mediatek: Implement
 CPUXGPT timers
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220613133819.35318-3-angelogioacchino.delregno@collabora.com>
References: <20220613133819.35318-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Message-ID: <165900505519.15455.11392750629016215652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     327e93cf9a59b0d04eb3a31a7fdbf0f11cf13ecb
Gitweb:        https://git.kernel.org/tip/327e93cf9a59b0d04eb3a31a7fdbf0f11cf13ecb
Author:        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
AuthorDate:    Mon, 13 Jun 2022 15:38:19 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:41:51 +02:00

clocksource/drivers/timer-mediatek: Implement CPUXGPT timers

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
Link: https://lore.kernel.org/r/20220613133819.35318-3-angelogioacchino.delregno@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-mediatek.c | 114 ++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index 7bcb4a3..d5b29fd 100644
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
@@ -72,6 +85,52 @@
 
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
+static void mtk_cpux_set_irq(struct timer_of *to, bool enable)
+{
+	const unsigned long *irq_mask = cpumask_bits(cpu_possible_mask);
+	u32 val;
+
+	val = mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
+
+	if (enable)
+		val |= *irq_mask;
+	else
+		val &= ~(*irq_mask);
+
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
+}
+
+static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	/* Clear any irq */
+	mtk_cpux_set_irq(to_timer_of(clkevt), false);
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
+	mtk_cpux_set_irq(to_timer_of(clkevt), true);
+	return 0;
+}
+
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
@@ -281,6 +340,60 @@ static struct timer_of to = {
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
@@ -339,3 +452,4 @@ static int __init mtk_gpt_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
 TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
+TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
