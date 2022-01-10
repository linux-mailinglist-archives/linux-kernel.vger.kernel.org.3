Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE796489919
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiAJNBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:01:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42766 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiAJM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:59:55 -0500
Date:   Mon, 10 Jan 2022 12:59:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcwCfiu/fiSGKnBT2ZOYS66fD907lvVbHbp9ziG1DMA=;
        b=Y/mPzwyhiulO8cbGfyJNNMkSXDDQOUuhqDCOWc6nUNoZFpHKSELHcwkSLtJg2elivJZDP4
        ZzW8+BNFo+K7ZrP8DQPRWvF1okxEOXvoiAUNLPvvqBh1J2Q+tAXrisC6R9Z5x7fNLo0qT/
        vnQbzexXkk7oP//D/mktfnumLr3HHL2/jFoqH4jAfD3iXAPr0pM2wV05JfwwHFCrC+rSKO
        bPBdrXucluhfWFSIxJSV9hBp0Hz2RFSo5RD1sPf/IXEdeFJE8TryBiYYSAQQRpIV7JeDWJ
        Da5sHaf1nmLNT4b3xKbC8rSqPixABXa7oYAiVSA0KaHEOOJJ48AVai9iMKOJpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcwCfiu/fiSGKnBT2ZOYS66fD907lvVbHbp9ziG1DMA=;
        b=iBwIgCHZ1ZDxV80u0uZBeZvwOUUnYcjgFVpTSBelgSYjLUW6lQyTWq/4+FBqkxTFldS/V7
        du+yVJhFt8KHv1Cw==
From:   "tip-bot2 for Romain Perier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/msc313e: Add support for
 ssd20xd-based platforms
Cc:     Romain Perier <romain.perier@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211217195727.8955-3-romain.perier@gmail.com>
References: <20211217195727.8955-3-romain.perier@gmail.com>
MIME-Version: 1.0
Message-ID: <164181959194.16921.8949016580691527548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e64da64f410cf4f9697e25ab76cdfc679f4fb6db
Gitweb:        https://git.kernel.org/tip/e64da64f410cf4f9697e25ab76cdfc679f4fb6db
Author:        Romain Perier <romain.perier@gmail.com>
AuthorDate:    Fri, 17 Dec 2021 20:57:23 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 20 Dec 2021 13:28:39 +01:00

clocksource/drivers/msc313e: Add support for ssd20xd-based platforms

On SSD20X family SoCs the timers are connected to a 432MHz clock instead
of 12MHz that all the previous chips used. There is no way to reduce or
divide these clocks in the clktree yet as we do not know exactly where
the 432MHz clock comes from but it is enabled at boot.

The SSD20X timers have an input clock divider within the timer itself
to configure the frequency. timer0 is preconfigured at power up to run
at 12MHz so it is backwards compatible and doesn't need special handling
right now. timer1 and timer2 run at 432Mhz at power up so are not
backward compatible.

This commit adds support for the input clock divider register and sets
timer1 and timer2 to run at 48Mhz for clockevents.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Link: https://lore.kernel.org/r/20211217195727.8955-3-romain.perier@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-msc313e.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/timer-msc313e.c b/drivers/clocksource/timer-msc313e.c
index 154e734..54c54ca 100644
--- a/drivers/clocksource/timer-msc313e.c
+++ b/drivers/clocksource/timer-msc313e.c
@@ -33,7 +33,9 @@
 #define MSC313E_REG_TIMER_MAX_HIGH	0x0c
 #define MSC313E_REG_COUNTER_LOW		0x10
 #define MSC313E_REG_COUNTER_HIGH	0x14
+#define MSC313E_REG_TIMER_DIVIDE	0x18
 
+#define MSC313E_CLK_DIVIDER		9
 #define TIMER_SYNC_TICKS		3
 
 #ifdef CONFIG_ARM
@@ -179,6 +181,12 @@ static int __init msc313e_clkevt_init(struct device_node *np)
 	if (ret)
 		return ret;
 
+	if (of_device_is_compatible(np, "sstar,ssd20xd-timer")) {
+		to->of_clk.rate = clk_get_rate(to->of_clk.clk) / MSC313E_CLK_DIVIDER;
+		to->of_clk.period = DIV_ROUND_UP(to->of_clk.rate, HZ);
+		writew(MSC313E_CLK_DIVIDER - 1, timer_of_base(to) + MSC313E_REG_TIMER_DIVIDE);
+	}
+
 	msc313e_clkevt.cpumask = cpu_possible_mask;
 	msc313e_clkevt.irq = to->of_irq.irq;
 	to->clkevt = msc313e_clkevt;
@@ -242,3 +250,4 @@ static int __init msc313e_timer_init(struct device_node *np)
 }
 
 TIMER_OF_DECLARE(msc313, "mstar,msc313e-timer", msc313e_timer_init);
+TIMER_OF_DECLARE(ssd20xd, "sstar,ssd20xd-timer", msc313e_timer_init);
