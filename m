Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B45550A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359182AbiFVQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359820AbiFVQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29BA83C71A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655913752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxyVNUsFoi+jcN5XK+ko0AFtnLVdkS+f5hOSgV7n0RI=;
        b=Qp0KXUwevHVC6/qE6uOluw/rexfYg+wdVsx0DMsNPWRdrUQDYu5Oo4pYZCgFvqxpSihiBd
        Ya4ggaVwMAudZZUdJpKCiOR2MLxbEXxS7ZLF7H7EgVCDmVMzuzcZ/7cc/E7IdU+BaRdkTg
        PWCNH4S/DgXWy71oOq4r9JspSnWJ9i4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-j8cOkwTcP3i-YH-AcC4ngA-1; Wed, 22 Jun 2022 12:02:28 -0400
X-MC-Unique: j8cOkwTcP3i-YH-AcC4ngA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 488361C14486;
        Wed, 22 Jun 2022 16:02:28 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B841121314;
        Wed, 22 Jun 2022 16:02:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A95BA416D5E9; Wed, 22 Jun 2022 13:02:09 -0300 (-03)
Date:   Wed, 22 Jun 2022 13:02:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     frederic@kernel.org, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v4] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <YrM9Aejz5I/mYPsO@fuller.cnet>
References: <20220621172207.1501641-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BZRWbDd6lnzCQEnQ"
Content-Disposition: inline
In-Reply-To: <20220621172207.1501641-1-atomlin@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BZRWbDd6lnzCQEnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2022 at 06:22:07PM +0100, Aaron Tomlin wrote:
> Hi Frederic and Marcelo,
> 
> I have incorporated an idea from Marcelo's patch [1] where a CPU-specific
> variable is used to indicate if a vmstat differential/or imbalance is
> present for a given CPU. So, at the appropriate time, vmstat processing can
> be initiated. The hope is that this particular approach is "cheaper" when
> compared to need_update() - used currently; in the context of nohz_full and
> the scheduling-clock tick being stopped, we would now with this patch,
> check if a CPU-specific vmstat imbalance is present before exiting
> user-mode (see tick_nohz_user_enter_prepare()).
> 
> This trivial test program [2] was used to determine the somewhat impact
> under vanilla and with the proposed changes; mlock(2) and munlock(2) was
> used solely to modify vmstat item 'NR_MLOCK'. The following is an average
> count of CPU-cycles across the aforementioned system calls and the idle
> loop, respectively. I believe these results are negligible:
> 
> 	  Modified		   |  		Vanilla
>                                    |
>                                    |
>   cycles per syscall: 7399         | 	cycles per syscall: 4150
>   cycles per idle loop: 141048     |	cycles per idle loop: 144730
>                                    |
> 
> 
> Any feedback would be appreciated. Thanks.
> 
> Changes since v3 [3]:
> 
>  - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
>  - Replaced need_update()
>  - Introduced CPU-specific variable namely 'vmstat_dirty'
>    and mark_vmstat_dirty()
> 
> [1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/
> [2]: https://pastebin.com/8AtzSAuK
> [3]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/
> 
> -- 
> 
> In the context of the idle task and an adaptive-tick mode/or a nohz_full
> CPU, quiet_vmstat() can be called: before stopping the idle tick,
> entering an idle state and on exit. In particular, for the latter case,
> when the idle task is required to reschedule, the idle tick can remain
> stopped and the timer expiration time endless i.e., KTIME_MAX. Now,
> indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
> counters should be processed to ensure the respective values have been
> reset and folded into the zone specific 'vm_stat[]'. That being said, it
> can only occur when: the idle tick was previously stopped, and
> reprogramming of the timer is not required.
> 
> A customer provided some evidence which indicates that the idle tick was
> stopped; albeit, CPU-specific vmstat counters still remained populated.
> Thus one can only assume quiet_vmstat() was not invoked on return to the
> idle loop.
> 
> If I understand correctly, I suspect this divergence might erroneously
> prevent a reclaim attempt by kswapd. If the number of zone specific free
> pages are below their per-cpu drift value then
> zone_page_state_snapshot() is used to compute a more accurate view of
> the aforementioned statistic.  Thus any task blocked on the NUMA node
> specific pfmemalloc_wait queue will be unable to make significant
> progress via direct reclaim unless it is killed after being woken up by
> kswapd (see throttle_direct_reclaim()).
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
>                 'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
>                 specific 'vm_stat[]' update was deferred as per the
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
> 		  ...
> 		    do_idle
> 		    {
> 
> 		      __current_set_polling()
> 		      tick_nohz_idle_enter()
> 
> 		      while (!need_resched()) {
> 
> 			local_irq_disable()
> 
> 			...
> 
> 			/* No polling or broadcast event */
> 			cpuidle_idle_call()
> 			{
> 
> 			  if (cpuidle_not_available(drv, dev)) {
> 			    tick_nohz_idle_stop_tick()
> 			      __tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched))
> 			      {
> 				int cpu = smp_processor_id()
> 
> 				if (ts->timer_expires_base)
> 				  expires = ts->timer_expires
> 				else if (can_stop_idle_tick(cpu, ts))
> 	      (1) ------->        expires = tick_nohz_next_event(ts, cpu)
> 				else
> 				  return
> 
> 				ts->idle_calls++
> 
> 				if (expires > 0LL) {
> 
> 				  tick_nohz_stop_tick(ts, cpu)
> 				  {
> 
> 				    if (ts->tick_stopped && (expires == ts->next_tick)) {
> 	      (2) ------->            if (tick == KTIME_MAX || ts->next_tick ==
> 					hrtimer_get_expires(&ts->sched_timer))
> 					return
> 				    }
> 				    ...
> 				  }
> 
> So the idea of with this patch is to ensure refresh_cpu_vm_stats(false) is
> called, when it is appropriate, on return to the idle loop when the idle
> tick was previously stopped too. Additionally, in the context of
> nohz_full, when the scheduling-tick is stopped and before exiting
> to user-mode, ensure no CPU-specific vmstat differentials remain.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  include/linux/tick.h     |  9 ++------
>  kernel/time/tick-sched.c | 19 ++++++++++++++++-
>  mm/vmstat.c              | 46 +++++++++++++---------------------------
>  3 files changed, 35 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index bfd571f18cfd..4c576c9ca0a2 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -11,7 +11,6 @@
>  #include <linux/context_tracking_state.h>
>  #include <linux/cpumask.h>
>  #include <linux/sched.h>
> -#include <linux/rcupdate.h>
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern void __init tick_init(void);
> @@ -123,6 +122,8 @@ enum tick_dep_bits {
>  #define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
>  #define TICK_DEP_MASK_RCU_EXP		(1 << TICK_DEP_BIT_RCU_EXP)
>  
> +void tick_nohz_user_enter_prepare(void);
> +
>  #ifdef CONFIG_NO_HZ_COMMON
>  extern bool tick_nohz_enabled;
>  extern bool tick_nohz_tick_stopped(void);
> @@ -305,10 +306,4 @@ static inline void tick_nohz_task_switch(void)
>  		__tick_nohz_task_switch();
>  }
>  
> -static inline void tick_nohz_user_enter_prepare(void)
> -{
> -	if (tick_nohz_full_cpu(smp_processor_id()))
> -		rcu_nocb_flush_deferred_wakeup();
> -}
> -
>  #endif
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index d257721c68b8..4cdd71cc292f 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -26,6 +26,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/context_tracking.h>
>  #include <linux/mm.h>
> +#include <linux/rcupdate.h>
>  
>  #include <asm/irq_regs.h>
>  
> @@ -43,6 +44,20 @@ struct tick_sched *tick_get_tick_sched(int cpu)
>  	return &per_cpu(tick_cpu_sched, cpu);
>  }
>  
> +void tick_nohz_user_enter_prepare(void)
> +{
> +	struct tick_sched *ts;
> +
> +	if (tick_nohz_full_cpu(smp_processor_id())) {
> +		ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +		if (ts->tick_stopped)
> +			quiet_vmstat();
> +		rcu_nocb_flush_deferred_wakeup();
> +	}
> +}
> +EXPORT_SYMBOL(tick_nohz_user_enter_prepare);
> +
>  #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
>  /*
>   * The time, when the last jiffy update happened. Write access must hold
> @@ -891,6 +906,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  		ts->do_timer_last = 0;
>  	}
>  
> +	/* Attempt to fold when the idle tick is stopped or not */
> +	quiet_vmstat();
> +
>  	/* Skip reprogram of event if its not changed */
>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
>  		/* Sanity check: make sure clockevent is actually programmed */
> @@ -912,7 +930,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	 */
>  	if (!ts->tick_stopped) {
>  		calc_load_nohz_start();
> -		quiet_vmstat();
>  
>  		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
>  		ts->tick_stopped = 1;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b75b1a64b54c..7bfcafafe8f7 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -195,6 +195,12 @@ void fold_vm_numa_events(void)
>  #endif
>  
>  #ifdef CONFIG_SMP
> +static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void mark_vmstat_dirty(void)
> +{
> +	this_cpu_write(vmstat_dirty, true);
> +}
>  
>  int calculate_pressure_threshold(struct zone *zone)
>  {
> @@ -367,6 +373,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	mark_vmstat_dirty();
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		preempt_enable();
> @@ -405,6 +412,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	mark_vmstat_dirty();
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		preempt_enable();
> @@ -603,6 +611,7 @@ static inline void mod_zone_state(struct zone *zone,
>  
>  	if (z)
>  		zone_page_state_add(z, zone, item);
> +	mark_vmstat_dirty();
>  }
>  
>  void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> @@ -671,6 +680,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
>  
>  	if (z)
>  		node_page_state_add(z, pgdat, item);
> +	mark_vmstat_dirty();
>  }
>  
>  void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> @@ -1866,6 +1876,7 @@ int sysctl_stat_interval __read_mostly = HZ;
>  static void refresh_vm_stats(struct work_struct *work)
>  {
>  	refresh_cpu_vm_stats(true);
> +	this_cpu_write(vmstat_dirty, false);
>  }
>  
>  int vmstat_refresh(struct ctl_table *table, int write,
> @@ -1930,6 +1941,7 @@ int vmstat_refresh(struct ctl_table *table, int write,
>  static void vmstat_update(struct work_struct *w)
>  {
>  	if (refresh_cpu_vm_stats(true)) {
> +		this_cpu_write(vmstat_dirty, false);
>  		/*
>  		 * Counters were updated so we expect more updates
>  		 * to occur in the future. Keep on running the
> @@ -1941,35 +1953,6 @@ static void vmstat_update(struct work_struct *w)
>  	}
>  }
>  
> -/*
> - * Check if the diffs for a certain cpu indicate that
> - * an update is needed.
> - */
> -static bool need_update(int cpu)
> -{
> -	pg_data_t *last_pgdat = NULL;
> -	struct zone *zone;
> -
> -	for_each_populated_zone(zone) {
> -		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> -		struct per_cpu_nodestat *n;
> -
> -		/*
> -		 * The fast way of checking if there are any vmstat diffs.
> -		 */
> -		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
> -			return true;
> -
> -		if (last_pgdat == zone->zone_pgdat)
> -			continue;
> -		last_pgdat = zone->zone_pgdat;
> -		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
> -		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
> -			return true;
> -	}
> -	return false;
> -}
> -
>  /*
>   * Switch off vmstat processing and then fold all the remaining differentials
>   * until the diffs stay at zero. The function is used by NOHZ and can only be
> @@ -1983,7 +1966,7 @@ void quiet_vmstat(void)
>  	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
>  		return;
>  
> -	if (!need_update(smp_processor_id()))
> +	if (!__this_cpu_read(vmstat_dirty))
>  		return;
>  
>  	/*
> @@ -1993,6 +1976,7 @@ void quiet_vmstat(void)
>  	 * vmstat_shepherd will take care about that for us.
>  	 */
>  	refresh_cpu_vm_stats(false);
> +	__this_cpu_write(vmstat_dirty, false);
>  }
>  
>  /*
> @@ -2014,7 +1998,7 @@ static void vmstat_shepherd(struct work_struct *w)
>  	for_each_online_cpu(cpu) {
>  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> +		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
>  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
>  
>  		cond_resched();
> -- 
> 2.34.3
> 

With attached test program and:

# dmesg | grep isol
[    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-tip root=/dev/mapper/fedora-root ro resume=/dev/mapper/fedora-swap rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap rhgb quiet skew_tick=1 isolcpus=managed_irq,domain,5,6,7 intel_pstate=disable nosoftlockup tsc=nowatchdog nohz=on nohz_full=5,6,7 rcu_nocbs=5,6,7 irqaffinity=0,1,2,3,4 console=ttyS0,115200 nomodeset
[    0.022862] Kernel command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-tip root=/dev/mapper/fedora-root ro resume=/dev/mapper/fedora-swap rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap rhgb quiet skew_tick=1 isolcpus=managed_irq,domain,5,6,7 intel_pstate=disable nosoftlockup tsc=nowatchdog nohz=on nohz_full=5,6,7 rcu_nocbs=5,6,7 irqaffinity=0,1,2,3,4 console=ttyS0,115200 nomodeset
[    0.041232] Kernel/User page tables isolation: enabled

# taskset -c 5 ./test-vmstat-overhead {syscall,idle}

I get:

Vanilla                                 -v4

cycles per syscall: 7173                6825
cycles per syscall: 7557                6744

cycles per idle loop: 154187            152788
cycles per idle loop: 154398            151593



--BZRWbDd6lnzCQEnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test-vmstat-overhead.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include <string.h>

typedef unsigned long long cycles_t;
typedef unsigned long long usecs_t;
typedef unsigned long long u64;

#ifdef __x86_64__
#define DECLARE_ARGS(val, low, high)    unsigned long low, high
#define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
#define EAX_EDX_ARGS(val, low, high)    "a" (low), "d" (high)
#define EAX_EDX_RET(val, low, high)     "=a" (low), "=d" (high)
#else
#define DECLARE_ARGS(val, low, high)    unsigned long long val
#define EAX_EDX_VAL(val, low, high)     (val)
#define EAX_EDX_ARGS(val, low, high)    "A" (val)
#define EAX_EDX_RET(val, low, high)     "=A" (val)
#endif

static inline unsigned long long __rdtscll(void)
{
        DECLARE_ARGS(val, low, high);

        asm volatile("cpuid; rdtsc" : EAX_EDX_RET(val, low, high));

        return EAX_EDX_VAL(val, low, high);
}

#define rdtscll(val) do { (val) = __rdtscll(); } while (0)

#define NRSYSCALLS 30000
#define NRSLEEPS   100000

void main(int argc, char *argv[])
{
	unsigned long a, b, cycles;
	int i, syscall = 0;
	void *page = malloc(4096);

	if (mlock(page, 4096))
		perror("mlock");
	if (munlock(page, 4096))
		perror("munlock");

	if (argc != 2) {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}

        rdtscll(a);

	if (strncmp("idle", argv[1], 4) == 0)
		syscall = 0;
	else if (strncmp("syscall", argv[1], 7) == 0)
		syscall = 1;
	else {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}
	
	if (syscall == 1) {
        	for (i = 0; i < NRSYSCALLS; i++) {
			if (mlock(page, 4096))
				perror("mlock");
			if (munlock(page, 4096))
				perror("munlock");
		}
	} else {
        	for (i = 0; i < NRSLEEPS; i++)
		 	usleep(10);
	}

        rdtscll(b);

        cycles = b - a;

	if (syscall == 1)
        	printf("cycles per syscall: %d\n", (b-a)/(NRSYSCALLS*2));
	else
		printf("cycles per idle loop: %d\n", (b-a)/NRSLEEPS);
}


--BZRWbDd6lnzCQEnQ--

