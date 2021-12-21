Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE947BEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhLUL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:27:23 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15957 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhLUL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:27:16 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJDcQ40NgzZdZ9;
        Tue, 21 Dec 2021 19:24:06 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 19:27:14 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 19:27:13 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <gregkh@linuxfoundation.org>,
        <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH linux-4.19.y 4/5] block, bfq: fix queue removal from weights tree
Date:   Tue, 21 Dec 2021 19:38:48 +0800
Message-ID: <20211221113849.2219126-5-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211221113849.2219126-1-yukuai3@huawei.com>
References: <20211221113849.2219126-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

commit 9dee8b3b057e1da26f85f1842f2aaf3bb200fb94 upstream.

bfq maintains an ordered list, through a red-black tree, of unique
weights of active bfq_queues. This list is used to detect whether there
are active queues with differentiated weights. The weight of a queue is
removed from the list when both the following two conditions become
true:

(1) the bfq_queue is flagged as inactive
(2) the has no in-flight request any longer;

Unfortunately, in the rare cases where condition (2) becomes true before
condition (1), the removal fails, because the function to remove the
weight of the queue (bfq_weights_tree_remove) is rightly invoked in the
path that deactivates the bfq_queue, but mistakenly invoked *before* the
function that actually performs the deactivation (bfq_deactivate_bfqq).

This commits moves the invocation of bfq_weights_tree_remove for
condition (1) to after bfq_deactivate_bfqq. As a consequence of this
move, it is necessary to add a further reference to the queue when the
weight of a queue is added, because the queue might otherwise be freed
before bfq_weights_tree_remove is invoked. This commit adds this
reference and makes all related modifications.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 17 +++++++++++++----
 block/bfq-wf2q.c    |  6 +++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d5daf6e05771..d22452fa2d5a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -748,6 +748,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 inc_counter:
 	bfqq->weight_counter->num_active++;
+	bfqq->ref++;
 }
 
 /*
@@ -772,6 +773,7 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 
 reset_entity_pointer:
 	bfqq->weight_counter = NULL;
+	bfq_put_queue(bfqq);
 }
 
 /*
@@ -783,9 +785,6 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 {
 	struct bfq_entity *entity = bfqq->entity.parent;
 
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
-
 	for_each_entity(entity) {
 		struct bfq_sched_data *sd = entity->my_sched_data;
 
@@ -819,6 +818,15 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			bfqd->num_groups_with_pending_reqs--;
 		}
 	}
+
+	/*
+	 * Next function is invoked last, because it causes bfqq to be
+	 * freed if the following holds: bfqq is not in service and
+	 * has no dispatched request. DO NOT use bfqq after the next
+	 * function invocation.
+	 */
+	__bfq_weights_tree_remove(bfqd, bfqq,
+				  &bfqd->queue_weights_tree);
 }
 
 /*
@@ -1012,7 +1020,8 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
-	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st;
+	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st -
+		(bfqq->weight_counter != NULL);
 }
 
 /* Empty burst list and add just bfqq (see comments on bfq_handle_burst) */
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 63e0f12be7c9..1301289b14aa 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1668,15 +1668,15 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqd->busy_queues--;
 
-	if (!bfqq->dispatched)
-		bfq_weights_tree_remove(bfqd, bfqq);
-
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues--;
 
 	bfqg_stats_update_dequeue(bfqq_group(bfqq));
 
 	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
+
+	if (!bfqq->dispatched)
+		bfq_weights_tree_remove(bfqd, bfqq);
 }
 
 /*
-- 
2.31.1

