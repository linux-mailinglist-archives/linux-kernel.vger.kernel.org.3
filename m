Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFC5489928
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiAJNCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiAJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70ADC061751;
        Mon, 10 Jan 2022 05:00:03 -0800 (PST)
Date:   Mon, 10 Jan 2022 13:00:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1AuXnZew9XqCqBDDfGs9K6JP9a5fJalwsLVipNrM/s=;
        b=vr+ghMHRIiRWMfdHnTIKYWv0NqCMjMv5m+zNFY6ehMVjLE4am6rij25cW7qQ19ilRaI4Bt
        sYY1RdHa0FAbyBlLUKHsmUwQmT4SzE8+yASpyaoTMG2CUro96dKYecvHd1o61z1nfeSOhG
        gpwPMbzgqBlmQDmaBJE6i0bwk6Vsvdim/ajnr3daaVcTQdgpE1cz9d0YiDDD7MXVYCFr4A
        WIG5qyDmfpvIY9hpRhYsP+n3GNND4Mh9QRS+bDPK1qVsmalYOOJfKmtY4ZhOMynSAo7DVX
        k9FZaz4F+rhlLjlIwvF7duYXaAqDXi5KuFYJlis6+p6hlLrcV3dN4j4RRUWlVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1AuXnZew9XqCqBDDfGs9K6JP9a5fJalwsLVipNrM/s=;
        b=Ocl++1udgR7FZeghIZskIUyoCsQzgXbDQ77/nhNI9pWDjmabmDVTk9YFNVSJWeIRmE5Dc/
        sqNQICw9m5LBvABg==
From:   "tip-bot2 for Marek Szyprowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Refactor resources
 allocation
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211101193531.15078-2-semen.protsenko@linaro.org>
References: <20211101193531.15078-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Message-ID: <164181960085.16921.10867646157884848899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7cd925a8823d16de5614d3f0aabea9948747accd
Gitweb:        https://git.kernel.org/tip/7cd925a8823d16de5614d3f0aabea9948747accd
Author:        Marek Szyprowski <m.szyprowski@samsung.com>
AuthorDate:    Mon, 01 Nov 2021 21:35:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 16 Nov 2021 16:12:00 +01:00

clocksource/drivers/exynos_mct: Refactor resources allocation

Move interrupts allocation from exynos4_timer_resources() into separate
function together with the interrupt number parsing code from
mct_init_dt(), so the code for managing interrupts is kept together.
While touching exynos4_timer_resources() function, move of_iomap() to it.
No functional changes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Link: https://lore.kernel.org/r/20211101193531.15078-2-semen.protsenko@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 50 ++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 5e3e96d..857cf12 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -504,11 +504,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
+static int __init exynos4_timer_resources(struct device_node *np)
 {
-	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: unable to ioremap mct address space\n", __func__);
+
 	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
@@ -519,9 +522,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
 
-	reg_base = base;
-	if (!reg_base)
-		panic("%s: unable to ioremap mct address space\n", __func__);
+	return 0;
+}
+
+static int __init exynos4_timer_interrupts(struct device_node *np,
+					   unsigned int int_type)
+{
+	int nr_irqs, i, err, cpu;
+
+	mct_int_type = int_type;
+
+	/* This driver uses only one global timer interrupt */
+	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
+
+	/*
+	 * Find out the number of local irqs specified. The local
+	 * timer irqs are specified after the four global timer
+	 * irqs are specified.
+	 */
+	nr_irqs = of_irq_count(np);
+	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
+		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
 	if (mct_int_type == MCT_INT_PPI) {
 
@@ -581,24 +602,13 @@ out_irq:
 
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
-	u32 nr_irqs, i;
 	int ret;
 
-	mct_int_type = int_type;
-
-	/* This driver uses only one global timer interrupt */
-	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
-
-	/*
-	 * Find out the number of local irqs specified. The local
-	 * timer irqs are specified after the four global timer
-	 * irqs are specified.
-	 */
-	nr_irqs = of_irq_count(np);
-	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
-		mct_irqs[i] = irq_of_parse_and_map(np, i);
+	ret = exynos4_timer_resources(np);
+	if (ret)
+		return ret;
 
-	ret = exynos4_timer_resources(np, of_iomap(np, 0));
+	ret = exynos4_timer_interrupts(np, int_type);
 	if (ret)
 		return ret;
 
