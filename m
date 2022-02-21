Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC54BD829
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiBUH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:59:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbiBUH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:58:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A01270F;
        Sun, 20 Feb 2022 23:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645430314; x=1676966314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZ+azJ3C6NsQmXfKrlNJXfCNh4CtclKSN1p9C0K3pXE=;
  b=t0IhatE/ypDz1TXZ5rWJUHzB0F72sRlps4/1UeirBrQBn8Ij7nms3Uef
   zjt6BRKSE7945KR5fa0hHbSM+17ZvwkFH5rDY653Fyd0NKSvctAw1wwgu
   yo8T0inDEtXQ5aKSEhlHc//jM6yEDieqZzUVM5GK1uwqL2RmqsD7ypj6d
   yqlOPKDf8pZl7OSs26FwFm6sJ5qUJFnR9kZBVrMDGbT+e7YiPxpv4ho0y
   vywa/lIo9p+GkSgrw3/DCdsmVqW5g2BqktzBw87PBoLvjYOM1X+S+UAk6
   MpA77eyaQWM8xNSKq6qN5E2iPbglF/GLGFOL5pxUReN++I53gTN7Mbz/B
   w==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="149399845"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2022 00:58:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Feb 2022 00:58:34 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 21 Feb 2022 00:58:32 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 5/7] hwrng: atmel - use __maybe_unused and pm_ptr() for pm ops
Date:   Mon, 21 Feb 2022 09:59:26 +0200
Message-ID: <20220221075928.563806-6-claudiu.beznea@microchip.com>
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

Use __maybe_unused and pm_ptr() for pm ops.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/char/hw_random/atmel-rng.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index ef49dbe681cf..0fff74808472 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -155,8 +155,7 @@ static int atmel_trng_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int atmel_trng_suspend(struct device *dev)
+static int __maybe_unused atmel_trng_suspend(struct device *dev)
 {
 	struct atmel_trng *trng = dev_get_drvdata(dev);
 
@@ -165,18 +164,17 @@ static int atmel_trng_suspend(struct device *dev)
 	return 0;
 }
 
-static int atmel_trng_resume(struct device *dev)
+static int __maybe_unused atmel_trng_resume(struct device *dev)
 {
 	struct atmel_trng *trng = dev_get_drvdata(dev);
 
 	return atmel_trng_init(trng);
 }
 
-static const struct dev_pm_ops atmel_trng_pm_ops = {
+static const struct dev_pm_ops __maybe_unused atmel_trng_pm_ops = {
 	.suspend	= atmel_trng_suspend,
 	.resume		= atmel_trng_resume,
 };
-#endif /* CONFIG_PM */
 
 static const struct atmel_trng_data at91sam9g45_config = {
 	.has_half_rate = false,
@@ -204,9 +202,7 @@ static struct platform_driver atmel_trng_driver = {
 	.remove		= atmel_trng_remove,
 	.driver		= {
 		.name	= "atmel-trng",
-#ifdef CONFIG_PM
-		.pm	= &atmel_trng_pm_ops,
-#endif /* CONFIG_PM */
+		.pm	= pm_ptr(&atmel_trng_pm_ops),
 		.of_match_table = atmel_trng_dt_ids,
 	},
 };
-- 
2.32.0

