Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B914D7EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiCNJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiCNJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B63527A;
        Mon, 14 Mar 2022 02:28:30 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbEI+i1ivALBIfpj7UkIC6yTADjTScQ2xKx34kea2QU=;
        b=XH9c3/LWFRNwVsj3Oq6r/Gyazx85BgBad4cHLidwQe0g748qK5rD+EXG3VKvD/ZkUZ5wgt
        pVlk+qKyto4I5yFf4+4N+Xq6kkm5wYjJkF0ApxRFOZiIAie+y3w09+2LGTnCS/sWQo0AXE
        QUn745e42+NXzladxhOPvoa2vzbtFIGZOFrfdpcBsYcWesNXvU+1wk+MsB0P/8UFVA4qFZ
        AFYiEAd5hvqYoZ3BbHx9ep00cXIUXS3J8++DLCIETObvPTk2VBbA0rICa/jUHd25Fh8NZR
        qArNaHxXtlewf36iTXxwqzx7m2Z5ell/BHjyDxU+kZCsuhoJq4Xk+LGOsFlSbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250109;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbEI+i1ivALBIfpj7UkIC6yTADjTScQ2xKx34kea2QU=;
        b=aoBzFI64KM8glWfbU+bfPXiRu3V7E0d2iIG7PIAuukYTN7zfSfI/MDAVSTAH7mL8nCra9J
        ckF5iRdZSbJvttCw==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Handle DTS with
 higher number of interrupts
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220220103815.135380-1-krzysztof.kozlowski@canonical.com>
References: <20220220103815.135380-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <164725010846.16921.7067111417542311406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ab8da93dc06d82f464c47ab30e6c75190702f369
Gitweb:        https://git.kernel.org/tip/ab8da93dc06d82f464c47ab30e6c75190702f369
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Sun, 20 Feb 2022 11:38:15 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

clocksource/drivers/exynos_mct: Handle DTS with higher number of interrupts

The driver statically defines maximum number of interrupts it can
handle, however it does not respect that limit when configuring them.
When provided with a DTS with more interrupts than assumed, the driver
will overwrite static array mct_irqs leading to silent memory
corruption.

Validate the interrupts coming from DTS to avoid this.  This does not
change the fact that such DTS might not boot at all, because it is
simply incompatible, however at least some warning will be printed.

Fixes: 36ba5d527e95 ("ARM: EXYNOS: add device tree support for MCT controller driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20220220103815.135380-1-krzysztof.kozlowski@canonical.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 6db3d55..03782b3 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -541,6 +541,11 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	 * irqs are specified.
 	 */
 	nr_irqs = of_irq_count(np);
+	if (nr_irqs > ARRAY_SIZE(mct_irqs)) {
+		pr_err("exynos-mct: too many (%d) interrupts configured in DT\n",
+			nr_irqs);
+		nr_irqs = ARRAY_SIZE(mct_irqs);
+	}
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
@@ -553,11 +558,14 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 		     mct_irqs[MCT_L0_IRQ], err);
 	} else {
 		for_each_possible_cpu(cpu) {
-			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
+			int mct_irq;
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
 
 			pcpu_mevt->evt.irq = -1;
+			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
+				break;
+			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
 
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
