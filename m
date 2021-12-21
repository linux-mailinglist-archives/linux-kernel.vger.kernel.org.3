Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B547BEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbhLUL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:27:25 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29275 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbhLUL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:27:17 -0500
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJDgc292gzbjVh;
        Tue, 21 Dec 2021 19:26:52 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 19:27:14 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 19:27:14 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <gregkh@linuxfoundation.org>,
        <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH linux-4.19.y 5/5] block, bfq: fix use after free in bfq_bfqq_expire
Date:   Tue, 21 Dec 2021 19:38:49 +0800
Message-ID: <20211221113849.2219126-6-yukuai3@huawei.com>
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

commit eed47d19d9362bdd958e4ab56af480b9dbf6b2b6 upstream.

The function bfq_bfqq_expire() invokes the function
__bfq_bfqq_expire(), and the latter may free the in-service bfq-queue.
If this happens, then no other instruction of bfq_bfqq_expire() must
be executed, or a use-after-free will occur.

Basing on the assumption that __bfq_bfqq_expire() invokes
bfq_put_queue() on the in-service bfq-queue exactly once, the queue is
assumed to be freed if its refcounter is equal to one right before
invoking __bfq_bfqq_expire().

But, since commit 9dee8b3b057e ("block, bfq: fix queue removal from
weights tree") this assumption is false. __bfq_bfqq_expire() may also
invoke bfq_weights_tree_remove() and, since commit 9dee8b3b057e
("block, bfq: fix queue removal from weights tree"), also
the latter function may invoke bfq_put_queue(). So __bfq_bfqq_expire()
may invoke bfq_put_queue() twice, and this is the actual case where
the in-service queue may happen to be freed.

To address this issue, this commit moves the check on the refcounter
of the queue right around the last bfq_put_queue() that may be invoked
on the queue.

Fixes: 9dee8b3b057e ("block, bfq: fix queue removal from weights tree")
Reported-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
Reported-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Dmitrii Tcvetkov <demfloro@demfloro.ru>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 15 +++++++--------
 block/bfq-iosched.h |  2 +-
 block/bfq-wf2q.c    | 17 +++++++++++++++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d22452fa2d5a..c2529dfda3e5 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2816,7 +2816,7 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 	bfq_remove_request(q, rq);
 }
 
-static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	/*
 	 * If this bfqq is shared between multiple processes, check
@@ -2849,9 +2849,11 @@ static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	/*
 	 * All in-service entities must have been properly deactivated
 	 * or requeued before executing the next function, which
-	 * resets all in-service entites as no more in service.
+	 * resets all in-service entities as no more in service. This
+	 * may cause bfqq to be freed. If this happens, the next
+	 * function returns true.
 	 */
-	__bfq_bfqd_reset_in_service(bfqd);
+	return __bfq_bfqd_reset_in_service(bfqd);
 }
 
 /**
@@ -3256,7 +3258,6 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	bool slow;
 	unsigned long delta = 0;
 	struct bfq_entity *entity = &bfqq->entity;
-	int ref;
 
 	/*
 	 * Check whether the process is slow (see bfq_bfqq_is_slow).
@@ -3325,10 +3326,8 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	 * reason.
 	 */
 	__bfq_bfqq_recalc_budget(bfqd, bfqq, reason);
-	ref = bfqq->ref;
-	__bfq_bfqq_expire(bfqd, bfqq);
-
-	if (ref == 1) /* bfqq is gone, no more actions on it */
+	if (__bfq_bfqq_expire(bfqd, bfqq))
+		/* bfqq is gone, no more actions on it */
 		return;
 
 	bfqq->injected_service = 0;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 746bd570b85a..ca98c98a8179 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -993,7 +993,7 @@ bool __bfq_deactivate_entity(struct bfq_entity *entity,
 			     bool ins_into_idle_tree);
 bool next_queue_may_preempt(struct bfq_data *bfqd);
 struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd);
-void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
+bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
 void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			 bool ins_into_idle_tree, bool expiration);
 void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 1301289b14aa..11ff5ceae02b 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1600,7 +1600,8 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 	return bfqq;
 }
 
-void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
+/* returns true if the in-service queue gets freed */
+bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 {
 	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
 	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
@@ -1624,8 +1625,20 @@ void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * service tree either, then release the service reference to
 	 * the queue it represents (taken with bfq_get_entity).
 	 */
-	if (!in_serv_entity->on_st)
+	if (!in_serv_entity->on_st) {
+		/*
+		 * If no process is referencing in_serv_bfqq any
+		 * longer, then the service reference may be the only
+		 * reference to the queue. If this is the case, then
+		 * bfqq gets freed here.
+		 */
+		int ref = in_serv_bfqq->ref;
 		bfq_put_queue(in_serv_bfqq);
+		if (ref == 1)
+			return true;
+	}
+
+	return false;
 }
 
 void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-- 
2.31.1

