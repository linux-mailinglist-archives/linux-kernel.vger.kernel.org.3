Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69743577C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiGRHIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiGRHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:08:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F92175B8;
        Mon, 18 Jul 2022 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658128111; x=1689664111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/36lrqu98ICjFsab92jQzawKglUSnBRJ4IRFIwtlFVM=;
  b=s3j1pR5gmGCDBo4wZDUJOZKCbO5KhRld3xXSLz/w9iMf1fixIIHcHrAB
   1zWPDns14nFDc4TmZ0edLSrHYK55k+Qf7JHo7zT6RTgMayAHM0Hs/QOll
   u+XJHHdn5wmIgN3GezEAsFcQCMuZuVj+jqS3APOhdpeZQJigbEcERomJa
   j1l3kPNwfd+67KkkKqspuW/xbzNvhAmUx2yN0cL5/yncOqIpVzaTvMjAc
   6hARBXJ5ZZhnWq/F+tPmkOhK6QRD/c0rKdm6lDtI8HuMkhkXEK0thYaxV
   hvaqMxDLDcdrDLcpMiZsn+6DpgVTfkDC00w3RGPOWOIKlTwLqJ16kKLiO
   g==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="165161049"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 00:08:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 00:08:30 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 00:08:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tudor.ambarus@microchip.com>, <broonie@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] spi: atmel: remove #ifdef CONFIG_{PM, SLEEP}
Date:   Mon, 18 Jul 2022 10:10:52 +0300
Message-ID: <20220718071052.1707858-1-claudiu.beznea@microchip.com>
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

Remove #ifdef CONFIG_PM, #ifdef CONFIG_PM_SLEEP and use
SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS() macros instead which allows
getting also rid of __maybe_unused in the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/spi/spi-atmel.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 9e300a932699..c4f22d50dba5 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1631,7 +1631,6 @@ static int atmel_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int atmel_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -1653,7 +1652,6 @@ static int atmel_spi_runtime_resume(struct device *dev)
 	return clk_prepare_enable(as->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int atmel_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -1693,17 +1691,12 @@ static int atmel_spi_resume(struct device *dev)
 	/* Start the queue running */
 	return spi_master_resume(master);
 }
-#endif
 
 static const struct dev_pm_ops atmel_spi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
-	SET_RUNTIME_PM_OPS(atmel_spi_runtime_suspend,
-			   atmel_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
+	RUNTIME_PM_OPS(atmel_spi_runtime_suspend,
+		       atmel_spi_runtime_resume, NULL)
 };
-#define ATMEL_SPI_PM_OPS	(&atmel_spi_pm_ops)
-#else
-#define ATMEL_SPI_PM_OPS	NULL
-#endif
 
 static const struct of_device_id atmel_spi_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-spi" },
@@ -1715,7 +1708,7 @@ MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
 static struct platform_driver atmel_spi_driver = {
 	.driver		= {
 		.name	= "atmel_spi",
-		.pm	= ATMEL_SPI_PM_OPS,
+		.pm	= pm_ptr(&atmel_spi_pm_ops),
 		.of_match_table	= atmel_spi_dt_ids,
 	},
 	.probe		= atmel_spi_probe,
-- 
2.34.1

