Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B144C27BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiBXJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiBXJJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:22 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53541A02B8;
        Thu, 24 Feb 2022 01:08:46 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so716745pjb.3;
        Thu, 24 Feb 2022 01:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zLpZo5QCnWe/V5DcsLs28NYLJFV4odvnBRSD6UeNM/k=;
        b=OF46hEzKbJzGkAj4LQoG5UF+FfqdwWxtgkEjFPUrwxsFza0+Vl/4gUMqQ60whMF5Lh
         LGF86o9/iSw5LpN1Ho8zMgIis3bKWqat8gPpF5QJfP7v53nTpGRSzuMR7sUoOIAIVRCK
         T/ko1ank720shMFRAJe5KJfM4b8zU1utgR1Z4dileRtVb+96EO9x2/ZpFMjw1gbt+wWI
         4ng2klWDKTGyYw/NlOy86X0PEw6PwuwW7EuVkcb9r0MqP/Zu2Cizgw1TJVpv+V0+oaXm
         iNcHgpRyt7GKbEih4K+6Vi/e0lhbr6XIe4ED6pbRZqhZ4h2PjtwmaIAjSrf2DhdEUtPW
         i5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zLpZo5QCnWe/V5DcsLs28NYLJFV4odvnBRSD6UeNM/k=;
        b=r0jD/rFF+39YBfU5+yGIrj8m/cs1WZxb8N51r6TqrKvqTPwHJM2wJwqI9ndNhp1I9Y
         bpPMV8Y1iPlSO+VHGRORaPl/UVE6tFLIPUna5lzJ76kO/GUJ72j6TR0VhC2h33/4GZDZ
         sM7JQ5DxhkSqtpz5Dx38hMWoyqA7DxN+/CGwKRaRaCP5Pm5YFQS4LXB0zHbtYrmFbCwA
         7osh+iBSLcLXpfPYj1/J6NlcS3IKqkYtdcLLTtai9wC4RcRmYZl3DxaY3M+WYINhGCWi
         43pLHLTC/t09uHkJbJ5MpL06zhecVosJk8GKrjqKeVUYXysxmCJ1L1uutqgNGP5eelUK
         T4oQ==
X-Gm-Message-State: AOAM5314ye399mySlbFb/KjF9YJPbNEOblTvxG4Gp5jV3APmqa+PrKXq
        RGfgCUlQ8CFU/7G6xf3607Y=
X-Google-Smtp-Source: ABdhPJzUm7Qb9J3IkPsDs5/peIEyz+A8FOydKrLVSPohYNN7luJgq+EMSFe97grVj6mM502usgOqTQ==
X-Received: by 2002:a17:902:854a:b0:14e:e053:c8b3 with SMTP id d10-20020a170902854a00b0014ee053c8b3mr1936118plo.8.1645693726272;
        Thu, 24 Feb 2022 01:08:46 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:45 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 10/16] blk-wbt: get rid of wbt_enable/disable_default()
Date:   Thu, 24 Feb 2022 17:06:48 +0800
Message-Id: <20220224090654.54671-11-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224090654.54671-1-jianchao.wan9@gmail.com>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wbt_enable_default() is used to open wbt feature by default.
wbt_disable_default() is only employed by bfq which has similar
writeback throttling mechanism. This kind of policy should be
selected by the user instead of being set in kernel. This patch
get rid of the interfaces and let the user configure appropricate
blk-rq-qos policy by themselves.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/bfq-iosched.c |  2 --
 block/blk-sysfs.c   |  3 +--
 block/blk-wbt.c     | 60 +--------------------------------------------
 block/blk-wbt.h     | 22 -----------------
 block/elevator.c    |  3 ---
 5 files changed, 2 insertions(+), 88 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0c612a911696..adbe5ff6c5e8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -132,7 +132,6 @@
 #include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
 #include "bfq-iosched.h"
-#include "blk-wbt.h"
 
 #define BFQ_BFQQ_FNS(name)						\
 void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)			\
@@ -7158,7 +7157,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfq_init_root_group(bfqd->root_group, bfqd);
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
-	wbt_disable_default(q);
 	return 0;
 
 out_free:
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1b321edd7ba7..4563283dae07 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -17,8 +17,8 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
-#include "blk-wbt.h"
 #include "blk-throttle.h"
+#include "blk-rq-qos.h"
 
 static ssize_t
 queue_var_show(unsigned long var, char *page)
