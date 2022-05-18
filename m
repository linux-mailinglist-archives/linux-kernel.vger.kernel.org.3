Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067652BDEA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiERPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiERPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:05:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60120.outbound.protection.outlook.com [40.107.6.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF61766AEA;
        Wed, 18 May 2022 08:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc63RNKF6KPM5f8HpYnNQSKdowRQwR7cQTit/VFE0ejcb0HHxwOWrMfdVcv+eb0Az2aYXNE8jcISLZUNHd7hWmmG16mPn6S86juKQdFsTeOLPcgcEf9vh2Ha/6B+t/yhg1v9SJccsy8aH/5QivD2mwE/xIRHBEaaDKNh89pn/shJw4BRuW/a7vHTvOPUW6X3XdRxSjpHZeAK3sxutrN0Tl7fi4p0n/i5GLpi0r/WXuUbdqDQJFdqwNPzqFhAgaxof+kg5GcYsU03gVrL/m59JQecJ3sIHXQ1JBjZY73MfkSI29YyqZTbQolJS/OpvdIC6M164nYIcWl7/1b25YtiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H523Zh88b9B/1TgO3VcudpPlZ336TqyROCpGQQIxntw=;
 b=PUcI0LcWe3EbiJ2Lq4HE5Y07bkem8dXWjyCIepoHb8WDhd6WPMkcblbciYUqZqfRR7m1GP32USn1KbwRYaY1c++cjheTb64wJGmJwmHhojTRvBbq2W6CNSqs/MpkZGagq0PtRwWtAcVYnHBAXUsQOJtQhqcHeDZtZ53ObeOh0T2EwTans7htk3f0gG7+g6rqSIPK5Z1A/op/OOf981nCqtWLNKoOVZcUW3fyawRjoq7SzPQR1GzMKdTVWFLJtn3tbm8ZoqX5RsnRqHcplxJ/rEh1HsKR2Mov6Vqqu9DIoLx/YQZjx/ar0DLjGUwX6E51M/kwtY7iDqL34wADj+fr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H523Zh88b9B/1TgO3VcudpPlZ336TqyROCpGQQIxntw=;
 b=pVCt7b3KmnPkP6fm2bRxPlLcKsrLlzze5foSn8BJkMrJG59Sb2KuGYQlrQPVBWLde4dwo6+V9BA4RSGuUy59E9E/Wcw6LOTU3tNvocyOycsgnAmvsGevZUciNBt4qW6c1NYobpZw9f5BjSl9rZUIAYZ0DlaP/XSiM1rxkcYiviM=
Received: from AM6P195CA0016.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::29)
 by VI1PR06MB4301.eurprd06.prod.outlook.com (2603:10a6:803:68::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 15:04:55 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::a7) by AM6P195CA0016.outlook.office365.com
 (2603:10a6:209:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Wed, 18 May 2022 15:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 18 May 2022 15:04:55 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V3 3/6] iio: accel: bmi088: modified the device name
Date:   Wed, 18 May 2022 15:04:22 +0000
Message-Id: <20220518150425.927988-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f9bd7cbb-37ad-49de-7925-08da38dfc4c6
X-MS-TrafficTypeDiagnostic: VI1PR06MB4301:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB4301D39F99BBF7449D012C63D7D19@VI1PR06MB4301.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjGVAZ0059iIhSVrkIrZpWxZV/z9i8fKEgeqxs9L/mtmCrbJa1VGZRGbkaja5SceBpucNmS3pOi1TG8Wu5d5KkyUHHR/xghDUif2ewS+7YKqY6y3/ZmeqCQ6fVcjK+v3vgI3uRU2s1zlmBSrVWqGePcIWGpOIpNQyyQvaXaWq22XP0JVFk6dq3Fptc2wzPvhp4+HuETy9MWddVqeQgX9lMJjSeBpdY8N591OQaHu6Wjdxf83FsVbWgfj0rJjFgbH5LNddHMS2HrgGnH0XAJ3LMbDTD7FmccIhKXb6HwG1iPXMuruqCxPINE7Caaw1pHaLI4N8U7goFzmuooce2hRvXQFjIN9C+i3xn1FwF424wudc62RUZ+j6ywQwhvzmg9JichizzaUNgM4NRf0DW9Gn3+vz3rIQ3sm2a12d7BDsVj3CxfbEi1QbGDxhA/7FJu9P06NKyYNqTq5JqacSM3yJJsaBYs9iVB2Eh4+3mxhmgGGB/oL+8AtEN+6R2Ux5BH157gZ8ptmGAyIUFLahk8DwEy1HWxyUMaAgatQRwpyDzLddwfC0STQTd3HiYVm4/1ZSPr98Vjl3lnAf9uP3LqqzW/6oe7qp9axgznFsruBbSaCFjUxuKZDrQbsuxsTnkWp9INLWXco8x6Ym8jeJs6PFivMBwj826Rv5dM1N8uj8lEQUuKDLHEEr3wVlSBMcRxOacXutGJxr/+UEI+s02/+Qw==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6506007)(6512007)(6666004)(8676002)(36736006)(47076005)(316002)(356005)(921005)(70586007)(6486002)(70206006)(118246002)(2906002)(36860700001)(86362001)(82310400005)(26005)(83380400001)(5660300002)(508600001)(2616005)(1076003)(956004)(186003)(336012)(36756003)(40460700003)(81166007)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:04:55.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bd7cbb-37ad-49de-7925-08da38dfc4c6
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iio: accel: bmi088: modified the device name

