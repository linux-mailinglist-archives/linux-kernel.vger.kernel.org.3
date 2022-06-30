Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4224556191F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiF3L07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiF3L0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:26:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2095.outbound.protection.outlook.com [40.107.21.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5232F4F653
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6Adm/AqANkvuNEOtC23bP8TIM96wk+JPKCtF/phMOSBPK3MWHYAnC/rrSNRZjsg/VRgwv4i75IfbIzIkh3qFsxFTIB9AAupYlZEr1X8VkOlr6CEjGS7uKyrVV/oJGnIZ8ruK1Sv9FoKr+J9XZMUOAR/aNuL7gozJEhxqaemT1S2fpfXZbSru3CAoUSLAPcnwdBHLbwIwnlmDYL427SEEdbOAy1P9B/X92+nx7aoxv69851mwpRURr1qF/v3YrbXSwWv1SXxdS4kr1COOit/X9ObtQmQEunminbPlqYc5MHStZxOX+PNNtlw/mbLrbTbaK3beE8JrbtkSHHveARDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPO6h/TEh1ewPSN4axm/eSQ6TpZAOxFobSM+p+vzXkY=;
 b=K/r+9S667/g/fUb5VUjbg9X+mF/iRzqxKZkw+h/OlpIYW5BWuaJRC6SzDQupkysC3FbwtPdlkISdFCsLq+Y8gCA40tq62OC0NGj3Fev76qmXG863UAoeUHYVQVfJf/xOaS6736qKCSnM/meN87fAowMA+Pu5NPUsScP6c7r5zhUGJgkLNVTFNaxu1cVUGUK1+2++5mv5dAxQ4c5585ilryXhJwQjJOj9Yj0Cia6wVXX7o7cPpwmpfI7ZGDLZxUPxlR3MHndqBJBwrfOF3NEnSx08fQXx9H6GMdHi4oie2JvsayonmFGqz894dJo2rWLw7M3vzH4rIj+mociKHYcUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPO6h/TEh1ewPSN4axm/eSQ6TpZAOxFobSM+p+vzXkY=;
 b=nd7eAH0TPhk8EIb/pUbXTYkb1+5MOitpvkU694Knlm1VfGNU/kZSabQL9K9uCpxwYcj/tmaV9FmDs/6AcNmbCePF2lDEriPLlf/eh0OYAWMTvp7m5bst6gTF/pEscyOOggqqNvIDJIdnSK5cpbl5q9tY3XSJp0XQ4QCvf0KHVHU=
Received: from DB7PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:10:36::47)
 by AMAP122MB0244.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.22; Thu, 30 Jun
 2022 11:26:52 +0000
Received: from DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::ec) by DB7PR05CA0034.outlook.office365.com
 (2603:10a6:10:36::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 11:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 DB5EUR01FT075.mail.protection.outlook.com (10.152.5.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 11:26:51 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by ext-eur1.smtp.philips.com with ESMTP
        id 6o5voey45l9Zi6sJvoXdVJ; Thu, 30 Jun 2022 13:26:51 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
        by smtprelay-eur1.philips.com with ESMTP
        id 6sJvodLaLBXNN6sJvoZUwp; Thu, 30 Jun 2022 13:26:51 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.222.238])
        by mail.bbl.ms.philips.com (Postfix) with ESMTP id 8D68C1833BD;
        Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
        id 83A042A00E5; Thu, 30 Jun 2022 13:26:51 +0200 (CEST)
