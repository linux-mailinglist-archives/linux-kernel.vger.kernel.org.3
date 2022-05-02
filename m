Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181D2517801
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiEBUZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387328AbiEBUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9DDF50
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x18so20927790wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnRXNVBrNu0gZUzja3H8hBQ5GxF3sLHXexVXlrLV7kM=;
        b=X8fSwKk9SZRgne6mCFt08RJn+hmq7rBZ6PS0Lif5QPtJZlQ/cHfzz0fePdMJeVoEV2
         zyvL1shPlDOhP7u5PUB1+DqnDigLCOfPrleRC1jrVgqFeGA6JfZbpihnOZS8qZ6jX59O
         yQRR3Ef/YOfAgiNOZmbbrm+EHUyXvO0wzB1x/k8lhJSruOvHLpeHyXixqlXvVQKDXCpM
         wAgMek3HRzP8pJX7hZzDEm5FnfCZxCzAXqVgnHT7IgLGxlhiRGCHc21Zbmg74RrYBhgy
         AP6MMmfMlFxTPqfQP+stHDF0r/sBv5lgDW1pewuNM7NazO3Hk/sxtq0oT/FGVKoxNudU
         /VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnRXNVBrNu0gZUzja3H8hBQ5GxF3sLHXexVXlrLV7kM=;
        b=LsovQ5UXEy2x7aFu6+a87GuyqTBHNyAZl+pm76/w5SnO/OcAwBmKJ8QhaPveFCEAXR
         Lsx9iPZUB0++xeTrz/UIS6nsVbdX5q61u05eHIBRLxJslM4WkaGgu0IMKu569BXh1QW1
         fsGci0D4bBrcK+2oasmHvBNzOlY12ItVAei1cgyevV1Uiastph0X4BrhYTjLZWIwJbWc
         e2C3lZRJRRUE2911alXX+gQoxcLpfiMwukLDLZN9zJTXbgsXmr0AOCg8yKRv4DsZN4S6
         0Wk0/UqtVkPHn1VU4U99pMdVXrI0Ic2BgHkseNzpunsJFq8DlDPJaF/5uPAUDD7OZpSA
         Ph1A==
X-Gm-Message-State: AOAM532gL9F8XLsyDhByrz1cVd1mcF3QK2NUR1cMYQ7ZM93uRzfrlJfy
        N3rQiio7b5VDXyQir9sRLp/yjg==
X-Google-Smtp-Source: ABdhPJzbkAkG2vpxk0wI5E7kifV7WOkLd0rKSFIEP5owheSFK+XfGcbbQ7pSR6xmwCbFCTwOuNafGw==
X-Received: by 2002:a05:6000:188c:b0:20c:563a:aa86 with SMTP id a12-20020a056000188c00b0020c563aaa86mr8982895wri.360.1651522788240;
        Mon, 02 May 2022 13:19:48 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 08/19] crypto: sun8i-ss: use sg_nents_for_len
Date:   Mon,  2 May 2022 20:19:18 +0000
Message-Id: <20220502201929.843194-9-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502201929.843194-1-clabbe@baylibre.com>
References: <20220502201929.843194-1-clabbe@baylibre.com>
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

When testing with some large SG list, the sun8i-ss drivers always
fallback even if it can handle it.
So use sg_nents_for_len() which permits to see less SGs than needed.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ss/sun8i-ss-cipher.c      | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 70e2e6e37389..c4cb1ab1eeaa 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -29,7 +29,8 @@ static bool sun8i_ss_need_fallback(struct skcipher_request *areq)
 	if (areq->cryptlen == 0 || areq->cryptlen % 16)
 		return true;
 
-	if (sg_nents(areq->src) > 8 || sg_nents(areq->dst) > 8)
+	if (sg_nents_for_len(areq->src, areq->cryptlen) > 8 ||
+		sg_nents_for_len(areq->dst, areq->cryptlen) > 8)
 		return true;
 
 	sg = areq->src;
@@ -169,6 +170,8 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 	int nr_sgs = 0;
 	int nr_sgd = 0;
 	int err = 0;
+	int nsgs = sg_nents_for_len(areq->src, areq->cryptlen);
+	int nsgd = sg_nents_for_len(areq->dst, areq->cryptlen);
 	int i;
 
 	algt = container_of(alg, struct sun8i_ss_alg_template, alg.skcipher);
@@ -201,8 +204,7 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 			goto theend_key;
 	}
 	if (areq->src == areq->dst) {
-		nr_sgs = dma_map_sg(ss->dev, areq->src, sg_nents(areq->src),
-				    DMA_BIDIRECTIONAL);
+		nr_sgs = dma_map_sg(ss->dev, areq->src, nsgs, DMA_BIDIRECTIONAL);
 		if (nr_sgs <= 0 || nr_sgs > 8) {
 			dev_err(ss->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
@@ -210,15 +212,13 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 		}
 		nr_sgd = nr_sgs;
 	} else {
-		nr_sgs = dma_map_sg(ss->dev, areq->src, sg_nents(areq->src),
-				    DMA_TO_DEVICE);
+		nr_sgs = dma_map_sg(ss->dev, areq->src, nsgs, DMA_TO_DEVICE);
 		if (nr_sgs <= 0 || nr_sgs > 8) {
 			dev_err(ss->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
 		}
-		nr_sgd = dma_map_sg(ss->dev, areq->dst, sg_nents(areq->dst),
-				    DMA_FROM_DEVICE);
+		nr_sgd = dma_map_sg(ss->dev, areq->dst, nsgd, DMA_FROM_DEVICE);
 		if (nr_sgd <= 0 || nr_sgd > 8) {
 			dev_err(ss->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
@@ -274,13 +274,10 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 
 theend_sgs:
 	if (areq->src == areq->dst) {
-		dma_unmap_sg(ss->dev, areq->src, sg_nents(areq->src),
-			     DMA_BIDIRECTIONAL);
+		dma_unmap_sg(ss->dev, areq->src, nsgs, DMA_BIDIRECTIONAL);
 	} else {
-		dma_unmap_sg(ss->dev, areq->src, sg_nents(areq->src),
-			     DMA_TO_DEVICE);
-		dma_unmap_sg(ss->dev, areq->dst, sg_nents(areq->dst),
-			     DMA_FROM_DEVICE);
+		dma_unmap_sg(ss->dev, areq->src, nsgs, DMA_TO_DEVICE);
+		dma_unmap_sg(ss->dev, areq->dst, nsgd, DMA_FROM_DEVICE);
 	}
 
 theend_iv:
-- 
2.35.1

