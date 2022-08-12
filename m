Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD10590D85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiHLIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiHLIjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:39:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8CA8948
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:39:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m2so207296pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0mUv/OIwNOgxr+AJ4heRTowHTjoovZ9rJeO39JRdzHw=;
        b=VB83/M+Y1sA7CDYIIhOnldF01NWx2UVGgdgUGtJkC/d841QVGlYW10n4El6AptnGyd
         6yUMuU60QfcGR51HWnMfZwXjoLJktV4WGrJ2v6IMFYmX80qc0csZDVYvpJ3UzCztXqPb
         OvjEYni5Oiv403aW7AsqJ8/IADSD0Aigap1W5bsjjpfOiX37lYqdchX5YGOewOHEtmAg
         a+SMtVxdP+XYijRV03ZBUyFxRqml98TU9hSdKpinUTAGeCqbbDOKH+RjdODPtCOqL1L9
         CHCqUL2myzY4OWqrxqfq9+oz52FV4TLlFkuuEhW1GvjY0O4iFiJ8FvH5XJsVASTMjEit
         3jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0mUv/OIwNOgxr+AJ4heRTowHTjoovZ9rJeO39JRdzHw=;
        b=RRqzxNuSl27k+Cl1wTgDYoZM4uHQ2R4AvwxGpG7I975a1oAMmYZ74HCO6zBMtHWXXJ
         Bmt2JY9k11TUQAbWXid6nQ7geHWOzRzdMRQh8CNS1X9gVIzlTXGCovFTkosczaRhp0HU
         3dd1OF1bviXSV1f+vva55GtBwlPzK3silG3Qg0vBeoLuss14axkOHjYa/XS3trzrRxjx
         R10Auhi2JwTt9AgU4nhkx34GRZZhpV5ORnfleKDHuNWnbvZRWTJa4pgtiMKAbqvBkBG1
         117VSeOtYudJfrNEILHfyCd2WAq3n1WufiWPOAX4RA9kJKmr+EUxEJklBuGpS/WO6OSv
         LaJA==
X-Gm-Message-State: ACgBeo2xoDxpCshAx+ifzRDJ6Ym3pDwinm0rSP3WTvzxuj9AqxLY+lSv
        PO5UEHpC6OdWzEi8gVn1n8gMCvONab6bgg==
X-Google-Smtp-Source: AA6agR5JCZ0P5SLwlydBxzbVzuLE6/hH+PDfT82O/NI4bMajbGhU/hB6meTTkeWLycLO9ypB79ApTw==
X-Received: by 2002:a17:903:120e:b0:16f:2e9:8c41 with SMTP id l14-20020a170903120e00b0016f02e98c41mr3065259plh.55.1660293593800;
        Fri, 12 Aug 2022 01:39:53 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b0016dd6929af5sm1109119plk.206.2022.08.12.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 01:39:53 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-mq: move bio merge attempt to blk_mq_submit_bio()
Date:   Fri, 12 Aug 2022 16:39:44 +0800
Message-Id: <20220812083944.79616-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will try to get request from cache before alloc request, in
both cases will first attempt bio merge.

This patch move this common part to blk_mq_submit_bio(), which
simplify the code and avoid passing in the pointer of bio.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ee62b95f3e5..aa091615e20b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2716,8 +2716,7 @@ static bool blk_mq_attempt_bio_merge(struct request_queue *q,
 
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
-					       struct bio *bio,
-					       unsigned int nsegs)
+					       struct bio *bio)
 {
 	struct blk_mq_alloc_data data = {
 		.q		= q,
@@ -2729,9 +2728,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	if (unlikely(bio_queue_enter(bio)))
 		return NULL;
 
-	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
-		goto queue_exit;
-
 	rq_qos_throttle(q, bio);
 
 	if (plug) {
@@ -2746,13 +2742,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-queue_exit:
+
 	blk_queue_exit(q);
 	return NULL;
 }
 
 static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
-		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
+		struct blk_plug *plug, struct bio *bio)
 {
 	struct request *rq;
 
@@ -2762,14 +2758,9 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	if (!rq || rq->q != q)
 		return NULL;
 
-	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
-		*bio = NULL;
-		return NULL;
-	}
-
-	if (blk_mq_get_hctx_type((*bio)->bi_opf) != rq->mq_hctx->type)
+	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
 		return NULL;
 
 	/*
@@ -2778,9 +2769,9 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	 * before we throttle.
 	 */
 	plug->cached_rq = rq_list_next(rq);
-	rq_qos_throttle(q, *bio);
+	rq_qos_throttle(q, bio);
 
-	rq->cmd_flags = (*bio)->bi_opf;
+	rq->cmd_flags = bio->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
 }
@@ -2824,11 +2815,12 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	bio_set_ioprio(bio);
 
-	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
+	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
+		return;
+
+	rq = blk_mq_get_cached_request(q, plug, bio);
 	if (!rq) {
-		if (!bio)
-			return;
-		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+		rq = blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq))
 			return;
 	}
-- 
2.36.1

