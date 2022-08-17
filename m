Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB9597654
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiHQTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiHQTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB5477E87
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660763824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A9mez3un0kb/dY1Y5a1jB6zoEKYBA9P7qIxMNfLm/80=;
        b=az0BSDsR/IN9mTpMhYOIGdfHR8Wr+B+BJN6kcCx1Wp9ud+plaudGWXNDebu+gDI+DpKZHa
        0xEIt2flgmKdHU9p/St/4j4bnl0Q8ljUNQ5ZxpqPTq9jkHIC+6TBQVtcJZVAU235+Rpktm
        xrtM7dWxbhxU+hiZAAmVzm37ZMJN+jI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-nfImuNj6OM-aMEIKQG5DPQ-1; Wed, 17 Aug 2022 15:17:01 -0400
X-MC-Unique: nfImuNj6OM-aMEIKQG5DPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98E6B811E75;
        Wed, 17 Aug 2022 19:17:00 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C17E40149B4;
        Wed, 17 Aug 2022 19:17:00 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 59172416D882; Wed, 17 Aug 2022 16:16:24 -0300 (-03)
Message-ID: <20220817191524.201253713@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 17 Aug 2022 16:13:48 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v7 2/3] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
References: <20220817191346.287594886@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Tomlin <atomlin@redhat.com>

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
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 include/linux/tick.h     |    5 +++--
 kernel/time/tick-sched.c |   19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/tick.h
===================================================================
--- linux-2.6.orig/include/linux/tick.h
+++ linux-2.6/include/linux/tick.h
@@ -11,7 +11,6 @@
 #include <linux/context_tracking_state.h>
 #include <linux/cpumask.h>
 #include <linux/sched.h>
-#include <linux/rcupdate.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -272,6 +271,7 @@ static inline void tick_dep_clear_signal
 
 extern void tick_nohz_full_kick_cpu(int cpu);
 extern void __tick_nohz_task_switch(void);
+void __tick_nohz_user_enter_prepare(void);
 extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
@@ -296,6 +296,7 @@ static inline void tick_dep_clear_signal
 
 static inline void tick_nohz_full_kick_cpu(int cpu) { }
 static inline void __tick_nohz_task_switch(void) { }
+static inline void __tick_nohz_user_enter_prepare(void) { }
 static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
 #endif
 
@@ -308,7 +309,7 @@ static inline void tick_nohz_task_switch
 static inline void tick_nohz_user_enter_prepare(void)
 {
 	if (tick_nohz_full_cpu(smp_processor_id()))
-		rcu_nocb_flush_deferred_wakeup();
+		__tick_nohz_user_enter_prepare();
 }
 
 #endif
Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -26,6 +26,7 @@
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
 
 #include <asm/irq_regs.h>
 
@@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
 	}
 }
 
+void __tick_nohz_user_enter_prepare(void)
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
+EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
+
 /* Get the boot-time nohz CPU list from the kernel parameters. */
 void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 {
@@ -890,6 +905,9 @@ static void tick_nohz_stop_tick(struct t
 		ts->do_timer_last = 0;
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat();
+
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -911,7 +929,6 @@ static void tick_nohz_stop_tick(struct t
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;


