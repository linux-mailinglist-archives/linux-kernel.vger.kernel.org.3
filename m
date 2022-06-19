Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D055093F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiFSHuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFSHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:50:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D50365E5;
        Sun, 19 Jun 2022 00:50:14 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LQlKB22RZzkWbM;
        Sun, 19 Jun 2022 15:49:02 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 19 Jun 2022 15:50:11 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 19 Jun
 2022 15:50:10 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <osandov@fb.com>, <asml.silence@gmail.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RFC v2 1/2] sbitmap: fix that same waitqueue can be woken up continuously
Date:   Sun, 19 Jun 2022 16:03:08 +0800
Message-ID: <20220619080309.1630027-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619080309.1630027-1-yukuai3@huawei.com>
References: <20220619080309.1630027-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Fix the problem by using atomic_cmpxchg() instead of atomic_set()
to update 'wake_index'.

Fixes: 417232880c8a ("sbitmap: Replace cmpxchg with xchg")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ae4fd4de9ebe..4a230e5baacf 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -576,19 +576,26 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
 
 static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
-	int i, wake_index;
+	int i, wake_index, old_wake_index;
 
+again:
 	if (!atomic_read(&sbq->ws_active))
 		return NULL;
 
-	wake_index = atomic_read(&sbq->wake_index);
+	old_wake_index = wake_index = atomic_read(&sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
 		if (waitqueue_active(&ws->wait)) {
-			if (wake_index != atomic_read(&sbq->wake_index))
-				atomic_set(&sbq->wake_index, wake_index);
-			return ws;
+			if (wake_index != old_wake_index) {
+				if (atomic_cmpxchg(&sbq->wake_index,
+						old_wake_index, wake_index) ==
+						old_wake_index)
+					return ws;
+				goto again;
+			} else {
+				return ws;
+			}
 		}
 
 		wake_index = sbq_index_inc(wake_index);
-- 
2.31.1

