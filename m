Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7E5A0A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbiHYHY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiHYHYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:24:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669BF9E2E7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so37769198ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4oX7Kz3MVV4hSXJmoV3BElc0F08jxmt7raiQQsmxayc=;
        b=MW5H/NNoqjJGKjOXPEUp6diJ0Ebk/7ve+sG3Vf+l0KuUBAvXz50GCgcJA7dHF9RJ/F
         YV/wOibDRkpDRz0sxjw3FI6zpSxqAJhGSdlI/poeQ1wGxShokSYfdqEa/N9SYMbHYltQ
         8aS3yEcIDE5WMl1gLsBxto2pvSbrnNxlrdczPsANNjjd0el6V17a15Kru2mtpPeAaIlq
         jkSt7scusL3g90qGNjr6AVdm+8+0TO+xzAz7a31PiMrRRq1SJ6r3Nez1lVaKTFkFn4uC
         eCrb+CCZFAk7kAOIu8uO3XWZecG+oZ4w8EoHj8P8lfNlPvUmj/bsNUsKsWVOA5XumtFe
         WGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4oX7Kz3MVV4hSXJmoV3BElc0F08jxmt7raiQQsmxayc=;
        b=MQbycwuTg3+Bbs9VhoM8H1CA0pypVj+uZWSC84pGsy/AehPRoIa9u6S0aGaWQkP+im
         cL6tDwHxHp94yfbT0HKHzPuKW1Gf8Jt7Dh4JvfNcrHWsf61yz4rRbhPqNzEbbMmO7DWs
         xD8IMyXapxiHkxtonTEP028fT1GIr0YKv/L7iFsC3ooSJlWOew2Jn+IZmelWFo10v1AV
         bXwzpN65D8RPHG8ToGG8ClwsVyzNdTOWcmE/JhR81OKgmD7XafSZEF0srOzRYd/mkmiz
         G7yXkuaAGGahFwNsc/L6F95llWW/vY49xxyvhuHgEnGoGKApvNAE1u8IC9DLOEqtpuOn
         7b+w==
X-Gm-Message-State: ACgBeo1Q9+baqeM7IYQYN8cIJAHuTFrW3umxAbBWBLdmo1sNlUc2tzKz
        rWneWfdqC7m59XVNa5+dDfHPSw==
X-Google-Smtp-Source: AA6agR7lhsz5pWp2kpFfMDfBBKJfF6f8ewMsA/5Mzz4qzehyEEhDRGqQs7+PcOiIi+6aXE6zbycuUg==
X-Received: by 2002:a17:907:970b:b0:73d:5a29:959 with SMTP id jg11-20020a170907970b00b0073d5a290959mr1656893ejc.183.1661412262910;
        Thu, 25 Aug 2022 00:24:22 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170907778c00b0073ce4abf093sm2032281ejc.214.2022.08.25.00.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:24:22 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] crypto: gemin: Fix error check for dma_map_sg
Date:   Thu, 25 Aug 2022 09:24:16 +0200
Message-Id: <20220825072421.29020-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825072421.29020-1-jinpu.wang@ionos.com>
References: <20220825072421.29020-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error.

Cc: Corentin Labbe <clabbe@baylibre.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 46c5338db7bd ("crypto: sl3516 - Add sl3516 crypto engine")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/gemini/sl3516-ce-cipher.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/gemini/sl3516-ce-cipher.c b/drivers/crypto/gemini/sl3516-ce-cipher.c
index 14d0d83d388d..34fea8aa91b6 100644
--- a/drivers/crypto/gemini/sl3516-ce-cipher.c
+++ b/drivers/crypto/gemini/sl3516-ce-cipher.c
@@ -149,7 +149,7 @@ static int sl3516_ce_cipher(struct skcipher_request *areq)
 	if (areq->src == areq->dst) {
 		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
 				    DMA_BIDIRECTIONAL);
-		if (nr_sgs <= 0 || nr_sgs > MAXDESC / 2) {
+		if (!nr_sgs || nr_sgs > MAXDESC / 2) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend;
@@ -158,14 +158,14 @@ static int sl3516_ce_cipher(struct skcipher_request *areq)
 	} else {
 		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
 				    DMA_TO_DEVICE);
-		if (nr_sgs <= 0 || nr_sgs > MAXDESC / 2) {
+		if (!nr_sgs || nr_sgs > MAXDESC / 2) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend;
 		}
 		nr_sgd = dma_map_sg(ce->dev, areq->dst, sg_nents(areq->dst),
 				    DMA_FROM_DEVICE);
-		if (nr_sgd <= 0 || nr_sgd > MAXDESC) {
+		if (!nr_sgd || nr_sgd > MAXDESC) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
 			goto theend_sgs;
-- 
2.34.1

