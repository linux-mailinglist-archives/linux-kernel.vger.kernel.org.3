Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC40652B71A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiERJci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiERJcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:32:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1785C9E9C1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WwG+aMK92zqBm4TaHVu6Z9jHdMGFIVZd9uJHvsK5LN0=; b=J5H1rzgmaKs8OKBAmhMBwVCEgg
        FoHwdHH8muQicHQwMlWSEC3vyA6SbC8z7VW4CHH2wBvhWvvb74o2YTDcrU6zlSPck1udP22eFa015
        y7iPp+/wIXboH9znjNQ4HjVjE+IB/kIWeuNBqa+LA3GBQpzrGbmRoJzMLsIx4p7OjRflFEFI715t0
        7FW3jo8Epn3lz9HA8zGLpR9mZk8EQsv3IU99kFKC/uves6XQ1bDrR7olyX7Wtr0QTGxk1egla/Z+x
        YUVRUX+/o5U2yggcpQl4nRKvSSuboM2l81U0NRwbGcJZ1S4Xigxj1xAsYYUAs7oo+Q/t253iEcx8y
        41nqNPdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrG2A-00Bdvk-Lw; Wed, 18 May 2022 09:31:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20991980DFF; Wed, 18 May 2022 11:31:56 +0200 (CEST)
Date:   Wed, 18 May 2022 11:31:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/numa: Apply imbalance limitations consistently
Message-ID: <20220518093156.GD10117@worktop.programming.kicks-ass.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511143038.4620-4-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:30:37PM +0100, Mel Gorman wrote:

> @@ -9108,6 +9108,24 @@ static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
>  	return running <= imb_numa_nr;
>  }
>  
> +#define NUMA_IMBALANCE_MIN 2
> +
> +static inline long adjust_numa_imbalance(int imbalance,
> +				int dst_running, int imb_numa_nr)
> +{
> +	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> +		return imbalance;
> +
> +	/*
> +	 * Allow a small imbalance based on a simple pair of communicating
> +	 * tasks that remain local when the destination is lightly loaded.
> +	 */
> +	if (imbalance <= NUMA_IMBALANCE_MIN)
> +		return 0;
> +
> +	return imbalance;
> +}

> @@ -9334,24 +9356,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	}
>  }
>  
> -#define NUMA_IMBALANCE_MIN 2
> -
> -static inline long adjust_numa_imbalance(int imbalance,
> -				int dst_running, int imb_numa_nr)
> -{
> -	if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> -		return imbalance;
> -
> -	/*
> -	 * Allow a small imbalance based on a simple pair of communicating
> -	 * tasks that remain local when the destination is lightly loaded.
> -	 */
> -	if (imbalance <= NUMA_IMBALANCE_MIN)
> -		return 0;
> -
> -	return imbalance;
> -}

If we're going to move that one up and remove the only other caller of
allow_numa_imbalance() we might as well move it up further still and
fold the functions.

Hmm?

(Although I do wonder about that 25% figure in the comment; that doesn't
seem to relate to any actual code anymore)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1536,8 +1536,29 @@ struct task_numa_env {

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
+	 * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
+	 * This is an approximation as the number of running tasks may not be
+	 * related to the number of busy CPUs due to sched_setaffinity.
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
@@ -9099,16 +9120,6 @@ static bool update_pick_idlest(struct sc
 }

 /*
- * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
- * This is an approximation as the number of running tasks may not be
- * related to the number of busy CPUs due to sched_setaffinity.
- */
-static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
-{
-	return running <= imb_numa_nr;
-}
-
-/*
  * find_idlest_group() finds and returns the least busy CPU group within the
  * domain.
  *
@@ -9245,8 +9256,12 @@ find_idlest_group(struct sched_domain *s
 			 * allowed. If there is a real need of migration,
 			 * periodic load balance will take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
+			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
+			if (!adjust_numa_imbalance(imbalance,
+						   local_sgs.sum_nr_running + 1,
+						   sd->imb_numa_nr)) {
 				return NULL;
+			}
 		}

 		/*
@@ -9334,24 +9349,6 @@ static inline void update_sd_lb_stats(st
 	}
 }

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
 /**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
@@ -9436,7 +9433,7 @@ static inline void calculate_imbalance(s
 			 */
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
-			env->imbalance = nr_diff >> 1;
+			env->imbalance = nr_diff;
 		} else {

 			/*
@@ -9444,16 +9441,20 @@ static inline void calculate_imbalance(s
 			 * idle cpus.
 			 */
 			env->migration_type = migrate_task;
-			env->imbalance = max_t(long, 0, (local->idle_cpus -
-						 busiest->idle_cpus) >> 1);
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

+		/* Number of tasks to move to restore balance */
+		env->imbalance >>= 1;
+
 		return;
 	}


