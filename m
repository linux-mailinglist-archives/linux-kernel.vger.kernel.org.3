Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF723535007
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbiEZNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiEZNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80127.outbound.protection.outlook.com [40.107.8.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA4D80BF;
        Thu, 26 May 2022 06:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geyQhnkrMo1mBcTqbz6dAJ3fPH10VkU4B68zwyCRVMeJ3Et60rbZhLgdZa2X+YUBcSvqg3480z8SOpy9Z1aYp+s22x+rynHsAPJyAsKsPx+u8YR3NtJsAZ8Nr9AIekGQvp+RJ/Pcu2eDzT4BSaBsuMNiAMMrSGaD+xAVuDzKtojspVVTrzXTW/E7tB7hZlPAhRXLyFiWWU4In7p6gey/2dHpz6Z3PclhNJlp71T04fAptLRwTpTSSKmNNnhNluQSbzAdMsfOBBniXpFbbu/UVvkDTWqm3Ezc4D8M5sSj+nWHDXHBQcOXP9aYIwhlBR/BevS/voEMoas13UTrIpvGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+xk23cg8Anp2Mjf8M1Ay5KX+v1dGQLeLjM9VmER06Y=;
 b=meaOuwZi8Tai3MY92aiq4f6OG9peyn+UsmIpsWCyyFtf7QGFcVeKSOJRwKgS77Rp7++JVYa565aPeTajzNftJRJGHdEv9J6ypYxLKa9klGQdx/85UAIVSNDUstsKfPjzKCm7N4CIHGXaSiEbhoU4leJNyRy9VSkGMStfw/OeNqtGH/5e563GewFrWmSVl+tA2WWds7OYubp+mI/8/t525u+FlbXnJT3ukf1J/JPtt43yxxm36zQjmu/s/KDWgmnxzBbNo9GLqGR0fg2aqMI8YJu7Jmy8CC13Tv97BtKpOIMq5Kz0zGuPbweNRj38hDpwSPGi75NZbVBy+DqRxJVWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+xk23cg8Anp2Mjf8M1Ay5KX+v1dGQLeLjM9VmER06Y=;
 b=DMXn0PGC6Eyg7lmsoC4u3nFk3lz2RsYY90Nbqskkej7MKJ9Ze/2psnJiyXyiogeXagLJQxKkSnNIPfl44y2fgXk8D/4JAZIhuX8r4SrL067A05Mk8v9k7mmuHc/tWNwEdVvBJoBih3kyYb2gyevPWvOnNfR+zUxt7CyAE1JvC0k=
Received: from AS9PR06CA0004.eurprd06.prod.outlook.com (2603:10a6:20b:462::20)
 by PR3PR06MB6873.eurprd06.prod.outlook.com (2603:10a6:102:8a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 26 May
 2022 13:34:05 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::82) by AS9PR06CA0004.outlook.office365.com
 (2603:10a6:20b:462::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 13:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 13:34:04 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V5 3/6] iio: accel: bmi088: modified the device name
Date:   Thu, 26 May 2022 13:33:56 +0000
Message-Id: <20220526133359.2261928-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d463a6e4-21a1-4ecb-6779-08da3f1c6762
X-MS-TrafficTypeDiagnostic: PR3PR06MB6873:EE_
X-Microsoft-Antispam-PRVS: <PR3PR06MB687369808C7CE9E0FD6E2358D7D99@PR3PR06MB6873.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twWAZIS6RCnZ6oMWrv3r/SwDTq2bA15fz6fOFgsV7lz25/P9zlQ25/TfqAzz7dpIRXpRX6qpyokGkjybHkH6x/Cvk4e7Tjs8D0GAXU4cmbNXNau9BfjOBvjk0+wv8km9f+oPgG2ydJnOclK/EdxqLHGAZYSE7KAk23RYrKotP3ThrwiI7jgguuSFWs50SYJXRbMQPVg9tGOnkrMtJ9lARlmPIxXUli8fNQ3z52svgIdsHU5See9SMx+c/NcWQb4zXzJqYiNvQaMPvW7t7IW3Fcahx8R+IhRNyVBMHqmOyMOUPO1Hr4p5oNO1ADM5tZQgH7bU0FMDlmoKoVFNrPJmI9VzarSWCxUNEIImTgiKX+turE4QhR5f7Iv+EkGd5KqIcQJO48RAIts0a/kR4yfPn3BOgLPtbDtS82KkAip996tiOTr3+ESMv5pnGLTRSGfMd0Cp9aSzMYJOdkv89Tg2GKciXvV/mIB0vnLJerrsQWqKnmxI8XtweUUJVTtBes3p7c8QSA9n5TXSz39K2wEcI6RcdsHcmL9MhOY5czxq72BQCwqsnXUA11KApkbxezdUt1gZ/3GeB+90AWKWgGWacQFfcsHWvTBDSNvOCGVW9NiKbkPEkJYbbdrpzwgEpf+beF40KW7OZbIfpFwBxUlLiSxbfwdFO9GfIUs0BWBA26puxRcF6s0Y3KkSUw97byI7Q7ZjncHXzN72F1m8thCWFQ==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(956004)(86362001)(47076005)(40460700003)(316002)(508600001)(107886003)(36736006)(186003)(6486002)(6506007)(6512007)(356005)(81166007)(1076003)(26005)(336012)(2616005)(6666004)(921005)(83380400001)(2906002)(82310400005)(8936002)(118246002)(4326008)(36756003)(8676002)(70206006)(70586007)(5660300002)(36860700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:34:04.9982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d463a6e4-21a1-4ecb-6779-08da3f1c6762
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6873
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
index 73c1e2aecd7e..f6e44b36f5fc 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -389,6 +389,7 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
 			     long mask)
 {
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		*vals = (const int *)data->chip_info->scale_table;
@@ -464,8 +465,8 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
 };
 
 static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
-	[0] = {
-		.name = "bmi088a",
+	[BOSCH_BMI088] = {
+		.name = "bmi088-accel",
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
@@ -484,12 +485,15 @@ static const unsigned long bmi088_accel_scan_masks[] = {
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
 
@@ -515,22 +519,23 @@ static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
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
@@ -545,13 +550,13 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 
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

