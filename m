Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5027354824E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiFMIzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiFMIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79D25DB;
        Mon, 13 Jun 2022 01:43:25 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qWSaDBqtLIxal9+YZyOtYbcEvf+5mndEcjTJnEXjCI=;
        b=o0BltIupABGQsEZDq3eE5FApO2NgMObc3RcoMCNOrvTothfv80lMwo75wG1k9uNit4BvIr
        y83HqDGeT67Ri45I1kyyeHKcoWK0NOG/hKe1bhu1Jdz/bKev2K/t6PLHT5cecRNeqIYcK2
        ybyXctnnNndcI/Uvbf1F129DCSdCy1fHpXnihiqiwyLzdzeVZWfnyBycCffYKAK31fKSvg
        SXutBJqE39Rj5MTnmEPb69IDpQKpFfW8EJLDIb4mjjBSi50750oXtznHNLkk9QcCcAaNUr
        k/Rph8DPHoHVL+kA1LEYeYTa0vdhcKBbAWiTtjz3Aa7Qhwr36reILw+nC9wKmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qWSaDBqtLIxal9+YZyOtYbcEvf+5mndEcjTJnEXjCI=;
        b=psPxYos6GLHyialRl5mqrnr0dBcCZhleNK1xyM0MqilPMQe7+MIZWRlR6mQA+s530HNRKZ
        gk1Msy1CALeBxABQ==
From:   "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove the limitation of WF_ON_CPU on
 wakelist if wakee cpu is idle
Cc:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220608233412.327341-3-dtcccc@linux.alibaba.com>
References: <20220608233412.327341-3-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165510980253.4207.6782064033276870896.tip-bot2@tip-bot2>
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

Commit-ID:     f3dd3f674555bd9455c5ae7fafce0696bd9931b3
Gitweb:        https://git.kernel.org/tip/f3dd3f674555bd9455c5ae7fafce0696bd9931b3
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Thu, 09 Jun 2022 07:34:12 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:30:01 +02:00

sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle

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

    Latency percentiles (usec)              before        after
        50.0000th:                             8            6
        75.0000th:                            10            7
        90.0000th:                            11            8
        95.0000th:                            12            8
        *99.0000th:                           13           10
        99.5000th:                            15           11
        99.9000th:                            18           14

  Unixbench with full threads (104)
                                            before        after
    Dhrystone 2 using register variables  3011862938    3009935994  -0.06%
    Double-Precision Whetstone              617119.3      617298.5   0.03%
    Execl Throughput                         27667.3       27627.3  -0.14%
    File Copy 1024 bufsize 2000 maxblocks   785871.4      784906.2  -0.12%
    File Copy 256 bufsize 500 maxblocks     210113.6      212635.4   1.20%
    File Copy 4096 bufsize 8000 maxblocks  2328862.2     2320529.1  -0.36%
    Pipe Throughput                      145535622.8   145323033.2  -0.15%
    Pipe-based Context Switching           3221686.4     3583975.4  11.25%
    Process Creation                        101347.1      103345.4   1.97%
    Shell Scripts (1 concurrent)            120193.5      123977.8   3.15%
    Shell Scripts (8 concurrent)             17233.4       17138.4  -0.55%
    System Call Overhead                   5300604.8     5312213.6   0.22%

  hackbench -g 1 -l 100000
                                            before        after
    Time                                     3.246        2.251

On arm64 (Ampere Altra):
  schbench -m 2 -t 8

    Latency percentiles (usec)              before        after
        50.0000th:                            14           10
        75.0000th:                            19           14
        90.0000th:                            22           16
        95.0000th:                            23           16
        *99.0000th:                           24           17
        99.5000th:                            24           17
        99.9000th:                            28           25

  Unixbench with full threads (80)
                                            before        after
    Dhrystone 2 using register variables  3536194249    3537019613   0.02%
    Double-Precision Whetstone              629383.6      629431.6   0.01%
    Execl Throughput                         65920.5       65846.2  -0.11%
    File Copy 1024 bufsize 2000 maxblocks  1063722.8     1064026.8   0.03%
    File Copy 256 bufsize 500 maxblocks     322684.5      318724.5  -1.23%
    File Copy 4096 bufsize 8000 maxblocks  2348285.3     2328804.8  -0.83%
    Pipe Throughput                      133542875.3   131619389.8  -1.44%
    Pipe-based Context Switching           3215356.1     3576945.1  11.25%
    Process Creation                        108520.5      120184.6  10.75%
    Shell Scripts (1 concurrent)            122636.3        121888  -0.61%
    Shell Scripts (8 concurrent)             17462.1       17381.4  -0.46%
    System Call Overhead                   4429998.9     4435006.7   0.11%

  hackbench -g 1 -l 100000
                                            before        after
    Time                                     4.217        2.916

Our patch has improvement on schbench, hackbench
and Pipe-based Context Switching of unixbench
when there exists idle cpus,
and no obvious regression on other tests of unixbench.
This can help improve rt in scenes where wakeup happens frequently.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20220608233412.327341-3-dtcccc@linux.alibaba.com
---
 kernel/sched/core.c  | 26 ++++++++++++++------------
 kernel/sched/sched.h |  1 -
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 294b918..7234526 100644
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
@@ -3824,17 +3824,21 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
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
 	 *
 	 * Note that we can only get here with (wakee) p->on_rq=0,
 	 * p->on_cpu can be whatever, we've done the dequeue, so
 	 * the wakee has been accounted out of ->nr_running.
 	 */
-	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
+	if (!cpu_rq(cpu)->nr_running)
 		return true;
 
 	return false;
@@ -3842,10 +3846,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 
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
@@ -4167,7 +4168,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * scheduling.
 	 */
 	if (smp_load_acquire(&p->on_cpu) &&
-	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
+	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
 		goto unlock;
 
 	/*
@@ -4757,7 +4758,8 @@ static inline void prepare_task(struct task_struct *next)
 	 * Claim the task as running, we do this before switching to it
 	 * such that any running task will have this set.
 	 *
-	 * See the ttwu() WF_ON_CPU case and its ordering comment.
+	 * See the smp_load_acquire(&p->on_cpu) case in ttwu() and
+	 * its ordering comment.
 	 */
 	WRITE_ONCE(next->on_cpu, 1);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0125961..1e34bb4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2039,7 +2039,6 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 
 #define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
 #define WF_MIGRATED 0x20 /* Internal use, task got migrated */
-#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
