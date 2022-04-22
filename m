Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8263950B1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444897AbiDVHjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbiDVHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:39:01 -0400
X-Greylist: delayed 1715 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 00:36:09 PDT
Received: from localhost.localdomain (unknown [219.141.250.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C0C50B02
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:36:08 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost.localdomain)
        by localhost.localdomain with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <kunyu@nfschina.com>)
        id 1nhnNr-0006Hd-Mq; Fri, 22 Apr 2022 15:07:15 +0800
Received: (from root@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 23M76wCn024156;
        Fri, 22 Apr 2022 15:06:58 +0800
Date:   Fri, 22 Apr 2022 15:06:58 +0800
From:   Li kunyu <kunyu@nfschina.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Optimize unused integer return values
Message-ID: <20220422070658.GA24149@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_PBL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
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

