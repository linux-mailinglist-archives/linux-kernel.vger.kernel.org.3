Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7484C3EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiBYHGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBYHGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:06:10 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D61DD0C0;
        Thu, 24 Feb 2022 23:05:35 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K4gjw1D6YzdZhK;
        Fri, 25 Feb 2022 15:04:04 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 25 Feb 2022 15:05:17 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 15:05:16 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ming.lei@redhat.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] blk-mq: fix potential uaf for 'queue_hw_ctx'
Date:   Fri, 25 Feb 2022 15:20:53 +0800
Message-ID: <20220225072053.2472431-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
submit_queues through configfs for null_blk), while it might still be
used from other context(e.g. switch elevator to none):

t1					t2
elevator_switch
 blk_mq_unquiesce_queue
  blk_mq_run_hw_queues
   queue_for_each_hw_ctx
    // assembly code for hctx = (q)->queue_hw_ctx[i]
    mov    0x48(%rbp),%rdx -> read old queue_hw_ctx

					__blk_mq_update_nr_hw_queues
					 blk_mq_realloc_hw_ctxs
					  hctxs = q->queue_hw_ctx
					  q->queue_hw_ctx = new_hctxs
					  kfree(hctxs)
    movslq %ebx,%rax
    mov    (%rdx,%rax,8),%rdi ->uaf

This problem was found by code review, and I comfirmed that the concurrent
scenario do exist(specifically 'q->queue_hw_ctx' can be changed during
blk_mq_run_hw_queues()), however, the uaf problem hasn't been repoduced yet
without hacking the kernel.

Sicne the queue is freezed in __blk_mq_update_nr_hw_queues(), fix the
problem by protecting 'queue_hw_ctx' through rcu where it can be accessed
without grabbing 'q_usage_counter'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
changes from rfc
 - move queue_hctx() to blk-mq.h
 - add review tag

 block/blk-mq.c         |  8 +++++++-
 block/blk-mq.h         | 11 +++++++++++
 include/linux/blk-mq.h |  2 +-
 include/linux/blkdev.h |  2 +-
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f1b067d06ab5..3fab7f925011 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3937,7 +3937,13 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (hctxs)
 			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
 			       sizeof(*hctxs));
-		q->queue_hw_ctx = new_hctxs;
+
+		rcu_assign_pointer(q->queue_hw_ctx, new_hctxs);
+		/*
+		 * Make sure reading the old queue_hw_ctx from other
+		 * context concurrently won't trigger uaf.
+		 */
+		synchronize_rcu();
 		kfree(hctxs);
 		hctxs = new_hctxs;
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 948791ea2a3e..20dcfc74d9ee 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -86,6 +86,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
 }
 
+static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	rcu_read_lock();
+	hctx = *(rcu_dereference(q->queue_hw_ctx) + id);
+	rcu_read_unlock();
+
+	return hctx;
+}
+
 static inline enum hctx_type blk_mq_get_hctx_type(unsigned int flags)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3a41d50b85d3..34eab6cd95f8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -918,7 +918,7 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
-	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
+	     ({ hctx = queue_hctx((q), i); 1; }); (i)++)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51a7399a98a1..b16785d1286d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -354,7 +354,7 @@ struct request_queue {
 	unsigned int		queue_depth;
 
 	/* hw dispatch queues */
-	struct blk_mq_hw_ctx	**queue_hw_ctx;
+	struct blk_mq_hw_ctx __rcu	**queue_hw_ctx;
 	unsigned int		nr_hw_queues;
 
 	/*
-- 
2.31.1

