Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA69D4C8B87
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiCAM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCAM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:26:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F617B562
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:25:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 487CF1F39D;
        Tue,  1 Mar 2022 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646137520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58pWrGNCbwEBIMex3Topa9R1mdmxkD1Mk0Xgo6Zbo/s=;
        b=KQW+YQPOrAc1caEACK0RU+FH+BQI6M4ZpALD+E2Flze2qBvvCf0zWjXsox82Jttx5voHeb
        taqy0vcGyKHIUOFEXPF/q4+rvN6C4r43Wk+CJWOSj3cocSh6fG+uD97ei9vxa7Zs5LoI4M
        LtdwitajE3g0vvnZVLTnJN8ubs1zlyg=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2A92CA3B88;
        Tue,  1 Mar 2022 12:25:20 +0000 (UTC)
Date:   Tue, 1 Mar 2022 13:25:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in
 drain_all_pages
Message-ID: <20220301122520.GB23924@pathway.suse.cz>
References: <20220225012819.1807147-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225012819.1807147-1-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-24 17:28:19, Suren Baghdasaryan wrote:
> Sending as an RFC to confirm if this is the right direction and to
> clarify if other tasks currently executed on mm_percpu_wq should be
> also moved to kthreads. The patch seems stable in testing but I want
> to collect more performance data before submitting a non-RFC version.
> 
> 
> Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> list during direct reclaim. The tasks on a workqueue can be delayed
> by other tasks in the workqueues using the same per-cpu worker pool.
> This results in sizable delays in drain_all_pages when cpus are highly
> contended.
> Memory management operations designed to relieve memory pressure should
> not be allowed to block by other tasks, especially if the task in direct
> reclaim has higher priority than the blocking tasks.
> Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
> kthreads to execute draining tasks.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

The patch looks good to me. See few comments below about things
where I was in doubts. But I do not see any real problem with
this approach.

> ---
>  mm/page_alloc.c | 84 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 70 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..c9ab2cf4b05b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2209,6 +2210,58 @@ _deferred_grow_zone(struct zone *zone, unsigned int order)
>  
>  #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
>  
> +static void drain_local_pages_func(struct kthread_work *work);
> +
> +static int alloc_drain_worker(unsigned int cpu)
> +{
> +	struct pcpu_drain *drain;
> +
> +	mutex_lock(&pcpu_drain_mutex);
> +	drain = per_cpu_ptr(&pcpu_drain, cpu);
> +	drain->worker = kthread_create_worker_on_cpu(cpu, 0, "pg_drain/%u", cpu);
> +	if (IS_ERR(drain->worker)) {
> +		drain->worker = NULL;
> +		pr_err("Failed to create pg_drain/%u\n", cpu);
> +		goto out;
> +	}
> +	/* Ensure the thread is not blocked by normal priority tasks */
> +	sched_set_fifo_low(drain->worker->task);
> +	kthread_init_work(&drain->work, drain_local_pages_func);
> +out:
> +	mutex_unlock(&pcpu_drain_mutex);
> +
> +	return 0;
> +}
> +
> +static int free_drain_worker(unsigned int cpu)
> +{
> +	struct pcpu_drain *drain;
> +
> +	mutex_lock(&pcpu_drain_mutex);
> +	drain = per_cpu_ptr(&pcpu_drain, cpu);
> +	kthread_cancel_work_sync(&drain->work);

I do see not how CPU down was handled in the original code.

Note that workqueues call unbind_workers() when a CPU
is going down. The pending work items might be proceed
on another CPU. From this POV, the new code looks more
safe.

> +	kthread_destroy_worker(drain->worker);
> +	drain->worker = NULL;
> +	mutex_unlock(&pcpu_drain_mutex);
> +
> +	return 0;
> +}
> +
> +static void __init init_drain_workers(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		alloc_drain_worker(cpu);

I though whether this need to be called under cpus_read_lock();
And I think that the code should be safe as it is. There
is this call chain:

  + kernel_init_freeable()
    + page_alloc_init_late()
      + init_drain_workers()

It is called after smp_init() but before the init process
is executed. I guess that nobody could trigger CPU hotplug
at this state. So there there is no need to synchronize
against it.

> +
> +	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					"page_alloc/drain:online",
> +					alloc_drain_worker,
> +					free_drain_worker)) {
> +		pr_err("page_alloc_drain: Failed to allocate a hotplug state\n");

I am not sure if there are any special requirements about the
ordering vs. other CPU hotplug operations.

Just note that the per-CPU workqueues are started/stopped
via CPUHP_AP_WORKQUEUE_ONLINE. They are available slightly
earlier before CPUHP_AP_ONLINE_DYN when the CPU is being
enabled.

> +	}
> +}
> +
>  void __init page_alloc_init_late(void)
>  {
>  	struct zone *zone;

Best Regards,
Petr
