Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E440E4894F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiAJJO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbiAJJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:39 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F448C061751;
        Mon, 10 Jan 2022 01:12:39 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x27so1437935pfu.3;
        Mon, 10 Jan 2022 01:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pUKMXuo3xVxEWKXjp7ogKF7zeSoPw2PTqo2WG9e7EOA=;
        b=Di3cCvIIY239IGt/c0tGqMqgvAASPuPHbHmpXojKoUTCVBMW1LRI5K5Roe/rkjJJF5
         J9zueerHJSCCjyTJL7jLXgEl3GnSNljmqfAhm5b86Un2Lhyu1CZI+IoZI+cLDaREx7ri
         7DOjA8EMIZ9c4wsmiRsBmKHm1YQC05orPwzfSvK4qdSEeaHiZqm0Yb7LfuRfcqAXiQoQ
         YoNBwOAsaXc8AfJLJ/mhZlZJeGB/6uev3KQXCfIt95hf8/gYJGcNrIWmWKncgMK6cTrD
         9d/3iH2t7PymWGE2CFZkWszqlDUNpTYE9FX/H1+UVFS+ZMOLoKzrJzdjGjxEpJ/L0WSF
         mHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pUKMXuo3xVxEWKXjp7ogKF7zeSoPw2PTqo2WG9e7EOA=;
        b=sYKBh/sQBKE65L7dT9XjRuXBUOE5JVe9FKCkaDDZgRXG8n6eovY9iVPzH5ggXyLD8d
         ZWEpXW2ZmkT1umkg1cUFlZ3E9hN9RLeJFrnOY7IJUR0xnHEpZUbW0RUVIWXYykTqDikw
         w6P3CR2nZHNtkvDeyNlUwmelQ34LiXwxtCP3x1+wP2QymBa4rEzFvXFePMgEvL5nqQw6
         6c23goeFyqhoeMuQ+uEfNOPFUDqQ84zQ031+2C2h+A70cpDcnSgtildcxQDYZzff4MRA
         c+9UJxrI4CKohFOkjC4P2uJdi04ISYTQDOTQeSaLoMnphEqdyVtKQblFGxUqeyauO1s5
         s6fw==
X-Gm-Message-State: AOAM5327DVwdJJSAKID+/bOH/Q9WGE1XI3hUekDKRJHd3Ctx6saRv3/R
        FcEoq8Wdb9+C0OawNbGtNCQ=
X-Google-Smtp-Source: ABdhPJzcUoj3Y6lu927itTNWfKF9jZHJw6//ZclzBXChG2+gGlTakfZDxB2artybUeJ0b5BbTvueRw==
X-Received: by 2002:a05:6a00:1351:b0:4bc:edbf:7acd with SMTP id k17-20020a056a00135100b004bcedbf7acdmr18006227pfu.41.1641805958867;
        Mon, 10 Jan 2022 01:12:38 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:38 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] blk: introduce iostat per cgroup module
Date:   Mon, 10 Jan 2022 17:10:46 +0800
Message-Id: <20220110091046.17010-14-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

iostat can only track the whole device's io statistics. This patch
introduces iostat per cgroup based on blk-rq-qos framework which
can track bw, iops, queue latency and device latency and distinguish
regular or meta data. The blkio.iostat per cgroup output in following
format,
vda-data bytes iops queue_lat dev_lat [ditto]  [ditto]
    meta   \___________ ______________/    |        |
	               v                   v        v
	             read               write   discard
In particular, the blkio.iostat of root only output the statistics
of IOs from root cgroup. However, the non-root blkio.iostat outputs
all of the children cgroups. With meta stats in root cgroup, hope
to observe the performace of fs metadata.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Kconfig          |   9 ++
 block/Makefile         |   2 +
 block/blk-iostat.c     | 356 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |   2 +-
 4 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-iostat.c

diff --git a/block/Kconfig b/block/Kconfig
index ea612cb5c8ee..35f24db3ec92 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -156,6 +156,15 @@ config BLK_CGROUP_IOPRIO
 	scheduler and block devices process requests. Only some I/O schedulers
 	and some block devices support I/O priorities.
 
