Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B1C581091
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiGZJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiGZJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:57:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEC32452;
        Tue, 26 Jul 2022 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658829450; x=1690365450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i8ZzEPCPV1l7drUm54+sPDrEsQsrRaUXcWuEJ9BPPeU=;
  b=bCPSdz8e20vtMJuufwEG9jNNQB8GPPPgHqb+GbAZwqs0t3wc3IpM/a/d
   pF0cs4duU4GBOrI5n7mVW8R1ctbqsP+n3kVwjmseQABqo/agcI0gLSBP9
   WkLRGceG7JB5F158APczj+tV9LdtFeQg5bR3jPsA1oolp5NHqhLvN3Yn5
   ck3Yxo+cC4aEfxwOJ7QvGMG7ZrSHwSQ9O0lMxHzOWZvXJIQ1nw3Akmuyk
   W05g7KwGzGye7D+BzW4qLkjR+iXklXXJ3hlDflfch/jTeNEzmjWAf8wnP
   5brDBPeeZzXwGhN44zP0sAwsp3BoyxYzM5MFbm9zhdp+kxL+nvDnLHKe0
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="173652709"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 02:57:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 02:57:28 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 02:57:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <cristian.birsan@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] usb: gadget: at91_udc: stop using legacy pm ops
Date:   Tue, 26 Jul 2022 12:59:47 +0300
Message-ID: <20220726095948.1809038-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using legacy PM ops and switch using dev_pm_ops.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 728987280373..2f522f77c553 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_data/atmel.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/atmel-matrix.h>
@@ -1948,11 +1949,10 @@ static int at91udc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
+static int at91udc_suspend(struct device *dev)
 {
-	struct at91_udc *udc = platform_get_drvdata(pdev);
-	int		wake = udc->driver && device_may_wakeup(&pdev->dev);
+	struct at91_udc *udc = dev_get_drvdata(dev);
+	int		wake = udc->driver && device_may_wakeup(dev);
 	unsigned long	flags;
 
 	/* Unless we can act normally to the host (letting it wake us up
@@ -1976,9 +1976,9 @@ static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
 	return 0;
 }
 
-static int at91udc_resume(struct platform_device *pdev)
+static int at91udc_resume(struct device *dev)
 {
-	struct at91_udc *udc = platform_get_drvdata(pdev);
+	struct at91_udc *udc = dev_get_drvdata(dev);
 	unsigned long	flags;
 
 	if (udc->board.vbus_pin && !udc->board.vbus_polled &&
@@ -1995,19 +1995,17 @@ static int at91udc_resume(struct platform_device *pdev)
 	}
 	return 0;
 }
-#else
-#define	at91udc_suspend	NULL
-#define	at91udc_resume	NULL
-#endif
+
+static DEFINE_SIMPLE_DEV_PM_OPS(at91_udc_pm_ops, at91udc_suspend,
+				at91udc_resume);
 
 static struct platform_driver at91_udc_driver = {
 	.remove		= at91udc_remove,
 	.shutdown	= at91udc_shutdown,
-	.suspend	= at91udc_suspend,
-	.resume		= at91udc_resume,
 	.driver		= {
 		.name	= driver_name,
 		.of_match_table	= at91_udc_dt_ids,
+		.pm = pm_ptr(&at91_udc_pm_ops),
 	},
 };
 
-- 
2.34.1

