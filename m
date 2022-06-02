Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4E53B452
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiFBH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiFBH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:27:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5893129FE6C;
        Thu,  2 Jun 2022 00:27:52 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LDHdZ1DvxzjXLQ;
        Thu,  2 Jun 2022 15:26:58 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 2 Jun
 2022 15:27:48 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <clabbe.montjoie@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <jernej.skrabec@gmail.com>,
        <samuel@sholland.org>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <wupeng58@huawei.com>
Subject: [PATCH] crypto: sun8i-ss - fix a NULL vs IS_ERR() check in sun8i_ss_hashkey
Date:   Thu, 2 Jun 2022 07:22:34 +0000
Message-ID: <20220602072234.54593-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crypto_alloc_shash() function never returns NULL. It returns error
pointers.

Fixes: 801b7d572c0a ("crypto: sun8i-ss - add hmac(sha1)")
Signed-off-by: Peng Wu <wupeng58@huawei.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index ac417a6b39e5..90334e435673 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -30,8 +30,8 @@ static int sun8i_ss_hashkey(struct sun8i_ss_hash_tfm_ctx *tfmctx, const u8 *key,
 	int ret = 0;
 
 	xtfm = crypto_alloc_shash("sha1", 0, CRYPTO_ALG_NEED_FALLBACK);
-	if (!xtfm)
-		return -ENOMEM;
+	if (IS_ERR(xtfm))
+		return PTR_ERR(xtfm);
 
 	len = sizeof(*sdesc) + crypto_shash_descsize(xtfm);
 	sdesc = kmalloc(len, GFP_KERNEL);
-- 
2.17.1

