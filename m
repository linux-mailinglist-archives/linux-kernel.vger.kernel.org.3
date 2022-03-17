Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4664DCFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiCQU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiCQU5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DBF1788F1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so5596020wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruXwUyP9Dpz+RWT2yY7JHASaIwDXhJOD3DSrvf8cm/M=;
        b=Dj8mOVRNdBIVMu1cfPCFvP0F1bqDUB69Wh+L5w6DOxCgL1+hO8ATqsOanDrFbkgCbj
         IdrT8D4gcvp1iQS6u0/MKX1cHHu9NX1nSYNQ/pagLI055MgYwr5X2EK4hOdP+rPp5MMM
         HP4OMMXOnJBAx5VwUaDrscHzXVix7jmvWdReUNIV/4S/n+lN6OgSkgdTd3KRBmNsoi+Z
         lu1BeFOEuyev9WII8WS2SHFQhcHged3RN6wwkXEp2NXvMkoaOCxNUj/vkGJg6i91OkZn
         oNU4zHuIvKgNriFGBTkM5m274YP7cBUARBZIK4nE5KfSoZ+1KDv5Ea6eZxLtzUDnwuJX
         v7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruXwUyP9Dpz+RWT2yY7JHASaIwDXhJOD3DSrvf8cm/M=;
        b=5qh69cOyAM/ZWwkkfIKLjM8KRsczs2NNbEBbM+X17z1okQ6iKI8N0bib6P6uIuPcRL
         Mf6pQgBegL51KonCagsdTfJi5qz8B1l8QnljMiu05xWh5O4zkOvvoRBCchPh5dXLj7QY
         OM6iSq5I+maPTcppC6ecK1D5ATSlU62HrLQNrI9z6qRAJIkrukH16TYks0D5IlEAGv5d
         85MXFr/A+2JDsiW5m+sjWA0PaQhq1smXLqc8Yw57VCt7D0KFyhOZsLvZW/5sYFrer2g1
         FvS5yucQnOyeWhDV9u+CjDiZOyjE4HgAl5grkT38C7u4A6+tgWsT1tDXLM8l5SE0obwr
         C1Xg==
X-Gm-Message-State: AOAM531lvvCjOeO9n/LCML7OP3xsA6M4JTciTdWLixEWMJ9EluKULwEp
        hR0liAdk1UAJT5DlzYFBh2Et3A==
X-Google-Smtp-Source: ABdhPJypwcaNDpLt4mcryk+m5fbQaZe+ynDzBvoPHmfRcrrpQ4cZfnFN0S6X/WudVUgNTSaFYswVvQ==
X-Received: by 2002:a05:600c:3d8b:b0:38c:7c68:42ef with SMTP id bi11-20020a05600c3d8b00b0038c7c6842efmr3631014wmb.14.1647550579223;
        Thu, 17 Mar 2022 13:56:19 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:18 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 11/19] crypto: sun8i-ss: handle requests if last block is not modulo 64
Date:   Thu, 17 Mar 2022 20:55:57 +0000
Message-Id: <20220317205605.3924836-12-clabbe@baylibre.com>
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

The current sun8i-ss handle only requests with all SG length being
modulo 64.
But the last SG could be always handled by copying it on the pad buffer.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |  2 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 35 ++++++++++++++-----
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h  |  2 ++
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 786b6f5cf300..8d31fd4968f3 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -487,7 +487,7 @@ static int allocate_flows(struct sun8i_ss_dev *ss)
 		}
 
 		/* the padding could be up to two block. */
-		ss->flows[i].pad = devm_kmalloc(ss->dev, SHA256_BLOCK_SIZE * 2,
+		ss->flows[i].pad = devm_kmalloc(ss->dev, MAX_PAD_SIZE,
 						GFP_KERNEL | GFP_DMA);
 		if (!ss->flows[i].pad)
 			goto error_engine;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 53e5bfb99c93..1b44c1a115d6 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <crypto/internal/hash.h>
+#include <crypto/scatterwalk.h>
 #include <crypto/sha1.h>
 #include <crypto/sha2.h>
 #include <crypto/md5.h>
@@ -262,6 +263,9 @@ static bool sun8i_ss_hash_need_fallback(struct ahash_request *areq)
 
 	if (areq->nbytes == 0)
 		return true;
+	if (areq->nbytes >= MAX_PAD_SIZE - 64)
+		return true;
+
 	/* we need to reserve one SG for the padding one */
 	if (sg_nents(areq->src) > MAX_SG - 1)
 		return true;
@@ -270,10 +274,13 @@ static bool sun8i_ss_hash_need_fallback(struct ahash_request *areq)
 		/* SS can operate hash only on full block size
 		 * since SS support only MD5,sha1,sha224 and sha256, blocksize
 		 * is always 64
-		 * TODO: handle request if last SG is not len%64
-		 * but this will need to copy data on a new SG of size=64
 		 */
-		if (sg->length % 64 || !IS_ALIGNED(sg->offset, sizeof(u32)))
+		/* Only the last block could be bounced to the pad buffer */
+		if (sg->length % 64 && sg_next(sg))
+			return true;
+		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
+			return true;
+		if (sg->length % 4)
 			return true;
 		sg = sg_next(sg);
 	}
@@ -361,6 +368,7 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 		goto theend;
 	}
 
+	j = 0;
 	len = areq->nbytes;
 	sg = areq->src;
 	i = 0;
@@ -369,12 +377,19 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 			sg = sg_next(sg);
 			continue;
 		}
-		rctx->t_src[i].addr = sg_dma_address(sg);
 		todo = min(len, sg_dma_len(sg));
-		rctx->t_src[i].len = todo / 4;
-		len -= todo;
-		rctx->t_dst[i].addr = addr_res;
-		rctx->t_dst[i].len = digestsize / 4;
+		/* only the last SG could be with a size not modulo64 */
+		if (todo % 64 == 0) {
+			rctx->t_src[i].addr = sg_dma_address(sg);
+			rctx->t_src[i].len = todo / 4;
+			rctx->t_dst[i].addr = addr_res;
+			rctx->t_dst[i].len = digestsize / 4;
+			len -= todo;
+		} else {
+			scatterwalk_map_and_copy(bf, sg, 0, todo, 0);
+			j += todo / 4;
+			len -= todo;
+		}
 		sg = sg_next(sg);
 		i++;
 	}
@@ -384,8 +399,10 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 		goto theend;
 	}
 
+	if (j > 0)
+		i--;
+
 	byte_count = areq->nbytes;
-	j = 0;
 	bf[j++] = cpu_to_le32(0x80);
 
 	fill = 64 - (byte_count % 64);
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index eb82ee5345ae..2e3524654aca 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -82,6 +82,8 @@
 #define PRNG_DATA_SIZE (160 / 8)
 #define PRNG_SEED_SIZE DIV_ROUND_UP(175, 8)
 
+#define MAX_PAD_SIZE 4096
+
 /*
  * struct ss_clock - Describe clocks used by sun8i-ss
  * @name:       Name of clock needed by this variant
-- 
2.34.1

