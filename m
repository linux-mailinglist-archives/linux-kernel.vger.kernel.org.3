Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA1A59E0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358386AbiHWLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357871AbiHWLg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:36:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D00C742F;
        Tue, 23 Aug 2022 02:27:38 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ/RMFf66nGK+xpI1jPIaUGANrAZSESSdwAr5o207UQ=;
        b=jq2XkPT7RCJBAOtUygmDvQ/bMuQLyACb6azHOkm3U/JfNB8SyhkyENQO7dpJJO4ZFjyF23
        Grq8S9H8/QwjJbRvpDaktHOQlJRv2R3zGqkkDbg5azXqHXpA9BVRT7rxGJn3eqqbJPHch6
        oDkFNP3snERopWw+X6EkwecrAbBZDsE9/p85zwehXXGrNyMrt/dfWgrTpCud16UuYAmfRA
        qa+5/7y49C8GievSQb1rhUbFGYdd2AR2e6aSNy4TwPzTywzE/XACzJwZIKGTqNlaqLV+MP
        PIXKyOOutfFmsjkb93p95UhGtWAVIBSUPx7aHRBGtyuEuXf480ZNoPF0c7xdtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ/RMFf66nGK+xpI1jPIaUGANrAZSESSdwAr5o207UQ=;
        b=l12mMzJbGXDjwEq+HmRw2WbdcTPVXgJO8/vloDb8bP8nJb6g+Nkmi25KJ+OZRrwVlC3Efo
        cxAcm9gigKPS95AA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reset sched_avg last_update_time before
 set_task_rq()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-4-zhouchengming@bytedance.com>
References: <20220818124805.601-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124685490.401.14854192796120212335.tip-bot2@tip-bot2>
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

Commit-ID:     5d6da83c44af70ede7bfd0fd6d1ef8a3b3e0402c
Gitweb:        https://git.kernel.org/tip/5d6da83c44af70ede7bfd0fd6d1ef8a3b3e0402c
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:47:59 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:18 +02:00

sched/fair: Reset sched_avg last_update_time before set_task_rq()

set_task_rq() -> set_task_rq_fair() will try to synchronize the blocked
task's sched_avg when migrate, which is not needed for already detached
task.

task_change_group_fair() will detached the task sched_avg from prev cfs_rq
first, so reset sched_avg last_update_time before set_task_rq() to avoid that.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220818124805.601-4-zhouchengming@bytedance.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c0eb2a..e4c0929 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11660,12 +11660,12 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 static void task_change_group_fair(struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
-	set_task_rq(p, task_cpu(p));
 
 #ifdef CONFIG_SMP
 	/* Tell se's cfs_rq has been changed -- migrated */
 	p->se.avg.last_update_time = 0;
 #endif
+	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
 }
 
