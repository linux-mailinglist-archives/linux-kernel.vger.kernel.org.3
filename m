Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54C587487
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiHAXnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiHAXnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37989474E0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659397388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqrH14f6u4rtPBP7mTrKN6TGeXQ06NPlIMwH+7GumHY=;
        b=M1vbh2kEGPx/eKvcKlcs8tsHK6Phte6uZjXcVAi9MaPaMP8xVGzg5jjeBQt+a8JeLqRpL2
        af/dv5OPbux+dZk4vETJFgOAxoduqRe6yILwjZcp7yTNB1rkYIiEm73OJyb9cKyI4tpTkT
        zlVtWML1sykvo3ulcDel0BkEQaPpePM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-JI3ZNjb4NRil0bg_j-Wxqg-1; Mon, 01 Aug 2022 19:43:07 -0400
X-MC-Unique: JI3ZNjb4NRil0bg_j-Wxqg-1
Received: by mail-wm1-f71.google.com with SMTP id 131-20020a1c0289000000b003a3497306a8so7427255wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 16:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bqrH14f6u4rtPBP7mTrKN6TGeXQ06NPlIMwH+7GumHY=;
        b=brU5kn1WamUdHmTC/7r6l6aE+Dk0EUz9i7ZgGYZR+aPJuMpxHg/aIX5qkJcC+N96nG
         oWnTRXtZNKMZT8m/NBp14i0xbY1ESxX+/7rteHq23eCM6TR/qqqftuMzv+6IkTGnWyFI
         11ZL/0jYwV83HMZzfLdIQxbs5C9lHJFsItF3YINU84IOiGChd9fqrhGE5jLTT8TKwpmM
         E9UnMa7oui0AUCyNBFlmhOmMr0UmobGdgdaJATXMFrhjA9Em2daxwSQroDyeDzTwvnd0
         qBgjrJccnWwK2QxgqGrnttqws9IctSG+jbHW+tgHZcFiUnISlEfDilSVWSbmMWiFNseM
         UIPg==
X-Gm-Message-State: ACgBeo3xnugJDZ7NZymrpn4C/IlY2hWHuakkZSr+L+AqrflMbc1Gr8lI
        avMHEkB8fIktKFAms7Kyk3ybxh3Opz/U+hIFTVrORRR304DED3dZ+e1eGxBgmJCz2rrWNk5CwQa
        31/Y6lLVZ3LZ1WQ4ZpWxETCk=
X-Received: by 2002:a05:6000:1841:b0:21e:fa04:61f4 with SMTP id c1-20020a056000184100b0021efa0461f4mr11433933wri.491.1659397385872;
        Mon, 01 Aug 2022 16:43:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR62sTUIxjyKmfQTaQnIyR3CaV/L2KTymYkPMJZ/SjfCdT+1VJLxYfrbdThjN3//o4rzt26j2Q==
X-Received: by 2002:a05:6000:1841:b0:21e:fa04:61f4 with SMTP id c1-20020a056000184100b0021efa0461f4mr11433927wri.491.1659397385658;
        Mon, 01 Aug 2022 16:43:05 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p15-20020adfce0f000000b0021ee28ff76esm13335489wrn.38.2022.08.01.16.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 16:43:04 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 2/2] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Tue,  2 Aug 2022 00:42:58 +0100
Message-Id: <20220801234258.134609-3-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801234258.134609-1-atomlin@redhat.com>
References: <20220801234258.134609-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the context of the idle task and an adaptive-tick mode/or a nohz_full
CPU, quiet_vmstat() can be called: before stopping the idle tick,
entering an idle state and on exit. In particular, for the latter case,
when the idle task is required to reschedule, the idle tick can remain
stopped and the timer expiration time endless i.e., KTIME_MAX. Now,
indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
counters should be processed to ensure the respective values have been
reset and folded into the zone specific 'vm_stat[]'. That being said, it
can only occur when: the idle tick was previously stopped, and
reprogramming of the timer is not required.

A customer provided some evidence which indicates that the idle tick was
stopped; albeit, CPU-specific vmstat counters still remained populated.
Thus one can only assume quiet_vmstat() was not invoked on return to the
idle loop.

If I understand correctly, I suspect this divergence might erroneously
prevent a reclaim attempt by kswapd. If the number of zone specific free
pages are below their per-cpu drift value then
zone_page_state_snapshot() is used to compute a more accurate view of
the aforementioned statistic.  Thus any task blocked on the NUMA node
specific pfmemalloc_wait queue will be unable to make significant
progress via direct reclaim unless it is killed after being woken up by
kswapd (see throttle_direct_reclaim()).