@@ -810,7 +810,6 @@ int blk_register_queue(struct gendisk *disk)
 	}
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-	wbt_enable_default(q);
 	blk_throtl_register_queue(q);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index bbec3b394273..6c0a85ddb107 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -86,8 +86,7 @@ enum {
 
 static inline bool rwb_enabled(struct rq_wb *rwb)
 {
-	return rwb && rwb->enable_state != WBT_STATE_OFF_DEFAULT &&
-		      rwb->wb_normal != 0;
+	return rwb && rwb->wb_normal != 0;
 }
 
 static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
@@ -703,7 +702,6 @@ static ssize_t wbt_lat_store(struct request_queue *q, const char *page,
 	blk_mq_quiesce_queue(q);
 
 	rwb->min_lat_nsec = val;
-	rwb->enable_state = WBT_STATE_ON_MANUAL;
 	wbt_update_limits(rwb);
 
 	blk_mq_unquiesce_queue(q);
@@ -734,26 +732,6 @@ static void wbt_exit(struct rq_qos *rqos)
 	__wbt_exit(rqos);
 }
 
-/*
- * Disable wbt, if enabled by default.
- */
-void wbt_disable_default(struct request_queue *q)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-	struct rq_wb *rwb;
-
-	if (!rqos)
-		return;
-
-	rwb = RQWB(rqos);
-	if (rwb->enable_state == WBT_STATE_ON_DEFAULT) {
-		blk_stat_deactivate(rwb->cb);
-		rwb->enable_state = WBT_STATE_OFF_DEFAULT;
-	}
-	rq_qos_put(rqos);
-}
-EXPORT_SYMBOL_GPL(wbt_disable_default);
-
 #ifdef CONFIG_BLK_DEBUG_FS
 static int wbt_curr_win_nsec_show(void *data, struct seq_file *m)
 {
@@ -764,15 +742,6 @@ static int wbt_curr_win_nsec_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static int wbt_enabled_show(void *data, struct seq_file *m)
-{
-	struct rq_qos *rqos = data;
-	struct rq_wb *rwb = RQWB(rqos);
-
-	seq_printf(m, "%d\n", rwb->enable_state);
-	return 0;
-}
-
 static int wbt_id_show(void *data, struct seq_file *m)
 {
 	struct rq_qos *rqos = data;
@@ -831,7 +800,6 @@ static int wbt_background_show(void *data, struct seq_file *m)
 
 static const struct blk_mq_debugfs_attr wbt_debugfs_attrs[] = {
 	{"curr_win_nsec", 0400, wbt_curr_win_nsec_show},
-	{"enabled", 0400, wbt_enabled_show},
 	{"id", 0400, wbt_id_show},
 	{"inflight", 0400, wbt_inflight_show},
 	{"min_lat_nsec", 0400, wbt_min_lat_nsec_show},
@@ -862,7 +830,6 @@ static int wbt_init(struct request_queue *q)
 
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
-	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->wc = 1;
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
 
@@ -900,31 +867,6 @@ static struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-/*
- * Enable wbt if defaults are configured that way
- */
-void wbt_enable_default(struct request_queue *q)
-{
-	struct rq_qos *rqos = wbt_rq_qos(q);
-
-	/* Throttling already enabled? */
-	if (rqos) {
-		if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
-			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
-
-		rq_qos_put(rqos);
-		return;
-	}
-
-	/* Queue not registered? Maybe shutting down... */
-	if (!blk_queue_registered(q))
-		return;
-
-	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
-		wbt_init(q);
-}
-EXPORT_SYMBOL_GPL(wbt_enable_default);
-
 static __init int wbt_mod_init(void)
 {
 	return rq_qos_register(&wbt_rqos_ops);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index b9ed3f373b5a..fe26f78390bd 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -27,16 +27,6 @@ enum {
 	WBT_NUM_RWQ,
 };
 
-/*
- * Enable states. Either off, or on by default (done at init time),
- * or on through manual setup in sysfs.
- */
-enum {
-	WBT_STATE_ON_DEFAULT	= 1,
-	WBT_STATE_ON_MANUAL	= 2,
-	WBT_STATE_OFF_DEFAULT
-};
-
 struct rq_wb {
 	/*
 	 * Settings that govern how we throttle
@@ -44,8 +34,6 @@ struct rq_wb {
 	unsigned int wb_background;		/* background writeback */
 	unsigned int wb_normal;			/* normal writeback */
 
-	short enable_state;			/* WBT_STATE_* */
-
 	/*
 	 * Number of consecutive periods where we don't have enough
 	 * information to make a firm scale up/down decision.
@@ -85,12 +73,8 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 	return ret;
 }
 
-
 #ifdef CONFIG_BLK_WBT
 
-void wbt_disable_default(struct request_queue *);
-void wbt_enable_default(struct request_queue *);
-
 void wbt_set_write_cache(struct request_queue *, bool);
 
 #else
@@ -98,12 +82,6 @@ void wbt_set_write_cache(struct request_queue *, bool);
 static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
 }
-static inline void wbt_disable_default(struct request_queue *q)
-{
-}
-static inline void wbt_enable_default(struct request_queue *q)
-{
-}
 static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
 {
 }
diff --git a/block/elevator.c b/block/elevator.c
index ec98aed39c4f..0da6fcf08d7b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -43,7 +43,6 @@
 #include "blk.h"
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
-#include "blk-wbt.h"
 
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
@@ -525,8 +524,6 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_del(&e->kobj);
 
 		e->registered = 0;
-		/* Re-enable throttling in case elevator disabled it */
-		wbt_enable_default(q);
 	}
 }
 
-- 
2.17.1

