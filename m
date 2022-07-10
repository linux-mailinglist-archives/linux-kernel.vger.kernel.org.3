Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF2356CC94
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 06:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGJEJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 00:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGJEJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 00:09:37 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63EF13CC8;
        Sat,  9 Jul 2022 21:09:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LgYRK4s5fzkX0H;
        Sun, 10 Jul 2022 12:08:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mn4UMpiguJUAg--.16364S7;
        Sun, 10 Jul 2022 12:09:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, asml.silence@gmail.com, osandov@fb.com,
        jack@suse.cz
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RFC v3 3/3] sbitmap: fix that 'wait_cnt' can be decreased while waitqueue is empty
Date:   Sun, 10 Jul 2022 12:22:00 +0800
Message-Id: <20220710042200.20936-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220710042200.20936-1-yukuai1@huaweicloud.com>
References: <20220710042200.20936-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mn4UMpiguJUAg--.16364S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF17ZryrtFyrXryxWFy8Krg_yoW8Kw1fpr
        42kF1vqanYvrW7t39rJr4jq3WYkws5ArZ7KrWfK3W5Cw12qrsavr10kF4Y9r18Zrs8XFW5
        Jr4fJ393CFyUXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU=
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

As pointed out by Jan Kara, following race is still possible:

CPU1				CPU2
__sbq_wake_up			 __sbq_wake_up
 sbq_wake_ptr()			 sbq_wake_ptr() -> the same
 wait_cnt = atomic_dec_return()
 /* decreased to 0 */
 sbq_index_atomic_inc()
 /* move to next waitqueue */
 atomic_set()
 /* reset wait_cnt */
 wake_up_nr()
 /* wake up on the old waitqueue */
				 wait_cnt = atomic_dec_return()
				 /*
				  * decrease wait_cnt in the old
				  * waitqueue, while it can be
				  * empty.
				  */

Fix the problem by waking up before updating 'wake_index' and
'wait_cnt'.

With this patch, noted that 'wait_cnt' is still decreased in the old
empty waitqueue, however, the wakeup is redirected to a active waitqueue,
and the extra decrement on the old empty waitqueue is not handled.

Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 57095dd88a33..55826ebbe7db 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -616,22 +616,33 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		return false;
 
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
-	if (wait_cnt > 0)
-		return false;
-
 	/*
 	 * For concurrent callers of this, callers should call this function
 	 * again to wakeup a new batch on a different 'ws'.
 	 */
-	if (wait_cnt < 0)
+	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
 		return true;
 
+	if (wait_cnt > 0)
+		return false;
+
 	wake_batch = READ_ONCE(sbq->wake_batch);
 
+	/*
+	 * Wake up first in case that concurrent callers decrease wait_cnt
+	 * while waitqueue is empty.
+	 */
+	wake_up_nr(&ws->wait, wake_batch);
+
 	/*
 	 * Pairs with the memory barrier in sbitmap_queue_resize() to
 	 * ensure that we see the batch size update before the wait
 	 * count is reset.
+	 *
+	 * Also pairs with the implicit barrier between becrementing wait_cnt
+	 * and checking for waitqueue_active() to make sure waitqueue_active()
+	 * sees result of the wakeup if atomic_dec_return() has seen the result
+	 * of atomic_set().
 	 */
 	smp_mb__before_atomic();
 
@@ -642,7 +653,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	 */
 	sbq_index_atomic_inc(&sbq->wake_index);
 	atomic_set(&ws->wait_cnt, wake_batch);
-	wake_up_nr(&ws->wait, wake_batch);
 
 	return false;
 }
-- 
2.31.1

