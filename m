Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20A4D7B68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiCNHQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiCNHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:16:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808123FDA8;
        Mon, 14 Mar 2022 00:15:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h5so11399338plf.7;
        Mon, 14 Mar 2022 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=x5dGbI9er1juJt9+jRuZHplHMW2zg96TRIfl5f163Ps=;
        b=KkBh65zDFpi3DrxawldNVBS0EodkeO3TgixoX7BO0BUESgMRnvGRDpsB9Q0rxr+nl5
         A/vp9aIarusXjOgc2A+3RvGfSAh08uQCu0yzXaZwArIlE7/QK1cTg/+78VAZqW1AVmXZ
         o+cyYUdVlUMi0xbF6n+gmFFxMkostlVsjecmPa18FYk8++TYifULQiEJlOJI3LQxwaNP
         /zc548vVYMIouQGYGz3fMQn0icHzyk0gCxpwJX0KCRHX4x+m0YQDcRYgkKCEGFwXqL3x
         xydy9Gpy75CDKjxIKoXXY7MPVDaHHb8YXYoJuWpg+vJYWRP/VOK7Bgim+qyWmxkwiQA0
         +qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=x5dGbI9er1juJt9+jRuZHplHMW2zg96TRIfl5f163Ps=;
        b=PwET1iXFnIAsfDsk6zMJb0MD8koQkJ0dPgGRtjgBwjsJOjY+htYaRok6MYQ2RQQYro
         cAUSzUeXxksSmCwOCc4GiamXu9bykUcGdv38ScOb72K3x5p3BUGDvHR3ctR+VUqhNQjR
         f5wLuKm9qkyxIVyZIRwn5WxuXwqqJ+VHe+EVwUY7pwOXQ8lDhzWG8l3bp9S5Pn05VtER
         O0Pwxg0ewFkK8VlsLcIDbybltXyq7rFJaJRUVYjUJoOrQewvyyZ7mRcfKHMW/8Lc26Vj
         +hsYIGAGUMhSbOifeQ5AUwbFxY4QKiCrpYihIBF/oEltFxM4xgjkgHQfz2Jxsg7B9dba
         La4Q==
X-Gm-Message-State: AOAM530Cn3sSYKkZPzPPV5s9HlL7ZFLzWmSemOO6lrLaTo0K9Pi0ugNj
        +kEpRrqKK/Gt9Y0YUR3ZVgS2tIygUsTKMQ==
X-Google-Smtp-Source: ABdhPJzfHWBGI4ZCMEnl4r0HK1W1QJikDHZN62HtqgaZCXHutHwo+25NC/N5dwTNKEnNJZ5QqnSF5w==
X-Received: by 2002:a17:903:4111:b0:153:8726:9fe1 with SMTP id r17-20020a170903411100b0015387269fe1mr539739pld.170.1647242104807;
        Mon, 14 Mar 2022 00:15:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ob13-20020a17090b390d00b001becfd7c6f3sm16845447pjb.27.2022.03.14.00.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 00:15:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 13 Mar 2022 21:15:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Yu Kuai <yukuai3@huawei.com>, Saravanan D <saravanand@fb.com>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH block-5.17] fix rq-qos breakage from skipping
 rq_qos_done_bio()
