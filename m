Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E80485141
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiAEKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:42:12 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:40993 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233526AbiAEKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:42:11 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id B16881C39A4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:42:09 +0000 (GMT)
Received: (qmail 22542 invoked from network); 5 Jan 2022 10:42:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Jan 2022 10:42:09 -0000
Date:   Wed, 5 Jan 2022 10:42:07 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20220105104207.GV3366@techsingularity.net>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
 <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com>
 <20211220111243.GS3366@techsingularity.net>
 <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 06:13:15PM +0100, Vincent Guittot wrote:
> > <SNIP>
> >
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
> >
> > <SNIP>
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

It's not necessarily true. allow_numa_imbalanced is checking if
dst_running < imb_numa_nr and adjust_numa_imbalance is checking the
imbalance.

imb_numa_nr = 4
dst_running = 2
imbalance   = 1

In that case, imbalance of 1 is ok, but 2 is not.

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

Yes

> > +                               struct sched_domain *top, *top_p;
> > +                               unsigned int llc_sq;
> > +
> > +                               /*
> > +                                * nr_llcs = (sd->span_weight / llc_weight);
> > +                                * imb = (llc_weight / nr_llcs) >> 2
> 
> it would be good to add a comment to explain why 25% of LLC weight /
> number of LLC in a node is the right value.

This?

                                 * The 25% imbalance is an arbitrary cutoff
                                 * based on SMT-2 to balance between memory
                                 * bandwidth and avoiding premature sharing
                                 * of HT resources and SMT-4 or SMT-8 *may*
                                 * benefit from a different cutoff. nr_llcs
                                 * are accounted for to mitigate premature
                                 * cache eviction due to multiple tasks
                                 * using one cache while a sibling cache
                                 * remains relatively idle.

> For example, why is it better than just 25% of the LLC weight ?

Because lets say there are 2 LLCs then an imbalance based on just the LLC
weight might allow 2 tasks to share one cache while another is idle. This
is the original problem whereby the vanilla imbalance allowed multiple
LLCs on the same node to be overloaded which hurt workloads that prefer
to spread wide.

> Do you want to allow the same imbalance at node level whatever the
> number of LLC in the node ?
> 

At this point, it's less clear how the larger domains should be
balanced and the initial scaling is as good an option as any.

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

Because on AMD Zen3, I saw inconsistent treatment of SD_NUMA prior to
degeneration depending on whether it was NPS-1, NPS-2 or NPS-4 and only
SD_PREFER_SIBLING gave the current results.

-- 
Mel Gorman
SUSE Labs
