Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38EC4C9793
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiCAVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiCAVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:13:15 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145F625A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:12:31 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2dbd97f9bfcso41075727b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLTMGPlk7m9BUyey2nJimGnjymGnIfWBWhbFIZII+Cg=;
        b=bsXrQVc+XxaRTYpztFqa81b3Vx8euJnUzbRJl6nb/1/B9k1+VBpi9QcxKe3T9QfMKO
         6bMfYTAYERmvRHNLW28I3N6SE7+zW12oJ3PH/zS4Nfprv7wUMFh93pqeo06jmIo3YVmz
         yoL6E7hX2VMI4rgzgn8UhOv3eWKPeOtcFrZDY5gchLbOcP26ywBGdWR2EID68APeNG32
         hXhwT9nK/1nCLckLsghw6bO4YI5joM7h7ceZ/AG1yQUEb1j+AgcgmRA17cIe+dkYFESU
         tiBlZRwYYJ9nbINAVpSjBWU+IRkxj4CxNTksScBzv1F+LXd8fskEALroe5PYtWh3IUym
         AT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLTMGPlk7m9BUyey2nJimGnjymGnIfWBWhbFIZII+Cg=;
        b=ZGOwk/HGNomv+LsY2nF8lKdZkkGqOM3sNvuyKWVoQGJmj0DpRLMnjappuqKJC3jRxo
         VRrs4PcTpDK0mLAuSHKdHnjvfAPx1Sm5Dhwt4PjOyu2OTAkWi3zObFGS/WU78q7gfbPs
         kRK4VWHhb45C+hBgYojtbVoRTMk27LlSj1o1g3AIbXPpVZxNBHbr/DqyHvhcDWPmIAu6
         bDNFZe867cFSgJ++QPReF/mJx0F9D/qgUH8cP/5idZGAxmnTcXGFu2T3ZFWYqwEOwL00
         hKIzkH42ENiEFC+jdjY+TBG3t0h+iZtzi+LpoYEL3Balpmmdio7Zfv9eS8hs0CjpEmSa
         SJaQ==
X-Gm-Message-State: AOAM533G8AziZa15h4aIM0JLJDpTks8E80mXoSTIShcvI7ig7gfqXPSZ
        D1h6kotEbck8UZvu4tTUx3HUqzbL5NsUGjPqt+/9J14kpeIN+A==
X-Google-Smtp-Source: ABdhPJwjyao+3UgsRIhwaiYtGiQu68noHsiYWnmRF190avJuNzhOLjV5QYk16k3JrPaACcrg/WsHdFmfSbXwKtZIEAQ=
X-Received: by 2002:a81:6982:0:b0:2db:2a9f:302c with SMTP id
 e124-20020a816982000000b002db2a9f302cmr19893143ywc.237.1646169150679; Tue, 01
 Mar 2022 13:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20220225012819.1807147-1-surenb@google.com> <20220301122520.GB23924@pathway.suse.cz>
In-Reply-To: <20220301122520.GB23924@pathway.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 1 Mar 2022 13:12:19 -0800
Message-ID: <CAJuCfpGYugkzoGvD4cXBLBWxUfwcge5Gx9PTEk-EuSAX=KSMzw@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in drain_all_pages
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
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

On Tue, Mar 1, 2022 at 4:25 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2022-02-24 17:28:19, Suren Baghdasaryan wrote:
> > Sending as an RFC to confirm if this is the right direction and to
> > clarify if other tasks currently executed on mm_percpu_wq should be
> > also moved to kthreads. The patch seems stable in testing but I want
> > to collect more performance data before submitting a non-RFC version.
> >
> >
> > Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> > list during direct reclaim. The tasks on a workqueue can be delayed
> > by other tasks in the workqueues using the same per-cpu worker pool.
> > This results in sizable delays in drain_all_pages when cpus are highly
> > contended.
> > Memory management operations designed to relieve memory pressure should
> > not be allowed to block by other tasks, especially if the task in direct
> > reclaim has higher priority than the blocking tasks.
> > Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
> > kthreads to execute draining tasks.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> The patch looks good to me. See few comments below about things
> where I was in doubts. But I do not see any real problem with
> this approach.

Thanks for the review, Petr. One question inline.

Other than that I would like to check if:
1. Using low priority FIFO for these kthreads is warranted. From
https://lore.kernel.org/all/CAEe=Sxmow-jx60cDjFMY7qi7+KVc+BT++BTdwC5+G9E=1soMmQ@mail.gmail.com/#t
my understanding was that we want this work to be done by RT
kthread_worker but maybe that's not appropriate here?
2. Do we want to move any other work done on mm_percpu_wq
(vmstat_work, lru_add_drain_all) to these kthreads?
If what I have currently is ok, I'll post the first version.
Thanks,
Suren.



>
> > ---
> >  mm/page_alloc.c | 84 ++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 70 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3589febc6d31..c9ab2cf4b05b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
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
> > +
> > +static int free_drain_worker(unsigned int cpu)
> > +{
> > +     struct pcpu_drain *drain;
> > +
> > +     mutex_lock(&pcpu_drain_mutex);
> > +     drain = per_cpu_ptr(&pcpu_drain, cpu);
> > +     kthread_cancel_work_sync(&drain->work);
>
> I do see not how CPU down was handled in the original code.
>
> Note that workqueues call unbind_workers() when a CPU
> is going down. The pending work items might be proceed
> on another CPU. From this POV, the new code looks more
> safe.
>
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
>
> I though whether this need to be called under cpus_read_lock();
> And I think that the code should be safe as it is. There
> is this call chain:
>
>   + kernel_init_freeable()
>     + page_alloc_init_late()
>       + init_drain_workers()
>
> It is called after smp_init() but before the init process
> is executed. I guess that nobody could trigger CPU hotplug
> at this state. So there there is no need to synchronize
> against it.

Should I add a comment here to describe why we don't need
cpus_read_lock here (due to init process not being active at this
time)?

>
> > +
> > +     if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > +                                     "page_alloc/drain:online",
> > +                                     alloc_drain_worker,
> > +                                     free_drain_worker)) {
> > +             pr_err("page_alloc_drain: Failed to allocate a hotplug state\n");
>
> I am not sure if there are any special requirements about the
> ordering vs. other CPU hotplug operations.
>
> Just note that the per-CPU workqueues are started/stopped
> via CPUHP_AP_WORKQUEUE_ONLINE. They are available slightly
> earlier before CPUHP_AP_ONLINE_DYN when the CPU is being
> enabled.
>
> > +     }
> > +}
> > +
> >  void __init page_alloc_init_late(void)
> >  {
> >       struct zone *zone;
>
> Best Regards,
> Petr
