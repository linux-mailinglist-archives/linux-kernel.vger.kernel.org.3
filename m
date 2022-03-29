Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7634EAA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiC2J1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiC2J1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:27:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD9972D2;
        Tue, 29 Mar 2022 02:26:00 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSPLZ1BV3zcbQS;
        Tue, 29 Mar 2022 17:25:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:25:58 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:25:57 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC 3/6] blk-mq: record how many tags are needed for splited bio
Date:   Tue, 29 Mar 2022 17:40:45 +0800
Message-ID: <20220329094048.2107094-4-yukuai3@huawei.com>
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

Prepare to wake up number of threads based on required tags.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c      | 1 +
 block/blk-mq.c          | 1 +
 block/blk-mq.h          | 1 +
 include/linux/sbitmap.h | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 68ac23d0b640..83dfbe2f1cfc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -155,6 +155,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
 		return BLK_MQ_NO_TAG;
 
+	wait.nr_tags += data->nr_split;
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
 		struct sbitmap_queue *bt_prev;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cad207d2079e..9bace9e2c5ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2737,6 +2737,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		.q		= q,
 		.nr_tags	= 1,
 		.cmd_flags	= bio->bi_opf,
+		.nr_split	= bio->bi_nr_split,
 	};
 	struct request *rq;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1a084b3b6097..3eabe394a5a9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -156,6 +156,7 @@ struct blk_mq_alloc_data {
 
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
+	unsigned int nr_split;
 	struct request **cached_rq;
 
 	/* input & output parameter */
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 8f5a86e210b9..9c8c6da3d820 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -591,11 +591,13 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m);
 struct sbq_wait {
 	struct sbitmap_queue *sbq;	/* if set, sbq_wait is accounted */
 	struct wait_queue_entry wait;
+	unsigned int nr_tags;
 };
 
 #define DEFINE_SBQ_WAIT(name)							\
 	struct sbq_wait name = {						\
 		.sbq = NULL,							\
+		.nr_tags = 1,							\
 		.wait = {							\
 			.private	= current,				\
 			.func		= autoremove_wake_function,		\
-- 
2.31.1

