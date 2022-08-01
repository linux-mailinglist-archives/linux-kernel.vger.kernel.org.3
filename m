Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B06C58637E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiHAE2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiHAE2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33132DFA6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so8697010pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/w4d2+EaQroyv2P/11Ro6fW4T9xIlpzK4n5YR8bSveQ=;
        b=SjypgSlEb0OP8iYCGGYtl5NTi7gHq0BX+OwbrP1J8RTxVLJtlwsCt8HHENmT1W/7Hs
         5VQtbEpd9Hlt3meP5bennKtCSfMXuZPYRpqBSmSCrbu7vQ636/HoukKS4SqT2UFUVo3g
         9QA4Zw0nwRlc15LNoSBT8FHHypdEHJC5OhdNZSyuiUuo0SdlUtNMyJgltYauzKpHmMXf
         BhOnw5knl1gwCkyGYTHA++UVBKswNn5SghrO1gJOz9Sl7c3wamkXv4B9C0IZmiQad9tB
         Ys5KnIpDtbG6waWI6t6TjdQXT9JCKtoT6mSsoVNF1L7niH3j2GBH25bxscQrwouYzmcR
         VEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/w4d2+EaQroyv2P/11Ro6fW4T9xIlpzK4n5YR8bSveQ=;
        b=BPNzEWxtTMDvZVAUUDVlSSRJB/JD36IQqIf/buEg7ha3O8bsD6qs3fVvO2kbcd+0zu
         lJ8ANnFwBE25NGyo1GH9xt0KZ2+hupYxwlN8vsmHEM+vFit2z2GovLKH6f+fd/AHONVB
         cCrQnTxk1CMNVkUZH0eKakXpAk911kiWLXyS9SJtNkIFigTS+hqMKG2xHan8A5sIMkOl
         jVzRa38RDm20wycDOlPOWWgc80EtwZW5DyuLAcHYofmTOR+E5Vrz4UfW1zS8TQTQwzko
         UIiPGxMeNQ1O9R2WxtdeD5fzHOXWKfHmr6iDoNmlVT/WM4zrwy/UiGg0aQcAZHasXpSI
         o3iQ==
X-Gm-Message-State: ACgBeo1QK0RSqZ2ljeJEXAbdB0Mn2VFad6R2GGj6h7DQtqRTJVhMK42P
        yQXM3bMl+B4JMVBJHrKynhtgvg==
X-Google-Smtp-Source: AA6agR495PY4jykHh20wj3uEIXUt+rv6O6xqlNdzX0mVPMpQCfaNl6aE2MCoh6YkWS/xWTHrU47WXA==
X-Received: by 2002:aa7:8e91:0:b0:52d:8ebf:29a4 with SMTP id a17-20020aa78e91000000b0052d8ebf29a4mr1706695pfr.1.1659328085577;
        Sun, 31 Jul 2022 21:28:05 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 01/10] sched/fair: maintain task se depth in set_task_rq()
Date:   Mon,  1 Aug 2022 12:27:36 +0800
Message-Id: <20220801042745.7794-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 2fc47257ae91..77cd2bad17a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11566,14 +11566,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
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
index aad7f5ee9666..8cc3eb7b86cd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1940,6 +1940,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	set_task_rq_fair(&p->se, p->se.cfs_rq, tg->cfs_rq[cpu]);
 	p->se.cfs_rq = tg->cfs_rq[cpu];
 	p->se.parent = tg->se[cpu];
+	p->se.depth = tg->se[cpu] ? tg->se[cpu]->depth + 1 : 0;
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-- 
2.36.1

