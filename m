Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5626A4B6C25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiBOMjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:39:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbiBOMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:38:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B108E69CF8;
        Tue, 15 Feb 2022 04:38:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso2648077pjt.4;
        Tue, 15 Feb 2022 04:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GOQRCwixPqUws0WrW/Jj54Sf3Uy4ptmcVfy0eOEhxBQ=;
        b=LGkxK7K2yutyCb7G2VIY4xv3ROjFuhFqOqYjuyG4mF7TunEv1AfUwPDXZsJ0WHWoZs
         R3zdBij0ZumdbaB7TWfDrcnV6x7gyx3zN1Nrq2x+yW2aL7u/4+GBs66kJCeaHr92JhHT
         dNXa3a6E3mIj8jtKnApMqcxHzEc9zeD9Q2qQapKKpcIpjruiEAXcpncWKOSMKq1Vjnee
         /JaakT1U5ss78cA/s2WD59D0K03Vk3g55drV5p7ZM5S/Nuxp9pbYOHw1zPibWOg1rbzF
         TzCfOJoInbe9drLmrOGsPGlfQPuLwGboI7gVXmIhMdzwQWNv00JvKvdqNAyFqsQq/+Cf
         JH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GOQRCwixPqUws0WrW/Jj54Sf3Uy4ptmcVfy0eOEhxBQ=;
        b=GBAFzfUBqqZ8/QAjDvge/IJY7FSbMYSqTCOgHPGsz614EPDBocp3/1NKfapDJ4c3/2
         FYiesuKZjlB8P9PdIpvkwjUa+3CIY7Lz5fDq1xWTiHoFEu1hdXVaC4p4C0b4QzqLmGdB
         mKOTpiR9g9vy7SINyBlmoLC6oenD91+SsvtDfBiC/lADvsSOQLau9xh16qoEnJdOsoab
         3j9moNAuGP03DCxxXs1zyvSxozBA/EY76ZN7J2Hqe5ZJ3plnF/I8Ox4wCHCW7EmNov46
         4G0H/nL2Cc75kJD3Izm4p/i30mq3uwbxBi4hHP1aw6VTXQV+kF3MFQqdyeSfBRvhRPLO
         V7fw==
X-Gm-Message-State: AOAM53351aG0ST6r/6kK1/bXcHntu/CDDJWs8XE16kpBMj6Mk9FNrSrd
        YAEcmc2OaVtkK+iyeVntrQw=
X-Google-Smtp-Source: ABdhPJzGLKB6Rxyhpqpdiv/2W4tXdqDq0UYukWuqAN90zYcwcYJJvWa6pHw7fW6DPbtFXxwP4I2xMg==
X-Received: by 2002:a17:90b:104:b0:1b8:d212:9b8e with SMTP id p4-20020a17090b010400b001b8d2129b8emr4188035pjz.11.1644928728263;
        Tue, 15 Feb 2022 04:38:48 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q8sm44017803pfl.143.2022.02.15.04.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:38:47 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 4/6] blk-iocost: make iocost pluggable
Date:   Tue, 15 Feb 2022 20:37:03 +0800
Message-Id: <20220215123705.58968-5-jianchao.wan9@gmail.com>
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

Make blk-iocost pluggable. Then we can close or open it through
/sys/block/xxx/queue/qos.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-iocost.c     | 47 ++++++++++++++++++++++++------------------
 block/blk-mq-debugfs.c |  2 --
 block/blk-rq-qos.h     |  1 -
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 54d6c93090ba..9d82f1002de9 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -660,9 +660,10 @@ static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 	return container_of(rqos, struct ioc, rqos);
 }
 
+static struct rq_qos_ops ioc_rqos_ops;
 static struct ioc *q_to_ioc(struct request_queue *q)
 {
-	return rqos_to_ioc(rq_qos_by_id(q, RQ_QOS_COST));
+	return rqos_to_ioc(rq_qos_by_id(q, ioc_rqos_ops.id));
 }
 
 static const char *q_name(struct request_queue *q)
@@ -2810,6 +2811,7 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	struct ioc *ioc = rqos_to_ioc(rqos);
 
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
+	rq_qos_deactivate(rqos);
 
 	spin_lock_irq(&ioc->lock);
 	ioc->running = IOC_STOP;