It is possible to have multiple sensors connected on the same platform.
For support of different sensors, making it possible to obtain the
device name by reading the chip id. If the device was found in the
table but the device tree binding is different, the driver will carry
on with a warning. If no matching device was found, the driver load
the binding chip info.

Tested case, test with bmi085 and bmi090 patches applied:
connect 3 bmi090l to the system, and set device tree compatible:
spi2.0: compatible = "bosch,bmi090l-accel";
spi2.2: compatible = "bosch,bmi088-accel";
spi2.4: compatible = "bosch,bmi085-accel";

Get a warning for the mismatched devices:
bmi088_accel_spi spi2.2: unexpected chip id 0x1A
bmi088_accel_spi spi2.4: unexpected chip id 0x1A

Get the real present device name:
/sys/bus/iio/devices/iio:device1/name:bmi090l-accel
/sys/bus/iio/devices/iio:device3/name:bmi090l-accel
/sys/bus/iio/devices/iio:device5/name:bmi090l-accel

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 35 +++++++++++++++------------
 drivers/iio/accel/bmi088-accel-spi.c  | 13 +++++++---
 drivers/iio/accel/bmi088-accel.h      |  7 +++++-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 563bcc311844..c30c2d510b92 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -388,6 +388,7 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
 			     long mask)
 {
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		*vals = (const int *)data->chip_info->scale_table;
@@ -463,8 +464,8 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
 };
 
 static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
-	[0] = {
-		.name = "bmi088a",
+	[BOSCH_BMI088] = {
+		.name = "bmi088-accel",
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
@@ -483,12 +484,15 @@ static const unsigned long bmi088_accel_scan_masks[] = {
 	0
 };
 
-static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
+static int bmi088_accel_chip_init(struct bmi088_accel_data *data, enum bmi_device_type type)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret, i;
 	unsigned int val;
 
+	if (type >= BOSCH_UNKNOWN)
+		return -ENODEV;
+
 	/* Do a dummy read to enable SPI interface, won't harm I2C */
 	regmap_read(data->regmap, BMI088_ACCEL_REG_INT_STATUS, &val);
 
@@ -514,22 +518,23 @@ static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
 	}
 
 	/* Validate chip ID */
-	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
-		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
-			data->chip_info = &bmi088_accel_chip_info_tbl[i];
+	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++)
+		if (bmi088_accel_chip_info_tbl[i].chip_id == val)
 			break;
-		}
-	}
-	if (i == ARRAY_SIZE(bmi088_accel_chip_info_tbl)) {
-		dev_err(dev, "Invalid chip %x\n", val);
-		return -ENODEV;
-	}
+
+	if (i == ARRAY_SIZE(bmi088_accel_chip_info_tbl))
+		data->chip_info = &bmi088_accel_chip_info_tbl[type];
+	else
+		data->chip_info = &bmi088_accel_chip_info_tbl[i];
+
+	if (i != type)
+		dev_warn(dev, "unexpected chip id 0x%X\n", val);
 
 	return 0;
 }
 
 int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
-	int irq, const char *name, bool block_supported)
+	int irq, enum bmi_device_type type)
 {
 	struct bmi088_accel_data *data;
 	struct iio_dev *indio_dev;
@@ -544,13 +549,13 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 
 	data->regmap = regmap;
 
-	ret = bmi088_accel_chip_init(data);
+	ret = bmi088_accel_chip_init(data, type);
 	if (ret)
 		return ret;
 
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
-	indio_dev->name = name ? name : data->chip_info->name;
+	indio_dev->name = data->chip_info->name;
 	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi088_accel_info;
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index dd1e3f6cf211..24cdeb41d2a6 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -52,8 +52,8 @@ static int bmi088_accel_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
-				       true);
+	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq,
+					id->driver_data);
 }
 
 static int bmi088_accel_remove(struct spi_device *spi)
@@ -61,8 +61,14 @@ static int bmi088_accel_remove(struct spi_device *spi)
 	return bmi088_accel_core_remove(&spi->dev);
 }
 
+static const struct of_device_id bmi088_of_match[] = {
+	{ .compatible = "bosch,bmi088-accel" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bmi088_of_match);
+
 static const struct spi_device_id bmi088_accel_id[] = {
-	{"bmi088-accel", },
+	{"bmi088-accel",  BOSCH_BMI088},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
@@ -71,6 +77,7 @@ static struct spi_driver bmi088_accel_driver = {
 	.driver = {
 		.name	= "bmi088_accel_spi",
 		.pm	= &bmi088_accel_pm_ops,
+		.of_match_table = bmi088_of_match,
 	},
 	.probe		= bmi088_accel_probe,
 	.remove		= bmi088_accel_remove,
diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
index 5c25f16b672c..b6a0281a847f 100644
--- a/drivers/iio/accel/bmi088-accel.h
+++ b/drivers/iio/accel/bmi088-accel.h
@@ -8,11 +8,16 @@
 
 struct device;
 
+enum bmi_device_type {
+	BOSCH_BMI088,
+	BOSCH_UNKNOWN,
+};
+
 extern const struct regmap_config bmi088_regmap_conf;
 extern const struct dev_pm_ops bmi088_accel_pm_ops;
 
 int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-			    const char *name, bool block_supported);
+			    enum bmi_device_type type);
 int bmi088_accel_core_remove(struct device *dev);
 
 #endif /* BMI088_ACCEL_H */
-- 
2.25.1

