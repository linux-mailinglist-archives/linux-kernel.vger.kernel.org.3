Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397E7521D19
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345921AbiEJO5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbiEJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70105.outbound.protection.outlook.com [40.107.7.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F324F0EC;
        Tue, 10 May 2022 07:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5eMHorbsDu17GTg7nznZsu9tDGY0DI5EQPldpZ+oPAgo42ikg65fyCux6/LIrFRRwqmQkQPh6pnmdIXyYEhU4fNmhJCsDCvNXaSkMr3JaNLeU9QM9uikfeuOPjwGTJEh5h1hyyR+UaMqzFnIQ4mW+DPZ2lclKlKj+AI1VDBTzEGJWmo3NlPRiRlN8Nl5HNR0B2P4dvGmCRe0xxKW6ojrDcFHh0rHgUm2r44v2igkyEOSiG85Yx8okWKxFkMRVJeVVBCSX5EdggGmfkWHWWsCV6gYmQtxUBxwrCpVONXKBv8p9x1Puon6by6mrR6+ClfmuPZWVT8wZFq0MpXQpWLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3cMHB+LzBVsn+w7tvL/rA+OnSjsKpw6mWub0Ro73ck=;
 b=RijBpcToZ4MVjtRYbruIzDB/oheFAaO6lg2CXBQIc3uk+sMPC6t/Kxcjs/7VkVgL/93rWI7hsI8whquYkcUjK1l2qNmRs/VoalQcASTEJDcR92Rn7mzzEwekB3OKLjav9mIUo5N9u3Q6oV3pGRPFIkrGoPrUC8CqYkToJG+84U+73ZWZrZJR1rt26Anarb82VLzKdYf4gHRi4Kkd9ejpOLfhwTj1vDf62s8Jn8lvQ62kZdOtw6Fb4Zi+DTTRHc1Otuf0iMXpFzUt0DhUpCQkMkVtLDHYBbv+DmUXZNY55wLt0h8L2qXVF2IdkZ8iiit0Ij7b3FlRse1ZPDCi9QhztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3cMHB+LzBVsn+w7tvL/rA+OnSjsKpw6mWub0Ro73ck=;
 b=oKWoYlzvWHNPJOnE7bOZ0nHs7kQkFY/Y2TsRNLIEbZ4qfENsL8XCP9ij3xElk75jo/oiKefrO0GpSPMC94XipO7vNV9dEj+fxRP1VQqsfiW2/lxLmdeO8Ovhp0krSBO+zEQ8V+gGifcYVxTZVIfx9N+J84C5l0vTlTZdn0QPvFE=
Received: from AS9PR06CA0338.eurprd06.prod.outlook.com (2603:10a6:20b:466::32)
 by AM6PR06MB5955.eurprd06.prod.outlook.com (2603:10a6:20b:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 14:17:58 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::c) by AS9PR06CA0338.outlook.office365.com
 (2603:10a6:20b:466::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 14:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT083.mail.protection.outlook.com (10.152.13.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:17:58 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: [PATCH V2 3/6] iio: accel: bmi088: modified the device name
Date:   Tue, 10 May 2022 14:17:50 +0000
Message-Id: <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 99fbe679-65cd-4b65-26d0-08da328fe24c
X-MS-TrafficTypeDiagnostic: AM6PR06MB5955:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB59553F1A34FD8C2AF8EBADAED7C99@AM6PR06MB5955.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WnNV4LEoPfSR/C2bLGyDb1CiIo+rHjicDRqDIWWxHfWAWETapVys5LH85PVdTvFlyi9Nc5Ns/F9Z2TH7kMMMI6TC6xtcD//DGaMU+XoB4wE3cM4G4y/4sVlSreq7ghB9St6OfUjxtpTyiJ8hTXB/HIVmo0FAIeXLW9O9qEsbad0nihhfx5HOT3GGjhIRRgDkuwIKFdjESnEPLUioo4ak9VtL5ymuUL+3l0b7ljeqBVOi82OLceczU7UNH5dB7U15OqsWZIviSeKOQ4PwdWhboYXggCIU+tvKvZBrn5Yw1skU3pfEKA1Iengm8CzPh3GNm5atpm8vX6fqr4EoMe5Q/EG4lC8yTbBznTm8Uv04Apwty+DIFn9dGXdUMQ9e/lM2raKZq1G5xu+5r90jlEqiaL6Nt3Ru1cVA/wQepWnt9Lz3jS5lJ7z58SHCm0i3EpBqw6o5P9SkvZv3CwCD/dq4Jr08XtyQ2xLt1V3REsIU2aVe3p3K3B4uKy+B/VlREGEFSmI/5XBnlgYxmki706fWFjA+OSB7vJSuGHbS+ZUSV0lniRaHy7YYT9zB/0557n+ULrrd7KIWlRH/yyBTBE3XJVl+PUYmrCxfyIPbZ2koE/hSCatslnmyIhQr0mELxMz9nXrWtfd4p15mvZLEPBFLH5BHzDZIOIKmeh0/B5tECAVnmxL1jq+65Lyc8MIjprBKBQ7dzYPbMY1HdyhA2X1csA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(82310400005)(921005)(81166007)(118246002)(83380400001)(36756003)(2616005)(8936002)(70586007)(70206006)(36736006)(8676002)(26005)(47076005)(40460700003)(6486002)(956004)(6512007)(36860700001)(336012)(508600001)(316002)(2906002)(5660300002)(186003)(6666004)(1076003)(6506007)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:17:58.2356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fbe679-65cd-4b65-26d0-08da328fe24c
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to have multiple sensors connected on the same platform,
To support multiple sensors, the commit makes it possible to obtain the
device name by reading the chip ID instead of the device-tree name.
To be compatible with previous versions, renam bmi088a to bmi088-accel.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 6 +++---
 drivers/iio/accel/bmi088-accel-spi.c  | 4 +---
 drivers/iio/accel/bmi088-accel.h      | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 8fee1d02e773..de2385e4dad5 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -459,7 +459,7 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
 
 static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 	[0] = {
-		.name = "bmi088a",
+		.name = "bmi088-accel",
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
@@ -524,7 +524,7 @@ static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
 }
 
 int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
-	int irq, const char *name, bool block_supported)
+	int irq, bool block_supported)
 {
 	struct bmi088_accel_data *data;
 	struct iio_dev *indio_dev;
@@ -545,7 +545,7 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
-	indio_dev->name = name ? name : data->chip_info->name;
+	indio_dev->name = data->chip_info->name;
 	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi088_accel_info;
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index dd1e3f6cf211..0fed0081e1fd 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -42,7 +42,6 @@ static struct regmap_bus bmi088_regmap_bus = {
 static int bmi088_accel_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
-	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	regmap = devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
 			spi, &bmi088_regmap_conf);
@@ -52,8 +51,7 @@ static int bmi088_accel_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
-				       true);
+	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, true);
 }
 
 static int bmi088_accel_remove(struct spi_device *spi)
diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
index 5c25f16b672c..c32afe9606a8 100644
--- a/drivers/iio/accel/bmi088-accel.h
+++ b/drivers/iio/accel/bmi088-accel.h
@@ -12,7 +12,7 @@ extern const struct regmap_config bmi088_regmap_conf;
 extern const struct dev_pm_ops bmi088_accel_pm_ops;
 
 int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-			    const char *name, bool block_supported);
+			    bool block_supported);
 int bmi088_accel_core_remove(struct device *dev);
 
 #endif /* BMI088_ACCEL_H */
-- 
2.25.1

