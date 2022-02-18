Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAC94BB6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiBRKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:16:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiBRKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:16:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB42AF90F;
        Fri, 18 Feb 2022 02:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645179375; x=1676715375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jsWxgS54TLuyrZok7rycmGN8GjwhZu+4iH1IkWMXxMw=;
  b=gp39X1Kq4bcycgGOZBeXGzBliLJnmD0k1ixLokYSZ7xqSg5VMCLEKIDo
   cJ9h+0KKMmhublZrUjo4IaCsT3bRw3vPTb7DLD9XaHB5/XgDhcc7LX/+I
   cE+uFpm9FQ6pZ3aaECUmFooEEBdnN3J0/nt3t3uFjJ7hwu2VMBmQXFZF+
   h4Aup1/G5BNcHpx8GXy/PF/l6UZxh3vvVH7jPBeDN4uracG0yq9hdzWa8
   yFE3WTEn8/6CELaeC66JkqsMK6CUbbn7a51EY4T0DZio4/6+sdxhmd0wR
   CsyAICcWU2dOBasWLGRaSipSZ7F0RACBa6V8KFWtn967Wre0ejVpAoQlr
   w==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="162767779"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 03:16:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 03:16:14 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 03:16:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/7] hwrnd: atmel - rename enable/disable functions to init/cleanup
Date:   Fri, 18 Feb 2022 12:17:08 +0200
Message-ID: <20220218101712.530576-4-claudiu.beznea@microchip.com>
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

s/atmel_trng_disable/atmel_trng_cleanup/g and
s/atmel_trng_enable/atmel_trng_init/g to cope with
struct hwrng::{init, cleanup} members.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/char/hw_random/atmel-rng.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index b7ef951927fb..17f02049c112 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -74,12 +74,12 @@ static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
 	return ret;
 }
 
-static void atmel_trng_enable(struct atmel_trng *trng)
+static void atmel_trng_init(struct atmel_trng *trng)
 {
 	writel(TRNG_KEY | 1, trng->base + TRNG_CR);
 }
 
-static void atmel_trng_disable(struct atmel_trng *trng)
+static void atmel_trng_cleanup(struct atmel_trng *trng)
 {
 	writel(TRNG_KEY, trng->base + TRNG_CR);
 }
@@ -117,7 +117,7 @@ static int atmel_trng_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	atmel_trng_enable(trng);
+	atmel_trng_init(trng);
 	trng->rng.name = pdev->name;
 	trng->rng.read = atmel_trng_read;
 
@@ -131,7 +131,7 @@ static int atmel_trng_probe(struct platform_device *pdev)
 
 err_register:
 	clk_disable_unprepare(trng->clk);
-	atmel_trng_disable(trng);
+	atmel_trng_cleanup(trng);
 	return ret;
 }
 
@@ -140,7 +140,7 @@ static int atmel_trng_remove(struct platform_device *pdev)
 	struct atmel_trng *trng = platform_get_drvdata(pdev);
 
 
-	atmel_trng_disable(trng);
+	atmel_trng_cleanup(trng);
 	clk_disable_unprepare(trng->clk);
 
 	return 0;
@@ -151,7 +151,7 @@ static int atmel_trng_suspend(struct device *dev)
 {
 	struct atmel_trng *trng = dev_get_drvdata(dev);
 
-	atmel_trng_disable(trng);
+	atmel_trng_cleanup(trng);
 	clk_disable_unprepare(trng->clk);
 
 	return 0;
@@ -166,7 +166,7 @@ static int atmel_trng_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	atmel_trng_enable(trng);
+	atmel_trng_init(trng);
 
 	return 0;
 }
-- 
2.32.0

