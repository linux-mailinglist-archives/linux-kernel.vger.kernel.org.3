Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935C50E0C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiDYMyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbiDYMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:54:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEB1CB27;
        Mon, 25 Apr 2022 05:50:59 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:50:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650891057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOr8NZGy5gwYgHJYgd46ZelGZZzi7C8Ouk3t0T6VexQ=;
        b=Lh5QGVP4Fb9K6umAzR8PupJ7EJoygkpstwG6+vZXJ6MFcsRQuEskr5U1YWAHO6IyUaDuvl
        JY3WiJzxExvoxGnhZxXDPTNiSBc2kgcktmrwihSTXyI/h8H9nrDeTkdX5hjrbUcK+6y6bn
        zXEIM8SiKZzaaWR1GIIZaxI18t7lvAsEYAIpz8POwEwvYTH1Gh6GKZ0LVn6xCq4XePjrkT
        HAiX0Jh3G/ltrClhG6svZ8F6kztq96WqeaC2MseeurFuy/privhJrTSLJU2iQJHsOyaB46
        VQGauM3XxXU6afdyCSBzeFo5bC5hjpxnKqIpO913j+PWBSLrxpH8lX+fIEHFFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650891057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOr8NZGy5gwYgHJYgd46ZelGZZzi7C8Ouk3t0T6VexQ=;
        b=WoDBts/BZsCdWFYmMC9lXvLOOpxB5Cr6AY2+Qmj4fWOdLrVb5LJFvvlLHlH2gnFjuR/v+W
        6E2TktxWW1LvgdAQ==
From:   "tip-bot2 for Nicholas Piggin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/nohz: Switch to ONESHOT_STOPPED in the
 low-res handler when the tick is stopped
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220422141446.915024-1-npiggin@gmail.com>
References: <20220422141446.915024-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-ID: <165089105607.4207.3022534114716811208.tip-bot2@tip-bot2>
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

Commit-ID:     62c1256d544747b38e77ca9b5bfe3a26f9592576
Gitweb:        https://git.kernel.org/tip/62c1256d544747b38e77ca9b5bfe3a26f9592576
Author:        Nicholas Piggin <npiggin@gmail.com>
AuthorDate:    Sat, 23 Apr 2022 00:14:46 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Apr 2022 14:45:22 +02:00

timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped

When tick_nohz_stop_tick() stops the tick and high resolution timers are
disabled, then the clock event device is not put into ONESHOT_STOPPED
mode. This can lead to spurious timer interrupts with some clock event
device drivers that don't shut down entirely after firing.

Eliminate these by putting the device into ONESHOT_STOPPED mode at points
where it is not being reprogrammed. When there are no timers active, then
tick_program_event() with KTIME_MAX can be used to stop the device. When
there is a timer active, the device can be stopped at the next tick (any
new timer added by timers will reprogram the tick).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220422141446.915024-1-npiggin@gmail.com
---
 kernel/time/tick-sched.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2d76c91..b1b105d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -928,6 +928,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1364,9 +1366,15 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
 
-	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		/*
+		 * The clockevent device is not reprogrammed, so change the
+		 * clock event device to ONESHOT_STOPPED to avoid spurious
+		 * interrupts on devices which might not be truly one shot.
+		 */
+		tick_program_event(KTIME_MAX, 1);
 		return;
+	}
 
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
