Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65918581094
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiGZJ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiGZJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:57:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571403245F;
        Tue, 26 Jul 2022 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658829451; x=1690365451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG/ERXhf6xiKqQVd9uEykEdvGxS/Vz7RRikpu9AWpDE=;
  b=e8Q2al9e7nTbmFaFMXfgcnyMYdJkS63GYGhkkX+u4Ey6x8xh60Ap9TIR
   8QKpmzROyXaPSKtoYVPIh2Qj290j9OZO3IX3T0Lx3ZGFACtsxv8L5aNaN
   9K0UP8YyfPE5Q6qOwFrFngEasLx1T6tcSCpWQrNDv5Z7JL1oPnrbqAgW5
   wZg1NldTiY5G9ayXW41wGlV1FZ3pkel5YWjKObQkzPKOt2sFcLbLSt6dP
   tDVUFWO2ulc5qRbLRAeDnNR84kfADJ20BmKfBmkz2/YFZXG/kSWQHkpO2
   mO1DWMuYpHAEI22XJaQW3E8eDtMBRMMB5UBiZ7t2dZqSSvRpzrq/7wJEr
   g==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="166409646"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 02:57:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 02:57:30 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 02:57:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <cristian.birsan@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] usb: gadget: udc: atmel: remove #ifdef CONFIG_PM_SLEEP
Date:   Tue, 26 Jul 2022 12:59:48 +0300
Message-ID: <20220726095948.1809038-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220726095948.1809038-1-claudiu.beznea@microchip.com>
References: <20220726095948.1809038-1-claudiu.beznea@microchip.com>
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

Remove #ifdef CONFIG_PM_SLEEP and use DEFINE_SIMPLE_DEV_PM_OPS() along with
pm_sleep_ptr().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index ae2bfbac603e..6c088f6e9afa 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2384,7 +2384,6 @@ static int usba_udc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int usba_udc_suspend(struct device *dev)
 {
 	struct usba_udc *udc = dev_get_drvdata(dev);
@@ -2442,15 +2441,14 @@ static int usba_udc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(usba_udc_pm_ops, usba_udc_suspend, usba_udc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(usba_udc_pm_ops, usba_udc_suspend, usba_udc_resume);
 
 static struct platform_driver udc_driver = {
 	.remove		= usba_udc_remove,
 	.driver		= {
 		.name		= "atmel_usba_udc",
-		.pm		= &usba_udc_pm_ops,
+		.pm		= pm_sleep_ptr(&usba_udc_pm_ops),
 		.of_match_table	= atmel_udc_dt_ids,
 	},
 };
-- 
2.34.1

