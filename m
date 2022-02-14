Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7F4B4D19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349919AbiBNLCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:02:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349874AbiBNLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:02:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14306A393;
        Mon, 14 Feb 2022 02:30:22 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:30:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644834621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQZWcHVIUV3ERfcLHn+wIKBsjkEWR6/yq3ljYM6Ph3A=;
        b=vROLgV4lGHMOen91K6jh2CCwL7tec0lgPiMMrG4kapvgrkcqSsxuxe7fHeB6ItRF8n5DJ+
        hRpf5oSje1tzVvr3PnLCiKyIx1qTfyOZecbnbLEerFxzxfWXBN2kXFfrWohEJmpy+DVxkn
        OIRNOQ1bgf9uftOIydqa38NA0nrVSplxl8bBeQdNUYlZA9NjyPbu1cxwZ6czWskF3SsDBS
        RuawwoH55pt+5nm6uy+uzuWZ4YQQ+xA78a0XkMhUc7iJStwpnnwLAQy3SwVh1CouoA0hn0
        vXcQasx0YtD7QZ2yAsD5oD/cUEsG3tKPtYWGsuSFOrhj2T1IPx4TlmjKBbuqGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644834621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQZWcHVIUV3ERfcLHn+wIKBsjkEWR6/yq3ljYM6Ph3A=;
        b=1M7gWZMkgQ1Ey3OTYSFsvhRdFvAlHROZ0JI7iJdi5Oyq6aVQPNOTcv5nIX9Mgt6aF9ks82
        5vbsVebbCGkX/jAA==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Improve consistency of allowed NUMA
 balance calculations
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220208094334.16379-2-mgorman@techsingularity.net>
References: <20220208094334.16379-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <164483462018.16921.16665181001915806595.tip-bot2@tip-bot2>
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

Commit-ID:     2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a
Gitweb:        https://git.kernel.org/tip/2cfb7a1b031b0e816af7a6ee0c6ab83b0acdf05a
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 08 Feb 2022 09:43:33 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 23:30:08 +01:00

sched/fair: Improve consistency of allowed NUMA balance calculations

There are inconsistencies when determining if a NUMA imbalance is allowed
that should be corrected.

o allow_numa_imbalance changes types and is not always examining
  the destination group so both the type should be corrected as
  well as the naming.
o find_idlest_group uses the sched_domain's weight instead of the
  group weight which is different to find_busiest_group
o find_busiest_group uses the source group instead of the destination
  which is different to task_numa_find_cpu
o Both find_idlest_group and find_busiest_group should account
  for the number of running tasks if a move was allowed to be
  consistent with task_numa_find_cpu

Fixes: 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20220208094334.16379-2-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5dca13f..ea71016 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9005,9 +9005,10 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * This is an approximation as the number of running tasks may not be
  * related to the number of busy CPUs due to sched_setaffinity.
  */
-static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
+static inline bool
+allow_numa_imbalance(unsigned int running, unsigned int weight)
 {
-	return (dst_running < (dst_weight >> 2));
+	return (running < (weight >> 2));
 }
 
 /*
@@ -9141,12 +9142,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 				return idlest;
 #endif
 			/*
-			 * Otherwise, keep the task on this node to stay close
-			 * its wakeup source and improve locality. If there is
-			 * a real need of migration, periodic load balance will
-			 * take care of it.
+			 * Otherwise, keep the task close to the wakeup source
+			 * and improve locality if the number of running tasks
+			 * would remain below threshold where an imbalance is
+			 * allowed. If there is a real need of migration,
+			 * periodic load balance will take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
 				return NULL;
 		}
 
@@ -9352,7 +9354,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-				busiest->sum_nr_running, busiest->group_weight);
+				local->sum_nr_running + 1, local->group_weight);
 		}
 
 		return;
