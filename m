Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4A557F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiFWPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFWPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:54:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE3C2EA3E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:54:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so1827733wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8jabGODKKpoAzTgeQU5m5vPEEziAoNWW/TrXaNDEpQ=;
        b=POfp7FBtLIkOJMQKzrvc5dcAk6RZ51ERRgCn8NVrmJBmSRdGMsct7LDz4AQPnSn047
         y2K+V+JKCw1b0HL1VY7vvfMhdXJ1cLt05PZQJMZK5cA6em2QiwwQQKPQ8EcBQSuGKrdy
         siiKFtNMQQeIcTWeF0VfS7t5bo9kZMPu5CtH13CyC43dFCcil0FJCHODlBRrXqKVx0rv
         HybLIkHvP1SJXjhcWOCdfpJXeOwVg8HBAOK1dgqTAdbFingi9j9AUQvR4qgucErJUdTM
         sbgXGJqa5SXabbvmBiFNzFU+oFhCejvHJiqoGE9B8wkR2RcuJynOmjFfPpb+YjgG2fze
         7FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8jabGODKKpoAzTgeQU5m5vPEEziAoNWW/TrXaNDEpQ=;
        b=rPPI5MrUgjJRzGK5ayrUlmWr4wCeCAZUQuFr1CtDWXoRtcUVoOwlWoN2GcvSn+PBcX
         JGQa2AzdI7SeNdoD/yTMal9DaLGs/hAM0hWptN2TnJEccwP4PIByyIU/e4ydqyjI4mrF
         pBB9D9lQjVIQ1rUN2Za7ndgk00qC1YOoFj6LIJhE0QgZWyyUJ+5teGpxhnNmT1W+tEdz
         X8AfLB+s5Yocreo2SXkgvIg12gWFvNw5d06sKW8mbLASeNkR2JnWDal3jyBSDZ+qZQax
         yR0n8/60EOwgd8p5ytj5cskoXnNbF5MdG1XX7ZK88y/ZkN2P+4ZV5lKbLehnO1AdIRCM
         RcOw==
X-Gm-Message-State: AJIora9gvzPJBvRxfQIGckIJIqFy4stFnfPXPcAKBMqyEYKsL8XnsSFF
        ZWnHQbxO96GSey/1ZQuTNc4lkg==
X-Google-Smtp-Source: AGRyM1ujXYf/CnT4UqbaqU9vpUq34vMQI4R83PM7VCv0ljpwS/NrHG4P6nULOd0q+zEhtxkOg8eK4Q==
X-Received: by 2002:a05:600c:a07:b0:39e:da6e:fc49 with SMTP id z7-20020a05600c0a0700b0039eda6efc49mr4941777wmp.143.1655999640606;
        Thu, 23 Jun 2022 08:54:00 -0700 (PDT)
Received: from OPPO-A74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm20650830wrr.3.2022.06.23.08.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:54:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com,
        Federico Gavioli <f.gavioli97@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 6/8] block, bfq: retrieve independent access ranges from request queue
Date:   Thu, 23 Jun 2022 17:53:33 +0200
Message-Id: <20220623155335.6147-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220623155335.6147-1-paolo.valente@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Federico Gavioli <f.gavioli97@gmail.com>

This patch implements the code to gather the content of the
independent_access_ranges structure from the request_queue and copy
it into the queue's bfq_data. This copy is done at queue initialization.

We copy the access ranges into the bfq_data to avoid taking the queue
lock each time we access the ranges.

This implementation, however, puts a limit to the maximum independent
ranges supported by the scheduler. Such a limit is equal to the constant
BFQ_MAX_ACTUATORS. This limit was placed to avoid the allocation of
dynamic memory.

Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 57 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h | 12 ++++++++++
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c5866f57b3aa..872036d059d7 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -764,7 +764,7 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 	struct bfq_entity *entity;
 	unsigned int act_idx;
 
-	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
 		struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0, act_idx);
 		struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1, act_idx);
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 99c305df6cce..24821334f685 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -689,7 +689,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
-	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
 		struct bfq_queue *bfqq =
 			bic ? bic_to_bfqq(bic, op_is_sync(op), act_idx) : NULL;
 
@@ -1829,10 +1829,24 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 /* get the index of the actuator that will serve bio */
 static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
 {
-	/*
-	 * Multi-actuator support not complete yet, so always return 0
-	 * for the moment.
-	 */
+	struct blk_independent_access_range *iar;
+	unsigned int i;
+	sector_t end;
+
+	if (bfqd->num_ia_ranges == 1)
+		return 0;
+
+	end = bio_end_sector(bio);
+
+	for (i = 0; i < bfqd->num_ia_ranges; i++) {
+		iar = &(bfqd->ia_ranges[i]);
+		if (end >= iar->sector && end < iar->sector + iar->nr_sectors)
+			return i;
+	}
+
+	WARN_ONCE(true,
+		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
+		  end);
 	return 0;
 }
 
@@ -2477,7 +2491,6 @@ static void bfq_remove_request(struct request_queue *q,
 
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending--;
-
 }
 
 static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
@@ -2673,7 +2686,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
+	for (k = 0; k < bfqd->num_ia_ranges; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				if (bfqg->async_bfqq[i][j][k])
@@ -5432,7 +5445,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	if (bfqd)
 		spin_lock_irqsave(&bfqd->lock, flags);
 
-	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < bfqd->num_ia_ranges; act_idx++) {
 		if (bic->stable_merge_bfqq[act_idx])
 			bfq_put_stable_ref(bic->stable_merge_bfqq[act_idx]);
 
@@ -7003,7 +7016,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
+	for (k = 0; k < bfqd->num_ia_ranges; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
@@ -7120,6 +7133,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	unsigned int i;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -7162,6 +7176,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
+	/*
+	 * If the disk supports multiple actuators, we copy the independent
+	 * access ranges from the request queue structure.
+	 */
+	spin_lock_irq(&q->queue_lock);
+	if (q->ia_ranges) {
+		/*
+		 * Check if the disk ia_ranges size exceeds the current bfq
+		 * actuator limit.
+		 */
+		if (q->ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
+			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
+					q->ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
+			pr_crit("Falling back to single actuator mode.\n");
+			bfqd->num_ia_ranges = 1;
+		} else {
+			bfqd->num_ia_ranges = q->ia_ranges->nr_ia_ranges;
+
+			for (i = 0; i < bfqd->num_ia_ranges; i++)
+				bfqd->ia_ranges[i] = q->ia_ranges->ia_range[i];
+		}
+	} else
+		bfqd->num_ia_ranges = 1;
+	spin_unlock_irq(&q->queue_lock);
+
 	INIT_LIST_HEAD(&bfqd->dispatch);
 
 	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 2687e9a85a41..0c78feea15d7 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -796,6 +796,18 @@ struct bfq_data {
 	 */
 	unsigned int word_depths[2][2];
 	unsigned int full_depth_shift;
+
+	/*
+	 * Number of independent access ranges. This is equal to 1 in
+	 * case of single actuator drives.
+	 */
+	unsigned int num_ia_ranges;
+
+	/*
+	 * Disk independent access ranges for each actuator
+	 * in this device.
+	 */
+	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
 };
 
 enum bfqq_state_flags {
-- 
2.20.1

