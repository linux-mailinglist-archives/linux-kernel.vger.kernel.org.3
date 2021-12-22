Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4732647CE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbhLVIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236120AbhLVIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640163166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wyGBU4x7z22CjQ4XFBuOGlIjfzvNCCP5PYPNEKcgXfs=;
        b=MG1IuB8gJLikY2vYrxmCRJyg8ZfJE7kkmIJVFWA+hmICDyj5mTmqCAKhhnOBn3q1Ja/Abw
        Fs7Cn2EeMBT8WmfP60a4YiOYSdINd/a3KBOrht18iRwWfhMWqLN2aCgGzH5TyegYf+DQlx
        Nz5Z6ImkwY8n3U3F8nHGOkfJ9/CkGms=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-OtmCCaC0PDC_WAnb8-oqyg-1; Wed, 22 Dec 2021 03:52:45 -0500
X-MC-Unique: OtmCCaC0PDC_WAnb8-oqyg-1
Received: by mail-yb1-f199.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso2820548ybj.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyGBU4x7z22CjQ4XFBuOGlIjfzvNCCP5PYPNEKcgXfs=;
        b=RD63TY9GCIAhAemZE8n0Hppkite49UXGEz25pT9IjJUsEE7dYF7yX2+AmgBWyFLBYb
         O7hEvZgfxtkMeLjVQY2VaSMvp9hKlKh3VucJ+jC768XSWR1OxG6TXK81pm7U8O6hv6lG
         3Bko5NBp/N5WaCV4UuEwwVvW46SLPeZ7781YA2hDZTgntcmO0eptmjL6vzjyH66QST/G
         NQp1Q4IVhN+WC1u1EjzK1FqVs1F+hZOlaY7RTG9YlXaNmUAJ1b+jck3lkelxNWIZusBA
         Hn3WN66dGWaD2ptSznoHQVhYROXSQ7YU4V0VCafW9nEMkKdkpUYI/mMyMyt6+/XdDEPb
         dGvA==
X-Gm-Message-State: AOAM532ChJ1I7YRJjDxcjq0/pj4K3w1NXFbXl+qIgcG/mnFagEip9WK3
        BL6/o1DNNrP1VPK6gT/wxHE26biUWqGacy377B3iHOkwg7WvRgbnFJY2xLSA5cR2ygiz92e51BO
        YHVtGbPr/yd1lskcKd8k+LmtUMZYUmMvwmoXWkYnC
X-Received: by 2002:a25:800f:: with SMTP id m15mr2803739ybk.525.1640163164642;
        Wed, 22 Dec 2021 00:52:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/U7dP56gQtCDooqV3XVTGtdJToxC5nefDXgm0NCDfYgAyJWUo/l41sXqBipIKl+yqj0Ddn5NPFXpZPgLHDpI=
X-Received: by 2002:a25:800f:: with SMTP id m15mr2803716ybk.525.1640163164351;
 Wed, 22 Dec 2021 00:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net> <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net> <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com> <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com> <20211220111243.GS3366@techsingularity.net>
 <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com>
In-Reply-To: <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Wed, 22 Dec 2021 09:52:33 +0100
Message-ID: <CAE4VaGAmM=ecxS_2xnSJyvU=K02AktBk2wR6cuE98c5FQO55Qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Philip Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

we have tested the performance impact of this patch and we see
performance drops up to 60% with the OpenMP implementation of the NAS
parallel benchmark.

Example of results:
2x AMD EPYC 7313 16-Core server (total 32 cores, 64 CPUs)

                                        5.16.0-rc5
5.16.0-rc5                 Difference
                                         (vanilla)             + v4 of
the patch           in %
                                         Mop/s total           Mop/s total
sp_C_x, 8 threads            36316.1               12939.6
         -64%
sp_C_x, 16 threads          64790.2               23968.0
        -63%
sp_C_x, 32 threads          67205.5               48891.4
        -27%

Other NAS subtests (bt_C_x, is_D_x, ua_C_x) show similar results.

It seems like the allowed imbalance is too large and the negative
impact on workloads that prefer to span wide across all NUMA nodes is
too large.

Thanks
Jirka


