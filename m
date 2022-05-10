Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E77521648
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiEJNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbiEJNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:06:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE49F261962;
        Tue, 10 May 2022 06:02:37 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyJ6C6MhQzGpkL;
        Tue, 10 May 2022 20:59:47 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:02:35 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 21:02:35 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next 1/2] block, bfq: protect 'bfqd->queued' by 'bfqd->lock'
Date:   Tue, 10 May 2022 21:16:28 +0800
Message-ID: <20220510131629.1964415-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220510131629.1964415-1-yukuai3@huawei.com>
References: <20220510131629.1964415-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

If bfq_schedule_dispatch() is called from bfq_idle_slice_timer_body(),
then 'bfqd->queued' is read without holding 'bfqd->lock'. This is
wrong since it can be wrote concurrently.

Fix the problem by holding 'bfqd->lock' for bfq_schedule_dispatch(),
like everywhere else.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 272d48d8f326..61750696e87f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -456,6 +456,8 @@ static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
  */
 void bfq_schedule_dispatch(struct bfq_data *bfqd)
 {
+	lockdep_assert_held(&bfqd->lock);
+
 	if (bfqd->queued != 0) {
 		bfq_log(bfqd, "schedule dispatch");
 		blk_mq_run_hw_queues(bfqd->queue, true);
@@ -6898,8 +6900,8 @@ bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_bfqq_expire(bfqd, bfqq, true, reason);
 
 schedule_dispatch:
-	spin_unlock_irqrestore(&bfqd->lock, flags);
 	bfq_schedule_dispatch(bfqd);
+	spin_unlock_irqrestore(&bfqd->lock, flags);
 }
 
 /*
-- 
2.31.1

