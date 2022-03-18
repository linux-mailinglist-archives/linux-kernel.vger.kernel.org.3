Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE54DD5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiCRILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiCRIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:11:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479C25CB9F;
        Fri, 18 Mar 2022 01:10:10 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKc8l4gMmzfYr1;
        Fri, 18 Mar 2022 16:08:39 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 16:10:00 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 16:09:59 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <yukuai3@huawei.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC -next 3/3] sbitmap: improve the fairness of waitqueues' wake up
Date:   Fri, 18 Mar 2022 16:25:05 +0800
Message-ID: <20220318082505.3025427-4-yukuai3@huawei.com>
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

Currently, same waitqueue might be woken up continuously:

__sbq_wake_up			__sbq_wake_up
 sbq_wake_ptr -> assume	0	 sbq_wake_ptr -> 0
 atomic_dec_return
				 atomic_dec_return
 atomic_cmpxchg -> succeed
				 atomic_cmpxchg -> failed
				  return true
				__sbq_wake_up
				 sbq_wake_ptr
				  atomic_read(&sbq->wake_index) -> 0
 sbq_index_atomic_inc -> inc to 1
				  if (waitqueue_active(&ws->wait))
				   if (wake_index != atomic_read(&sbq->wake_index))
				    atomic_set(&sbq->wake_index, wake_index); -> reset from 1 to 0
 wake_up_nr -> wake up first waitqueue
				    // continue to wake up in first waitqueue

To fix the problem, add a detection in sbq_wake_ptr() to avoid choose
the same waitqueue; and refactor __sbq_wake_up() to increase
'wake_index' before updating 'wait_cnt'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index bde0783e4ace..86b18eed83aa 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -583,6 +583,10 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 		return NULL;
 
 	wake_index = atomic_read(&sbq->wake_index);
+
+	/* If this waitqueue is about to wake up, switch to the next */
+	if (atomic_read(&sbq->ws[wake_index].wait_cnt) <= 0)
+		wake_index = sbq_index_inc(wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
@@ -609,33 +613,31 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		return false;
 
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
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
+	if (wait_cnt > 0)
+		return false;
+	/*
+	 * Concurrent callers should call this function again
+	 * to wakeup a new batch on a different 'ws'.
+	 */
+	else if (wait_cnt < 0)
+		return true;
 
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
+	/*
+	 * Increase 'wake_index' before updating 'wake_batch', in case that
+	 * concurrent callers wake up the same 'ws' again.
+	 */
+	sbq_index_atomic_inc(&sbq->wake_index);
+	wake_batch = READ_ONCE(sbq->wake_batch);
 
-		return true;
-	}
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

