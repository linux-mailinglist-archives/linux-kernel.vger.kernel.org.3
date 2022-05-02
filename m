Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D8517804
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386612AbiEBUZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387338AbiEBUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD0DF7D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so20906191wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mg7+JDCCGco+e4GPVsYAzBNoWm3/Kgnpe9n7FdTc3i4=;
        b=TLBu1j5ncN/Jn6oml7fVC6B8xeoInjCp0ETOpxy5+1E5f9S460WfLpJCCUFoOENHHi
         LJoJDlr52k4al2Y1IkF4FjvOgZ72Atw7nAH14noV21l2xdejCujFxKMVP+TFCkNHINyz
         D0pMkc5DPJ2QVi7jbUoaqZxo6MaqpI+67fWS5ITLwVmTBrVrs+Qf63P6nmAKg4JuYXIx
         xlEuUSZlQr/OtSRCuSUAug5vCUNzBHPdvXwfLBzii1//qa6peQv3AM82k4V+Unq1QB00
         X37XC2aVKmRfs3T43YgoiH7dZYKN8exWoC9Na9qFdN5aNfp3nznDaKhZoipr/q2qxGD+
         HO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mg7+JDCCGco+e4GPVsYAzBNoWm3/Kgnpe9n7FdTc3i4=;
        b=t2heJgtrgnmNEQLdcj3Xjzyj0YQVDGGoXnIv4UG2t12PTdlSukDHTDMOB9uCb9WeU+
         zzx6h98oqLcK0uqJJ+Eqd/HHA4rsgimAjqGO9MIQsZP5aw8jrfGAwFesQxbrQek1mvsW
         oHCeeKzj9k7CJH4EKa1Yr42lOa/N1kGH1Io9mcAq/D/Bc2AozPYBg2iP0aVP7Si/a30d
         fVZ3XzBtaCRl3AsFW6Wu0j8M/k/qVx6sfxpD7/Jr8W70+tksY6Lmsox9wNIIFf3q1kWY
         NsVL26zJorJz4QmEw+PdT65JEUUz0Oczcp21flzp4mEhiO9hLNwzvyXplONMFrYroyK8
         eXBQ==
X-Gm-Message-State: AOAM532oGkiuoJ86o2pXNNgWoPV5xx2PbXTKc02l0aRSGRGhAMjvXCq1
        TPfHEMffym7GNYBoQnPyRsYkxQ==
X-Google-Smtp-Source: ABdhPJwKdiIeYcermo7ePCeyaCT8ZpEZzu4r0d8ohBUa7YMuJ53K+SikREyLUqDCe/Abymt4Bmb9Zw==
X-Received: by 2002:a05:6000:10a:b0:20a:e2aa:6848 with SMTP id o10-20020a056000010a00b0020ae2aa6848mr10234337wrx.464.1651522790383;
        Mon, 02 May 2022 13:19:50 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:49 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 10/19] crypto: sun8i-ss: do not zeroize all pad
Date:   Mon,  2 May 2022 20:19:20 +0000
Message-Id: <20220502201929.843194-11-clabbe@baylibre.com>
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
2.35.1

