Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228594A909B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 23:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355780AbiBCWWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 17:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229910AbiBCWWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643926961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WZXCmfYPH1b0sC5bDaa2nOw0sCY60s72SBQGAprR8A=;
        b=LRsDBkroHKMdZbO4Et3S2jpY+yqDig1IGkHD89mhSBrpJZshQTnWldyOZQK2E0jaQcCBi+
        FvS9d3XN5NbC9rEqog6Qc8aO7KAi9AkOY9zole5+kuWYglZAG+3jQnzIcJYALffa2y4iLr
        wX3JkqHMCcoF5SSB0vFMuhesWFYM4BY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-CPurr6fdM_ScSM3zQkn1uQ-1; Thu, 03 Feb 2022 17:22:38 -0500
X-MC-Unique: CPurr6fdM_ScSM3zQkn1uQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E8F683DD23;
        Thu,  3 Feb 2022 22:22:37 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADF165ED43;
        Thu,  3 Feb 2022 22:22:30 +0000 (UTC)
Date:   Thu, 3 Feb 2022 17:22:28 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        atomlin@atomlin.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <YfxVpEO+UJTC+a9e@lorien.usersys.redhat.com>
References: <20220203214339.1889971-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203214339.1889971-1-atomlin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On Thu, Feb 03, 2022 at 09:43:39PM +0000 Aaron Tomlin wrote:
> Hi Frederic,
> 
> If I understand correctly, in the context of the idle task and a nohz_full
> CPU, quiet_vmstat() can be called: before stopping the idle tick, entering
> an idle state and on exit. In particular, for the latter case, when the
> idle task is required to reschedule, the idle tick can remain stopped and
> the timer expiration time endless i.e., KTIME_MAX. Now, indeed before a
> nohz_full CPU enters an idle state, CPU-specific vmstat counters should
> be processed to ensure the respective values have been reset and folded
> into the zone specific vm_stat[]. That being said, it can only occur when:
> the idle tick was previously stopped, and reprogramming of the timer is not
> required.
> 
> A customer provided some evidence which indicates that the idle tick was
> stopped; albeit, CPU-specific vmstat counters still remained populated.
> Thus one can only assume quiet_vmstat() was not invoked on return to the
> idle loop.
> 
> Unfortunately, I suspect this divergence might erroneously prevent a
> reclaim attempt by kswapd. If the number of zone specific free pages are
> below their per-cpu drift value then zone_page_state_snapshot() is used to
> compute a more accurate view of the aforementioned statistic.
> Thus any task blocked on the NUMA node specific pfmemalloc_wait queue will
> be unable to make significant progress via direct reclaim unless it is
> killed after being woken up by kswapd (see throttle_direct_reclaim()).
> That being said, eventually reclaim should give up if the conditions are
> correct, no?
> 
> Consider the following theoretical scenario:
> 
>         1.      CPU Y migrated running task A to CPU X that was
>                 in an idle state i.e. waiting for an IRQ - not
>                 polling; marked the current task on CPU X to
>                 need/or require a reschedule i.e., set
>                 TIF_NEED_RESCHED and invoked a reschedule IPI to
>                 CPU X (see sched_move_task())
> 
>         2.      CPU X acknowledged the reschedule IPI from CPU Y;
>                 generic idle loop code noticed the
>                 TIF_NEED_RESCHED flag against the idle task and
>                 attempts to exit of the loop and calls the main
>                 scheduler function i.e. __schedule().
> 
>                 Since the idle tick was previously stopped no
>                 scheduling-clock tick would occur.
>                 So, no deferred timers would be handled
> 
>         3.      Post transition to kernel execution Task A
>                 running on CPU Y, indirectly released a few pages
>                 (e.g. see __free_one_page()); CPU Y's
>                 vm_stat_diff[NR_FREE_PAGES] was updated and zone
>                 specific vm_stat[] update was deferred as per the
>                 CPU-specific stat threshold
> 
>         4.      Task A does invoke exit(2) and the kernel does
>                 remove the task from the run-queue; the idle task
>                 was selected to execute next since there are no
>                 other runnable tasks assigned to the given CPU
>                 (see pick_next_task() and pick_next_task_idle())
> 
>         5.      On return to the idle loop since the idle tick
>                 was already stopped and can remain so (see [1]
>                 below) e.g. no pending soft IRQs, no attempt is
>                 made to zero and fold CPU Y's vmstat counters
>                 since reprogramming of the scheduling-clock tick
>                 is not required/or needed (see [2])
> 
>               ...
>                 do_idle
>                 {
> 
>                   __current_set_polling()
>                   tick_nohz_idle_enter()
> 
>                   while (!need_resched()) {
> 
>                     local_irq_disable()
> 
>                     ...
> 
>                     /* No polling or broadcast event */
>                     cpuidle_idle_call()
>                     {
> 
>                       if (cpuidle_not_available(drv, dev)) {
>                         tick_nohz_idle_stop_tick()
>                           __tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched))
>                           {
>                             int cpu = smp_processor_id()
> 
>                             if (ts->timer_expires_base)
>                               expires = ts->timer_expires
>                             else if (can_stop_idle_tick(cpu, ts))
>           (1) ------->        expires = tick_nohz_next_event(ts, cpu)
>                             else
>                               return
> 
>                             ts->idle_calls++
> 
>                             if (expires > 0LL) {
> 
>                               tick_nohz_stop_tick(ts, cpu)
>                               {
> 
>                                 if (ts->tick_stopped && (expires == ts->next_tick)) {
>           (2) ------->            if (tick == KTIME_MAX || ts->next_tick ==
>                                     hrtimer_get_expires(&ts->sched_timer))
>                                     return
>                                 }
>                                 ...
>                               }
> 
> 
> The idea with this patch is to ensure refresh_cpu_vm_stats(false) is called
> on return to the idle loop when the idle tick was previously stopped.
> 
> Any feedback/or testing would be appreciated.
> 
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/time/tick-sched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 17a283ce2b20..61874df064b6 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -876,6 +876,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  		ts->do_timer_last = 0;
>  	}
>  
> +	/* Attempt to fold when the idle tick is stopped or not */
> +	quiet_vmstat();
> +
>  	/* Skip reprogram of event if its not changed */
>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
>  		/* Sanity check: make sure clockevent is actually programmed */
> @@ -897,7 +900,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	 */
>  	if (!ts->tick_stopped) {
>  		calc_load_nohz_start();
> -		quiet_vmstat();
>  
>  		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
>  		ts->tick_stopped = 1;
> -- 
> 2.34.1
> 
> 

As I said earlier, I don't think you want to call quiet_vmstat() unconditionally. And
I don't think this will catch the cases you are trying to fix. Once the tick is stopped
tick_nohz_stop_tick should not be getting called again until it's been restarted.

Something like this I think should catch cases where the task goes idle after
changing the counters but without restarting the tick.

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ed1fd55fc55b..8fbb5167ceb4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1121,6 +1121,9 @@ void tick_nohz_idle_enter(void)
 
        WARN_ON_ONCE(ts->timer_expires_base);
 
+       if (ts->tick_stopped)
+               quiet_vmstat();
+
        ts->inidle = 1;
        tick_nohz_start_idle(ts);
 

But I could be wrong...


Cheers,
Phil

-- 

