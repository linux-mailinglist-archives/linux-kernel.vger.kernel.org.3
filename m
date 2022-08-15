Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5E594642
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiHOWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbiHOWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:08:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28119118474;
        Mon, 15 Aug 2022 12:38:01 -0700 (PDT)
Received: from dslb-188-096-143-237.188.096.pools.vodafone-ip.de ([188.96.143.237] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oNfuO-000485-Fg; Mon, 15 Aug 2022 21:37:56 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] hwrng: imx-rngc - use devm_clk_get_enabled
Date:   Mon, 15 Aug 2022 21:37:42 +0200
Message-Id: <20220815193743.105926-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815193743.105926-1-martin@kaiser.cx>
References: <20220815193743.105926-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new devm_clk_get_enabled function to get our clock.

We don't have to disable and unprepare the clock ourselves any more in
error paths and in the remove function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 4345df012d8f..23f490204341 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -245,7 +245,7 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	if (IS_ERR(rngc->base))
 		return PTR_ERR(rngc->base);
 
-	rngc->clk = devm_clk_get(&pdev->dev, NULL);
+	rngc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(rngc->clk)) {
 		dev_err(&pdev->dev, "Can not get rng_clk\n");
 		return PTR_ERR(rngc->clk);
@@ -255,26 +255,20 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = clk_prepare_enable(rngc->clk);
-	if (ret)
-		return ret;
-
 	ver_id = readl(rngc->base + RNGC_VER_ID);
 	rng_type = ver_id >> RNGC_TYPE_SHIFT;
 	/*
 	 * This driver supports only RNGC and RNGB. (There's a different
 	 * driver for RNGA.)
 	 */
-	if (rng_type != RNGC_TYPE_RNGC && rng_type != RNGC_TYPE_RNGB) {
-		ret = -ENODEV;
-		goto err;
-	}
+	if (rng_type != RNGC_TYPE_RNGC && rng_type != RNGC_TYPE_RNGB)
+		return -ENODEV;
 
 	ret = devm_request_irq(&pdev->dev,
 			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
 	if (ret) {
 		dev_err(rngc->dev, "Can't get interrupt working.\n");
-		goto err;
+		return ret;
 	}
 
 	init_completion(&rngc->rng_op_done);
@@ -294,14 +288,14 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		ret = imx_rngc_self_test(rngc);
 		if (ret) {
 			dev_err(rngc->dev, "self test failed\n");
-			goto err;
+			return ret;
 		}
 	}
 
 	ret = hwrng_register(&rngc->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "hwrng registration failed\n");
-		goto err;
+		return ret;
 	}
 
 	dev_info(&pdev->dev,
@@ -309,11 +303,6 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		rng_type == RNGC_TYPE_RNGB ? 'B' : 'C',
 		(ver_id >> RNGC_VER_MAJ_SHIFT) & 0xff, ver_id & 0xff);
 	return 0;
-
-err:
-	clk_disable_unprepare(rngc->clk);
-
-	return ret;
 }
 
 static int __exit imx_rngc_remove(struct platform_device *pdev)
@@ -322,8 +311,6 @@ static int __exit imx_rngc_remove(struct platform_device *pdev)
 
 	hwrng_unregister(&rngc->rng);
 
-	clk_disable_unprepare(rngc->clk);
-
 	return 0;
 }
 
-- 
2.30.2

