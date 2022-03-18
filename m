Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933304DD5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiCRILZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiCRILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:11:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436C1890E8;
        Fri, 18 Mar 2022 01:10:01 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKc8Z1J1ZzfYqT;
        Fri, 18 Mar 2022 16:08:30 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 16:09:59 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 16:09:58 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <yukuai3@huawei.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC -next 2/3] blk-mq: call 'bt_wait_ptr()' later in blk_mq_get_tag()
Date:   Fri, 18 Mar 2022 16:25:04 +0800
Message-ID: <20220318082505.3025427-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220318082505.3025427-1-yukuai3@huawei.com>
References: <20220318082505.3025427-1-yukuai3@huawei.com>
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

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 68ac23d0b640..a531351ab190 100644
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
 
@@ -173,7 +172,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		tag = __blk_mq_get_tag(data, bt);
 		if (tag != BLK_MQ_NO_TAG)
 			break;
-
+		if (!ws)
+			ws = bt_wait_ptr(bt, data->hctx);
 		sbitmap_prepare_to_wait(bt, ws, &wait, TASK_UNINTERRUPTIBLE);
 
 		tag = __blk_mq_get_tag(data, bt);
-- 
2.31.1

