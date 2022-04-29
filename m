Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586C5155BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380824AbiD2UjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiD2UjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:39:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1D8230E;
        Fri, 29 Apr 2022 13:36:01 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:35:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K37SKVATOrDEGjpCoOVGz3lZnJ9xwueFxnQ9P6IsH5Y=;
        b=4A2s2/HoWsO123jM4qHEFMbopSCvs2NgBqCKTmKEwZSx29r843vx5WLqtFIWPgv7ld7wtv
        Kr7mFjm5zkHjkme4fTHf4drISHk23/9qFu8QzAYdYggZFDTj53qvHi3OumoSG2epiKLIYd
        twJ90s1kjAIHsMK9UUJ9Blh+9y6K2Jz77U9ItiDp9FSQVaL6V8w/KQuLh+uLlrtmLXqU5j
        UXM6K+jg05QcG7Er914+m4eHVwp/7YYE5+WJ3AMzGR8ReDrn3qNMWkBf/aaO4BvyRV37DR
        CYAyyGvCJylSn+VsR/7yfg0q0xVsSCKrI8GoWuuj2iyEAVxbLAUS+uaAsZlzsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K37SKVATOrDEGjpCoOVGz3lZnJ9xwueFxnQ9P6IsH5Y=;
        b=qZTwTZDY2N1NsgRO+NZYQXn96nSu3SXjjvsY1JaxJQ2bmMd2fZzLkanQhEMTuXpPyroYU+
        IJth+slwK9zY0vCw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove cfs_rq_tg_path()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220428144338.479094-3-qais.yousef@arm.com>
References: <20220428144338.479094-3-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <165126455892.4207.1028425150501881014.tip-bot2@tip-bot2>
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

Commit-ID:     97956dd278d3af1b5657026b992b54cf2e1b50b9
Gitweb:        https://git.kernel.org/tip/97956dd278d3af1b5657026b992b54cf2e1b50b9
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Apr 2022 15:43:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:29 +02:00

sched/fair: Remove cfs_rq_tg_path()

cfs_rq_tg_path() is used by a tracepoint-to traceevent (tp-2-te)
converter to format the path of a taskgroup or autogroup respectively.
It doesn't have any in-kernel users after the removal of the
sched_trace_cfs_rq_path() helper function.

cfs_rq_tg_path() can be coded in a tp-2-te converter.

Remove it from kernel/sched/fair.c.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220428144338.479094-3-qais.yousef@arm.com
---
 kernel/sched/fair.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19803e1..6ca054b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -313,19 +313,6 @@ const struct sched_class fair_sched_class;
 #define for_each_sched_entity(se) \
 		for (; se; se = se->parent)
 
-static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
-{
-	if (!path)
-		return;
-
-	if (cfs_rq && task_group_is_autogroup(cfs_rq->tg))
-		autogroup_path(cfs_rq->tg, path, len);
-	else if (cfs_rq && cfs_rq->tg->css.cgroup)
-		cgroup_path(cfs_rq->tg->css.cgroup, path, len);
-	else
-		strlcpy(path, "(null)", len);
-}
-
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -493,12 +480,6 @@ static int se_is_idle(struct sched_entity *se)
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
-static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
-{
-	if (path)
-		strlcpy(path, "(null)", len);
-}
-
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	return true;
