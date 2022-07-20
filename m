Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C702157B3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiGTJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiGTJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:31:17 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6090158848
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:31:15 -0700 (PDT)
X-QQ-mid: bizesmtp65t1658309467tf1e345v
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 20 Jul 2022 17:31:06 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000020
X-QQ-FEAT: 27H4dUct9tghbnHYDZeKVKd0xx9j0n8612/DIAsUpecCQTLoJQmMsosEIRaAn
        4jKRH2a/Sl1qRoB9/PVzCjGCTQ+WB6Cnexbjt4m+sXRJfSuuZ/SdaducgdyDH+huFApW074
        eMtz9iQuYc1YxcNJKQ4suanjHRm8M4LCEA5Nt3weu1UiOOYI2TD8NoQJGQhS1cqTZw1pKWt
        wyxvdDOREAS4Pa1efErxq2+9JdFrqGZwjlInn578PXJ68m4YkouOaF/n30M7GkJWC3myoYo
        ZWbaBjTgIomaV5i7GX/jitjghLW5jZe1Y68olgx9BHoj3ib7D4vqfICv3v+8VEtIDqdusR6
        uDXZVS3iRxtJB9wWBCcP3wqceV0fZjZHtUof/bXy/hGeNxBUB6kMr6NybQRof8scORm8b8/
        R0mVGEBK3qz9TnxhOBCC1A==
X-QQ-GoodBg: 1
From:   Wang You <wangyoua@uniontech.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangyoua@uniontech.com,
        wangxiaohua@uniontech.com
Subject: [PATCH 1/2] block: Introduce nr_sched_batch sys interface
Date:   Wed, 20 Jul 2022 17:30:47 +0800
Message-Id: <20220720093048.225944-2-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220720093048.225944-1-wangyoua@uniontech.com>
References: <20220720093048.225944-1-wangyoua@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of this patch is to add an nr_sched_batch interface under
/sys/block/sdx/queue/, which can be used to set the number of batching
requests. Of course, the default value is nr_requests and will follow
nr_request when it has not been changed.

Signed-off-by: Wang You <wangyoua@uniontech.com>
---
 block/blk-mq-sched.c   |  4 +++-
 block/blk-sysfs.c      | 34 ++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a4f7c101b53b..92798a0c03bd 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -100,7 +100,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	if (hctx->dispatch_busy)
 		max_dispatch = 1;
 	else
-		max_dispatch = hctx->queue->nr_requests;
+		max_dispatch = q->nr_sched_batch;
 
 	do {
 		struct request *rq;
@@ -567,6 +567,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
 		q->elevator = NULL;
 		q->nr_requests = q->tag_set->queue_depth;
+		q->nr_sched_batch = q->nr_requests;
 		return 0;
 	}
 
@@ -577,6 +578,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	 */
 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
 				   BLKDEV_DEFAULT_RQ);
+	q->nr_sched_batch = q->nr_requests;
 
 	if (blk_mq_is_shared_tags(flags)) {
 		ret = blk_mq_init_sched_shared_tags(q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9b905e9443e4..8f299a3cf66c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -70,6 +70,7 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 {
 	unsigned long nr;
 	int ret, err;
+	unsigned long prev_nr_request = q->nr_requests;
 
 	if (!queue_is_mq(q))
 		return -EINVAL;
@@ -85,6 +86,37 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 	if (err)
 		return err;
 
+	if (q->nr_sched_batch == prev_nr_request ||
+		q->nr_sched_batch > nr)
+		q->nr_sched_batch = nr;
+
+	return ret;
+}
+
+static ssize_t
+elv_nr_batch_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->nr_sched_batch, page);
+}
+
+static ssize_t
+elv_nr_batch_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long nr;
+	int ret;
+
+	if (!queue_is_mq(q))
+		return -EINVAL;
+
+	ret = queue_var_store(&nr, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (nr > q->nr_requests || nr < 1)
+		return -EINVAL;
+
+	q->nr_sched_batch = nr;
+
 	return ret;
 }
 
@@ -573,6 +605,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_ENTRY(elv_nr_batch, "nr_sched_batch");
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -632,6 +665,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_max_integrity_segments_entry.attr,
 	&queue_max_segment_size_entry.attr,
 	&elv_iosched_entry.attr,
+	&elv_nr_batch_entry.attr,
 	&queue_hw_sector_size_entry.attr,
 	&queue_logical_block_size_entry.attr,
 	&queue_physical_block_size_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2f7b43444c5f..13b050c0756b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -422,6 +422,7 @@ struct request_queue {
 	 * queue settings
 	 */
 	unsigned long		nr_requests;	/* Max # of requests */
+	unsigned long           nr_sched_batch;
 
 	unsigned int		dma_pad_mask;
 	unsigned int		dma_alignment;
-- 
2.27.0



