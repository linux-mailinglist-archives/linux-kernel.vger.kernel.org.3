Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91510597C60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbiHRDpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiHRDpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:45:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69799411C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso612748pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pWnT33mPHdMvZcJ8SNdBSZ87EcCdDL5ffg44dY+n5ac=;
        b=3606vPhRV9ZndngZeLSAK9BjgLHmT/nKkpd2u9wNdZ+/5EDn/sF0kaDWHDRhYvIJ5j
         VPRt7OTjAo8MNE+Lz4PIayUQvwccLb7p+VlxUVEaADeEzojR3p1LcDPRHrFtFGkyqhXZ
         4ulgiAiz6FVB8Hbbjw/OJPr0v5g8LWQ4ZXhZEuN5SvXeizMsSZXApwYxYOaldWmF515i
         0AUZmYtMpPMEHM90hYK1ecv4jDBVG3H2qF4Pd9UnLrrYqsapV/L7Ee1Od0/krJgwC+7j
         hXWxvMAu8k8WKSquppsBP4BV12Gi//bKDsfWs+F6NJH9HL+U+pxTRjeYCanEzeahv3lf
         pWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pWnT33mPHdMvZcJ8SNdBSZ87EcCdDL5ffg44dY+n5ac=;
        b=K4iujJ8IHD6bvBavuswd3nszvo5fix+/flG1YedxQg16PNFU5WeZz1podwgOdwG0JH
         M7Y7I7gjobHhMdjOHyIqmNsLwLwZkC1AIEqaL7NnMtXi69RKvybXRLLopcMlo/WtSNON
         EzR6mP3BJkysqmnMFUSd42LAVC03fMLPKGwqZCNO5aQR+CBVFhKjCfzSsMb+TXckRSOJ
         wQ0U9+WGRNaO9Xr7vCrIlCZmNtM09VA0rf2g0vNC4up1Q+iB2mUBNa82pyWpP1/9PK/A
         A0UWeDY8ECuij07mxNmSkZkX+j5wk7VNqVjt75DZhm6OWUMGU52/s5frfuOjTqFqQlgo
         yWtQ==
X-Gm-Message-State: ACgBeo3kl+HlA9wgTYHphPm8x1YDpBTsWtu8W+tUtb2eBGlKGaCP/JpU
        cVF8mCAodkn3MC6MjYM3JZ0Jkw==
X-Google-Smtp-Source: AA6agR6xaurWKzuiWpVoUfPL93HJH+0sBR27OlFy+r7toqZKCp+h0t6x3O17oCX28HdA7Opdf9xQFg==
X-Received: by 2002:a17:903:22c7:b0:171:516d:d2a4 with SMTP id y7-20020a17090322c700b00171516dd2a4mr965888plg.98.1660794344160;
        Wed, 17 Aug 2022 20:45:44 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:45:43 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 1/9] sched/fair: maintain task se depth in set_task_rq()
Date:   Thu, 18 Aug 2022 11:43:35 +0800
Message-Id: <20220818034343.87625-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818034343.87625-1-zhouchengming@bytedance.com>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 8 --------
 kernel/sched/sched.h | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a71d6686149b..c5ee08b187ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11726,14 +11726,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
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
index ddcfc7837595..628ffa974123 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1932,6 +1932,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
 	p->se.cfs_rq = tg->cfs_rq[cpu];
 	p->se.parent = tg->se[cpu];
+	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.37.2

