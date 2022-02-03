Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D2B4A9023
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355468AbiBCVno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229863AbiBCVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643924623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V8faXE0FFtDTjH9wIDJIv18tEc+YN5rYBGQr/xW2GG0=;
        b=UX+M96+NZlpTUjTkZ/pKVAhKhIcPtL4V+hG06PNDz9q/rExxDJF0S+RM6GR74qIcujnKAp
        AxA3iOIO0z64/mQl443Z+BO+ZGfOutM8+jxmhLVvH9NwAAOdFQ87y0W+ETDDKz2MM3h3Mj
        bsOrlRD8UW5X0+BRaBTPpL169EABGbA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-xCu-gto3NgekPkjMxHVUgw-1; Thu, 03 Feb 2022 16:43:41 -0500
X-MC-Unique: xCu-gto3NgekPkjMxHVUgw-1
Received: by mail-wm1-f72.google.com with SMTP id o3-20020a1c4d03000000b003539520b248so1785872wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8faXE0FFtDTjH9wIDJIv18tEc+YN5rYBGQr/xW2GG0=;
        b=FGppMQgwdatD62jOH+6SOn0X8tCKsi9vjOWYqXKn/oUxrPh3URgaoadOc9pkNUUr0H
         XjCJyQuKHHMoAJCt8n7zUY4JgUyR4eNaZTlA/enB45e2fRaIc3mxp1tM3DqD5phJrlRJ
         qTRjVhyM8YfBrbyDQSPjanMvTY480UxguwjYdqLK6i7VaS23UHtIMNaIJDGpkiq9Jrpn
         frvj0hHhj2+/yO5OFJ6HIst+a0+J4Eqr9kUQuTbDyAMSEiI0iCT5GW5mrRyDBFZ6PeUO
         yzL8o7uwIdSPnyGU5RBO5VsYfbjOV0bGuRIyZcMIdSVb2AnYaBuMXZUak98XgvpaSYZo
         84Yg==
X-Gm-Message-State: AOAM530145sSOEREyxP/2zG8wGrGezCWIiMp6EEbmlGEiL0Z/Y9VkdzH
        Po2WKb48vEC/a+eu/6jdtXnP4gNxsi81AU8enBbrW77jD3mGESM+t3QCkLxc1MvHMz/lMXx1+ZK
        BjPqZTN+Le0ngBqpWCFtuObc=
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr11991450wmb.109.1643924620486;
        Thu, 03 Feb 2022 13:43:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZptB5WgZob+g2GcdQ7EHeO6VOT34UtGxT+EbBSxHmqrqkJpMn7q8FC3oP5bQSmqatxxmpRA==
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr11991440wmb.109.1643924620224;
        Thu, 03 Feb 2022 13:43:40 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n5sm11806wmq.43.2022.02.03.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:43:39 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Thu,  3 Feb 2022 21:43:39 +0000
Message-Id: <20220203214339.1889971-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

If I understand correctly, in the context of the idle task and a nohz_full
CPU, quiet_vmstat() can be called: before stopping the idle tick, entering
an idle state and on exit. In particular, for the latter case, when the
idle task is required to reschedule, the idle tick can remain stopped and
the timer expiration time endless i.e., KTIME_MAX. Now, indeed before a
nohz_full CPU enters an idle state, CPU-specific vmstat counters should
be processed to ensure the respective values have been reset and folded
into the zone specific vm_stat[]. That being said, it can only occur when:
the idle tick was previously stopped, and reprogramming of the timer is not
required.

A customer provided some evidence which indicates that the idle tick was
stopped; albeit, CPU-specific vmstat counters still remained populated.
Thus one can only assume quiet_vmstat() was not invoked on return to the
idle loop.

Unfortunately, I suspect this divergence might erroneously prevent a
reclaim attempt by kswapd. If the number of zone specific free pages are
below their per-cpu drift value then zone_page_state_snapshot() is used to
compute a more accurate view of the aforementioned statistic.
Thus any task blocked on the NUMA node specific pfmemalloc_wait queue will
be unable to make significant progress via direct reclaim unless it is
killed after being woken up by kswapd (see throttle_direct_reclaim()).
That being said, eventually reclaim should give up if the conditions are
correct, no?

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
                vm_stat_diff[NR_FREE_PAGES] was updated and zone
                specific vm_stat[] update was deferred as per the
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


The idea with this patch is to ensure refresh_cpu_vm_stats(false) is called
on return to the idle loop when the idle tick was previously stopped.

Any feedback/or testing would be appreciated.


Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/time/tick-sched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 17a283ce2b20..61874df064b6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -876,6 +876,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		ts->do_timer_last = 0;
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat();
+
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -897,7 +900,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		ts->tick_stopped = 1;
-- 
2.34.1

