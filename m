Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579F150C2B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiDVWNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiDVWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA7C822BE79
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650661141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u7GJtMbCE34QoOXHn+8Ig2ao8hDA4umJBBrgrTadkEM=;
        b=FnwwObot881BqPbMK1L+7pd+aSLf/vY8ly3qZ+wUlOw4Dm6ZiqHCyCB5kFH5E1omZMjp1k
        7dhWBzBMnbjLUEyxGD+l3gNbQdHWXqdoBk3QMOGsJrO117Hd6VnSO8/orVyx5j55MHC2Ur
        CTiTNsUsXzFeYwJBYNnILGTZwIk7C0Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-IbE87w3EPDm_1XE2unYpTQ-1; Fri, 22 Apr 2022 15:36:50 -0400
X-MC-Unique: IbE87w3EPDm_1XE2unYpTQ-1
Received: by mail-wr1-f72.google.com with SMTP id b10-20020adfc74a000000b0020ab029d5edso2273635wrh.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7GJtMbCE34QoOXHn+8Ig2ao8hDA4umJBBrgrTadkEM=;
        b=bt2vdY5pDcmNdUUk8OR/6i6bdwkV481DPIAmoSiY5OypICYxa55ldGdcKzvlHTzLvd
         Okk+C0wAXjUL3FCSVqy6hUlGcmvyUZyYHkhr5wcNNiQWLhEyIxpNpRP4Mp5w9BrpGWbd
         lhlHnftmSakODUn0lb8iggwuWPUvidZ9CbT2zw2SzEOiSIKZJITCCREiKxLxe8aJ8+6M
         d6O0l+IBNlFP+eEfYKHWYJgWC4TQolQCvkPyfxkC18jct2C2Z3Zjf24cfrc/tz7DNToW
         GxrMeMQiYLzXF3eiktGCwhMjUTe9hXbOnUuF+mk8zAd+0eFSZeAXGKCjXmOancWAMhVb
         Mnpw==
X-Gm-Message-State: AOAM533CH7Up6WyinoSpchJgbrFIBzdvlKEKVChLAN73pRbN55klgQg3
        Io2Rt97exmDdKo/d9N1BESJhry6TIZPD7wg2+vHLcynoyvnUrDyVMtS+pSf4mnGYg9en2Fj3k83
        ctoZmB1+PBArt2dkOmmadMRI=
X-Received: by 2002:a05:6000:1b91:b0:207:9869:1dfe with SMTP id r17-20020a0560001b9100b0020798691dfemr4846318wru.689.1650656209468;
        Fri, 22 Apr 2022 12:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweTLHKgey8s+MPWjUCZkTfPrfufQ74d31Z3iIQ1HW/4aGVuUQfGjiIuh9S9A0AahFTbvk78Q==
X-Received: by 2002:a05:6000:1b91:b0:207:9869:1dfe with SMTP id r17-20020a0560001b9100b0020798691dfemr4846306wru.689.1650656209234;
        Fri, 22 Apr 2022 12:36:49 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d598a000000b0020a9493bdddsm2803421wri.40.2022.04.22.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:36:48 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Fri, 22 Apr 2022 20:36:47 +0100
Message-Id: <20220422193647.3808657-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
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

Hi Frederic and Marcelo,

Oops, please ignore RFC Patch v2 [1] since I forgot to compile test - sorry
about that! Any feedback would be appreciated. Thanks.

[1]: https://lore.kernel.org/lkml/20220422112053.3695526-1-atomlin@redhat.com/


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
tick was previously stopped too. Additionally, when the scheduling-tick
is stopped and a task in kernel-mode, modifies the CPU-specific
'vm_stat_diff[]' and goes to user-mode for a long time.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/tick.h     |  9 ++-------
 kernel/time/tick-sched.c | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

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
index d257721c68b8..c6cac2d8e8ed 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -26,6 +26,7 @@
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
 
 #include <asm/irq_regs.h>
 
@@ -43,6 +44,19 @@ struct tick_sched *tick_get_tick_sched(int cpu)
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
+
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
  * The time, when the last jiffy update happened. Write access must hold
@@ -891,6 +905,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		ts->do_timer_last = 0;
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat();
+
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -912,7 +929,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
-- 
2.34.1

