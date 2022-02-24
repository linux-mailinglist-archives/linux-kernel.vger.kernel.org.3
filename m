Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60554C279C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiBXJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiBXJJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:05 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67619E0A5;
        Thu, 24 Feb 2022 01:08:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 12so1259110pgd.0;
        Thu, 24 Feb 2022 01:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nx8GCTCx6Zwjghi38JpLlv6BNyEAfbmY7D9QOG9o9BE=;
        b=DzEeRDK/keZK/gwZpdZ137RRiHFrQyVRP39pKv58zsMwCzQhnIuGNzFNuDce6+hdWW
         Qaveh5x6rErROnWbwY0jBBuwcpb0SabJOVg31R4DssC4OUznzIARc3X2DFM8o4xlhWg2
         3ZAf0sVBLaOeUk9LhVPNXw/vk+CXIrVfCeLqRHxSSLY6SnHvVp6Y9R4VX4FExXkVCfGl
         kTpnlv2SQby+dBAINjmIZRzhDCn1tVcfPmEwBFxv5bOPIN0gs9fujeUTgg1bk3ZY2AeX
         HIhaYkfudhDTZWkjtCBP/rtiTRLT7/czDD5AYv97t/RLdv9PcX0O5RIAXpaNJdWHsOd3
         c/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nx8GCTCx6Zwjghi38JpLlv6BNyEAfbmY7D9QOG9o9BE=;
        b=OQKMwstIagygZMFO2JWTyEFqtpR9QsbgI4/B1i0irMIaIyl7iMpyiEzbVMKi0z0cdb
         x112AcXQzBsWrzQ5kPaHdU+lF3b90FDDlFFNwEMpXR+MNa6Q4tpDMEmWo0ld9z/+m/4N
         dBPYAFixUQL8RipLpUL8D+Lf304wWVK+tmpIhAr8v3aDXtEO62CyZ9tsTuqdaD5wUP6A
         K5b4c+MKLaGeraUNCcKbApQmDXxLDQaXDaNrhpq4vvGQzmRdCg5SfPYCYtjINdfallQY
         7FBGEsj7iG3CsDdEsHYBtsXHgnL9i1wtugPokCzojrCUUJ9Rn/IguaLIvruzIDvMiDz0
         IARg==
X-Gm-Message-State: AOAM532WrGhJLoBtq/p3H9TdoWAwnCg4TBEGIUSNK5icNOjrIvl/1jWX
        HTyhGnwLyh+ItKIuDJlgs28OSVwbRdEojg==
X-Google-Smtp-Source: ABdhPJx0S/65fbYpA5OKdQStj/iXK+wsS+H3aKskTsHu7ozvaCyl7g0+CwIKsI/ilj57UGQVA0A++Q==
X-Received: by 2002:a63:3545:0:b0:36c:479c:927a with SMTP id c66-20020a633545000000b0036c479c927amr1506619pga.347.1645693712016;
        Thu, 24 Feb 2022 01:08:32 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:31 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 04/16] blk-iolatency: make iolatency pluggable
Date:   Thu, 24 Feb 2022 17:06:42 +0800
Message-Id: <20220224090654.54671-5-jianchao.wan9@gmail.com>
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

Use new blk-rq-qos API to make blk-iolatency pluggable.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-cgroup.c     |  6 ------
 block/blk-iolatency.c  | 44 +++++++++++++++++++++++++++---------------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 ------
 block/blk.h            |  6 ------
 5 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 650f7e27989f..3ae2aa557aef 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1203,12 +1203,6 @@ int blkcg_init_queue(struct request_queue *q)
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_iolatency_init(q);
-	if (ret) {
-		blk_throtl_exit(q);
-		goto err_destroy_all;
-	}
-
 	return 0;
 
 err_destroy_all:
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 6593c7123b97..1459b606e995 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -90,6 +90,8 @@ struct blk_iolatency {
 	atomic_t enabled;
 };
 
+static struct rq_qos_ops blkcg_iolatency_ops;
+
 static inline struct blk_iolatency *BLKIOLATENCY(struct rq_qos *rqos)
 {
 	return container_of(rqos, struct blk_iolatency, rqos);
@@ -646,15 +648,10 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	del_timer_sync(&blkiolat->timer);
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
+	rq_qos_deactivate(rqos);
 	kfree(blkiolat);
 }
 
