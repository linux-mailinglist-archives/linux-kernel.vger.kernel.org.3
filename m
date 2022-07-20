Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C742C57B782
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiGTN3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiGTN3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:29:36 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441A558D9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:29:34 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id E9lWoEl0qnm5hE9lXoFeAH; Wed, 20 Jul 2022 15:29:32 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 15:29:32 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@infradead.org>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2] crypto: ccree - Remove a useless dma_supported() call
Date:   Wed, 20 Jul 2022 15:28:44 +0200
Message-Id: <f47cdaa7067af0ae2eeeca52cee2176cdc449a22.1658323697.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in calling dma_supported() before calling
dma_set_coherent_mask(). This function already calls dma_supported() and
returns an error (-EIO) if it fails.

So remove the superfluous dma_supported() call.

Moreover, setting a larger DMA mask will never fail when setting a smaller
one will succeed, so the whole "while" loop can be removed as well. (see
[1])

While at it, fix the name of the function reported in a dev_err().

[1]: https://lore.kernel.org/all/YteQ6Vx2C03UtCkG@infradead.org/

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/ccree/cc_driver.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 7d1bee86d581..cadead18b59e 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -372,17 +372,10 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		dev->dma_mask = &dev->coherent_dma_mask;
 
 	dma_mask = DMA_BIT_MASK(DMA_BIT_MASK_LEN);
-	while (dma_mask > 0x7fffffffUL) {
-		if (dma_supported(dev, dma_mask)) {
-			rc = dma_set_coherent_mask(dev, dma_mask);
-			if (!rc)
-				break;
-		}
-		dma_mask >>= 1;
-	}
-
+	rc = dma_set_coherent_mask(dev, dma_mask);
 	if (rc) {
-		dev_err(dev, "Failed in dma_set_mask, mask=%llx\n", dma_mask);
+		dev_err(dev, "Failed in dma_set_coherent_mask, mask=%llx\n",
+			dma_mask);
 		return rc;
 	}
 
-- 
2.34.1

