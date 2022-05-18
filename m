Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0984E52B830
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiERKrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiERKrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:47:03 -0400
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F43793B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:46:56 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 1D73CBAA9D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:46:55 +0100 (IST)
Received: (qmail 18669 invoked from network); 18 May 2022 10:46:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 May 2022 10:46:54 -0000
Date:   Wed, 18 May 2022 11:46:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/numa: Apply imbalance limitations consistently
Message-ID: <20220518104652.GO3441@techsingularity.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-4-mgorman@techsingularity.net>
 <20220518093156.GD10117@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220518093156.GD10117@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:31:56AM +0200, Peter Zijlstra wrote:
> On Wed, May 11, 2022 at 03:30:37PM +0100, Mel Gorman wrote:
> 
> > @@ -9108,6 +9108,24 @@ static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
> >  	return running <= imb_numa_nr;
> >  }
> >  
> > +#define NUMA_IMBALANCE_MIN 2
> > +
> > +static inline long adjust_numa_imbalance(int imbalance,
> > +				int dst_running, int imb_numa_nr)
> > +{
> > +	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> > +		return imbalance;
> > +
> > +	/*
> > +	 * Allow a small imbalance based on a simple pair of communicating
> > +	 * tasks that remain local when the destination is lightly loaded.
> > +	 */
> > +	if (imbalance <= NUMA_IMBALANCE_MIN)
> > +		return 0;
> > +
> > +	return imbalance;
> > +}
> 
> > @@ -9334,24 +9356,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  	}
> >  }
> >  
> > -#define NUMA_IMBALANCE_MIN 2
> > -
> > -static inline long adjust_numa_imbalance(int imbalance,
> > -				int dst_running, int imb_numa_nr)
> > -{
> > -	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> > -		return imbalance;
> > -
> > -	/*
> > -	 * Allow a small imbalance based on a simple pair of communicating
> > -	 * tasks that remain local when the destination is lightly loaded.
> > -	 */
> > -	if (imbalance <= NUMA_IMBALANCE_MIN)
> > -		return 0;
> > -
> > -	return imbalance;
> > -}
> 
> If we're going to move that one up and remove the only other caller of
> allow_numa_imbalance() we might as well move it up further still and
> fold the functions.
> 
> Hmm?
> 

Yes, that would be fine and makes sense. I remember thinking that they
should be folded and then failed to follow through.

> (Although I do wonder about that 25% figure in the comment; that doesn't
> seem to relate to any actual code anymore)
> 

You're right, by the end of the series it's completely inaccurate and
currently it's not accurate if there are multiple LLCs per node. I
adjusted the wording to "Allow a NUMA imbalance if busy CPUs is less
than the maximum threshold. Above this threshold, individual tasks may
be contending for both memory bandwidth and any shared HT resources."

Diff between v1 and v2 is now below

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 602c05b22805..51fde61ec756 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1536,8 +1536,31 @@ struct task_numa_env {
 
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
-static inline long adjust_numa_imbalance(int imbalance,
-					int dst_running, int imb_numa_nr);
+
+#define NUMA_IMBALANCE_MIN 2
+
+static inline long
+adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
+{
+	/*
+	 * Allow a NUMA imbalance if busy CPUs is less than the maximum
+	 * threshold. Above this threshold, individual tasks may be contending
+	 * for both memory bandwidth and any shared HT resources.  This is an
+	 * approximation as the number of running tasks may not be related to
+	 * the number of busy CPUs due to sched_setaffinity.
+	 */
+	if (dst_running > imb_numa_nr)
+		return imbalance;
+
+	/*
+	 * Allow a small imbalance based on a simple pair of communicating
+	 * tasks that remain local when the destination is lightly loaded.
+	 */
+	if (imbalance <= NUMA_IMBALANCE_MIN)
+		return 0;
+
+	return imbalance;
+}
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -9098,34 +9121,6 @@ static bool update_pick_idlest(struct sched_group *idlest,
 	return true;
 }
 
-/*
- * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
- * This is an approximation as the number of running tasks may not be
- * related to the number of busy CPUs due to sched_setaffinity.
- */
-static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
-{
-	return running <= imb_numa_nr;
-}
-
-#define NUMA_IMBALANCE_MIN 2
-
-static inline long adjust_numa_imbalance(int imbalance,
-				int dst_running, int imb_numa_nr)
-{
-	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
-		return imbalance;
-
-	/*
-	 * Allow a small imbalance based on a simple pair of communicating
-	 * tasks that remain local when the destination is lightly loaded.
-	 */
-	if (imbalance <= NUMA_IMBALANCE_MIN)
-		return 0;
-
-	return imbalance;
-}
-
 /*
  * find_idlest_group() finds and returns the least busy CPU group within the
  * domain.
@@ -9448,14 +9443,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * idle cpus.
 			 */
 			env->migration_type = migrate_task;
-			env->imbalance = max_t(long, 0, (local->idle_cpus -
-						 busiest->idle_cpus));
+			env->imbalance = max_t(long, 0,
+					       (local->idle_cpus - busiest->idle_cpus));
 		}
 
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				local->sum_nr_running + 1, env->sd->imb_numa_nr);
+							       local->sum_nr_running + 1,
+							       env->sd->imb_numa_nr);
 		}
 
 		/* Number of tasks to move to restore balance */