From:   Julian Haller <julian.haller@bbl.ms.philips.com>
To:     linux-kernel@vger.kernel.org
Cc:     julian.haller@philips.com, zbr@ioremap.net
Subject: [PATCH 2/4] w1: ds1wm: Add device tree support
Date:   Thu, 30 Jun 2022 13:26:49 +0200
Message-Id: <20220630112651.2739425-2-julian.haller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630112651.2739425-1-julian.haller@bbl.ms.philips.com>
References: <20220630112651.2739425-1-julian.haller@bbl.ms.philips.com>
Reply-To: julian.haller@philips.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c9686760-796f-49a0-2907-08da5a8b6e0c
X-MS-TrafficTypeDiagnostic: AMAP122MB0244:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0V2iqQ1KebZMizjEEpdJ3mdELKr+tGVV5dIYNdgW3PIJz/0aBYEIXvPVtBYDmyfF49NrfN+eK0+x74eamgu3Jiu3rvC220jRr2B1XlAeG9XsKQl/3B0t6y5bV5slXM3Rl1258u+hUz2zrsCvMzDOnoU0pmRIftoxdkAE/21fdRVlJ+Ho9pwT+tcT/sOFn1Q4mkNnpoaYG9A4CJqzGIyauvMkJgsq+ZT+CQ19II4uVKRoixBPjHEXfOh1gbomz/0cNTG4VlCRcHUilnJy3lE/ShQydLgsPB+C+7/2xD/ks6l0atpLCCA0Xd9/XZ8Awa3HBhW1F3Knd2R3LgyrYerRa4mbQ3UCvh1Ri7DYCe5JXTApWa9bpJ0I5YBMWVQNZYcsOeci7t0ZuW8xIY/R3Io2c4U0fnM7CXW8y2XnWhOt081CVO549eq1qwbG84X9b8uNdrzjsb0Fc8ae0ZvsVGw2VyfwB97x+tU1YQit1gKVyjaos6v5gAYkv+dqVlwf+enaHCSsLHsTaY5UwoJS0e5dVxe04GCZzYs3sOoapgJyfMYomxb2yfjR1mWMrVUuE7JGs6tJ/Hf25HbVfQxV28Rc4kSmMNBv833DAA+L5oCd9jk0aRX1O9Pljt/zlzm3wUXZJ8HrJJxrprIjdg9Et4qYynxPOCme7mCDLMX/i6BbAySL+Ur+Aiz0sEODjTJMU4HnEDtGMABNnP09CikRRQ3SLtxiVglij7Wu89lEViGIldjgfVLIG1+lcN0KhxVSx6u8cObbRBZQIWxn7jDP9J0wNkiLJv89H3zcbzQH1CGislv40pQDLI4qM7ZlES6SKWENvv88vyWT5FLyj0VfTKqZNSoQNruDMlZHlHEWU8mQ7V7pVgYJL0H18T7Bk/6JQlBw
X-Forefront-Antispam-Report: CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(40470700004)(46966006)(36840700001)(36860700001)(40480700001)(83380400001)(7636003)(7596003)(82960400001)(356005)(40460700003)(82740400003)(426003)(8936002)(44832011)(478600001)(5660300002)(336012)(70206006)(2906002)(41300700001)(316002)(6916009)(42186006)(6266002)(186003)(26005)(70586007)(4326008)(47076005)(107886003)(1076003)(8676002)(2616005)(82310400005)(32563001)(473944003);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 11:26:51.8966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9686760-796f-49a0-2907-08da5a8b6e0c
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMAP122MB0244
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Haller <julian.haller@philips.com>

The ds1wm driver now supports both, initialization with platform_data
and initialization via device tree.

