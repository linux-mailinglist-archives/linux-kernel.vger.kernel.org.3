Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A355552EA04
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345861AbiETKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348225AbiETKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:36:16 -0400
Received: from outbound-smtp21.blacknight.com (outbound-smtp21.blacknight.com [81.17.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F5972223
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:36:11 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 96549CCB7F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:36:10 +0100 (IST)
Received: (qmail 31755 invoked from network); 20 May 2022 10:36:10 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 20 May 2022 10:36:10 -0000
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
Subject: [PATCH 4/4] sched/numa: Adjust imb_numa_nr to a better approximation of memory channels
Date:   Fri, 20 May 2022 11:35:19 +0100
Message-Id: <20220520103519.1863-5-mgorman@techsingularity.net>
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

For a single LLC per node, a NUMA imbalance is allowed up until 25%
of CPUs sharing a node could be active. One intent of the cut-off is
to avoid an imbalance of memory channels but there is no topological
information based on active memory channels. Furthermore, there can
be differences between nodes depending on the number of populated
DIMMs.

A cut-off of 25% was arbitrary but generally worked. It does have a severe
corner cases though when an parallel workload is using 25% of all available
CPUs over-saturates memory channels. This can happen due to the initial
forking of tasks that get pulled more to one node after early wakeups
(e.g. a barrier synchronisation) that is not quickly corrected by the
load balancer. The LB may fail to act quickly as the parallel tasks are
considered to be poor migrate candidates due to locality or cache hotness.

On a range of modern Intel CPUs, 12.5% appears to be a better cut-off
assuming all memory channels are populated and is used as the new cut-off
point. A minimum of 1 is specified to allow a communicating pair to
remain local even for CPUs with low numbers of cores. For modern AMDs,
there are multiple LLCs and are not affected.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/topology.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 810750e62118..2740e245cb37 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2295,23 +2295,30 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 				/*
 				 * For a single LLC per node, allow an
-				 * imbalance up to 25% of the node. This is an
-				 * arbitrary cutoff based on SMT-2 to balance
-				 * between memory bandwidth and avoiding
-				 * premature sharing of HT resources and SMT-4
-				 * or SMT-8 *may* benefit from a different
-				 * cutoff.
+				 * imbalance up to 12.5% of the node. This is
+				 * arbitrary cutoff based two factors -- SMT and
+				 * memory channels. For SMT-2, the intent is to
+				 * avoid premature sharing of HT resources but
+				 * SMT-4 or SMT-8 *may* benefit from a different
+				 * cutoff. For memory channels, this is a very
+				 * rough estimate of how many channels may be
+				 * active and is based on recent CPUs with
+				 * many cores.
 				 *
 				 * For multiple LLCs, allow an imbalance
 				 * until multiple tasks would share an LLC
 				 * on one node while LLCs on another node
-				 * remain idle.
+				 * remain idle. This assumes that there are
+				 * enough logical CPUs per LLC to avoid SMT
+				 * factors and that there is a correlation
+				 * between LLCs and memory channels.
 				 */
 				nr_llcs = sd->span_weight / child->span_weight;
 				if (nr_llcs == 1)
-					imb = sd->span_weight >> 2;
+					imb = sd->span_weight >> 3;
 				else
 					imb = nr_llcs;
+				imb = max(1U, imb);
 				sd->imb_numa_nr = imb;
 
 				/* Set span based on the first NUMA domain. */
-- 
2.34.1

