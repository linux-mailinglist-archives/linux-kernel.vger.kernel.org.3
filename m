Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD959950C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbiHSGIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344867AbiHSGIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562D162F9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kb8so6993479ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Af+4xj435h7tYd148SgfWr1zA59+PnWfK6elz89ZgLM=;
        b=Xd8NAKNiubTfxSsUtmJumEPpCI6vYOF5EL7eEqsASLzToqEfPk6XzX5naT+z+HYz8I
         1w53N+2KRQhMMbNho1wRRAHnHctpEyn+ZAZ+My+y94GnQ5BUud/SCly6Wqagaak6riGw
         VJXb180ImFH4mR4mo9owoXe/iiPOaEVE/QR7+wSIyjKVsRC6G/DI8OyjSBRW5Ayh2bkn
         O1tiHylgbNmwwQh68r5Aw8twy4PJFSp+KXlV8SJ/KXety+QEl+w1NfyMTG+JMF9b+oyx
         jE0UjBp39Rp78xg0g9guNVRyW5aG3Fb4qMhoEcrZPddQOIZtkz1omaYtCVqpw/Z4oEwE
         JWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Af+4xj435h7tYd148SgfWr1zA59+PnWfK6elz89ZgLM=;
        b=XZ5w1Vva6llrW+zAKbzofuKZ654lL/Fy9WhsLY/u7iSCIsFRPnyBdxCKEi6PvUupHi
         gtiXaVPeIFHCTUZC1z56Vl208fdQrrhfOJLJz97Bi0BffICEN6nWWzxQRBZMQeyyOSqB
         i93OqkrdsUcJ3vd/GXj8oA5xR3L+ePFCKHVVEwzsVtVFOUM68t3HOg0LMfHcSvhIFIBe
         fZyMoI8uMoRY+5/UgO2b11cUyJmNgV7s/XNOvnA0K8eFpwU7OXD2Q+bdTKbFkn+r+DQK
         VKJyQaj0B+V3svJJ3XxNRJJBFgxzcusgcGk0/uRF/qBG5aD5pnJsjXJahVhMuJTGlZDQ
         zxvQ==
X-Gm-Message-State: ACgBeo35Ah4HLLT/H6hoo0fUElaZO8UiCUgShQ1Uc69VEKzU5YdgVzr5
        lBPVpq6bVdGgv83qIhU00bFLgLfuLBrk+pyA
X-Google-Smtp-Source: AA6agR6s6z8H4PJAO2ZxVq5Iz7zKjhRBNrkLvhyCmREGjaDozeybRofTqZW61aHl+9y+8xWxNaWEhw==
X-Received: by 2002:a17:907:da2:b0:731:60e4:2261 with SMTP id go34-20020a1709070da200b0073160e42261mr3844241ejc.679.1660889292785;
        Thu, 18 Aug 2022 23:08:12 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:11 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 07/19] crypto: gemin: Fix error check for dma_map_sg
Date:   Fri, 19 Aug 2022 08:07:49 +0200
Message-Id: <20220819060801.10443-8-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

