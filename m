Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D14894FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiAJJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbiAJJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:29 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7AC061751;
        Mon, 10 Jan 2022 01:12:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v25so10608430pge.2;
        Mon, 10 Jan 2022 01:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mye8NrrngBW+LTEJOPV5rC/ZWn3FGUdytNp+4GKYHYE=;
        b=WivIciOSaQFS3IEPnDGqfT0VeQwufCr5Cw2IZWjxnUPIFReohYsNsunLXo3v6kLfJv
         x/nArzg8Y/DMxpnxdQH9SODoNPqPOz8KyHv18qt0tO4LfAyy8MUHh34qZXNE3NhrB1jo
         Ar493F/EdStR5iGrxtvftkhej8aQ6ag6+BtuEvxXJ8TWtiGA2ZryVrfMw5IbsN1O2ccW
         ozkEvYIjOZpxrISOZ/Ny8Wslvs1C/addTshfclC28tnH6hKHtEH4/VUNeZZD2twb0GLK
         AoGPRIwM27GOuc7iuwalW6AFIXRRW9vZn0+YUUtl1VeuyNjLVM87EAhMzi61f+uVmD+Y
         w7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mye8NrrngBW+LTEJOPV5rC/ZWn3FGUdytNp+4GKYHYE=;
        b=gicGX3bqOM5o3VmQ6aXGGm+c3tByWW7G/DXSnVDajMFE+dXg1c1y8Or/aPNBc0PJi2
         4tnyMxyea8J9qTyGyy17m1bYb8b0sUgde8yWgJRVMcsbr2XNN6q9xPhRj5oNxdHT8BQP
         YCIlIDN9uFU0Cj5Nk7A+ewmlbMu6Puq3d+JTprNe5E+JaPNdyvgDtpelt6sZHJy6Q8ty
         fwSvZARWWwnryMAKEzSOTZSxLXIxgjivInFd1hjDRTiSx06bACNVyY+zv9xib5Vn++ic
         i/rjOrpCBVinEw1MDGFpFPknKqw7zFY7r2DsvRMuEZE0Ct0WWzRnD/VzCduozUEFZvyG
         XX+A==
X-Gm-Message-State: AOAM533df3TrmhCPHaaucT2VMBZ/tJYqoDZPLrE3wsUQrpJTbmKWZbf5
        XW6J3XTOyO2JqZwB1Pbo2DPsNJcxKIX4hn+R
X-Google-Smtp-Source: ABdhPJzA0wzm5mUwsMaMKwmPjz/g2UVPNLMf9OkAcZmCzqZLrXVI/9Jp2ru1duFdtlM5AUBpK2xTiw==
X-Received: by 2002:a62:5fc4:0:b0:4bb:2472:5147 with SMTP id t187-20020a625fc4000000b004bb24725147mr74946037pfb.74.1641805933690;
        Mon, 10 Jan 2022 01:12:13 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:13 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] blk: export following interfaces
Date:   Mon, 10 Jan 2022 17:10:36 +0800
Message-Id: <20220110091046.17010-4-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

This is a preparation for making blk-rq-qos policyies modular,
there is no functional change.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/bdev.c               |  5 -----
 block/blk-cgroup.c         | 12 ++++++++++++
 block/blk-mq-debugfs.c     |  2 ++
 block/blk-rq-qos.c         |  2 ++
 block/blk-stat.c           | 30 ------------------------------
 block/blk-stat.h           | 31 ++++++++++++++++++++++++++++---
 include/linux/blk-cgroup.h |  1 +
 include/linux/blkdev.h     |  5 ++++-
 8 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b1d087e5e205..35d8c71be741 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -761,11 +761,6 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	return bdev;
 }
 
