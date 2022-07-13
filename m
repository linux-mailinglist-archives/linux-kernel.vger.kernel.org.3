Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6519572C20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiGMEFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGMEFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5E8D9E1B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o15so10292688pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAiAxlX2yM9GEaHbySNw9bkpD1G1UgOvHW7DJbEFXpw=;
        b=cOoaSwrn9IFMIlZOmUPyAQ/aqgUX6EhUFNVqVpyKQTX/rcK9qMAoKONBBvY5xBkP2w
         QrrlvasfIGG4EVKsBClQsrcxI52Yf9KsMH7bMmS44ZW+svk6cBXOneuH+JaZAewg4Dlp
         beifnQkrxQdJHV5P+RJviIPq9n8NHRjV0AxNE/d3/6XCORFxvE/r4ftwAtBChGaWlIzc
         zM8MVWb7G5NXEYBTDurq2fH+DYuxvl0jdmAjGe1GXeJBBqRVYJhwaYTM1t05K3dTJY9w
         cXX80MX0AKCjPcCD7hjsmJwSa5h+z+QAapD8HqSjdH+CQDNeT6VMVkHcUD3ATxDJZMyu
         //KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAiAxlX2yM9GEaHbySNw9bkpD1G1UgOvHW7DJbEFXpw=;
        b=z3G04JfA8E/dMZnb1nMcxsuVNQy8STrRmq/1uVZHJFo9k8B1sSFGTs0PxIXXE7nI68
         2gh16vU4pAX9Z0cRr0teaT5LIoplq3HRMq2o4TlpGAb14ce9Ju4Sw3JpNowXmWtB4Ulq
         RcPTahFcXM6ETIpRHKxFiHJWf7BbPhANcDZEetG8SugN9wrTrjZCQdn0/aBnU4+eQ7+H
         CjNT1bICbnU9MYBW5joT9gtUWC5BqfooOmnd92Q530FweDHKKIQF5PZFAmy4z9kZ6UGe
         Nb5ZJSeOPm9p2qkmXGGD/FlNPzvKJtBOMGEtDZ5MlMP4Kqr4GBaNAMXPKF6bElzCgz/2
         NIYQ==
X-Gm-Message-State: AJIora8m8I+RZ1PVAPaTS8U/Ao1UlUsItHgcwOOouFjA/XcXTgj++Bmj
        baxdVIUMyX9zxwgVAFxjY1xI+w==
X-Google-Smtp-Source: AGRyM1ttdf7T1YLlh9gJKvXn7DL9hQMPjsyvEYNHt+5K3wISV4uNTInrWjdZ1GdFlW4VFultDEYkqg==
X-Received: by 2002:a17:90a:f3c8:b0:1ef:7976:a6d8 with SMTP id ha8-20020a17090af3c800b001ef7976a6d8mr8126104pjb.198.1657685098516;
        Tue, 12 Jul 2022 21:04:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:04:58 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 03/10] sched/fair: maintain task se depth in set_task_rq()
Date:   Wed, 13 Jul 2022 12:04:23 +0800
Message-Id: <20220713040430.25778-4-zhouchengming@bytedance.com>
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

Previously we only maintain task se depth in task_move_group_fair(),
if a !fair task change task group, its se depth will not be updated,
so commit eb7a59b2c888 ("sched/fair: Reset se-depth when task switched to FAIR")
fix the problem by updating se depth in switched_to_fair() too.

This patch move task se depth maintainence to set_task_rq(), which will be
called when CPU/cgroup change, so its depth will always be correct.

This patch is preparation for the next patch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c  | 8 --------
 kernel/sched/sched.h | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2a3e12ead144..bf595b622656 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11539,14 +11539,6 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
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

