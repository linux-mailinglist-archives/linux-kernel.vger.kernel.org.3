Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820A957C239
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiGUCZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiGUCZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:25:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE55B1FA;
        Wed, 20 Jul 2022 19:25:24 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LpGYn1kY5z1M8Gr;
        Thu, 21 Jul 2022 10:22:37 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 10:25:21 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Jul
 2022 10:25:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH] crypto: hisilicon/sec - fix auth key size error
Date:   Thu, 21 Jul 2022 10:18:31 +0800
Message-ID: <20220721021831.25609-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The authentication algorithm supports a maximum of 128-byte keys.
The allocated key memory is insufficient.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 6 +++---
 drivers/crypto/hisilicon/sec2/sec_crypto.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 53285b0e70d3..d08e2ad8865c 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -662,7 +662,7 @@ static int sec_auth_init(struct sec_ctx *ctx)
 {
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
-	a_ctx->a_key = dma_alloc_coherent(ctx->dev, SEC_MAX_KEY_SIZE,
+	a_ctx->a_key = dma_alloc_coherent(ctx->dev, SEC_MAX_AKEY_SIZE,
 					  &a_ctx->a_key_dma, GFP_KERNEL);
 	if (!a_ctx->a_key)
 		return -ENOMEM;
@@ -674,8 +674,8 @@ static void sec_auth_uninit(struct sec_ctx *ctx)
 {
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
-	memzero_explicit(a_ctx->a_key, SEC_MAX_KEY_SIZE);
-	dma_free_coherent(ctx->dev, SEC_MAX_KEY_SIZE,
+	memzero_explicit(a_ctx->a_key, SEC_MAX_AKEY_SIZE);
+	dma_free_coherent(ctx->dev, SEC_MAX_AKEY_SIZE,
 			  a_ctx->a_key, a_ctx->a_key_dma);
 }
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 5e039b50e9d4..d033f63b583f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -7,6 +7,7 @@
 #define SEC_AIV_SIZE		12
 #define SEC_IV_SIZE		24
 #define SEC_MAX_KEY_SIZE	64
+#define SEC_MAX_AKEY_SIZE	128
 #define SEC_COMM_SCENE		0
 #define SEC_MIN_BLOCK_SZ	1
 
-- 
2.30.0

