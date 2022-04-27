Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC7512317
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiD0Twe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiD0Tw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:52:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8F49C8B;
        Wed, 27 Apr 2022 12:49:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h12so2459041plf.12;
        Wed, 27 Apr 2022 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dHyaJhWWV2/0XVRasONV/Ot6Fn0AQBDrxMk4qZE1NjE=;
        b=j2ccc9/tmPk1fdAf55kkSQPYg5qtpni4v4AYOGGuRC5Kc275Wz1QP0LZk6VSEAomca
         LJ45O+/bKjIV8dVSZXzuyea5d1YHbou1nsPuHMfJVJXv7EGS4CyWTJyS52gkMqqntX5N
         ybMZx6PAE1e2RF4VOQlALzstvb4Ja3mYTJiI3GFPU82iFnHIGEhOC1oH92roLwG0gu3v
         E6Kc5bFKoAxaemNUCt3Yo5K/rPaqIXn5GqHaRVLjnwptdArBBUAbJeU2IivJVomYoxO2
         nwbN+bg518RRO6yq4EKPISyZXVhnboeJh73dYApkF7Yf/Q3d+IuJwH2w3Nd3vl7YDhKj
         fYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=dHyaJhWWV2/0XVRasONV/Ot6Fn0AQBDrxMk4qZE1NjE=;
        b=jqmSRHw8IiBJekRQ1GjfMfM9+LzzDAWyn682IBavQCF44DcuFwcGfpzC9A7F/NXZyG
         uXrU7G3zj4ZxH6vF+KVCvBvkEnIwS7RirksGVBoWtxnr093G1Jr4ET9i+GWoToTXhxTp
         iLxk/E1hntNro2mz+cjucGzpzP1piM5vNmCwzXTA1/wAY076l41A0NWJRm9q6ax0ZZL3
         oI3qcpVveF7dZPU5SdNmxNXF3UTUS519gTo17uu7ugs0NOL4wfCY41n2qsSZ9Jr+1Qmz
         9EVU189V2rmzRNKm6TyB+sADpvJ568GipjfKseOgC0rNdoG8RfFDrM+2OJ0M3TyHOujK
         cn3w==
X-Gm-Message-State: AOAM531DvMXzWmElVZDyXLsF2ZiDYJjPwz/DGzwxgJjAB5Zlyj7ukG9g
        3INorDF3Sr/fDBj8fc1SPU4=
X-Google-Smtp-Source: ABdhPJwzV7jGfLMkNkr7Nc4QrooBYL9PbbBZexVN3BcRMkRjddWyw7MQE+tpvgzPcSSWq11ciWNqZg==
X-Received: by 2002:a17:902:f64d:b0:151:3895:46bf with SMTP id m13-20020a170902f64d00b00151389546bfmr30687221plg.31.1651088955577;
        Wed, 27 Apr 2022 12:49:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4f81])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090a4f4b00b001d8abe4bb17sm3569076pjl.32.2022.04.27.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:49:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Apr 2022 09:49:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Saravanan D <saravanand@fb.com>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH block-5.18] Revert "block: inherit request start time from
 bio for BLK_CGROUP"
Message-ID: <YmmeOLfo5lzc+8yI@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0006707723233cb2a9a23ca19fc3d0864835704c. It has a
couple problems:

* bio_issue_time() is stored in bio->bi_issue truncated to 51 bits. This
  overflows in slightly over 26 days. Setting rq->io_start_time_ns with it
  means that io duration calculation would yield >26days after 26 days of
  uptime. This, for example, confuses kyber making it cause high IO
  latencies.

* rq->io_start_time_ns should record the time that the IO is issued to the
  device so that on-device latency can be measured. However,
  bio_issue_time() is set before the bio goes through the rq-qos controllers
  (wbt, iolatency, iocost), so when the bio gets throttled in any of the
  mechanisms, the measured latencies make no sense - on-device latencies end
  up higher than request-alloc-to-completion latencies.

We'll need a smarter way to avoid calling ktime_get_ns() repeatedly
back-to-back. For now, let's revert the commit.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org # v5.16+
---
 block/blk-mq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c4370d2761706..84d749511f551 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1131,14 +1131,7 @@ void blk_mq_start_request(struct request *rq)
 	trace_block_rq_issue(rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		u64 start_time;
-#ifdef CONFIG_BLK_CGROUP
-		if (rq->bio)
-			start_time = bio_issue_time(&rq->bio->bi_issue);
-		else
-#endif
-			start_time = ktime_get_ns();
-		rq->io_start_time_ns = start_time;
+		rq->io_start_time_ns = ktime_get_ns();
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
-- 
2.36.0