Consider the following theoretical scenario:

        1.      CPU Y migrated running task A to CPU X that was
                in an idle state i.e. waiting for an IRQ - not
                polling; marked the current task on CPU X to
                need/or require a reschedule i.e., set
                TIF_NEED_RESCHED and invoked a reschedule IPI to
                CPU X (see sched_move_task())

        2.      CPU X acknowledged the reschedule IPI from CPU Y;
                generic idle loop code noticed the
                TIF_NEED_RESCHED flag against the idle task and
                attempts to exit of the loop and calls the main
                scheduler function i.e. __schedule().

                Since the idle tick was previously stopped no
                scheduling-clock tick would occur.
                So, no deferred timers would be handled

        3.      Post transition to kernel execution Task A
                running on CPU Y, indirectly released a few pages
                (e.g. see __free_one_page()); CPU Y's
                'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
                specific 'vm_stat[]' update was deferred as per the
                CPU-specific stat threshold

        4.      Task A does invoke exit(2) and the kernel does
                remove the task from the run-queue; the idle task
                was selected to execute next since there are no
                other runnable tasks assigned to the given CPU
                (see pick_next_task() and pick_next_task_idle())

        5.      On return to the idle loop since the idle tick
                was already stopped and can remain so (see [1]
                below) e.g. no pending soft IRQs, no attempt is
                made to zero and fold CPU Y's vmstat counters
                since reprogramming of the scheduling-clock tick
                is not required/or needed (see [2])

		  ...
		    do_idle
		    {

		      __current_set_polling()
		      tick_nohz_idle_enter()

		      while (!need_resched()) {

			local_irq_disable()

			...

			/* No polling or broadcast event */
			cpuidle_idle_call()
			{

			  if (cpuidle_not_available(drv, dev)) {
			    tick_nohz_idle_stop_tick()
			      __tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched))
			      {
				int cpu = smp_processor_id()

				if (ts->timer_expires_base)
				  expires = ts->timer_expires
				else if (can_stop_idle_tick(cpu, ts))
	      (1) ------->        expires = tick_nohz_next_event(ts, cpu)
				else
				  return

				ts->idle_calls++

				if (expires > 0LL) {

				  tick_nohz_stop_tick(ts, cpu)
				  {

				    if (ts->tick_stopped && (expires == ts->next_tick)) {
	      (2) ------->            if (tick == KTIME_MAX || ts->next_tick ==
					hrtimer_get_expires(&ts->sched_timer))
					return
				    }
				    ...
				  }

So the idea of with this patch is to ensure refresh_cpu_vm_stats(false) is
called, when it is appropriate, on return to the idle loop when the idle
tick was previously stopped too. Additionally, in the context of
nohz_full, when the scheduling-tick is stopped and before exiting
to user-mode, ensure no CPU-specific vmstat differentials remain.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/tick.h     |  9 ++-------
 kernel/time/tick-sched.c | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..4c576c9ca0a2 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -11,7 +11,6 @@
 #include <linux/context_tracking_state.h>
 #include <linux/cpumask.h>
 #include <linux/sched.h>
-#include <linux/rcupdate.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -123,6 +122,8 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
 #define TICK_DEP_MASK_RCU_EXP		(1 << TICK_DEP_BIT_RCU_EXP)
 
+void tick_nohz_user_enter_prepare(void);
+
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
 extern bool tick_nohz_tick_stopped(void);
@@ -305,10 +306,4 @@ static inline void tick_nohz_task_switch(void)
 		__tick_nohz_task_switch();
 }
 
-static inline void tick_nohz_user_enter_prepare(void)
-{
-	if (tick_nohz_full_cpu(smp_processor_id()))
-		rcu_nocb_flush_deferred_wakeup();
-}
-
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 30049580cd62..c7c69a974414 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -26,6 +26,7 @@
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
 
 #include <asm/irq_regs.h>
 
@@ -43,6 +44,20 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 	return &per_cpu(tick_cpu_sched, cpu);
 }
 
+void tick_nohz_user_enter_prepare(void)
+{
+	struct tick_sched *ts;
+
+	if (tick_nohz_full_cpu(smp_processor_id())) {
+		ts = this_cpu_ptr(&tick_cpu_sched);
+
+		if (ts->tick_stopped)
+			quiet_vmstat();
+		rcu_nocb_flush_deferred_wakeup();
+	}
+}
+EXPORT_SYMBOL(tick_nohz_user_enter_prepare);
+
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
  * The time, when the last jiffy update happened. Write access must hold
@@ -890,6 +905,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		ts->do_timer_last = 0;
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat();
+
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -911,7 +929,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
-- 
2.37.1

