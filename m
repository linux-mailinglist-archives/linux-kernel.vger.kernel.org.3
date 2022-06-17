Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD2254F8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382642AbiFQN7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382571AbiFQN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:58:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A84C400;
        Fri, 17 Jun 2022 06:58:46 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPgXn6pykzBrmp;
        Fri, 17 Jun 2022 21:55:21 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 21:58:24 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 21:58:23 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <jack@suse.cz>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC -next] sbitmap: fix possible io hung due to lost wakeups
Date:   Fri, 17 Jun 2022 22:11:25 +0800
Message-ID: <20220617141125.3024491-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, same waitqueue might be woken up continuously:

__sbq_wake_up		__sbq_wake_up
 sbq_wake_ptr -> assume	0
			 sbq_wake_ptr -> 0
 atomic_dec_return
			atomic_dec_return
 atomic_cmpxchg -> succeed
			 atomic_cmpxchg -> failed
			  return true

			__sbq_wake_up
			 sbq_wake_ptr
			  atomic_read(&sbq->wake_index) -> still 0
 sbq_index_atomic_inc -> inc to 1
			  if (waitqueue_active(&ws->wait))
			   if (wake_index != atomic_read(&sbq->wake_index))
			    atomic_set -> reset from 1 to 0
 wake_up_nr -> wake up first waitqueue
			    // continue to wake up in first waitqueue

What's worse, io hung is possible in theory because wakeups might be
missed. For example, 2 * wake_batch tags are put, while only wake_batch
threads are worken:

__sbq_wake_up
 atomic_cmpxchg -> reset wait_cnt
			__sbq_wake_up -> decrease wait_cnt
			...
			__sbq_wake_up -> wait_cnt is decreased to 0 again
			 atomic_cmpxchg
			 sbq_index_atomic_inc -> increase wake_index
			 wake_up_nr -> wake up and waitqueue might be empty
 sbq_index_atomic_inc -> increase again, one waitqueue is skipped
 wake_up_nr -> invalid wake up because old wakequeue might be empty

To fix the problem, refactor to make sure waitqueues will be woken up
one by one,

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 83 ++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ae4fd4de9ebe..dc2959cb188c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -574,66 +574,69 @@ void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
 
-static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
+static void sbq_update_wake_index(struct sbitmap_queue *sbq,
+				  int old_wake_index)
 {
 	int i, wake_index;
-
-	if (!atomic_read(&sbq->ws_active))
-		return NULL;
+	struct sbq_wait_state *ws;
 
 	wake_index = atomic_read(&sbq->wake_index);
-	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
-		struct sbq_wait_state *ws = &sbq->ws[wake_index];
+	if (old_wake_index != wake_index)
+		return;
 
+	for (i = 1; i < SBQ_WAIT_QUEUES; i++) {
+		wake_index = sbq_index_inc(wake_index);
+		ws = &sbq->ws[wake_index];
+		/* Find the next active waitqueue in round robin manner */
 		if (waitqueue_active(&ws->wait)) {
-			if (wake_index != atomic_read(&sbq->wake_index))
-				atomic_set(&sbq->wake_index, wake_index);
-			return ws;
+			atomic_cmpxchg(&sbq->wake_index, old_wake_index,
+				       wake_index);
+			return;
 		}
-
-		wake_index = sbq_index_inc(wake_index);
 	}
-
-	return NULL;
 }
 
 static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 {
 	struct sbq_wait_state *ws;
 	unsigned int wake_batch;
-	int wait_cnt;
+	int wait_cnt, wake_index;
 
-	ws = sbq_wake_ptr(sbq);
-	if (!ws)
+	if (!atomic_read(&sbq->ws_active))
 		return false;
 
-	wait_cnt = atomic_dec_return(&ws->wait_cnt);
-	if (wait_cnt <= 0) {
-		int ret;
-
-		wake_batch = READ_ONCE(sbq->wake_batch);
-
-		/*
-		 * Pairs with the memory barrier in sbitmap_queue_resize() to
-		 * ensure that we see the batch size update before the wait
-		 * count is reset.
-		 */
-		smp_mb__before_atomic();
+	wake_index = atomic_read(&sbq->wake_index);
+	ws = &sbq->ws[wake_index];
+	/*
+	 * This can only happen in the first wakeup when sbitmap waitqueues
+	 * are no longer idle.
+	 */
+	if (!waitqueue_active(&ws->wait)) {
+		sbq_update_wake_index(sbq, wake_index);
+		return true;
+	}
 
-		/*
-		 * For concurrent callers of this, the one that failed the
-		 * atomic_cmpxhcg() race should call this function again
-		 * to wakeup a new batch on a different 'ws'.
-		 */
-		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
-		if (ret == wait_cnt) {
-			sbq_index_atomic_inc(&sbq->wake_index);
-			wake_up_nr(&ws->wait, wake_batch);
-			return false;
-		}
+	wait_cnt = atomic_dec_return(&ws->wait_cnt);
+	if (wait_cnt > 0)
+		return false;
 
+	sbq_update_wake_index(sbq, wake_index);
+	/*
+	 * Concurrent callers should call this function again
+	 * to wakeup a new batch on a different 'ws'.
+	 */
+	if (wait_cnt < 0)
 		return true;
-	}
+
+	wake_batch = READ_ONCE(sbq->wake_batch);
+	/*
+	 * Pairs with the memory barrier in sbitmap_queue_resize() to
+	 * ensure that we see the batch size update before the wait
+	 * count is reset.
+	 */
+	smp_mb__before_atomic();
+	atomic_set(&ws->wait_cnt, wake_batch);
+	wake_up_nr(&ws->wait, wake_batch);
 
 	return false;
 }
-- 
2.31.1

