Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63844DCFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiCQU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiCQU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B0416CE64
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d7so9019107wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DfrP260y+jEAcpziyMQUGu1tL0r3DThT0S3Uk42ZRE=;
        b=X6CMwytAqz7jdPWfXo9j9PtD9ooTchYkz/BFk/J5ZD8MFLMr9+fePQaaLfqN+Kztnj
         b2IAZdkeCZEWQqj68GPcSgF26C0MXrPEmjxlF9xgHQzHh6Sp76sFjVAQqhyl+Fb6c8gu
         kwm6CfoIYMcILMWzV6fUVWzVFCEvAFGE04phATw8KrwY1/uuLl4ryeeRfniH59gVQd9i
         GWWPvhLsdh+v6Yze3a7bIYv3kLV7WTlGjisHBU6wTteCSE4fG7yhrJUD6TkCt4ZILs9A
         qkHYOAFvVPrh+U94yA3dR/9HMPI3uzrq8tB/jCSVDtze33/iBbHc0PusuPNgkHIzR33D
         NEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DfrP260y+jEAcpziyMQUGu1tL0r3DThT0S3Uk42ZRE=;
        b=YQAWS1VaVkVEgmneaRATA8GDDRJ0lTsIXxab55txIOWZeGOaQ+6Wz6ROfjEE6ez3sK
         OiBar2jAbyUE+qxXhSHF5GFbK2Y18LV9KH4xkuJQR9WaGXrjJD/+0qZWVUYlU4bPdj7E
         ZWv8T21SkgTrHzzqw2lylNzQsdZyUatRlNu3yGoJ+tY/Azdgu9gh9a8vFTHPl2lge6sY
         u2NonBAE8udIynVNdh2vvzBQul38ItXrdkFll8Wx2ivd2t+vjHCoI8Gf36fYOifl67b5
         eLu2wjoPEXb02wBqFAHscsxY6rb95LqKpXWHJJDBV4ari3rgK5/c3EXqs9rknovfRtnb
         pp7g==
X-Gm-Message-State: AOAM532Tclfm7ZibkHgqSn93DNrEYglJhVfr0ono2wbyhMDmFFeayccJ
        14a7xYFtJamWzcyNkuE+Rjy+QQ==
X-Google-Smtp-Source: ABdhPJx36EcM764FemJXg4W2iPycJ3xj1yxJn6h+Vm6/lQ59kFEYqX0lHJv0ULkmYWcDfR23RZviwA==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr5413939wre.711.1647550580008;
        Thu, 17 Mar 2022 13:56:20 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 12/19] crypto: sun8i-ss: rework debugging
Date:   Thu, 17 Mar 2022 20:55:58 +0000
Message-Id: <20220317205605.3924836-13-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317205605.3924836-1-clabbe@baylibre.com>
References: <20220317205605.3924836-1-clabbe@baylibre.com>
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

The "Fallback for xxx" message is annoying, remove it and store the
information in the debugfs.
In the same time, reports more fallback statistics.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ss/sun8i-ss-cipher.c      | 41 ++++++++++++++-----
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 21 ++++++++++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 36 ++++++++++++----
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  7 +++-
 4 files changed, 83 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index c4cb1ab1eeaa..7f1940c6cc41 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -22,35 +22,54 @@
 
 static bool sun8i_ss_need_fallback(struct skcipher_request *areq)
 {
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct sun8i_ss_alg_template *algt = container_of(alg, struct sun8i_ss_alg_template, alg.skcipher);
 	struct scatterlist *in_sg = areq->src;
 	struct scatterlist *out_sg = areq->dst;
 	struct scatterlist *sg;
 
-	if (areq->cryptlen == 0 || areq->cryptlen % 16)
+	if (areq->cryptlen == 0 || areq->cryptlen % 16) {
+		algt->stat_fb_len++;
 		return true;
+	}
 
 	if (sg_nents_for_len(areq->src, areq->cryptlen) > 8 ||
-		sg_nents_for_len(areq->dst, areq->cryptlen) > 8)
+		sg_nents_for_len(areq->dst, areq->cryptlen) > 8) {
+		algt->stat_fb_sgnum++;
 		return true;
+	}
 
 	sg = areq->src;
 	while (sg) {
-		if ((sg->length % 16) != 0)
+		if ((sg->length % 16) != 0) {
+			algt->stat_fb_sglen++;
 			return true;
-		if ((sg_dma_len(sg) % 16) != 0)
+		}
+		if ((sg_dma_len(sg) % 16) != 0) {
+			algt->stat_fb_sglen++;
 			return true;
-		if (!IS_ALIGNED(sg->offset, 16))
+		}
+		if (!IS_ALIGNED(sg->offset, 16)) {
+			algt->stat_fb_align++;
 			return true;
+		}
 		sg = sg_next(sg);
 	}
 	sg = areq->dst;
 	while (sg) {
-		if ((sg->length % 16) != 0)
+		if ((sg->length % 16) != 0) {
+			algt->stat_fb_sglen++;
 			return true;
-		if ((sg_dma_len(sg) % 16) != 0)
+		}
+		if ((sg_dma_len(sg) % 16) != 0) {
+			algt->stat_fb_sglen++;
 			return true;
-		if (!IS_ALIGNED(sg->offset, 16))
+		}
+		if (!IS_ALIGNED(sg->offset, 16)) {
+			algt->stat_fb_align++;
 			return true;
+		}
 		sg = sg_next(sg);
 	}
 
@@ -385,9 +404,9 @@ int sun8i_ss_cipher_init(struct crypto_tfm *tfm)
 			 crypto_skcipher_reqsize(op->fallback_tfm);
 
 