-static struct rq_qos_ops blkcg_iolatency_ops = {
-	.throttle = blkcg_iolatency_throttle,
-	.done_bio = blkcg_iolatency_done_bio,
-	.exit = blkcg_iolatency_exit,
-};
-
 static void blkiolatency_timer_fn(struct timer_list *t)
 {
 	struct blk_iolatency *blkiolat = from_timer(blkiolat, t, timer);
@@ -716,7 +713,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 	rcu_read_unlock();
 }
 
-int blk_iolatency_init(struct request_queue *q)
+static int blk_iolatency_init(struct request_queue *q)
 {
 	struct blk_iolatency *blkiolat;
 	struct rq_qos *rqos;
@@ -727,15 +724,10 @@ int blk_iolatency_init(struct request_queue *q)
 		return -ENOMEM;
 
 	rqos = &blkiolat->rqos;
-	rqos->id = RQ_QOS_LATENCY;
-	rqos->ops = &blkcg_iolatency_ops;
-	rqos->q = q;
-
-	rq_qos_add(q, rqos);
-
+	rq_qos_activate(q, rqos, &blkcg_iolatency_ops);
 	ret = blkcg_activate_policy(q, &blkcg_policy_iolatency);
 	if (ret) {
-		rq_qos_del(q, rqos);
+		rq_qos_deactivate(rqos);
 		kfree(blkiolat);
 		return ret;
 	}
@@ -745,6 +737,14 @@ int blk_iolatency_init(struct request_queue *q)
 	return 0;
 }
 
+static struct rq_qos_ops blkcg_iolatency_ops = {
+	.name = "iolat",
+	.throttle = blkcg_iolatency_throttle,
+	.done_bio = blkcg_iolatency_done_bio,
+	.exit = blkcg_iolatency_exit,
+	.init = blk_iolatency_init,
+};
+
 /*
  * return 1 for enabling iolatency, return -1 for disabling iolatency, otherwise
  * return 0.
@@ -962,7 +962,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
-	struct rq_qos *rqos = blkcg_rq_qos(blkg->q);
+	struct rq_qos *rqos = rq_qos_get(blkg->q, blkcg_iolatency_ops.id);
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 	u64 now = ktime_to_ns(ktime_get());
 	int cpu;
@@ -1016,6 +1016,7 @@ static void iolatency_pd_offline(struct blkg_policy_data *pd)
 	if (ret == -1)
 		atomic_dec(&blkiolat->enabled);
 	iolatency_clear_scaling(blkg);
+	rq_qos_put(&blkiolat->rqos);
 }
 
 static void iolatency_pd_free(struct blkg_policy_data *pd)
@@ -1046,12 +1047,23 @@ static struct blkcg_policy blkcg_policy_iolatency = {
 
 static int __init iolatency_init(void)
 {
-	return blkcg_policy_register(&blkcg_policy_iolatency);
+	int ret;
+
+	ret = rq_qos_register(&blkcg_iolatency_ops);
+	if (ret)
+		return ret;
+
+	ret = blkcg_policy_register(&blkcg_policy_iolatency);
+	if (ret)
+		rq_qos_unregister(&blkcg_iolatency_ops);
+
+	return ret;
 }
 
 static void __exit iolatency_exit(void)
 {
 	blkcg_policy_unregister(&blkcg_policy_iolatency);
+	rq_qos_unregister(&blkcg_iolatency_ops);
 }
 
 module_init(iolatency_init);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 073ca7fca9b3..102bc5814cda 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -826,8 +826,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_LATENCY:
-		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
 	case RQ_QOS_IOPRIO:
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 8ce3f48b16b9..ecd1d1692a7d 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
 };
@@ -75,11 +74,6 @@ static inline struct rq_qos *rq_qos_id(struct request_queue *q,
 	return rqos;
 }
 
-static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
-{
-	return rq_qos_id(q, RQ_QOS_LATENCY);
-}
-
 static inline void rq_wait_init(struct rq_wait *rq_wait)
 {
 	atomic_set(&rq_wait->inflight, 0);
diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d..1a314257b6a3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -400,12 +400,6 @@ static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
 		__blk_queue_bounce(q, bio);	
 }
 
-#ifdef CONFIG_BLK_CGROUP_IOLATENCY
-extern int blk_iolatency_init(struct request_queue *q);
-#else
-static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
-#endif
-
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.17.1

