Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAF4C3CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiBYEKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBYEKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:10:04 -0500
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 20:09:31 PST
Received: from mailgate01.didichuxing.com (mx2.didichuxing.com [36.110.17.22])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C389B254560
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:09:31 -0800 (PST)
Received: from mail.didiglobal.com (unknown [172.20.36.141])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id E6919D80C3E06;
        Fri, 25 Feb 2022 12:01:24 +0800 (CST)
Received: from localhost.localdomain (172.31.2.13) by
 BJSGEXMBX11.didichuxing.com (172.20.15.141) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 25 Feb 2022 12:01:24 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.141
From:   Honglei Wang <wanghonglei@didichuxing.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Honglei Wang <jameshongleiwang@126.com>,
        Honglei Wang <wanghonglei@didichuxing.com>
Subject: [PATCH] sched debug: refine the output of sched-debug
Date:   Fri, 25 Feb 2022 12:01:17 +0800
Message-ID: <20220225040117.40235-1-wanghonglei@didichuxing.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.2.13]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX11.didichuxing.com (172.20.15.141)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several items including sum-block, numabalancing associates and task
group path were missed in the header of sched debug info. Let's add them
to make the info clearer.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
---
 kernel/sched/debug.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index aa29211de1bf..ca1316f1def6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -548,7 +548,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
-	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, "        %d           %d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	SEQ_printf_task_group_path(m, task_group(p), " %s")
@@ -563,8 +563,16 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
-		   "     wait-time             sum-exec        sum-sleep\n");
+	SEQ_printf(m, " S            task   PID         tree-key  switches  prio");
+	SEQ_printf(m, "     wait-time             sum-exec        sum-sleep");
+	SEQ_printf(m, "        sum-block");
+#ifdef CONFIG_NUMA_BALANCING
+	SEQ_printf(m, "    node  numa-group");
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+	SEQ_printf(m, " task-group");
+#endif
+	SEQ_printf(m, "\n");
 	SEQ_printf(m, "-------------------------------------------------------"
 		   "------------------------------------------------------\n");
 
-- 
2.14.1

