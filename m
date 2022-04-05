Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E24F2160
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiDECSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiDECSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:18:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B7317A2C2;
        Mon,  4 Apr 2022 18:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EFF8CCE1B74;
        Tue,  5 Apr 2022 01:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C437C340EE;
        Tue,  5 Apr 2022 01:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649120889;
        bh=kq/b6VF1wMSV/+Puxxy8XdTehugTZhED97PZCHZBYu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9jgIrVBhksHbL9ZdPmZqBn9XVWsVHN0AzHOic0nz+08MsWNDHZA+E2mTTUL1++GK
         ms3B+Nh+FntxGjBJcXAug6OwaenRhP2kxCw568lmBJMOfyUwzBPZimPP5olaQKdIom
         a/OoaAa/bKQGCpzifUxA87T/GwRkXJuv80aSk1zdjUaiW4kFyqZ5xYs3E9+KCaR/bJ
         t3E5F5SRD1x2Zzm73n/gygIqufGkT+zsEO0X7R8PdUWK2zkf85uM5YKC2cm7MYsi3J
         nqEbzyILtq1Mdl7w93gI9TPscugaMBy6Fl+AVn5nhQPHrj2g12l3jUsWS1d9pkHzJx
         7gsQa/nNMqRXQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RT][PATCH 2/2] tick: Fix timer storm since introduction of timersd
Date:   Tue,  5 Apr 2022 03:07:52 +0200
Message-Id: <20220405010752.1347437-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405010752.1347437-1-frederic@kernel.org>
References: <20220405010752.1347437-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If timers are pending while the tick is reprogrammed on nohz_mode, the
next expiry is not armed to fire now, it is delayed one jiffy forward
instead so as not to raise an inextinguishable timer storm with such
scenario:

1) IRQ triggers and queue a timer
2) ksoftirqd() is woken up
3) IRQ tail: timer is reprogrammed to fire now
4) IRQ exit
5) TIMER interrupt
6) goto 3)

...all that until we finally reach ksoftirqd.

Unfortunately we are checking the wrong softirq vector bitmask since
timersd kthread has split from ksoftirqd. Timers now have their own
vector state field that must be checked separately. As a result, the
old timer storm is back. This shows up early on boot with extremely long
initcalls:

	[  333.004807] initcall dquot_init+0x0/0x111 returned 0 after 323822879 usecs

and the cause is uncovered with the right trace events showing just
10 microseconds between ticks (~100 000 Hz):

	swapper/-1         1dn.h111 60818582us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415486608
	swapper/-1         1dn.h111 60818592us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415496082
	swapper/-1         1dn.h111 60818601us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415505550
	swapper/-1         1dn.h111 60818611us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415515013
	swapper/-1         1dn.h111 60818620us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415524483
	swapper/-1         1dn.h111 60818630us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415533949
	swapper/-1         1dn.h111 60818639us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415543426
	swapper/-1         1dn.h111 60818649us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415553061
	swapper/-1         1dn.h111 60818658us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415562511

Fix this with checking the right timer vector state from the nohz code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h | 12 ++++++++++++
 kernel/softirq.c          |  7 +------
 kernel/time/tick-sched.c  |  2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e4b8a04e67ce..da248458f4d9 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -607,9 +607,16 @@ extern void raise_softirq(unsigned int nr);
 
 #ifdef CONFIG_PREEMPT_RT
 DECLARE_PER_CPU(struct task_struct *, timersd);
+DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
+
 extern void raise_timer_softirq(void);
 extern void raise_hrtimer_softirq(void);
 
+static inline unsigned int local_pending_timers(void)
+{
+        return __this_cpu_read(pending_timer_softirq);
+}
+
 #else
 static inline void raise_timer_softirq(void)
 {
@@ -620,6 +627,11 @@ static inline void raise_hrtimer_softirq(void)
 {
 	raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
+
+static inline unsigned int local_pending_timers(void)
+{
+        return local_softirq_pending();
+}
 #endif
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 89eb45614af6..c0aef5f760e5 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -625,12 +625,7 @@ static inline void tick_irq_exit(void)
 }
 
 DEFINE_PER_CPU(struct task_struct *, timersd);
-static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
-
-static unsigned int local_pending_timers(void)
-{
-        return __this_cpu_read(pending_timer_softirq);
-}
+DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
 
 static void wake_timersd(void)
 {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 17a283ce2b20..7c359f029b97 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -763,7 +763,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
+	return local_pending_timers() & BIT(TIMER_SOFTIRQ);
 }
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
-- 
2.25.1

