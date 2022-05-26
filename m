Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE28F534C54
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346838AbiEZJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346814AbiEZJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:10:39 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF86DC6E52;
        Thu, 26 May 2022 02:10:37 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D4BAE1E80D3A;
        Thu, 26 May 2022 17:02:59 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WwSRPcp8U3_5; Thu, 26 May 2022 17:02:57 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.89])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 696951E80D01;
        Thu, 26 May 2022 17:02:56 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] sched: change printk(KERN_<LEVEL>.. to pr_<level>()
Date:   Thu, 26 May 2022 02:10:31 -0700
Message-Id: <20220526091031.3741819-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer pr_<level>(...  to printk(KERN_<LEVEL> ..., change them.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 kernel/sched/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a247f8d9d417..4522bb3bbafb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5602,7 +5602,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 	if (oops_in_progress)
 		return;
 
-	printk(KERN_ERR "BUG: scheduling while atomic: %s/%d/0x%08x\n",
+	pr_err("BUG: scheduling while atomic: %s/%d/0x%08x\n",
 		prev->comm, prev->pid, preempt_count());
 
 	debug_show_held_locks(prev);
@@ -5636,7 +5636,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	if (!preempt && READ_ONCE(prev->__state) && prev->non_block_count) {
-		printk(KERN_ERR "BUG: scheduling in a non-blocking section: %s/%d/%i\n",
+		pr_err("BUG: scheduling in a non-blocking section: %s/%d/%i\n",
 			prev->comm, prev->pid, prev->non_block_count);
 		dump_stack();
 		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
@@ -9370,7 +9370,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
 
 	lockdep_assert_rq_held(rq);
 
-	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
+	pr_warn("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
 	for_each_process_thread(g, p) {
 		if (task_cpu(p) != cpu)
 			continue;
@@ -9378,7 +9378,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
 		if (!task_on_rq_queued(p))
 			continue;
 
-		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
+		pr_warn("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
 	}
 }
 
@@ -9773,8 +9773,8 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 		return;
 	prev_jiffy = jiffies;
 
-	printk(KERN_ERR "BUG: assuming atomic context at %s:%d\n", file, line);
-	printk(KERN_ERR "in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
+	pr_err("BUG: assuming atomic context at %s:%d\n", file, line);
+	pr_err("in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
 			in_atomic(), irqs_disabled(),
 			current->pid, current->comm);
 
-- 
2.25.1

