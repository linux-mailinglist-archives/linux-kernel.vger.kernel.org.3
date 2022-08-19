Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79259951E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346706AbiHSGJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbiHSGIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B52B1A3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r4so4436349edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MhAvXvgOuGSOVU+0SPcQuNTLcHtqNw2MpFIs8bOelUY=;
        b=f1tj4JkACZwBuG1Wd+y0k1B4j6b/vQPV1oCFLCsOqpOzuvijbn46KCd4KAXf/gvHeT
         XnpTd7mcqNqk5iwk1SY78oocOtcdS+Dq6qelGImkzEHazqVx1Y1P+k7knppAWoAoFsl5
         B5sK2IXanUQbA5/cLSBhvAO397/VqKN6N1xRxmopNPjByZqJxc/zUhyAko0OLnMZtJb+
         Mu5E9sw6kXxGG9G9C6si7nPick00J5XPuXyCaSuzub0JlHbPgwoVJyEOeXJ63uqBMJJ+
         /yrQud7vigK7bG19ieiUVjWP5H+YBFHkYoVdPD1O0xNPcGOJ0cu8KcZpNdA4Dqi9WG/Y
         aXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MhAvXvgOuGSOVU+0SPcQuNTLcHtqNw2MpFIs8bOelUY=;
        b=udiFeMhVDbiTUbosbvnkFhzMZZr71+kkY9E0zURwSMud24P7RqcfP2j2s1IsDD0v+o
         SqvskM2mPsppPSNjk6PDckiq03y/NRZzaHzFZ45/Bx99F7x43rU/zxnn9iFhmkB9L9/x
         0BQjoLt548lg4lhsI1R95l24cHJ3xPUkmgoFCjA9tV/y1+jSRNORafeNxMvXckAaZDhE
         req5pSezl4sfV+ZQWrqaPwt+W46TC+T73fXyAzRIhW2av0OEUBtbMbsJeoUQew5md4vo
         pZy/LDCXkMfsuLPjBIPLL68g/Gs3EpYlQV/A4TC+UYOwDpo3fJxwdTDcsW4Zohy3VObh
         WYtQ==
X-Gm-Message-State: ACgBeo1LZu2Y6DsBvhi5GJvOPlgh88yBCO0Bu02IE71Tm9T7cDeF9WMN
        Nf500wf6FdoMGT0x3SCMTXs1rL5hUY5uUxp7
X-Google-Smtp-Source: AA6agR45x+III0utWJMPQr/7+FfJG2j+q5Z9JwzMPorUnxjE8X9vtPiF+PHoDO1FO0i+zG5jcgjANA==
X-Received: by 2002:a05:6402:27c6:b0:43d:6fab:146e with SMTP id c6-20020a05640227c600b0043d6fab146emr4785049ede.376.1660889301413;
        Thu, 18 Aug 2022 23:08:21 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:20 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Peng Wu <wupeng58@huawei.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v1 11/19] crypto: allwinner: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:53 +0200
Message-Id: <20220819060801.10443-12-jinpu.wang@ionos.com>
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

Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Minghao Chi <chi.minghao@zte.com.cn>
Cc: Peng Wu <wupeng58@huawei.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-crypto@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 6 +++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c   | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 4 ++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 74b4e910a38d..be7f46faef7e 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -208,7 +208,7 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 
 	if (areq->src == areq->dst) {
 		nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_BIDIRECTIONAL);
-		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+		if (!nr_sgs || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
@@ -216,13 +216,13 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 		nr_sgd = nr_sgs;
 	} else {
 		nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
-		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+		if (!nr_sgs || nr_sgs > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
 		}
 		nr_sgd = dma_map_sg(ce->dev, areq->dst, nd, DMA_FROM_DEVICE);
-		if (nr_sgd <= 0 || nr_sgd > MAX_SG) {
+		if (!nr_sgd || nr_sgd > MAX_SG) {
 			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
 			goto theend_sgs;
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
index 8b5b9b9d04c3..0e6843ec197f 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -389,7 +389,7 @@ int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq)
 	cet->t_asym_ctl = 0;
 
 	nr_sgs = dma_map_sg(ce->dev, areq->src, ns, DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+	if (!nr_sgs || nr_sgs > MAX_SG) {
 		dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
 		err = -EINVAL;
 		goto theend;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 910d6751644c..fdcc98cdecaa 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -232,13 +232,13 @@ static int sun8i_ss_cipher(struct skcipher_request *areq)
 		nr_sgd = nr_sgs;
 	} else {
 		nr_sgs = dma_map_sg(ss->dev, areq->src, nsgs, DMA_TO_DEVICE);
-		if (nr_sgs <= 0 || nr_sgs > 8) {
+		if (!nr_sgs || nr_sgs > 8) {
 			dev_err(ss->dev, "Invalid sg number %d\n", nr_sgs);
 			err = -EINVAL;
 			goto theend_iv;
 		}
 		nr_sgd = dma_map_sg(ss->dev, areq->dst, nsgd, DMA_FROM_DEVICE);
-		if (nr_sgd <= 0 || nr_sgd > 8) {
+		if (!nr_sgd || nr_sgd > 8) {
 			dev_err(ss->dev, "Invalid sg number %d\n", nr_sgd);
 			err = -EINVAL;
 			goto theend_sgs;
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 36a82b22953c..fcb8c41cc957 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -527,7 +527,7 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	rctx->method = ss->variant->alg_hash[algt->ss_algo_id];
 
 	nr_sgs = dma_map_sg(ss->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
+	if (!nr_sgs || nr_sgs > MAX_SG) {
 		dev_err(ss->dev, "Invalid sg number %d\n", nr_sgs);
 		err = -EINVAL;
 		goto theend;
-- 
2.34.1

