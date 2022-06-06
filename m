Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ED453E86E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiFFNhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiFFNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:37:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22827643;
        Mon,  6 Jun 2022 06:37:39 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LGvdt2gtTzjXP0;
        Mon,  6 Jun 2022 21:36:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 21:37:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 21:37:35 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <linux-crypto@vger.kernel.org>
CC:     <clabbe.montjoie@gmail.com>, <herbert@gondor.apana.org.au>
Subject: [PATCH -next] crypto: sun8i-ss - fix error return code in allocate_flows()
Date:   Mon, 6 Jun 2022 21:48:15 +0800
Message-ID: <20220606134815.4103024-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_kmalloc() fails, it should return error code in allocate_flows()

Fixes: 8eec4563f152 ("crypto: sun8i-ss - do not allocate memory when handling hash requests")
Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 98593a0cff69..ac2329e2b0e5 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -528,25 +528,33 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 
 		ss->flows[i].biv = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
 						GFP_KERNEL | GFP_DMA);
-		if (!ss->flows[i].biv)
+		if (!ss->flows[i].biv) {
+			err = -ENOMEM;
 			goto error_engine;
+		}
 
 		for (j = 0; j < MAX_SG; j++) {
 			ss->flows[i].iv[j] = devm_kmalloc(ss->dev, AES_BLOCK_SIZE,
 							  GFP_KERNEL | GFP_DMA);
-			if (!ss->flows[i].iv[j])
+			if (!ss->flows[i].iv[j]) {
+				err = -ENOMEM;
 				goto error_engine;
+			}
 		}
 
 		/* the padding could be up to two block. */
 		ss->flows[i].pad = devm_kmalloc(ss->dev, MAX_PAD_SIZE,
 						GFP_KERNEL | GFP_DMA);
-		if (!ss->flows[i].pad)
+		if (!ss->flows[i].pad) {
+			err = -ENOMEM;
 			goto error_engine;
+		}
 		ss->flows[i].result = devm_kmalloc(ss->dev, SHA256_DIGEST_SIZE,
 						   GFP_KERNEL | GFP_DMA);
-		if (!ss->flows[i].result)
+		if (!ss->flows[i].result) {
+			err = -ENOMEM;
 			goto error_engine;
+		}
 
 		ss->flows[i].engine = crypto_engine_alloc_init(ss->dev, true);
 		if (!ss->flows[i].engine) {
-- 
2.25.1

