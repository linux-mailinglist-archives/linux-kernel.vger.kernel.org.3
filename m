Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA04C279A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiBXJJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiBXJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:08:57 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA419E09B;
        Thu, 24 Feb 2022 01:08:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so1500663pja.1;
        Thu, 24 Feb 2022 01:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EG+9Tmn7QgIN9x1YJfpebtDxHiDxr2IlFvxydQ8lHH8=;
        b=AQEud2jm1cGodIEDiEA9sfmipttXDcP1WN7+BvOuPLN4wkikS8J2lf4BhNrd54UQ40
         IZWHIiN9n1Yaw+cFhK83scaTgkRxcxjgx9WJpmZa2wmxVmmQ8KockRMMkuZ0aP0qTG0t
         9pY6y4rrPKZ6C6wL+YYEC5DlBITmK/SS34x1bPvsEkGTQNyxEmYcZX0y1vNhLejfuefN
         G1NSiureac63d/tz4wgP8IAhREu1pMiOXy7cRuZ4kzRvbZ1NQhK4pKR7+fphVPL1JxJ6
         wFoUUZjYzqK5jORaMmQX+PhX/2r3bSwFA0whW7CnVvysb9irINCLStR6P2+1eT6gvPQm
         KB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EG+9Tmn7QgIN9x1YJfpebtDxHiDxr2IlFvxydQ8lHH8=;
        b=sDJO3Oq4Xvzx8++BmOwOmn6D0yya/vUF1TZ8fBh8yIGLaqFYifighl163SbYNPYytz
         MSnQOHhhRO0nXuBW62GWXcWOooCJSkqXAWpiJBP+Eb9yOouCUBVv2FPrDRWhlGVwFzxd
         +xrFXMKap03HSCcENjKBI6FBGQzKhUG9eW0StyHGLftpasIg51Xqcut+E1PWeaNU8VcN
         Cgv6AVMHREhjMkxtCqgW9XMQKCrpKKErxoBdKHu7Juec52yvaacE0YJ0hyPW+QJs+TmU
         6NWQ07Hm8nCcy2jksukdXlX1Mv7oh0+A4LMIH8jtm32LhZmNUPlwyJV6yWDMD3Fv56jk
         pNwQ==
X-Gm-Message-State: AOAM532/vQwCgXiIij60D7xXhQe8XiZCNPVC3OPyHp6kf5t9nh4reZhe
        L6mqPUpkGispPxJ7zyqpb5o=
X-Google-Smtp-Source: ABdhPJxhxEjoNI3MULwqlEW2x19JpXwakblQ7INZa//RIx16PLZg+HyjEVlDhE9+i8bv6MqnMmeYww==
X-Received: by 2002:a17:90a:ac14:b0:1bc:2b81:4f5d with SMTP id o20-20020a17090aac1400b001bc2b814f5dmr13471421pjq.207.1645693707644;
        Thu, 24 Feb 2022 01:08:27 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:27 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 02/16] blk/rq-qos: prepare to make blk-rq-qos pluggable
Date:   Thu, 24 Feb 2022 17:06:40 +0800
Message-Id: <20220224090654.54671-3-jianchao.wan9@gmail.com>
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

This patch makes blk-rq-qos policies pluggable as following,
(1) Add code to maintain the rq_qos_ops. A rq-qos policy need to
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
ioprio to make them pluggable one by one. And after that, the sysfs
interface /sys/block/xxx/queue/qos will be exported.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-core.c       |   1 +
 block/blk-mq-debugfs.c |  12 +-
 block/blk-rq-qos.c     | 246 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-rq-qos.h     |  25 ++++-
 include/linux/blkdev.h |   1 +
 5 files changed, 280 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d93e3bb9a769..448d153e515b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -485,6 +485,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 	mutex_init(&q->sysfs_lock);
 	mutex_init(&q->sysfs_dir_lock);
 	spin_lock_init(&q->queue_lock);
