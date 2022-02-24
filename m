Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E534C2796
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiBXJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiBXJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:08:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F8A1A0299;
        Thu, 24 Feb 2022 01:08:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gi6so1456044pjb.1;
        Thu, 24 Feb 2022 01:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3qV9UcfDlhAtdycG/J2QOpmGOMHKDJw+84ivqZISOMw=;
        b=IjmAeg2pDMjLBkjhDzcPiuyBVYTe1bHui+bbO2vn62dW7dxWewlKo3AxD3ielKGiui
         LwbUCXIfMntnMG9hz177Jy813YUYtvVMuwOzyG+6MBLAN/tWchzrMh9eCuklwgbzhKIT
         Iulp3RcFLMPEOjMoZcTq2cE9gBrtWOF/aYKTnoVWT+ecNZ/btouTylVyQcemxk2Foimc
         oZN2AznQ0TGG0jn0jUwjGG6xI3uJ/y9WlLf9Q9Nl/GnOzKnc8grxrfBJKRBm8ylbz3yD
         Bc7rO+mzhSw90IvMlN3slWPTDZ0g3TbcsYqToPZonfQZQk8y87eikLQ0YuDujuwBHqIg
         KZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3qV9UcfDlhAtdycG/J2QOpmGOMHKDJw+84ivqZISOMw=;
        b=YvPYklQLSETevwEhANWH+flKbDKwpy22ZTBprAMEcxpbVtX0PuUrifzg8mQJAijthB
         z2mjkuJk6rtr6gL2r+g6YDtBCoQb+Ch3s2hzb2PmpxFGQJSZXV3xRH0GhyN9JENYCdeD
         hjeKzElaBe/QHMtmLnvJ4UG6wkh2A3rhzCcdEZufoSog8pepIJU8trKG9RiXUigSdVj4
         KWez7qbfqVxx/FsNhECrErTz5tUKta1DaVhGNR53B0pBFo68RaAdPUQIGPh8WR7ZDvyp
         pzcYjN9XSvZ910eO6EDVpeAKQNstLrBBK9oK8Fvcabi3KRAE8V4Tf6Nf5Nq5J4+SSI74
         O97w==
X-Gm-Message-State: AOAM530pY/0VY33CPseeAAnQ0+4r8ZIt0kRe9KSr89k/zUFPBVUvWYyC
        s+KMlNhuwmdnfmhOew+Zw+o=
X-Google-Smtp-Source: ABdhPJzYCCdc66Px6kgcsd2keNn2AV14IvK10+oNUoVGSXgrEJ9kfydYiX3JXraJAWyrCMLduZT5Qw==
X-Received: by 2002:a17:90a:4891:b0:1b9:81c:8774 with SMTP id b17-20020a17090a489100b001b9081c8774mr1840091pjh.8.1645693705380;
        Thu, 24 Feb 2022 01:08:25 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:25 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 01/16] blk: make the whole blk_mq_submit_bio under q_usage_counter
Date:   Thu, 24 Feb 2022 17:06:39 +0800
Message-Id: <20220224090654.54671-2-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224090654.54671-1-jianchao.wan9@gmail.com>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to protect the rqos list against the rqos open/close. We
need to drain all of the caller of blk_mq_submit_bio() before
we can operate the rqos list.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1adfe4824ef5..3c1cd32c72fd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2723,8 +2723,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (unlikely(bio_queue_enter(bio)))
-		return NULL;
+	percpu_ref_get(&q->q_usage_counter);
 
 	if (plug) {
 		data.nr_tags = plug->nr_ios;
@@ -2789,15 +2788,18 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
+	if (unlikely(bio_queue_enter(bio)))
+		return;
+
 	blk_queue_bounce(q, &bio);
 	if (blk_may_split(q, bio))
 		__blk_queue_split(q, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
-		return;
+		goto exit;
 
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
-		return;
+		goto exit;
 
 	rq_qos_throttle(q, bio);
 
@@ -2805,7 +2807,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq) {
 		rq = blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq))
-			return;
+			goto exit;
 	}
 
 	trace_block_getrq(bio);
@@ -2819,12 +2821,12 @@ void blk_mq_submit_bio(struct bio *bio)
 		bio->bi_status = ret;
 		bio_endio(bio);
 		blk_mq_free_request(rq);
-		return;
+		goto exit;
 	}
 
 	if (op_is_flush(bio->bi_opf)) {
 		blk_insert_flush(rq);
-		return;
+		goto exit;
 	}
 
 	if (plug)
@@ -2836,6 +2838,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	else
 		blk_mq_run_dispatch_ops(rq->q,
 				blk_mq_try_issue_directly(rq->mq_hctx, rq));
+exit:
+	blk_queue_exit(q);
 }
 
 /**
-- 
2.17.1

