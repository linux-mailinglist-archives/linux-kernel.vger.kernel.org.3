Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A473350C9A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiDWLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDWLle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:41:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB41A04F;
        Sat, 23 Apr 2022 04:38:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w1so18481434lfa.4;
        Sat, 23 Apr 2022 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCiolmgN3BM/9hqURVQm8Fqd8GzWBSSZv9txkhzdRc4=;
        b=kx8deysmbzOe6OBlcsMIejoPkxCsCvoTcg6r8W64zbqEoHAe/Mvx1oRuO/la7HWA3M
         qOMXRMVv6coinGmI+AkdjC2z0ezlI4FZcWDGoEg1kiLbfxTnGgRtya9CMYa5fOvaFsoT
         uCcWYO4eoNLt9T2/HiOOUa2Xx97NzuiSV65kru4NkhxYtO8k47kbeK66X86y2kBVO/9I
         bkrAlEIMeTgHjFkpYiMRU6AL4WqSH064226SwlK3jRURfar1n3hX7uMpX2NnDCO/xedh
         qT/O1rMHt82mAh4AjacfQlGZAodiTHUPcK/i4LTkCFoMusJv3ZOucTGaCU+LTnywWzQZ
         KFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCiolmgN3BM/9hqURVQm8Fqd8GzWBSSZv9txkhzdRc4=;
        b=rnRrxt7d2QAikD8wJ+3u6MZ7teXHfD3dy6hnksxY4lgMLIw8uYrnBc1yHP4TS12BSI
         8qcw1d5c2bX5txfBiiChYRrhGVr2RzeGZldAzM1QLcPpD6rU2O/oeid+PJF5QXSaVPAd
         8WSkqp1HdBrHVP6jPTbWceQIrYVLnS78hOIY2L+KLvla8yfSzUAsJ9JLiWbcsR3BVYZA
         /WyT4ONKw8SpPANyLRA23M7YZTZU1H5//Eye/YOuPqly7BFaTOk6KIjAKd5dLn6Qmu0J
         3z/NdUNArnuVPs6N9QSibxD3JDIuT2mxS9eEQmj6YCYT2l3geoSKDL1T+XT+7b2LkLQ9
         bv0Q==
X-Gm-Message-State: AOAM532CU/1FkkhQ5zOgs885A+F1ydPn6KUtiuV1fEqFq3EMCcFXI+cM
        wC0uI8CxVYHVD5YnHMeJiVg=
X-Google-Smtp-Source: ABdhPJyRKbtRxftsMtdsT/P9kh3negEMeQhkrHNU5CWAZELcGfNHS8JQO7Edg7UKKSf+M9FvASw0lw==
X-Received: by 2002:a05:6512:4017:b0:471:b3c3:481d with SMTP id br23-20020a056512401700b00471b3c3481dmr6234569lfb.541.1650713914723;
        Sat, 23 Apr 2022 04:38:34 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id g17-20020a2e9cd1000000b0024db538c2absm526411ljj.7.2022.04.23.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:38:34 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH RESEND v2 2/5] block/blk-map: Remove redundant assignment
Date:   Sat, 23 Apr 2022 13:38:08 +0200
Message-Id: <20220423113811.13335-2-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423113811.13335-1-michalorzel.eng@gmail.com>
References: <20220423113811.13335-1-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of redundant assignment to a variable ret from function
bio_map_user_iov as it is being assigned a value that is never read.
It is being re-assigned in the first instruction after the while loop

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 block/blk-map.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index c7f71d83eff1..fa72e63e18c2 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -260,10 +260,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
-		if (unlikely(offs & queue_dma_alignment(rq->q))) {
-			ret = -EINVAL;
+		if (unlikely(offs & queue_dma_alignment(rq->q)))
 			j = 0;
-		} else {
+		else {
 			for (j = 0; j < npages; j++) {
 				struct page *page = pages[j];
 				unsigned int n = PAGE_SIZE - offs;
-- 
2.25.1

