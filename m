Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311104B6C24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiBOMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:38:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiBOMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:38:50 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E16369CF8;
        Tue, 15 Feb 2022 04:38:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l19so28849994pfu.2;
        Tue, 15 Feb 2022 04:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJ10HBq4BWKicmzEPWCjLkyunI27H5I0+qD8B78L35c=;
        b=kFmq2hcte9NpNAqRDZdOnKMov2bAhK4Rbev21eVFB6/aMd1Ml2LSLf2qwFIzvVTIBl
         IDwMUTVcTn5+npkVW+uJgv6w4IvVzUvu2c+MlE1MUGW+RFqQq1ASQG2rHZwcdyLUWfVy
         TDqfL8X4FTYxBJuQMxN/J1BJS+qgavgNf/73WRtkPGUZzoVk2Bjaxgdnjqhmvqy85tgM
         CtmZkPEwJac7pgiskBLkcawOj/8cMYac1KvUsgiapacn3nMaDwdroXrE2/q2lW9A6eXe
         PRD6ClXdyXVii1ph4Cj2LgaPVollTnIooWAswo23sIKMU2CzvcTiIpi0chYJ4m2KIZfC
         EsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJ10HBq4BWKicmzEPWCjLkyunI27H5I0+qD8B78L35c=;
        b=l57EsPFOnyXOgc3YGBy60OS3gIkGXbZCdHwB+dVDbYvIcSzJ4s+7Ifbm4QqM991KXl
         xVRkZ3ZR+dN0cGbiSXQil1/UeCaK2bajaGUAa9Krn6NzhoYzxWPHlZoKTOsOhdiHYXtt
         OGFhm6mDN10978juzg9+YjTxz2vNTbiDGndJA3Vdzwa1EzTCHwdC4FY3MIoRw0JxtpBh
         YAm/oCWp9apSWvp5QuVECHpHGcW8c5U/oxMDOc4f2N8feiInNpJXeDpx3r1j8G3MjJtr
         mSVZWYVEjihwggiQhO72SODPB/h7EVmH/8dzTQQeW8H7B3hOiRls2DVBRw/47TSaArCU
         A4/g==
X-Gm-Message-State: AOAM5337ONSt/7LEFV+m8AcG1+Qrt14WdxSa/19gP/ZGGgAAuhJ7pHfV
        4vTj05yZRK7ffbQZzpIHNc8=
X-Google-Smtp-Source: ABdhPJxsEJ4R47z4RWJGFjDY4FpFboh4OSFMHpZYliCkO95lvDdaHCDUARtDgNCWAAsWGv594q9ydw==
X-Received: by 2002:a62:2982:: with SMTP id p124mr4108188pfp.53.1644928719723;
        Tue, 15 Feb 2022 04:38:39 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q8sm44017803pfl.143.2022.02.15.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:38:39 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 1/6] blk: make blk-rq-qos support pluggable and modular policy
Date:   Tue, 15 Feb 2022 20:37:00 +0800
Message-Id: <20220215123705.58968-2-jianchao.wan9@gmail.com>
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

Because the rq-qos list can be modified at anytime, rq_qos_id()
which has been renamed to rq_qos_by_id() has to iterate the list
under sysfs_lock or queue_lock. This patch adapts the code for this.
More details, please refer to the comment above rq_qos_get(), And
the rq_qos_exit() is moved to blk_cleanup_queue. Except for these
modification, there is no other functional change here. Following
patches will adpat the code of wbt, iolatency, iocost and ioprio
to make them pluggable and modular one by one.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-core.c       |   2 +
 block/blk-iocost.c     |  22 ++-
 block/blk-mq-debugfs.c |   4 +-
 block/blk-rq-qos.c     | 312 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-rq-qos.h     |  55 +++++++-
 block/blk-sysfs.c      |   2 +
 block/blk-wbt.c        |   6 +-
 block/elevator.c       |   3 +
 block/genhd.c          |   2 -
 include/linux/blkdev.h |   4 +
 10 files changed, 395 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d93e3bb9a769..00352bcba32d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -50,6 +50,7 @@
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-throttle.h"
+#include "blk-rq-qos.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -337,6 +338,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * it is safe to free requests now.
 	 */
 	mutex_lock(&q->sysfs_lock);
+	rq_qos_exit(q);
 	if (q->elevator)
 		blk_mq_sched_free_rqs(q);
 	mutex_unlock(&q->sysfs_lock);
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 769b64394298..54d6c93090ba 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -662,7 +662,7 @@ static struct ioc *rqos_to_ioc(struct rq_qos *rqos)
 
 static struct ioc *q_to_ioc(struct request_queue *q)
 {
-	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
+	return rqos_to_ioc(rq_qos_by_id(q, RQ_QOS_COST));
 }
 
 static const char *q_name(struct request_queue *q)
