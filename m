Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913B64D7E80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiCNJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiCNJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB24A3F8A3;
        Mon, 14 Mar 2022 02:28:19 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OuXkGyAP7RTj0WjOxzjdW8HyPHfjCrHSJeN3ozUz3FM=;
        b=XXFkvBwIRYwVUEgVYkFFT8iwnxZoJ026nJfUViJMcdevB5M6gjUaXsPMenfAN+MaK+LFLf
        ykDogl6tUGRl0/vwFV1YO5/ybV2udtlLh3x6WvvUvf0AsXMRmCIpWjKwOKMiu0Z5LxJrvN
        FpG70tZH7LymJLM3n0zwn0cnaCpPVpiaLqD5aTfeD0f1rhe5j3vPXKaYEleNRGYGXgyj3v
        Qs+VIojrWrC19bAVcCyakYtBbzuudEOmS6q+cC9A0XctBK1TguqqnTN17x+KXr9gpHnRND
        RnGnX44UIiI2wnXuinRWZ66zNFrj4V7v876W+fiZTvjA+K2xEwOZ4CNccUOCCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OuXkGyAP7RTj0WjOxzjdW8HyPHfjCrHSJeN3ozUz3FM=;
        b=Ph3kauVUIjt+ga/rNENNgsiP4xKVDhlTST6o4telu9kSl60ECbk0ncvbeMr1OKo0ubYomR
        mP2+VIGCDPaButAg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Detect and fix jiffies update stall
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164725009728.16921.14131316005907895212.tip-bot2@tip-bot2>
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

Commit-ID:     a1ff03cd6fb9c501fff63a4a2bface9adcfa81cd
Gitweb:        https://git.kernel.org/tip/a1ff03cd6fb9c501fff63a4a2bface9adcfa81cd
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 02 Feb 2022 01:01:07 +01:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 07 Mar 2022 23:01:19 +01:00

tick: Detect and fix jiffies update stall

On some rare cases, the timekeeper CPU may be delaying its jiffies
update duty for a while. Known causes include:

* The timekeeper is waiting on stop_machine in a MULTI_STOP_DISABLE_IRQ
  or MULTI_STOP_RUN state. Disabled interrupts prevent from timekeeping
  updates while waiting for the target CPU to complete its
  stop_machine() callback.

* The timekeeper vcpu has VMEXIT'ed for a long while due to some overload
  on the host.

Detect and fix these situations with emergency timekeeping catchups.

Original-patch-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c | 17 +++++++++++++++++
 kernel/time/tick-sched.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 17a283c..c89f50a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -169,6 +169,8 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
 
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
@@ -196,6 +198,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
+	/*
+	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * or VMEXIT'ed for several msecs), force an update.
+	 */
+	if (ts->last_tick_jiffies != jiffies) {
+		ts->stalled_jiffies = 0;
+		ts->last_tick_jiffies = READ_ONCE(jiffies);
+	} else {
+		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
+			tick_do_update_jiffies64(now);
+			ts->stalled_jiffies = 0;
+			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		}
+	}
+
 	if (ts->inidle)
 		ts->got_idle_tick = 1;
 }
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index d952ae3..5046495 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -49,6 +49,8 @@ enum tick_nohz_mode {
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @next_timer:		Expiry time of next expiring timer for debugging purpose only
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -77,6 +79,8 @@ struct tick_sched {
 	u64				next_timer;
 	ktime_t				idle_expires;
 	atomic_t			tick_dep_mask;
+	unsigned long			last_tick_jiffies;
+	unsigned int			stalled_jiffies;
 };
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
