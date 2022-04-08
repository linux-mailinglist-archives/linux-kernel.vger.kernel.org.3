Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854454F8F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiDHH1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiDHH0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:26:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C72369E34;
        Fri,  8 Apr 2022 00:24:42 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZV8H1G1yzgYXx;
        Fri,  8 Apr 2022 15:22:55 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 15:24:40 +0800
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
Subject: [PATCH -next RFC v2 5/8] sbitmap: force tag preemption if free tags are sufficient
Date:   Fri, 8 Apr 2022 15:39:13 +0800
Message-ID: <20220408073916.1428590-6-yukuai3@huawei.com>
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

Now that tag preemption is disabled, if wakers doesn't use up
'wake_batch' tags while preemption is still disabled, io concurrency
will be declined.

To fix the problem, add a detection before wake up, and force tag
preemption is free tags are sufficient, so that the extra tags can be
used by new io.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c      |  3 ++-
 include/linux/sbitmap.h |  2 ++
 lib/sbitmap.c           | 11 +++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index be2d49e6d69e..dfbb06edfbc3 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -131,7 +131,8 @@ static inline bool preempt_tag(struct blk_mq_alloc_data *data,
 			       struct sbitmap_queue *bt)
 {
 	return data->preemption ||
-	       atomic_read(&bt->ws_active) <= SBQ_WAIT_QUEUES;
+	       atomic_read(&bt->ws_active) <= SBQ_WAIT_QUEUES ||
+	       bt->force_tag_preemption;
 }
 
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 8a64271d0696..ca00ccb6af48 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -143,6 +143,8 @@ struct sbitmap_queue {
 	 * sbitmap_queue_get_shallow()
 	 */
 	unsigned int min_shallow_depth;
+
+	bool force_tag_preemption;
 };
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 176fba0252d7..8d01e02ea4b1 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -434,6 +434,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
 	atomic_set(&sbq->ws_active, 0);
+	sbq->force_tag_preemption = true;
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
@@ -604,6 +605,15 @@ static void sbq_update_wake_index(struct sbitmap_queue *sbq,
 		atomic_cmpxchg(&sbq->wake_index, old_wake_index, index);
 }
 
+static inline void sbq_update_preemption(struct sbitmap_queue *sbq,
+					 unsigned int wake_batch)
+{
+	bool force = (sbq->sb.depth - sbitmap_weight(&sbq->sb)) >=
+		     wake_batch << 1;
+
+	WRITE_ONCE(sbq->force_tag_preemption, force);
+}
+
 static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 {
 	struct sbq_wait_state *ws;
@@ -637,6 +647,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	 */
 	smp_mb__before_atomic();
 	atomic_set(&ws->wait_cnt, wake_batch);
+	sbq_update_preemption(sbq, wake_batch);
 	wake_up_nr(&ws->wait, wake_batch);
 
 	return true;
-- 
2.31.1

