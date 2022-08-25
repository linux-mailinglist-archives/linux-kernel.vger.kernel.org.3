Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C125A0A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiHYHYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiHYHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:24:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF829A1D31
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u9so8825121ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=iP30pHrSfvf//uv6vYc2HV2OsHCadoMIEZDRU1K2e5k=;
        b=FjKuASlS49j208n5Kl+QlCP37BPbCoGM6O6BdIcVjegb3xtzbRMAldDlBrl197HM16
         Fho9RC/2JtNXq6ufUP5Iurkcey669vkstHxtp9gShG4Ta62xLiRwfsdMr/866Q8TaMim
         JeOG2VlimSO56CRUORP2VA/niecVlozajZudJTeY+e6+xZFUEQWulC3tAlK/OASog++P
         NjJ3hGUALqEODwHpDd+LRMDdBThWApmP6EdxybcUKJKh/FNzrqZw2AnGhAIKCcI8jfhj
         GktnUz0sKuHyPXM3MW3uIoFB2RINqvOvXHROGspI+r2vlvIgCg4qjmCbYOiWNIkwHOQl
         cijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=iP30pHrSfvf//uv6vYc2HV2OsHCadoMIEZDRU1K2e5k=;
        b=Qc0jFgqDHRbAFKEkif9qiomcq8zZQyCu0EiBUIZO6oyGEKM6gQUvdTCKgtQssMXKkZ
         aNp0DTc6G/+kTeWuODy2kxwAhSsosDae03SHfMn+/ZcERBHlEmb543+BiDMm33vo1F6k
         n/Ycy6Nr7LoJ2UvLYmHaT6JkEtWgCJ2wN2dqwRmJdiywFhF0t3jmR6C9Q4XS0cKPToqE
         8brIwHHarjtR9szB4Nd1mW9u6ANkBShFouKVpWOKNuHN7uBJUZeSsk5Roi/iLy8hQ+tG
         XdOtvKQN2QaSjJ7+3MctD6OKmN3Vrte7gGf9hjdFpVNOuMyJTq8gcpRKrj+9SDs7UcXU
         jSfg==
X-Gm-Message-State: ACgBeo2KdHO1arfmJfITTuV0sXSytFOkuV1s0OENtwBKUMtVQBmzlPBn
        gNm+ddx1RUj/OVhw9FkGVZrTpw==
X-Google-Smtp-Source: AA6agR5uR7pT04jGGk2tkZTpZwwm5LskjqagqLGYMahxhnEFlMFMyjKz901JuP7vFx67ULz8lckojw==
X-Received: by 2002:a17:906:846f:b0:73d:710b:357e with SMTP id hx15-20020a170906846f00b0073d710b357emr1603084ejc.103.1661412265367;
        Thu, 25 Aug 2022 00:24:25 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170907778c00b0073ce4abf093sm2032281ejc.214.2022.08.25.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:24:24 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] crypto: amlogic: Fix dma_map_sg error check
Date:   Thu, 25 Aug 2022 09:24:19 +0200
Message-Id: <20220825072421.29020-5-jinpu.wang@ionos.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 48fe583fe541 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index e79514fce731..af017a087ebf 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -177,7 +177,7 @@ static int meson_cipher(struct skcipher_request *areq)
 	if (areq->src == areq->dst) {
 		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
 				    DMA_BIDIRECTIONAL);
-		if (nr_sgs < 0) {
+		if (!nr_sgs) {
 			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend;
@@ -186,14 +186,14 @@ static int meson_cipher(struct skcipher_request *areq)
 	} else {
 		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
 				    DMA_TO_DEVICE);
-		if (nr_sgs < 0 || nr_sgs > MAXDESC - 3) {
+		if (!nr_sgs || nr_sgs > MAXDESC - 3) {
 			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend;
 		}
 		nr_sgd = dma_map_sg(mc->dev, areq->dst, sg_nents(areq->dst),
 				    DMA_FROM_DEVICE);
-		if (nr_sgd < 0 || nr_sgd > MAXDESC - 3) {
+		if (!nr_sgd || nr_sgd > MAXDESC - 3) {
 			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgd);
 			err = -EINVAL;
 			goto theend;
-- 
2.34.1

