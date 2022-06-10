Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD819545AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiFJECV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiFJECS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:02:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BECAE274
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:01:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v1so40427199ejg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 21:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyqT7+Dz27sfCTXwbNK+V2Qe/Npol6CsUzEm++LhrJc=;
        b=oGZ/AM+FKQbuW9jA3r2TLBLueApWlc7Uu6u98T85LkwdHyPnSrwX7bQlx7hJEEU1Cm
         ucy4eYCQFuK3tvNQJOD2yLysAQaVy0GvvIMozw5XOTS7STolKow6+/+wRoFEgc5Ww1B4
         9q+PKTs2ylXWfTAmGTlbRrMFKpn3533ww30Slu8xZ+K0CE9wdoHZ6jQ/BzGSenPMlTdV
         T2w1w+2d+rR+R9gtWe+Y6X/sTx3p6ZaANl2xlGq/Bc7pogZkH5VnwvaNHh5AeKeGdPSH
         T2AMERrUJ1x0aTAhdQ9I5JDH5ZLQZUzAwvu/81yY4MGPyphyNRjQntrRV3fhR5g+xSxz
         3cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyqT7+Dz27sfCTXwbNK+V2Qe/Npol6CsUzEm++LhrJc=;
        b=FH+sz+gWq5s2w5FAvTPbYee0t6AjpxBhUvlUMsILKC6PtWA95tFLVnvu6jrkwx1IMC
         wxMTvn1/81W8YXNn5FiwlnXj20s9ZmEUHo1CqQ71a1DWCfG4lrj3HtXyMT3bH+/cj9Wg
         U8L2ICOyy6U/a6JJgG6TDO3QoWLVTBvqg9P2/kKsozRx13twzcc1Ovu0PPlyptXfvLk4
         aUXFe59kXzrZLr0xBoRo9306AzGscSgu6kyKe5KOAtlrtoD9pdWeORuRTrTbFdZMmCF7
         cgsx3rgwzZ0c857ryrkB//+340ttuT6zEWtI0ypd4wBPN2rhd5rr3siL9/V7hz1pFyOB
         lKSA==
X-Gm-Message-State: AOAM5334UqjlbDHFWTbkiiI6BLjFkGqmqtNPZ5crEOYhYijB382f5ILI
        XQqZ0zYi7ZUljerIcY7o4QHkhHml+Y4cxE6VoVA=
X-Google-Smtp-Source: ABdhPJwh5Fa/fwWzAPcIkQhhZ8E7nVBWvJb0amkcOKUO/hqvHnF16u3vn//FNp6YBkjn7djUFuDcz2Mpbs37dSlQhEc=
X-Received: by 2002:a17:906:3e12:b0:704:6e14:9726 with SMTP id
 k18-20020a1709063e1200b007046e149726mr40078863eji.457.1654833704618; Thu, 09
 Jun 2022 21:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-3-yangyicong@hisilicon.com> <c3fa2b4f5884e5ad4efda48b1bb2ab4f7a2e532a.camel@linux.intel.com>
In-Reply-To: <c3fa2b4f5884e5ad4efda48b1bb2ab4f7a2e532a.camel@linux.intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 10 Jun 2022 16:01:33 +1200
Message-ID: <CAGsJ_4weF6DzWBwUoOs27VJ18Zccu++cMhNZfiTou6347c0w4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>, hesham.almatary@huawei.com,
        john.garry@huawei.com, Yang Shen <shenyang39@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:47 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Thu, 2022-06-09 at 20:06 +0800, Yicong Yang wrote:
