Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB7504774
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbiDQKB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiDQKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:01:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F35C03
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 02:59:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650189555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W1m8VLfjzQK90MyhsuL33nF8VtSdralMAdK05ScJcC0=;
        b=PDFlTQfM2fsq9CVTz11u7J9taJm3QKMeEc3VchYJ9gfJ/iRpQ3OpDgqZNqoCby7BCW1gp4
        oUDqpBqN3S9/52Fmanx2doouaS6I/Mkgjowy/xEYCMuBl6fXZkA5zlZryp196J+a7L1SDH
        yPBnVNvPGcvTHI37tpUrlsZpIUw+FAp9VnbXAOwb/9D300n2taIPVy0qMLOAyrBXFxrPit
        YWzyv3rxdh9NBpAjMgLpTMpdOf8H0g34eW+vz7xFWoGNun3H04gJ+fXyzYrR+hHnuzIyf4
        EiP0CiydqhQAYflccl6glsl3OVc63Ay7IJpKNKTIllgyMcZ3JGKM9fxMthpNWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650189555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W1m8VLfjzQK90MyhsuL33nF8VtSdralMAdK05ScJcC0=;
        b=aYJwx9qgEpYZMR3OI0VJMjkuqpbgaddmMc0Wf43yxfT7ktqke4EF8pXHuL6Is0yu9nrx35
        Ca28yBkg0xuJ/SCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.18-rc3
References: <165018953450.44773.6382828227632028472.tglx@xen13>
Message-ID: <165018953738.44773.8160831624072143061.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 17 Apr 2022 11:59:14 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
22-04-17

up to:  9c95bc25ad3b: tick/sched: Fix non-kernel-doc comment


A small set of fixes for the timers core:

  - Fix the warning condition in __run_timers() which does not take into
    account, that a CPU base (especially the deferrable base) has never a
    timer armed on it and therefore the next_expiry value can become stale.

  - Replace a WARN_ON() in the NOHZ code with a WARN_ON_ONCE() to prevent
    endless spam in dmesg.

  - Remove the double star from a comment which is not meant to be in
    kernel-doc format.


Thanks,

	tglx

------------------>
Anna-Maria Behnsen (1):
      timers: Fix warning condition in __run_timers()

Jiapeng Chong (1):
      tick/sched: Fix non-kernel-doc comment

Paul Gortmaker (1):
      tick/nohz: Use WARN_ON_ONCE() to prevent console saturation


 kernel/time/tick-sched.c |  6 +++---
 kernel/time/timer.c      | 11 +++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2d76c91b85de..d257721c68b8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -188,7 +188,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, kt=
ime_t now)
 	 */
 	if (unlikely(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
-		WARN_ON(tick_nohz_full_running);
+		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
 		tick_do_timer_cpu =3D cpu;
 	}
@@ -1538,7 +1538,7 @@ void tick_cancel_sched_timer(int cpu)
 }
 #endif
=20
-/**
+/*
  * Async notification about clocksource changes
  */
 void tick_clock_notify(void)
@@ -1559,7 +1559,7 @@ void tick_oneshot_notify(void)
 	set_bit(0, &ts->check_clocks);
 }
=20
-/**
+/*
  * Check, if a change happened, which makes oneshot possible.
  *
  * Called cyclic from the hrtimer softirq (driven by the timer
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021ad459..9dd2a39cb3b0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1722,11 +1722,14 @@ static inline void __run_timers(struct timer_base *ba=
se)
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels =3D collect_expired_timers(base, heads);
 		/*
-		 * The only possible reason for not finding any expired
-		 * timer at this clk is that all matching timers have been
-		 * dequeued.
+		 * The two possible reasons for not finding any expired
+		 * timer at this clk are that all matching timers have been
+		 * dequeued or no timer has been queued since
+		 * base::next_expiry was set to base::clk +
+		 * NEXT_TIMER_MAX_DELTA.
 		 */
-		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
+		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
+			     && base->timers_pending);
 		base->clk++;
 		base->next_expiry =3D __next_timer_interrupt(base);
=20

