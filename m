Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCDB4CB2DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiCBXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCBXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:02 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15902399C4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:43:42 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso3104568oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 15:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0rddFreBeaOz0mWCXtjsYyNHQxD469iCzkybKp8Hm4=;
        b=bdi2mdZmdBDwK297etVaiiS8i1rpVOwfXtd/fBrC04gnu0rrm0SZ9UCxypGt0fpQ1m
         oAP5zfe3a65bhCfaaccs8YI3gxSurH2G1z79A0DiFf5cjyKmPa++VfW5PTTqGiDtUAIz
         VlctI3JTQDbkpACRlq32cwavCiWf/bEDJi6tZ2fb6ApO6tQ07+5wMjL7rMTbXjzxmcEE
         CJJmnVDRqeOdAH28SHojDMJtMWFPqvnX8vq727Y9gVS4ha4uH/FjG9LgJqUN7GewXWQT
         HAoUs9gxSZOHizcBLYlnhL6776op2npl5RaGAbzGuZEtCABIHE3CcaXS3pRuIeoLLAh5
         NgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0rddFreBeaOz0mWCXtjsYyNHQxD469iCzkybKp8Hm4=;
        b=fcti6NR6RyQdB+X33p4lGWAL9mz5Aq71aZkn2N/VWQzQcNa6jwJURhPQb0E7L/EobV
         I01hoIzfvuvnmtxfY6+FlZYyuegYlzeGEbp4+A8SJ1E8CoTbgZ2du6KJcfU2d9T9eJOz
         /7Yuwo43zAPrjoI7yzgG0275dE7vgzZtxlq+dqnjCdfXPjZCwAQk4LJbKMDaLYEhQ+OJ
         +GNyXM4F5v9CVzhSH8dB6sTEpiVvMp2uL9hKhm64Rrwoq/be4hwaeYomga3wuS0QCVoO
         6nraIc5a6dJmCGi75W6pYnQOqdi1kC39NhqXoIrMYd3Uu3sbLq8SxTbho++S2LgHbd7V
         PVfg==
X-Gm-Message-State: AOAM531zqilp9ENNxJQCj3NC7quRY5LF/nlA7a2HpHnJfcwlceSV1s07
        IcP9cgCU9t6AbDBxjFr8k4DskGVuZ7lA8JZ8OmzPUjf07Uy8Dw==
X-Google-Smtp-Source: ABdhPJyF5F9gcr/OgOWt8689+mzsTtT8hB6ASSZynYgU83Bi35DZ52yS6TuxOUB8M9HnuKkmLaaKNcwSMjOijtK5ofg=
X-Received: by 2002:a25:1906:0:b0:61d:9576:754e with SMTP id
 6-20020a251906000000b0061d9576754emr30690643ybz.426.1646262395276; Wed, 02
 Mar 2022 15:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20220225012819.1807147-1-surenb@google.com> <20220302002150.2113-1-hdanton@sina.com>
In-Reply-To: <20220302002150.2113-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 2 Mar 2022 15:06:24 -0800
Message-ID: <CAJuCfpG3TRgs8fA5kpkhrFRcDF=C9VyqLTCz42sxOyKZ0pRaNQ@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in drain_all_pages
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 4:22 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 24 Feb 2022 17:28:19 -0800 Suren Baghdasaryan wrote:
> > Sending as an RFC to confirm if this is the right direction and to
> > clarify if other tasks currently executed on mm_percpu_wq should be
> > also moved to kthreads. The patch seems stable in testing but I want
> > to collect more performance data before submitting a non-RFC version.
> >
> >
> > Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> > list during direct reclaim. The tasks on a workqueue can be delayed
> > by other tasks in the workqueues using the same per-cpu worker pool.
>
> The pending works may be freeing a couple of slabs/pages each. Who knows?

If we are talking about work specifically scheduled on mm_percpu_wq
then apart from drain_all_pages, mm_percpu_wq is used to execute
vmstat_update and lru_add_drain_cpu for drainig pagevecs. If OTOH what
you mean is that the work might be blocked by say kswapd, which is
freeing memory, then sure, who knows...

