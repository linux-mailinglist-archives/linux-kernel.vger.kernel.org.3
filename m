Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1B5140CA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiD2DEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiD2DDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:03:49 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3173C3334F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:00:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E8E001E80D45;
        Fri, 29 Apr 2022 10:56:53 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GieVs9qPp06N; Fri, 29 Apr 2022 10:56:51 +0800 (CST)
Received: from localhost.localdomain (unknown [111.193.132.126])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id EC6FE1E80D05;
        Fri, 29 Apr 2022 10:56:50 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH RESEND] sched: Optimize unused integer return values
Date:   Fri, 29 Apr 2022 10:58:52 +0800
Message-Id: <20220429025852.49657-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched: Optimize unused integer return values

Signed-off-by: Li kunyu<kunyu@nfschina.com>
---
 kernel/sched/core.c  | 3 +--
 kernel/sched/sched.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..a71d09d6bb75 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5491,11 +5491,10 @@ static void sched_tick_stop(int cpu)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-int __init sched_tick_offload_init(void)
+void __init sched_tick_offload_init(void)
 {
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
-	return 0;
 }
 
 #else /* !CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..850e25f7460d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2326,7 +2326,7 @@ extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool sched_can_stop_tick(struct rq *rq);
-extern int __init sched_tick_offload_init(void);
+extern void __init sched_tick_offload_init(void);
 
 /*
  * Tick may be needed by tasks in the runqueue depending on their policy and
@@ -2346,7 +2346,7 @@ static inline void sched_update_tick_dependency(struct rq *rq)
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
 }
 #else
-static inline int sched_tick_offload_init(void) { return 0; }
+static inline void sched_tick_offload_init(void) { }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
 #endif
 
-- 
2.18.2

