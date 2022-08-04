Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DED5899D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiHDJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHDJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:21:35 -0400
Received: from outbound-smtp47.blacknight.com (outbound-smtp47.blacknight.com [46.22.136.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F94922B29
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:21:32 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 3BC87FABE8
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:21:31 +0100 (IST)
Received: (qmail 19609 invoked from network); 4 Aug 2022 09:21:30 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 4 Aug 2022 09:21:30 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/1] sched/core: Do not requeue task on CPU excluded from cpus_mask
Date:   Thu,  4 Aug 2022 10:21:19 +0100
Message-Id: <20220804092119.20137-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning was triggered on a large machine early in boot on
a distribution kernel but the same problem should also affect mainline.

[    7.732929] ------------[ cut here ]------------
[    7.736736] WARNING: CPU: 439 PID: 10 at ../kernel/workqueue.c:2231 process_one_work+0x4d/0x440
[    7.748731] Modules linked in:
[    7.748731] Supported: Yes
[    7.748731] CPU: 439 PID: 10 Comm: mm_percpu_wq Not tainted
[    7.748731] Hardware name: HPE Superdome Flex/Superdome Flex
[    7.748731] Workqueue:  0x0 (mm_percpu_wq)
[    7.748731] RIP: 0010:process_one_work+0x4d/0x440
[    7.748731] Code: 00 00 00 00 4c 0f 44 e0 49 8b 44 24 08 44 8b a8 00 01 00 00 41 83 e5 20 f6 45 10 04 75 0e 65 8b 05 98 64 f5 4e 39 45 04 74 02 <0f> 0b 48 ba eb 83 b5 80 46 86 c8 61 48 0f af d6 48 c1 ea 3a 48 8b
[    7.748731] RSP: 0000:ffffb15980183e88 EFLAGS: 00010093
[    7.748731] RAX: 00000000000001b7 RBX: ffff968ec02121f0 RCX: ffff96ddbcbf32a0
[    7.748731] RDX: ffff96ddbcbf3298 RSI: ffff96ddbcbeff40 RDI: ffff968ec02121c0
[    7.748731] RBP: ffff96ddbcbf3280 R08: ffff96ddbcc745d0 R09: 0000000000000000
[    7.748731] R10: ffffb15980183d98 R11: 0000000000000213 R12: ffff96ddbcbfcd00
[    7.748731] R13: 0000000000000000 R14: ffff96ddbcbfcd88 R15: ffff968ec02121c0
[    7.748731] FS:  0000000000000000(0000) GS:ffff96ddbcc40000(0000) knlGS:0000000000000000
[    7.748731] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.748731] CR2: 0000000000000000 CR3: 00000028b8810001 CR4: 00000000007706e0
[    7.748731] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.748731] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.748731] PKRU: 55555554
[    7.748731] Call Trace:
[    7.748731]  <TASK>
[    7.748731]  rescuer_thread+0x1f6/0x360
[    7.748731]  ? cancel_delayed_work+0xa0/0xa0
[    7.748731]  kthread+0x156/0x180
[    7.748731]  ? set_kthread_struct+0x40/0x40
[    7.748731]  ret_from_fork+0x22/0x30
[    7.748731]  </TASK>
[    7.748731] ---[ end trace 9cfa5ca579d758e4 ]---

Commit c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on
p->on_cpu") optimises ttwu by queueing a task that is descheduling
on the wakelist but does not check if the task descheduling is still
allowed to run on that CPU.

In this warning, the problematic task is a workqueue rescue thread which
checks if the rescue is for a per-cpu workqueue and running on the wrong CPU.
While this is early in boot and it should be possible to create workers,
the rescue thread may still used if the MAYDAY_INITIAL_TIMEOUT is reached
or MAYDAY_INTERVAL and on a sufficiently large machine, the rescue
thread is being used frequently.

Tracing confirmed that the task should have migrated properly using the
stopper thread to handle the migration. However, a parallel wakeup from udev
running on another CPU that does not share CPU cache observes p->on_cpu and
uses task_cpu(p), queues the task on the old CPU and triggers the warning.

Check that the wakee task that is descheduling is still allowed to run
on its current CPU and if not, wait for the descheduling to complete
and select an allowed CPU.

Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 189999007f32..139b5b409c46 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3802,7 +3802,7 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
-static inline bool ttwu_queue_cond(int cpu)
+static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 {
 	/*
 	 * Do not complicate things with the async wake_list while the CPU is
@@ -3811,6 +3811,10 @@ static inline bool ttwu_queue_cond(int cpu)
 	if (!cpu_active(cpu))
 		return false;
 
+	/* Ensure the task will still be allowed to run on the CPU. */
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return false;
+
 	/*
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
@@ -3840,7 +3844,7 @@ static inline bool ttwu_queue_cond(int cpu)
 
 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
-	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu)) {
+	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(p, cpu)) {
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
 		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
-- 
2.35.3

