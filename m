Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B1472CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhLMNBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:01:37 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:34163 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhLMNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:01:35 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 8CA201C3EBF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:01:33 +0000 (GMT)
Received: (qmail 20553 invoked from network); 13 Dec 2021 13:01:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Dec 2021 13:01:33 -0000
Date:   Mon, 13 Dec 2021 13:01:31 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211213130131.GQ3366@techsingularity.net>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:58:03PM +0530, Gautham R. Shenoy wrote:
> > On a Zen3 machine running STREAM parallelised with OMP to have on instance
> > per LLC the results and without binding, the results are
> > 
> >                             5.16.0-rc1             5.16.0-rc1
> >                                vanilla       sched-numaimb-v4
> > MB/sec copy-16    166712.18 (   0.00%)   651540.22 ( 290.82%)
> > MB/sec scale-16   140109.66 (   0.00%)   382254.74 ( 172.83%)
> > MB/sec add-16     160791.18 (   0.00%)   623073.98 ( 287.51%)
> > MB/sec triad-16   160043.84 (   0.00%)   633964.52 ( 296.12%)
> 
> 
> Could you please share the size of the stream array ? These numbers
> are higher than what I am observing.
> 

512MB

> > @@ -9280,19 +9286,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  	}
> >  }
> >  
> > -#define NUMA_IMBALANCE_MIN 2
> > -
> >  static inline long adjust_numa_imbalance(int imbalance,
> > -				int dst_running, int dst_weight)
> > +				int dst_running, int dst_weight,
> > +				int imb_numa_nr)
> >  {
> >  	if (!allow_numa_imbalance(dst_running, dst_weight))
> >  		return imbalance;
> >
> 
> if (4 * dst_running >= dst_weight) we return imbalance here. The
> dst_weight here corresponds to the span of the domain, while
> dst_running is the nr_running in busiest.
> 

Yes, once dst_running is high enough, no imbalance is allowed. In
previous versions I changed this but that was a mistake and in this
version, the threshold where imbalance is not allowed remains the same.

> On Zen3, at the top most NUMA domain, the dst_weight = 256 across in
> all the configurations of Nodes Per Socket (NPS) = 1/2/4. There are
> two groups, where each group is a socket. So, unless there are at
> least 64 tasks running in one of the sockets, we would not return
> imbalance here and go to the next step.
> 

Yes

> 
> > -	/*
> > -	 * Allow a small imbalance based on a simple pair of communicating
> > -	 * tasks that remain local when the destination is lightly loaded.
> > -	 */
> > -	if (imbalance <= NUMA_IMBALANCE_MIN)
> > +	if (imbalance <= imb_numa_nr)
> 
> imb_numa_nr in NPS=1 mode, imb_numa_nr would be 4. Since NUMA domains
> don't have PREFER_SIBLING, we would be balancing the number of idle
> CPUs. We will end up doing the imbalance, as long as the difference
> between the idle CPUs is at least 8.
> 
> In NPS=2, imb_numa_nr = 8 for this topmost NUMA domain. So here, we
> will not rebalance unless the difference between the idle CPUs is 16.
> 
> In NPS=4, imb_numa_nr = 16 for this topmost NUMA domain. So, the
> threshold is now bumped up to 32.
> 
> >  		return 0;
> 
> 
> 
> >  
> >  	return imbalance;
> > @@ -9397,7 +9398,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >  		/* Consider allowing a small imbalance between NUMA groups */
> >  		if (env->sd->flags & SD_NUMA) {
> >  			env->imbalance = adjust_numa_imbalance(env->imbalance,
> > -				busiest->sum_nr_running, env->sd->span_weight);
> > +				busiest->sum_nr_running, env->sd->span_weight,
> > +				env->sd->imb_numa_nr);
> >  		}
> >  
> >  		return;
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index d201a7052a29..bacec575ade2 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2242,6 +2242,43 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Calculate an allowed NUMA imbalance such that LLCs do not get
> > +	 * imbalanced.
> > +	 */
> > +	for_each_cpu(i, cpu_map) {
> > +		unsigned int imb = 0;
> > +		unsigned int imb_span = 1;
> > +
> > +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > +			struct sched_domain *child = sd->child;
> > +
> > +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > +				struct sched_domain *top = sd;
> 
> 
> We don't seem to be using top anywhere where sd may not be used since
> we already have variables imb and imb_span to record the
> top->imb_numa_nr and top->span_weight.
> 

Top could have been removed but we might still need it.

> 
> > +				unsigned int llc_sq;
> > +
> > +				/*
> > +				 * nr_llcs = (top->span_weight / llc_weight);
> > +				 * imb = (child_weight / nr_llcs) >> 2
> 
> child here is the llc. So can we use imb = (llc_weight / nr_llcs) >> 2.
> 

That is be clearer.

> > +				 *
> > +				 * is equivalent to
> > +				 *
> > +				 * imb = (llc_weight^2 / top->span_weight) >> 2
> > +				 *
> > +				 */
> > +				llc_sq = child->span_weight * child->span_weight;
> > +
> > +				imb = max(2U, ((llc_sq / top->span_weight) >> 2));
> > +				imb_span = sd->span_weight;
> 
> On Zen3, child_weight (or llc_weight) = 16. llc_sq = 256.
>    with NPS=1
>       top = DIE.
>       top->span_weight = 128. imb = max(2, (256/128) >> 2) = 2. imb_span = 128.
> 
>    with NPS=2
>       top = NODE.
>       top->span_weight = 64. imb = max(2, (256/64) >> 2) = 2. imb_span = 64.
> 
>    with NPS=4      
>       top = NODE.
>       top->span_weight = 32. imb = max(2, (256/32) >> 2) = 2. imb_span = 32.
> 
> On Zen2, child_weight (or llc_weight) = 8. llc_sq = 64.
>    with NPS=1
>       top = DIE.
>       top->span_weight = 128. imb = max(2, (64/128) >> 2) = 2. imb_span = 128.
> 
>    with NPS=2
>       top = NODE.
>       top->span_weight = 64. imb = max(2, (64/64) >> 2) = 2. imb_span = 64.
> 
>    with NPS=4      
>       top = NODE.
>       top->span_weight = 32. imb = max(2, (64/32) >> 2) = 2. imb_span = 32.
> 
> 
> > +
> > +				sd->imb_numa_nr = imb;
> > +			} else {
> > +				sd->imb_numa_nr = imb * (sd->span_weight / imb_span);
> > +			}
> 
> On Zen3,
>    with NPS=1
>         sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/128) = 4.
> 
>    with NPS=2
>         sd=NUMA, sd->span_weight = 128. sd->imb_numa_nr = 2 * (128/64) = 4
> 	sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/64) = 8
> 
>    with NPS=4
>         sd=NUMA, sd->span_weight = 128. sd->imb_numa_nr = 2 * (128/32) = 8
> 	sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/32) = 16
> 
> 
> For Zen2, since the imb_span and imb values are the same as the
> corresponding NPS=x values on Zen3, the imb_numa_nr values are the
> same as well since the corresponding sd->span_weight is the same.
> 
> If we look at the highest NUMA domain, there are two groups in all the
> NPS configurations. There are the same number of LLCs in each of these
> groups across the different NPS configurations (nr_llcs=8 on Zen3, 16
> on Zen2) . However, the imb_numa_nr at this domain varies with the NPS
> value, since we compute the imb_numa_nr value relative to the number
> of "top" domains that can be fit within this NUMA domain. This is
> because the size of the "top" domain varies with the NPS value. This
> shows up in the benchmark results.
> 