+config BLK_CGROUP_IOSTAT
+	tristate "IO statistics monitor per cgroup"
+	select BLK_RQ_BLKCG_GQ
+	select BLK_RQ_ALLOC_TIME
+	depends on BLK_CGROUP
+	help
+	Monitor IO statistics, including bw, iops, queue latency and device
+	latency, in per-cgroup level.
+
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
diff --git a/block/Makefile b/block/Makefile
index 3f76836076b2..ad89015e37ce 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -23,6 +23,8 @@ iolat-y 				:= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= iolat.o
 iocost-y 			:= blk-iocost.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= iocost.o
+iostat-y 			:= blk-iostat.o
+obj-$(CONFIG_BLK_CGROUP_IOSTAT)	+= iostat.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
diff --git a/block/blk-iostat.c b/block/blk-iostat.c
new file mode 100644
index 000000000000..3c6bcb6ab055
--- /dev/null
+++ b/block/blk-iostat.c
@@ -0,0 +1,356 @@
+#include <linux/kernel.h>
+#include <linux/blk_types.h>
+#include <linux/module.h>
+#include <linux/blk-cgroup.h>
+#include <linux/bio.h>
+#include <linux/spinlock.h>
+
+#include "blk.h"
+#include "blk-rq-qos.h"
+
+enum {
+	IOSTAT_READ = 0,
+	IOSTAT_WRITE,
+	IOSTAT_DISCARD,
+	IOSTAT_MAX,
+};
+
+struct iostat_data {
+	u64 bytes[IOSTAT_MAX];
+	u64 ios[IOSTAT_MAX];
+	u64 queue_lat[IOSTAT_MAX];
+	u64 dev_lat[IOSTAT_MAX];
+};
+
+struct iostat_queue {
+	struct rq_qos rqos;
+};
+
+struct iostat_gq {
+	struct blkg_policy_data pd;
+	char disk_name[DISK_NAME_LEN];
+	struct {
+		struct iostat_data __percpu *data;
+		struct iostat_data __percpu *meta;
+	} stat;
+};
+
+struct iostat_cgrp {
+	struct blkcg_policy_data cpd;
+};
+
+DEFINE_MUTEX(iostat_mutex);
+
+static struct blkcg_policy blkcg_policy_iostat;
+
+static inline struct iostat_gq *pd_to_ist(struct blkg_policy_data *pd)
+{
+	return pd ? container_of(pd, struct iostat_gq, pd) : NULL;
+}
+
+static inline struct iostat_gq *blkg_to_ist(struct blkcg_gq *blkg)
+{
+	return pd_to_ist(blkg_to_pd(blkg, &blkcg_policy_iostat));
+}
+
+static inline bool req_is_meta(struct request *req)
+{
+	return req->cmd_flags & REQ_META;
+}
+
+static inline int iostat_op(struct request *req)
+{
+	int op;
+
+	if (unlikely(op_is_discard(req_op(req))))
+		op = IOSTAT_DISCARD;
+	else if (op_is_write(req_op(req)))
+		op = IOSTAT_WRITE;
+	else
+		op = IOSTAT_READ;
+
+	return op;
+}
+
+static void __iostat_issue(struct rq_qos *rqos,
+		struct iostat_gq *is, struct request *req)
+{
+	struct iostat_data *stat;
+	int op = iostat_op(req);
+
+	/*
+	 * blk_mq_start_request() inherents bio_issue_time() when BLK_CGROUP
+	 * to avoid overhead of readtsc.
+	 */
+	req->io_start_time_ns = ktime_get_ns();
+	if (req_is_meta(req))
+		stat = get_cpu_ptr(is->stat.meta);
+	else
+		stat = get_cpu_ptr(is->stat.data);
+	/*
+	 * alloc_time_ns is get before get tag, we use it monitor depth,
+	 * tag waits and in queue time.
+	 */
+	stat->queue_lat[op] += req->io_start_time_ns - req->alloc_time_ns;
+	stat->ios[op]++;
+	stat->bytes[op] += blk_rq_bytes(req);
+	put_cpu_ptr(stat);
+}
+
+static void iostat_issue(struct rq_qos *rqos, struct request *req)
+{
+	struct iostat_gq *is;
+
+	if (unlikely(!req->bio))
+		return;
+
+	is = blkg_to_ist(req->blkg);
+	/*
+	 * Most of time, bios from submit_bio would have the valid bi_blkg,
+	 * however, blk_execute_rq case is an exception.
+	 */
+	if (is)
+		__iostat_issue(rqos, is, req);
+}
+
+static void __iostat_done(struct rq_qos *rq_qos,
+		struct iostat_gq *is, struct request *req)
+{
+	struct iostat_data *stat;
+	int op = iostat_op(req);
+
+	if (req_is_meta(req))
+		stat = get_cpu_ptr(is->stat.meta);
+	else
+		stat = get_cpu_ptr(is->stat.data);
+	if (req->io_start_time_ns)
+		stat->dev_lat[op] += ktime_get_ns() - req->io_start_time_ns;
+	put_cpu_ptr(stat);
+}
+
+static void iostat_done(struct rq_qos *rqos, struct request *req)
+{
+	struct iostat_gq *is = blkg_to_ist(req->blkg);
+
+	if (is)
+		__iostat_done(rqos, is, req);
+}
+
+static void iostat_exit(struct rq_qos *rqos)
+{
+	struct iostat_queue *isq = container_of(rqos, struct iostat_queue, rqos);
+
+	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iostat);
+	rq_qos_deactivate(rqos);
+	kfree(isq);
+}
+
+static int iostat_init(struct request_queue *q);
+
+struct rq_qos_ops iostat_rq_ops = {
+#if IS_MODULE(CONFIG_BLK_CGROUP_IOLATENCY)
+	.owner = THIS_MODULE,
+#endif
+	.name = "iostat",
+	.flags = RQOS_FLAG_CGRP_POL | RQOS_FLAG_RQ_ALLOC_TIME,
+	.issue = iostat_issue,
+	.done = iostat_done,
+	.exit = iostat_exit,
+	.init = iostat_init,
+};
+
+static int iostat_init(struct request_queue *q)
+{
+	struct iostat_queue *isq;
+	struct rq_qos *rqos;
+	int ret;
+
+	isq = kzalloc_node(sizeof(*isq), GFP_KERNEL, q->node);
+	if (!isq) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, q);
+	rqos = &isq->rqos;
+	rq_qos_activate(q, rqos, &iostat_rq_ops);
+
+	ret = blkcg_activate_policy(q, &blkcg_policy_iostat);
+	if (ret) {
+		rq_qos_deactivate(rqos);
+		kfree(isq);
+	}
+out:
+	return ret;
+}
+
+static void iostat_sum(struct blkcg_gq *blkg,
+		struct iostat_data *sum, bool meta)
+{
+	struct iostat_gq *is = blkg_to_ist(blkg);
+	struct iostat_data *stat;
+	int cpu, i;
+
+	for_each_possible_cpu(cpu) {
+		if (meta)
+			stat = per_cpu_ptr(is->stat.meta, cpu);
+		else
+			stat = per_cpu_ptr(is->stat.data, cpu);
+		for (i = 0; i < IOSTAT_MAX; i++) {
+			sum->bytes[i] += stat->bytes[i];
+			sum->ios[i] += stat->ios[i];
+			sum->dev_lat[i] += stat->dev_lat[i];
+			sum->queue_lat[i] += stat->queue_lat[i];
+		}
+	}
+}
+
+static int iostat_show(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct cgroup_subsys_state *pos_css;
+	struct iostat_gq *is;
+	struct blkcg_gq *blkg, *pos_blkg;
+	struct iostat_data data_sum, meta_sum;
+	int i;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+		is = blkg_to_ist(blkg);
+		/*
+		 * The is activated on demand so iostat may be NULL
+		 */
+		if (!is)
+			continue;
+
+		memset(&data_sum, 0, sizeof(data_sum));
+		memset(&meta_sum, 0, sizeof(meta_sum));
+		if (blkg == blkg->q->root_blkg) {
+			iostat_sum(blkg, &data_sum, false);
+			iostat_sum(blkg, &meta_sum, true);
+		} else {
+			/*
+			 * Iterate every children blkg to agregate statistics
+			 */
+			blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
+				if (!pos_blkg->online)
+					continue;
+				iostat_sum(pos_blkg, &data_sum, false);
+				iostat_sum(pos_blkg, &meta_sum, true);
+			}
+		}
+
+		seq_printf(sf, "%s-data ", is->disk_name);
+		for (i = 0; i < IOSTAT_MAX; i++)
+			seq_printf(sf, "%llu %llu %llu %llu ",
+				data_sum.bytes[i], data_sum.ios[i],
+				data_sum.queue_lat[i], data_sum.dev_lat[i]);
+		seq_printf(sf, "\n");
+		seq_printf(sf, "%s-meta ", is->disk_name);
+		for (i = 0; i < IOSTAT_MAX; i++)
+			seq_printf(sf, "%llu %llu %llu %llu ",
+				meta_sum.bytes[i], meta_sum.ios[i],
+				meta_sum.queue_lat[i], meta_sum.dev_lat[i]);
+		seq_printf(sf, "\n");
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static struct cftype iostat_files[] = {
+	{
+		.name = "iostat",
+		.seq_show = iostat_show,
+	},
+	{}
+};
+
+static struct cftype iostat_legacy_files[] = {
+	{
+		.name = "iostat",
+		.seq_show = iostat_show,
+	},
+	{}
+};
+
+static void iostat_pd_free(struct blkg_policy_data *pd)
+{
+	struct iostat_gq *is = pd_to_ist(pd);
+
+	if (is->stat.data)
+		free_percpu(is->stat.data);
+
+	if (is->stat.meta)
+		free_percpu(is->stat.meta);
+
+	kfree(is);
+}
+
+static struct blkg_policy_data *iostat_pd_alloc(gfp_t gfp,
+		struct request_queue *q, struct blkcg *blkcg)
+{
+	struct iostat_gq *is;
+
+	is = kzalloc_node(sizeof(*is), gfp, q->node);
+	if (!is)
+		return NULL;
+
+	is->stat.data = __alloc_percpu_gfp(sizeof(struct iostat_data),
+			__alignof__(struct iostat_data), gfp);
+	if (!is->stat.data)
+		goto out_free;
+
+	is->stat.meta = __alloc_percpu_gfp(sizeof(struct iostat_data),
+			__alignof__(struct iostat_data), gfp);
+	if (!is->stat.meta)
+		goto out_free;
+	/*
+	 * request_queue.kobj's parent is gendisk
+	 */
+	strlcpy(is->disk_name,
+		kobject_name(q->kobj.parent),
+		DISK_NAME_LEN);
+	return &is->pd;
+out_free:
+	if (is->stat.data)
+		free_percpu(is->stat.data);
+	iostat_pd_free(&is->pd);
+	return NULL;
+}
+
+static struct blkcg_policy blkcg_policy_iostat = {
+	.dfl_cftypes	= iostat_files,
+	.legacy_cftypes	= iostat_legacy_files,
+	.pd_alloc_fn	= iostat_pd_alloc,
+	.pd_free_fn	= iostat_pd_free,
+};
+
+static int __init iostat_mod_init(void)
+{
+	int ret;
+
+	ret = rq_qos_register(&iostat_rq_ops);
+	if (ret)
+		return ret;
+
+	ret = blkcg_policy_register(&blkcg_policy_iostat);
+	if (ret) {
+		rq_qos_unregister(&iostat_rq_ops);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit iostat_mod_exit(void)
+{
+	rq_qos_unregister(&iostat_rq_ops);
+	blkcg_policy_unregister(&blkcg_policy_iostat);
+}
+
+module_init(iostat_mod_init);
+module_exit(iostat_mod_exit);
+MODULE_AUTHOR("Wang Jianchao");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Block Statistics per Cgroup");
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed30b3c3fee7..75026cf54384 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -42,7 +42,7 @@ struct blk_crypto_profile;
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
  */
-#define BLKCG_MAX_POLS		6
+#define BLKCG_MAX_POLS		7
 /*
  * Non blk-rq-qos blkcg policies include blk-throttle and bfq
  */
-- 
2.17.1

