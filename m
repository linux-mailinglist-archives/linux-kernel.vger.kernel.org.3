Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4386559950F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbiHSGJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346486AbiHSGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706C1EACB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so4436223edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5gJkiTR+kGRLtGgVd47CicF8SNS8UY18L9XUin4OY2Y=;
        b=QJC4IJlQ/pc53o+D11jC62z/3fhQ5SotDCbo5C5orgKX9ZXhpy96Sv15+GEhv6RP+G
         mrqO821gPfoqnBrUz0Pt1mdZBC7U0OIwQtGUeZHKroZt28gFxn1D4vhYT4/byi/4ACXS
         0Oc1eKBWrKxD+RJKPtaXXTHwrCsqVefIZIni+tQ/LWKxtsrTymFXxkO2gJgQ99ozgjKX
         iGxLfMcpdIkhS9BbSA9nwWk2FjQCCCsKcEmYr+qDKpN1Gq2yXXILl8CF25Aw5O0Jy7bR
         kQcpxeHm18TpANDu7+SIayoh6NdnbkYKG6/jA5VrzTKRTWDRCMl9o+vUxdzr5Rkhq2ha
         xXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5gJkiTR+kGRLtGgVd47CicF8SNS8UY18L9XUin4OY2Y=;
        b=14bCcaNGeNKXJOKE101wz5B/nvVFOy11LliCwqer+jWFoyDHVUYWbgqoWUgv2qnAAU
         tnUHTBBEVFgeoN1c5/rOMH4UaCqbuteisURyGsBKybpYFo+IEXLAALnMm/k0jkMps+0j
         IeIgNPfyh/JLjzCcRsGZGpYa+Bw4n782CSKl0R3JAQm2EHq/1uhDUZ2forgzx8cutWRH
         1IuEch0oh7DXRCohnAK+q2oRqkvEmXrn3JhI14JNj4V1TiicaWxGeej8oip5Ytkqa1BR
         NX9roS5j/WRcme6s7prRHA9+0UaFFK+qB3mhnjqjlbXtA7O9EqtE3SXFjICOXtFaGQ+5
         eMPQ==
X-Gm-Message-State: ACgBeo1meSx5dALSkbnzZJzXgwggGw8z0UC4C0ipsCK9AtF+32+d6lDg
        b2A9AUcW0XatDci2LfxQplAnFtKYVNkfV+YV
X-Google-Smtp-Source: AA6agR75k14pdaTAK1S0BCFB7OdMaf69W99USHyOlv8hrS6V7Mr9HiIOc/Y2kMJ6Foo2b8Ui1jyy/g==
X-Received: by 2002:a05:6402:191:b0:445:cf66:25c5 with SMTP id r17-20020a056402019100b00445cf6625c5mr4865875edv.58.1660889298374;
        Thu, 18 Aug 2022 23:08:18 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:17 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 09/19] crypto: qce: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:51 +0200
Message-Id: <20220819060801.10443-10-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

