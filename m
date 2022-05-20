Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6728652EA01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348195AbiETKgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348202AbiETKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:35:58 -0400
Received: from outbound-smtp63.blacknight.com (outbound-smtp63.blacknight.com [46.22.136.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131C20F4B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:35:51 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id 4B6ECFA96A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:35:50 +0100 (IST)
Received: (qmail 30665 invoked from network); 20 May 2022 10:35:50 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 20 May 2022 10:35:50 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] sched/numa: Do not swap tasks between nodes when spare capacity is available
Date:   Fri, 20 May 2022 11:35:17 +0100
Message-Id: <20220520103519.1863-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220520103519.1863-1-mgorman@techsingularity.net>
References: <20220520103519.1863-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a destination node has spare capacity but there is an imbalance then
two tasks are selected for swapping. If the tasks have no numa group
or are within the same NUMA group, it's simply shuffling tasks around
without having any impact on the compute imbalance. Instead, it's just
punishing one task to help another.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 867806a57119..03b1ad79d47d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1778,6 +1778,15 @@ static bool task_numa_compare(struct task_numa_env *env,
 	 */
 	cur_ng = rcu_dereference(cur->numa_group);
 	if (cur_ng == p_ng) {
+		/*
+		 * Do not swap within a group or between tasks that have
+		 * no group if there is spare capacity. Swapping does
+		 * not address the load imbalance and helps one task at
+		 * the cost of punishing another.
+		 */
+		if (env->dst_stats.node_type == node_has_spare)
+			goto unlock;
+
 		imp = taskimp + task_weight(cur, env->src_nid, dist) -
 		      task_weight(cur, env->dst_nid, dist);
 		/*
-- 
2.34.1

