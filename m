Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2856CC93
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 06:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiGJEJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 00:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGJEJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 00:09:37 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBFE12D3C;
        Sat,  9 Jul 2022 21:09:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LgYRK1vLQzl0rR;
        Sun, 10 Jul 2022 12:08:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mn4UMpiguJUAg--.16364S6;
        Sun, 10 Jul 2022 12:09:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, asml.silence@gmail.com, osandov@fb.com,
        jack@suse.cz
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RFC v3 2/3] sbitmap: fix invalid wakeup on the wrong waitqueue
Date:   Sun, 10 Jul 2022 12:21:59 +0800
Message-Id: <20220710042200.20936-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220710042200.20936-1-yukuai1@huaweicloud.com>
References: <20220710042200.20936-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mn4UMpiguJUAg--.16364S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWr17AF4xtFWrXr4xtF1DKFg_yoW5Gr17pr
        43GFn2qanYvrWIywsrJr4jy3WYk3yvk3yxGrW5G348Cr17trsIkr10grn3Zry8CrZ5XFy3
        Jr43JrZ3CFyUXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjYiiDUUUUU=
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

For example, 2 * wake_batch tags are put, while only wake_batch threads
are woken:

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

To fix the problem, increasing 'wake_index' before resetting 'wait_cnt'.

Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index b46fce1beb3a..57095dd88a33 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -616,32 +616,33 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		return false;
 
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
-	if (wait_cnt <= 0) {
-		int ret;
+	if (wait_cnt > 0)
+		return false;
 
-		wake_batch = READ_ONCE(sbq->wake_batch);
+	/*
+	 * For concurrent callers of this, callers should call this function
+	 * again to wakeup a new batch on a different 'ws'.
+	 */
+	if (wait_cnt < 0)
+		return true;
 
-		/*
-		 * Pairs with the memory barrier in sbitmap_queue_resize() to
-		 * ensure that we see the batch size update before the wait
-		 * count is reset.
-		 */
-		smp_mb__before_atomic();
+	wake_batch = READ_ONCE(sbq->wake_batch);
 
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
+	 * Pairs with the memory barrier in sbitmap_queue_resize() to
+	 * ensure that we see the batch size update before the wait
+	 * count is reset.
+	 */
+	smp_mb__before_atomic();
 
-		return true;
-	}
+	/*
+	 * Increase wake_index before updating wait_cnt, otherwise concurrent
+	 * callers can see valid wait_cnt in old waitqueue, which can cause
+	 * invalid wakeup on the old waitqueue.
+	 */
+	sbq_index_atomic_inc(&sbq->wake_index);
+	atomic_set(&ws->wait_cnt, wake_batch);
+	wake_up_nr(&ws->wait, wake_batch);
 
 	return false;
 }
-- 
2.31.1

