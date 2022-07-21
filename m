Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE757D557
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGUU7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiGUU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:59:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69131904DD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:59:01 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id EdG2oNF3UGDTnEdG2ovb82; Thu, 21 Jul 2022 22:58:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 22:58:59 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2] crypto: hisilicon/zip: Use the bitmap API to allocate bitmaps
Date:   Thu, 21 Jul 2022 22:58:53 +0200
Message-Id: <456a8b00720d603221c8329c19e38b9f4d96d15a.1658437112.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
It is less verbose and it improves the semantic.

While at it, add an explicit include <linux/bitmap.h>.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 -> v2
- add the missing include <linux/bitmap.h>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 67869513e48c..ad35434a3fdb 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <crypto/internal/acompress.h>
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include "zip.h"
@@ -606,8 +607,7 @@ static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
 		req_q = &ctx->qp_ctx[i].req_q;
 		req_q->size = QM_Q_DEPTH;
 
-		req_q->req_bitmap = kcalloc(BITS_TO_LONGS(req_q->size),
-					    sizeof(long), GFP_KERNEL);
+		req_q->req_bitmap = bitmap_zalloc(req_q->size, GFP_KERNEL);
 		if (!req_q->req_bitmap) {
 			ret = -ENOMEM;
 			if (i == 0)
@@ -631,11 +631,11 @@ static int hisi_zip_create_req_q(struct hisi_zip_ctx *ctx)
 	return 0;
 
 err_free_loop1:
-	kfree(ctx->qp_ctx[HZIP_QPC_DECOMP].req_q.req_bitmap);
+	bitmap_free(ctx->qp_ctx[HZIP_QPC_DECOMP].req_q.req_bitmap);
 err_free_loop0:
 	kfree(ctx->qp_ctx[HZIP_QPC_COMP].req_q.q);
 err_free_bitmap:
-	kfree(ctx->qp_ctx[HZIP_QPC_COMP].req_q.req_bitmap);
+	bitmap_free(ctx->qp_ctx[HZIP_QPC_COMP].req_q.req_bitmap);
 	return ret;
 }
 
@@ -645,7 +645,7 @@ static void hisi_zip_release_req_q(struct hisi_zip_ctx *ctx)
 
 	for (i = 0; i < HZIP_CTX_Q_NUM; i++) {
 		kfree(ctx->qp_ctx[i].req_q.q);
-		kfree(ctx->qp_ctx[i].req_q.req_bitmap);
+		bitmap_free(ctx->qp_ctx[i].req_q.req_bitmap);
 	}
 }
 
-- 
2.34.1

