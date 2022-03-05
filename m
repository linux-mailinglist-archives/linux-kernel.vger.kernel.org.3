Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099834CE29C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 05:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiCEEec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 23:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiCEEeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 23:34:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A21CFA25
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 20:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F367860748
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 04:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51468C004E1;
        Sat,  5 Mar 2022 04:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646454821;
        bh=YvJWYgita7RiF0BJsjp7/gHtf6Fs5XQSkvkSiE00kJE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LwCADQBWieEzNr83jw6YYACNrZNkiUdmsVH181i7vK3M4ZwdA14v0yD2fpDRxxnG8
         +k/ChKJ9pTQyshV1V7JGwFLn66oqPhc0kFgpHcM12gNLE5hrW1rTEGjN9ODTXmDMXg
         O8jgZxQH1XbI48yl/MmRlzct7fzUTqTTfYt8/7NXokrwdbwQMS7lVGz0RaNzLz2C3x
         GL8Z0Ls1Da9bdJiQzyoVxyczkFr3iDqQGakfAJCHktQVTt5wvn3NN1d5HJkzRaDcD5
         uWswzH3u5JJhejC0EJ+lrubuk4yzMmkxSkOY1U/yfy1B69yFkAixlz/egnStn/Kz+s
         2cGCEN2FUqYWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D9E5C5C0920; Fri,  4 Mar 2022 20:33:40 -0800 (PST)
Date:   Fri, 4 Mar 2022 20:33:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch v4] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-ID: <20220305043340.GU4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiI+a9gTr/UBCf0X@fuller.cnet>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 01:29:31PM -0300, Marcelo Tosatti wrote:
>  
> On systems that run FIFO:1 applications that busy loop 
> on isolated CPUs, executing tasks on such CPUs under
> lower priority is undesired (since that will either
> hang the system, or cause longer interruption to the
> FIFO task due to execution of lower priority task 
> with very small sched slices).
> 
> Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU 
> pagevec during the migration temporarily") relies on 
> queueing work items on all online CPUs to ensure visibility
> of lru_disable_count.
> 
> However, its possible to use synchronize_rcu which will provide the same
> guarantees (see comment this patch modifies on lru_cache_disable).
> 
> Fixes:
> 
> [ 1873.243925] INFO: task kworker/u160:0:9 blocked for more than 622 seconds.
> [ 1873.243927]       Tainted: G          I      --------- ---  5.14.0-31.rt21.31.el9.x86_64 #1
> [ 1873.243929] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1873.243929] task:kworker/u160:0  state:D stack:    0 pid:    9 ppid:     2 flags:0x00004000
> [ 1873.243932] Workqueue: cpuset_migrate_mm cpuset_migrate_mm_workfn
> [ 1873.243936] Call Trace:
> [ 1873.243938]  __schedule+0x21b/0x5b0
> [ 1873.243941]  schedule+0x43/0xe0
> [ 1873.243943]  schedule_timeout+0x14d/0x190
> [ 1873.243946]  ? resched_curr+0x20/0xe0
> [ 1873.243953]  ? __prepare_to_swait+0x4b/0x70
> [ 1873.243958]  wait_for_completion+0x84/0xe0
> [ 1873.243962]  __flush_work.isra.0+0x146/0x200
> [ 1873.243966]  ? flush_workqueue_prep_pwqs+0x130/0x130
> [ 1873.243971]  __lru_add_drain_all+0x158/0x1f0
> [ 1873.243978]  do_migrate_pages+0x3d/0x2d0
> [ 1873.243985]  ? pick_next_task_fair+0x39/0x3b0
> [ 1873.243989]  ? put_prev_task_fair+0x1e/0x30
> [ 1873.243992]  ? pick_next_task+0xb30/0xbd0
> [ 1873.243995]  ? __tick_nohz_task_switch+0x1e/0x70
> [ 1873.244000]  ? raw_spin_rq_unlock+0x18/0x60
> [ 1873.244002]  ? finish_task_switch.isra.0+0xc1/0x2d0
> [ 1873.244005]  ? __switch_to+0x12f/0x510
> [ 1873.244013]  cpuset_migrate_mm_workfn+0x22/0x40
> [ 1873.244016]  process_one_work+0x1e0/0x410
> [ 1873.244019]  worker_thread+0x50/0x3b0
> [ 1873.244022]  ? process_one_work+0x410/0x410
> [ 1873.244024]  kthread+0x173/0x190
> [ 1873.244027]  ? set_kthread_struct+0x40/0x40
> [ 1873.244031]  ret_from_fork+0x1f/0x30
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Given the explanation and the comments below, this does look plausible
to me.

							Thanx, Paul

>  ---
>  
>  v4: improve comment clarify, mention synchronize_rcu guarantees
>      on v5.1				(Andrew Morton /
> 						 Paul E. McKenney)
>  v3: update stale comment			(Nicolas Saenz Julienne)
>  v2: rt_spin_lock calls rcu_read_lock, no need
>  to add it before local_lock on swap.c		(Nicolas Saenz Julienne) 
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index bcf3ac288b56..b5ee163daa66 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -831,8 +831,7 @@ inline void __lru_add_drain_all(bool force_all_cpus)
>  	for_each_online_cpu(cpu) {
>  		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
>  
> -		if (force_all_cpus ||
> -		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
> +		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
>  		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
>  		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
>  		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
> @@ -876,15 +875,21 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
>  void lru_cache_disable(void)
>  {
>  	atomic_inc(&lru_disable_count);
> -#ifdef CONFIG_SMP
>  	/*
> -	 * lru_add_drain_all in the force mode will schedule draining on
> -	 * all online CPUs so any calls of lru_cache_disabled wrapped by
> -	 * local_lock or preemption disabled would be ordered by that.
> -	 * The atomic operation doesn't need to have stronger ordering
> -	 * requirements because that is enforced by the scheduling
> -	 * guarantees.
> +	 * Readers of lru_disable_count are protected by either disabling
> +	 * preemption or rcu_read_lock:
> +	 *
> +	 * preempt_disable, local_irq_disable  [bh_lru_lock()]
> +	 * rcu_read_lock		       [rt_spin_lock CONFIG_PREEMPT_RT]
> +	 * preempt_disable		       [local_lock !CONFIG_PREEMPT_RT]
> +	 *
> +	 * Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
> +	 * preempt_disable() regions of code. So any CPU which sees
> +	 * lru_disable_count = 0 will have exited the critical
> +	 * section when synchronize_rcu() returns.
>  	 */
> +	synchronize_rcu();
> +#ifdef CONFIG_SMP
>  	__lru_add_drain_all(true);
>  #else
>  	lru_add_and_bh_lrus_drain();
> 