-void blkdev_put_no_open(struct block_device *bdev)
-{
-	put_device(&bdev->bd_device);
-}
-
 /**
  * blkdev_get_by_dev - open a block device by device number
  * @dev: device number of block device to open
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 663aabfeba18..fb56d74f1c8e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -55,10 +55,18 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
 bool blkcg_debug_stats = false;
+EXPORT_SYMBOL_GPL(blkcg_debug_stats);
+
 static struct workqueue_struct *blkcg_punt_bio_wq;
 
 #define BLKG_DESTROY_BATCH_SIZE  64
 
+bool blkcg_debug_stats_enabled(void)
+{
+	return blkcg_debug_stats;
+}
+EXPORT_SYMBOL_GPL(blkcg_debug_stats_enabled);
+
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
 {
@@ -494,6 +502,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
 		return NULL;
 	return bdi_dev_name(blkg->q->disk->bdi);
 }
+EXPORT_SYMBOL_GPL(blkg_dev_name);
 
 /**
  * blkcg_print_blkgs - helper for printing per-blkg data
@@ -606,6 +615,7 @@ struct block_device *blkcg_conf_open_bdev(char **inputp)
 	*inputp = input;
 	return bdev;
 }
+EXPORT_SYMBOL_GPL(blkcg_conf_open_bdev);
 
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
@@ -1778,6 +1788,7 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
 		current->use_memdelay = use_memdelay;
 	set_notify_resume(current);
 }
+EXPORT_SYMBOL_GPL(blkcg_schedule_throttle);
 
 /**
  * blkcg_add_delay - add delay to this blkg
@@ -1795,6 +1806,7 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 	blkcg_scale_delay(blkg, now);
 	atomic64_add(delta, &blkg->delay_nsec);
 }
+EXPORT_SYMBOL_GPL(blkcg_add_delay);
 
 /**
  * blkg_tryget_closest - try and get a blkg ref on the closet blkg
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e225db3c271f..9c786b63c847 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -835,6 +835,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 	debugfs_remove_recursive(rqos->debugfs_dir);
 	rqos->debugfs_dir = NULL;
 }
+EXPORT_SYMBOL_GPL(blk_mq_debugfs_unregister_rqos);
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 {
@@ -855,6 +856,7 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
+EXPORT_SYMBOL_GPL(blk_mq_debugfs_register_rqos);
 
 void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
 {
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index a94ff872722b..08ccd4a4e913 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -33,6 +33,7 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
 {
 	return atomic_inc_below(&rq_wait->inflight, limit);
 }
+EXPORT_SYMBOL_GPL(rq_wait_inc_below);
 
 void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio)
 {
@@ -296,6 +297,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
 }
+EXPORT_SYMBOL_GPL(rq_qos_wait);
 
 void rq_qos_exit(struct request_queue *q)
 {
diff --git a/block/blk-stat.c b/block/blk-stat.c
index ae3dd1fb8e61..2b0c530b0c9c 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -18,36 +18,6 @@ struct blk_queue_stats {
 	bool enable_accounting;
 };
 
-void blk_rq_stat_init(struct blk_rq_stat *stat)
-{
-	stat->min = -1ULL;
-	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->batch = 0;
-}
-
-/* src is a per-cpu stat, mean isn't initialized */
-void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
-{
-	if (!src->nr_samples)
-		return;
-
-	dst->min = min(dst->min, src->min);
-	dst->max = max(dst->max, src->max);
-
-	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
-				dst->nr_samples + src->nr_samples);
-
-	dst->nr_samples += src->nr_samples;
-}
-
-void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
-{
-	stat->min = min(stat->min, value);
-	stat->max = max(stat->max, value);
-	stat->batch += value;
-	stat->nr_samples++;
-}
-
 void blk_stat_add(struct request *rq, u64 now)
 {
 	struct request_queue *q = rq->q;
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17b47a86eefb..2642969594d8 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -164,8 +164,33 @@ static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
 	mod_timer(&cb->timer, jiffies + msecs_to_jiffies(msecs));
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *, u64);
-void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
-void blk_rq_stat_init(struct blk_rq_stat *);
+static inline void blk_rq_stat_init(struct blk_rq_stat *stat)
+{
+	stat->min = -1ULL;
+	stat->max = stat->nr_samples = stat->mean = 0;
+	stat->batch = 0;
+}
+
+/* src is a per-cpu stat, mean isn't initialized */
+static inline void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+{
+	if (!src->nr_samples)
+		return;
+
+	dst->min = min(dst->min, src->min);
+	dst->max = max(dst->max, src->max);
 
+	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
+				dst->nr_samples + src->nr_samples);
+
+	dst->nr_samples += src->nr_samples;
+}
+
+static inline void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
+{
+	stat->min = min(stat->min, value);
+	stat->max = max(stat->max, value);
+	stat->batch += value;
+	stat->nr_samples++;
+}
 #endif
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b4de2010fba5..b87a1bdde675 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -179,6 +179,7 @@ struct blkcg_policy {
 extern struct blkcg blkcg_root;
 extern struct cgroup_subsys_state * const blkcg_root_css;
 extern bool blkcg_debug_stats;
+bool blkcg_debug_stats_enabled(void);
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e7dce2232814..ed30b3c3fee7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1297,7 +1297,10 @@ void blkdev_put(struct block_device *bdev, fmode_t mode);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
-void blkdev_put_no_open(struct block_device *bdev);
+static inline void blkdev_put_no_open(struct block_device *bdev)
+{
+	put_device(&bdev->bd_device);
+}
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
-- 
2.17.1

