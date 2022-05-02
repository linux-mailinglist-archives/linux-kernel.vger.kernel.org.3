Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3545177FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387368AbiEBUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387317AbiEBUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:23:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC4DF45
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:19:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p189so8824044wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxgERR4MmEJr2YW3s3P/BTJupqeCTylb9pEXfQax4lw=;
        b=y9aRNEd7zfN2JS9mk38MoQlzNlf7DQYJ5H03RA2P1GjLrY+bMQrVDZkhNC383mN+zT
         80rh7dcGxxGIUB++LJRqL0jb+jY4nZff7/fY02nRyfO5oB8OSMr+o4ykZXRjekjyAF8+
         T1U2FjDRoLxZ1z+75wjzDI5T3KAzMRBmB2x/m4Us6cjx0Tvf5eCZ4IqtXxWVF9b5RSqD
         rCM9CRC9eqasS4CpdR66cpm9oLNQImV7bauGRudAuN/wcs+jN9cFVqf7yIakgx3eH5V6
         YoEGFx6iDE5OvN+zdNhTIYLS9ByTLIMlg9ntHejUhIEuZOkK1Z1qT8oQ8N/BzQ1lzR+6
         Aj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxgERR4MmEJr2YW3s3P/BTJupqeCTylb9pEXfQax4lw=;
        b=D3RdO0CwyNtQ7JgI603MmJdCygZZa1txTO3XiQNa14DB0tDyzMaSN+KUfef/0lOtzL
         A+XR/TZu9RRO0z/W6Uvpu+BypXmKWpnXNE7rURswsX6+qS34m1JWdWgScLl4iK5EaDYY
         fH7IqiG3K5QttBE5p/DdmvYxY7w5wVobfT5tYbxGQweMo3zAw3LN+NgizYuCYcaPSomg
         kF+NhtnUsPoWC/fB62GYjQfyOIenMJqVmDiBrD4y03BqxoC/Z7qAgIPfUq3S3g7yYqF0
         0fcgYZ4DJ7xtVHQwwVt5QeB1OngqeROLBO1GdIm6yWLPtj9VpCTaUkNsQ1CYXx8sFRth
         IcXg==
X-Gm-Message-State: AOAM532NtP8bjrSkphiOgEQUU9Q/Ia2Oo9ikKh5SO3P5Eb1RLioNCCQ3
        ltGxXCb9b/b8frypJ7OqJq4TXA==
X-Google-Smtp-Source: ABdhPJwMx9QV+PjMyJ+evDOGZaUh+NusKzcSVINsVKDEeNYscfPWigPgNhrv8jmZYMZdbX1V2lUw2Q==
X-Received: by 2002:a05:600c:1e1d:b0:394:2183:e75c with SMTP id ay29-20020a05600c1e1d00b003942183e75cmr554373wmb.203.1651522787180;
        Mon, 02 May 2022 13:19:47 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l2-20020adfb102000000b0020c547f75easm7238183wra.101.2022.05.02.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:19:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        samuel@sholland.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 07/19] crypto: sun8i-ss: test error before assigning
Date:   Mon,  2 May 2022 20:19:17 +0000
Message-Id: <20220502201929.843194-8-clabbe@baylibre.com>
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

The first thing we should do after dma_map_single() is to test the
result.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index eaa0bbaf5581..49e2e947b36b 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -420,15 +420,15 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	}
 
 	addr_pad = dma_map_single(ss->dev, pad, j * 4, DMA_TO_DEVICE);
-	rctx->t_src[i].addr = addr_pad;
-	rctx->t_src[i].len = j;
-	rctx->t_dst[i].addr = addr_res;
-	rctx->t_dst[i].len = digestsize / 4;
 	if (dma_mapping_error(ss->dev, addr_pad)) {
 		dev_err(ss->dev, "DMA error on padding SG\n");
 		err = -EINVAL;
 		goto theend;
 	}
+	rctx->t_src[i].addr = addr_pad;
+	rctx->t_src[i].len = j;
+	rctx->t_dst[i].addr = addr_res;
+	rctx->t_dst[i].len = digestsize / 4;
 
 	err = sun8i_ss_run_hash_task(ss, rctx, crypto_tfm_alg_name(areq->base.tfm));
 
-- 
2.35.1

