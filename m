Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412BD52E9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbiETKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348185AbiETKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:35:33 -0400
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B74EBA8A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:35:31 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id DF960BAB0A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:35:29 +0100 (IST)
Received: (qmail 29734 invoked from network); 20 May 2022 10:35:29 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 20 May 2022 10:35:29 -0000
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
Subject: [PATCH v2 0/4] Mitigate inconsistent NUMA imbalance behaviour
Date:   Fri, 20 May 2022 11:35:15 +0100
Message-Id: <20220520103519.1863-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V1
o Consolidate [allow|adjust]_numa_imbalance			(peterz)
o #ifdefs around NUMA-specific pieces to build arc-allyesconfig	(lkp)

A problem was reported privately related to inconsistent performance of
NAS when parallelised with MPICH. The root of the problem is that the
initial placement is unpredictable and there can be a larger imbalance
than expected between NUMA nodes. As there is spare capacity and the faults
are local, the imbalance persists for a long time and performance suffers.

This is not 100% an "allowed imbalance" problem as setting the allowed
imbalance to 0 does not fix the issue but the allowed imbalance contributes
the the performance problem. The unpredictable behaviour was most recently
introduced by commit c6f886546cb8 ("sched/fair: Trigger the update of
blocked load on newly idle cpu").

mpirun forks hydra_pmi_proxy helpers with MPICH that go to sleep before the
execing the target workload. As the new tasks are sleeping, the potential
imbalance is not observed as idle_cpus does not reflect the tasks that
will be running in the near future. How bad the problem depends on the
timing of when fork happens and whether the new tasks are still running.
Consequently, a large initial imbalance may not be detected until the
workload is fully running. Once running, NUMA Balancing picks the preferred
node based on locality and runtime load balancing often ignores the tasks
as can_migrate_task() fails for either locality or task_hot reasons and
instead picks unrelated tasks.

This is the min, max and range of run time for mg.D parallelised with ~25%
of the CPUs parallelised by MPICH running on a 2-socket machine (80 CPUs,
16 active for mg.D due to limitations of mg.D).

v5.3                                     Min  95.84 Max  96.55 Range   0.71 Mean  96.16
v5.7                                     Min  95.44 Max  96.51 Range   1.07 Mean  96.14
v5.8                                     Min  96.02 Max 197.08 Range 101.06 Mean 154.70
v5.12                                    Min 104.45 Max 111.03 Range   6.58 Mean 105.94
v5.13                                    Min 104.38 Max 170.37 Range  65.99 Mean 117.35
v5.13-revert-c6f886546cb8                Min 104.40 Max 110.70 Range   6.30 Mean 105.68
v5.18rc4-baseline                        Min 110.78 Max 169.84 Range  59.06 Mean 131.22
v5.18rc4-revert-c6f886546cb8             Min 113.98 Max 117.29 Range   3.31 Mean 114.71
v5.18rc4-this_series                     Min  95.56 Max 163.97 Range  68.41 Mean 105.39
v5.18rc4-this_series-revert-c6f886546cb8 Min  95.56 Max 104.86 Range   9.30 Mean  97.00

This shows that we've had unpredictable performance for a long time for
this load. Instability was introduced somewhere between v5.7 and v5.8,
fixed in v5.12 and broken again since v5.13.  The revert against 5.13
and 5.18-rc4 shows that c6f886546cb8 is the primary source of instability
although the best case is still worse than 5.7.

This series addresses the allowed imbalance problems to get the peak
performance back to 5.7 although only some of the time due to the
instability problem. The series plus the revert is both stable and has
slightly better peak performance and similar average performance. I'm
not convinced commit c6f886546cb8 is wrong but haven't isolated exactly
why it's unstable. I'm just noting it has an issue for now.

Patch 1 initialises numa_migrate_retry. While this resolves itself
	eventually, it is unpredictable early in the lifetime of
	a task.

Patch 2 will not swap NUMA tasks in the same NUMA group or without
	a NUMA group if there is spare capacity. Swapping is just
	punishing one task to help another.

Patch 3 fixes an issue where a larger imbalance can be created at
	fork time than would be allowed at run time. This behaviour
	can help some workloads that are short lived and prefer
	to remain local but it punishes long-lived tasks that are
	memory intensive.

Patch 4 adjusts the threshold where a NUMA imbalance is allowed to
	better approximate the number of memory channels, at least
	for x86-64.

 kernel/sched/fair.c     | 91 +++++++++++++++++++++++++----------------
 kernel/sched/topology.c | 23 +++++++----
 2 files changed, 70 insertions(+), 44 deletions(-)

-- 
2.34.1
