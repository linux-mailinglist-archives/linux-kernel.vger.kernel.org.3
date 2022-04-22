Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D150B613
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447072AbiDVLXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446980AbiDVLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CE1D5370D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650626457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NXA1fGNBDrS3qL6VbkEQlKT5m57X+jj9VzGQYmAhbNA=;
        b=e5iHZcRa03MDsACAMSeAaAQP8cS33eYh376hSJuPXR+XWnONw5/SRz6Wq7PusRlay9nj/v
        RU5Bq72pD7Xp4DLaZ3Vl4IuR53qIZA4QJIJLtXN3nDh0+T2nlzjfagT6i7dwgKXT7z7P1b
        P56ql4ONvkpQrDsJMcv3XQXqPpjK55g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-K--GsoDxP3CTu7pt9jeFzQ-1; Fri, 22 Apr 2022 07:20:56 -0400
X-MC-Unique: K--GsoDxP3CTu7pt9jeFzQ-1
Received: by mail-wm1-f72.google.com with SMTP id p31-20020a05600c1d9f00b0038ed0964a90so3645683wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXA1fGNBDrS3qL6VbkEQlKT5m57X+jj9VzGQYmAhbNA=;
        b=TR71dLz+wdw5i1VW8RdM3Xnl0/5lecaJg/xiWtzA23OLoSUr8cZf6A/W5PPY3qMUzT
         xHBt5yHvikt98hTJKwCFDS73xxSv1Sq2w6pkZ1ua4PfH4NxS+rS/ZWpAGFvoOUjQjkKb
         dmF3qr4YwOfPFU5/ovIgM7j1bOmNGRjP5FqYJx5R+SBbq9Bg++5wcinIkHsKaAZsRUHv
         0RDTNkpOrXBmg1NSt6EqP106dFJmC+Wzoo+2Uei24lbM5EbOSGwKhSD0aHjyYvZjfUyy
         aBwoUGEZj8SES5OZEysfHICkia/bptgniAMHPCLeyY1S5hrvJD8/zuu9WsYttajekgvO
         ijBw==
X-Gm-Message-State: AOAM532OoAD0ZWSSTIBVZtOaaIDq2L4cBLHNTVQ8lSMxgO0ywdZadkS8
        DkbWOIxreR0BDTWrXQhcbiDLlSGmlnWJig6dCsp6dUn345qiGaPwGcJ+ruW/9/E764ewS50o5YA
        dCGZU4Y8Df+HxnULBKq91IZw=
X-Received: by 2002:a1c:3b87:0:b0:38e:ae26:87c3 with SMTP id i129-20020a1c3b87000000b0038eae2687c3mr3746848wma.117.1650626455275;
        Fri, 22 Apr 2022 04:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8QI4l3w8Xtxl0vltlddGtksedQQtGJiNLmdjW9VR/fQPdNRVH2qF4ty6+72+PvbFzSYt2FA==
X-Received: by 2002:a1c:3b87:0:b0:38e:ae26:87c3 with SMTP id i129-20020a1c3b87000000b0038eae2687c3mr3746832wma.117.1650626455031;
        Fri, 22 Apr 2022 04:20:55 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r184-20020a1c2bc1000000b00392af6f0ab0sm1485145wmr.18.2022.04.22.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:20:54 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v2] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Fri, 22 Apr 2022 12:20:53 +0100
Message-Id: <20220422112053.3695526-1-atomlin@redhat.com>
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

The only change since RFC v1 [1] is an alternative approach to hopefully
resolve the second scenario [2] without disturbing the workload via an
interrupt. Any feedback/or testing would be appreciated. Thanks!

[1]: https://lore.kernel.org/lkml/20220203214339.1889971-1-atomlin@redhat.com/
[2]: https://lore.kernel.org/lkml/20220217163205.GA748087@lothringen/


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

So the idea of this patch is to ensure refresh_cpu_vm_stats(false) is
called (when it is appropriate) on return to the idle loop when the idle
tick was previously stopped too. Additionally, when the scheduling-tick
is stopped and a task in kernel-mode, modifies the CPU-specific
'vm_stat_diff[]' and goes to user-mode for a long time.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/tick.h     | 9 ++++++++-
 kernel/time/tick-sched.c | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..7bd25266712c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -307,8 +307,15 @@ static inline void tick_nohz_task_switch(void)
 
 static inline void tick_nohz_user_enter_prepare(void)
 {
-	if (tick_nohz_full_cpu(smp_processor_id()))
+	struct tick_sched *ts;
+
+	if (tick_nohz_full_cpu(smp_processor_id())) {
+		ts = this_cpu_ptr(&tick_cpu_sched);
+
+		if (ts->tick_stopped)
+			quiet_vmstat();
 		rcu_nocb_flush_deferred_wakeup();
+	}
 }
 
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d257721c68b8..56d86d9371b7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -891,6 +891,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		ts->do_timer_last = 0;
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat();
+
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -912,7 +915,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
-- 
2.34.1

