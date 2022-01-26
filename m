Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0149D40C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiAZVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiAZVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:04:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56860C061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso4568973wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buaazu1WrMDzlwPQHqm8IQrYu7KI8/m+gyfaMuk4eCE=;
        b=1A4bnZJMdAQkBvC7PZ9mskNXQQhnZE6VRNKHHrWqzWuGTS1Z16M0qFlCtl/SufBbX6
         ju7zpaQvvPl6/6yYxzVAG0qOGzlZEII7AF3FnhhTi8gxB2bibYzmW8UAoccwQyy+q2tQ
         nk3Y4gy280Pf5xsbL9gjfo7lTPTwpKmR3lYhx3vr2TS5qr61thhOlWKFDo4Nx4rbZQ4C
         mW8yQ9Hi+dQ6D8GfzdecOb6Dj2uvVs2GVkILNRnWPDyo2JaeDSd8sF+fP/NVnpwKGGUC
         vrEG0Hrce98hI4JJCkrSa3eKAmWNBmBsu70WuYFLzr7bX/qaa8EBe3iAGVn/Uc6wQ0OE
         H07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buaazu1WrMDzlwPQHqm8IQrYu7KI8/m+gyfaMuk4eCE=;
        b=WTyKSemPHu/3yoRynDgyxfgCQh0yaqHRWa9fLrgR9vsbMmOP7UfyFssHEsq91lPBOQ
         ryvQR5OwkLEmaNHDx1iZqKyAcQlqeXOb5wpVAr477LVYeAm7dkxM6Bf5+v8eACRFVmOQ
         hnaQ2A90Q9pCWroWrgAg8mpmwByG0OfwSHBnhSMA00CczVk7q5yTqVLY9dI+TtC1rdhh
         BArQJeZ0bj6v55crWxh/40B+iNY58DfCUcGQ2qfgZbk5AmVDYg9dnGU9v8GUb0QP23Xe
         vrAQcg8LNwcAL1Jn3L/cOud8wl9aPRgZOm+mA4YVjQiKfOpqjdsLk65ojORTD/L/oQo9
         aQNA==
X-Gm-Message-State: AOAM532OZYHnjBRSJylDvi2FtsqZAAm9K7MjIcN/O6xI528yyzG6aAXD
        3MtuaAgjNyvrAeEMVZ6nYZ8QvA==
X-Google-Smtp-Source: ABdhPJwjF2ajoGSl2zYfi3anBFhjjlzUNBMG2st7gOW9X9MaMsEN3LPB/dFbwfDv5lsPqcizGI2x+w==
X-Received: by 2002:a05:600c:1e86:: with SMTP id be6mr8890155wmb.79.1643231094782;
        Wed, 26 Jan 2022 13:04:54 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j19sm4948611wmq.17.2022.01.26.13.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:54 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/8] crypto: sun8i-ss: do not zeroize all pad
Date:   Wed, 26 Jan 2022 21:04:38 +0000
Message-Id: <20220126210441.3661782-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126210441.3661782-1-clabbe@baylibre.com>
References: <20220126210441.3661782-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index f7a9578e87f7..ef3020bc9547 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -328,7 +328,7 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	unsigned int len;
 	u64 fill, min_fill, byte_count;
 	void *pad, *result;
-	int j, i, todo;
+	int j, i, k, todo;
 	__be64 *bebits;
 	__le64 *lebits;
 	dma_addr_t addr_res, addr_pad;
@@ -343,7 +343,6 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 
 	result = ss->flows[rctx->flow].result;
 	pad = ss->flows[rctx->flow].pad;
-	memset(pad, 0, algt->alg.hash.halg.base.cra_blocksize * 2);
 	bf = (__le32 *)pad;
 
 	for (i = 0; i < MAX_SG; i++) {
@@ -404,7 +403,10 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
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

