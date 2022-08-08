Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046DD58C8D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiHHM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242423AbiHHM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16838BA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so7993051pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJVNRZWuthlVG6eumc2+xZt1bVXvLPuf4bfEzwEj/Wo=;
        b=6dDSvsFNGQ69wKIW/QKdjoE8xJFiEIeyydanuWHYbH4zsMgfaLOUOZzk6ynRtJeqUT
         gVRNLI2AqHldEcpMlLvDUPevPvA/KLqa4pUYt6tMd617qZ7fEFoDT8Kpo4F90dM1aF57
         YTwwIcsCQf2/jmCYIKldOQ6ZjXOuDx3XSSGLHIBg86bbvtka8KMxSzh90/rovCAw+wN/
         49Dh4kGgis+RmqxEOifFSZIApEYbX5tbPllO1dhL6QTQb1UoXUV9v/ZljR58NnpaZVj2
         xPobRB3isOq+rxuBAY5ysAjnMRpcSEmuxfrh+fJMq0AKCOsMspuQoJAB0yglzACu0a4n
         sLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJVNRZWuthlVG6eumc2+xZt1bVXvLPuf4bfEzwEj/Wo=;
        b=npnkX7pu3orpnXJkk02DU7Bro1e66oNrYrf5umPMfOuXHdCE5hT5xDXgdXzi2nVTHZ
         nDmM6VuUzrEdFlqFOxhSRB8fXBcTQSibA3fa98SwyKh2y6lFsj4Aeio8RLSjdJ0WKyiP
         dx/0Fif5RR8zXqGr1gC5A9lxyhMljsUMkieoHQW3jUfIXOEBxFigmjRFjkA85uB0Nxfa
         uP7tZNVL5MvQt8gNuPspX/Rhm+2O6UEGDYl6Vs98hLBEZEhOUh4YLETp7FNePsqqGP0P
         4lECTo2PwLBCkLzbzzyimR13XqO4sUYdlwvVBiEjYxyAXMyLNTpALzcv6IKCjifGUovm
         lvvQ==
X-Gm-Message-State: ACgBeo3ue+2w5XJo4bDh1UeVYefAsATyGYNeChEnU+PJHva3b7jO0y87
        T5znaK7NUi9f9wYi9jvbRfUphA==
X-Google-Smtp-Source: AA6agR6ywmSe8sZA101skeGGetaqxzyuock7Z4+LBpqjpoqh+sYXrQ6l6oRPu7cZdJ+MufUVONlAig==
X-Received: by 2002:a05:6a00:1c49:b0:52e:4e9a:a07a with SMTP id s9-20020a056a001c4900b0052e4e9aa07amr18262720pfw.26.1659963484057;
        Mon, 08 Aug 2022 05:58:04 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:03 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 1/9] sched/fair: maintain task se depth in set_task_rq()
Date:   Mon,  8 Aug 2022 20:57:37 +0800
Message-Id: <20220808125745.22566-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808125745.22566-1-zhouchengming@bytedance.com>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
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
index da388657d5ac..a3b0f8b1029e 100644
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
index 3ccd35c22f0f..4c4822141026 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1930,6 +1930,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
 	p->se.cfs_rq = tg->cfs_rq[cpu];
 	p->se.parent = tg->se[cpu];
+	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.36.1

