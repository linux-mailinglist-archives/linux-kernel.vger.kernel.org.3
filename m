Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74059DBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358140AbiHWLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357410AbiHWLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:35:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318DC6FCC;
        Tue, 23 Aug 2022 02:27:34 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JavbG4FavK4RyRgwMlt4DUH5+W8wPYivHE4KrAaXLIk=;
        b=EZ2K+3C2hj9Aldk4DCEi5xXG6INTX3Fz6HuMzEtZCgcC3XTTFjSXlo/Fqth0IRGyZy/+8M
        WG5rqfsMh6QKy+u8BRKX9CC2vmhQx2k9CdAXfZnwdZvdWe48ch77uv6MmRn9vXWXFvAN1C
        IN+mHcdh8giQHmGCv+T81ykLtfd10v1mZFBDlc373LjhtPjXc4R81iGWGPkqTktTjgCErf
        F9xXDoK9p2Ve9L87Hb8TQyG20B/yZMX66nLcxar9RAY4u86PW8ga5RqcUuYtaQ6msDMcic
        FiGirXZHEdKiBA4IVaOgZ01c9MIeVrg2JMxmXAABSs3da0NsX4ZM2L43ITNsYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JavbG4FavK4RyRgwMlt4DUH5+W8wPYivHE4KrAaXLIk=;
        b=LRXdFPNeZ4uZQS3f2eyH88eISnq1gzjrZSkcmIRVQDJeX90aXFevHjBibe7dGG8Vr9YQGs
        1BO2WM77jF91KeAg==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move task sched_avg attach to
 enqueue_task_fair()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-9-zhouchengming@bytedance.com>
References: <20220818124805.601-9-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124684994.401.15319814976088151997.tip-bot2@tip-bot2>
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

Commit-ID:     d6531ab6e50149ab2a144b0f4787cb9277d0893f
Gitweb:        https://git.kernel.org/tip/d6531ab6e50149ab2a144b0f4787cb9277d0893f
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:48:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:19 +02:00

sched/fair: Move task sched_avg attach to enqueue_task_fair()

When wake_up_new_task(), we use post_init_entity_util_avg() to init
util_avg/runnable_avg based on cpu's util_avg at that time, and
attach task sched_avg to cfs_rq.

Since enqueue_task_fair() -> enqueue_entity() -> update_load_avg()
loop will do attach, we can move this work to update_load_avg().

wake_up_new_task(p)
  post_init_entity_util_avg(p)
    attach_entity_cfs_rq()  --> (1)
  activate_task(rq, p)
    enqueue_task() := enqueue_task_fair()
      enqueue_entity() loop
        update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH)
          if (!se->avg.last_update_time && (flags & DO_ATTACH))
            attach_entity_load_avg()  --> (2)

This patch move attach from (1) to (2), update related comments too.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220818124805.601-9-zhouchengming@bytedance.com
---
 kernel/sched/fair.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fd1aa4c..ef325b5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -799,8 +799,6 @@ void init_entity_runnable_average(struct sched_entity *se)
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
 
-static void attach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
@@ -863,8 +861,6 @@ void post_init_entity_util_avg(struct task_struct *p)
 		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 		return;
 	}
-
-	attach_entity_cfs_rq(se);
 }
 
 #else /* !CONFIG_SMP */
@@ -3838,8 +3834,7 @@ static void migrate_se_pelt_lag(struct sched_entity *se) {}
  * @cfs_rq: cfs_rq to update
  *
  * The cfs_rq avg is the direct sum of all its entities (blocked and runnable)
- * avg. The immediate corollary is that all (fair) tasks must be attached, see
- * post_init_entity_util_avg().
+ * avg. The immediate corollary is that all (fair) tasks must be attached.
  *
  * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
  *
@@ -4072,8 +4067,8 @@ static void remove_entity_load_avg(struct sched_entity *se)
 
 	/*
 	 * tasks cannot exit without having gone through wake_up_new_task() ->
-	 * post_init_entity_util_avg() which will have added things to the
-	 * cfs_rq, so we can remove unconditionally.
+	 * enqueue_task_fair() which will have added things to the cfs_rq,
+	 * so we can remove unconditionally.
 	 */
 
 	sync_entity_load_avg(se);
