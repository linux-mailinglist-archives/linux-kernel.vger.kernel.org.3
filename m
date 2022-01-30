Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09B64A3AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356791AbiA3XFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiA3XFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:05:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A74C061714;
        Sun, 30 Jan 2022 15:05:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k18so21937262wrg.11;
        Sun, 30 Jan 2022 15:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLIKePOeCome+/jrAOdUWZSwyKBM/SDtl/LP3yhDNYM=;
        b=e+clUAX4p9oBLGf9A96fySwmIAjAATRP3Dk8p8FHCvwn5kEVpadYL06GhUQQWY80aP
         4aMUnP1kuLXcH+z2S9ADV51gj/e5k4LxtC2X7g1GZldbToIcPZ+CqPVtZyS3VK0rXZBM
         k5FR3elkLENDFbp/Y0maydNFfjQK2k+DjUXvYhbz7Js2WHoAHiid7WnEw02r+YgDYEPc
         aam8aJkHEo2+YuyOtVy6NAiZmXpmq3rAuSAmjdsdGVdu6zuQiL7l9SbBIa5aMdDIPIq+
         HV2+wj6HCY58eaM27F6J9b13tGQ7Bn5Wyj64rFZH6f9Zo2VELoZS+ffV9QCC6iLqnCXN
         WOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLIKePOeCome+/jrAOdUWZSwyKBM/SDtl/LP3yhDNYM=;
        b=6geeyGu3basraW1lyk/YBxeWfWVzs/h29HXjOqhBJ/oKQXnK5BpYxAQSEXnMqNuZvp
         OfsxT/JbhYbfUC//E2JOhbE2vGr2tDg6r+ADOpoSqO78FlHrkDR+uDnH2c4P2gry3TlS
         NMpM7YIQNLuKYq23UkcUk08MrvG61JB+mSbzM2+jNUgi18o9KVsrciCVmLDYbg7KMCzN
         sdACRKA+Rr6yuBsiQJeS/bnJUU9Je+1A68MwgaYSgYUjtDZG9zbLUuTMSIRT09VNsQ2m
         BveKYGeMBuldcgiwB61YwKvx5Rp+aq2MJw6ETOvXk3VL0RZxDJ0GWAjxUYs+fALx7xpt
         rteg==
X-Gm-Message-State: AOAM532LFGZ7My9VVOWpZfekTODtIhm1n1ofO2VO7R2EmOQWGcuWX0u8
        ZVFJMJdSrUyaJ43Zi08xj00=
X-Google-Smtp-Source: ABdhPJzb62H0qxffVALn0pUgTOkkID2z8NicfA9VV7LoeIrQoDnLlzgP80EsDJmq7VA5ZU7+b3EBog==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr6185249wrn.284.1643583916962;
        Sun, 30 Jan 2022 15:05:16 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r2sm14226210wrz.99.2022.01.30.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 15:05:16 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Corentin Labbe <clabbe@baylibre.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: sl3516: remove redundant initializations of pointers in_sg and out_sg
Date:   Sun, 30 Jan 2022 23:05:15 +0000
Message-Id: <20220130230515.8338-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers in_sg and out_sg are being initialized with values that are
never read, they are being re-assigned the same values later on. The
initializations are redundant, remove them in preference to the later
assignments that are closer to when the pointers are being used.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/crypto/gemini/sl3516-ce-cipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/gemini/sl3516-ce-cipher.c b/drivers/crypto/gemini/sl3516-ce-cipher.c
index c1c2b1d86663..53e3fefb81de 100644
--- a/drivers/crypto/gemini/sl3516-ce-cipher.c
+++ b/drivers/crypto/gemini/sl3516-ce-cipher.c
@@ -23,8 +23,8 @@ static bool sl3516_ce_need_fallback(struct skcipher_request *areq)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
 	struct sl3516_ce_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
 	struct sl3516_ce_dev *ce = op->ce;
-	struct scatterlist *in_sg = areq->src;
-	struct scatterlist *out_sg = areq->dst;
+	struct scatterlist *in_sg;
+	struct scatterlist *out_sg;
 	struct scatterlist *sg;
 
 	if (areq->cryptlen == 0 || areq->cryptlen % 16) {
-- 
2.34.1

