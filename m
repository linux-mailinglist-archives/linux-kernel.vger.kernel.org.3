Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520915177EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387345AbiEBUX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbiEBUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1925DF21
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so20845756wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bzBSnYxnno3ubCsu2RX/z6PxzsqdZYUM+vjWEuZhKY=;
        b=GxlhQp5w8ZuJqgjBx6Zl1aym3RLt7VZe8OBwmdaGKDWWTDH6AegMB+WV64l0mZrWC+
         eZauRXWf+sSFmjWkXytfcD3iAlaiXJMP4lVmmlcOl5t6N0kILe7fUkBEY031QSeR4U/b
         jshsTBKf9Crf7ictWjp4M0RXZVDYVqd5ecsJS3kS1TdBNvJU01WXuaL/4vZX4q17DIX9
         r0nqPN2UbN3d925lXp9WV7VTShNitOE+wFsYjpO7iwbJGpgm5batKtjiKSTrmpji/j81
         eMtD+9fDWSBaHd2kRQH0YsLS29S80QhJwmrYJzt8utV3P2fvhLkx/RVWKWJHbq3UekkQ
         TVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bzBSnYxnno3ubCsu2RX/z6PxzsqdZYUM+vjWEuZhKY=;
        b=TIstRoiWfDipRsR/CjkIhtl9ha8ZSabLq4xnLp/lC4nIJ8KSiwUq1zM1N8+Xgzlq1r
         j0f6dkRE9U36M8xURwFVb1ouyH4bHe7wMxcbQmt4RnqJ+7AtjjnuKe7pJmPS8EixgEL4
         E5M5e7sdzSmkZR1Li6NhtqKPtkaZZ7R454HBiyZQtO+6pBx19faf6uEHJ3kS9lhlps3C
         4stPCX/V+swdEQarmtXONVXguwAsBQeDE803qyPAihsMx13dUdNyevpdzC89tv6X/PJw
         URG1WgrnVkMPdyherN5/lIwjuy3b1ny6w+5/Xf7OzSW6x7pZgLeJlzp8n01Iy1kCWXJd
         XRCw==
X-Gm-Message-State: AOAM530Y9Fc46/B7frSAVCOLoJb+aXRSfgtM5oUEW14JTBziPTOTAnNN
        kWAcUkBb5vUclaPDm0I+ZlSvpg==
X-Google-Smtp-Source: ABdhPJwFrgBjSnqhajyzAIXw5oe4LmQJf7erSZFSRVx/6BCzkZ5YZlAaQoIpNBQ8MyvzwU7lvhdbhQ==
X-Received: by 2002:a5d:47af:0:b0:20c:6701:50be with SMTP id 15-20020a5d47af000000b0020c670150bemr3602958wrb.148.1651522783039;
        Mon, 02 May 2022 13:19:43 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 03/19] crypto: sun4i-ss: do not allocate backup IV on requests
Date:   Mon,  2 May 2022 20:19:13 +0000
Message-Id: <20220502201929.843194-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502201929.843194-1-clabbe@baylibre.com>
References: <20220502201929.843194-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of allocate memory on each requests, it is easier to
pre-allocate buffer for backup IV.
This made error path easier.
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 22 +++++++------------
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h  |  1 +
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index 8dc2a475c601..a8c784acce13 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -20,7 +20,6 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
 	struct sun4i_cipher_req_ctx *ctx = skcipher_request_ctx(areq);
 	u32 mode = ctx->mode;
-	void *backup_iv = NULL;
 	/* when activating SS, the default FIFO space is SS_RX_DEFAULT(32) */
 	u32 rx_cnt = SS_RX_DEFAULT;
 	u32 tx_cnt = 0;
@@ -47,10 +46,8 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	}
 
 	if (areq->iv && ivsize > 0 && mode & SS_DECRYPTION) {
-		backup_iv = kzalloc(ivsize, GFP_KERNEL);
-		if (!backup_iv)
-			return -ENOMEM;
-		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
+		scatterwalk_map_and_copy(ctx->backup_iv, areq->src,
+					 areq->cryptlen - ivsize, ivsize, 0);
 	}
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
@@ -133,8 +130,8 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 
 	if (areq->iv) {
 		if (mode & SS_DECRYPTION) {
-			memcpy(areq->iv, backup_iv, ivsize);
-			kfree_sensitive(backup_iv);
+			memcpy(areq->iv, ctx->backup_iv, ivsize);
+			memzero_explicit(ctx->backup_iv, ivsize);
 		} else {
 			scatterwalk_map_and_copy(areq->iv, areq->dst, areq->cryptlen - ivsize,
 						 ivsize, 0);
@@ -198,7 +195,6 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	unsigned int ileft = areq->cryptlen;
 	unsigned int oleft = areq->cryptlen;
 	unsigned int todo;
-	void *backup_iv = NULL;
 	struct sg_mapping_iter mi, mo;
 	unsigned long pi = 0, po = 0; /* progress for in and out */
 	bool miter_err;
@@ -242,10 +238,8 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 		return sun4i_ss_cipher_poll_fallback(areq);
 
 	if (areq->iv && ivsize > 0 && mode & SS_DECRYPTION) {
-		backup_iv = kzalloc(ivsize, GFP_KERNEL);
-		if (!backup_iv)
-			return -ENOMEM;
-		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
+		scatterwalk_map_and_copy(ctx->backup_iv, areq->src,
+					 areq->cryptlen - ivsize, ivsize, 0);
 	}
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_SUN4I_SS_DEBUG)) {
@@ -382,8 +376,8 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	}
 	if (areq->iv) {
 		if (mode & SS_DECRYPTION) {
-			memcpy(areq->iv, backup_iv, ivsize);
-			kfree_sensitive(backup_iv);
+			memcpy(areq->iv, ctx->backup_iv, ivsize);
+			memzero_explicit(ctx->backup_iv, ivsize);
 		} else {
 			scatterwalk_map_and_copy(areq->iv, areq->dst, areq->cryptlen - ivsize,
 						 ivsize, 0);
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
index 0fee6f4e2d90..ba59c7a48825 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
@@ -183,6 +183,7 @@ struct sun4i_tfm_ctx {
 
 struct sun4i_cipher_req_ctx {
 	u32 mode;
+	u8 backup_iv[AES_BLOCK_SIZE];
 	struct skcipher_request fallback_req;   // keep at the end
 };
 
-- 
2.35.1

