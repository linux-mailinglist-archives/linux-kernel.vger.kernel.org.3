Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06C2525B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377290AbiEMGYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiEMGYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:24:41 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB50291E76
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:24:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VD1tx8B_1652423067;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VD1tx8B_1652423067)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 May 2022 14:24:35 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sched: Queue task on wakelist in the same llc if the wakee cpu is idle
Date:   Fri, 13 May 2022 14:24:27 +0800
Message-Id: <20220513062427.2375743-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
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

We notice the commit 518cd6234178 ("sched: Only queue remote wakeups
when crossing cache boundaries") disabled queuing tasks on wakelist when
the cpus share llc. This is because, at that time, the scheduler must
send IPIs to do ttwu_queue_wakelist. Nowadays, ttwu_queue_wakelist also
supports TIF_POLLING, so this is not a problem now when the wakee cpu is
in idle polling.

Benefits:
  Queuing the task on idle cpu can help improving performance on waker cpu
  and utilization on wakee cpu, and further improve locality because
  the wakee cpu can handle its own rq. This patch helps improving rt on
  our real java workloads where wakeup happens frequently.

Does this patch bring IPI flooding?
  For archs with TIF_POLLING_NRFLAG (e.g., x86), there will be no
  difference if the wakee cpu is idle polling. If the wakee cpu is idle
  but not polling, the later check_preempt_curr() will send IPI too.

  For archs without TIF_POLLING_NRFLAG (e.g., arm64), the IPI is
  unavoidable, since the later check_preempt_curr() will send IPI when
  wakee cpu is idle.

Benchmark:
running schbench -m 2 -t 8 on 8269CY:

without patch:
Latency percentiles (usec)
        50.0000th: 10
        75.0000th: 14
        90.0000th: 16
        95.0000th: 16
        *99.0000th: 17
        99.5000th: 20
        99.9000th: 23
        min=0, max=28

with patch:
Latency percentiles (usec)
        50.0000th: 6
        75.0000th: 8
        90.0000th: 9
        95.0000th: 9
        *99.0000th: 10
        99.5000th: 10
        99.9000th: 14
        min=0, max=16

We've also tested unixbench and see about 10% improvement on Pipe-based
Context Switching, and no performance regression on other test cases.

For arm64, we've tested schbench and unixbench on Kunpeng920, the
results show that, the improvement is not as obvious as on x86, and
there's no performance regression.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..cae5011a8b1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3820,6 +3820,9 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	if (!cpu_active(cpu))
 		return false;
 
+	if (cpu == smp_processor_id())
+		return false;
+
 	/*
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
@@ -3827,6 +3830,12 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	if (!cpus_share_cache(smp_processor_id(), cpu))
 		return true;
 
+	/*
+	 * If the CPU is idle, let itself do activation to improve utilization.
+	 */
+	if (available_idle_cpu(cpu))
+		return true;
+
 	/*
 	 * If the task is descheduling and the only running task on the
 	 * CPU then use the wakelist to offload the task activation to
@@ -3842,9 +3851,6 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
-		if (WARN_ON_ONCE(cpu == smp_processor_id()))
-			return false;
-
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
-- 
2.27.0