>
> > This results in sizable delays in drain_all_pages when cpus are highly
> > contended.
> > Memory management operations designed to relieve memory pressure should
> > not be allowed to block by other tasks, especially if the task in direct
> > reclaim has higher priority than the blocking tasks.
>
> Wonder why priority is the right cure to tight memory - otherwise it was
> not a problem given a direct reclaimer of higher priority.
>
> Off topic question - why is it making sense from begining for a task of
> lower priority to peel pages off from another of higher priority if
> priority is considered in direct reclaim?

The way I understood your question is that you are asking why we have
to use workqueues of potentially lower priority to drain pages for a
potentially higher priority process in direct reclaim (which is
blocked waiting for workqueues to complete draining)?
If so, IIUC this mechanism was introduced in
https://lore.kernel.org/all/20170117092954.15413-4-mgorman@techsingularity.net
to avoid draining from IPI context (CC'ing Mel Gorman to correct me if
I'm wrong).
I think the issue here is that in the process we are losing
information about the priority of the process in direct reclaim, which
might lead to priority inversion.

I'm not sure at all if this is the right solution here, hence sending
this as RFC to gather more feedback.
The discussion that lead to this patch starts here:
https://lore.kernel.org/all/YhNTcM9XtqA1zUUi@dhcp22.suse.cz (CC'ing
people who were involved in that discussion)

>
> > Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
> > kthreads to execute draining tasks.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/page_alloc.c | 84 ++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 70 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3589febc6d31..c9ab2cf4b05b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -153,7 +153,8 @@ EXPORT_PER_CPU_SYMBOL(_numa_mem_);
> >  /* work_structs for global per-cpu drains */
> >  struct pcpu_drain {
> >       struct zone *zone;
> > -     struct work_struct work;
> > +     struct kthread_work work;
> > +     struct kthread_worker *worker;
> >  };
> >  static DEFINE_MUTEX(pcpu_drain_mutex);
> >  static DEFINE_PER_CPU(struct pcpu_drain, pcpu_drain);
> > @@ -2209,6 +2210,58 @@ _deferred_grow_zone(struct zone *zone, unsigned int order)
> >
> >  #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
> >
> > +static void drain_local_pages_func(struct kthread_work *work);
> > +
> > +static int alloc_drain_worker(unsigned int cpu)
> > +{
> > +     struct pcpu_drain *drain;
> > +
> > +     mutex_lock(&pcpu_drain_mutex);
>
> Nit, see below.
>
> > +     drain = per_cpu_ptr(&pcpu_drain, cpu);
> > +     drain->worker = kthread_create_worker_on_cpu(cpu, 0, "pg_drain/%u", cpu);
> > +     if (IS_ERR(drain->worker)) {
> > +             drain->worker = NULL;
> > +             pr_err("Failed to create pg_drain/%u\n", cpu);
> > +             goto out;
> > +     }
> > +     /* Ensure the thread is not blocked by normal priority tasks */
> > +     sched_set_fifo_low(drain->worker->task);
> > +     kthread_init_work(&drain->work, drain_local_pages_func);
> > +out:
> > +     mutex_unlock(&pcpu_drain_mutex);
> > +
> > +     return 0;
> > +}
>
> alloc_drain_worker(unsigned int cpu)
>   mutex_lock(&pcpu_drain_mutex);
>   drain->worker = kthread_create_worker_on_cpu(cpu, 0, "pg_drain/%u", cpu);
>     __kthread_create_worker(cpu, flags, namefmt, args);
>       kzalloc(sizeof(*worker), GFP_KERNEL);
>         kmalloc
>           slab_alloc
>             new_slab
>               alloc_pages
>                 __alloc_pages_slowpath
>                   __alloc_pages_direct_reclaim
>                     drain_all_pages(NULL);
>                       __drain_all_pages(zone, false);
>                       if (unlikely(!mutex_trylock(&pcpu_drain_mutex))) {
>                                 if (!zone)
>                                         return;
>                                 mutex_lock(&pcpu_drain_mutex);
>                       }
>
> Either deadlock or no page drained wrt pcpu_drain_mutex if nothing missed.

