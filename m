Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7924EAA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiC2J2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiC2J1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:27:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09498F63;
        Tue, 29 Mar 2022 02:26:02 -0700 (PDT)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSPK26vctzfZB8;
        Tue, 29 Mar 2022 17:24:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:26:00 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:25:59 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC 6/6] sbitmap: force tag preemption if free tags are sufficient
Date:   Tue, 29 Mar 2022 17:40:48 +0800
Message-ID: <20220329094048.2107094-7-yukuai3@huawei.com>
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

If tag preemption is disabled and system is under high io pressure,
inflight io should use up tags. Since new io will wait directly, this
rely on waked up threads will obtain at least 'wake_batch' tags.
However, this might be broken if 8 waitqueues is unbalanced.

This patch tries to calculate free tags each time a 'ws' is woken up,
and force tag preemption if free tags are sufficient.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c      | 3 ++-
 include/linux/sbitmap.h | 6 ++++++
 lib/sbitmap.c           | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 4e485bcc5820..55139a011e75 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -131,7 +131,8 @@ static inline bool preempt_tag(struct blk_mq_alloc_data *data,
 			       struct sbitmap_queue *bt)
 {
 	return data->preemption ||
-	       atomic_read(&bt->ws_active) <= SBQ_WAIT_QUEUES;
+	       atomic_read(&bt->ws_active) <= SBQ_WAIT_QUEUES ||
+	       READ_ONCE(bt->force_tag_preemption);
 }
 
 unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 9c8c6da3d820..7a0ea8c0692b 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -118,6 +118,12 @@ struct sbitmap_queue {
 	 */
 	unsigned int wake_batch;
 
+	/**
+	 * @force_tag_preemption: prrempt tag even is tag preemption is
+	 * disabled.
+	 */
+	bool force_tag_preemption;
+
 	/**
 	 * @wake_index: Next wait queue in @ws to wake up.
 	 */
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1655c15ee11d..49241b44f163 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -432,6 +432,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 
 	sbq->min_shallow_depth = UINT_MAX;
 	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
+	sbq->force_tag_preemption = 0;
 	atomic_set(&sbq->wake_index, 0);
 	atomic_set(&sbq->ws_active, 0);
 
@@ -650,6 +651,10 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		 */
 		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
 		if (ret == wait_cnt) {
+			bool force = (sbq->sb.depth - sbitmap_weight(&sbq->sb) >
+				      READ_ONCE(sbq->wake_batch) * 2);
+
+			WRITE_ONCE(sbq->force_tag_preemption, force);
 			sbq_index_atomic_inc(&sbq->wake_index);
 			wake_up_nr(&ws->wait, get_wake_nr(ws, &wake_batch));
 			if (wake_batch)
-- 
2.31.1