@@ -3162,6 +3162,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
@@ -3172,14 +3173,15 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev_get_queue(bdev));
-	if (!ioc) {
+	rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+	if (!rqos) {
 		ret = blk_iocost_init(bdev_get_queue(bdev));
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(bdev_get_queue(bdev));
+		rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
 	}
 
+	ioc = rqos_to_ioc(rqos);
 	spin_lock_irq(&ioc->lock);
 	memcpy(qos, ioc->params.qos, sizeof(qos));
 	enable = ioc->enabled;
@@ -3272,10 +3274,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	rq_qos_put(rqos);
 	blkdev_put_no_open(bdev);
 	return nbytes;
 einval:
 	ret = -EINVAL;
+	rq_qos_put(rqos);
 err:
 	blkdev_put_no_open(bdev);
 	return ret;
@@ -3329,6 +3333,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct rq_qos *rqos;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
@@ -3339,14 +3344,15 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev_get_queue(bdev));
-	if (!ioc) {
+	rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
+	if (!rqos) {
 		ret = blk_iocost_init(bdev_get_queue(bdev));
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(bdev_get_queue(bdev));
+		rqos = rq_qos_get(bdev_get_queue(bdev), RQ_QOS_COST);
 	}
 
+	ioc = rqos_to_ioc(rqos);
 	spin_lock_irq(&ioc->lock);
 	memcpy(u, ioc->params.i_lcoefs, sizeof(u));
 	user = ioc->user_cost_model;
@@ -3397,11 +3403,13 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
+	rq_qos_put(rqos);
 	blkdev_put_no_open(bdev);
 	return nbytes;
 
 einval:
 	ret = -EINVAL;
+	rq_qos_put(rqos);
 err:
 	blkdev_put_no_open(bdev);
 	return ret;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a790eb4995c..30f064872581 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -844,7 +844,9 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
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
index e83af7bc7591..a94ff872722b 100644
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
@@ -294,11 +299,316 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
-	blk_mq_debugfs_unregister_queue_rqos(q);
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock));
 
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
+		if (rqos->ops->owner)
+			module_put(rqos->ops->owner);
 		rqos->ops->exit(rqos);
 	}
