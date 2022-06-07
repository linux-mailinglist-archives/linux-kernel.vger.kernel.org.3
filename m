Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1961653B266
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiFBEHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiFBEHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:07:00 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C7D5799D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:06:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VF8oYOn_1654142815;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VF8oYOn_1654142815)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 12:06:56 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle
Date:   Thu,  2 Jun 2022 12:06:45 +0800
Message-Id: <20220602040645.275555-3-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220602040645.275555-1-dtcccc@linux.alibaba.com>
References: <20220602040645.275555-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wakelist can help avoid cache bouncing and offload the overhead of waker
cpu. So far, using wakelist within the same llc only happens on
WF_ON_CPU, and this limitation could be removed to further improve
wakeup performance.

The commit 518cd6234178 ("sched: Only queue remote wakeups when
crossing cache boundaries") disabled queuing tasks on wakelist when
the cpus share llc. This is because, at that time, the scheduler must
send IPIs to do ttwu_queue_wakelist. Nowadays, ttwu_queue_wakelist also
supports TIF_POLLING, so this is not a problem now when the wakee cpu is
in idle polling.

Benefits:
  Queuing the task on idle cpu can help improving performance on waker cpu
  and utilization on wakee cpu, and further improve locality because
  the wakee cpu can handle its own rq. This patch helps improving rt on
  our real java workloads where wakeup happens frequently.

  Consider the normal condition (CPU0 and CPU1 share same llc)
  Before this patch:

         CPU0                                       CPU1

    select_task_rq()                                idle
    rq_lock(CPU1->rq)
    enqueue_task(CPU1->rq)
    notify CPU1 (by sending IPI or CPU1 polling)

                                                    resched()

  After this patch:

         CPU0                                       CPU1

    select_task_rq()                                idle
    add to wakelist of CPU1
    notify CPU1 (by sending IPI or CPU1 polling)

                                                    rq_lock(CPU1->rq)
                                                    enqueue_task(CPU1->rq)
                                                    resched()

  We see CPU0 can finish its work earlier. It only needs to put task to
  wakelist and return.
  While CPU1 is idle, so let itself handle its own runqueue data.

This patch brings no difference about IPI.
  This patch only takes effect when the wakee cpu is:
  1) idle polling
  2) idle not polling

  For 1), there will be no IPI with or without this patch.

  For 2), there will always be an IPI before or after this patch.
  Before this patch: waker cpu will enqueue task and check preempt. Since
  "idle" will be sure to be preempted, waker cpu must send a resched IPI.
  After this patch: waker cpu will put the task to the wakelist of wakee
  cpu, and send an IPI.

Benchmark:
We've tested schbench, unixbench, and hachbench on both x86 and arm64.

On x86 (Intel Xeon Platinum 8269CY):
  schbench -m 2 -t 8

    Latency percentiles (usec)             before         after
        50.0000th:                            8             6
        75.0000th:                           10             7
        90.0000th:                           11             8
        95.0000th:                           12             8
        *99.0000th:                          15            10
        99.5000th:                           16            11
        99.9000th:                           20            14

  Unixbench with full threads (104)
                                            before        after
    Dhrystone 2 using register variables  3004614211    3004725417   0.00%
    Double-Precision Whetstone              616764.3      617355.9   0.10%
    Execl Throughput                         26449.2       26468.6   0.07%
    File Copy 1024 bufsize 2000 maxblocks   832763.3      824099.4  -1.04%
    File Copy 256 bufsize 500 maxblocks     210718.7      211775.1   0.50%
    File Copy 4096 bufsize 8000 maxblocks  2393528.2     2398755.4   0.22%
    Pipe Throughput                      144559102.7   144605068.8   0.03%
    Pipe-based Context Switching           3192192.9     3571238.1  11.87%
    Process Creation                         95270.5       98865.4   3.77%
    Shell Scripts (1 concurrent)            113780.6      113924.7   0.13%
    Shell Scripts (8 concurrent)             15557.2       15508.9  -0.31%
    System Call Overhead                   5359984.1     5356711.4  -0.06%

  hackbench -g 1 -l 100000
                                            before        after
    Time                                     3.246        2.251

