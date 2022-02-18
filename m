Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606234BB1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiBRGTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:19:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiBRGTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:19:01 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8928B615
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:18:45 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K0Lxl0Vgmz1FDLL;
        Fri, 18 Feb 2022 14:14:19 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 14:18:43 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 14:18:42 +0800
Message-ID: <acac2680-2064-e46b-463e-a11670a527d3@huawei.com>
Date:   Fri, 18 Feb 2022 14:18:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched: Fix yet more sched_fork() races
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Borislav Petkov <bp@suse.de>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <tj@kernel.org>, <dietmar.eggemann@arm.com>
References: <Ygj7feK+vdtPw6zj@zn.tnic>
 <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
 <YgoWoh6pIzlsQx6d@hirez.programming.kicks-ass.net>
 <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
 <Yg4MdYLBqiw8zFaF@hirez.programming.kicks-ass.net>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <Yg4MdYLBqiw8zFaF@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/17 16:51, Peter Zijlstra 写道:
> On Mon, Feb 14, 2022 at 10:16:57AM +0100, Peter Zijlstra wrote:
>> Zhang, Tadeusz, TJ, how does this look?
> 
> *sigh* I was hoping for some Tested-by, since I've no idea how to
> operate this cgroup stuff properly.

tested this patch successfully.

Tested-by: Zhang Qiao <zhangqiao22@huawei.com>


> 
> Anyway, full patch below. I'll go stick it in sched/urgent.
> 
> ---
> Subject: sched: Fix yet more sched_fork() races
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 14 Feb 2022 10:16:57 +0100
> 
> Where commit 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an
> invalid sched_task_group") fixed a fork race vs cgroup, it opened up a
> race vs syscalls by not placing the task on the runqueue before it
> gets exposed through the pidhash.
> 
> Commit 13765de8148f ("sched/fair: Fix fault in reweight_entity") is
> trying to fix a single instance of this, instead fix the whole class
> of issues, effectively reverting this commit.
> 
> Fixes: 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an invalid sched_task_group")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched/task.h |    4 ++--
>  kernel/fork.c              |   13 ++++++++++++-
>  kernel/sched/core.c        |   34 +++++++++++++++++++++-------------
>  3 files changed, 35 insertions(+), 16 deletions(-)
> 
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -54,8 +54,8 @@ extern asmlinkage void schedule_tail(str
>  extern void init_idle(struct task_struct *idle, int cpu);
>  
>  extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
> -extern void sched_post_fork(struct task_struct *p,
> -			    struct kernel_clone_args *kargs);
> +extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
> +extern void sched_post_fork(struct task_struct *p);
>  extern void sched_dead(struct task_struct *p);
>  
>  void __noreturn do_task_dead(void);
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2266,6 +2266,17 @@ static __latent_entropy struct task_stru
>  		goto bad_fork_put_pidfd;
>  
>  	/*
> +	 * Now that the cgroups are pinned, re-clone the parent cgroup and put
> +	 * the new task on the correct runqueue. All this *before* the task
> +	 * becomes visible.
> +	 *
> +	 * This isn't part of ->can_fork() because while the re-cloning is
> +	 * cgroup specific, it unconditionally needs to place the task on a
> +	 * runqueue.
> +	 */
> +	sched_cgroup_fork(p, args);
> +
> +	/*
>  	 * From this point on we must avoid any synchronous user-space
>  	 * communication until we take the tasklist-lock. In particular, we do
>  	 * not want user-space to be able to predict the process start-time by
> @@ -2375,7 +2386,7 @@ static __latent_entropy struct task_stru
>  	write_unlock_irq(&tasklist_lock);
>  
>  	proc_fork_connector(p);
> -	sched_post_fork(p, args);
> +	sched_post_fork(p);
>  	cgroup_post_fork(p, args);
>  	perf_event_fork(p);
>  
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1215,9 +1215,8 @@ int tg_nop(struct task_group *tg, void *
>  }
>  #endif
>  
> -static void set_load_weight(struct task_struct *p)
> +static void set_load_weight(struct task_struct *p, bool update_load)
>  {
> -	bool update_load = !(READ_ONCE(p->__state) & TASK_NEW);
>  	int prio = p->static_prio - MAX_RT_PRIO;
>  	struct load_weight *load = &p->se.load;
>  
> @@ -4408,7 +4407,7 @@ int sched_fork(unsigned long clone_flags
>  			p->static_prio = NICE_TO_PRIO(0);
>  
>  		p->prio = p->normal_prio = p->static_prio;
> -		set_load_weight(p);
> +		set_load_weight(p, false);
>  
>  		/*
>  		 * We don't need the reset flag anymore after the fork. It has
> @@ -4426,6 +4425,7 @@ int sched_fork(unsigned long clone_flags
>  
>  	init_entity_runnable_average(&p->se);
>  
> +
>  #ifdef CONFIG_SCHED_INFO
>  	if (likely(sched_info_on()))
>  		memset(&p->sched_info, 0, sizeof(p->sched_info));
> @@ -4441,18 +4441,23 @@ int sched_fork(unsigned long clone_flags
>  	return 0;
>  }
>  
> -void sched_post_fork(struct task_struct *p, struct kernel_clone_args *kargs)
> +void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
>  {
>  	unsigned long flags;
> -#ifdef CONFIG_CGROUP_SCHED
> -	struct task_group *tg;
> -#endif
>  
> +	/*
> +	 * Because we're not yet on the pid-hash, p->pi_lock isn't strictly
> +	 * required yet, but lockdep gets upset if rules are violated.
> +	 */
>  	raw_spin_lock_irqsave(&p->pi_lock, flags);
>  #ifdef CONFIG_CGROUP_SCHED
> -	tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
> -			  struct task_group, css);
> -	p->sched_task_group = autogroup_task_group(p, tg);
> +	if (1) {
> +		struct task_group *tg;
> +		tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
> +				  struct task_group, css);
> +		tg = autogroup_task_group(p, tg);
> +		p->sched_task_group = tg;
> +	}
>  #endif
>  	rseq_migrate(p);
>  	/*
> @@ -4463,7 +4468,10 @@ void sched_post_fork(struct task_struct
>  	if (p->sched_class->task_fork)
>  		p->sched_class->task_fork(p);
>  	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +}
>  
> +void sched_post_fork(struct task_struct *p)
> +{
>  	uclamp_post_fork(p);
>  }
>  
> @@ -6923,7 +6931,7 @@ void set_user_nice(struct task_struct *p
>  		put_prev_task(rq, p);
>  
>  	p->static_prio = NICE_TO_PRIO(nice);
> -	set_load_weight(p);
> +	set_load_weight(p, true);
>  	old_prio = p->prio;
>  	p->prio = effective_prio(p);
>  
> @@ -7214,7 +7222,7 @@ static void __setscheduler_params(struct
>  	 */
>  	p->rt_priority = attr->sched_priority;
>  	p->normal_prio = normal_prio(p);
> -	set_load_weight(p);
> +	set_load_weight(p, true);
>  }
>  
>  /*
> @@ -9447,7 +9455,7 @@ void __init sched_init(void)
>  #endif
>  	}
>  
> -	set_load_weight(&init_task);
> +	set_load_weight(&init_task, false);
>  
>  	/*
>  	 * The boot idle thread does lazy MMU switching as well:
> 
> .
> 
