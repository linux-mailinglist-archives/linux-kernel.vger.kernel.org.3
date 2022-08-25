Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3E65A0A21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiHYHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiHYHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:24:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43187A1D1D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u15so29133608ejt.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aInweo0Jux9Z9X/Y92voM/oHOHIVny38ZqjCucXLbT4=;
        b=dHcksVUiA9w8htpClZRDhOaLNpL+9hSosMEXX2NfcokwunPW5A0onEIjv6IornTEKR
         ZBRez8/+vKN8ow12rGDC8Cyf33Zr/su0sWLGc5pQWvsKm7/nuk6IL7OKnFp6A5UBUGhM
         NAWalusSZMvgk5WN/1mwf+6kWcur5LW0CCY800Vos6J4tZBLjqiyTSzHcg1j/48klvbx
         lF+uhDYu+pHdxxgQaQsut9Hm+N/7nRDs6Tp0xIKbGtUePkAwzi7CtpyNDazJruIql6mn
         /t9b5Kiq6P1Pgp3hxDWY1CC4zHAI02LusVz0U9SRS3o6k0MEpl3DEAV+xAnjmt6lZMvP
         vOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aInweo0Jux9Z9X/Y92voM/oHOHIVny38ZqjCucXLbT4=;
        b=s8Dot4/39nAH8aGQI57nDtfe3q+/rU5j6lntrPR7IvSmswEcdU1GSsUevLWuK/dyRR
         aeiqWpklnGbxIJkyAzKTDJ9A6ZJt8W277i/iJc5CfUQzzndrXz7sb7v6dX0E8PMC26/2
         fcoUNmMw/VxshREGErcarPGDkwdIrqUc6AOUhII80lwqDq1ip1Cn+aMwlyTxmQfRSmd+
         i/FGpjVGzENbmW0Yj2ub5DAIIvm7SpaJPiTEtFW0+zhTpO2zWHIsMja7yvc82DGAlTmq
         RD0UzZRp+GHSWOJFgQnNgStAAiNernNfiXjg2IlBNxhf+ttewGMfk6+rEVGzBnPkReZd
         lZKg==
X-Gm-Message-State: ACgBeo0i0B/bdVX8qjIP8ySwzMJG3wNyislBPRyEaNtpJk/L7wmIydeQ
        tz0ytmHqXszHwei7h3oXxKTIHg==
X-Google-Smtp-Source: AA6agR67uUPcSw52bekJ7oYloatLLfSvLZ9X56mb9YEMr7qZprZW2YIlziZh4QccZOKqrqQPG/g5pw==
X-Received: by 2002:a17:906:6a2a:b0:73d:8246:f192 with SMTP id qw42-20020a1709066a2a00b0073d8246f192mr1584672ejc.507.1661412263665;
        Thu, 25 Aug 2022 00:24:23 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170907778c00b0073ce4abf093sm2032281ejc.214.2022.08.25.00.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:24:23 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] crypto: sahara: Fix error check for dma_map_sg
Date:   Thu, 25 Aug 2022 09:24:17 +0200
Message-Id: <20220825072421.29020-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825072421.29020-1-jinpu.wang@ionos.com>
References: <20220825072421.29020-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, it returns the number of
DMA address segments mapped (this may be shorter
than <nents> passed in if some elements of the scatter/gather
list are physically or virtually adjacent and an IOMMU maps
them with a single entry).

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 5de8875281e1 ("crypto: sahara - Add driver for SAHARA2 accelerator.")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/sahara.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 457084b344c1..bb71aac30e2c 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -487,13 +487,13 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 
 	ret = dma_map_sg(dev->device, dev->in_sg, dev->nb_in_sg,
 			 DMA_TO_DEVICE);
-	if (ret != dev->nb_in_sg) {
+	if (!ret) {
 		dev_err(dev->device, "couldn't map in sg\n");
 		goto unmap_in;
 	}
 	ret = dma_map_sg(dev->device, dev->out_sg, dev->nb_out_sg,
 			 DMA_FROM_DEVICE);
-	if (ret != dev->nb_out_sg) {
+	if (!ret) {
 		dev_err(dev->device, "couldn't map out sg\n");
 		goto unmap_out;
 	}
-- 
2.34.1