Signed-off-by: Julian Haller <julian.haller@philips.com>
---
 drivers/w1/masters/ds1wm.c | 122 +++++++++++++++++++++++++++++++------
 1 file changed, 102 insertions(+), 20 deletions(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index 0ecb14772f30..a764b016758f 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -22,6 +22,9 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/ds1wm.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #include <asm/io.h>
 
@@ -97,6 +100,7 @@ struct ds1wm_data {
 	void     __iomem *map;
 	unsigned int      bus_shift; /* # of shifts to calc register offsets */
 	bool      is_hw_big_endian;
+	unsigned long clock_rate;
 	struct platform_device *pdev;
 	const struct mfd_cell   *cell;
 	int      irq;
@@ -294,7 +298,7 @@ static u8 ds1wm_read(struct ds1wm_data *ds1wm_data, unsigned char write_data)
 	return ds1wm_data->read_byte;
 }
 
-static int ds1wm_find_divisor(int gclk)
+static int ds1wm_find_divisor(unsigned long gclk)
 {
 	int i;
 
@@ -309,17 +313,16 @@ static void ds1wm_up(struct ds1wm_data *ds1wm_data)
 {
 	int divisor;
 	struct device *dev = &ds1wm_data->pdev->dev;
-	struct ds1wm_driver_data *plat = dev_get_platdata(dev);
 
-	if (ds1wm_data->cell->enable)
+	if (ds1wm_data->cell && ds1wm_data->cell->enable)
 		ds1wm_data->cell->enable(ds1wm_data->pdev);
 
-	divisor = ds1wm_find_divisor(plat->clock_rate);
-	dev_dbg(dev, "found divisor 0x%x for clock %d\n",
-		divisor, plat->clock_rate);
+	divisor = ds1wm_find_divisor(ds1wm_data->clock_rate);
+	dev_dbg(dev, "found divisor 0x%x for clock %lu\n",
+		divisor, ds1wm_data->clock_rate);
 	if (divisor == 0) {
-		dev_err(dev, "no suitable divisor for %dHz clock\n",
-			plat->clock_rate);
+		dev_err(dev, "no suitable divisor for %luHz clock\n",
+			ds1wm_data->clock_rate);
 		return;
 	}
 	ds1wm_write_register(ds1wm_data, DS1WM_CLKDIV, divisor);
@@ -338,7 +341,7 @@ static void ds1wm_down(struct ds1wm_data *ds1wm_data)
 	ds1wm_write_register(ds1wm_data, DS1WM_INT_EN,
 		ds1wm_data->int_en_reg_none);
 
-	if (ds1wm_data->cell->disable)
+	if (ds1wm_data->cell && ds1wm_data->cell->disable)
 		ds1wm_data->cell->disable(ds1wm_data->pdev);
 }
 
@@ -529,15 +532,86 @@ static int ds1wm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ds1wm_data->pdev = pdev;
-	ds1wm_data->cell = mfd_get_cell(pdev);
-	if (!ds1wm_data->cell)
-		return -ENODEV;
-	plat = dev_get_platdata(&pdev->dev);
-	if (!plat)
-		return -ENODEV;
+
+	if (pdev->dev.of_node) {
+		/* Using device tree */
+		struct device_node *node = pdev->dev.of_node;
+		uint32_t register_size;
+		uint32_t clock_rate;
+
+		ret = of_property_read_u32(node, "maxim,register-size",
+				&register_size);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to read maxim,register-size from dtb\n");
+			return ret;
+		}
+
+		switch (register_size) {
+		case 1:
+			ds1wm_data->bus_shift = 0;
+			break;
+		case 2:
+			ds1wm_data->bus_shift = 1;
+			break;
+		case 4:
+			ds1wm_data->bus_shift = 2;
+			break;
+		default:
+			dev_err(&pdev->dev,
+				"Invalid value for maxim,register-size: %u\n",
+				register_size);
+			return -EINVAL;
+		}
+
+		ds1wm_data->is_hw_big_endian = of_property_read_bool(node,
+				"maxim,big-endian");
+
+		if (of_property_read_bool(node, "maxim,active-high"))
+			ds1wm_data->int_en_reg_none = DS1WM_INTEN_IAS;
+		else
+			ds1wm_data->int_en_reg_none = 0;
+
+		ret = of_property_read_u32(node, "maxim,reset-recover-delay",
+				&ds1wm_data->reset_recover_delay);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to read maxim,reset-recover-delay from dtb\n");
+			return ret;
+		}
+
+		ret = of_property_read_u32(node, "maxim,clock-rate",
+				&clock_rate);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to read maxim,clock-rate from dtb\n");
+			return ret;
+		}
+		ds1wm_data->clock_rate = clock_rate;
+
+		ds1wm_data->strong_pullup = of_property_read_bool(node,
+				"maxim,strong-pullup");
+	} else {
+		/* Using platform data */
+		ds1wm_data->cell = mfd_get_cell(pdev);
+		if (!ds1wm_data->cell)
+			return -ENODEV;
+		plat = dev_get_platdata(&pdev->dev);
+		if (!plat)
+			return -ENODEV;
+
+		ds1wm_data->bus_shift = plat->bus_shift;
+		ds1wm_data->is_hw_big_endian = plat->is_hw_big_endian;
+
+		ds1wm_data->int_en_reg_none =
+			(plat->active_high ? DS1WM_INTEN_IAS : 0);
+		ds1wm_data->reset_recover_delay = plat->reset_recover_delay;
+
+		ds1wm_data->clock_rate = plat->clock_rate;
+	}
 
 	/* how many bits to shift register number to get register offset */
-	if (plat->bus_shift > 2) {
+	if (ds1wm_data->bus_shift > 2) {
 		dev_err(&ds1wm_data->pdev->dev,
 			"illegal bus shift %d, not written",
 			ds1wm_data->bus_shift);
@@ -553,14 +627,10 @@ static int ds1wm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ds1wm_data->is_hw_big_endian = plat->is_hw_big_endian;
-
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res)
 		return -ENXIO;
 	ds1wm_data->irq = res->start;
-	ds1wm_data->int_en_reg_none = (plat->active_high ? DS1WM_INTEN_IAS : 0);
-	ds1wm_data->reset_recover_delay = plat->reset_recover_delay;
 
 	/* Mask interrupts, set IAS before claiming interrupt */
 	inten = ds1wm_read_register(ds1wm_data, DS1WM_INT_EN);
@@ -643,9 +713,20 @@ static int ds1wm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id driver_of_ids[] = {
+	{
+		.compatible = "maxim,ds1wm",
+	},
+	{
+		/* sentinel */
+	}
+};
+
 static struct platform_driver ds1wm_driver = {
 	.driver   = {
 		.name = "ds1wm",
+		.owner = THIS_MODULE,
+		.of_match_table = driver_of_ids,
 	},
 	.probe    = ds1wm_probe,
 	.remove   = ds1wm_remove,
@@ -667,6 +748,7 @@ static void __exit ds1wm_exit(void)
 module_init(ds1wm_init);
 module_exit(ds1wm_exit);
 
+MODULE_DEVICE_TABLE(of, driver_of_ids);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>, "
 	"Matt Reimer <mreimer@vpop.net>,"
-- 
2.25.1