Message-ID: <Yi7rdrzQEHjJLGKB@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a647a524a467 ("block: don't call rq_qos_ops->done_bio if the bio isn't
tracked") made bio_endio() skip rq_qos_done_bio() if BIO_TRACKED is not set.
While this fixed a potential oops, it also broke blk-iocost by skipping the
done_bio callback for merged bios.

Before, whether a bio goes through rq_qos_throttle() or rq_qos_merge(),
rq_qos_done_bio() would be called on the bio on completion with BIO_TRACKED
distinguishing the former from the latter. rq_qos_done_bio() is not called
for bios which wenth through rq_qos_merge(). This royally confuses
blk-iocost as the merged bios never finish and are considered perpetually
in-flight.

One reliably reproducible failure mode is an intermediate cgroup geting
stuck active preventing its children from being activated due to the
leaf-only rule, leading to loss of control. The following is from
resctl-bench protection scenario which emulates isolating a web server like
workload from a memory bomb run on an iocost configuration which should
yield a reasonable level of protection.

  # cat /sys/block/nvme2n1/device/model
  Samsung SSD 970 PRO 512GB               
  # cat /sys/fs/cgroup/io.cost.model
  259:0 ctrl=user model=linear rbps=834913556 rseqiops=93622 rrandiops=102913 wbps=618985353 wseqiops=72325 wrandiops=71025
  # cat /sys/fs/cgroup/io.cost.qos
  259:0 enable=1 ctrl=user rpct=95.00 rlat=18776 wpct=95.00 wlat=8897 min=60.00 max=100.00
  # resctl-bench -m 29.6G -r out.json run protection::scenario=mem-hog,loops=1
  ...
  Memory Hog Summary
  ==================

  IO Latency: R p50=242u:336u/2.5m p90=794u:1.4m/7.5m p99=2.7m:8.0m/62.5m max=8.0m:36.4m/350m
              W p50=221u:323u/1.5m p90=709u:1.2m/5.5m p99=1.5m:2.5m/9.5m max=6.9m:35.9m/350m

  Isolation and Request Latency Impact Distributions:

                min   p01   p05   p10   p25   p50   p75   p90   p95   p99   max  mean stdev
  isol%       15.90 15.90 15.90 40.05 57.24 59.07 60.01 74.63 74.63 90.35 90.35 58.12 15.82 
  lat-imp%        0     0     0     0     0  4.55 14.68 15.54 233.5 548.1 548.1 53.88 143.6 

  Result: isol=58.12:15.82% lat_imp=53.88%:143.6 work_csv=100.0% missing=3.96%

The isolation result of 58.12% is close to what this device would show
without any IO control.

Fix it by introducing a new flag BIO_QOS_MERGED to mark merged bios and
calling rq_qos_done_bio() on them too. For consistency and clarity, rename
BIO_TRACKED to BIO_QOS_THROTTLED. The flag checks are moved into
rq_qos_done_bio() so that it's next to the code paths that set the flags.

With the patch applied, the above same benchmark shows:

  # resctl-bench -m 29.6G -r out.json run protection::scenario=mem-hog,loops=1
  ...
  Memory Hog Summary
  ==================

  IO Latency: R p50=123u:84.4u/985u p90=322u:256u/2.5m p99=1.6m:1.4m/9.5m max=11.1m:36.0m/350m
              W p50=429u:274u/995u p90=1.7m:1.3m/4.5m p99=3.4m:2.7m/11.5m max=7.9m:5.9m/26.5m

  Isolation and Request Latency Impact Distributions:

                min   p01   p05   p10   p25   p50   p75   p90   p95   p99   max  mean stdev
  isol%       84.91 84.91 89.51 90.73 92.31 94.49 96.36 98.04 98.71 100.0 100.0 94.42  2.81 
  lat-imp%        0     0     0     0     0  2.81  5.73 11.11 13.92 17.53 22.61  4.10  4.68 

  Result: isol=94.42:2.81% lat_imp=4.10%:4.68 work_csv=58.34% missing=0%

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: a647a524a467 ("block: don't call rq_qos_ops->done_bio if the bio isn't tracked")
Cc: stable@vger.kernel.org # v5.15+
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>
---
 block/bio.c               |    3 +--
 block/blk-iolatency.c     |    2 +-
 block/blk-rq-qos.h        |   20 +++++++++++---------
 include/linux/blk_types.h |    3 ++-
 4 files changed, 15 insertions(+), 13 deletions(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -1486,8 +1486,7 @@ again:
 	if (!bio_integrity_endio(bio))
 		return;
 
-	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACKED))
-		rq_qos_done_bio(bdev_get_queue(bio->bi_bdev), bio);
+	rq_qos_done_bio(bio);
 
 	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
 		trace_block_bio_complete(bdev_get_queue(bio->bi_bdev), bio);
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -598,7 +598,7 @@ static void blkcg_iolatency_done_bio(str
 	int inflight = 0;
 
 	blkg = bio->bi_blkg;
-	if (!blkg || !bio_flagged(bio, BIO_TRACKED))
+	if (!blkg || !bio_flagged(bio, BIO_QOS_THROTTLED))
 		return;
 
 	iolat = blkg_to_lat(bio->bi_blkg);
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -177,20 +177,20 @@ static inline void rq_qos_requeue(struct
 		__rq_qos_requeue(q->rq_qos, rq);
 }
 
-static inline void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
+static inline void rq_qos_done_bio(struct bio *bio)
 {
-	if (q->rq_qos)
-		__rq_qos_done_bio(q->rq_qos, bio);
+	if (bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
+			     bio_flagged(bio, BIO_QOS_MERGED))) {
+		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+		if (q->rq_qos)
+			__rq_qos_done_bio(q->rq_qos, bio);
+	}
 }
 
 static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 {
-	/*
-	 * BIO_TRACKED lets controllers know that a bio went through the
-	 * normal rq_qos path.
-	 */
 	if (q->rq_qos) {
-		bio_set_flag(bio, BIO_TRACKED);
+		bio_set_flag(bio, BIO_QOS_THROTTLED);
 		__rq_qos_throttle(q->rq_qos, bio);
 	}
 }
@@ -205,8 +205,10 @@ static inline void rq_qos_track(struct r
 static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
-	if (q->rq_qos)
+	if (q->rq_qos) {
+		bio_set_flag(bio, BIO_QOS_MERGED);
 		__rq_qos_merge(q->rq_qos, rq, bio);
+	}
 }
 
 static inline void rq_qos_queue_depth_changed(struct request_queue *q)
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -317,7 +317,8 @@ enum {
 	BIO_TRACE_COMPLETION,	/* bio_endio() should trace the final completion
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
-	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_QOS_THROTTLED,	/* bio went through rq_qos throttle path */
+	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
 	BIO_PERCPU_CACHE,	/* can participate in per-cpu alloc cache */
