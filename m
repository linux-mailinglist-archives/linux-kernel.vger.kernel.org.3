Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E34BC6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiBSINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 03:13:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiBSINm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 03:13:42 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2D2229E41;
        Sat, 19 Feb 2022 00:13:23 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K11RW3z59z1FCw6;
        Sat, 19 Feb 2022 16:08:55 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Feb 2022 16:13:20 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Feb
 2022 16:13:20 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH] crypto: hisilicon/sec - fix the aead software fallback for engine
Date:   Sat, 19 Feb 2022 16:08:08 +0800
Message-ID: <20220219080808.12212-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the subreq pointer misuse the private context memory. The aead
soft crypto occasionally casues the OS panic as setting the 64K page.
Here is fix it.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 8caba9fd1f19..a91635c348b5 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2295,9 +2295,10 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
 				struct aead_request *aead_req,
 				bool encrypt)
 {
-	struct aead_request *subreq = aead_request_ctx(aead_req);
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 	struct device *dev = ctx->dev;
+	struct aead_request *subreq;
+	int ret;
 
 	/* Kunpeng920 aead mode not support input 0 size */
 	if (!a_ctx->fallback_aead_tfm) {
@@ -2305,6 +2306,10 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
 		return -EINVAL;
 	}
 
+	subreq = aead_request_alloc(a_ctx->fallback_aead_tfm, GFP_KERNEL);
+	if (!subreq)
+		return -ENOMEM;
+
 	aead_request_set_tfm(subreq, a_ctx->fallback_aead_tfm);
 	aead_request_set_callback(subreq, aead_req->base.flags,
 				  aead_req->base.complete, aead_req->base.data);
@@ -2312,8 +2317,13 @@ static int sec_aead_soft_crypto(struct sec_ctx *ctx,
 			       aead_req->cryptlen, aead_req->iv);
 	aead_request_set_ad(subreq, aead_req->assoclen);
 
-	return encrypt ? crypto_aead_encrypt(subreq) :
-		   crypto_aead_decrypt(subreq);
+	if (encrypt)
+		ret = crypto_aead_encrypt(subreq);
+	else
+		ret = crypto_aead_decrypt(subreq);
+	aead_request_free(subreq);
+
+	return ret;
 }
 
 static int sec_aead_crypto(struct aead_request *a_req, bool encrypt)
-- 
2.33.0

