Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A3572C27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiGMEF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiGMEF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C669DA0E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b8so8883923pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YxO3douG9yaDP325H3l2tI70xR2hZpS+aWxFMUKMRFw=;
        b=auPbO2h7LsRh0gM5laDsxqiugnJF/UTbb95NxHR5R+lPBv3nn0ZvzDqgNMeEKd5jDt
         fwZB+f/j3ByGbbss/INMM5XXu5JrDdjPGYXBiybN/XmGIB4Mr3eCfamx3AZ7Mwv39Joc
         FzHgyfnxjc57xsr8Q/jfz+CiiLIbopxmCz07ZxmjOfyNUIk1TzIdJxUhFRkvryoqqXvb
         EZGLs8jb0BmSTQ1OQpLI5B0MXL1S4RqHDEvgUj2CCBlyzBJMOB/Z84BS095VX/TdrpnG
         8xkHujETtEbEjEscZB/AtQ0bIUPhXUJpyImGqYObrseIuFwJlvOfA8JY8/DVgIhEfI+E
         S3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YxO3douG9yaDP325H3l2tI70xR2hZpS+aWxFMUKMRFw=;
        b=Tf6axrlmHdfMfTLSQecYccZI1WPW+29BywKuNRBkiBuzsVq5uVPOyAUzzlJtKg5BwO
         MTMQAGvJ47OuK1QsHTUCHmvgkSdFISIKaoTYkxD5giLUmmi9hQyq6PBuYqJSgN+0J/Sz
         2ZU0d0P6ZlWH0CLugxuW40XmEXDwPCAdXggCdaWLfvWdV36PNT0XdOLGei0BO3tVcP+0
         RRh85EsdeCSzODwt1+f/n29vbiZYaP5HKDmj4IQ7f8ddxVOlmggYkBYKBZQVCDY7XI7S
         eMJB/O+VpoiHTomhrnyiTgHwca9vcqUtVa/IwYfS60v24PyIqKCqe/z3B5W8Flm/sB+m
         Zbwg==
X-Gm-Message-State: AJIora9T6tqMAbrUNrvXEBl2uz/gpT7hTIp9Hv9NRRQN4+Yt+gcmLCQ8
        8QVdoDD1t6d6Wa7BeNhKoGGZKHLLpLo3hUnT
X-Google-Smtp-Source: AGRyM1ubREtBdERwinjkfVXTmWC38yQCiY3CzrFHJGyov5zSsVcwROeUDgetNw7hdK0J6h6IqKJY4A==
X-Received: by 2002:a17:903:40cc:b0:16c:115d:5e80 with SMTP id t12-20020a17090340cc00b0016c115d5e80mr1282948pld.0.1657685125521;
        Tue, 12 Jul 2022 21:05:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:05:25 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 10/10] sched/fair: delete superfluous set_task_rq_fair()
Date:   Wed, 13 Jul 2022 12:04:30 +0800
Message-Id: <20220713040430.25778-11-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713040430.25778-1-zhouchengming@bytedance.com>
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
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
And delete unused ATTACH_AGE_LOAD feature together.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c     | 31 -------------------------------
 kernel/sched/features.h |  1 -
 kernel/sched/sched.h    |  8 --------
 3 files changed, 40 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 576028f5a09e..b435eda88468 100644
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
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..fb92431d496f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,7 +85,6 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 
 SCHED_FEAT(RT_RUNTIME_SHARE, false)
 SCHED_FEAT(LB_MIN, false)
-SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
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

