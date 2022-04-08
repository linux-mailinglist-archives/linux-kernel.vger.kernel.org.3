Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94B4F8F89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiDHH1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiDHH0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:26:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3F369E0B;
        Fri,  8 Apr 2022 00:24:41 -0700 (PDT)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZV8G3RLhzgYYk;
        Fri,  8 Apr 2022 15:22:54 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 15:24:40 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 15:24:39 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <yukuai3@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v2 4/8] blk-mq: don't preempt tag under heavy load
Date:   Fri, 8 Apr 2022 15:39:12 +0800
Message-ID: <20220408073916.1428590-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220408073916.1428590-1-yukuai3@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Tag preemption is the default behaviour, specifically blk_mq_get_tag()
will try to get tag unconditionally, which means a new io can preempt
tag even if there are lots of ios that are waiting for tags.

Such behaviour doesn't make sense when the disk is under heavy load,
because it will intensify competition without improving performance,
especially for huge io as split io is unlikely to be issued
continuously.

The idle way to disable tag preemption is to track how many tags are
available, and wait directly in blk_mq_get_tag() if free tags are
very little. However, this is out of reality because fast path is
affected.

As 'ws_active' is only updated in slow path, this patch disable tag
preemption if 'ws_active' is greater than 8, which means there are many
threads waiting for tags already.

Once tag preemption is disabled, there is a situation that can cause
performance degration(or io hung in extreme scenarios): the waitqueue
doesn't have 'wake_batch' threads, thus wake up on this waitqueue might
cause the concurrency of ios to be decreased. The next patch will fix this
problem.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 36 +++++++++++++++++++++++++-----------
 block/blk-mq.h     |  1 +
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 228a0001694f..be2d49e6d69e 100644
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
 
 	do {
 		struct sbitmap_queue *bt_prev;
@@ -169,20 +178,25 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
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
 
 		ws = bt_wait_ptr(bt, data->hctx);
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
 
+		data->preemption = true;
 		sbitmap_finish_wait(bt, ws, &wait);
 
 		data->ctx = blk_mq_get_ctx(data->q);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 2615bd58bad3..b49b20e11350 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -156,6 +156,7 @@ struct blk_mq_alloc_data {
 
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
+	bool preemption;
 	struct request **cached_rq;
 
 	/* input & output parameter */
-- 
2.31.1