This was intentional to have some scaling but based on your results, the
scaling might be at the wrong level.

> 
> 
> The numbers with stream, tbench and YCSB +
> Mongodb are as follows:
> 
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Stream with 16 threads.
> built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
> Zen3, 64C128T per socket, 2 sockets,
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> NPS=1
> Test:     tip/sched/core                 mel-v3                    mel-v4
>  Copy:    113716.62 (0.00 pct)     218961.59 (92.55 pct)     217130.07 (90.93 pct)
> Scale:    110996.89 (0.00 pct)     216674.73 (95.20 pct)     220765.94 (98.89 pct)
>   Add:    124504.19 (0.00 pct)     253461.32 (103.57 pct     260273.88 (109.04 pct)
> Triad:    122890.43 (0.00 pct)     247552.00 (101.44 pct     252615.62 (105.56 pct)
> 
> 
> NPS=2
> Test:     tip/sched/core                 mel-v3                     mel-v4
>  Copy:    58217.00 (0.00 pct)      204630.34 (251.49 pct)     191312.73 (228.62 pct)
> Scale:    55004.76 (0.00 pct)      212142.88 (285.68 pct)     175499.15 (219.06 pct)
>   Add:    63269.04 (0.00 pct)      254752.56 (302.64 pct)     203571.50 (221.75 pct)
> Triad:    62178.25 (0.00 pct)      247290.80 (297.71 pct)     198988.70 (220.02 pct)
> 
> NPS=4
> Test:     tip/sched/core                 mel-v3                     mel-v4
>  Copy:    37986.66 (0.00 pct)      254183.87 (569.13 pct)     48748.87 (28.33 pct)
> Scale:    35471.22 (0.00 pct)      237804.76 (570.41 pct)     48317.82 (36.21 pct)
>   Add:    39303.25 (0.00 pct)      292285.20 (643.66 pct)     54259.59 (38.05 pct)
> Triad:    39319.85 (0.00 pct)      285284.30 (625.54 pct)     54503.98 (38.61 pct)
> 

At minimum, v3 is a failure because a single pair of communicating tasks
were getting split across NUMA domains and the allowed numa imbalance
gets cut off too early because of the change to allow_numa_imbalance.
So while it's a valid comparison, it's definitely not the fix.

Given how you describe NPS, maybe the scaling should only start at the
point where tasks are no longer balanced between sibling domains. Can
you try this? I've only boot tested it at this point. It should work for
STREAM at least but probably not great for tbench.


diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bacec575ade2..1fa3e977521d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2255,26 +2255,38 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
 			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
-				struct sched_domain *top = sd;
+				struct sched_domain *top, *top_p;
 				unsigned int llc_sq;
 
 				/*
-				 * nr_llcs = (top->span_weight / llc_weight);
-				 * imb = (child_weight / nr_llcs) >> 2
+				 * nr_llcs = (sd->span_weight / llc_weight);
+				 * imb = (llc_weight / nr_llcs) >> 2
 				 *
 				 * is equivalent to
 				 *
-				 * imb = (llc_weight^2 / top->span_weight) >> 2
+				 * imb = (llc_weight^2 / sd->span_weight) >> 2
 				 *
 				 */
 				llc_sq = child->span_weight * child->span_weight;
 
-				imb = max(2U, ((llc_sq / top->span_weight) >> 2));
-				imb_span = sd->span_weight;
-
+				imb = max(2U, ((llc_sq / sd->span_weight) >> 2));
 				sd->imb_numa_nr = imb;
+
+				/*
+				 * Set span based on top domain that places
+				 * tasks in sibling domains.
+				 */
+				top = sd;
+				top_p = top->parent;
+				while (top_p && (top_p->flags & SD_PREFER_SIBLING)) {
+					top = top->parent;
+					top_p = top->parent;
+				}
+				imb_span = top_p ? top_p->span_weight : sd->span_weight;
 			} else {
-				sd->imb_numa_nr = imb * (sd->span_weight / imb_span);
+				int factor = max(1U, (sd->span_weight / imb_span));
+
+				sd->imb_numa_nr = imb * factor;
 			}
 		}
 	}
