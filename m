Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6320856CA4B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiGIPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGIPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:15:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FAB33A27
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:15:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m2so1114795plx.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFXP5LC8HL3mqo588wuUmwfRWCNgtbOQ+XNQ7lde5Ys=;
        b=65RueBNubOToFHloKGsGeVW9SUCku7EopCzpY1hqUZZ5kgCeRrhhZfSCikqIy8vjxC
         X8LNoWeIMwhfREI+F6fFdwZIqOB1lXIvN4uWdfIZedqjQsqIoOFJVUtg9KrEE50Psp0K
         EI7VeHRsF58LLbXh2CNQi3L2q8UNtKRtZaNcGnRqeKLgAB/gD4qHbqE8IF5Y++BINUTk
         VAvv1sBmYH901m4tBtjYpjdIvjr1d+RUO00Sn3e9i9+EkTmems93MsWjqMzQY4dTg5F1
         OWpV3klXiXJqNQwPWHqyhLk8SygYu2iLC8JqCGCiOe/5G1v4kwi3j0GgOHlCNYhwxWy4
         pCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFXP5LC8HL3mqo588wuUmwfRWCNgtbOQ+XNQ7lde5Ys=;
        b=YgRXfavwaw8N14GlCKuS+/jYVlufpoFXaQJlAntodxF2Aip6r63FVryV/WjV3gXy7n
         n5v3WLTYdJcjBMA/XcbpDvrK9xvVnvWLqyOwQ3Nitc2hYun23iooChkDyL4HDg9yDda8
         /Lbb5bcVgogkDuib4RqfqlVUE43gs60N9WBmzSYRsw7KB7B7uHpNuI37hE8LHpgpoT0P
         y6Ozn9lfrdVV34FrOy8M8TqBxszEyR1EZUTYwq6VEeydLG+ACv8g0sSuEYKpIyWSclmy
         z501vbgHzrg9K6EjIMKqGqkXiFYzVg2Unm9KFMwQK1ibeRE/fm21pXUgamIktnPCkTXi
         oGgA==
X-Gm-Message-State: AJIora+I8+iJDrI2YYtie4pnKiBEJuMIx0SolWBX/sSNloXZP8v0nwKu
        KqISnIB+KdIcrzKy4hDhpzpHjdVEr0OQG6Wb
X-Google-Smtp-Source: AGRyM1uJuDOP8/4RP6+RcZbmValw0bVnXErnn/seWnQORd5hmeg9tr9BIjA2AhQwIHS8TZl5qUhCMg==
X-Received: by 2002:a17:902:d490:b0:16b:fb09:50ea with SMTP id c16-20020a170902d49000b0016bfb0950eamr9277224plg.77.1657379754754;
        Sat, 09 Jul 2022 08:15:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:54 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 7/8] sched/fair: delete superfluous set_task_rq_fair()
Date:   Sat,  9 Jul 2022 23:13:52 +0800
Message-Id: <20220709151353.32883-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709151353.32883-1-zhouchengming@bytedance.com>
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
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

set_task_rq() is used when move task across CPUs/groups to change
its cfs_rq and parent entity, and it will call set_task_rq_fair()
to sync blocked task load_avg just before change its cfs_rq.

1. task migrate CPU: will detach/remove from prev cfs_rq and reset
   its sched_avg last_update_time to 0, so don't need to sync again.

2. task migrate cgroup: will detach from prev cfs_rq and reset its
   sched_avg last_update_time to 0, so don't need to sync too.

3. !fair task migrate CPU/cgroup: we stop load tracking for !fair task,
   reset sched_avg last_update_time to 0 when switched_from_fair(), so
   don't need it too.

So set_task_rq_fair() is not needed anymore, this patch delete it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c  | 31 -------------------------------
 kernel/sched/sched.h |  8 --------
 2 files changed, 39 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ca714eedeec5..b0bde895ba96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3430,37 +3430,6 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	}
 }
 
-/*
- * Called within set_task_rq() right before setting a task's CPU. The
- * caller only guarantees p->pi_lock is held; no other assumptions,
- * including the state of rq->lock, should be made.
- */
-void set_task_rq_fair(struct sched_entity *se,
-		      struct cfs_rq *prev, struct cfs_rq *next)
-{
-	u64 p_last_update_time;
-	u64 n_last_update_time;
-
-	if (!sched_feat(ATTACH_AGE_LOAD))
-		return;
-
-	/*
-	 * We are supposed to update the task to "current" time, then its up to
-	 * date and ready to go to new CPU/cfs_rq. But we have difficulty in
-	 * getting what current time is, so simply throw away the out-of-date
-	 * time. This will result in the wakee task is less decayed, but giving
-	 * the wakee more load sounds not bad.
-	 */
-	if (!(se->avg.last_update_time && prev))
-		return;
-
-	p_last_update_time = cfs_rq_last_update_time(prev);
-	n_last_update_time = cfs_rq_last_update_time(next);
-
-	__update_load_avg_blocked_se(p_last_update_time, se);
-	se->avg.last_update_time = n_last_update_time;
-}
-
 /*
  * When on migration a sched_entity joins/leaves the PELT hierarchy, we need to
  * propagate its contribution. The key to this propagation is the invariant
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 19e0076e4245..a8ec7af4bd51 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -505,13 +505,6 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
-#ifdef CONFIG_SMP
-extern void set_task_rq_fair(struct sched_entity *se,
-			     struct cfs_rq *prev, struct cfs_rq *next);
-#else /* !CONFIG_SMP */
-static inline void set_task_rq_fair(struct sched_entity *se,
-			     struct cfs_rq *prev, struct cfs_rq *next) { }
-#endif /* CONFIG_SMP */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #else /* CONFIG_CGROUP_SCHED */
@@ -1937,7 +1930,6 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
 	p->se.cfs_rq = tg->cfs_rq[cpu];
 	p->se.parent = tg->se[cpu];
 	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
-- 
2.36.1

