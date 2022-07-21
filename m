Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6057C6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiGUIoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiGUIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:44:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFC7E83E;
        Thu, 21 Jul 2022 01:44:41 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:44:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658393080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6t9SHuMpqSRx23aqqJvzAgAl2wSJRu2uE4nVE1EuwaE=;
        b=HOpNuJdZWQdsxlM3ZAL5s3u0OHNXcV9M2pXKAEscti+nSDJ8CUGxpWyZrqHdM9K5jwMyza
        OPHPG9xS/9kIGwuTtxLkYPNSBeXMYi8lguCO/exyGY9phnRhlgOAv3VYP0E1x0cK2bpn1u
        uUw5PaXsJVLKH2Ka09ZQ+HxxIk+auW2sDuxGHOrvYs/2W6Ba2zOxbyWV4aTDbZbX4pj/Du
        06NMlta4SPR1Eb8FAXLpjz1EdI0bOXTzrHEokzE1rptd2iAK0DBIEEnT+6vP7/rpV8Mig2
        QwnzctD9xS1aEHDx/m8+UCLijZQcqMOlrUIZgxiflCGqUoMAepHpQvEER8b0aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658393080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6t9SHuMpqSRx23aqqJvzAgAl2wSJRu2uE4nVE1EuwaE=;
        b=3Yws62MJ/gSpiqluCct2wa8nWfZZzQEFtq0mKiq+RlrNv0jZ1Ezui6A6CaWLJzZ1AKceHA
        tZ/PstudlX1fCUCg==
From:   "tip-bot2 for Libo Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Disallow sync wakeup from interrupt context
Cc:     Libo Chen <libo.chen@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220711224704.1672831-1-libo.chen@oracle.com>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
MIME-Version: 1.0
Message-ID: <165839307880.15455.1642344321269380664.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     14b3f2d9ee8df3b6040f7e21f9fcd1d848938fd9
Gitweb:        https://git.kernel.org/tip/14b3f2d9ee8df3b6040f7e21f9fcd1d848938fd9
Author:        Libo Chen <libo.chen@oracle.com>
AuthorDate:    Mon, 11 Jul 2022 15:47:04 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Jul 2022 10:39:39 +02:00

sched/fair: Disallow sync wakeup from interrupt context

Barry Song first pointed out that replacing sync wakeup with regular wakeup
seems to reduce overeager wakeup pulling and shows noticeable performance
improvement.[1]

This patch argues that allowing sync for wakeups from interrupt context
is a bug and fixing it can improve performance even when irq/softirq is
evenly spread out.

For wakeups from ISR, the waking CPU is just the CPU of ISR and the so-called
waker can be any random task that happens to be running on that CPU when the
interrupt comes in. This is completely different from other wakups where the
task running on the waking CPU is the actual waker. For example, two tasks
communicate through a pipe or mutiple tasks access the same critical section,
etc. This difference is important because with sync we assume the waker will
get off the runqueue and go to sleep immedately after the wakeup. The
assumption is built into wake_affine() where it discounts the waker's presence
from the runqueue when sync is true. The random waker from interrupts bears no
relation to the wakee and don't usually go to sleep immediately afterwards
unless wakeup granularity is reached. Plus the scheduler no longer enforces the
preepmtion of waker for sync wakeup as it used to before
patch f2e74eeac03ffb7 ("sched: Remove WAKEUP_SYNC feature"). Enforcing sync
wakeup preemption for wakeups from interrupt contexts doesn't seem to be
appropriate too but at least sync wakeup will do what it's supposed to do.

Add a check to make sure that sync can only be set when in_task() is true. If
a wakeup is from interrupt context, sync flag will be 0 because in_task()
returns 0.

Tested in two scenarios: wakeups from 1) task contexts, expected to see no
performance changes; 2) interrupt contexts, expected to see better performance
under low/medium load and no regression under heavy load.

Use hackbench for scenario 1 and pgbench for scenarios 2 both from mmtests on
a 2-socket Xeon E5-2699v3 box with 256G memory in total. Running 5.18 kernel
with SELinux disabled. Scheduler/MM tunables are all default. Irqbalance
daemon is active.

Hackbench (config-scheduler-unbound)
=========
process-pipes:
                Baseline                Patched
Amean   1       0.4300  ( 0.00%)        0.4420  ( -2.79%)
Amean   4       0.8757  ( 0.00%)        0.8774  ( -0.20%)
Amean   7       1.3712  ( 0.00%)        1.3789  ( -0.56%)
Amean   12      2.3541  ( 0.00%)        2.3714  ( -0.73%)
Amean   21      4.2229  ( 0.00%)        4.2439  ( -0.50%)
Amean   30      5.9113  ( 0.00%)        5.9451  ( -0.57%)
Amean   48      9.3873  ( 0.00%)        9.4898  ( -1.09%)
Amean   79      15.9281 ( 0.00%)        16.1385 ( -1.32%)
Amean   110     22.0961 ( 0.00%)        22.3433 ( -1.12%)
Amean   141     28.2973 ( 0.00%)        28.6209 ( -1.14%)
Amean   172     34.4709 ( 0.00%)        34.9347 ( -1.35%)
Amean   203     40.7621 ( 0.00%)        41.2497 ( -1.20%)
Amean   234     47.0416 ( 0.00%)        47.6470 ( -1.29%)
Amean   265     53.3048 ( 0.00%)        54.1625 ( -1.61%)
Amean   288     58.0595 ( 0.00%)        58.8096 ( -1.29%)

process-sockets:
                Baseline                Patched
