Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70559444C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbiHOWJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346748AbiHOWH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:07:59 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118D3118471;
        Mon, 15 Aug 2022 12:38:01 -0700 (PDT)
Received: from dslb-188-096-143-237.188.096.pools.vodafone-ip.de ([188.96.143.237] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oNfuP-000485-S1; Mon, 15 Aug 2022 21:37:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] hwrng: imx-rngc - use devres for hwrng registration
Date:   Mon, 15 Aug 2022 21:37:43 +0200
Message-Id: <20220815193743.105926-3-martin@kaiser.cx>
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

Replace hwrng_register with devm_hwrng_register and let devres unregister
our hwrng when the device is removed.

It's possible to do this now that devres also handles clock
disable+uprepare. When we had to disable+unprepare the clock ourselves,
we had to unregister the hwrng before this and couldn't use devres.

There's nothing left to do for imx_rngc_remove, this function can go.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 23f490204341..97d8dc931ca6 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -292,7 +292,7 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = hwrng_register(&rngc->rng);
+	ret = devm_hwrng_register(&pdev->dev, &rngc->rng);
 	if (ret) {
 		dev_err(&pdev->dev, "hwrng registration failed\n");
 		return ret;
@@ -305,15 +305,6 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit imx_rngc_remove(struct platform_device *pdev)
-{
-	struct imx_rngc *rngc = platform_get_drvdata(pdev);
-
-	hwrng_unregister(&rngc->rng);
-
-	return 0;
-}
-
 static int __maybe_unused imx_rngc_suspend(struct device *dev)
 {
 	struct imx_rngc *rngc = dev_get_drvdata(dev);
@@ -346,7 +337,6 @@ static struct platform_driver imx_rngc_driver = {
 		.pm = &imx_rngc_pm_ops,
 		.of_match_table = imx_rngc_dt_ids,
 	},
-	.remove = __exit_p(imx_rngc_remove),
 };
 
 module_platform_driver_probe(imx_rngc_driver, imx_rngc_probe);
-- 
2.30.2

