Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536994DCFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiCQU6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiCQU5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB417155B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p26so2660714wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtchaM94YM1VegqN4dLecw9vdPFGdK2+AK0IlUyWGNM=;
        b=JN6BCT/TB8P/cEYVkNRv0NhaugkXmtIe5kGi2WExIn1h+G6U+AJ32Ez9/RCgHRmLDp
         M5MJzJF1yDdVggt8Rtc2aZMhnJUNBTAVxK4oxU/7RmJz05sp3tZvnC1turEOgiQND5/r
         raLEo3avhyafqd38eMMEchgMaR5rAMvHjDgxtVR6VFtwQHDimutOS19Uba4PF+fHs43L
         jke6YmhRH3t6gRfVks5PXcu1eJmUkHdowWOlxMBo3s9PAdjmfml0r+vjGhQUyvfU+dK7
         O+weVl89dQCQjMjLevV2YMXaK5qeEzZAtx99qziy3hEKAtduHcHlsqp7NU2fFW/IAqXN
         8oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtchaM94YM1VegqN4dLecw9vdPFGdK2+AK0IlUyWGNM=;
        b=hyOUtOJgbZyzVt2AQN6a+7A7e/rD9yANl5IcMuDNbrdh73ydPssWudNzzHkMeQtS/Q
         tBWAm7WFnILXBdkIFIW2aVeXSTCvPCyqPo4WlQp9vTk7zBBwJlyqlYEBEbGC/hoad++U
         Uq0r+/hEuEdpZqVPE/YlVKQvfivCKqesjh+JCIR04TqU1l793wKRAdm4cDyPZg/thQLJ
         tXu6plZQjNW1cVAtdQ52kACIytEgNpoxJvOean8VF7ryMH3e6mHMR8tj37TbvQB+1Rnt
         4g+T0EsQIydVDchZ8v6Pnt9p3nI+uWA5VuVp+b9ATLC/Wi+4evz4r4gDKssCs2DTBRPD
         HOpQ==
X-Gm-Message-State: AOAM532ps1ie1bDlizO4dlqNghaeAl8OTjATtQ7cyYVM9Zp/31F1nK4i
        CllUnAtMPnhjD5PIpQLTfTLYyQ==
X-Google-Smtp-Source: ABdhPJzf9ed7YPOo1pNtfYfn4ilwHvwd9wFs/snO9PWNIXdQ873daopcr6dF4eMoUCC6IGWn/3++cw==
X-Received: by 2002:a1c:f719:0:b0:381:ba:5247 with SMTP id v25-20020a1cf719000000b0038100ba5247mr5731291wmh.183.1647550578428;
        Thu, 17 Mar 2022 13:56:18 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r4-20020a05600c35c400b00389f368cf1esm3695424wmq.40.2022.03.17.13.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 13:56:18 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 10/19] crypto: sun8i-ss: do not zeroize all pad
Date:   Thu, 17 Mar 2022 20:55:56 +0000
Message-Id: <20220317205605.3924836-11-clabbe@baylibre.com>
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

Instead of memset all pad buffer, it is faster to only put 0 where
needed.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 9582ac450d08..53e5bfb99c93 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -319,7 +319,7 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	unsigned int len;
 	u64 fill, min_fill, byte_count;
 	void *pad, *result;
-	int j, i, todo;
+	int j, i, k, todo;
 	__be64 *bebits;
 	__le64 *lebits;
 	dma_addr_t addr_res, addr_pad;
@@ -334,7 +334,6 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 
 	result = ss->flows[rctx->flow].result;
 	pad = ss->flows[rctx->flow].pad;
-	memset(pad, 0, algt->alg.hash.halg.base.cra_blocksize * 2);
 	bf = (__le32 *)pad;
 
 	for (i = 0; i < MAX_SG; i++) {
@@ -395,7 +394,10 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	if (fill < min_fill)
 		fill += 64;
 
+	k = j;
 	j += (fill - min_fill) / sizeof(u32);
+	for (; k < j; k++)
+		bf[k] = 0;
 
 	switch (algt->ss_algo_id) {
 	case SS_ID_HASH_MD5:
-- 
2.34.1

