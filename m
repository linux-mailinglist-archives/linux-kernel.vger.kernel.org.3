Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3195059DD82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358482AbiHWLlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357900AbiHWLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:36:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5BDC7B88;
        Tue, 23 Aug 2022 02:27:39 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zjfTNaFn8VPa2Lkn3ZMfM122fEeU0I/FmGpR0qv5RI=;
        b=IvcnGwcc2Xj2heUIQ8SEYTdFpQSIcBX5v7C3w+bqDH++L57ZWLdrsz+esWRLB1x9K4wIK6
        G9eHvMFHY6YpzANWuwhYvLybmtpdBMP8mbMU55piOl462Z9hwdqfPLc0Q6KqAXAFQGNb0V
        8kHg7w0oTbMcCkIBni5Uz1R7em87iugBhCvb5BhRTs8IwkfdX4aiaGejcjuG6Azvx3XyGB
        QU6vexapqunKN86ipv5GWSm6ka5fVPYhkBq+v7121vtd7Hw8S0ZXXj+JbN5jXLLTUN9rzC
        5Z2p1nZcsUw1xctMGBhnmA3L+ItJxRokFp9TdGPl+zKFxAVH1stSDoqEnJUctw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zjfTNaFn8VPa2Lkn3ZMfM122fEeU0I/FmGpR0qv5RI=;
        b=I9mAqVd8ECCjA3yol8K/JQg+Scsf1o02zfm0dDxv73bQ0qWVfGKmor7xuHhW0psKWHKoWp
        oLDJ/XHyRoQ692Cg==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Maintain task se depth in set_task_rq()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-2-zhouchengming@bytedance.com>
References: <20220818124805.601-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124685689.401.4486657040685089131.tip-bot2@tip-bot2>
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

Commit-ID:     78b6b15770618efb60d84e2d605f6b93dc94051b
Gitweb:        https://git.kernel.org/tip/78b6b15770618efb60d84e2d605f6b93dc94051b
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:47:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:17 +02:00

sched/fair: Maintain task se depth in set_task_rq()

Previously we only maintain task se depth in task_move_group_fair(),
if a !fair task change task group, its se depth will not be updated,
so commit eb7a59b2c888 ("sched/fair: Reset se-depth when task switched to FAIR")
fix the problem by updating se depth in switched_to_fair() too.

Then commit daa59407b558 ("sched/fair: Unify switched_{from,to}_fair()
and task_move_group_fair()") unified these two functions, moved se.depth
setting to attach_task_cfs_rq(), which further into attach_entity_cfs_rq()
with commit df217913e72e ("sched/fair: Factorize attach/detach entity").

This patch move task se depth maintenance from attach_entity_cfs_rq()
to set_task_rq(), which will be called when CPU/cgroup change, so its
depth will always be correct.

This patch is preparation for the next patch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220818124805.601-2-zhouchengming@bytedance.com
---
 kernel/sched/fair.c  | 8 --------
 kernel/sched/sched.h | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da38865..a3b0f8b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11562,14 +11562,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	/*
-	 * Since the real-depth could have been changed (only FAIR
-	 * class maintain depth value), reset depth properly.
-	 */
-	se->depth = se->parent ? se->parent->depth + 1 : 0;
-#endif
-
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
 	attach_entity_load_avg(cfs_rq, se);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3ccd35c..4c48221 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1930,6 +1930,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
 	p->se.cfs_rq = tg->cfs_rq[cpu];
 	p->se.parent = tg->se[cpu];
+	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