+	spin_lock_init(&q->rqos_lock);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a790eb4995c..24d47bc90b4a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -729,7 +729,10 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 	if (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
-
+		/*
+		 * Queue has not been registered right now, it is safe to
+		 * iterate the rqos w/o lock
+		 */
 		while (rqos) {
 			blk_mq_debugfs_register_rqos(rqos);
 			rqos = rqos->next;
@@ -844,7 +847,12 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
 	struct request_queue *q = rqos->q;
-	const char *dir_name = rq_qos_id_to_name(rqos->id);
+	const char *dir_name;
+
+	if (rqos->ops->name)
+		dir_name = rqos->ops->name;
+	else
+		dir_name = rq_qos_id_to_name(rqos->id);
 
 	if (rqos->debugfs_dir || !rqos->ops->debugfs_attrs)
 		return;
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index e83af7bc7591..c43436c2ead1 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -2,6 +2,9 @@
 
 #include "blk-rq-qos.h"
 
+static DEFINE_IDR(rq_qos_idr);
+static DEFINE_MUTEX(rq_qos_mutex);
+
 /*
  * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
  * false if 'v' + 1 would be bigger than 'below'.
@@ -294,11 +297,250 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
-	blk_mq_debugfs_unregister_queue_rqos(q);
-
+	/*
+	 * Queue must have been unregistered here, it is safe to
+	 * iterate the list w/o lock
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
+ * This helper interface is to keep rqos alive against
+ * rqos switching. rq_qos_deactivate() drains all of
+ * rq_qos_get() before it frees the rqos structure.
+ */
+struct rq_qos *rq_qos_get(struct request_queue *q, int id)
+{
+	struct rq_qos *rqos;
+
+	spin_lock_irq(&q->rqos_lock);
+	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (rqos->id == id) {
+			break;
+		}
+	}
+	if (rqos && rqos->dying)
+		rqos = NULL;
+	if (rqos)
+		refcount_inc(&rqos->ref);
+	spin_unlock_irq(&q->rqos_lock);
+	return rqos;
+}
+
+void rq_qos_put(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+
+	spin_lock_irq(&q->rqos_lock);
+	refcount_dec(&rqos->ref);
+	if (rqos->dying)
+		wake_up(&rqos->waitq);
+	spin_unlock_irq(&q->rqos_lock);
+}
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
+	spin_lock_irq(&q->rqos_lock);
+	pos = q->rq_qos;
+	if (pos) {
+		while (pos->next)
+			pos = pos->next;
+		pos->next = rqos;
+	} else {
+		q->rq_qos = rqos;
+	}
+	spin_unlock_irq(&q->rqos_lock);
+
+	if (rqos->ops->debugfs_attrs)
+		blk_mq_debugfs_register_rqos(rqos);
+}
+
+void rq_qos_deactivate(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+	struct rq_qos **cur;
+
+	spin_lock_irq(&q->rqos_lock);
+	rqos->dying = true;
+	/*
+	 * Drain all of the usage of get/put_rqos()
+	 */
+	wait_event_lock_irq(rqos->waitq,
+		refcount_read(&rqos->ref) == 1, q->rqos_lock);
+	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
+		if (*cur == rqos) {
+			*cur = rqos->next;
+			break;
+		}
+	}
+	spin_unlock_irq(&q->rqos_lock);
+	blk_mq_debugfs_unregister_rqos(rqos);
+}
+
+static struct rq_qos_ops *rq_qos_op_find(const char *name)
+{
+	struct rq_qos_ops *pos;
+	int id;
+
+	idr_for_each_entry(&rq_qos_idr, pos, id) {
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
+	start = RQ_QOS_IOPRIO + 1;
+	ret = idr_alloc(&rq_qos_idr, ops, start, INT_MAX, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	ops->id = ret;
+	ret = 0;
+out:
+	mutex_unlock(&rq_qos_mutex);
+	return ret;
+}
+
+void rq_qos_unregister(struct rq_qos_ops *ops)
+{
+	mutex_lock(&rq_qos_mutex);
+	idr_remove(&rq_qos_idr, ops->id);
+	mutex_unlock(&rq_qos_mutex);
+}
+
+ssize_t queue_qos_show(struct request_queue *q, char *buf)
+{
+	struct rq_qos_ops *ops;
+	struct rq_qos *rqos;
+	int id, ret = 0;
+
+	mutex_lock(&rq_qos_mutex);
+	/*
+	 * Show the policies in the order of being invoked.
+	 * rqos_lock is not needed here as the sysfs_lock is
+	 * protected us from the queue_qos_store()
+	 */
+	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
+		if (!rqos->ops->name)
+			continue;
+		ret += sprintf(buf + ret, "[%s] ", rqos->ops->name);
+	}
+	idr_for_each_entry(&rq_qos_idr, ops, id) {
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
+		mutex_unlock(&rq_qos_mutex);
+		if (!ops) {
+			ret = -EINVAL;
+			goto out;
+		}
+	} else {
+		ops = rqos->ops;
+	}
+
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+	if (add) {
+		ret = ops->init(q);
+	} else {
+		ops->exit(rqos);
+		ret = 0;
+	}
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+out:
+	kfree(buf);
+	return ret ? ret : count;
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 3cfbc8668cba..aa6ef12637a0 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -26,9 +26,12 @@ struct rq_wait {
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
@@ -36,6 +39,8 @@ struct rq_qos {
 };
 
 struct rq_qos_ops {
+	const char *name;
+	int id;
 	void (*throttle)(struct rq_qos *, struct bio *);
 	void (*track)(struct rq_qos *, struct request *, struct bio *);
 	void (*merge)(struct rq_qos *, struct request *, struct bio *);
@@ -46,6 +51,7 @@ struct rq_qos_ops {
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*queue_depth_changed)(struct rq_qos *);
 	void (*exit)(struct rq_qos *);
+	int (*init)(struct request_queue *);
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
 };
 
@@ -132,6 +138,17 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
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
 
@@ -211,8 +228,14 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 
 static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 {
+	/*
+	 * It is called by external module, protect the rqos list with
+	 * sysfs_lock against qos switching
+	 */
+	mutex_lock(&q->sysfs_lock);
 	if (q->rq_qos)
 		__rq_qos_queue_depth_changed(q->rq_qos);
+	mutex_unlock(&q->sysfs_lock);
 }
 
 void rq_qos_exit(struct request_queue *);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f35aea98bc35..126aac824ccc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -230,6 +230,7 @@ struct request_queue {
 	int			id;
 
 	spinlock_t		queue_lock;
+	spinlock_t		rqos_lock;
 
 	struct gendisk		*disk;
 
-- 
2.17.1

