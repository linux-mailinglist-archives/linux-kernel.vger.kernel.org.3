Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84A59F2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 06:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiHXEiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 00:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXEiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:38:03 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B15FAC6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 21:38:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VN5nYf._1661315871;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0VN5nYf._1661315871)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 12:37:58 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: select waker's cpu for wakee on sync wakeup
Date:   Wed, 24 Aug 2022 12:37:50 +0800
Message-Id: <1508aa17d1a169077c8d8d8c22d2bd529101af0e.1661313074.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sync wakeup, waker is about to sleep, and if it is the only
running task, wakee can get warm data on waker's cpu.

Unixbench, schbench, and hackbench are tested on
Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz (192 logic CPUs)

Unixbench get +20.7% improvement with full threads mainly
because of the pipe-based context switch and fork test.

No obvious impact on schbench.

This change harms hackbench with lower concurrency, while gets improvement
when concurrency increases.

Unixbench: ./Run
(Higher score is better)
(One thread)				   /o patch   w/ patch

Dhrystone 2 using register variables         2666.8     2689.7    +0.9%
Double-Precision Whetstone                   1040.0     1040.4     0.0%
Execl Throughput                              979.1      981.7    +0.3%
File Copy 1024 bufsize 2000 maxblocks        2892.8     2904.2    -0.4%
File Copy 256 bufsize 500 maxblocks          1885.6     1887.6    +0.1%
File Copy 4096 bufsize 8000 maxblocks        5850.2     5881.4    +0.5%
Pipe Throughput                              1533.0     1542.4    +0.6%
Pipe-based Context Switching                  541.3      769.3   +42.1%
Process Creation                              579.6      573.6    -1.0%
Shell Scripts (1 concurrent)                 1777.1     1727.7    -2.8%
Shell Scripts (8 concurrent)                 5596.4     5426.5    +3.0%
System Call Overhead                         1217.2     1213.8    +0.3%
                                           ========   ========
System Benchmarks Index Score                1679.7     1723.3    +2.6%

(192 full threads)		          w/o patch    w/ patch

Dhrystone 2 using register variables       367559.1    356451.8    -3.0%
Double-Precision Whetstone                 172899.3    172906.7     0.0%
Execl Throughput                             4112.6      4228.2    +2.8%
File Copy 1024 bufsize 2000 maxblocks         972.3       993.8    +2.2%
File Copy 256 bufsize 500 maxblocks           578.4       570.1    +1.4%
File Copy 4096 bufsize 8000 maxblocks        2020.9      1951.4    -3.4%
Pipe Throughput                            179361.6    179381.0     0.0%
Pipe-based Context Switching                 7818.4     83949.3  +973.7%
Process Creation                             4008.6      4419.6   +10.3%
Shell Scripts (1 concurrent)                17632.9     18370.2    +4.1%
Shell Scripts (8 concurrent)                16811.1     17525.5    +4.2%
System Call Overhead                         1599.2      1658.7    +3.7%
                                           ========    ========
System Benchmarks Index Score                9807.1     12139.2   +20.7%

./schbench -m 12 -t 16 -r 10
w/o patch:
Latency percentiles (usec)
        50.0th: 21 (5282 samples)
        75.0th: 29 (2549 samples)
        90.0th: 36 (1561 samples)
        95.0th: 39 (464 samples)
        *99.0th: 48 (397 samples)
        99.5th: 53 (53 samples)
        99.9th: 83 (40 samples)
        min=1, max=6341

w/ patch:
Latency percentiles (usec)
        50.0th: 22 (5395 samples)
        75.0th: 30 (2392 samples)
        90.0th: 36 (1622 samples)
        95.0th: 39 (509 samples)
        *99.0th: 46 (345 samples)
        99.5th: 51 (37 samples)
        99.9th: 124 (41 samples)
        min=1, max=2197

./hackbench -g $1 --thread --pipe -l 6000
(less time is better)

		  w/o patch			 w/ patch
grp
1	0.194   (+/- 5.96%)  		0.400 (+/- 4.50%)	+106.2%
2	0.418   (+/- 2.17%)  	        0.491 (+/- 5.69%)        +17.5%
4	0.520   (+/- 8.62%)             0.462 (+/- 2.31%)	 -11.1%
8	0.539   (+/- 2.50%)             0.514 (+/- 2.75%)	  -4.6%
16     10.825  (+/- 10.61%)             9.556 (+/- 7.06%)	 -11.7%
32      5.464   (+/- 0.56%)             5.537 (+/- 0.05%)	  +1.3%
64	9.007   (+/- 0.93%)             8.293 (+/- 3.00%)	  -7.9%
128	9.616   (+/- 3.02%)             8.470 (+/- 4.12%)	 -11.9%
256    14.278   (+/- 9.87%)            12.330 (+/- 5.39%)	 -13.6%

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..41ceb8581d36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -776,7 +776,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
-static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu, int sync_affine);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -6515,7 +6515,7 @@ static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-static int select_idle_sibling(struct task_struct *p, int prev, int target)
+static int select_idle_sibling(struct task_struct *p, int prev, int target, int sync_affine)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
@@ -6536,7 +6536,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	if ((available_idle_cpu(target) || sched_idle_cpu(target) || sync_affine) &&
 	    asym_fits_capacity(task_util, target))
 		return target;
 
@@ -7017,7 +7017,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
-	int want_affine = 0;
+	int want_affine = 0, sync_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
 
@@ -7046,6 +7046,12 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		 */
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
+			/*
+			 * If waker is the only running task and about to sleep,
+			 * there may be some data ready for wakee on this cpu.
+			 */
+			if (sched_feat(WA_IDLE) && sync && cpu_rq(cpu)->nr_running == 1)
+				sync_affine = 1;
 			if (cpu != prev_cpu)
 				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
 
@@ -7069,7 +7075,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, sync_affine);
 	}
 	rcu_read_unlock();
 
-- 
2.27.0

