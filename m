Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE157386F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiGMOJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiGMOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:09:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCCC12763
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:09:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p9so12154646pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZUCsCUFTB3hUkWYK46U+VsvZBxdvNM3Fkqu8Dxi8pc=;
        b=Cn/jpQyig6YQIyCLHkn4YaP7UZR5ml4Q9/jM/qWHFT8jzNZxvfWZdaVAlBy206ad7N
         pE1scK5mgeZYVQq6z/R/5AN20t9Gs/e1e3BMDsMtvjpaEz9mjHwlsnYQFxSHMYdQORKu
         LmZEmrcfGRK9gCw6EuVk5VVOaH+qxczVX007bw+bmQxmVuA0T9S5lzOdLP98F/7Pem51
         WvIdP9WAI41JgutJjyTuzGlSXvXFrZy7i2fr8AnhnCXEvDyJfpinG3E8ntorApKIcLYT
         d5WQDwlJ2jhRZQK9hAGuhEi9JkrbEXHlQEiHSYzbXixem49nWfplucI2sNSKjaF1tH3O
         ss1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZUCsCUFTB3hUkWYK46U+VsvZBxdvNM3Fkqu8Dxi8pc=;
        b=0zDYCdIo8hM8t9QPWUCoVaomtlPZiP9RP7Ch8gS8kACsUSu5vpvPYj1xZnY86hIsvd
         9nxa9VJzSRf5+k7v6tukzTFzQP9Mc+bDQNN5xX/hsnh0OlI4spI0LnJVfGjelE9Q/xRJ
         ivF2LFtCCs5xITMREwhpFPAVUwjCYOsZUigA/W3sortLPsUjYdB6E+xHsNzF368WNQcE
         yMWe1dNbJMxINoDO43U5TtvJj1Dp3AzwBH4fASn4ldvMy7qVjLcIEE5rPDOnUVkDoqXf
         /lCANZGD52eWJgu1cQBl+8Oc3b+dF1QOGY512WtCUsyo0SirOg/lPLup1Ao86V2Er/Vs
         s78A==
X-Gm-Message-State: AJIora8KtBgEeRwm8vksZf1sY26VcZzMzGn//V12vD7/uvpx15E9znVA
        8f+XNd/Sc4Ghu4kErk4uCJ6LM4exFp1PI4xE
X-Google-Smtp-Source: AGRyM1ue1MoP4IWh46nK55SBZDgiY7nb8CbRRXsJl/DmE7gN3+60bd97mvAZFdyOMgJmskZsh3ZRLg==
X-Received: by 2002:a17:90a:e008:b0:1ef:831a:1fff with SMTP id u8-20020a17090ae00800b001ef831a1fffmr10183337pjy.221.1657721367885;
        Wed, 13 Jul 2022 07:09:27 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18d5:ce0:b14a:8f36:de08:545f])
        by smtp.gmail.com with ESMTPSA id y4-20020a655b44000000b004126f343fc9sm7920738pgr.67.2022.07.13.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:09:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, snitzer@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] block: fix missing blkcg_bio_issue_init
Date:   Wed, 13 Jul 2022 22:02:26 +0800
Message-Id: <20220713140226.68135-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 513616843d73 ("block: remove superfluous calls to
blkcg_bio_issue_init") has removed blkcg_bio_issue_init from
__bio_clone since submit_bio will override ->bi_issue.
However, __blk_queue_split is called after blkcg_bio_issue_init
(see blk_mq_submit_bio) in submit_bio. In this case, the
->bi_issue is 0. Fix it.

Fixes: 513616843d73 ("block: remove superfluous calls to blkcg_bio_issue_init")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-merge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5abf5aa5a5f0..a5bfe7f18f42 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -355,6 +355,7 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		/* there isn't chance to merge the splitted bio */
 		split->bi_opf |= REQ_NOMERGE;
 
+		blkcg_bio_issue_init(split);
 		bio_chain(split, *bio);
 		trace_block_split(split, (*bio)->bi_iter.bi_sector);
 		submit_bio_noacct(*bio);
-- 
2.11.0

