Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F93C546C54
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbiFJS1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349791AbiFJS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:27:33 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923AA38DB2;
        Fri, 10 Jun 2022 11:27:26 -0700 (PDT)
Received: from hednb3.intra.ispras.ru (unknown [10.10.2.52])
        by mail.ispras.ru (Postfix) with ESMTPSA id 35B6E40737C5;
        Fri, 10 Jun 2022 18:27:24 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] crypto: sun8i-ss - fix infinite loop in sun8i_ss_setup_ivs()
Date:   Fri, 10 Jun 2022 21:27:15 +0300
Message-Id: <1654885635-32290-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no i decrement in while (i >= 0) loop.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 5bb950182026..910d6751644c 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -170,6 +170,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 	while (i >= 0) {
 		dma_unmap_single(ss->dev, rctx->p_iv[i], ivsize, DMA_TO_DEVICE);
 		memzero_explicit(sf->iv[i], ivsize);
+		i--;
 	}
 	return err;
 }
-- 
2.7.4

