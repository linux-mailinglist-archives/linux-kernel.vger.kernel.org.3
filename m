Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817BD4B870E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiBPLty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:49:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiBPLtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:49:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5A1CEB29;
        Wed, 16 Feb 2022 03:49:39 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q132so1924338pgq.7;
        Wed, 16 Feb 2022 03:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zEaED2klU/tmakY6hfsKkyNGyq5NXoTXpDD8xgT9OMY=;
        b=Swt/iOtKeq9QBud/wmXj5HEStx3FHPc8S8qJuV3jrMvfixPLeUopAm7zhtfBKY0tE3
         s6UXelRDPPbp2pY7oX6ldXuotpoeEQ4DZbLGxYLHgDwCeHtZeWwBDW4AxcTYbsp9WLAZ
         w2tHVcdyFwMgFsxixfBAwcWVK/zNC9stxiZGrfXIQOmkVfQQjlE9wbGePZn3/f74ad6Z
         RYyzuucyPToveFpTCHVNIpzZ06duDai7Y9kkwZg4Ms4hbPQPlPh/tUOoRMTgMVyX9xlN
         AXy6ffD8VPeQRDa94XiMJ1ykHmp36DYPOL7wgVZPPw8PcLQ1ZN+1zyGknkMddH88rF6b
         PGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zEaED2klU/tmakY6hfsKkyNGyq5NXoTXpDD8xgT9OMY=;
        b=RXfNrMNujgnMQ6WLkbqwh2f/oujI8y+jc1edU7JvZn/DQVM6lzJ7Ir+MkLe28LzqJ2
         VI3PvJDfL62IzGBJiXZD9rfa1c3Uyk+dubbmojmZjG7jf2pOCHCbI99PymqQreEV1nKN
         B+x0SaaM5ULHnU7KjF9MvhjZebDylWzdqUQ+JygSxeW483McfkQnI0qU0gw77M5GkNL6
         3duRjwF26DLhFUA19cdIZ33/K6UPcbcyfCp+maiRDIFWS8wGwcFMSQccCKjjBHz/LVce
         5FGX19OjRM3NvwxBki1fJPCuF/GKKqrOUJjhxM8TdrXuyoU79RAWuTFlKTyciXFCRYpe
         k5TA==
X-Gm-Message-State: AOAM532apqEphSNL0fj0T17QQ1JavYGJ/rpAIz6aiyQi48nJjNUD/Q0d
        yzORsqteUheicPqL6tBvgpQ=
X-Google-Smtp-Source: ABdhPJy0JcycBTlOT78v0ofYoHJlp6PMfAMEPWhsWXKmgH3HyVh4SblGqNr1/+jWXCAGR2i0d+k2wA==
X-Received: by 2002:a63:3f42:0:b0:363:c08a:8dfd with SMTP id m63-20020a633f42000000b00363c08a8dfdmr2025652pga.108.1645012178506;
        Wed, 16 Feb 2022 03:49:38 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id q1sm26209119pfs.112.2022.02.16.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:49:38 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V3 1/6] blk: prepare to make blk-rq-qos pluggable and modular
Date:   Wed, 16 Feb 2022 19:48:04 +0800
Message-Id: <20220216114809.84551-2-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216114809.84551-1-jianchao.wan9@gmail.com>
References: <20220216114809.84551-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk-rq-qos is a standalone framework out of io-sched and can be
used to control or observe the IO progress in block-layer with
hooks. blk-rq-qos is a great design but right now, it is totally
fixed and built-in and shut out peoples who want to use it with
external module.

This patch make blk-rq-qos policies pluggable and modular.
(1) Add code to maintain the rq_qos_ops. A rq-qos module need to
    register itself with rq_qos_register(). The original enum
    rq_qos_id will be removed in following patch. They will use
    a dynamic id maintained by rq_qos_ida.
(2) Add .init callback into rq_qos_ops. We use it to initialize the
    resource.
(3) Add /sys/block/x/queue/qos
    We can use '+name' or "-name" to open or close the blk-rq-qos
    policy.