Amean   1       0.6776   ( 0.00%)       0.6611   ( 2.43%)
Amean   4       2.6183   ( 0.00%)       2.5769   ( 1.58%)
Amean   7       4.5662   ( 0.00%)       4.4801   ( 1.89%)
Amean   12      7.7638   ( 0.00%)       7.6201   ( 1.85%)
Amean   21      13.5335  ( 0.00%)       13.2915  ( 1.79%)
Amean   30      19.3369  ( 0.00%)       18.9811  ( 1.84%)
Amean   48      31.0724  ( 0.00%)       30.6015  ( 1.52%)
Amean   79      51.1881  ( 0.00%)       50.4251  ( 1.49%)
Amean   110     71.3399  ( 0.00%)       70.4578  ( 1.24%)
Amean   141     91.4675  ( 0.00%)       90.3769  ( 1.19%)
Amean   172     111.7463 ( 0.00%)       110.3947 ( 1.21%)
Amean   203     131.6927 ( 0.00%)       130.3270 ( 1.04%)
Amean   234     151.7459 ( 0.00%)       150.1320 ( 1.06%)
Amean   265     171.9101 ( 0.00%)       169.9751 ( 1.13%)
Amean   288     186.9231 ( 0.00%)       184.7706 ( 1.15%)

thread-pipes:
                Baseline                Patched
Amean   1       0.4523  ( 0.00%)        0.4535  ( -0.28%)
Amean   4       0.9041  ( 0.00%)        0.9085  ( -0.48%)
Amean   7       1.4111  ( 0.00%)        1.4146  ( -0.25%)
Amean   12      2.3532  ( 0.00%)        2.3688  ( -0.66%)
Amean   21      4.1550  ( 0.00%)        4.1701  ( -0.36%)
Amean   30      6.1043  ( 0.00%)        6.2391  ( -2.21%)
Amean   48      10.2077 ( 0.00%)        10.3511 ( -1.40%)
Amean   79      16.7922 ( 0.00%)        17.0427 ( -1.49%)
Amean   110     23.3350 ( 0.00%)        23.6522 ( -1.36%)
Amean   141     29.6458 ( 0.00%)        30.2617 ( -2.08%)
Amean   172     35.8649 ( 0.00%)        36.4225 ( -1.55%)
Amean   203     42.4477 ( 0.00%)        42.8332 ( -0.91%)
Amean   234     48.7117 ( 0.00%)        49.4042 ( -1.42%)
Amean   265     54.9171 ( 0.00%)        55.6551 ( -1.34%)
Amean   288     59.5282 ( 0.00%)        60.2903 ( -1.28%)

thread-sockets:
                Baseline                Patched
Amean   1       0.6917   ( 0.00%)       0.6892   ( 0.37%)
Amean   4       2.6651   ( 0.00%)       2.6017   ( 2.38%)
Amean   7       4.6734   ( 0.00%)       4.5637   ( 2.35%)
Amean   12      8.0156   ( 0.00%)       7.8079   ( 2.59%)
Amean   21      14.0451  ( 0.00%)       13.6679  ( 2.69%)
Amean   30      20.0963  ( 0.00%)       19.5657  ( 2.64%)
Amean   48      32.4115  ( 0.00%)       31.6001  ( 2.50%)
Amean   79      53.1104  ( 0.00%)       51.8395  ( 2.39%)
Amean   110     74.0929  ( 0.00%)       72.4391  ( 2.23%)
Amean   141     95.1506  ( 0.00%)       93.0992  ( 2.16%)
Amean   172     116.1969 ( 0.00%)       113.8307 ( 2.04%)
Amean   203     137.4413 ( 0.00%)       134.5247 ( 2.12%)
Amean   234     158.5395 ( 0.00%)       155.2793 ( 2.06%)
Amean   265     179.7729 ( 0.00%)       176.1099 ( 2.04%)
Amean   288     195.5573 ( 0.00%)       191.3977 ( 2.13%)

Pgbench (config-db-pgbench-timed-ro-small)
=======
                Baseline            Patched
Hmean   1       68.54    ( 0.00%)   69.72    ( 1.71%)
Hmean   6       27725.78 ( 0.00%)   34119.11 ( 23.06%)
Hmean   12      55724.26 ( 0.00%)   63158.22 ( 13.34%)
Hmean   22      72806.26 ( 0.00%)   73389.98 ( 0.80%)
Hmean   30      79000.45 ( 0.00%)   75197.02 ( -4.81%)
Hmean   48      78180.16 ( 0.00%)   75074.09 ( -3.97%)
Hmean   80      75001.93 ( 0.00%)   70590.72 ( -5.88%)
Hmean   110     74812.25 ( 0.00%)   74128.57 ( -0.91%)
Hmean   142     74261.05 ( 0.00%)   72910.48 ( -1.82%)
Hmean   144     75375.35 ( 0.00%)   71295.72 ( -5.41%)

For hackbench, +-3% fluctuation is normal on this two-socket box, it's safe to
conclude that there are no performance differences for wakeups from task context.
For pgbench, after many runs, 10~30% gains are very consistent at lower
client counts (< #cores per socket). For higher client counts, both kernels are
very close, +-5% swings are quite common. Also NET_TX|RX softirq load
does spread out across both NUMA nodes in this test so there is no need to do
any explicit RPS/RFS.

[1]: https://lkml.kernel.org/r/20211105105136.12137-1-21cnbao@gmail.com

Signed-off-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220711224704.1672831-1-libo.chen@oracle.com
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c..2fc4725 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7013,7 +7013,10 @@ unlock:
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 {
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	/*
+	 * Only consider WF_SYNC from task context; since only a task can schedule out.
+	 */
+	int sync = in_task() && (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
