Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469DF583C55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiG1KpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiG1Koe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257306558F;
        Thu, 28 Jul 2022 03:44:16 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6BZ9e/h8EecDhjgWxXbZDHW7zQIJGId9eNRPxRGTT0=;
        b=F0EsYAtejxbHRceBYStSHl/4D5vnBVlEi7sq+8ywNBcHpBSJP0BqFtho3fzEQtbgEb0bTN
        6B4fkEpd/cdW63FpB4Q0ujlXN2Gff14lmUAC7jmI8315iul0SgRC5TfL4+WLGRSxND9Ssf
        FVCc3wzCPAoP0Y5CPNiVridQ2Kh9XjrAhxiakvwEhphYLA/dWl8MivrCDq0TtDRgu+SAt1
        U7m/Blx5sM5SLTKncQFHP7pIea1P2GYy+bhvAk1euTAqTXESpBXN+giAQEzD5bh3q7bSwb
        2tmt1aJQVaQEcgh6iy9QuncqiOcLhciBkTNMTh7CnNXB6KDVZbqeOmfl2d61Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6BZ9e/h8EecDhjgWxXbZDHW7zQIJGId9eNRPxRGTT0=;
        b=Dxz3YOZC+I0xlnnorCwqSGjR0eUuCq9v4DFdRNkNxbuXXEn7jw726PdvsxqZEbMN2Z12JQ
        UOd+D5WMBDYrScDg==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Remove
 suspend/resume ops for ce
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220609094041.1796372-2-claudiu.beznea@microchip.com>
References: <20220609094041.1796372-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <165900505324.15455.10001237218485518496.tip-bot2@tip-bot2>
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

Commit-ID:     2c9c4c9e543de46a8031d5300e3036a3a89bad28
Gitweb:        https://git.kernel.org/tip/2c9c4c9e543de46a8031d5300e3036a3a89bad28
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Thu, 09 Jun 2022 12:40:39 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:52:31 +02:00

clocksource/drivers/timer-microchip-pit64b: Remove suspend/resume ops for ce

Remove suspend and resume ops for clockevent and add set_state_oneshot()
instead. Along with this mchp_pit64b_{suspend, resume}() were called on
proper function to disable/enable clocks. This will allow disabling clocks
for clockevent in case it is not selected as active clockevent.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20220609094041.1796372-2-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-microchip-pit64b.c | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index abce83d..b512593 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -173,7 +173,8 @@ static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (!clockevent_state_detached(cedev))
+		mchp_pit64b_suspend(timer);
 
 	return 0;
 }
@@ -182,35 +183,37 @@ static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
 	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
 			  MCHP_PIT64B_IER_PERIOD);
 
 	return 0;
 }
 
-static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
-					     struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_oneshot(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
+	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_ONE_SHOT,
 			  MCHP_PIT64B_IER_PERIOD);
 
 	return 0;
 }
 
-static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
+					     struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	mchp_pit64b_suspend(timer);
-}
-
-static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
-{
-	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
+	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+			  MCHP_PIT64B_IER_PERIOD);
 
-	mchp_pit64b_resume(timer);
+	return 0;
 }
 
 static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
@@ -395,9 +398,8 @@ static int __init mchp_pit64b_init_clkevt(struct mchp_pit64b_timer *timer,
 	ce->clkevt.rating = 150;
 	ce->clkevt.set_state_shutdown = mchp_pit64b_clkevt_shutdown;
 	ce->clkevt.set_state_periodic = mchp_pit64b_clkevt_set_periodic;
+	ce->clkevt.set_state_oneshot = mchp_pit64b_clkevt_set_oneshot;
 	ce->clkevt.set_next_event = mchp_pit64b_clkevt_set_next_event;
-	ce->clkevt.suspend = mchp_pit64b_clkevt_suspend;
-	ce->clkevt.resume = mchp_pit64b_clkevt_resume;
 	ce->clkevt.cpumask = cpumask_of(0);
 	ce->clkevt.irq = irq;
 