> > From: Barry Song <song.bao.hua@hisilicon.com>
> >
> > For platforms having clusters like Kunpeng920, CPUs within the same cluster
> > have lower latency when synchronizing and accessing shared resources like
> > cache. Thus, this patch tries to find an idle cpu within the cluster of the
> > target CPU before scanning the whole LLC to gain lower latency.
> >
> > Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this patch
> > doesn't consider SMT for this moment.
> >
> > Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> > numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> >
> > With this patch, We noticed enhancement on tbench within one numa or cross
> > two numa.
> >
> > On numa 0:
> >                             5.19-rc1                patched
> > Hmean     1        350.27 (   0.00%)      406.88 *  16.16%*
> > Hmean     2        702.01 (   0.00%)      808.22 *  15.13%*
> > Hmean     4       1405.14 (   0.00%)     1614.34 *  14.89%*
> > Hmean     8       2830.53 (   0.00%)     3169.02 *  11.96%*
> > Hmean     16      5597.95 (   0.00%)     6224.20 *  11.19%*
> > Hmean     32     10537.38 (   0.00%)    10524.97 *  -0.12%*
> > Hmean     64      8366.04 (   0.00%)     8437.41 *   0.85%*
> > Hmean     128     7060.87 (   0.00%)     7150.25 *   1.27%*
> >
> > On numa 0-1:
> >                             5.19-rc1                patched
> > Hmean     1        346.11 (   0.00%)      408.47 *  18.02%*
> > Hmean     2        693.34 (   0.00%)      805.78 *  16.22%*
> > Hmean     4       1384.96 (   0.00%)     1602.49 *  15.71%*
> > Hmean     8       2699.45 (   0.00%)     3069.98 *  13.73%*
> > Hmean     16      5327.11 (   0.00%)     5688.19 *   6.78%*
> > Hmean     32     10019.10 (   0.00%)    11862.56 *  18.40%*
> > Hmean     64     13850.57 (   0.00%)    17748.54 *  28.14%*
> > Hmean     128    12498.25 (   0.00%)    15541.59 *  24.35%*
> > Hmean     256    11195.77 (   0.00%)    13854.06 *  23.74%*
>
> Yicong,
>
> Have you tried any workload where tasks don't share data
> with each other but have sleep/wakeup?  That's the case
> where we actually want to spread the tasks out among the clusters
> to void contention for L2 cache.

guess there isn't a way to universally win in term of the modifcation of
scheduling policies. The good news is that  as long as LB is still there,
tasks still get a good chance to spread if they stop talking to each other
again and again after a small talk.

if tasks do like spreading but keep in constant touch with each other, we
may have to interfere with them from userspace by openMP, numactl or
taskset etc. as WAKE_AFFINE is always an enemy for this requirement.

>
> Will be nice to make sure there's no regression there for
> such workload.
>
> Code itself looks good.
>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>
> >
> > Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 41 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 77b2048a9326..6d173e196ad3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6327,6 +6327,40 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> >
> >  #endif /* CONFIG_SCHED_SMT */
> >
> > +#ifdef CONFIG_SCHED_CLUSTER
> > +/*
> > + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> > + */
> > +static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
> > +                            int target, int *nr)
> > +{
> > +     struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> > +     int cpu, idle_cpu;
> > +
> > +     /* TODO: Support SMT system with cluster topology */
> > +     if (!sched_smt_active() && sd) {
> > +             for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> > +                     if (!--*nr)
> > +                             break;
> > +
> > +                     idle_cpu = __select_idle_cpu(cpu, p);
> > +                     if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > +                             return idle_cpu;
> > +             }
> > +
> > +             cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> > +     }
> > +
> > +     return -1;
> > +}
> > +#else
> > +static inline int scan_cluster(struct task_struct *p, struct cpumask *cpus,
> > +                            int target, int *nr)
> > +{
> > +     return -1;
> > +}
> > +#endif
> > +
> >  /*
> >   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
> >   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> > @@ -6375,6 +6409,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >               time = cpu_clock(this);
> >       }
> >
> > +     idle_cpu = scan_cluster(p, cpus, target, &nr);
> > +     if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > +             return idle_cpu;
> > +
> >       for_each_cpu_wrap(cpu, cpus, target + 1) {
> >               if (has_idle_core) {
> >                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > @@ -6382,7 +6420,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >                               return i;
> >
> >               } else {
> > -                     if (!--nr)
> > +                     if (--nr <= 0)
> >                               return -1;
> >                       idle_cpu = __select_idle_cpu(cpu, p);
> >                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > @@ -6481,7 +6519,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >       /*
> >        * If the previous CPU is cache affine and idle, don't be stupid:
> >        */
> > -     if (prev != target && cpus_share_cache(prev, target) &&
> > +     if (prev != target && cpus_share_resources(prev, target) &&
> >           (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> >           asym_fits_capacity(task_util, prev))
> >               return prev;
> > @@ -6507,7 +6545,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >       p->recent_used_cpu = prev;
> >       if (recent_used_cpu != prev &&
> >           recent_used_cpu != target &&
> > -         cpus_share_cache(recent_used_cpu, target) &&
> > +         cpus_share_resources(recent_used_cpu, target) &&
> >           (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> >           cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
> >           asym_fits_capacity(task_util, recent_used_cpu)) {
>

Thanks
Barry
