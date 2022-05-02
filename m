Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922435177EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387361AbiEBUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387318AbiEBUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0032DF41
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so197462wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7Xtal5iImj+Z51acJrJe79yB1r8z7s4am9aOqW5Wb8=;
        b=TYO8UR3UezMgzO0rfp1BJKTfy2y89Vk6AjNPv0Dgo6jr/ccEobuzl/+QmY6SXe8N8z
         +89fsh+aUNOxZaIxqQWH0+dMhPdbIQfKpdq2U7/NHmCXbhuHhTr85rP1+IWvRfzmWiov
         4k/0cRveDPbLjHsqJNy/7DjDCidELdxWLljS+VasJkl3RLjUbIUtttKe+lYi0kw2Nd2B
         69KsRwbgqvhx6/U9DS+AYkCllLuxPh4amIESu45mT5iMrwOlr3QGBYKXWVl2ddV9cD+3
         771NBhzu0f3NqbefCed6v7WRLPBAfizOZR8/N104ggNY/4gbRezYvV48VsbLeQ9vqHwH
         unoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7Xtal5iImj+Z51acJrJe79yB1r8z7s4am9aOqW5Wb8=;
        b=zVmBan+kjG0hTQfmW0FAOJED71vRBRrJet0EwSCxgTcKyRQh4u7s3lNtXjW5Toctx9
         t+tmdPfG3DgVf3Cnwjwzw+PsRkBcvoPDmow+DiTQwhbFzmMZBQ33eDnx6ou8gzaRV5VA
         bfpcJU6q3Kl7XxLaBVaqteRHFDFEv9RjC/bhmW9ibHCs22c5m7/PHVO/nI+tn1kpP/EW
         uqLBVhkZTMo48VBczYMScEpDZy7av8bQLsvBfYNPonKOqLBHApb2gXc/nGobpzjJzDJw
         vCvtXss/jm5b9IF2wQnCkdnN7m22r2TdcsLMqw/X7MMBqNI5zSHJGX02L3FEvzZfNcmZ
         ZBSA==
X-Gm-Message-State: AOAM5322vTWVdz9dj1mEIy2n4J84nSEZ64DxLHOOcTFw5VBL4GgmsMPM
        NS5z2LuPsgPk4Q50mxpGyynsUw==
X-Google-Smtp-Source: ABdhPJwPj7ya0ul9Pb7RjiDxC4/249zRQPxN5ij1KoY2SJztutO6o887eeZLU0sjR6MRJTI0eI7p8Q==
X-Received: by 2002:a05:600c:601d:b0:393:fbe9:3596 with SMTP id az29-20020a05600c601d00b00393fbe93596mr577879wmb.141.1651522786075;
        Mon, 02 May 2022 13:19:46 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 06/19] crypto: sun8i-ss: remove redundant test
Date:   Mon,  2 May 2022 20:19:16 +0000
Message-Id: <20220502201929.843194-7-clabbe@baylibre.com>
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

Some fallback tests were redundant with what sun8i_ss_hash_need_fallback() already do.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index ca4f280af35d..eaa0bbaf5581 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -288,21 +288,11 @@ int sun8i_ss_hash_digest(struct ahash_request *areq)
 	struct sun8i_ss_alg_template *algt;
 	struct sun8i_ss_dev *ss;
 	struct crypto_engine *engine;
-	struct scatterlist *sg;
-	int nr_sgs, e, i;
+	int e;
 
 	if (sun8i_ss_hash_need_fallback(areq))
 		return sun8i_ss_hash_digest_fb(areq);
 
-	nr_sgs = sg_nents(areq->src);
-	if (nr_sgs > MAX_SG - 1)
-		return sun8i_ss_hash_digest_fb(areq);
-
-	for_each_sg(areq->src, sg, nr_sgs, i) {
-		if (sg->length % 4 || !IS_ALIGNED(sg->offset, sizeof(u32)))
-			return sun8i_ss_hash_digest_fb(areq);
-	}
-
 	algt = container_of(alg, struct sun8i_ss_alg_template, alg.hash);
 	ss = algt->ss;
 
-- 
2.35.1

