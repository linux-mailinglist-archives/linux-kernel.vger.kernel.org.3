Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B2647A86C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhLTLMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:12:47 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:40071 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhLTLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:12:46 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id D997D1C4883
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:12:44 +0000 (GMT)
Received: (qmail 3137 invoked from network); 20 Dec 2021 11:12:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Dec 2021 11:12:44 -0000
Date:   Mon, 20 Dec 2021 11:12:43 +0000
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
Message-ID: <20211220111243.GS3366@techsingularity.net>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
 <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the delay, was offline for a few days)

On Fri, Dec 17, 2021 at 12:03:06AM +0530, Gautham R. Shenoy wrote:
> Hello Mel,
> 
> On Wed, Dec 15, 2021 at 12:25:50PM +0000, Mel Gorman wrote:
> > On Wed, Dec 15, 2021 at 05:22:30PM +0530, Gautham R. Shenoy wrote:
> 
> [..SNIP..]
> 
> > > On a 2 Socket Zen3:
> > > 
> > > NPS=1
> > >    child=MC, llc_weight=16, sd=DIE. sd->span_weight=128 imb=max(2U, (16*16/128) / 4)=2
> > >    top_p = NUMA, imb_span = 256.
> > > 
> > >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/256) = 2
> > > 
> > > NPS=2
> > >    child=MC, llc_weight=16, sd=NODE. sd->span_weight=64 imb=max(2U, (16*16/64) / 4) = 2
> > >    top_p = NUMA, imb_span = 128.
> > > 
> > >    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
> > >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> > > 
> > > NPS=4:
> > >    child=MC, llc_weight=16, sd=NODE. sd->span_weight=32 imb=max(2U, (16*16/32) / 4) = 2
> > >    top_p = NUMA, imb_span = 128.
> > > 
> > >    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
> > >    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> > > 
> > > Again, we will be more aggressively load balancing across the two
> > > sockets in NPS=1 mode compared to NPS=2/4.
> > > 
> > 
> > Yes, but I felt it was reasonable behaviour because we have to strike
> > some sort of balance between allowing a NUMA imbalance up to a point
> > to prevent communicating tasks being pulled apart and v3 broke that
> > completely. There will always be a tradeoff between tasks that want to
> > remain local to each other and others that prefer to spread as wide as
> > possible as quickly as possible.
> 
> I agree with this argument that we want to be conservative while
> pulling tasks across NUMA domains. My point was that the threshold at
> the NUMA domain that spans the 2 sockets is lower for NPS=1
> (imb_numa_nr = 2) when compared to the threshold for the same NUMA
> domain when NPS=2/4 (imb_numa_nr = 4).
> 

Is that a problem though? On an Intel machine with sub-numa clustering,
the distances are 11 and 21 for a "node" that is the split cache and the
remote node respectively.

> Irrespective of what NPS mode we are operating in, the NUMA distance
> between the two sockets is 32 on Zen3 systems. Hence shouldn't the
> thresholds be the same for that level of NUMA? 
> 

Maybe, but then it is not a property of the sched_domain and instead
needs to account for distance when balancing between two nodes that may
be varying distances from each other.

> Would something like the following work ?
> 
> if (sd->flags & SD_NUMA) {
> 
>    /* We are using the child as a proxy for the group. */
>    group_span = sd->child->span_weight;
>    sd_distance = /* NUMA distance at this sd level */
> 

NUMA distance relative to what? On Zen, the distance to a remote node may
be fixed but on topologies with multiple nodes that are not fully linked
to every other node by one hop, the same is not true.

>    /* By default we set the threshold to 1/4th the sched-group span. */
>    imb_numa_shift = 2;
> 
>    /*
>     * We can be a little aggressive if the cost of migrating tasks
>     * across groups of this NUMA level is not high.
>     * Assuming 
>     */
>    
>    if (sd_distance < REMOTE_DISTANCE)
>       imb_numa_shift++;
> 

The distance would have to be accounted for elsewhere because here we
are considering one node in isolation, not relative to other nodes.

>    /*
>     * Compute the number of LLCs in each group.
>     * More the LLCs, more aggressively we migrate across
>     * the groups at this NUMA sd.
>     */
>     nr_llcs = group_span/llc_size;
> 
>     sd->imb_numa_nr = max(2U, (group_span / nr_llcs) >> imb_numa_shift);
> }
> 

Same, any adjustment would have to happen during load balancing taking
into account the relatively NUMA distances. I'm not necessarily opposed
but it would be a separate patch.

> > > <SNIP>
> > > If we retain the (2,4) thresholds from v4.1 but use them in
> > > allow_numa_imbalance() as in v3 we get
> > > 
> > > NPS=4
> > > Test:	 mel-v4.2
> > >  Copy:	 225860.12 (498.11%)
> > > Scale:	 227869.07 (572.58%)
> > >   Add:	 278365.58 (624.93%)
> > > Triad:	 264315.44 (596.62%)
> > > 
> > 
> > The potential problem with this is that it probably will work for
> > netperf when it's a single communicating pair but may not work as well
> > when there are multiple communicating pairs or a number of communicating
> > tasks that exceed numa_imb_nr.
> 
> 
> Yes that's true. I think what you are doing in v4 is the right thing.
> 
> In case of stream in NPS=4, it just manages to hit the corner case for
> this heuristic which results in a suboptimal behaviour. Description
> follows:
> 

