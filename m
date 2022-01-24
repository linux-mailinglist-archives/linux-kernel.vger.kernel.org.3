Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6536C497CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiAXKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:03:29 -0500
Received: from outbound-smtp60.blacknight.com ([46.22.136.244]:52991 "EHLO
        outbound-smtp60.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230339AbiAXKD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:03:26 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id 6CA22FA928
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:03:23 +0000 (GMT)
Received: (qmail 28722 invoked from network); 24 Jan 2022 10:03:23 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 24 Jan 2022 10:03:23 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/1] sched/fair: Increase wakeup_gran if current task has not executed the minimum granularity
Date:   Mon, 24 Jan 2022 10:03:12 +0000
Message-Id: <20220124100312.32573-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
reasons why this sysctl may be used may be for "optimising for throughput",
particularly when overloaded. The tool TuneD sometimes alters this for two
profiles e.g. "mssql" and "throughput-performance".  Since tuned 2.16.0,
it also pokes into debugfs without any clear reason why. This patch
aims to reduce the motivation to tweak sysctl_sched_wakeup_granularity
by increasing sched_wakeup_granularity if the running task runtime has
not exceeded sysctl_sched_min_granularity.

During task migration or wakeup, a decision is made on whether
to preempt the current task or not. To limit over-scheduling,
sysctl_sched_wakeup_granularity delays the preemption to allow at least 1ms
of runtime before preempting. However, when a domain is heavily overloaded
(e.g. hackbench), the degree of over-scheduling is still severe. This is
problematic as time is wasted rescheduling tasks that could instead be
used by userspace tasks.

However, care must be taken. Even if a system is overloaded, there may
be high priority threads that must still be able to run. Mike Galbraith
explained the constraints as follows;

        CFS came about because the O1 scheduler was unfair to the
        point it had starvation problems. People pretty much across the
        board agreed that a fair scheduler was a much way better way
        to go, and CFS was born.  It didn't originally have the sleep
        credit business, but had to grow it to become _short term_ fair.
        Ingo cut the sleep credit in half because of overscheduling, and
        that has worked out pretty well all told.. but now you're pushing
        it more in the unfair direction, all the way to extremely unfair
        for anything and everything very light.

        Fairness isn't the holy grail mind you, and at some point, giving
        up on short term fairness certainly isn't crazy, as proven by your
        hackbench numbers and other numbers we've seen over the years,
        but taking bites out of the 'CF' in the CFS that was born to be a
        corner-case killer is.. worrisome.  The other shoe will drop.. it
        always does :)

This patch increases the wakeup granularity if the current task has not
reached its minimum preemption granularity. The current task may still
be preempted but the difference in runtime must be higher.

hackbench-process-pipes
                          5.17.0-rc0             5.17.0-rc0
                             vanilla sched-scalewakegran-v5
Amean     1        0.3360 (   0.00%)      0.3247 (   3.37%)
Amean     4        0.8490 (   0.00%)      0.8170 (   3.77%)
Amean     7        1.0653 (   0.00%)      1.0337 (   2.97%)
Amean     12       1.7473 (   0.00%)      1.5793 *   9.61%*
Amean     21       3.0810 (   0.00%)      2.6507 *  13.97%*
Amean     30       4.4270 (   0.00%)      3.7067 *  16.27%*
Amean     48       7.4763 (   0.00%)      5.8417 *  21.86%*
Amean     79      12.6160 (   0.00%)      8.9873 *  28.76%*
Amean     110     17.8917 (   0.00%)     12.5193 *  30.03%*
Amean     141     20.9503 (   0.00%)     17.1913 *  17.94%*
Amean     172     24.0280 (   0.00%)     20.2977 *  15.52%*
Amean     203     27.2777 (   0.00%)     24.8710 *   8.82%*
Amean     234     32.1567 (   0.00%)     29.2507 (   9.04%)
Amean     265     35.2520 (   0.00%)     30.2247 *  14.26%*
Amean     296     37.7867 (   0.00%)     33.8587 *  10.40%*

                  5.17.0-rc0  5.17.0-rc0
                     vanilla sched-scalewakegran-v5
Duration User       16189.01    15301.35
Duration System     37651.60    30529.21
Duration Elapsed      706.79      605.33

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c     | 17 +++++++++++++++--
 kernel/sched/features.h |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..b976b094d8c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6965,10 +6965,23 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
-static unsigned long wakeup_gran(struct sched_entity *se)
+static unsigned long
+wakeup_gran(struct sched_entity *curr, struct sched_entity *se)
 {
 	unsigned long gran = sysctl_sched_wakeup_granularity;
 
+	if (sched_feat(SCALE_WAKEUP_GRAN)) {
+		unsigned long delta_exec;
+
+		/*
+		 * Increase the wakeup granularity if curr's runtime
+		 * is less than the minimum preemption granularity.
+		 */
+		delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
+		if (delta_exec < sysctl_sched_min_granularity)
+			gran += sysctl_sched_min_granularity;
+	}
+
 	/*
 	 * Since its curr running now, convert the gran from real-time
 	 * to virtual-time in his units.
@@ -7007,7 +7020,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 	if (vdiff <= 0)
 		return -1;
 
-	gran = wakeup_gran(se);
+	gran = wakeup_gran(curr, se);
 	if (vdiff > gran)
 		return 1;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1cf435bbcd9c..7b70a409cfa5 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -100,3 +100,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(SCALE_WAKEUP_GRAN, true)
-- 
2.31.1

