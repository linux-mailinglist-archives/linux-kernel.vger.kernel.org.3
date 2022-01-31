Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4463E4A46B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376283AbiAaMRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:17:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47682 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358749AbiAaMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:17:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7F61210F8;
        Mon, 31 Jan 2022 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643631436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHBt4c+Xhy7OqCvnrOC9JlR18pNnSJzhVo60R72j03c=;
        b=CQ4TsyMmpsX+LHwnJ0RbjkHGjXSxIASk8H/1xkg6Vgqv15Kiho829GTkq08LfofdTQLPvo
        buTN6oXDa042Vb+Qe7VAHjdnq8RiEtVBPeaZjT/INOcaX+uYcK1CORS36njutAOWkkBqDx
        0ldxgd20+COArZN2bipuC/OhyiZD+Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643631436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHBt4c+Xhy7OqCvnrOC9JlR18pNnSJzhVo60R72j03c=;
        b=IdplAjrZN2+6jifmRRPIOOz9PMQWNfR8kgT9yMG5CFY/vY9lxIfddkYStAMkqlCKdOPdFJ
        q8WgdtS922Z8meBQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 425A0A3B81;
        Mon, 31 Jan 2022 12:17:16 +0000 (UTC)
Date:   Mon, 31 Jan 2022 12:17:14 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH v0 1/3] sched/numa: Process based autonuma scan
 period framework
Message-ID: <20220131121714.GX3301@suse.de>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-2-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220128052851.17162-2-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:58:49AM +0530, Bharata B Rao wrote:
> From: Disha Talreja <dishaa.talreja@amd.com>
> 
> Add a new framework that calculates autonuma scan period
> based on per-process NUMA fault stats.
> 
> NUMA faults can be classified into different categories, such
> as local vs. remote, or private vs. shared. It is also important
> to understand such behavior from the perspective of a process.
> The per-process fault stats added here will be used for
> calculating the scan period in the adaptive NUMA algorithm.
> 

Be more specific no how the local vs remote, private vs shared states
are reflections of per-task activity of the same.

> The actual scan period is still using the original value
> p->numa_scan_period before the real implementation is added in
> place in a later commit.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  include/linux/mm_types.h |  7 +++++++
>  kernel/sched/fair.c      | 40 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 9db36dc5d4cf..4f978c09d3db 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -610,6 +610,13 @@ struct mm_struct {
>  
>  		/* numa_scan_seq prevents two threads setting pte_numa */
>  		int numa_scan_seq;
> +
> +		/* Process-based Adaptive NUMA */
> +		atomic_long_t faults_locality[2];
> +		atomic_long_t faults_shared[2];
> +
> +		spinlock_t pan_numa_lock;

Document what this lock protects. In the context of this patch it appears
to protect a read of p->numa_scan_period and it's overkill to use a
spinlock for that.  Also, given that it's a trylock, the task_numa_work
ends up doing no scanning or updates. This might have some value in
terms of avoiding multiple threads doing updates if they happen to start
at the same time but that's a narrow side-effect given the short hold
time of the lock.

> +		unsigned int numa_scan_period;

Document how the per-mm numa_scan_period is related to the per-task
numa_scan_period.

Maybe it's done in a later patch, I haven't read that far yet.

>  #endif
>  		/*
>  		 * An operation with batched TLB flushing is going on. Anything
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..1d6404b2d42e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2099,6 +2099,20 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
>  	numa_group->active_nodes = active_nodes;
>  }
>  
> +/**********************************************/
> +/*  Process-based Adaptive NUMA (PAN) Design  */
> +/**********************************************/
> +/*
> + * Updates mm->numa_scan_period under mm->pan_numa_lock.
> + *
> + * Returns p->numa_scan_period now but updated to return
> + * p->mm->numa_scan_period in a later patch.
> + */
> +static unsigned long pan_get_scan_period(struct task_struct *p)
> +{
> +	return p->numa_scan_period;
> +}
> +
>  /*
>   * When adapting the scan rate, the period is divided into NUMA_PERIOD_SLOTS
>   * increments. The more local the fault statistics are, the higher the scan
> @@ -2616,6 +2630,9 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
>  			task_numa_group(p, last_cpupid, flags, &priv);
>  	}
>  
> +	atomic_long_add(pages, &(p->mm->faults_locality[local]));
> +	atomic_long_add(pages, &(p->mm->faults_shared[priv]));
> +
>  	/*
>  	 * If a workload spans multiple NUMA nodes, a shared fault that
>  	 * occurs wholly within the set of nodes that the workload is
> @@ -2702,12 +2719,20 @@ static void task_numa_work(struct callback_head *work)
>  	if (time_before(now, migrate))
>  		return;
>  
> -	if (p->numa_scan_period == 0) {
> +	if (p->mm->numa_scan_period == 0) {
> +		p->numa_scan_period_max = task_scan_max(p);
> +		p->numa_scan_period = task_scan_start(p);
> +		mm->numa_scan_period = p->numa_scan_period;
> +	} else if (p->numa_scan_period == 0) {
>  		p->numa_scan_period_max = task_scan_max(p);
>  		p->numa_scan_period = task_scan_start(p);
>  	}
>  
> -	next_scan = now + msecs_to_jiffies(p->numa_scan_period);
> +	if (!spin_trylock(&p->mm->pan_numa_lock))
> +		return;
> +	next_scan = now + msecs_to_jiffies(pan_get_scan_period(p));
> +	spin_unlock(&p->mm->pan_numa_lock);
> +
>  	if (cmpxchg(&mm->numa_next_scan, migrate, next_scan) != migrate)
>  		return;
>  
> @@ -2807,6 +2832,16 @@ static void task_numa_work(struct callback_head *work)
>  	}
>  }
>  
> +/* Init Process-based Adaptive NUMA */
> +static void pan_init_numa(struct task_struct *p)
> +{
> +	struct mm_struct *mm = p->mm;
> +
> +	spin_lock_init(&mm->pan_numa_lock);
> +	mm->numa_scan_period = sysctl_numa_balancing_scan_delay;
> +
> +}
> +
>  void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
>  {
>  	int mm_users = 0;
> @@ -2817,6 +2852,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
>  		if (mm_users == 1) {
>  			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
>  			mm->numa_scan_seq = 0;
> +			pan_init_numa(p);
>  		}
>  	}
>  	p->node_stamp			= 0;
> -- 
> 2.25.1
> 

-- 
Mel Gorman
SUSE Labs