To avoid the corner case, we'd need to explicitly favour spreading early
and assume wakeup will pull communicating tasks together and NUMA
balancing migrate the data after some time which looks like

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c07bfa2d80f2..54f5207154d3 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -93,6 +93,7 @@ struct sched_domain {
 	unsigned int busy_factor;	/* less balancing by factor if busy */
 	unsigned int imbalance_pct;	/* No balance until over watermark */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
+	unsigned int imb_numa_nr;	/* Nr imbalanced tasks allowed between nodes */
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0a969affca76..df0e84462e62 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1489,6 +1489,7 @@ struct task_numa_env {
 
 	int src_cpu, src_nid;
 	int dst_cpu, dst_nid;
+	int imb_numa_nr;
 
 	struct numa_stats src_stats, dst_stats;
 
@@ -1504,7 +1505,8 @@ static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
 static inline long adjust_numa_imbalance(int imbalance,
-					int dst_running, int dst_weight);
+					int dst_running,
+					int imb_numa_nr);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -1885,7 +1887,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		dst_running = env->dst_stats.nr_running + 1;
 		imbalance = max(0, dst_running - src_running);
 		imbalance = adjust_numa_imbalance(imbalance, dst_running,
-							env->dst_stats.weight);
+						  env->imb_numa_nr);
 
 		/* Use idle CPU if there is no imbalance */
 		if (!imbalance) {
@@ -1950,8 +1952,10 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
-	if (sd)
+	if (sd) {
 		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
+		env.imb_numa_nr = sd->imb_numa_nr;
+	}
 	rcu_read_unlock();
 
 	/*
@@ -9050,9 +9054,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * This is an approximation as the number of running tasks may not be
  * related to the number of busy CPUs due to sched_setaffinity.
  */
-static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
 {
-	return (dst_running < (dst_weight >> 2));
+	return dst_running < imb_numa_nr;
 }
 
 /*
@@ -9186,12 +9190,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 				return idlest;
 #endif
 			/*
-			 * Otherwise, keep the task on this node to stay close
-			 * its wakeup source and improve locality. If there is
-			 * a real need of migration, periodic load balance will
-			 * take care of it.
+			 * Otherwise, keep the task on this node to stay local
+			 * to its wakeup source if the number of running tasks
+			 * are below the allowed imbalance. If there is a real
+			 * need of migration, periodic load balance will take
+			 * care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
+			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->imb_numa_nr))
 				return NULL;
 		}
 
@@ -9280,19 +9285,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 }
 
-#define NUMA_IMBALANCE_MIN 2
-
 static inline long adjust_numa_imbalance(int imbalance,
-				int dst_running, int dst_weight)
+				int dst_running, int imb_numa_nr)
 {
-	if (!allow_numa_imbalance(dst_running, dst_weight))
+	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
 		return imbalance;
 
-	/*
-	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the destination is lightly loaded.
-	 */
-	if (imbalance <= NUMA_IMBALANCE_MIN)
+	if (imbalance <= imb_numa_nr)
 		return 0;
 
 	return imbalance;
@@ -9397,7 +9396,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				busiest->sum_nr_running, env->sd->span_weight);
+				busiest->sum_nr_running, env->sd->imb_numa_nr);
 		}
 
 		return;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..1fa3e977521d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2242,6 +2242,55 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	/*
+	 * Calculate an allowed NUMA imbalance such that LLCs do not get
+	 * imbalanced.
+	 */
+	for_each_cpu(i, cpu_map) {
+		unsigned int imb = 0;
+		unsigned int imb_span = 1;
+
+		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
+			struct sched_domain *child = sd->child;
+
+			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
+			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
+				struct sched_domain *top, *top_p;
+				unsigned int llc_sq;
+
+				/*
+				 * nr_llcs = (sd->span_weight / llc_weight);
+				 * imb = (llc_weight / nr_llcs) >> 2
+				 *
+				 * is equivalent to
+				 *
+				 * imb = (llc_weight^2 / sd->span_weight) >> 2
+				 *
+				 */
+				llc_sq = child->span_weight * child->span_weight;
+
+				imb = max(2U, ((llc_sq / sd->span_weight) >> 2));
+				sd->imb_numa_nr = imb;
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
+			} else {
+				int factor = max(1U, (sd->span_weight / imb_span));
+
+				sd->imb_numa_nr = imb * factor;
+			}
+		}
+	}
+
 	/* Calculate CPU capacity for physical packages and nodes */
 	for (i = nr_cpumask_bits-1; i >= 0; i--) {
 		if (!cpumask_test_cpu(i, cpu_map))