-	dev_info(op->ss->dev, "Fallback for %s is %s\n",
-		 crypto_tfm_alg_driver_name(&sktfm->base),
-		 crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)));
+	memcpy(algt->fbname,
+	       crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)),
+	       CRYPTO_MAX_ALG_NAME);
 
 	op->enginectx.op.do_one_request = sun8i_ss_handle_cipher_request;
 	op->enginectx.op.prepare_request = NULL;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 8d31fd4968f3..f09de5737e8b 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -430,6 +430,17 @@ static int sun8i_ss_debugfs_show(struct seq_file *seq, void *v)
 				   ss_algs[i].alg.skcipher.base.cra_driver_name,
 				   ss_algs[i].alg.skcipher.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
+
+			seq_printf(seq, "\tLast fallback is: %s\n",
+				   ss_algs[i].fbname);
+			seq_printf(seq, "\tFallback due to length: %lu\n",
+				   ss_algs[i].stat_fb_len);
+			seq_printf(seq, "\tFallback due to SG length: %lu\n",
+				   ss_algs[i].stat_fb_sglen);
+			seq_printf(seq, "\tFallback due to alignment: %lu\n",
+				   ss_algs[i].stat_fb_align);
+			seq_printf(seq, "\tFallback due to SG numbers: %lu\n",
+				   ss_algs[i].stat_fb_sgnum);
 			break;
 		case CRYPTO_ALG_TYPE_RNG:
 			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
@@ -442,6 +453,16 @@ static int sun8i_ss_debugfs_show(struct seq_file *seq, void *v)
 				   ss_algs[i].alg.hash.halg.base.cra_driver_name,
 				   ss_algs[i].alg.hash.halg.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
+			seq_printf(seq, "\tLast fallback is: %s\n",
+				   ss_algs[i].fbname);
+			seq_printf(seq, "\tFallback due to length: %lu\n",
+				   ss_algs[i].stat_fb_len);
+			seq_printf(seq, "\tFallback due to SG length: %lu\n",
+				   ss_algs[i].stat_fb_sglen);
+			seq_printf(seq, "\tFallback due to alignment: %lu\n",
+				   ss_algs[i].stat_fb_align);
+			seq_printf(seq, "\tFallback due to SG numbers: %lu\n",
+				   ss_algs[i].stat_fb_sgnum);
 			break;
 		}
 	}
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 1b44c1a115d6..cb510ec21ec4 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -51,9 +51,8 @@ int sun8i_ss_hash_crainit(struct crypto_tfm *tfm)
 				 sizeof(struct sun8i_ss_hash_reqctx) +
 				 crypto_ahash_reqsize(op->fallback_tfm));
 
-	dev_info(op->ss->dev, "Fallback for %s is %s\n",
-		 crypto_tfm_alg_driver_name(tfm),
-		 crypto_tfm_alg_driver_name(&op->fallback_tfm->base));
+	memcpy(algt->fbname, crypto_tfm_alg_driver_name(&op->fallback_tfm->base), CRYPTO_MAX_ALG_NAME);
+
 	err = pm_runtime_get_sync(op->ss->dev);
 	if (err < 0)
 		goto error_pm;
@@ -259,16 +258,29 @@ static int sun8i_ss_run_hash_task(struct sun8i_ss_dev *ss,
 
 static bool sun8i_ss_hash_need_fallback(struct ahash_request *areq)
 {
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
+	struct ahash_alg *alg = __crypto_ahash_alg(tfm->base.__crt_alg);
+	struct sun8i_ss_alg_template *algt;
 	struct scatterlist *sg;
 
-	if (areq->nbytes == 0)
+	algt = container_of(alg, struct sun8i_ss_alg_template, alg.hash);
+
+	if (areq->nbytes == 0) {
+		algt->stat_fb_len++;
 		return true;
-	if (areq->nbytes >= MAX_PAD_SIZE - 64)
+	}
+
+	if (areq->nbytes >= MAX_PAD_SIZE - 64) {
+		algt->stat_fb_len++;
 		return true;
+	}
 
 	/* we need to reserve one SG for the padding one */
-	if (sg_nents(areq->src) > MAX_SG - 1)
+	if (sg_nents(areq->src) > MAX_SG - 1) {
+		algt->stat_fb_sgnum++;
 		return true;
+	}
+
 	sg = areq->src;
 	while (sg) {
 		/* SS can operate hash only on full block size
@@ -276,12 +288,18 @@ static bool sun8i_ss_hash_need_fallback(struct ahash_request *areq)
 		 * is always 64
 		 */
 		/* Only the last block could be bounced to the pad buffer */
-		if (sg->length % 64 && sg_next(sg))
+		if (sg->length % 64 && sg_next(sg)) {
+			algt->stat_fb_sglen++;
 			return true;
-		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
+		}
+		if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
+			algt->stat_fb_align++;
 			return true;
-		if (sg->length % 4)
+		}
+		if (sg->length % 4) {
+			algt->stat_fb_sglen++;
 			return true;
+		}
 		sg = sg_next(sg);
 	}
 	return false;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 2e3524654aca..b56038de333b 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -279,11 +279,14 @@ struct sun8i_ss_alg_template {
 		struct rng_alg rng;
 		struct ahash_alg hash;
 	} alg;
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
 	unsigned long stat_req;
 	unsigned long stat_fb;
 	unsigned long stat_bytes;
-#endif
+	unsigned long stat_fb_len;
+	unsigned long stat_fb_sglen;
+	unsigned long stat_fb_align;
+	unsigned long stat_fb_sgnum;
+	char fbname[CRYPTO_MAX_ALG_NAME];
 };
 
 int sun8i_ss_enqueue(struct crypto_async_request *areq, u32 type);
-- 
2.34.1

