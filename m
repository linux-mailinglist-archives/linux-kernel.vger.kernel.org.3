Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9097A4F8F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiDHH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiDHH0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:26:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5301D36A451;
        Fri,  8 Apr 2022 00:24:43 -0700 (PDT)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZV9m2SBdzdZgB;
        Fri,  8 Apr 2022 15:24:12 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 15:24:41 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 15:24:40 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <yukuai3@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v2 6/8] blk-mq: force tag preemption for split bios
Date:   Fri, 8 Apr 2022 15:39:14 +0800
Message-ID: <20220408073916.1428590-7-yukuai3@huawei.com>
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

For HDD, sequential io is much faster than random io, thus it's better
to issue split io continuously. However, this is broken when tag preemption
is disabled, because wakers can only get one tag each time.

Thus tag preemption should be disabled for split bios, specifically the
first bio won't preempt tag, and following split bios will preempt tag.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-merge.c         | 9 ++++++++-
 block/blk-mq.c            | 1 +
 include/linux/blk_types.h | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7771dacc99cb..cab6ca681513 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -343,12 +343,19 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 
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
+	} else {
+		if ((*bio)->bi_opf & REQ_SPLIT)
+			(*bio)->bi_opf |= REQ_PREEMPT;
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed3ed86f7dd2..909420c5186c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2737,6 +2737,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		.q		= q,
 		.nr_tags	= 1,
 		.cmd_flags	= bio->bi_opf,
+		.preemption	= (bio->bi_opf & REQ_PREEMPT),
 	};
 	struct request *rq;
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c62274466e72..6b56e271f926 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -418,6 +418,8 @@ enum req_flag_bits {
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
+	__REQ_SPLIT,
+	__REQ_PREEMPT,
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

