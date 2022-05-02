Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20B05177FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387655AbiEBUYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387295AbiEBUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D6DF71
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so11053366wrn.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6ojxrJ3JCDmwxgYcuW8Z/fCHj7C/NmFL+u5RXlbqHM=;
        b=2FMw48hoq0iT1baIfYW3+6fIqjJC8ILqaei+4p/aWkOmUC6pxdgGS/UxezQKrGwpu5
         JwVxOFwImw3lTFUamfirSvwyvKtxdNr41V5jV8SijHt24Kxd113u5eRrL1i4z+dKu5+l
         YCXOJkIVtSjnO4/b9OH+kWMVcG2s5W1vU8YOQvSDPk2OZiRGR4MykMYQV9yIbT1KrAfY
         Mth6Wcucdp/DrhUyd6QVl9HrbIHKvymqvJ7ubgyScll5XzcOCDR1mExqEijO99DjJyue
         Z0/KExvA/HUj6OzgeHznlHDsYBr2Si9JUFxqXy1l1rZg+TDMKRhdoNddMiN/tAla9W1w
         43IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6ojxrJ3JCDmwxgYcuW8Z/fCHj7C/NmFL+u5RXlbqHM=;
        b=lasz6a8qmPkDpQqhctgdDwNLkZJvUGr8y5ow0ZyS2fMXLTH0svPn1f+lo6H4DVye6s
         TVtZg3MKIFdWwLITcUTEAx4UExhMlRh60EB437cPYcWf7jFSbjzuy+UaonpTKrbzvmxd
         In0m/doPSTTJvfwxXkhOvpWCz4YEzsX74w4bI91qKqUECQaeBXYdsgq+z1wOYzpiUTav
         8Y4cFDku71L0EtL3ATRZjlwm7KlrfRqV5YqMHyASX9LnmvO1vdTg9HqNOMFMOP8LkYoo
         E4UWf6/d5A38TkOfvE0LaA5LKzwGaItr1HKkiPeaqtOyLuhsumfeZkbFHVTOiA86aDqt
         5GPw==
X-Gm-Message-State: AOAM532I1JUBy5zaj7E8vQnDkTuiLy2whr3vLScDlDzNuzCA4jKN8XsH
        Ov7h2JWBUWfCvU7iAehjyz6Dig==
X-Google-Smtp-Source: ABdhPJxbumqnLOpEvOC4qOx+9lGvPoJ59aLRGJaRDccVXsB9zQ/0pYEU5eQJGSeVtgZ3fUVJ7fonIg==
X-Received: by 2002:adf:e112:0:b0:206:d12:9c3a with SMTP id t18-20020adfe112000000b002060d129c3amr10160404wrz.391.1651522789323;
        Mon, 02 May 2022 13:19:49 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 09/19] crypto: sun8i-ss: do not allocate memory when handling hash requests
Date:   Mon,  2 May 2022 20:19:19 +0000
Message-Id: <20220502201929.843194-10-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502201929.843194-1-clabbe@baylibre.com>
References: <20220502201929.843194-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of allocate memory on each requests, it is easier to
pre-allocate buffers.
This made error path easier.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 10 ++++++++++
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 15 +++------------
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h      |  4 ++++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 657530578643..786b6f5cf300 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -486,6 +486,16 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 				goto error_engine;
 		}
 
+		/* the padding could be up to two block. */
+		ss->flows[i].pad = devm_kmalloc(ss->dev, SHA256_BLOCK_SIZE * 2,
+						GFP_KERNEL | GFP_DMA);
+		if (!ss->flows[i].pad)
+			goto error_engine;
+		ss->flows[i].result = devm_kmalloc(ss->dev, SHA256_DIGEST_SIZE,
+						   GFP_KERNEL | GFP_DMA);
+		if (!ss->flows[i].result)
+			goto error_engine;
+
 		ss->flows[i].engine = crypto_engine_alloc_init(ss->dev, true);
 		if (!ss->flows[i].engine) {
 			dev_err(ss->dev, "Cannot allocate engine\n");
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 49e2e947b36b..9582ac450d08 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -332,18 +332,11 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	if (digestsize == SHA224_DIGEST_SIZE)
 		digestsize = SHA256_DIGEST_SIZE;
 
-	/* the padding could be up to two block. */
-	pad = kzalloc(algt->alg.hash.halg.base.cra_blocksize * 2, GFP_KERNEL | GFP_DMA);
-	if (!pad)
-		return -ENOMEM;
+	result = ss->flows[rctx->flow].result;
+	pad = ss->flows[rctx->flow].pad;
+	memset(pad, 0, algt->alg.hash.halg.base.cra_blocksize * 2);
 	bf = (__le32 *)pad;
 
-	result = kzalloc(digestsize, GFP_KERNEL | GFP_DMA);
-	if (!result) {
-		kfree(pad);
-		return -ENOMEM;
-	}
-
 	for (i = 0; i < MAX_SG; i++) {
 		rctx->t_dst[i].addr = 0;
 		rctx->t_dst[i].len = 0;
@@ -439,8 +432,6 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 
 	memcpy(areq->result, result, algt->alg.hash.halg.digestsize);
 theend:
-	kfree(pad);
-	kfree(result);
 	local_bh_disable();
 	crypto_finalize_hash_request(engine, breq, err);
 	local_bh_enable();
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 57ada8653855..eb82ee5345ae 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -123,6 +123,8 @@ struct sginfo {
  * @stat_req:	number of request done by this flow
  * @iv:		list of IV to use for each step
  * @biv:	buffer which contain the backuped IV
+ * @pad:	padding buffer for hash operations
+ * @result:	buffer for storing the result of hash operations
  */
 struct sun8i_ss_flow {
 	struct crypto_engine *engine;
@@ -130,6 +132,8 @@ struct sun8i_ss_flow {
 	int status;
 	u8 *iv[MAX_SG];
 	u8 *biv;
+	void *pad;
+	void *result;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
 	unsigned long stat_req;
 #endif
-- 
2.35.1

