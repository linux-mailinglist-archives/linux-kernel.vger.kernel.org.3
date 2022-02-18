Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38124BB6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiBRKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:16:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiBRKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:16:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B62AFE9D;
        Fri, 18 Feb 2022 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645179377; x=1676715377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iRwy/l1gN6TA2D/EeDe1EPLIvg3mQHpedoZHLk08KpA=;
  b=XhZGEELKhN+Sa5Y7aGSVkk8zAS5zwzKTP4yvDKxwZ9KriKaMNhyfd/ZQ
   NBy1KsgFGflm+lSa/DvKszMLi806xLzdZ09KpbgeXYoiiRD5xCR17Ssyp
   E6VS+eET4tOacb/dpJ3bkbZ4W2TDrgh6IAylxfQidF0cd/8wp7KvzzC1k
   3wB0AHwafGewL6u9cx+UGmaoN1wFwMw+zx6eP7uCpJDFyXRi9fMdb1vk+
   RTkfI5dkmxEDk4wdaJxObY1hi4v9GBZMu4Mx+cTy5dmwq2pM277LTj1+v
   cRiJhcmlR5zArV9KYiALFadCC+nsj9c75SYj1pL0jSSVjLEED9BLwW5Bu
   w==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="149200684"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 03:16:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 03:16:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 03:16:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/7] hwrng: atmel - move set of TRNG_HALFR in atmel_trng_init()
Date:   Fri, 18 Feb 2022 12:17:09 +0200
Message-ID: <20220218101712.530576-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220218101712.530576-1-claudiu.beznea@microchip.com>
References: <20220218101712.530576-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move set of TRNG_HALFR in atmel_trng_init() as this function is
also called on resume path. In case of SAMA7G5 (where backup and
self-refresh PM mode is available) most of the SoC parts are
powered of (including TRNG) when entering suspend. In that case
on resuming path TRNG_HALFR should also be re-configured.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/char/hw_random/atmel-rng.c | 49 +++++++++++++++---------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 17f02049c112..ef49dbe681cf 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -36,6 +36,7 @@ struct atmel_trng {
 	struct clk *clk;
 	void __iomem *base;
 	struct hwrng rng;
+	bool has_half_rate;
 };
 
 static bool atmel_trng_wait_ready(struct atmel_trng *trng, bool wait)
@@ -74,14 +75,32 @@ static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
 	return ret;
 }
 
-static void atmel_trng_init(struct atmel_trng *trng)
+static int atmel_trng_init(struct atmel_trng *trng)
 {
+	unsigned long rate;
+	int ret;
+
+	ret = clk_prepare_enable(trng->clk);
+	if (ret)
+		return ret;
+
+	if (trng->has_half_rate) {
+		rate = clk_get_rate(trng->clk);
+
+		/* if peripheral clk is above 100MHz, set HALFR */
+		if (rate > 100000000)
+			writel(TRNG_HALFR, trng->base + TRNG_MR);
+	}
+
 	writel(TRNG_KEY | 1, trng->base + TRNG_CR);
+
+	return 0;
 }
 
 static void atmel_trng_cleanup(struct atmel_trng *trng)
 {
 	writel(TRNG_KEY, trng->base + TRNG_CR);
+	clk_disable_unprepare(trng->clk);
 }
 
 static int atmel_trng_probe(struct platform_device *pdev)
@@ -105,22 +124,14 @@ static int atmel_trng_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENODEV;
 
-	if (data->has_half_rate) {
-		unsigned long rate = clk_get_rate(trng->clk);
-
-		/* if peripheral clk is above 100MHz, set HALFR */
-		if (rate > 100000000)
-			writel(TRNG_HALFR, trng->base + TRNG_MR);
-	}
+	trng->has_half_rate = data->has_half_rate;
+	trng->rng.name = pdev->name;
+	trng->rng.read = atmel_trng_read;
 
-	ret = clk_prepare_enable(trng->clk);
+	ret = atmel_trng_init(trng);
 	if (ret)
 		return ret;
 
-	atmel_trng_init(trng);
-	trng->rng.name = pdev->name;
-	trng->rng.read = atmel_trng_read;
-
 	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
 	if (ret)
 		goto err_register;
@@ -130,7 +141,6 @@ static int atmel_trng_probe(struct platform_device *pdev)
 	return 0;
 
 err_register:
-	clk_disable_unprepare(trng->clk);
 	atmel_trng_cleanup(trng);
 	return ret;
 }
@@ -141,7 +151,6 @@ static int atmel_trng_remove(struct platform_device *pdev)
 
 
 	atmel_trng_cleanup(trng);
-	clk_disable_unprepare(trng->clk);
 
 	return 0;
 }
@@ -152,7 +161,6 @@ static int atmel_trng_suspend(struct device *dev)
 	struct atmel_trng *trng = dev_get_drvdata(dev);
 
 	atmel_trng_cleanup(trng);
-	clk_disable_unprepare(trng->clk);
 
 	return 0;
 }
@@ -160,15 +168,8 @@ static int atmel_trng_suspend(struct device *dev)
 static int atmel_trng_resume(struct device *dev)
 {
 	struct atmel_trng *trng = dev_get_drvdata(dev);
-	int ret;
 
-	ret = clk_prepare_enable(trng->clk);
-	if (ret)
-		return ret;
-
-	atmel_trng_init(trng);
-
-	return 0;
+	return atmel_trng_init(trng);
 }
 
 static const struct dev_pm_ops atmel_trng_pm_ops = {
-- 
2.32.0

