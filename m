Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54BB589A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiHDJwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiHDJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:51:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8F5275F3;
        Thu,  4 Aug 2022 02:51:47 -0700 (PDT)
Date:   Thu, 04 Aug 2022 09:51:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659606706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9KFp3Q8FANAJlxYolRoliLVkamvy/Db09livD6w2ms=;
        b=B33og1K3qhK2OzBZe5bJcaHsQ1m/GNOrv6WpuB9cV+YutQkBuISUTHNXVefQ8Evwk1m2TR
        oN4swROXBaX4uf6tHmzquNXPsTL4fjneQm9Q8UQrCc8D4xEmWyyGdGV6b2c6IHpGmlARzy
        Yrxopxo/jkiWWtjmTvrLu146oQ2YiUjBE/S0VuvFI0QTMgSWlUUL/q4Ok6eKSyAT6Nxxkz
        x/meVQae1TjUPRJLStJZDLisRENOb1fMc2miybMCnAzlWEATtRHrAyWVYfFG6ZFWHaad+X
        FtM/WVY+DRzl+6MHL/cvOp8bh1du1o1JaSDdfpLRUZ4eJhmUgAMfKU5WXas5iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659606706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9KFp3Q8FANAJlxYolRoliLVkamvy/Db09livD6w2ms=;
        b=ePh6+61LxOZqTEn7tDkUdlbgRK/MqCEYBY08Cl9xr68mK/OcOnpjigX6Kt//Hsyi/MpKFc
        c/D1fdDk/hXUZ0CQ==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Do not requeue task on CPU excluded
 from cpus_mask
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804092119.20137-1-mgorman@techsingularity.net>
References: <20220804092119.20137-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <165960670500.15455.2504938304719155397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     751d4cbc43879229dbc124afefe240b70fd29a85
Gitweb:        https://git.kernel.org/tip/751d4cbc43879229dbc124afefe240b70fd29a85
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Thu, 04 Aug 2022 10:21:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Aug 2022 11:26:13 +02:00

sched/core: Do not requeue task on CPU excluded from cpus_mask

The following warning was triggered on a large machine early in boot on
a distribution kernel but the same problem should also affect mainline.

   WARNING: CPU: 439 PID: 10 at ../kernel/workqueue.c:2231 process_one_work+0x4d/0x440
   Call Trace:
    <TASK>
    rescuer_thread+0x1f6/0x360
    kthread+0x156/0x180
    ret_from_fork+0x22/0x30
    </TASK>

Commit c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
optimises ttwu by queueing a task that is descheduling on the wakelist,
but does not check if the task descheduling is still allowed to run on that CPU.

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220804092119.20137-1-mgorman@techsingularity.net
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index addc3c2..02afa1c 100644
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
