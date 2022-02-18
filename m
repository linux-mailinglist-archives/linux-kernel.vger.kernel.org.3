Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240E4BB6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiBRKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:16:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiBRKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:16:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D02B0481;
        Fri, 18 Feb 2022 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645179381; x=1676715381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZ+azJ3C6NsQmXfKrlNJXfCNh4CtclKSN1p9C0K3pXE=;
  b=bCrWc8IJYzhLV3LvTdJcc+F3H+tjFkEaXKfpDa2mpo0PFjHPbcFiSGgR
   +38/l/buROo1lxz2fRZN0JwUC8gPooKFkXKU30hYMTndPNFKbIPlwx0kP
   451X2rcJC8MdFxadjC7hnCnBkrndNpPfuga+c/eFAkSHSZ+ghSWuXN/Zk
   NvnpAVy3MpY+YTFC1CjLRdW51SkC0N2gCs2dlqgwJfuDvmYhYTDsMuVpe
   6YVwQQnC0xo7kNfhl99dWI8dPnykQa10CW3yzZu7HGmNbXebcW3TGWqct
   RsTT6RMrqvphbTAoZKJPInFPuhiMkh9/qQbH9dhsfGBiX4Qip/mhh9nra
   w==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="146491137"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 03:16:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 03:16:19 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 03:16:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/7] hwrnd: atmel - use __maybe_unused and pm_ptr() for pm ops
Date:   Fri, 18 Feb 2022 12:17:10 +0200
Message-ID: <20220218101712.530576-6-claudiu.beznea@microchip.com>
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

