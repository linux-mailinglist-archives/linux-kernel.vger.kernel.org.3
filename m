Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687B94BD7A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346683AbiBUH7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:59:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbiBUH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:59:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793562182A;
        Sun, 20 Feb 2022 23:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645430317; x=1676966317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hXm0Jtwri1nLMNu8938lMqvk/Ro4GDt9J9rutPzfAFk=;
  b=GPj5uK+AEnS4W0nevf/WEMoLxkdK7OdLKd9beuXkyQZlEiGJhP6GFVPU
   9J3/nFsOI3WELeiId6/aiwbpbUOr8VdALbQppo2XeZjGuKASR2CnsSrHx
   cVawkQ3TpM+Vm7rmTGfpc5rqIE9uYmAX5XEXN9Xaubd1S9F5zcCn7Xzex
   XuVYl7ZcksCWEX4e/xKGBLee0AiTMruX6yUiPC3hvYojuUqEs9Tsuwn5l
   2fmSd2Xs6CXcS69AFc1deaq6dHGgLy9797pyDW480DPFE3h6KPl52F9le
   RTiDHmIaBvCbBQApj7p72TxxW81m0k5MBbCcUdd++8x3gqQweYIkiyf9e
   g==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="149399849"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2022 00:58:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Feb 2022 00:58:36 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 21 Feb 2022 00:58:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 6/7] hwrng: atmel - add runtime pm support
Date:   Mon, 21 Feb 2022 09:59:27 +0200
Message-ID: <20220221075928.563806-7-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220221075928.563806-1-claudiu.beznea@microchip.com>
References: <20220221075928.563806-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime PM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/char/hw_random/atmel-rng.c | 44 ++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 0fff74808472..b662d44a09a6 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -17,6 +17,7 @@
 #include <linux/hw_random.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #define TRNG_CR		0x00
 #define TRNG_MR		0x04
@@ -58,6 +59,12 @@ static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
 	u32 *data = buf;
 	int ret;
 
+	ret = pm_runtime_get_sync((struct device *)trng->rng.priv);
+	if (ret < 0) {
+		pm_runtime_put_sync((struct device *)trng->rng.priv);
+		return ret;
+	}
+
 	ret = atmel_trng_wait_ready(trng, wait);
 	if (!ret)
 		goto out;
@@ -72,6 +79,8 @@ static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
 	ret = 4;
 
 out:
+	pm_runtime_mark_last_busy((struct device *)trng->rng.priv);
+	pm_runtime_put_sync_autosuspend((struct device *)trng->rng.priv);
 	return ret;
 }
 
@@ -127,21 +136,28 @@ static int atmel_trng_probe(struct platform_device *pdev)
 	trng->has_half_rate = data->has_half_rate;
 	trng->rng.name = pdev->name;
 	trng->rng.read = atmel_trng_read;
+	trng->rng.priv = (unsigned long)&pdev->dev;
+	platform_set_drvdata(pdev, trng);
 
+#ifndef CONFIG_PM
 	ret = atmel_trng_init(trng);
 	if (ret)
 		return ret;
+#endif
 
-	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
-	if (ret)
-		goto err_register;
-
-	platform_set_drvdata(pdev, trng);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
-	return 0;
+	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+#ifndef CONFIG_PM
+		atmel_trng_cleanup(trng);
+#endif
+	}
 
-err_register:
-	atmel_trng_cleanup(trng);
 	return ret;
 }
 
@@ -151,11 +167,13 @@ static int atmel_trng_remove(struct platform_device *pdev)
 
 
 	atmel_trng_cleanup(trng);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	return 0;
 }
 
-static int __maybe_unused atmel_trng_suspend(struct device *dev)
+static int __maybe_unused atmel_trng_runtime_suspend(struct device *dev)
 {
 	struct atmel_trng *trng = dev_get_drvdata(dev);
 
@@ -164,7 +182,7 @@ static int __maybe_unused atmel_trng_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused atmel_trng_resume(struct device *dev)
+static int __maybe_unused atmel_trng_runtime_resume(struct device *dev)
 {
 	struct atmel_trng *trng = dev_get_drvdata(dev);
 
@@ -172,8 +190,10 @@ static int __maybe_unused atmel_trng_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops __maybe_unused atmel_trng_pm_ops = {
-	.suspend	= atmel_trng_suspend,
-	.resume		= atmel_trng_resume,
+	SET_RUNTIME_PM_OPS(atmel_trng_runtime_suspend,
+			   atmel_trng_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static const struct atmel_trng_data at91sam9g45_config = {
-- 
2.32.0

