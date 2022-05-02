Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6856517806
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387377AbiEBU0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387383AbiEBUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBA7DF2B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so20846222wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ev6VkzNd8mWajKtgoY5TumXP3duJOCaOdR600zP4Pxg=;
        b=Z/Lw+lnGWpcXrOZnRWxKzRVo+wFU5ra06ZgxPTSqzBJpOHO4n17m7KTCr4Sx3BrL+d
         tJ57TKr6ykabxjkBF0k95jGnlLgO1av4r8iBkp3STLbzb9iT+UfIrgGyrgUPtghKuxeM
         cBVI9as/TkxdOWs8UzlsbA1XGJ/NcA1zOvtFS3pqwr3aEE+UL251CJj0EsOKuLrMBWG4
         gH7ALbq1LlnlN0yVou8nVSpuXgc1U7JbrSdO9UHSVqQMN9aVtp3cw9NLqnrhafg2xsfa
         81Vz0of/NRXBdhbmufz0cZGNGHSvp+3MwmlYtsTq3GibiaRiMBRMcJKp/Uu2HUf5dDl1
         UjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ev6VkzNd8mWajKtgoY5TumXP3duJOCaOdR600zP4Pxg=;
        b=VOBRSn7l7IT16pHyFha0r57BhrY3CXWzzD9Kd0XYp4Wxop4/+2D5ytF2XBPsBc9CI6
         tZWK9vLufhNcRgEF37+8RYPTQ83Pn5cVdVIUpZL/+0XL/seFLc7EtgUT3u5SfnOu7mQd
         ZiVfILrhdSFDC1Q3zmNFL3wacjJcPq48G1WK5EIcwSz9gunKVvpedHWxETgkfUOq+NJO
         2Bj+8TTURsblzArQGyQNNDQk20xRByCEDAX0vfkbOD0XUP+gIhwCqIF5Yy9Hoz9bviMs
         ljqWJbXv6ykLla3pClm6E6haCSqIX2CXXe+ooMIQB3scnTDim9ezW7YFysBNDIEvcoQ1
         x2XQ==
X-Gm-Message-State: AOAM530vVAL9tUvew+1si0mP/Nhur97UNh52F1FjDaiETG3vSCLRvnp4
        f5oA529RaJAwE4pK1G2M/m7Mzg==
X-Google-Smtp-Source: ABdhPJyemTLSgoak6z+//F8uVgKbFZkCNOJ7AMgwijmSMkhH9eOY/9nZNrRffO5kHMaJB0L+fasVjA==
X-Received: by 2002:adf:d1c9:0:b0:203:c4f8:dd17 with SMTP id b9-20020adfd1c9000000b00203c4f8dd17mr10465301wrd.633.1651522793740;
        Mon, 02 May 2022 13:19:53 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:53 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 13/19] crypto: sun8i-ss: Add function for handling hash padding
Date:   Mon,  2 May 2022 20:19:23 +0000
Message-Id: <20220502201929.843194-14-clabbe@baylibre.com>
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

Move all padding work to a dedicated function.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 87 ++++++++++++++-----
 1 file changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index cb510ec21ec4..0db1e8253667 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -328,6 +328,64 @@ int sun8i_ss_hash_digest(struct ahash_request *areq)
 	return crypto_transfer_hash_request_to_engine(engine, areq);
 }
 
+static u64 hash_pad(__le32 *buf, unsigned int bufsize, u64 padi, u64 byte_count, bool le, int bs)
+{
+	u64 fill, min_fill, j, k;
+	__be64 *bebits;
+	__le64 *lebits;
+
+	j = padi;
+	buf[j++] = cpu_to_le32(0x80);
+
+	if (bs == 64) {
+		fill = 64 - (byte_count % 64);
+		min_fill = 2 * sizeof(u32) + sizeof(u32);
+	} else {
+		fill = 128 - (byte_count % 128);
+		min_fill = 4 * sizeof(u32) + sizeof(u32);
+	}
+
+	if (fill < min_fill)
+		fill += bs;
+
+	k = j;
+	j += (fill - min_fill) / sizeof(u32);
+	if (j * 4 > bufsize) {
+		pr_err("%s OVERFLOW %llu\n", __func__, j);
+		return 0;
+	}
+	for (; k < j; k++)
+		buf[k] = 0;
+
+	if (le) {
+		/* MD5 */
+		lebits = (__le64 *)&buf[j];
+		*lebits = cpu_to_le64(byte_count << 3);
+		j += 2;
+	} else {
+		if (bs == 64) {
+			/* sha1 sha224 sha256 */
+			bebits = (__be64 *)&buf[j];
+			*bebits = cpu_to_be64(byte_count << 3);
+			j += 2;
+		} else {
+			/* sha384 sha512*/
+			bebits = (__be64 *)&buf[j];
+			*bebits = cpu_to_be64(byte_count >> 61);
+			j += 2;
+			bebits = (__be64 *)&buf[j];
+			*bebits = cpu_to_be64(byte_count << 3);
+			j += 2;
+		}
+	}
+	if (j * 4 > bufsize) {
+		pr_err("%s OVERFLOW %llu\n", __func__, j);
+		return 0;
+	}
+
+	return j;
+}
+
 /* sun8i_ss_hash_run - run an ahash request
  * Send the data of the request to the SS along with an extra SG with padding
  */
@@ -342,11 +400,9 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	struct scatterlist *sg;
 	int nr_sgs, err, digestsize;
 	unsigned int len;
-	u64 fill, min_fill, byte_count;
+	u64 byte_count;
 	void *pad, *result;
 	int j, i, k, todo;
-	__be64 *bebits;
-	__le64 *lebits;
 	dma_addr_t addr_res, addr_pad;
 	__le32 *bf;
 
@@ -421,33 +477,20 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 		i--;
 
 	byte_count = areq->nbytes;
-	bf[j++] = cpu_to_le32(0x80);
-
-	fill = 64 - (byte_count % 64);
-	min_fill = 3 * sizeof(u32);
-
-	if (fill < min_fill)
-		fill += 64;
-
-	k = j;
-	j += (fill - min_fill) / sizeof(u32);
-	for (; k < j; k++)
-		bf[k] = 0;
-
 	switch (algt->ss_algo_id) {
 	case SS_ID_HASH_MD5:
-		lebits = (__le64 *)&bf[j];
-		*lebits = cpu_to_le64(byte_count << 3);
-		j += 2;
+		j = hash_pad(bf, 4096, j, byte_count, true, bs);
 		break;
 	case SS_ID_HASH_SHA1:
 	case SS_ID_HASH_SHA224:
 	case SS_ID_HASH_SHA256:
-		bebits = (__be64 *)&bf[j];
-		*bebits = cpu_to_be64(byte_count << 3);
-		j += 2;
+		j = hash_pad(bf, 4096, j, byte_count, false, bs);
 		break;
 	}
+	if (!j) {
+		err = -EINVAL;
+		goto theend;
+	}
 
 	addr_pad = dma_map_single(ss->dev, pad, j * 4, DMA_TO_DEVICE);
 	if (dma_mapping_error(ss->dev, addr_pad)) {
-- 
2.35.1