This patch mainly prepare help interfaces and no functional changes.
Following patches will adpat the code of wbt, iolatency, iocost and
ioprio to make them pluggable and modular one by one. And after that,
the /sys/block/xxx/queue/qos interfaces will be exported.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c |   9 +-
 block/blk-rq-qos.c     | 303 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-rq-qos.h     |  39 +++++-
 include/linux/blkdev.h |   4 +
 4 files changed, 350 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a790eb4995c..4da803bf5617 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -729,7 +729,10 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 	if (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
-
+		/*
+		 * queue has not been registered right now, it is safe to 
+		 * iterate the rqos w/o lock
+		 */
 		while (rqos) {
 			blk_mq_debugfs_register_rqos(rqos);
 			rqos = rqos->next;
@@ -844,7 +847,9 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
-	const char *dir_name = rq_qos_id_to_name(rqos->id);
+	const char *dir_name;
+
+	dir_name = rqos->ops->name ? rqos->ops->name : rq_qos_id_to_name(rqos->id);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index e83af7bc7591..f269bb9745ad 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -2,6 +2,11 @@
 
 #include "blk-rq-qos.h"
 
+static DEFINE_IDA(rq_qos_ida);
+static int nr_rqos_blkcg_pols;
+static DEFINE_MUTEX(rq_qos_mutex);
+static LIST_HEAD(rq_qos_list);
+
 /*
  * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
  * false if 'v' + 1 would be bigger than 'below'.
@@ -294,11 +299,305 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
-	blk_mq_debugfs_unregister_queue_rqos(q);
-
+	/*
+	 * queue must have been unregistered here, it is safe to iterate
+	 * the list w/o lock
+	 */
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
 		rqos->ops->exit(rqos);
 	}
+	blk_mq_debugfs_unregister_queue_rqos(q);
+}
+
+static struct rq_qos *rq_qos_by_name(struct request_queue *q,
+		const char *name)
+{
+	struct rq_qos *rqos;
+
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock) && !spin_is_locked(&q->queue_lock));
+
+	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (!rqos->ops->name)
+			continue;
+
+		if (!strncmp(rqos->ops->name, name,
+					strlen(rqos->ops->name)))
+			return rqos;
+	}
+	return NULL;
+}
+
+/*
+ * After the pluggable blk-qos, rqos's life cycle become complicated,
+ * as we may modify the rqos list there. Except for the places where
+ * queue is not registered, there are following places may access rqos
+ * list concurrently:
+ * (1) normal IO path, can be serialized by queue freezing
+ * (2) blkg_create, the .pd_init_fn() may access rqos, can be serialized
+ *     by queue_lock.
+ * (3) cgroup file, such as ioc_cost_model_write, rq_qos_get is for this
+ *     case to keep the rqos alive.
+ */
+struct rq_qos *rq_qos_get(struct request_queue *q, int id)
+{
+	struct rq_qos *rqos;
+
+	spin_lock_irq(&q->queue_lock);
+	rqos = rq_qos_id(q, id);
+	if (rqos && rqos->dying)
+		rqos = NULL;
+	if (rqos)
+		refcount_inc(&rqos->ref);
+	spin_unlock_irq(&q->queue_lock);
+	return rqos;
+}
+EXPORT_SYMBOL_GPL(rq_qos_get);
+
+void rq_qos_put(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+
+	spin_lock_irq(&q->queue_lock);
+	refcount_dec(&rqos->ref);
+	if (rqos->dying)
+		wake_up(&rqos->waitq);
+	spin_unlock_irq(&q->queue_lock);
+}
+EXPORT_SYMBOL_GPL(rq_qos_put);
+
+void rq_qos_activate(struct request_queue *q,
+		struct rq_qos *rqos, const struct rq_qos_ops *ops)
+{
+	struct rq_qos *pos;
+
+	rqos->dying = false;
+	refcount_set(&rqos->ref, 1);
+	init_waitqueue_head(&rqos->waitq);
+	rqos->id = ops->id;
+	rqos->ops = ops;
+	rqos->q = q;
+	rqos->next = NULL;
+
+	spin_lock_irq(&q->queue_lock);
+	pos = q->rq_qos;
+	if (pos) {
+		while (pos->next)
+			pos = pos->next;
+		pos->next = rqos;
+	} else {
+		q->rq_qos = rqos;
+	}
+	spin_unlock_irq(&q->queue_lock);
+
+	if (rqos->ops->debugfs_attrs)
+		blk_mq_debugfs_register_rqos(rqos);
+
+	if (ops->owner)
+		__module_get(ops->owner);
+}
+EXPORT_SYMBOL_GPL(rq_qos_activate);
+
+void rq_qos_deactivate(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+	struct rq_qos **cur;
+
+	spin_lock_irq(&q->queue_lock);
+	rqos->dying = true;
+	/*
+	 * Drain all of the usage of get/put_rqos()
+	 */
+	wait_event_lock_irq(rqos->waitq,
+		refcount_read(&rqos->ref) == 1, q->queue_lock);
+	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
+		if (*cur == rqos) {
+			*cur = rqos->next;
+			break;
+		}
+	}
+	spin_unlock_irq(&q->queue_lock);
+	blk_mq_debugfs_unregister_rqos(rqos);
+
+	if (rqos->ops->owner)
+			module_put(rqos->ops->owner);
+}
+EXPORT_SYMBOL_GPL(rq_qos_deactivate);
+
+static struct rq_qos_ops *rq_qos_op_find(const char *name)
+{
+	struct rq_qos_ops *pos;
+
+	list_for_each_entry(pos, &rq_qos_list, node) {
+		if (!strncmp(pos->name, name, strlen(pos->name)))
+			return pos;
+	}
+
+	return NULL;
+}
+
+int rq_qos_register(struct rq_qos_ops *ops)
+{
+	int ret, start;
+
+	mutex_lock(&rq_qos_mutex);
+
+	if (rq_qos_op_find(ops->name)) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	if (ops->flags & RQOS_FLAG_CGRP_POL &&
+	    nr_rqos_blkcg_pols >= (BLKCG_MAX_POLS - BLKCG_NON_RQOS_POLS)) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	start = RQ_QOS_IOPRIO + 1;
+	ret = ida_simple_get(&rq_qos_ida, start, INT_MAX, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	if (ops->flags & RQOS_FLAG_CGRP_POL)
+		nr_rqos_blkcg_pols++;
+
+	ops->id = ret;
+	ret = 0;
+	INIT_LIST_HEAD(&ops->node);
+	list_add_tail(&ops->node, &rq_qos_list);
+out:
+	mutex_unlock(&rq_qos_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rq_qos_register);
+
+void rq_qos_unregister(struct rq_qos_ops *ops)
+{
+	mutex_lock(&rq_qos_mutex);
+
+	if (ops->flags & RQOS_FLAG_CGRP_POL)
+		nr_rqos_blkcg_pols--;
+	list_del_init(&ops->node);
+	ida_simple_remove(&rq_qos_ida, ops->id);
+	mutex_unlock(&rq_qos_mutex);
+}
+EXPORT_SYMBOL_GPL(rq_qos_unregister);
+
+ssize_t queue_qos_show(struct request_queue *q, char *buf)
+{
+	struct rq_qos_ops *ops;
+	struct rq_qos *rqos;
+	int ret = 0;
+
+	mutex_lock(&rq_qos_mutex);
+	/*
+	 * Show the policies in the order of being invoked.
+	 * queue_lock is not needed here as the sysfs_lock is
+	 * protected us from the queue_qos_store()
+	 */
+	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (!rqos->ops->name)
+			continue;
+		ret += sprintf(buf + ret, "[%s] ", rqos->ops->name);
+	}
+	list_for_each_entry(ops, &rq_qos_list, node) {
+		if (!rq_qos_by_name(q, ops->name))
+			ret += sprintf(buf + ret, "%s ", ops->name);
+	}
+
+	ret--; /* overwrite the last space */
+	ret += sprintf(buf + ret, "\n");
+	mutex_unlock(&rq_qos_mutex);
+
+	return ret;
+}
+
+int rq_qos_switch(struct request_queue *q,
+		const struct rq_qos_ops *ops,
+		struct rq_qos *rqos)
+{
+	int ret;
+
+	blk_mq_freeze_queue(q);
+	if (!rqos) {
+		ret = ops->init(q);
+	} else {
+		ops->exit(rqos);
+		ret = 0;
+	}
+	blk_mq_unfreeze_queue(q);
+
+	return ret;
+}
+
+ssize_t queue_qos_store(struct request_queue *q, const char *page,
+			  size_t count)
+{
+	const struct rq_qos_ops *ops;
+	struct rq_qos *rqos;
+	const char *qosname;
+	char *buf;
+	bool add;
+	int ret;
+
+	if (!blk_queue_registered(q))
+		return -ENOENT;
+
+	buf = kstrdup(page, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf = strim(buf);
+	if (buf[0] != '+' && buf[0] != '-') {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	add = buf[0] == '+';
+	qosname = buf + 1;
+
+	rqos = rq_qos_by_name(q, qosname);
+	if ((buf[0] == '+' && rqos)) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	if ((buf[0] == '-' && !rqos)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (add) {
+		mutex_lock(&rq_qos_mutex);
+		ops = rq_qos_op_find(qosname);
+		if (!ops) {
+			/*
+			 * module_init callback may request this mutex
+			 */
+			mutex_unlock(&rq_qos_mutex);
+			request_module("%s", qosname);
+			mutex_lock(&rq_qos_mutex);
+			ops = rq_qos_op_find(qosname);
+		}
+		if (!ops) {
+			ret = -EINVAL;
+		} else if (ops->owner && !try_module_get(ops->owner)) {
+			ops = NULL;
+			ret = -EAGAIN;
+		}
+		mutex_unlock(&rq_qos_mutex);
+		if (!ops)
+			goto out;
+	} else {
+		ops = rqos->ops;
+	}
+
+	ret = rq_qos_switch(q, ops, add ? NULL : rqos);
+
+	if (add)
+		module_put(ops->owner);
+out:
+	kfree(buf);
+	return ret ? ret : count;
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 3cfbc8668cba..586c3f5ec152 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -26,16 +26,28 @@ struct rq_wait {
 };
 
 struct rq_qos {
-	struct rq_qos_ops *ops;
+	const struct rq_qos_ops *ops;
 	struct request_queue *q;
 	enum rq_qos_id id;
+	refcount_t ref;
+	wait_queue_head_t waitq;
+	bool dying;
 	struct rq_qos *next;
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry *debugfs_dir;
 #endif
 };
 
+enum {
+	RQOS_FLAG_CGRP_POL = 1 << 0,
+};
+
 struct rq_qos_ops {
+	struct list_head node;
+	struct module *owner;
+	const char *name;
+	int flags;
+	int id;
 	void (*throttle)(struct rq_qos *, struct bio *);
 	void (*track)(struct rq_qos *, struct request *, struct bio *);
 	void (*merge)(struct rq_qos *, struct request *, struct bio *);
@@ -46,6 +58,7 @@ struct rq_qos_ops {
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*queue_depth_changed)(struct rq_qos *);
 	void (*exit)(struct rq_qos *);
+	int (*init)(struct request_queue *);
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
 };
 
@@ -70,6 +83,19 @@ static inline struct rq_qos *rq_qos_id(struct request_queue *q,
 	return rqos;
 }
 
+static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
+{
+	struct rq_qos *rqos;
+
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock) && !spin_is_locked(&q->queue_lock));
+
+	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (rqos->id == id)
+			break;
+	}
+	return rqos;
+}
+
 static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
 {
 	return rq_qos_id(q, RQ_QOS_WBT);
@@ -132,6 +158,17 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 	blk_mq_debugfs_unregister_rqos(rqos);
 }
 
+int rq_qos_register(struct rq_qos_ops *ops);
+void rq_qos_unregister(struct rq_qos_ops *ops);
+void rq_qos_activate(struct request_queue *q,
+		struct rq_qos *rqos, const struct rq_qos_ops *ops);
+void rq_qos_deactivate(struct rq_qos *rqos);
+ssize_t queue_qos_show(struct request_queue *q, char *buf);
+ssize_t queue_qos_store(struct request_queue *q, const char *page,
+			  size_t count);
+struct rq_qos *rq_qos_get(struct request_queue *q, int id);
+void rq_qos_put(struct rq_qos *rqos);
+
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
 typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f35aea98bc35..d5698a7cda67 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -44,6 +44,10 @@ struct blk_crypto_profile;
  * Defined here to simplify include dependency.
  */
 #define BLKCG_MAX_POLS		6
+/*
+ * Non blk-rq-qos blkcg policies include blk-throttle and bfq
+ */
+#define BLKCG_NON_RQOS_POLS		2
 
 static inline int blk_validate_block_size(unsigned long bsize)
 {
-- 
2.17.1