@@ -2820,13 +2822,17 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
 	kfree(ioc);
 }
 
+static int blk_iocost_init(struct request_queue *q);
 static struct rq_qos_ops ioc_rqos_ops = {
+	.name = "iocost",
+	.flags = RQOS_FLAG_CGRP_POL | RQOS_FLAG_RQ_ALLOC_TIME,
 	.throttle = ioc_rqos_throttle,
 	.merge = ioc_rqos_merge,
 	.done_bio = ioc_rqos_done_bio,
 	.done = ioc_rqos_done,
 	.queue_depth_changed = ioc_rqos_queue_depth_changed,
 	.exit = ioc_rqos_exit,
+	.init = blk_iocost_init,
 };
 
 static int blk_iocost_init(struct request_queue *q)
@@ -2856,10 +2862,7 @@ static int blk_iocost_init(struct request_queue *q)
 	}
 
 	rqos = &ioc->rqos;
-	rqos->id = RQ_QOS_COST;
-	rqos->ops = &ioc_rqos_ops;
-	rqos->q = q;
-
+	rq_qos_activate(q, rqos, &ioc_rqos_ops);
 	spin_lock_init(&ioc->lock);
 	timer_setup(&ioc->timer, ioc_timer_fn, 0);
 	INIT_LIST_HEAD(&ioc->active_iocgs);
@@ -2883,10 +2886,9 @@ static int blk_iocost_init(struct request_queue *q)
 	 * called before policy activation completion, can't assume that the
 	 * target bio has an iocg associated and need to test for NULL iocg.
 	 */
-	rq_qos_add(q, rqos);
 	ret = blkcg_activate_policy(q, &blkcg_policy_iocost);
 	if (ret) {
-		rq_qos_del(q, rqos);
+		rq_qos_deactivate(rqos);
 		free_percpu(ioc->pcpu_stat);
 		kfree(ioc);
 		return ret;
@@ -3173,12 +3175,10 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+	rqos = rq_qos_get(bdev_get_queue(bdev), ioc_rqos_ops.id);
 	if (!rqos) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
-		if (ret)
-			goto err;
-		rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+		ret = -EOPNOTSUPP;
+		goto err;
 	}
 
 	ioc = rqos_to_ioc(rqos);
@@ -3257,10 +3257,8 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	if (enable) {
 		blk_stat_enable_accounting(ioc->rqos.q);
-		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
 		ioc->enabled = true;
 	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
 		ioc->enabled = false;
 	}
 
@@ -3344,12 +3342,10 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+	rqos = rq_qos_get(bdev_get_queue(bdev), ioc_rqos_ops.id);
 	if (!rqos) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
-		if (ret)
-			goto err;
-		rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+		ret = -EOPNOTSUPP;
+		goto err;
 	}
 
 	ioc = rqos_to_ioc(rqos);
@@ -3449,12 +3445,23 @@ static struct blkcg_policy blkcg_policy_iocost = {
 
 static int __init ioc_init(void)
 {
-	return blkcg_policy_register(&blkcg_policy_iocost);
+	int ret;
+
+	ret = rq_qos_register(&ioc_rqos_ops);
+	if (ret)
+		return ret;
+
+	ret = blkcg_policy_register(&blkcg_policy_iocost);
+	if (ret)
+		rq_qos_unregister(&ioc_rqos_ops);
+
+	return ret;
 }
 
 static void __exit ioc_exit(void)
 {
 	blkcg_policy_unregister(&blkcg_policy_iocost);
+	rq_qos_unregister(&ioc_rqos_ops);
 }
 
 module_init(ioc_init);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8faa5c5e25be..9bb1dabc223b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -823,8 +823,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 static const char *rq_qos_id_to_name(enum rq_qos_id id)
 {
 	switch (id) {
-	case RQ_QOS_COST:
-		return "cost";
 	case RQ_QOS_IOPRIO:
 		return "ioprio";
 	}
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 6ca46c69e325..4eef53f2c290 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -14,7 +14,6 @@
 struct blk_mq_debugfs_attr;
 
 enum rq_qos_id {
-	RQ_QOS_COST,
 	RQ_QOS_IOPRIO,
 };
 
-- 
2.17.1

