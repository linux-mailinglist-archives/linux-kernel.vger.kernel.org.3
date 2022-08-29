Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E8B5A4D11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiH2NI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiH2NI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:08:29 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA46581F;
        Mon, 29 Aug 2022 06:03:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGVvZ4t90zKGHG;
        Mon, 29 Aug 2022 21:02:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgB3PY0ruQxjk7hcAA--.5381S6;
        Mon, 29 Aug 2022 21:03:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next 2/3] md/raid10: convert resync_lock to use seqlock
Date:   Mon, 29 Aug 2022 21:15:01 +0800
Message-Id: <20220829131502.165356-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829131502.165356-1-yukuai1@huaweicloud.com>
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3PY0ruQxjk7hcAA--.5381S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw45Gr4ruFyfArW8ZFW5Wrg_yoW7Cr48pw
        4agr43JrWUXwnxXrs8Ja1q9r1ftw1kKa4UKa9rua4kZFs5tryfXr1UGrykWryqvr9xJrnY
        qFWrCFWrGw12yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2jgxUUUUU=
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

Currently, wait_barrier() will hold 'resync_lock' to read 'conf->barrier',
and io can't be dispatched until 'barrier' is dropped.

Since holding the 'barrier' is not common, convert 'resync_lock' to use
seqlock so that holding lock can be avoided in fast path.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 62 ++++++++++++++++++++++++++++++---------------
 drivers/md/raid10.h |  2 +-
 2 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b70c207f7932..086216b051f5 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -930,38 +930,60 @@ static void flush_pending_writes(struct r10conf *conf)
 
 static void raise_barrier(struct r10conf *conf, int force)
 {
-	spin_lock_irq(&conf->resync_lock);
+	write_seqlock_irq(&conf->resync_lock);
 	BUG_ON(force && !conf->barrier);
 
 	/* Wait until no block IO is waiting (unless 'force') */
 	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
-			    conf->resync_lock);
+			    conf->resync_lock.lock);
 
 	/* block any new IO from starting */
-	conf->barrier++;
+	WRITE_ONCE(conf->barrier, conf->barrier + 1);
 
 	/* Now wait for all pending IO to complete */
 	wait_event_lock_irq(conf->wait_barrier,
 			    !atomic_read(&conf->nr_pending) && conf->barrier < RESYNC_DEPTH,
-			    conf->resync_lock);
+			    conf->resync_lock.lock);
 
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 }
 
 static void lower_barrier(struct r10conf *conf)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&conf->resync_lock, flags);
-	conf->barrier--;
-	spin_unlock_irqrestore(&conf->resync_lock, flags);
+
+	write_seqlock_irqsave(&conf->resync_lock, flags);
+	WRITE_ONCE(conf->barrier, conf->barrier - 1);
+	write_sequnlock_irqrestore(&conf->resync_lock, flags);
 	wake_up(&conf->wait_barrier);
 }
 
+static bool wait_barrier_nolock(struct r10conf *conf)
+{
+	unsigned int seq = raw_read_seqcount(&conf->resync_lock.seqcount);
+
+	if (seq & 1)
+		return false;
+
+	if (READ_ONCE(conf->barrier))
+		return false;
+
+	atomic_inc(&conf->nr_pending);
+	if (!read_seqcount_retry(&conf->resync_lock.seqcount, seq))
+		return true;
+
+	atomic_dec(&conf->nr_pending);
+	return false;
+}
+
 static bool wait_barrier(struct r10conf *conf, bool nowait)
 {
 	bool ret = true;
 
-	spin_lock_irq(&conf->resync_lock);
+	if (wait_barrier_nolock(conf))
+		return true;
+
+	write_seqlock_irq(&conf->resync_lock);
 	if (conf->barrier) {
 		struct bio_list *bio_list = current->bio_list;
 		conf->nr_waiting++;
@@ -992,7 +1014,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
 					      test_bit(MD_RECOVERY_RUNNING,
 						       &conf->mddev->recovery) &&
 					      conf->nr_queued > 0),
-					    conf->resync_lock);
+					    conf->resync_lock.lock);
 		}
 		conf->nr_waiting--;
 		if (!conf->nr_waiting)
@@ -1001,7 +1023,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
 	/* Only increment nr_pending when we wait */
 	if (ret)
 		atomic_inc(&conf->nr_pending);
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 	return ret;
 }
 
@@ -1026,27 +1048,27 @@ static void freeze_array(struct r10conf *conf, int extra)
 	 * must match the number of pending IOs (nr_pending) before
 	 * we continue.
 	 */
-	spin_lock_irq(&conf->resync_lock);
+	write_seqlock_irq(&conf->resync_lock);
 	conf->array_freeze_pending++;
-	conf->barrier++;
+	WRITE_ONCE(conf->barrier, conf->barrier + 1);
 	conf->nr_waiting++;
 	wait_event_lock_irq_cmd(conf->wait_barrier,
 				atomic_read(&conf->nr_pending) == conf->nr_queued+extra,
-				conf->resync_lock,
+				conf->resync_lock.lock,
 				flush_pending_writes(conf));
 
 	conf->array_freeze_pending--;
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 }
 
 static void unfreeze_array(struct r10conf *conf)
 {
 	/* reverse the effect of the freeze */
-	spin_lock_irq(&conf->resync_lock);
-	conf->barrier--;
+	write_seqlock_irq(&conf->resync_lock);
+	WRITE_ONCE(conf->barrier, conf->barrier - 1);
 	conf->nr_waiting--;
 	wake_up(&conf->wait_barrier);
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 }
 
 static sector_t choose_data_offset(struct r10bio *r10_bio,
@@ -4033,7 +4055,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	INIT_LIST_HEAD(&conf->retry_list);
 	INIT_LIST_HEAD(&conf->bio_end_io_list);
 
-	spin_lock_init(&conf->resync_lock);
+	seqlock_init(&conf->resync_lock);
 	init_waitqueue_head(&conf->wait_barrier);
 	atomic_set(&conf->nr_pending, 0);
 
@@ -4352,7 +4374,7 @@ static void *raid10_takeover_raid0(struct mddev *mddev, sector_t size, int devs)
 				rdev->new_raid_disk = rdev->raid_disk * 2;
 				rdev->sectors = size;
 			}
-		conf->barrier = 1;
+		WRITE_ONCE(conf->barrier, 1);
 	}
 
 	return conf;
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 5c0804d8bb1f..8c072ce0bc54 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -76,7 +76,7 @@ struct r10conf {
 	/* queue pending writes and submit them on unplug */
 	struct bio_list		pending_bio_list;
 
-	spinlock_t		resync_lock;
+	seqlock_t		resync_lock;
 	atomic_t		nr_pending;
 	int			nr_waiting;
 	int			nr_queued;
-- 
2.31.1

