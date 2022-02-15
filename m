Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDDE4B6C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbiBOMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:38:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiBOMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:38:55 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5669CF8;
        Tue, 15 Feb 2022 04:38:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y9so17313948pjf.1;
        Tue, 15 Feb 2022 04:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=syrsn6nEvf+7tdkz3FTOP8T+eqOKo0hcbspn1UNfC9I=;
        b=VY1ERCX3/FbFG1AykWtzFDBBRFk/kDJ4vqEXiAsw+d0KlyGIGJosoc81JbMDh+cv9h
         lSE1aaJIv1fJim14eWflxm40nFq8S5adAKvVFqkuYIez62OZTgKj1AiFWf8lWHzgnes0
         98H7nJMZUdDZu5mMAaGdPryu8mVUkMEJvyMPLYGHrhAJhilSNeWMH/bebiRnLQqph9tx
         EEW42R2Q8qwDLRrT1tI6Lua+UgkXHUA7fQEdqjQ5n9aDwteaRfi45TDUvlvcvmSkAcMB
         F4abpKj5sUf24dqU2sjNhff6ISgHsAJhEQYHyZi2p5U6hEOJr8bvgw0guxAUe5jhBcvM
         oueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=syrsn6nEvf+7tdkz3FTOP8T+eqOKo0hcbspn1UNfC9I=;
        b=YkaaM80C0TjUHtacnKUrweBw0HeKcXE8muXEwKEE66I9nw+WBL8ENL1MQlkykPxFgh
         2kT1cdL+vI21QkFK7YWlC3Gfo46sK2gsx9aoIydEgCK0IqRS/ssEjTQEm9qlJbmTptL/
         YcnMW0xd3tiaMHFvgRy3mn1OXGJdp4ME1zdlbwREB/uFN8kvID75NjrRzUG0xnxwQ5nc
         +zoqvT4Ye5a/DLGFOUg9ud/onS7CPETkEv5L6p1FPmrooOFzG5D2Vp2vj3j/XQFEjrgI
         sd6EP7hUED+ZINHL8M3E/LfMweEB3Ioyhw/mMakus3fnUJkEClj9ORgrjte+cXkb/cYH
         hLRA==
X-Gm-Message-State: AOAM531LXMMQqOPwtPI6BnyT0qfFY7cnNCWP4YhYdEdL5xhJZk1gDCke
        86NgA4V5gpKZEnGopTuT/AI=
X-Google-Smtp-Source: ABdhPJxSuRwdrUgVueIEgcXC3Q4HDw5Rqx0/Q0df/okSePPz4DE7k4vSdx6HBEgiosYagOX/U44nMQ==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr3856228pll.88.1644928725495;
        Tue, 15 Feb 2022 04:38:45 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q8sm44017803pfl.143.2022.02.15.04.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:38:45 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 3/6] blk-iolatency: make iolatency pluggable
Date:   Tue, 15 Feb 2022 20:37:02 +0800
Message-Id: <20220215123705.58968-4-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215123705.58968-1-jianchao.wan9@gmail.com>
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make blk-iolatency pluggable. Then we can close or open it through
/sys/block/xxx/queue/qos.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-cgroup.c     |  6 ------
 block/blk-iolatency.c  | 33 +++++++++++++++++++++++++--------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 ------
 block/blk.h            |  6 ------
 5 files changed, 25 insertions(+), 28 deletions(-)

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
index 6593c7123b97..b0596a7a35f0 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -90,6 +90,12 @@ struct blk_iolatency {
 	atomic_t enabled;
 };
 
+static struct rq_qos_ops blkcg_iolatency_ops;
+static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
+{
+	return rq_qos_by_id(q, blkcg_iolatency_ops.id);
+}
+
 static inline struct blk_iolatency *BLKIOLATENCY(struct rq_qos *rqos)
 {
 	return container_of(rqos, struct blk_iolatency, rqos);
@@ -646,13 +652,18 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	del_timer_sync(&blkiolat->timer);
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
+	rq_qos_deactivate(rqos);
 	kfree(blkiolat);
 }
 
+static int blk_iolatency_init(struct request_queue *q);
 static struct rq_qos_ops blkcg_iolatency_ops = {
+	.name = "iolat",
+	.flags = RQOS_FLAG_CGRP_POL,
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
+	.init = blk_iolatency_init,
 };
 
 static void blkiolatency_timer_fn(struct timer_list *t)
@@ -727,15 +738,10 @@ int blk_iolatency_init(struct request_queue *q)
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
@@ -1046,12 +1052,23 @@ static struct blkcg_policy blkcg_policy_iolatency = {
 
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
index c7b17576a65f..8faa5c5e25be 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -823,8 +823,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_LATENCY:
-		return "latency";
 	case RQ_QOS_COST:
 		return "cost";
 	case RQ_QOS_IOPRIO:
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index de82eb951bdd..6ca46c69e325 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
 };
@@ -85,11 +84,6 @@ static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
 	return rqos;
 }
 
-static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
-{
-	return rq_qos_by_id(q, RQ_QOS_LATENCY);
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

