Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513F9588BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiHCMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiHCMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:03:13 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2583B1A072;
        Wed,  3 Aug 2022 05:03:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LyVp82HH1z6S2yZ;
        Wed,  3 Aug 2022 20:01:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDX38P6Y+piI+qYAA--.61185S4;
        Wed, 03 Aug 2022 20:03:08 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk, osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Date:   Wed,  3 Aug 2022 20:15:04 +0800
Message-Id: <20220803121504.212071-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX38P6Y+piI+qYAA--.61185S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr17AF4ruFWfAr4DCr48WFg_yoWrtrWrpr
        43GFnYqanYvFWIywsrJw4UZa4Ykw4vg3srGrWfK34rCr12gr4Ykr109r15ury8Ars8Wry5
        tr4fJFZ3CFWUXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are two problems can lead to lost wakeup:

1) invalid wakeup on the wrong waitqueue:

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

2) 'wait_cnt' can be decreased while waitqueue is empty

As pointed out by Jan Kara, following race is possible:

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
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changes in official version:
- fix spelling mistake in comments
- add review tag
Changes in rfc v4:
 - remove patch 1, which improve fairness with overhead
 - merge patch2 and patch 3
Changes in rfc v3:
 - rename patch 2, and add some comments.
 - add patch 3, which fixes a new issue pointed out by Jan Kara.
Changes in rfc v2:
 - split to spearate patches for different problem.
 - add fix tag

 previous versions:
rfc v1: https://lore.kernel.org/all/20220617141125.3024491-1-yukuai3@huawei.com/
rfc v2: https://lore.kernel.org/all/20220619080309.1630027-1-yukuai3@huawei.com/
rfc v3: https://lore.kernel.org/all/20220710042200.20936-1-yukuai1@huaweicloud.com/
rfc v4: https://lore.kernel.org/all/20220723024122.2990436-1-yukuai1@huaweicloud.com/
 lib/sbitmap.c | 55 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 29eb0484215a..1aa55806f6a5 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -611,32 +611,43 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		return false;
 
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
-	if (wait_cnt <= 0) {
-		int ret;
+	/*
+	 * For concurrent callers of this, callers should call this function
+	 * again to wakeup a new batch on a different 'ws'.
+	 */
+	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
+		return true;
 
-		wake_batch = READ_ONCE(sbq->wake_batch);
+	if (wait_cnt > 0)
+		return false;
 
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
+	 * Wake up first in case that concurrent callers decrease wait_cnt
+	 * while waitqueue is empty.
+	 */
+	wake_up_nr(&ws->wait, wake_batch);
 
-		return true;
-	}
+	/*
+	 * Pairs with the memory barrier in sbitmap_queue_resize() to
+	 * ensure that we see the batch size update before the wait
+	 * count is reset.
+	 *
+	 * Also pairs with the implicit barrier between decrementing wait_cnt
+	 * and checking for waitqueue_active() to make sure waitqueue_active()
+	 * sees result of the wakeup if atomic_dec_return() has seen the result
+	 * of atomic_set().
+	 */
+	smp_mb__before_atomic();
+
+	/*
+	 * Increase wake_index before updating wait_cnt, otherwise concurrent
+	 * callers can see valid wait_cnt in old waitqueue, which can cause
+	 * invalid wakeup on the old waitqueue.
+	 */
+	sbq_index_atomic_inc(&sbq->wake_index);
+	atomic_set(&ws->wait_cnt, wake_batch);
 
 	return false;
 }
-- 
2.31.1

