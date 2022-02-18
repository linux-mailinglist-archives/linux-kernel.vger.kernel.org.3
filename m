Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37184BB69D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiBRKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:16:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiBRKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:16:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C41B2AEDA6;
        Fri, 18 Feb 2022 02:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645179370; x=1676715370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bqtRma4i+aDRPSPwCrS3g3crpowmv6qvyEHjsN3/F0U=;
  b=yJAV02lK2Vhh7mjjy/gW5NR0OknWC/ud4GPBDGyrJi86hUHx1/mhBX7+
   0WsvpxuE/sziWptxb5NQ6OJEhbEsBUci8qlZ5e4+//rcw9GJHppKVzatA
   uLXmSua7m3qnAaankw0viUDQv/lrXN3DBYU1ilvFv5RR2MQRdblp+xke9
   EtQ0cSQZVI5fhgzVQJjWrIp8/ogDALE+JyxKBu3FNDzxzhzidvxAO4qHE
   Fo5HE3VEzoEu10+PzDq7cTwQzK2GIVq5qw4CEOeQmXJI3Q8CxCJO6JprB
   i3meUACvJ9WgwAt7g2VwqEgrQn0TIk+v7NqmfWPxDNfyZ4ocol9BuOWiy
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="149200659"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 03:16:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 03:16:09 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 03:16:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/7] hwrng: atmel - add wait for ready support on read
Date:   Fri, 18 Feb 2022 12:17:06 +0200
Message-ID: <20220218101712.530576-2-claudiu.beznea@microchip.com>
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

Add wait for ready support on read.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/char/hw_random/atmel-rng.c | 43 +++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index ecb71c4317a5..1a4874668c04 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/hw_random.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -20,6 +21,7 @@
 #define TRNG_CR		0x00
 #define TRNG_MR		0x04
 #define TRNG_ISR	0x1c
+#define TRNG_ISR_DATRDY	BIT(0)
 #define TRNG_ODATA	0x50
 
 #define TRNG_KEY	0x524e4700 /* RNG */
@@ -36,25 +38,40 @@ struct atmel_trng {
 	struct hwrng rng;
 };
 
+static bool atmel_trng_wait_ready(struct atmel_trng *trng, bool wait)
+{
+	int ready;
+
+	ready = readl(trng->base + TRNG_ISR) & TRNG_ISR_DATRDY;
+	if (!ready && wait)
+		readl_poll_timeout(trng->base + TRNG_ISR, ready,
+				   ready & TRNG_ISR_DATRDY, 1000, 20000);
+
+	return !!ready;
+}
+
 static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
 			   bool wait)
 {
 	struct atmel_trng *trng = container_of(rng, struct atmel_trng, rng);
 	u32 *data = buf;
+	int ret;
+
+	ret = atmel_trng_wait_ready(trng, wait);
+	if (!ret)
+		goto out;
 
-	/* data ready? */
-	if (readl(trng->base + TRNG_ISR) & 1) {
-		*data = readl(trng->base + TRNG_ODATA);
-		/*
-		  ensure data ready is only set again AFTER the next data
-		  word is ready in case it got set between checking ISR
-		  and reading ODATA, so we don't risk re-reading the
-		  same word
-		*/
-		readl(trng->base + TRNG_ISR);
-		return 4;
-	} else
-		return 0;
+	*data = readl(trng->base + TRNG_ODATA);
+	/*
+	 * ensure data ready is only set again AFTER the next data word is ready
+	 * in case it got set between checking ISR and reading ODATA, so we
+	 * don't risk re-reading the same word
+	 */
+	readl(trng->base + TRNG_ISR);
+	ret = 4;
+
+out:
+	return ret;
 }
 
 static void atmel_trng_enable(struct atmel_trng *trng)
-- 
2.32.0

