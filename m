Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3843A4B967B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBQDQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:16:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiBQDPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:15:45 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C66D2727B1;
        Wed, 16 Feb 2022 19:15:31 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l73so3806305pge.11;
        Wed, 16 Feb 2022 19:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nC+1B3PeLDhJAaHINUXdTNpBlJO6pz1AmTjWajsQpzQ=;
        b=HG9bk6ncJCZHDKIJ0KNwMKOB8Up68PnbEzjz6VcqlokqzCPQ3AgBGCFuaWB5gKblWA
         qCDLakFLP2aWHLxIaLDwL9PV8v+PIDFtWBw8P+KtxVyQDCqhF7i4MwYduZURLsvQLbOd
         pO7Ssw72dJaKItcs8OddSb5U7JuBN9iEmxHJSxj7AQlLeeiocxUPgTW9cP9Ma0zvi0aF
         Gp6MgwJ5f/csPTvlh7qlVYDCJQnuS4wX5O/v1K8jB0/01MMbQGfl7XVIFC2iYCtq9BV7
         eFSARbYZeVC0NOxamSGPZiw7FtgGUdbvYlFxq5edT4h+1Gs649+kuiERXDhwna7GKwXG
         fPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nC+1B3PeLDhJAaHINUXdTNpBlJO6pz1AmTjWajsQpzQ=;
        b=6wfPbHDzc0NfO6L2vYrjUbxoMMMcRVLUr9o8qCwY6+1EdiQM3j41k5PLL5RNu3I7x7
         mtqTfbK692zWmb/Y6fVteIEKXNEKeBPbdZhr2n6JkuioyC9zI8ta7CSi/ugUV3db/sJh
         dm9NYIlNfw6NlIn0nEqwvdnuiyg/khPO8UOOizo5CEjCl6EWo/KCP+44l8ZGa/qq/Qws
         07XrqvDa4PrmJs/byaZUv8YblXMEi6FjGOucHj9IbhVpRlZYGydtlIrsrEA5tmf2XhOx
         5/2fCU31BG8MG4QmzHO0RNTOn+TGNOgp4emqw/ZBEskaKukpXXGg4L5LYzbZZZxg5t64
         B8hw==
X-Gm-Message-State: AOAM533/LnUIN5iAeMd6MFTdf8/GO3e6qt5KB/IYHdvd18jt5J5ytZ4N
        9eIH0MHpiWP3A3RBCStK3FA=
X-Google-Smtp-Source: ABdhPJyZK6XRMixCNv7nozmyzTljSlGuuyWxQUtQ0wRCHHQyuoWFbU+DiCjixgjbUpf40wO6PWzDDg==
X-Received: by 2002:a05:6a00:150a:b0:4cc:f6a6:1bc6 with SMTP id q10-20020a056a00150a00b004ccf6a61bc6mr1177769pfu.74.1645067730943;
        Wed, 16 Feb 2022 19:15:30 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id cu21sm421018pjb.50.2022.02.16.19.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:15:30 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V4 6/6] blk: export the sysfs for switching qos
Date:   Thu, 17 Feb 2022 11:13:49 +0800
Message-Id: <20220217031349.98561-7-jianchao.wan9@gmail.com>
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

All of the blk-rq-qos policies has been changed to use the new
interfaces. Thus we can export the sysfs interface, namely
/sys/block/xxx/queue/qos and get rid of the unused interfaces.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c | 10 +------
 block/blk-rq-qos.h     | 63 +-----------------------------------------
 block/blk-sysfs.c      |  2 ++
 3 files changed, 4 insertions(+), 71 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cbbd668029a1..3defd5cb1cea 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -823,11 +823,6 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
 	q->sched_debugfs_dir = NULL;
 }
 
-static const char *rq_qos_id_to_name(enum rq_qos_id id)
-{
-	return "unknown";
-}
-
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 	debugfs_remove_recursive(rqos->debugfs_dir);
@@ -837,9 +832,6 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
-	const char *dir_name;
-
-	dir_name = rqos->ops->name ? rqos->ops->name : rq_qos_id_to_name(rqos->id);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
@@ -848,7 +840,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 		q->rqos_debugfs_dir = debugfs_create_dir("rqos",
 							 q->debugfs_dir);
 
-	rqos->debugfs_dir = debugfs_create_dir(dir_name,
+	rqos->debugfs_dir = debugfs_create_dir(rqos->ops->name,
 					       rqos->q->rqos_debugfs_dir);
 
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index bba829bbb461..262d221794f5 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -13,10 +13,6 @@
 
 struct blk_mq_debugfs_attr;
 
-enum rq_qos_id {
-	RQ_QOS_UNUSED,
-};
-
 struct rq_wait {
 	wait_queue_head_t wait;
 	atomic_t inflight;
@@ -25,7 +21,7 @@ struct rq_wait {
 struct rq_qos {
 	const struct rq_qos_ops *ops;
 	struct request_queue *q;
-	enum rq_qos_id id;
+	int id;
 	refcount_t ref;
 	wait_queue_head_t waitq;
 	bool dying;
@@ -69,17 +65,6 @@ struct rq_depth {
 	unsigned int default_depth;
 };
 
-static inline struct rq_qos *rq_qos_id(struct request_queue *q,
-				       enum rq_qos_id id)
-{
-	struct rq_qos *rqos;
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->id == id)
-			break;
-	}
-	return rqos;
-}
-
 static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
 {
 	struct rq_qos *rqos;
@@ -99,52 +84,6 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 	init_waitqueue_head(&rq_wait->wait);
 }
 
-static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
-{
-	/*
-	 * No IO can be in-flight when adding rqos, so freeze queue, which
-	 * is fine since we only support rq_qos for blk-mq queue.
-	 *
-	 * Reuse ->queue_lock for protecting against other concurrent
-	 * rq_qos adding/deleting
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	rqos->next = q->rq_qos;
-	q->rq_qos = rqos;
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	if (rqos->ops->debugfs_attrs)
-		blk_mq_debugfs_register_rqos(rqos);
-}
-
-static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
-{
-	struct rq_qos **cur;
-
-	/*
-	 * See comment in rq_qos_add() about freezing queue & using
-	 * ->queue_lock.
-	 */
-	blk_mq_freeze_queue(q);
-
-	spin_lock_irq(&q->queue_lock);
-	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
-		if (*cur == rqos) {
-			*cur = rqos->next;
-			break;
-		}
-	}
-	spin_unlock_irq(&q->queue_lock);
-
-	blk_mq_unfreeze_queue(q);
-
-	blk_mq_debugfs_unregister_rqos(rqos);
-}
-
 int rq_qos_register(struct rq_qos_ops *ops);
 void rq_qos_unregister(struct rq_qos_ops *ops);
 void rq_qos_activate(struct request_queue *q,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f32882ceb2f..c02747db4e3b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -574,6 +574,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_ENTRY(queue_qos, "qos");
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -633,6 +634,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&elv_iosched_entry.attr,
+	&queue_qos_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
-- 
2.17.1

