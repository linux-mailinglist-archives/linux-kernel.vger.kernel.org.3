Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394B45A4D12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiH2NIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiH2NI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:08:29 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED66E889;
        Mon, 29 Aug 2022 06:03:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MGVvb58bFz6PDdj;
        Mon, 29 Aug 2022 21:02:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgB3PY0ruQxjk7hcAA--.5381S7;
        Mon, 29 Aug 2022 21:03:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 3/3] md/raid10: prevent unnecessary calls to wake_up() in fast path
Date:   Mon, 29 Aug 2022 21:15:02 +0800
Message-Id: <20220829131502.165356-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829131502.165356-1-yukuai1@huaweicloud.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3PY0ruQxjk7hcAA--.5381S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4fXF13JrWruF1UJr18Xwb_yoWrAFWDp3
        yaqF45tFW5ZFZ0qw4DJFWUu3WYgw1ktFWIkrZ2k34kZF18tryftF1UJFyDCryjvrZ3ury8
        ZFW5CrWfGw48tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4q2_UUUUU=
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

Currently, wake_up() is called unconditionally in fast path such as
raid10_make_request(), which will cause lock contention under high
concurrency:

raid10_make_request
 wake_up
  __wake_up_common_lock
   spin_lock_irqsave

Improve performance by only call wake_up() if waitqueue is not empty.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 086216b051f5..2f7c8bef6dc2 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -274,6 +274,12 @@ static void put_buf(struct r10bio *r10_bio)
 	lower_barrier(conf);
 }
 
+static void wake_up_barrier(struct r10conf *conf)
+{
+	if (wq_has_sleeper(&conf->wait_barrier))
+		wake_up(&conf->wait_barrier);
+}
+
 static void reschedule_retry(struct r10bio *r10_bio)
 {
 	unsigned long flags;
@@ -286,7 +292,7 @@ static void reschedule_retry(struct r10bio *r10_bio)
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 
 	/* wake up frozen array... */
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 
 	md_wakeup_thread(mddev->thread);
 }
@@ -884,7 +890,7 @@ static void flush_pending_writes(struct r10conf *conf)
 		/* flush any pending bitmap writes to disk
 		 * before proceeding w/ I/O */
 		md_bitmap_unplug(conf->mddev->bitmap);
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 
 		while (bio) { /* submit pending writes */
 			struct bio *next = bio->bi_next;
@@ -955,7 +961,7 @@ static void lower_barrier(struct r10conf *conf)
 	write_seqlock_irqsave(&conf->resync_lock, flags);
 	WRITE_ONCE(conf->barrier, conf->barrier - 1);
 	write_sequnlock_irqrestore(&conf->resync_lock, flags);
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 }
 
 static bool wait_barrier_nolock(struct r10conf *conf)
@@ -1018,7 +1024,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
 		}
 		conf->nr_waiting--;
 		if (!conf->nr_waiting)
-			wake_up(&conf->wait_barrier);
+			wake_up_barrier(conf);
 	}
 	/* Only increment nr_pending when we wait */
 	if (ret)
@@ -1031,7 +1037,7 @@ static void allow_barrier(struct r10conf *conf)
 {
 	if ((atomic_dec_and_test(&conf->nr_pending)) ||
 			(conf->array_freeze_pending))
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 }
 
 static void freeze_array(struct r10conf *conf, int extra)
@@ -1067,7 +1073,7 @@ static void unfreeze_array(struct r10conf *conf)
 	write_seqlock_irq(&conf->resync_lock);
 	WRITE_ONCE(conf->barrier, conf->barrier - 1);
 	conf->nr_waiting--;
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 	write_sequnlock_irq(&conf->resync_lock);
 }
 
@@ -1092,7 +1098,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		spin_lock_irq(&conf->device_lock);
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 		md_wakeup_thread(mddev->thread);
 		kfree(plug);
 		return;
@@ -1101,7 +1107,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
 	md_bitmap_unplug(mddev->bitmap);
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 
 	while (bio) { /* submit pending writes */
 		struct bio *next = bio->bi_next;
@@ -1907,7 +1913,7 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
 	__make_request(mddev, bio, sectors);
 
 	/* In case raid10d snuck in to freeze_array */
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 	return true;
 }
 
@@ -3055,7 +3061,7 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 			 * In case freeze_array() is waiting for condition
 			 * nr_pending == nr_queued + extra to be true.
 			 */
-			wake_up(&conf->wait_barrier);
+			wake_up_barrier(conf);
 			md_wakeup_thread(conf->mddev->thread);
 		} else {
 			if (test_bit(R10BIO_WriteError,
-- 
2.31.1

