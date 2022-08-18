Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5159836C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiHRMsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbiHRMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403126108
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 24so1218502pgr.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pWnT33mPHdMvZcJ8SNdBSZ87EcCdDL5ffg44dY+n5ac=;
        b=yb5KLdXUXulR/7gbFuViIcRGvsePBu5ewFDaPy5og+Aojdgeg9N0K0S0JbZ3pqWHxE
         hEj23JrDQhWiGrybp82Bp2EDvXvDCfvGK9ICkLOEQLCIOFrTS22P6imp37hY3Zm0qREn
         WDd5SyUGy5kyW3LpzIIm5DvvrkZlLSzxCIvoJ3I4E6W6RRA16co3sRZJjHSIb69Bzark
         m25dyQe9uNhfFijDoIMU0ZjAlw7umwxkwhYox95rVOTPcN32ydP09IGkmhclalI0HG6Z
         rPoyrDGiWVNtKcRL7To5IFEEvYnuzLTdfJ2j/DCpupCzIFsfjW2b9oYaURXBn46fm2+0
         EWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pWnT33mPHdMvZcJ8SNdBSZ87EcCdDL5ffg44dY+n5ac=;
        b=G/T+uR654Z2A+FWjGMA5+u0Phl8+O81OY3vclygDaKs1GBS9mdAjdY0hGhZ9Kjylit
         ZLA8i5U8x1oTUNGB/22/v2aD/Kg9gZFGsH2by/ksz5aoTklKeS062D1KEDETZQGqhuU8
         zGAmdSCQlHOK/faH005AAXSaVZZ/QdmZulOm+m9/TyvR/7xNsxM/lWtuT2ht8EFNBriZ
         W+srxvdSqynNLF0LGqO1UtItuNpZSnhh6A5U8Ceo3cxWK9wdCLboCiuaJlAIYI99HiF1
         9kQhake9WES/6TZtV43BANjzROBna46peuz/FnX4WXCQZmjHStDlf7fStEOhJAXi2Nhy
         ryLg==
X-Gm-Message-State: ACgBeo1xRsuJHzu/fIwEBqWy8Q7W6N8dQf5mHJzzVDIgP8tHjEJ4W9Wk
        DMDyySU8QUPGar7OJjGR6Ldecg==
X-Google-Smtp-Source: AA6agR6A/+NDPmoxO2HtCCBQavads7LcUaDt81u7HLGsoN+scpZqsbK+QOfdUvI40Yu+FTZT1jJh3Q==
X-Received: by 2002:a63:41c4:0:b0:429:8c1b:61df with SMTP id o187-20020a6341c4000000b004298c1b61dfmr2364558pga.518.1660826902124;
        Thu, 18 Aug 2022 05:48:22 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:21 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 1/9] sched/fair: maintain task se depth in set_task_rq()
Date:   Thu, 18 Aug 2022 20:47:57 +0800
Message-Id: <20220818124805.601-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818124805.601-1-zhouchengming@bytedance.com>
References: <20220818124805.601-1-zhouchengming@bytedance.com>
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

