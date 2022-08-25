Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4524E5A0A20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiHYHYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiHYHY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:24:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC6FA1D50
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 2so16903143edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GPCchtlqY0x+osDXrsSxawuc0V42qtMzkjN73n8cxBM=;
        b=JccJ9HB44F/VRIZXTXJH1gnUBCWN08vJ4qS1hLoSC72Z0WogPZQj4sAV23CRjuy0pi
         caId474J23+1783idQuywKTtEuPYu+AdLKe9Iq4gnIp1X/89jtv3QsSrD9y/UoFCUx8K
         vw2kU3MLLGp1sJB44GoHEEm/nhwZKxpXaYX/ZmTEjP63N5aFmUVC3S1JDsDtQ1EsTxK6
         CW6egRcLA4qrY1YL3VKvrcbZQIN6xnvfSKKOl39Bnc0BVwZleKAJqk3WAgyaQE3gac3t
         MjU+OsdRCRFN2h2KoCyOPHJ8TCKPwUkTUlxsQwc4RCeDpdY7qdcKLVkMEkqcVsIh5vqH
         t/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GPCchtlqY0x+osDXrsSxawuc0V42qtMzkjN73n8cxBM=;
        b=mA3Ay4GrzrO9GmKk9gSKG0TkXmmEF/OCbe+fDoyXOFYfNbGsC/IZMsoten6QgI2ZLI
         u4u/22vsvtLMDI+gim3uo8tFapRYqHYTu+1VjgbyZatyGyz8Ui8JFkf+DmXCaZhC67t+
         3XcFVDEZSqjZHldLZOnBX7I3ZDUFNzJEVUaLCQHo7DPLlRqjFNAFGD8OtSiUoJMcb2a5
         I89pIlAf3aX2kF3i8LONfL3w9nOlhdg7m90uxRg4BWf6pEcJDXncHGisKjxVLUSojJlJ
         iGY8ArU+X1InHW9nyArDuPMWNKeHcqhqnNQigiu0T2jMB23ZzjFCbw3W/QYsh3qzLNQv
         qd/Q==
X-Gm-Message-State: ACgBeo04VIFg9muDb1n7ipLY+6xYST7EIh4YuZ9XvZopAGVvirpQC48C
        RG4N1zCxzKijS4LeILdf+rU+SQ==
X-Google-Smtp-Source: AA6agR7q9pwuIWJfkIrvtAB6BO2kapEJ9TRNLDpYyUhe+LhPG7n3xt+KkchNWrnVdEJxrxlL/W6TEQ==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr2135577eda.134.1661412264497;
        Thu, 25 Aug 2022 00:24:24 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170907778c00b0073ce4abf093sm2032281ejc.214.2022.08.25.00.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:24:24 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] crypto: qce: Fix dma_map_sg error check
Date:   Thu, 25 Aug 2022 09:24:18 +0200
Message-Id: <20220825072421.29020-4-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825072421.29020-1-jinpu.wang@ionos.com>
References: <20220825072421.29020-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, fix the error check and return -EIO to
caller.

Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/qce/aead.c     | 4 ++--
 drivers/crypto/qce/sha.c      | 8 +++++---
 drivers/crypto/qce/skcipher.c | 8 ++++----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 97a530171f07..6eb4d2e35629 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -450,8 +450,8 @@ qce_aead_async_req_handle(struct crypto_async_request *async_req)
 	if (ret)
 		return ret;
 	dst_nents = dma_map_sg(qce->dev, rctx->dst_sg, rctx->dst_nents, dir_dst);
-	if (dst_nents < 0) {
-		ret = dst_nents;
+	if (!dst_nents) {
+		ret = -EIO;
 		goto error_free;
 	}
 
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 59159f5e64e5..37bafd7aeb79 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -97,14 +97,16 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 	}
 
 	ret = dma_map_sg(qce->dev, req->src, rctx->src_nents, DMA_TO_DEVICE);
-	if (ret < 0)
-		return ret;
+	if (!ret)
+		return -EIO;
 
 	sg_init_one(&rctx->result_sg, qce->dma.result_buf, QCE_RESULT_BUF_SZ);
 
 	ret = dma_map_sg(qce->dev, &rctx->result_sg, 1, DMA_FROM_DEVICE);
-	if (ret < 0)
+	if (!ret) {
+		ret = -EIO;
 		goto error_unmap_src;
+	}
 
 	ret = qce_dma_prep_sgs(&qce->dma, req->src, rctx->src_nents,
 			       &rctx->result_sg, 1, qce_ahash_done, async_req);
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 3d27cd5210ef..5b493fdc1e74 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -124,15 +124,15 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 	rctx->dst_sg = rctx->dst_tbl.sgl;
 
 	dst_nents = dma_map_sg(qce->dev, rctx->dst_sg, rctx->dst_nents, dir_dst);
-	if (dst_nents < 0) {
-		ret = dst_nents;
+	if (!dst_nents) {
+		ret = -EIO;
 		goto error_free;
 	}
 
 	if (diff_dst) {
 		src_nents = dma_map_sg(qce->dev, req->src, rctx->src_nents, dir_src);
-		if (src_nents < 0) {
-			ret = src_nents;
+		if (!src_nents) {
+			ret = -EIO;
 			goto error_unmap_dst;
 		}
 		rctx->src_sg = req->src;
-- 
2.34.1

