Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002A94B9677
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiBQDPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:15:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiBQDPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:15:41 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C929413D;
        Wed, 16 Feb 2022 19:15:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c4so3825922pfl.7;
        Wed, 16 Feb 2022 19:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Fv0yxs7Due0iTDo5Cr/QA0fQkobiZAYipeprXXiS0s=;
        b=hrLvcSCOD+vQi7IgYUszEV8dWjnsRtLiF/qFDdSa+U4cnACQBh/ctsf+MSChxJsQR0
         7KjyNijwSngm3fAYawhSrdriCFsf9nsUI0DUWHGDTiRFhMqcHYTlfiMQbY7Y4HaFqM8J
         zKI/amqOGN/g1irI35BYYg7wVstrpQsAFJxW6p+0CQFfV6V/auiAXU7RFkpAt3Za2+s7
         x3Ljaw7gWZjv67XYEuwp0HmpoVntQr/VOBSkB6SRpN8O6EgSNhewBjtRDToUNifpOv5I
         +0lTuL1vOPeuN+IviVNI9FBYTyrabjZnnXAt25S3RpMnNvbh4sP5IqaWmXhMQQ7+qVkB
         oQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Fv0yxs7Due0iTDo5Cr/QA0fQkobiZAYipeprXXiS0s=;
        b=u23MnY+ltdOUd+A3McsBb7Z5DJd5yCEt8s1mA+Cwl0rONaAkIAAUw7lwsDrPgRDtix
         BkitOMWbtaJF0Zz/rlNibWM+cYlRPPlh7sXXERvuv+L7ASf5bGkwWenckZ5pUd7MF7gP
         Exku7E46btCj2uD9rp9ZH2iQMb7rtVCnNjsvxit9+C48hXK3cXobQhYiJrVcSnIQwE5v
         plqWtle0r56+TXoNQC1hNwlVPEyZos+dZYMR1hMW7CBT4m6SI4k7RfejG/DNi88C5d5v
         /PEJ2FZCyQcqOXfFNvQUogPAOiqYDce9pF0t5Q1WyAK0Li/RmR+4Ohnf5yo8PYsyPlOg
         cIrw==
X-Gm-Message-State: AOAM532aCuDV4pmNy+8tGxM7CFzSg0HfYuNr19t9+oKzgiSoJROnFPYG
        BZTuUMJ7BVc7qxSvmQbU5LY=
X-Google-Smtp-Source: ABdhPJxH0k4m9rHU+Q6m54KhxFOGVUeDmq3yyjPqUY+rrDE6tnsx+FcY4TsO3XWFo9QzXAj66SDNHA==
X-Received: by 2002:a63:fe01:0:b0:372:b258:a8c9 with SMTP id p1-20020a63fe01000000b00372b258a8c9mr862999pgh.376.1645067723051;
        Wed, 16 Feb 2022 19:15:23 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id cu21sm421018pjb.50.2022.02.16.19.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:15:22 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V4 3/6] blk-iolatency: make iolatency pluggable
Date:   Thu, 17 Feb 2022 11:13:46 +0800
Message-Id: <20220217031349.98561-4-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217031349.98561-1-jianchao.wan9@gmail.com>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
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
 block/blk-iolatency.c  | 34 ++++++++++++++++++++++++++--------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  6 ------
 block/blk.h            |  6 ------
 5 files changed, 26 insertions(+), 28 deletions(-)

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
index 6593c7123b97..a8a201d6d669 100644
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
@@ -646,13 +652,19 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 
 	del_timer_sync(&blkiolat->timer);
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
+	rq_qos_deactivate(rqos);
 	kfree(blkiolat);
 }
 
+static int blk_iolatency_init(struct request_queue *q);
+
 static struct rq_qos_ops blkcg_iolatency_ops = {
+	.name = "blk-iolat",
+	.flags = RQOS_FLAG_CGRP_POL,
 	.throttle = blkcg_iolatency_throttle,
 	.done_bio = blkcg_iolatency_done_bio,
 	.exit = blkcg_iolatency_exit,
+	.init = blk_iolatency_init,
 };
 
 static void blkiolatency_timer_fn(struct timer_list *t)
@@ -727,15 +739,10 @@ int blk_iolatency_init(struct request_queue *q)
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
@@ -1046,12 +1053,23 @@ static struct blkcg_policy blkcg_policy_iolatency = {
 
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
index a5d78b094234..918870b8de5b 100644
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
index 171a83d6de45..2a919db52fef 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_LATENCY,
 	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
 };
@@ -95,11 +94,6 @@ static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
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

