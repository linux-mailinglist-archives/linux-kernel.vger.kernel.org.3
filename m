Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5545027B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351951AbiDOJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351938AbiDOJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:58:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EE3BA306;
        Fri, 15 Apr 2022 02:56:27 -0700 (PDT)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KfsCR3BnwzfYvB;
        Fri, 15 Apr 2022 17:55:47 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:56:25 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 17:56:25 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v3 2/8] blk-mq: call 'bt_wait_ptr()' later in blk_mq_get_tag()
Date:   Fri, 15 Apr 2022 18:10:47 +0800
Message-ID: <20220415101053.554495-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220415101053.554495-1-yukuai3@huawei.com>
References: <20220415101053.554495-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

bt_wait_ptr() will increase 'wait_index', however, if blk_mq_get_tag()
get a tag successfully after bt_wait_ptr() is called and before
sbitmap_prepare_to_wait() is called, then the 'ws' is skipped. This
behavior might cause 8 waitqueues to be unbalanced.

Move bt_wait_ptr() later should reduce the problem when the disk is
under high io preesure.

In the meantime, instead of calling bt_wait_ptr() during every loop,
calling bt_wait_ptr() only if destination hw queue is changed, which
should reduce the unfairness further.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 68ac23d0b640..5ad85063e91e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -131,7 +131,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 {
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct sbitmap_queue *bt;
-	struct sbq_wait_state *ws;
+	struct sbq_wait_state *ws = NULL;
 	DEFINE_SBQ_WAIT(wait);
 	unsigned int tag_offset;
 	int tag;
@@ -155,7 +155,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
 		return BLK_MQ_NO_TAG;
 
-	ws = bt_wait_ptr(bt, data->hctx);
 	do {
 		struct sbitmap_queue *bt_prev;
 
@@ -174,6 +173,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		if (!ws)
+			ws = bt_wait_ptr(bt, data->hctx);
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
@@ -199,10 +200,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		 * previous queue for compensating the wake up miss, so
 		 * other allocations on previous queue won't be starved.
 		 */
-		if (bt != bt_prev)
+		if (bt != bt_prev) {
 			sbitmap_queue_wake_up(bt_prev);
-
-		ws = bt_wait_ptr(bt, data->hctx);
+			ws = bt_wait_ptr(bt, data->hctx);
+		}
 	} while (1);
 
 	sbitmap_finish_wait(bt, ws, &wait);
-- 
2.31.1

