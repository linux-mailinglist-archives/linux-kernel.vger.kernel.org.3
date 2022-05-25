Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847F5533D54
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiEYNI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbiEYNIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:08:46 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140102.outbound.protection.outlook.com [40.107.14.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10DD4BB97;
        Wed, 25 May 2022 06:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5bHPaxoqlXZUVelWHJOQKCKSQfVhDZ2QCzmJ3Vce/jMxUxRdgfbNE2Dk6zhed6td0i1lrI4YvV+coPOoZvYZ0WZ8TK3clopZA5uX4MBhjkbFzbOvXyw/+H3ut9jxEI+1TCnLUO39plBg92RZ6uC79ZIkiI1mE73Hk63gZyb/hGcbJgkzqZQTXfbjzDGwtFN5ShHqf6SqklbQ4g21ArvacTnd2Qfvqk0WEK7yRFOPY5bcdWZMS8AciDKoBGPVvDaMjBh84GYrj7tm+WOsnf72GdwudWAgZOXmSsjT0cS6/n6D845HFeaggikWXNSgUS1vJLv6twPSORAIi45LtpFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XFlk5WFuK2cIX5Ys1DBdTbS/G49IjssPCzOyKESzWE=;
 b=A+txutBfLC1Z6SrbbHFhuCr/cosbX2IgQxDzAkTFFOqnzTSObkLWPCDzUv0tS1rE83Clo/45qQJRxpL9mUaWIJ4Pj86YDcR+YCKyZN1t/t2pQQbbFSzougS80zj8HRR/jo4j1sCtTTnaLJ0mHGXgQgNNFSl/UgW3x0TW/vIgm97GBIZSHOOlEXizihAvPTzPEBG8+SqbIxjGvVLNUKRAbJyWJJirvyTO45nNbVzleFRGPslC3o6qMrNI+AjzW53Syqowja5pPrFxwtrWJhtL8AQEgBMm7CzTDnR3FBHB5CIrXhAOaiyaeNd0JrXOhgluiFLeiv7uNMep58xyqrHVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XFlk5WFuK2cIX5Ys1DBdTbS/G49IjssPCzOyKESzWE=;
 b=dSYGEEwY65nvrlf6CmSLd+YqTIOD9j1nxopwJqpbcYf8vsurEAhasCXKmiG9+BT50kZVC4nJzdDIv0L/+JPwPuufc19N4qvq2XzmK+cgr5gXLz9mS31U/NG6KFRxxCsc98Z2xQ7XhSDWfVYZcdLJeRcsUXqFMfV4xH9uTUMExH8=
Received: from AS9PR07CA0008.eurprd07.prod.outlook.com (2603:10a6:20b:46c::6)
 by AM6PR06MB4785.eurprd06.prod.outlook.com (2603:10a6:20b:5b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 13:08:42 +0000
Received: from HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::84) by AS9PR07CA0008.outlook.office365.com
 (2603:10a6:20b:46c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 13:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT051.mail.protection.outlook.com (10.152.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 13:08:41 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V4 3/6] iio: accel: bmi088: modified the device name
Date:   Wed, 25 May 2022 13:08:25 +0000
Message-Id: <20220525130828.2394919-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8bc52cca-fc9a-4257-baad-08da3e4fb0f7
X-MS-TrafficTypeDiagnostic: AM6PR06MB4785:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB47856D385C96E3B3AB1CB564D7D69@AM6PR06MB4785.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRESdfyt6eV85kIAIV+L1SlpOiAS7aUHepSrRQ33N7qVNNCG6PkOarJbMDKDw1w1I8X7THlpJ1l9LTE3NIPE2twu1JWrUW3xYxVc1Z42HQlF+o2vdVwChKJANKpoBWkMlh054GNStBnbqlbza68FfG4kZF7qKJWOvlNzX0vfjJNvlzdykB2GF0zjz5OVya3GO05OA3nVBYJT1cROjjhJIO+GEolNpCJJbfchdHdPSnLjnFd665ue4lg7nY5UzcBulOtqmZT7eWOuKkn2vJSTfgpoZW4C0+PmG4LiXGurnO3fHeVjSuaw2NAvSKBIXxzJaT/xwZwypL93VtVblqHIxT8i3ZXCy8CvKe0JaQKucJvBAgt7R+3P0vPOkQAtA4vfj13NaoPx7dg8rATmLDHL8eX8RNon/flRHn6Kb1+MBCVSb2jSYw1D10TzKI3unwlVxnsva7Did487WgAWVPnCFz5LZtQsrmM9xJsGsZTOmXbPxSUJGn/VsCf3caKgHFEkRMU4oGXuyI2uO146B8WGZj3O6bSGbVlW1jptXODkQKUalBdNT/ccb2jqW6awk/Stwx95qEmKn42McAKUllQQQqT/EEl7Ab+WxP2SN6WZpZs6NwFfArU67nvy3cSzeJZXmwa1SmNN5U0dlVadcfH/ZaOw4iYkeXBizTilQI98zJ4lsFOqc3sh27AtWixbtxcxApLdm9plUwJTeKOYHsLBmA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(70206006)(6666004)(6512007)(36860700001)(36756003)(118246002)(336012)(6506007)(8936002)(86362001)(82310400005)(508600001)(186003)(83380400001)(6486002)(2616005)(107886003)(81166007)(1076003)(956004)(5660300002)(2906002)(8676002)(4326008)(26005)(921005)(316002)(356005)(36736006)(40460700003)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:08:41.3554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc52cca-fc9a-4257-baad-08da3e4fb0f7
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4785
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
index 16c95d90f829..fe8db9615d69 100644
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
index 06d99d9949f3..c77aec01bc67 100644
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
 
 static void bmi088_accel_remove(struct spi_device *spi)
@@ -61,8 +61,14 @@ static void bmi088_accel_remove(struct spi_device *spi)
 	bmi088_accel_core_remove(&spi->dev);
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
index 5d40c7cf1cbc..65338a1bf97d 100644
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
 void bmi088_accel_core_remove(struct device *dev);
 
 #endif /* BMI088_ACCEL_H */
-- 
2.25.1

