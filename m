Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A834894F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiAJJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbiAJJMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:37 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD787C06175B;
        Mon, 10 Jan 2022 01:12:36 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f5so10590908pgk.12;
        Mon, 10 Jan 2022 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bSUEh0XLtqhfgkfkzajXuKpmq20fHb9Sj/+2QGQC9ew=;
        b=jzwrhKF0NlGNkrs0lKhKEQVXqGfdbsnXa/4dzpcDhN3rFtajTCp9xVy86nUMHwXCtr
         iql48w/CwdJX9x5rpOvpnLNHFMSGu8KD5a8CpHcdSLM43GkkGH0fRIsH26NAn4ElAVHw
         hpmFOSyyjy1fchoAZGBvYHCaENHaFJhZZ6V/1ELvUleV1rtbHgxldxoDN+InaHkbE/MK
         hB1myc/KO6znAfJcTSQf5Wz/EIq14zITjIm+50KHSLODbabX8bXVgpCz3c34bWBdCuCi
         1zCj40tb1hDNMuBJX4PWb6KpKs5M/o+v+AY6yql8ktoTeUWSSsgy35b2pC7WN90kF8PQ
         Jtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bSUEh0XLtqhfgkfkzajXuKpmq20fHb9Sj/+2QGQC9ew=;
        b=u192hYkONIaUPAb3c42BRcolRzFUsUrxZpt0/1sqH7dd8VqDKNqkOAV7Db5BKUA2l4
         mY0JZQaGG2heEKhuFmiolRg+w4Y/jt5mTkSMR/wRUm5MILDyDzm+HV5pObWNzzs3Q3+y
         ahoZiQd7ttOw/+uaNHdImEiGb6z8Y3/dq/Q321xXeIpuN210MS2BcixXLD0OTKFTmaun
         7zmBFUxTvU/GPF8dFzy1TZ3EUkvD0LBJZVOeuhPv779lhMk62im/zBKz6KhMuuUfaZVl
         sv1KKzEMVHZyqwIQm2QNEBDr/l45nigS+vv+oVX1SAUAAsSdRDTGu8Xp4Wu5nIOq1ngD
         3JWA==
X-Gm-Message-State: AOAM532gys9LwjPGxcevQ0RFFBh31LJSEt9V8bsa83CiQLIIwKNH1LGo
        CrP4EaBzU1kshQWFxpGJfIM=
X-Google-Smtp-Source: ABdhPJzsaxURA5vI16ldXhVbMjcAnwUgXVGx9P+pyAfurtLyGpwIdEoqiLlJH/5hXDN5H9EapuNNhA==
X-Received: by 2002:a63:33cd:: with SMTP id z196mr42921496pgz.78.1641805956416;
        Mon, 10 Jan 2022 01:12:36 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:36 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] blk: make request able to carry blkcg_gq
Date:   Mon, 10 Jan 2022 17:10:45 +0800
Message-Id: <20220110091046.17010-13-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

After blk_update_request, the bios can be gone. We cannot track
the req in cgroup fashion in following IO completion path. This
patch add blkcg_gq into request, get it when install bio, put it
before request is released.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 block/Kconfig          |  3 +++
 block/blk-core.c       |  6 +++++-
 block/blk-merge.c      |  9 +++++++++
 block/blk-mq.c         | 14 ++++++++++++++
 include/linux/blk-mq.h |  4 +++-
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index b3a2c656a64b..ea612cb5c8ee 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -32,6 +32,9 @@ config BLK_BIO_IOCOST
 config BLK_RQ_ALLOC_TIME
 	bool
 
+config BLK_RQ_BLKCG_GQ
+	bool
+
 config BLK_CGROUP_RWSTAT
 	bool
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 2847ab514c1f..083160895125 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1462,7 +1462,11 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	}
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
 	rq->ioprio = rq_src->ioprio;
-
+#ifdef CONFIG_BLK_RQ_BLKCG_GQ
+	if (rq_src->blkg)
+		blkg_get(rq_src->blkg);
+	rq->blkg = rq_src->blkg;
+#endif
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 893c1a60b701..cf5d0e5ce04f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -793,6 +793,10 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
+#ifdef CONFIG_BLK_RQ_BLKCG_GQ
+	if (req->blkg != next->blkg)
+		return NULL;
+#endif
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -930,6 +934,11 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
+#ifdef CONFIG_BLK_RQ_BLKCG_GQ
+	if (rq->blkg != bio->bi_blkg)
+		return false;
+#endif
+
 	return true;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8874a63ae952..131845bca5de 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -28,6 +28,7 @@
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 
@@ -369,6 +370,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->nr_phys_segments = 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
+#endif
+#ifdef CONFIG_BLK_RQ_BLKCG_GQ
+	rq->blkg = NULL;
 #endif
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
@@ -600,6 +604,10 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	const int sched_tag = rq->internal_tag;
 
+#ifdef CONFIG_BLK_RQ_BLKCG_GQ
+	if (rq->blkg)
+		blkg_put(rq->blkg);
+#endif
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
@@ -2305,6 +2313,12 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 	rq->__sector = bio->bi_iter.bi_sector;
 	rq->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
+#ifdef CONFIG_BLK_RQ_BLKCG_GQ
+	if (bio->bi_blkg) {
+		blkg_get(bio->bi_blkg);
+		rq->blkg = bio->bi_blkg;
+	}
+#endif
 
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
 	err = blk_crypto_rq_bio_prep(rq, bio, GFP_NOIO);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2949d9ac7484..f9cc6f6b8d63 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -110,7 +110,9 @@ struct request {
 	u64 start_time_ns;
 	/* Time that I/O was submitted to the device. */
 	u64 io_start_time_ns;
-
+#ifdef CONFIG_BLK_RQ_BLKCG_GQ
+	struct blkcg_gq *blkg;
+#endif
 #ifdef CONFIG_BLK_WBT
 	unsigned short wbt_flags;
 #endif
-- 
2.17.1

