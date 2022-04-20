Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE68508881
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378638AbiDTMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiDTMx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:53:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55379275D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:50:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0EA681F74F;
        Wed, 20 Apr 2022 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650459042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0sWHIpk+fc+W6AQBdmM/lEHyo7aM5qyRvv8vFOHrHk=;
        b=OoLnORWXbzlw0YXnheiRRtpr7lMSYXir6YIix/3hRrk3j6C9HRlRYowA6PP+qjJj8zlBr1
        Z24ey89CJ3DoBVpXe4D9o9HEESW6FNSa7IgxYSTXnqm1gS5E/fEbEX0TiWblowSlnXrjSn
        OFua4Rw2bO4ZgyI72+NAqyJBCf9KQz0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 904F52C14B;
        Wed, 20 Apr 2022 12:50:41 +0000 (UTC)
Date:   Wed, 20 Apr 2022 14:50:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v9] oom_kill.c: futex: Delay the OOM reaper to allow time
 for proper futex cleanup
Message-ID: <YmABoUYOPqhVTCBl@dhcp22.suse.cz>
References: <20220414144042.677008-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414144042.677008-1-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-04-22 10:40:42, Nico Pache wrote:
> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> be targeted by the oom reaper. This mapping is used to store the futex
> robust list head; the kernel does not keep a copy of the robust list and
> instead references a userspace address to maintain the robustness during
> a process death. A race can occur between exit_mm and the oom reaper that
> allows the oom reaper to free the memory of the futex robust list before
> the exit path has handled the futex death:
> 
>     CPU1                               CPU2
> ------------------------------------------------------------------------
>     page_fault
>     do_exit "signal"
>     wake_oom_reaper
>                                         oom_reaper
>                                         oom_reap_task_mm (invalidates mm)
>     exit_mm
>     exit_mm_release
>     futex_exit_release
>     futex_cleanup
>     exit_robust_list
>     get_user (EFAULT- can't access memory)
> 
> If the get_user EFAULT's, the kernel will be unable to recover the
> waiters on the robust_list, leaving userspace mutexes hung indefinitely.
> 
> Delay the OOM reaper, allowing more time for the exit path to perform
> the futex cleanup.
> 
> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
> 
> [1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370
> 
> Fixes: 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Herton R. Krzesinski <herton@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Joel Savitz <jsavitz@redhat.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: stable@kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> [ Based on a patch by Michal Hocko ]
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/sched.h |  1 +
>  mm/oom_kill.c         | 54 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d5e3c00b74e1..a8911b1f35aa 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1443,6 +1443,7 @@ struct task_struct {
>  	int				pagefault_disabled;
>  #ifdef CONFIG_MMU
>  	struct task_struct		*oom_reaper_list;
> +	struct timer_list		oom_reaper_timer;
>  #endif
>  #ifdef CONFIG_VMAP_STACK
>  	struct vm_struct		*stack_vm_area;
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 7ec38194f8e1..49d7df39b02d 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -632,7 +632,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  	 */
>  	set_bit(MMF_OOM_SKIP, &mm->flags);
>  
> -	/* Drop a reference taken by wake_oom_reaper */
> +	/* Drop a reference taken by queue_oom_reaper */
>  	put_task_struct(tsk);
>  }
>  
> @@ -644,12 +644,12 @@ static int oom_reaper(void *unused)
>  		struct task_struct *tsk = NULL;
>  
>  		wait_event_freezable(oom_reaper_wait, oom_reaper_list != NULL);
> -		spin_lock(&oom_reaper_lock);
> +		spin_lock_irq(&oom_reaper_lock);
>  		if (oom_reaper_list != NULL) {
>  			tsk = oom_reaper_list;
>  			oom_reaper_list = tsk->oom_reaper_list;
>  		}
> -		spin_unlock(&oom_reaper_lock);
> +		spin_unlock_irq(&oom_reaper_lock);
>  
>  		if (tsk)
>  			oom_reap_task(tsk);
> @@ -658,22 +658,48 @@ static int oom_reaper(void *unused)
>  	return 0;
>  }
>  
> -static void wake_oom_reaper(struct task_struct *tsk)
> +static void wake_oom_reaper(struct timer_list *timer)
>  {
> -	/* mm is already queued? */
> -	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> -		return;
> +	struct task_struct *tsk = container_of(timer, struct task_struct,
> +			oom_reaper_timer);
> +	struct mm_struct *mm = tsk->signal->oom_mm;
> +	unsigned long flags;
>  
> -	get_task_struct(tsk);
> +	/* The victim managed to terminate on its own - see exit_mmap */
> +	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> +		put_task_struct(tsk);
> +		return;
> +	}
>  
> -	spin_lock(&oom_reaper_lock);
> +	spin_lock_irqsave(&oom_reaper_lock, flags);
>  	tsk->oom_reaper_list = oom_reaper_list;
>  	oom_reaper_list = tsk;
> -	spin_unlock(&oom_reaper_lock);
> +	spin_unlock_irqrestore(&oom_reaper_lock, flags);
>  	trace_wake_reaper(tsk->pid);
>  	wake_up(&oom_reaper_wait);
>  }
>  
> +/*
> + * Give the OOM victim time to exit naturally before invoking the oom_reaping.
> + * The timers timeout is arbitrary... the longer it is, the longer the worst
> + * case scenario for the OOM can take. If it is too small, the oom_reaper can
> + * get in the way and release resources needed by the process exit path.
> + * e.g. The futex robust list can sit in Anon|Private memory that gets reaped
> + * before the exit path is able to wake the futex waiters.
> + */
> +#define OOM_REAPER_DELAY (2*HZ)
> +static void queue_oom_reaper(struct task_struct *tsk)
> +{
> +	/* mm is already queued? */
> +	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
> +		return;
> +
> +	get_task_struct(tsk);
> +	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> +	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> +	add_timer(&tsk->oom_reaper_timer);
> +}
> +
>  static int __init oom_init(void)
>  {
>  	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
> @@ -681,7 +707,7 @@ static int __init oom_init(void)
>  }
>  subsys_initcall(oom_init)
>  #else
> -static inline void wake_oom_reaper(struct task_struct *tsk)
> +static inline void queue_oom_reaper(struct task_struct *tsk)
>  {
>  }
>  #endif /* CONFIG_MMU */
> @@ -932,7 +958,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	rcu_read_unlock();
>  
>  	if (can_oom_reap)
> -		wake_oom_reaper(victim);
> +		queue_oom_reaper(victim);
>  
>  	mmdrop(mm);
>  	put_task_struct(victim);
> @@ -968,7 +994,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	task_lock(victim);
>  	if (task_will_free_mem(victim)) {
>  		mark_oom_victim(victim);
> -		wake_oom_reaper(victim);
> +		queue_oom_reaper(victim);
>  		task_unlock(victim);
>  		put_task_struct(victim);
>  		return;
> @@ -1067,7 +1093,7 @@ bool out_of_memory(struct oom_control *oc)
>  	 */
>  	if (task_will_free_mem(current)) {
>  		mark_oom_victim(current);
> -		wake_oom_reaper(current);
> +		queue_oom_reaper(current);
>  		return true;
>  	}
>  
> -- 
> 2.35.1

-- 
Michal Hocko
SUSE Labs
