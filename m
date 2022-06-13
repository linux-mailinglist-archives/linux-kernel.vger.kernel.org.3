Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9804C548283
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiFMIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiFMIne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C825DB;
        Mon, 13 Jun 2022 01:43:32 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTE31coiVEWVLeTvQGweuYMu9lyT3sZrZA7atEAo6MY=;
        b=vtfd98rdqnknhqNDJ3TLQStpRGpqXCxdmz8VLl/UrhGyaMl+CF8yPmkma9fSJB0aqJukq+
        TMPG8ELqZ4mNCeAfXhPEjjU1CClGd8b3a8wZKczi5OPHQtbe2ugNnv+hN8JXbEoTxyEXZC
        0F/vRvuJp6h1b8OSy5IT/TgzcuhqtmZ5Z0nT79o0fid2z3MqQzpMnS3P5Rd6qBvzJlAnoT
        k/VMgA3pKUiB7hi+LXwrAgur7+eWpxj1QRm2YEDLTbGYZcqFBgEe84gXtMeCKDplTt+xZA
        XFXgtrJmSGXFuDHyVADN/fwP+n27rDEpBP7bI2MAxLEVhOEKOs9+DE0nUh46Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTE31coiVEWVLeTvQGweuYMu9lyT3sZrZA7atEAo6MY=;
        b=bUCS4U9qA1b2dDhRW6KYrnUnQrTrWUgwPtaBBs3hnR/aUkW76zqqJviBjpVE3dQHm/lG4g
        4+S8u/lawi1FDzBw==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Apply imbalance limitations consistently
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520103519.1863-4-mgorman@techsingularity.net>
References: <20220520103519.1863-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <165510980980.4207.5946665132420916159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cb29a5c19d2d68afc641fb1949e1a1c565b582ea
Gitweb:        https://git.kernel.org/tip/cb29a5c19d2d68afc641fb1949e1a1c565b582ea
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 May 2022 11:35:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:29:59 +02:00

sched/numa: Apply imbalance limitations consistently

The imbalance limitations are applied inconsistently at fork time
and at runtime. At fork, a new task can remain local until there are
too many running tasks even if the degree of imbalance is larger than
NUMA_IMBALANCE_MIN which is different to runtime. Secondly, the imbalance
figure used during load balancing is different to the one used at NUMA
placement. Load balancing uses the number of tasks that must move to
restore imbalance where as NUMA balancing uses the total imbalance.

In combination, it is possible for a parallel workload that uses a small
number of CPUs without applying scheduler policies to have very variable
run-to-run performance.

[lkp@intel.com: Fix build breakage for arc-allyesconfig]

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20220520103519.1863-4-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 81 ++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23da36c..166f5f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1055,6 +1055,33 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
+#ifdef CONFIG_NUMA
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
+#endif /* CONFIG_NUMA */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Approximate time to scan a full NUMA task in ms. The task scan period is
@@ -1548,8 +1575,6 @@ struct task_numa_env {
 
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
-static inline long adjust_numa_imbalance(int imbalance,
-					int dst_running, int imb_numa_nr);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -9068,16 +9093,6 @@ static bool update_pick_idlest(struct sched_group *idlest,
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
@@ -9193,6 +9208,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 		break;
 
 	case group_has_spare:
+#ifdef CONFIG_NUMA
 		if (sd->flags & SD_NUMA) {
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
@@ -9206,7 +9222,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			idlest_cpu = cpumask_first(sched_group_span(idlest));
 			if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
 				return idlest;
-#endif
+#endif /* CONFIG_NUMA_BALANCING */
 			/*
 			 * Otherwise, keep the task close to the wakeup source
 			 * and improve locality if the number of running tasks
@@ -9214,9 +9230,14 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
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
+#endif /* CONFIG_NUMA */
 
 		/*
 		 * Select group with highest number of idle CPUs. We could also
@@ -9303,24 +9324,6 @@ next_group:
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
@@ -9405,7 +9408,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 */
 			env->migration_type = migrate_task;
 			lsub_positive(&nr_diff, local->sum_nr_running);
-			env->imbalance = nr_diff >> 1;
+			env->imbalance = nr_diff;
 		} else {
 
 			/*
@@ -9413,15 +9416,21 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 * idle cpus.
 			 */
 			env->migration_type = migrate_task;
-			env->imbalance = max_t(long, 0, (local->idle_cpus -
-						 busiest->idle_cpus) >> 1);
+			env->imbalance = max_t(long, 0,
+					       (local->idle_cpus - busiest->idle_cpus));
 		}
 
+#ifdef CONFIG_NUMA
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				local->sum_nr_running + 1, env->sd->imb_numa_nr);
+							       local->sum_nr_running + 1,
+							       env->sd->imb_numa_nr);
 		}
+#endif
+
+		/* Number of tasks to move to restore balance */
+		env->imbalance >>= 1;
 
 		return;
 	}