+	blk_mq_debugfs_unregister_queue_rqos(q);
+}
+
+/*
+ * After the pluggable blk-qos, rqos's life cycle become complicated,
+ * qos switching path can add/delete rqos to/from request_queue
+ * under sysfs_lock and queue_lock. There are following places
+ * may access rqos through rq_qos_by_id() concurrently:
+ * (1) normal IO path, under q_usage_counter,
+ * (2) queue sysfs interfaces, under sysfs_lock,
+ * (3) blkg_create, the .pd_init_fn() may access rqos, under queue_lock,
+ * (4) cgroup file, such as ioc_cost_model_write,
+ *
+ * (1)(2)(3) are definitely safe. case (4) is tricky. rq_qos_get() is
+ * for the case.
+ */
+struct rq_qos *rq_qos_get(struct request_queue *q, int id)
+{
+	struct rq_qos *rqos;
+
+	spin_lock_irq(&q->queue_lock);
+	rqos = rq_qos_by_id(q, id);
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
+	bool rq_alloc_time = false;
+
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock));
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
+		while (pos->next) {
+			if (pos->ops->flags & RQOS_FLAG_RQ_ALLOC_TIME)
+				rq_alloc_time = true;
+			pos = pos->next;
+		}
+		pos->next = rqos;
+	} else {
+		q->rq_qos = rqos;
+	}
+	if (ops->flags & RQOS_FLAG_RQ_ALLOC_TIME &&
+	    !rq_alloc_time)
+		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, q);
+
+	spin_unlock_irq(&q->queue_lock);
+
+	if (rqos->ops->debugfs_attrs)
+		blk_mq_debugfs_register_rqos(rqos);
+}
+EXPORT_SYMBOL_GPL(rq_qos_activate);
+
+void rq_qos_deactivate(struct rq_qos *rqos)
+{
+	struct request_queue *q = rqos->q;
+	struct rq_qos **cur, *pos;
+	bool rq_alloc_time = false;
+
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock));
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
+
+	pos = q->rq_qos;
+	while (pos && pos->next) {
+		if (pos->ops->flags & RQOS_FLAG_RQ_ALLOC_TIME)
+			rq_alloc_time = true;
+		pos = pos->next;
+	}
+
+	if (rqos->ops->flags & RQOS_FLAG_RQ_ALLOC_TIME &&
+	    !rq_alloc_time)
+		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, q);
+
+	spin_unlock_irq(&q->queue_lock);
+	blk_mq_debugfs_unregister_rqos(rqos);
+}
+EXPORT_SYMBOL_GPL(rq_qos_deactivate);
+
+static struct rq_qos_ops *rq_qos_find_by_name(const char *name)
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
+	if (rq_qos_find_by_name(ops->name)) {
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
+	 * Show the policies in the order of being invoked
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
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock));
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
+	mutex_lock(&rq_qos_mutex);
+	if (add) {
+		ops = rq_qos_find_by_name(qosname);
+		if (!ops) {
+			/*
+			 * module_init callback may request this mutex
+			 */
+			mutex_unlock(&rq_qos_mutex);
+			request_module("%s", qosname);
+			mutex_lock(&rq_qos_mutex);
+			ops = rq_qos_find_by_name(qosname);
+		}
+	} else {
+		ops = rqos->ops;
+	}
+
+	if (!ops) {
+		ret = -EINVAL;
+	} else if (ops->owner && !try_module_get(ops->owner)) {
+		ops = NULL;
+		ret = -EAGAIN;
+	}
+	mutex_unlock(&rq_qos_mutex);
+
+	if (!ops)
+		goto out;
+
+	if (add) {
+		ret = rq_qos_switch(q, ops, NULL);
+		if (!ret && ops->owner)
+			__module_get(ops->owner);
+	} else {
+		rq_qos_switch(q, ops, rqos);
+		ret = 0;
+		if (ops->owner)
+			module_put(ops->owner);
+	}
+
+	if (ops->owner)
+		module_put(ops->owner);
+out:
+	kfree(buf);
+	return ret ? ret : count;
 }
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 3cfbc8668cba..c2b9b41f8fd4 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -26,7 +26,10 @@ struct rq_wait {
 };
 
 struct rq_qos {
-	struct rq_qos_ops *ops;
+	refcount_t ref;
+	wait_queue_head_t waitq;
+	bool dying;
+	const struct rq_qos_ops *ops;
 	struct request_queue *q;
 	enum rq_qos_id id;
 	struct rq_qos *next;
@@ -35,7 +38,17 @@ struct rq_qos {
 #endif
 };
 
+enum {
+	RQOS_FLAG_CGRP_POL = 1 << 0,
+	RQOS_FLAG_RQ_ALLOC_TIME = 1 << 1
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
@@ -46,6 +59,7 @@ struct rq_qos_ops {
 	void (*cleanup)(struct rq_qos *, struct bio *);
 	void (*queue_depth_changed)(struct rq_qos *);
 	void (*exit)(struct rq_qos *);
+	int (*init)(struct request_queue *);
 	const struct blk_mq_debugfs_attr *debugfs_attrs;
 };
 
@@ -59,10 +73,12 @@ struct rq_depth {
 	unsigned int default_depth;
 };
 
-static inline struct rq_qos *rq_qos_id(struct request_queue *q,
-				       enum rq_qos_id id)
+static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
 {
 	struct rq_qos *rqos;
+
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock) && !spin_is_locked(&q->queue_lock));
+
 	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
 		if (rqos->id == id)
 			break;
@@ -72,12 +88,12 @@ static inline struct rq_qos *rq_qos_id(struct request_queue *q,
 
 static inline struct rq_qos *wbt_rq_qos(struct request_queue *q)
 {
-	return rq_qos_id(q, RQ_QOS_WBT);
+	return rq_qos_by_id(q, RQ_QOS_WBT);
 }
 
 static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
 {
-	return rq_qos_id(q, RQ_QOS_LATENCY);
+	return rq_qos_by_id(q, RQ_QOS_LATENCY);
 }
 
 static inline void rq_wait_init(struct rq_wait *rq_wait)
@@ -132,6 +148,35 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
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
+static inline struct rq_qos *rq_qos_by_name(struct request_queue *q,
+		const char *name)
+{
+	struct rq_qos *rqos;
+
+	WARN_ON(!mutex_is_locked(&q->sysfs_lock));
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
 typedef bool (acquire_inflight_cb_t)(struct rq_wait *rqw, void *private_data);
 typedef void (cleanup_cb_t)(struct rq_wait *rqw, void *private_data);
 
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
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0c119be0e813..88265ae4fa41 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -628,9 +628,13 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 
 void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
 {
-	struct rq_qos *rqos = wbt_rq_qos(q);
+	struct rq_qos *rqos;
+
+	spin_lock_irq(&q->queue_lock);
+	rqos = wbt_rq_qos(q);
 	if (rqos)
 		RQWB(rqos)->wc = write_cache_on;
+	spin_unlock_irq(&q->queue_lock);
 }
 
 /*
diff --git a/block/elevator.c b/block/elevator.c
index ec98aed39c4f..dd8b3fbc34fe 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -705,12 +705,15 @@ void elevator_init_mq(struct request_queue *q)
 	 * requests, then no need to quiesce queue which may add long boot
 	 * latency, especially when lots of disks are involved.
 	 */
+
+	mutex_lock(&q->sysfs_lock);
 	blk_mq_freeze_queue(q);
 	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
 	blk_mq_unfreeze_queue(q);
+	mutex_unlock(&q->sysfs_lock);
 
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..fe7d4b169a1d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -621,8 +621,6 @@ void del_gendisk(struct gendisk *disk)
 	device_del(disk_to_dev(disk));
 
 	blk_mq_freeze_queue_wait(q);
-
-	rq_qos_exit(q);
 	blk_sync_queue(q);
 	blk_flush_integrity();
 	/*
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