Thanks for noticing it! I think this can be easily fixed by calling
kthread_create_worker_on_cpu outside of the pcpu_drain_mutex
protection and then assigning the result to drain->worker after taking
pcpu_drain_mutex.
Thanks,
Suren.

>
> > +
> > +static int free_drain_worker(unsigned int cpu)
> > +{
> > +     struct pcpu_drain *drain;
> > +
> > +     mutex_lock(&pcpu_drain_mutex);
> > +     drain = per_cpu_ptr(&pcpu_drain, cpu);
> > +     kthread_cancel_work_sync(&drain->work);
> > +     kthread_destroy_worker(drain->worker);
> > +     drain->worker = NULL;
> > +     mutex_unlock(&pcpu_drain_mutex);
> > +
> > +     return 0;
> > +}
> > +
> > +static void __init init_drain_workers(void)
> > +{
> > +     unsigned int cpu;
> > +
> > +     for_each_online_cpu(cpu)
> > +             alloc_drain_worker(cpu);
> > +
> > +     if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > +                                     "page_alloc/drain:online",
> > +                                     alloc_drain_worker,
> > +                                     free_drain_worker)) {
> > +             pr_err("page_alloc_drain: Failed to allocate a hotplug state\n");
> > +     }
> > +}
> > +
> >  void __init page_alloc_init_late(void)
> >  {
> >       struct zone *zone;
> > @@ -2245,6 +2298,8 @@ void __init page_alloc_init_late(void)
> >
> >       for_each_populated_zone(zone)
> >               set_zone_contiguous(zone);
> > +
> > +     init_drain_workers();
> >  }
> >
> >  #ifdef CONFIG_CMA
> > @@ -3144,7 +3199,7 @@ void drain_local_pages(struct zone *zone)
> >               drain_pages(cpu);
> >  }
> >
> > -static void drain_local_pages_wq(struct work_struct *work)
> > +static void drain_local_pages_func(struct kthread_work *work)
> >  {
> >       struct pcpu_drain *drain;
> >
> > @@ -3175,6 +3230,7 @@ static void drain_local_pages_wq(struct work_struct *work)
> >  static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
> >  {
> >       int cpu;
> > +     struct pcpu_drain *drain;
> >
> >       /*
> >        * Allocate in the BSS so we won't require allocation in
> > @@ -3182,13 +3238,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
> >        */
> >       static cpumask_t cpus_with_pcps;
> >
> > -     /*
> > -      * Make sure nobody triggers this path before mm_percpu_wq is fully
> > -      * initialized.
> > -      */
> > -     if (WARN_ON_ONCE(!mm_percpu_wq))
> > -             return;
> > -
> >       /*
> >        * Do not drain if one is already in progress unless it's specific to
> >        * a zone. Such callers are primarily CMA and memory hotplug and need
> > @@ -3238,14 +3287,21 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
> >       }
> >
> >       for_each_cpu(cpu, &cpus_with_pcps) {
> > -             struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
> > +             drain = per_cpu_ptr(&pcpu_drain, cpu);
> >
> >               drain->zone = zone;
> > -             INIT_WORK(&drain->work, drain_local_pages_wq);
> > -             queue_work_on(cpu, mm_percpu_wq, &drain->work);
> > +             if (likely(drain->worker))
> > +                     kthread_queue_work(drain->worker, &drain->work);
> > +     }
> > +     /* Wait for kthreads to finish or drain itself */
> > +     for_each_cpu(cpu, &cpus_with_pcps) {
> > +             drain = per_cpu_ptr(&pcpu_drain, cpu);
> > +
> > +             if (likely(drain->worker))
> > +                     kthread_flush_work(&drain->work);
> > +             else
> > +                     drain_local_pages_func(&drain->work);
> >       }
> > -     for_each_cpu(cpu, &cpus_with_pcps)
> > -             flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
> >
> >       mutex_unlock(&pcpu_drain_mutex);
> >  }
> > --
> > 2.35.1.574.g5d30c73bfb-goog
> >
> >
>
