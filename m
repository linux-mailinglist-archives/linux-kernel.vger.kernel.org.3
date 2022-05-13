Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBF525CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377992AbiEMIBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiEMIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:01:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715802D1EB;
        Fri, 13 May 2022 01:01:38 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L01Ky5HDNzgYjF;
        Fri, 13 May 2022 16:00:54 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 16:01:36 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:01:36 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH] crypto: hisilicon/sec - delele the flag CRYPTO_ALG_ALLOCATES_MEMORY
Date:   Fri, 13 May 2022 15:55:42 +0800
Message-ID: <20220513075542.16227-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Should not to uses the CRYPTO_ALG_ALLOCATES_MEMORY in SEC2. The SEC2
driver uses the pre-allocated buffers, including the src sgl pool, dst
sgl pool and other qp ctx resources. (e.g. IV buffer, mac buffer, key
buffer). The SEC2 driver doesn't allocate memory during request processing.
The driver only maps software sgl to allocated hardware sgl during I/O. So
here is fix it.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index a91635c348b5..6eebe739893c 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2113,7 +2113,6 @@ static int sec_skcipher_decrypt(struct skcipher_request *sk_req)
 		.cra_driver_name = "hisi_sec_"sec_cra_name,\
 		.cra_priority = SEC_PRIORITY,\
 		.cra_flags = CRYPTO_ALG_ASYNC |\
-		 CRYPTO_ALG_ALLOCATES_MEMORY |\
 		 CRYPTO_ALG_NEED_FALLBACK,\
 		.cra_blocksize = blk_size,\
 		.cra_ctxsize = sizeof(struct sec_ctx),\
@@ -2366,7 +2365,6 @@ static int sec_aead_decrypt(struct aead_request *a_req)
 		.cra_driver_name = "hisi_sec_"sec_cra_name,\
 		.cra_priority = SEC_PRIORITY,\
 		.cra_flags = CRYPTO_ALG_ASYNC |\
-		 CRYPTO_ALG_ALLOCATES_MEMORY |\
 		 CRYPTO_ALG_NEED_FALLBACK,\
 		.cra_blocksize = blk_size,\
 		.cra_ctxsize = sizeof(struct sec_ctx),\
-- 
2.33.0

