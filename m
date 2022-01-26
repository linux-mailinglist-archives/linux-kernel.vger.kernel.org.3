Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3649D410
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiAZVFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiAZVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:04:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FCDC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d138-20020a1c1d90000000b0034e043aaac7so1969501wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQfQxPxFJ18OHZiKr+H6x2uvjjAUEJks7M+mZV0XyDU=;
        b=gI5EvP3Vb93EkxWs5/NGdIKIUHXcZ9cD9PdxdQ7AihS1mp1WTtquESrkQ6JOACLki7
         b2yp7STxQIt6XVZNAdkqGfgp+Lz/deN30PAjSTkDJl/MSHZLDhnBwPHPjpDB+t1qbsoN
         /3T5mHPFZmgSIkaDztl2MQfQto871u3/wf28GDMSsqYwmBdYWkQPqzZxA1n7iDQ6BJ2R
         RAe4PUYx4cn45hZeDcg6MRkKdyCcefKnagdZiyC32zANamTA1ve0rX2BC5g3wBrhqozr
         aW1epb7TiZPn/6GRVlyA6plsOHzrsfw5rr57aGhyuJWIHNE5hamLD6o5boZpoLi9gxN2
         zMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQfQxPxFJ18OHZiKr+H6x2uvjjAUEJks7M+mZV0XyDU=;
        b=7dTGDTLEBs36eN0QyB02KDERyArKZkRkT1EWbqEqXcLTVDa7EuTMkc+MZBgTHoJKJX
         lFVQTzgxyQsamBUh2QqnXAVBVIcVvOpfM/QJgscKqHgYkEoNoZbljn0O6jj6p4xz1Nnr
         n8mkv5dVUrotxqWpUKuBKweHF2EZxAiisFaEztDeQENFa8KA9eaLY8tGsWtlLIZTCZch
         yUDuCxAec3M20Rm8ZBuD4zbeIjAzE/tOKTtRyX/HxiogVssXHvj3WEDntrk7+V0TdxXy
         up7OZ6JRP0+bSS8xY/YOJOl3KiGkehd3qL3LO9X5TcXL8xrf9PMSXgf8PNkf6JKEfxwk
         u7uw==
X-Gm-Message-State: AOAM530iZQ8Tr0HWJ6vwvCsCcQUW4fK6YF5vgl98n9MPh6Ji5D2kcODS
        W/Ky5Uckr/DWLxyMk0BTekPHHw==
X-Google-Smtp-Source: ABdhPJz0wDzZ/chLZNIXRRbPWQZRsRz89OXrDdMn3YyXcTITc7q8YpCcfv3JsZnHYnOX78ChNWqaVw==
X-Received: by 2002:a05:600c:1c16:: with SMTP id j22mr480719wms.60.1643231091453;
        Wed, 26 Jan 2022 13:04:51 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j19sm4948611wmq.17.2022.01.26.13.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:50 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/8] crypto: sun4i-ss: do not allocate backup IV on requests
Date:   Wed, 26 Jan 2022 21:04:35 +0000
Message-Id: <20220126210441.3661782-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126210441.3661782-1-clabbe@baylibre.com>
References: <20220126210441.3661782-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.34.1

