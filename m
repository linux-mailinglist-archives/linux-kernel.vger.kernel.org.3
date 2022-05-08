Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF151EF34
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382874AbiEHTLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbiEHTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51067BF7E
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d5so16714182wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HcULCDUWUOb7zL9pkaT5teTJK7hgsOh6ToY9+UZMac=;
        b=8NgyOBgrf29vd+obhJNvgE6/+k6xvZTKqauWZrHZIxwR7gNlLjf14uG9Prvr2EOxgY
         /gqXcgfqCEp5c1KQUpYDNtgcNqhyUwI1Y2D2KgrKgt7YbwHSGKszt0ffP+stDMNd1Jui
         tV4lP7bFP7X3YAqadOWixpgqiZNgwN+QGdaTofJw16l5DdgphENhBKz4LBILsDfapSev
         +cOlxc4emLmgH9cOsq4AabNveDAo9mQLiE14/TpuXyYkgPuOGRVOCWOY2HMAziN0qRbe
         Oc/olfLiU0Egc53lk2WOcm7TijKrs2ZPFVFlm5PBozyOiPEmEIlQ7Oeh0bkRkhP021sm
         qWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HcULCDUWUOb7zL9pkaT5teTJK7hgsOh6ToY9+UZMac=;
        b=ujnOTKL/LIw8Uf6CAVMG687bRKptlqexO46zCW11dsKLFki6bQQHaaissXX+6p/zZM
         4Llg1M4Gi4ESeOuBwMN/KmYt3XKbMeU3fRy8LSWtA/a0lPYXj3ePWbwUYnVLItbVRour
         HOpmy7Y/AkVMtgrB97/v4GtWI8XVyuI00VcLxg5EmfbuF+x28MNOAwwrkevWBVUIVGaN
         s35ZdHB3R29mEw7UOe1G1TewwN+ySiNsA78wE+hDnzngAQOZdQj6o35Tq8OzvBHa6TA+
         3AuDdJvN3H4SwLYHZC8gwet3TTFo8xFhjcRJmcNqKQilNCUe5V+NeeYZ5d7AKjDVTLwT
         EY3A==
X-Gm-Message-State: AOAM530iQhPIXiWQg52AELDYirC9EtdK8LzoWuD4vO7+lL0AP7n+Axlx
        VrvL1m+Sy58UJX1ZEcFEQTgMsA==
X-Google-Smtp-Source: ABdhPJyXUfndJA3IiOkW+IQ2db9ggpZ1qHHw52Nbd2i/rcN+ItF3YiiH0otZhhTNABlg9zKO6bhW4A==
X-Received: by 2002:a5d:47a6:0:b0:20c:5f3d:44b8 with SMTP id 6-20020a5d47a6000000b0020c5f3d44b8mr10392956wrb.216.1652036437936;
        Sun, 08 May 2022 12:00:37 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:37 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 31/33] crypto: rockchip: rk_ahash_reg_init use crypto_info from parameter
Date:   Sun,  8 May 2022 18:59:55 +0000
Message-Id: <20220508185957.3629088-32-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
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

rk_ahash_reg_init() use crypto_info from TFM context, since we will
remove it, let's take if from parameters.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
index d1bf68cb390d..30f78256c955 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -78,12 +78,10 @@ static int zero_message_process(struct ahash_request *req)
 	return 0;
 }
 
-static void rk_ahash_reg_init(struct ahash_request *req)
+static void rk_ahash_reg_init(struct ahash_request *req,
+			      struct rk_crypto_info *dev)
 {
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(req);
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct rk_ahash_ctx *tctx = crypto_ahash_ctx(tfm);
-	struct rk_crypto_info *dev = tctx->dev;
 	int reg_status;
 
 	reg_status = CRYPTO_READ(dev, RK_CRYPTO_CTRL) |
@@ -281,7 +279,7 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
 		goto theend;
 	}
 
-	rk_ahash_reg_init(areq);
+	rk_ahash_reg_init(areq, rkc);
 
 	while (sg) {
 		reinit_completion(&rkc->complete);
-- 
2.35.1

