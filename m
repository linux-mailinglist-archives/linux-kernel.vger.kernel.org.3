Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1B4A46B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359642AbiAaMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:17:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47706 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376583AbiAaMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:17:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D563A212CB;
        Mon, 31 Jan 2022 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643631442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wlgmVKDLoRDbXBxlr0Qq/CN3SOuVki91W5nT54POkl0=;
        b=LUyNpNPjoJN40DI7nAn9YpG9p72l5wIRS1/JQqy4ktp4IechOVFBDXTGwQ7dKs7W7M9+cg
        hSxXBcwEJtOYs8yKcYncLVhXMbc2ttX9s8XmSVmLf9nf9qm3hiuLGNEJUiKX77SuQhU98t
        MiLN/+/mEVrKnW8MXO+LRLHdzs8waZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643631442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wlgmVKDLoRDbXBxlr0Qq/CN3SOuVki91W5nT54POkl0=;
        b=TIPXxSKPDc8TgleFMmphT35633T+u3VxzWrBjMp5Q1iRC0ytUOZ4UH3oV8ryV1n+rtGzH8
        cOyW7y2wwcTteDCQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CA911A3B87;
        Mon, 31 Jan 2022 12:17:21 +0000 (UTC)
Date:   Mon, 31 Jan 2022 12:17:20 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH v0 2/3] sched/numa: Add cumulative history of
 per-process fault stats
Message-ID: <20220131121720.GY3301@suse.de>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-3-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220128052851.17162-3-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:58:50AM +0530, Bharata B Rao wrote:
> From: Disha Talreja <dishaa.talreja@amd.com>
> 
> The cumulative history of local/remote (lr) and private/shared (ps)
> will be used for calculating adaptive scan period.
> 

How it used to calculate adaptive scan period?

As it is likely used in a later patch, note here that the per-thread
stats are simply accumulated in the address space for now.

> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  include/linux/mm_types.h |  2 ++
>  kernel/sched/fair.c      | 49 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4f978c09d3db..2c6f119b947f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -614,6 +614,8 @@ struct mm_struct {
>  		/* Process-based Adaptive NUMA */
>  		atomic_long_t faults_locality[2];
>  		atomic_long_t faults_shared[2];
> +		unsigned long faults_locality_history[2];
> +		unsigned long faults_shared_history[2];
>  
>  		spinlock_t pan_numa_lock;
>  		unsigned int numa_scan_period;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d6404b2d42e..4911b3841d00 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2102,14 +2102,56 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
>  /**********************************************/
>  /*  Process-based Adaptive NUMA (PAN) Design  */
>  /**********************************************/
> +/*
> + * Update the cumulative history of local/remote and private/shared
> + * statistics. If the numbers are too small worthy of updating,
> + * return FALSE, otherwise return TRUE.
> + */
> +static bool pan_update_history(struct task_struct *p)
> +{
> +	unsigned long local, remote, shared, private;
> +	long diff;
> +	int i;
> +
> +	remote = atomic_long_read(&p->mm->faults_locality[0]);
> +	local = atomic_long_read(&p->mm->faults_locality[1]);
> +	shared = atomic_long_read(&p->mm->faults_shared[0]);
> +	private = atomic_long_read(&p->mm->faults_shared[1]);
> +
> +	/* skip if the activities in this window are too small */
> +	if (local + remote < 100)
> +		return false;
> +

Why 100?

> +	/* decay over the time window by 1/4 */
> +	diff = local - (long)(p->mm->faults_locality_history[1] / 4);
> +	p->mm->faults_locality_history[1] += diff;
> +	diff = remote - (long)(p->mm->faults_locality_history[0] / 4);
> +	p->mm->faults_locality_history[0] += diff;
> +
> +	/* decay over the time window by 1/2 */
> +	diff = shared - (long)(p->mm->faults_shared_history[0] / 2);
> +	p->mm->faults_shared_history[0] += diff;
> +	diff = private - (long)(p->mm->faults_shared_history[1] / 2);
> +	p->mm->faults_shared_history[1] += diff;
> +

Why are the decay windows different?


> +	/* clear the statistics for the next window */
> +	for (i = 0; i < 2; i++) {
> +		atomic_long_set(&(p->mm->faults_locality[i]), 0);
> +		atomic_long_set(&(p->mm->faults_shared[i]), 0);
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * Updates mm->numa_scan_period under mm->pan_numa_lock.
> - *
>   * Returns p->numa_scan_period now but updated to return
>   * p->mm->numa_scan_period in a later patch.
>   */

Spurious whitespace change.

>  static unsigned long pan_get_scan_period(struct task_struct *p)
>  {
> +	pan_update_history(p);
> +
>  	return p->numa_scan_period;
>  }
>  

Ok, so the spinlock is protecting the RMW of the PAN history. It still
may be a concern that task_numa_work gets aborted if the spinlock cannot
be acquired.

> @@ -2836,10 +2878,15 @@ static void task_numa_work(struct callback_head *work)
>  static void pan_init_numa(struct task_struct *p)
>  {
>  	struct mm_struct *mm = p->mm;
> +	int i;
>  
>  	spin_lock_init(&mm->pan_numa_lock);
>  	mm->numa_scan_period = sysctl_numa_balancing_scan_delay;
>  
> +	for (i = 0; i < 2; i++) {
> +		mm->faults_locality_history[i] = 0;
> +		mm->faults_shared_history[i] = 0;
> +	}
>  }
>  
>  void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
> -- 
> 2.25.1
> 

-- 
Mel Gorman
SUSE Labs