On Tue, Dec 21, 2021 at 6:13 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 20 Dec 2021 at 12:12, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > (sorry for the delay, was offline for a few days)
> >
> > On Fri, Dec 17, 2021 at 12:03:06AM +0530, Gautham R. Shenoy wrote:
> > > Hello Mel,
> > >
> > > On Wed, Dec 15, 2021 at 12:25:50PM +0000, Mel Gorman wrote:
> > > > On Wed, Dec 15, 2021 at 05:22:30PM +0530, Gautham R. Shenoy wrote:
> > >
> > > [..SNIP..]
> > >
>
> [snip]
>
> >
> > To avoid the corner case, we'd need to explicitly favour spreading early
> > and assume wakeup will pull communicating tasks together and NUMA
> > balancing migrate the data after some time which looks like
> >
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index c07bfa2d80f2..54f5207154d3 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -93,6 +93,7 @@ struct sched_domain {
> >         unsigned int busy_factor;       /* less balancing by factor if busy */
> >         unsigned int imbalance_pct;     /* No balance until over watermark */
> >         unsigned int cache_nice_tries;  /* Leave cache hot tasks for # tries */
> > +       unsigned int imb_numa_nr;       /* Nr imbalanced tasks allowed between nodes */
>
> So now you compute an allowed imbalance level instead of using
> 25% of sd->span_weight
> or
> 25% of busiest->group_weight
>
> And you adjust this new imb_numa_nr according to the topology.
>
> That makes sense.
>
> >
> >         int nohz_idle;                  /* NOHZ IDLE status */
> >         int flags;                      /* See SD_* */
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0a969affca76..df0e84462e62 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1489,6 +1489,7 @@ struct task_numa_env {
> >
> >         int src_cpu, src_nid;
> >         int dst_cpu, dst_nid;
> > +       int imb_numa_nr;
> >
> >         struct numa_stats src_stats, dst_stats;
> >
> > @@ -1504,7 +1505,8 @@ static unsigned long cpu_load(struct rq *rq);
> >  static unsigned long cpu_runnable(struct rq *rq);
> >  static unsigned long cpu_util(int cpu);
> >  static inline long adjust_numa_imbalance(int imbalance,
> > -                                       int dst_running, int dst_weight);
> > +                                       int dst_running,
> > +                                       int imb_numa_nr);
> >
> >  static inline enum
> >  numa_type numa_classify(unsigned int imbalance_pct,
> > @@ -1885,7 +1887,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
> >                 dst_running = env->dst_stats.nr_running + 1;
> >                 imbalance = max(0, dst_running - src_running);
> >                 imbalance = adjust_numa_imbalance(imbalance, dst_running,
> > -                                                       env->dst_stats.weight);
> > +                                                 env->imb_numa_nr);
> >
> >                 /* Use idle CPU if there is no imbalance */
> >                 if (!imbalance) {
> > @@ -1950,8 +1952,10 @@ static int task_numa_migrate(struct task_struct *p)
> >          */
> >         rcu_read_lock();
> >         sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
> > -       if (sd)
> > +       if (sd) {
> >                 env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
> > +               env.imb_numa_nr = sd->imb_numa_nr;
> > +       }
> >         rcu_read_unlock();
> >
> >         /*
> > @@ -9050,9 +9054,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
> >   * This is an approximation as the number of running tasks may not be
> >   * related to the number of busy CPUs due to sched_setaffinity.
> >   */
> > -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> > +static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
> >  {
> > -       return (dst_running < (dst_weight >> 2));
> > +       return dst_running < imb_numa_nr;
> >  }
> >
> >  /*
> > @@ -9186,12 +9190,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >                                 return idlest;
> >  #endif
> >                         /*
> > -                        * Otherwise, keep the task on this node to stay close
> > -                        * its wakeup source and improve locality. If there is
> > -                        * a real need of migration, periodic load balance will
> > -                        * take care of it.
> > +                        * Otherwise, keep the task on this node to stay local
> > +                        * to its wakeup source if the number of running tasks
> > +                        * are below the allowed imbalance. If there is a real
> > +                        * need of migration, periodic load balance will take
> > +                        * care of it.
> >                          */
> > -                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> > +                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->imb_numa_nr))
> >                                 return NULL;
> >                 }
> >
> > @@ -9280,19 +9285,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >         }
> >  }
> >
> > -#define NUMA_IMBALANCE_MIN 2
> > -
> >  static inline long adjust_numa_imbalance(int imbalance,
> > -                               int dst_running, int dst_weight)
> > +                               int dst_running, int imb_numa_nr)
> >  {
> > -       if (!allow_numa_imbalance(dst_running, dst_weight))
> > +       if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> >                 return imbalance;
> >
> > -       /*
> > -        * Allow a small imbalance based on a simple pair of communicating
> > -        * tasks that remain local when the destination is lightly loaded.
> > -        */
> > -       if (imbalance <= NUMA_IMBALANCE_MIN)
> > +       if (imbalance <= imb_numa_nr)
>
> Isn't this always true ?
>
> imbalance is "always" < dst_running as imbalance is usually the number
> of these tasks that we would like to migrate
>
>
> >                 return 0;
> >
> >         return imbalance;
> > @@ -9397,7 +9396,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >                 /* Consider allowing a small imbalance between NUMA groups */
> >                 if (env->sd->flags & SD_NUMA) {
> >                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> > -                               busiest->sum_nr_running, env->sd->span_weight);
> > +                               busiest->sum_nr_running, env->sd->imb_numa_nr);
> >                 }
> >
> >                 return;
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index d201a7052a29..1fa3e977521d 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2242,6 +2242,55 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >                 }
> >         }
> >
> > +       /*
> > +        * Calculate an allowed NUMA imbalance such that LLCs do not get
> > +        * imbalanced.
> > +        */
> > +       for_each_cpu(i, cpu_map) {
> > +               unsigned int imb = 0;
> > +               unsigned int imb_span = 1;
> > +
> > +               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > +                       struct sched_domain *child = sd->child;
> > +
> > +                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > +                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
>
> sched_domains have not been degenerated yet so you found here the DIE domain
>
> > +                               struct sched_domain *top, *top_p;
> > +                               unsigned int llc_sq;
> > +
> > +                               /*
> > +                                * nr_llcs = (sd->span_weight / llc_weight);
> > +                                * imb = (llc_weight / nr_llcs) >> 2
>
> it would be good to add a comment to explain why 25% of LLC weight /
> number of LLC in a node is the right value.
> For example, why is it better than just 25% of the LLC weight ?
> Do you want to allow the same imbalance at node level whatever the
> number of LLC in the node ?
>
> > +                                *
> > +                                * is equivalent to
> > +                                *
> > +                                * imb = (llc_weight^2 / sd->span_weight) >> 2
> > +                                *
> > +                                */
> > +                               llc_sq = child->span_weight * child->span_weight;
> > +
> > +                               imb = max(2U, ((llc_sq / sd->span_weight) >> 2));
> > +                               sd->imb_numa_nr = imb;
> > +
> > +                               /*
> > +                                * Set span based on top domain that places
> > +                                * tasks in sibling domains.
> > +                                */
> > +                               top = sd;
> > +                               top_p = top->parent;
> > +                               while (top_p && (top_p->flags & SD_PREFER_SIBLING)) {
>
> Why are you looping on SD_PREFER_SIBLING  instead of SD_NUMA  ?
> Apart the heterogeneous domain (SD_ASYM_CPUCAPACITY) but I'm not sure
> that you want to take this case into account, only numa node don't
> have SD_PREFER_SIBLING
>
> > +                                       top = top->parent;
> > +                                       top_p = top->parent;
> > +                               }
> > +                               imb_span = top_p ? top_p->span_weight : sd->span_weight;
> > +                       } else {
> > +                               int factor = max(1U, (sd->span_weight / imb_span));
> > +
> > +                               sd->imb_numa_nr = imb * factor;
> > +                       }
> > +               }
> > +       }
> > +
> >         /* Calculate CPU capacity for physical packages and nodes */
> >         for (i = nr_cpumask_bits-1; i >= 0; i--) {
> >                 if (!cpumask_test_cpu(i, cpu_map))
>


-- 
-Jirka

