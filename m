Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9666A5027B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiDOJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351946AbiDOJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:58:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165BBBA316;
        Fri, 15 Apr 2022 02:56:30 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfsB50Yq4zhXZF;
        Fri, 15 Apr 2022 17:54:37 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:56:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 17:56:27 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v3 5/8] sbitmap: force tag preemption if free tags are sufficient
Date:   Fri, 15 Apr 2022 18:10:50 +0800
Message-ID: <20220415101053.554495-6-yukuai3@huawei.com>
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

Now that tag preemption is disabled under heavy load, if wakers doesn't
use up 'wake_batch' tags while preemption is still disabled, io
concurrency will be declined.

To fix the problem, add a detection before wake up, and force tag
preemption is free tags are sufficient, so that the extra tags can be
used by new io. And tag preemption will be disabled again if the extra
tags are used up.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c      |  3 ++-
 include/linux/sbitmap.h |  2 ++
 lib/sbitmap.c           | 30 ++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a6c5ec846a5e..d02710cf3355 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -131,7 +131,8 @@ static inline bool preempt_tag(struct blk_mq_alloc_data *data,
 			       struct sbitmap_queue *bt)
 {
 	return data->preempt ||
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
index 7527527bbc86..315e5619b384 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -434,6 +434,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
 	atomic_set(&sbq->wake_index, 0);
 	atomic_set(&sbq->ws_active, 0);
+	sbq->force_tag_preemption = true;
 
 	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
 	if (!sbq->ws) {
@@ -604,6 +605,34 @@ static void sbq_update_wake_index(struct sbitmap_queue *sbq,
 		atomic_cmpxchg(&sbq->wake_index, old_wake_index, index);
 }
 
+static inline void sbq_update_preemption(struct sbitmap_queue *sbq,
+					 unsigned int wake_batch)
+{
+	unsigned int free;
+
+	if (wake_batch == 1) {
+		/*
+		 * Waiters will be woken up one by one, no risk of declining
+		 * io concurrency.
+		 */
+		sbq->force_tag_preemption = false;
+		return;
+	}
+
+	free = sbq->sb.depth - sbitmap_weight(&sbq->sb);
+	if (sbq->force_tag_preemption) {
+		if (free <= wake_batch)
+			sbq->force_tag_preemption = false;
+	} else {
+		if (free > wake_batch << 1)
+			sbq->force_tag_preemption = true;
+
+	}
+	sbq->force_tag_preemption =
+		(sbq->sb.depth - sbitmap_weight(&sbq->sb)) >= wake_batch << 1 ?
+		true : false;
+}
+
 static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 {
 	struct sbq_wait_state *ws;
@@ -642,6 +671,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	 */
 	smp_mb__before_atomic();
 	atomic_set(&ws->wait_cnt, wake_batch);
+	sbq_update_preemption(sbq, wake_batch);
 	wake_up_nr(&ws->wait, wake_batch);
 
 	return false;
-- 
2.31.1

