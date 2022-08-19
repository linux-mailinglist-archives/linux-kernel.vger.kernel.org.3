Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B259950A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346660AbiHSGJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbiHSGId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908D7220F7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w19so6976875ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=F5ABPES53yBnNM8KMYaOoJGq6EgoilQgsIQzRxOn8jI=;
        b=YF9RDOWfoLh1rKjWTYgYRo+wyiZASSeVrPh9Z70zeRcDdGmQB3lQT7MPFxJXHqlu+M
         osfBgwSm98SFRcW8wlbcC7vK6DmPb6aKRn5z/Ba0K+qEsnyMxYg1jcgWV/2UyxnAwnEQ
         MfGHH3SoCYX9kM1xEFBRZz8Agb6CqTD6RyOE2yaoiVP4theIZp9an+m8AbQDehTGukSB
         Mw1rEXirxBiuAaZdwCSx1VXbv8ye39ic9KrRi5ONSIGqKYv+5bYHnFf6XmZDwRcd9+p5
         eLj5546HBAkV+eB0IWBmdPR3FZ/FoBJM9JLkOtFcVcq4yhGfO9gnyqJDB5QpSv1uibdN
         CnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=F5ABPES53yBnNM8KMYaOoJGq6EgoilQgsIQzRxOn8jI=;
        b=xO0/ZKjcyQDxkK26uEbiuj/y+ba4fxz3vkZ5UGlAV9w75dxTR37pj9tsPuDCIuotfd
         3nGlblbEKvnpmUiJqXOowEWOsIOX4sHvXeXgUYCHNFCyNC1hYgjsOQijjbtNl6Rk8DkS
         jiUnuYbIB9THeuyOpTxVQqYT4cFYFfhKkW+XA5ZmsliAEQpVTzUVVOPeZLc+lvtKxAn1
         lTNuseIijO/0I/1eywkBItViQM2C8buHD+x+a/aThMhliUnYyVBZcYBbqQHzbqrP8qBl
         xQkMnix3trLzRTwzs+jWUGY9KGbR08H7hu4qAGOVvP4d6TLiStvrMTZLfAhXhV/OSO13
         lzKA==
X-Gm-Message-State: ACgBeo33iT18DwUs5LHLMaHS55F64x6ze1wLmKZ5ZXOCdwAg5zuW6R0O
        tctk0nN6j8iMd/3lXutwKmaNph16oF46TvNF
X-Google-Smtp-Source: AA6agR7vpe7XwFhB8bWIG6ZHamJs/kMyizsVnVvMQeylgjrGCsHiyms0BKMF09snW3nldFzq48Vd7A==
X-Received: by 2002:a17:906:8a55:b0:73b:d8ea:6c2b with SMTP id gx21-20020a1709068a5500b0073bd8ea6c2bmr3343732ejc.114.1660889299632;
        Thu, 18 Aug 2022 23:08:19 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:19 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH v1 10/19] crypto: amlogic: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:52 +0200
Message-Id: <20220819060801.10443-11-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

