Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363465027AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344802AbiDOJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351949AbiDOJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:59:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD81BA327;
        Fri, 15 Apr 2022 02:56:31 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KfsCV6HWRz1HC0w;
        Fri, 15 Apr 2022 17:55:50 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:56:29 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 17:56:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v3 6/8] blk-mq: force tag preemption for split bios
Date:   Fri, 15 Apr 2022 18:10:51 +0800
Message-ID: <20220415101053.554495-7-yukuai3@huawei.com>
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

For HDD, sequential io is much faster than random io, thus it's better
to issue split io continuously. However, this is broken when tag preemption
is disabled, because wakers can only get one tag each time.

Thus tag preemption should be enabled for split bios, at least for HDD,
specifically the first bio won't preempt tag, and following split bios
will preempt tag.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c         | 8 +++++++-
 block/blk-mq.c            | 1 +
 include/linux/blk_types.h | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7771dacc99cb..85c285023f5e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -343,12 +343,18 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 
 	if (split) {
 		/* there isn't chance to merge the splitted bio */
-		split->bi_opf |= REQ_NOMERGE;
+		split->bi_opf |= (REQ_NOMERGE | REQ_SPLIT);
+		if ((*bio)->bi_opf & REQ_SPLIT)
+			split->bi_opf |= REQ_PREEMPT;
+		else
+			(*bio)->bi_opf |= REQ_SPLIT;
 
 		bio_chain(split, *bio);
 		trace_block_split(split, (*bio)->bi_iter.bi_sector);
 		submit_bio_noacct(*bio);
 		*bio = split;
+	} else if ((*bio)->bi_opf & REQ_SPLIT) {
+		(*bio)->bi_opf |= REQ_PREEMPT;
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32beacbad5e2..a889f01d2cdf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2766,6 +2766,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		.q		= q,
 		.nr_tags	= 1,
 		.cmd_flags	= bio->bi_opf,
+		.preempt	= (bio->bi_opf & REQ_PREEMPT),
 	};
 	struct request *rq;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c62274466e72..046a34c81ec4 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -418,6 +418,8 @@ enum req_flag_bits {
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
+	__REQ_SPLIT,		/* IO is split. */
+	__REQ_PREEMPT,		/* IO will preempt tag. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -443,6 +445,8 @@ enum req_flag_bits {
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_SPLIT		(1ULL << __REQ_SPLIT)
+#define REQ_PREEMPT		(1ULL << __REQ_PREEMPT)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-- 
2.31.1

