Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442554EAA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiC2J2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiC2J1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:27:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED3698F51;
        Tue, 29 Mar 2022 02:26:01 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSPK21v2xzfYyV;
        Tue, 29 Mar 2022 17:24:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:25:59 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:25:59 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC 5/6] blk-mq: don't preempt tag expect for split bios
Date:   Tue, 29 Mar 2022 17:40:47 +0800
Message-ID: <20220329094048.2107094-6-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329094048.2107094-1-yukuai3@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve the sequential of split io, this patch disables
tag preemption for the first split bios and other non-split bios if
the device is under high io pressure.

Noted that this solution rely on waitqueues of sbitmap to be balanced,
otherwise it may happen that 'wake_batch' tags is freed and wakers don't
obtain 'wake_batch' new tags, thus concurrent io will become less. The
next patch will avoid such problem, however, fix the unfairness of
waitqueues might be better.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c         |  7 ++++++-
 block/blk-mq-tag.c        | 37 ++++++++++++++++++++++++++-----------
 block/blk-mq.c            |  6 ++++++
 block/blk-mq.h            |  1 +
 include/linux/blk_types.h |  2 ++
 lib/sbitmap.c             | 14 ++++++++++----
 6 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 340860746cac..fd4bbf773b45 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -357,6 +357,11 @@ static unsigned short blk_queue_split_all(struct request_queue *q,
 		if (!first)
 			first = split;
 
+		/*
+		 * Except the first split bio, others will always preempt
+		 * tag, so that they can be sequential.
+		 */
+		split->bi_opf |= REQ_PREEMPTIVE;
 		nr_split++;
 		submit_bio_noacct(split);
 	}
@@ -387,7 +392,7 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio)
 
 	if (split) {
 		split->bi_nr_split = blk_queue_split_all(q, *bio);
-		(*bio)->bi_opf |= REQ_SPLIT;
+		(*bio)->bi_opf |= (REQ_SPLIT | REQ_PREEMPTIVE);
 		submit_bio_noacct(*bio);
 		*bio = split;
 	}
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 83dfbe2f1cfc..4e485bcc5820 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -127,6 +127,13 @@ unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
 	return ret;
 }
 
+static inline bool preempt_tag(struct blk_mq_alloc_data *data,
+			       struct sbitmap_queue *bt)
+{
+	return data->preemption ||
+	       atomic_read(&bt->ws_active) <= SBQ_WAIT_QUEUES;
+}
+
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
@@ -148,12 +155,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		tag_offset = tags->nr_reserved_tags;
 	}
 
-	tag = __blk_mq_get_tag(data, bt);
-	if (tag != BLK_MQ_NO_TAG)
-		goto found_tag;
+	if (data->flags & BLK_MQ_REQ_NOWAIT || preempt_tag(data, bt)) {
+		tag = __blk_mq_get_tag(data, bt);
+		if (tag != BLK_MQ_NO_TAG)
+			goto found_tag;
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
-		return BLK_MQ_NO_TAG;
+		if (data->flags & BLK_MQ_REQ_NOWAIT)
+			return BLK_MQ_NO_TAG;
+	}
 
 	wait.nr_tags += data->nr_split;
 	ws = bt_wait_ptr(bt, data->hctx);
@@ -171,20 +180,26 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		 * Retry tag allocation after running the hardware queue,
 		 * as running the queue may also have found completions.
 		 */
-		tag = __blk_mq_get_tag(data, bt);
-		if (tag != BLK_MQ_NO_TAG)
-			break;
+		if (preempt_tag(data, bt)) {
+			tag = __blk_mq_get_tag(data, bt);
+			if (tag != BLK_MQ_NO_TAG)
+				break;
+		}
 
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
-		tag = __blk_mq_get_tag(data, bt);
-		if (tag != BLK_MQ_NO_TAG)
-			break;
+		if (preempt_tag(data, bt)) {
+			tag = __blk_mq_get_tag(data, bt);
+			if (tag != BLK_MQ_NO_TAG)
+				break;
+		}
 
 		bt_prev = bt;
 		io_schedule();
 
 		sbitmap_finish_wait(bt, ws, &wait);
+		if (!blk_mq_is_tag_preemptive(data->hctx->flags))
+			data->preemption = true;
 
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9bace9e2c5ca..06ba6fa9ec1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -470,6 +470,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 retry:
 	data->ctx = blk_mq_get_ctx(q);
 	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	if (blk_mq_is_tag_preemptive(data->hctx->flags))
+		data->preemption = true;
+
 	if (!(data->rq_flags & RQF_ELV))
 		blk_mq_tag_busy(data->hctx);
 
@@ -577,6 +580,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = xa_load(&q->hctx_table, hctx_idx);
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
+	if (blk_mq_is_tag_preemptive(data.hctx->flags))
+		data.preemption = true;
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
@@ -2738,6 +2743,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		.nr_tags	= 1,
 		.cmd_flags	= bio->bi_opf,
 		.nr_split	= bio->bi_nr_split,
+		.preemption	= (bio->bi_opf & REQ_PREEMPTIVE),
 	};
 	struct request *rq;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3eabe394a5a9..915bb710dd6f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -157,6 +157,7 @@ struct blk_mq_alloc_data {
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
 	unsigned int nr_split;
+	bool preemption;
 	struct request **cached_rq;
 
 	/* input & output parameter */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 702f6b83dc88..8fd9756f0a06 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -419,6 +419,7 @@ enum req_flag_bits {
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
 	__REQ_SPLIT,		/* io is splitted */
+	__REQ_PREEMPTIVE,	/* io can preempt tag */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -444,6 +445,7 @@ enum req_flag_bits {
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
 #define REQ_SPLIT		(1ULL << __REQ_SPLIT)
+#define REQ_PREEMPTIVE		(1ULL << __REQ_PREEMPTIVE)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 9d04c0ecc8f7..1655c15ee11d 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -597,7 +597,8 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 	return NULL;
 }
 
-static unsigned int get_wake_nr(struct sbq_wait_state *ws, unsigned int nr_tags)
+static unsigned int get_wake_nr(struct sbq_wait_state *ws,
+				unsigned int *nr_tags)
 {
 	struct sbq_wait *wait;
 	struct wait_queue_entry *entry;
@@ -606,11 +607,13 @@ static unsigned int get_wake_nr(struct sbq_wait_state *ws, unsigned int nr_tags)
 	spin_lock_irq(&ws->wait.lock);
 	list_for_each_entry(entry, &ws->wait.head, entry) {
 		wait = container_of(entry, struct sbq_wait, wait);
-		if (nr_tags <= wait->nr_tags)
+		if (*nr_tags <= wait->nr_tags) {
+			*nr_tags = 0;
 			break;
+		}
 
 		nr++;
-		nr_tags -= wait->nr_tags;
+		*nr_tags -= wait->nr_tags;
 	}
 	spin_unlock_irq(&ws->wait.lock);
 
@@ -648,7 +651,10 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
 		if (ret == wait_cnt) {
 			sbq_index_atomic_inc(&sbq->wake_index);
-			wake_up_nr(&ws->wait, get_wake_nr(ws, wake_batch));
+			wake_up_nr(&ws->wait, get_wake_nr(ws, &wake_batch));
+			if (wake_batch)
+				sbitmap_queue_wake_all(sbq);
+
 			return false;
 		}
 
-- 
2.31.1