On arm64 (Ampere Altra):
  schbench -m 2 -t 8

    Latency percentiles (usec)             before         after
        50.0000th:                           14            10
        75.0000th:                           19            14
        90.0000th:                           22            16
        95.0000th:                           23            16
        *99.0000th:                          24            17
        99.5000th:                           24            17
        99.9000th:                           31            25

  Unixbench with full threads (80)
                                            before        after
    Dhrystone 2 using register variables  3536787968    3536476016  -0.01%
    Double-Precision Whetstone              629370.6      629333.3  -0.01%
    Execl Throughput                         66615.9       66288.8  -0.49%
    File Copy 1024 bufsize 2000 maxblocks  1038402.1     1050181.2   1.13%
    File Copy 256 bufsize 500 maxblocks     311054.2      310317.2  -0.24%
    File Copy 4096 bufsize 8000 maxblocks  2276795.6       2297703   0.92%
    Pipe Throughput                      130409359.9   130390848.7  -0.01%
    Pipe-based Context Switching           3148440.7     3383705.1   7.47%
    Process Creation                        111574.3      119728.6   7.31%
    Shell Scripts (1 concurrent)            122980.7      122657.4  -0.26%
    Shell Scripts (8 concurrent)             17482.8       17476.8  -0.03%
    System Call Overhead                   4424103.4     4430062.6   0.13%

  hackbench -g 1 -l 100000
                                            before        after
    Time                                     4.217        2.916

Our patch has improvement on schbench, hackbench
and Pipe-based Context Switching of unixbench
when there exists idle cpus,
and no obvious regression on other tests of unixbench.
This can help improve rt in scenes where wakeup happens frequently.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/core.c  | 27 ++++++++++++++++-----------
 kernel/sched/sched.h |  1 -
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9efe134fbe5..ccb9e0fbf49b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3808,7 +3808,7 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
-static inline bool ttwu_queue_cond(int cpu, int wake_flags)
+static inline bool ttwu_queue_cond(int cpu)
 {
 	/*
 	 * Do not complicate things with the async wake_list while the CPU is
@@ -3824,13 +3824,21 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	if (!cpus_share_cache(smp_processor_id(), cpu))
 		return true;
 
+	if (cpu == smp_processor_id())
+		return false;
+
 	/*
-	 * If the task is descheduling and the only running task on the
-	 * CPU then use the wakelist to offload the task activation to
-	 * the soon-to-be-idle CPU as the current CPU is likely busy.
-	 * nr_running is checked to avoid unnecessary task stacking.
+	 * If the wakee cpu is idle, or the task is descheduling and the
+	 * only running task on the CPU, then use the wakelist to offload
+	 * the task activation to the idle (or soon-to-be-idle) CPU as
+	 * the current CPU is likely busy. nr_running is checked to
+	 * avoid unnecessary task stacking.
+	 *
+	 * Note that we can only get here with (wakee) p->on_rq=0,
+	 * p->on_cpu can be whatever, we've done the dequeue, so
+	 * the wakee has been accounted out of ->nr_running.
 	 */
-	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
+	if (!cpu_rq(cpu)->nr_running)
 		return true;
 
 	return false;
@@ -3838,10 +3846,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
-	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
-		if (WARN_ON_ONCE(cpu == smp_processor_id()))
-			return false;
-
+	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu)) {
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
@@ -4163,7 +4168,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * scheduling.
 	 */
 	if (smp_load_acquire(&p->on_cpu) &&
-	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
+	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
 		goto unlock;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 01259611beb9..1e34bb4527fd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2039,7 +2039,6 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 
 #define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
 #define WF_MIGRATED 0x20 /* Internal use, task got migrated */
-#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
-- 
2.27.0

