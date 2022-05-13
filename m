Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0B5259AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376511AbiEMCV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376486AbiEMCVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:21:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6058F72228;
        Thu, 12 May 2022 19:21:19 -0700 (PDT)
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kzsmf6t86zfbLG;
        Fri, 13 May 2022 10:20:02 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:21:17 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 10:21:16 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2 2/2] block, bfq: make bfq_has_work() more accurate
Date:   Fri, 13 May 2022 10:35:07 +0800
Message-ID: <20220513023507.2625717-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220513023507.2625717-1-yukuai3@huawei.com>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

bfq_has_work() is using busy_queues currently, which is not accurate
because bfq_queue is busy doesn't represent that it has requests. Since
bfqd aready has a counter 'queued' to record how many requests are in
bfq, use it instead of busy_queues.

Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus the
lock can't be held in bfq_has_work() to protect 'bfqd->queued'.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 61750696e87f..740dd83853a6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2210,7 +2210,11 @@ static void bfq_add_request(struct request *rq)
 
 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
 	bfqq->queued[rq_is_sync(rq)]++;
-	bfqd->queued++;
+	/*
+	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
+	 * may be read without holding the lock in bfq_has_work().
+	 */
+	WRITE_ONCE(bfqd->queued, bfqd->queued + 1);
 
 	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
 		bfq_check_waker(bfqd, bfqq, now_ns);
@@ -2402,7 +2406,11 @@ static void bfq_remove_request(struct request_queue *q,
 	if (rq->queuelist.prev != &rq->queuelist)
 		list_del_init(&rq->queuelist);
 	bfqq->queued[sync]--;
-	bfqd->queued--;
+	/*
+	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', however, it
+	 * may be read without holding the lock in bfq_has_work().
+	 */
+	WRITE_ONCE(bfqd->queued, bfqd->queued - 1);
 	elv_rb_del(&bfqq->sort_list, rq);
 
 	elv_rqhash_del(q, rq);
@@ -5063,11 +5071,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 
 	/*
-	 * Avoiding lock: a race on bfqd->busy_queues should cause at
+	 * Avoiding lock: a race on bfqd->queued should cause at
 	 * most a call to dispatch for nothing
 	 */
 	return !list_empty_careful(&bfqd->dispatch) ||
-		bfq_tot_busy_queues(bfqd) > 0;
+		READ_ONCE(bfqd->queued);
 }
 
 static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
-- 
2.31.1

