Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA2533D48
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbiEYNIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiEYNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:08:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70098.outbound.protection.outlook.com [40.107.7.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C9A2062;
        Wed, 25 May 2022 06:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0S+Oa6KVetd7DRLa+vMfI5AZrnZHcSg4cQGlMllcjuEizUMIpDyejn+7fgMZyR/Y2xbfbTB1K9iuS30V9y91S7Hzr9ONM9wShMxV+vmSqNEtdfsftWj1ROmirKJgL9Fxz/tf3frHim4fKsERnIpNdD5AgkzJX4285IRwN4HQq4V06p8Kf5sZSgZ01okMpP1rxHtcuAGExDh2kmSnYeDOBVqBT3ZNGu7TuTKuiry1WD7zWkfjFi8A/9OZUMqp5+5Tn4A1HAQ5yTkfPmtkXrTnqCm6mjGuUKGVUFVbVEjevULpAtOqIc9vg+KF+SRWuqar6rzUCXaI7T8CWm7dadHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9YoyUl4Jwgq9M/1fNZmhEW5S01RQSaiaLfksrOzzJo=;
 b=MJTW1GnkDfj8vh/ggySOW/NadOWy6gtGB5y05nG6bMTCUp/818BpeRf+H8TsyyLUQ9MFtRxGa8uAwbfrKUR9TT5JpbvTcBkmnzgubGW/H4L8sZvJMwUlndL3JvqrmvjOVFpYw13THj50uk8zdmHivRtJUfm+pAACfPI2bydOhlnW7QZoVeqfWTdPqUzlTX9HS1v/qqMmnHFGxHa1fWRi1SFvZx7Wqpeps3hcpknU3dBa22TnwoNXjK4N8+35tgtx+ihcVd34rwQwdBakoPuiTdvVusZhbmrOZSbPfnmqDWUH5BcBxvl3iSkZqFzG5cXHCVp6qrjPln3uEHSWj56dRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9YoyUl4Jwgq9M/1fNZmhEW5S01RQSaiaLfksrOzzJo=;
 b=KwE+BzCQtbVmY5ei48E3392Sk89IfXI2D7SX+9CnrQ7nqwLVjlxYmOssVa4wpQb3Pq6bkRvVKcMrx2YkF1jvcZAlFynSRflUdk+5SS0H0RjEda9gnFnppm5/4JwTz9sqWgt4Xw+TpjFue+0AqqWxB+8/rrmHJZ7PXiBhUsIE97Y=
Received: from AS9PR07CA0017.eurprd07.prod.outlook.com (2603:10a6:20b:46c::13)
 by AM9PR06MB8052.eurprd06.prod.outlook.com (2603:10a6:20b:3a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 13:08:40 +0000
Received: from HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::38) by AS9PR07CA0017.outlook.office365.com
 (2603:10a6:20b:46c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 13:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT051.mail.protection.outlook.com (10.152.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 13:08:39 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V4 1/6] iio: accel: bmi088: Modified the scale calculate
Date:   Wed, 25 May 2022 13:08:23 +0000
Message-Id: <20220525130828.2394919-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0c4aaac0-2aaf-47a9-4181-08da3e4fafb8
X-MS-TrafficTypeDiagnostic: AM9PR06MB8052:EE_
X-Microsoft-Antispam-PRVS: <AM9PR06MB80521B75EE9793BD852094B3D7D69@AM9PR06MB8052.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 870euEi/ecb5RwL52R/o2k5cxIfySJESZa5uGH3KTW8aATKfulDmv/B5vIuuKsZzb1WqkrGlLPGs5ftaRo6TVvVagiJsrCELfC2pf1xFjMONHiblEgQtXkaZCxykoyTXC03IKDJ836tR3jAnabeKzDsX2haN94yFIH6kPEo0QCYnQI+EmVH3NIqRlxFflqhAK27PVkhmPchDt9WRJP6fuPbIyt79xGSjHHaa39lw3EjhAvWwIsKHHkMn8eulZVNjDi9r9eWWNYWvGlpl2XR6dNssmmSb02kdlzYHVZ43KFm8SwYDRm5XhKzQyNHKA0VJlXFADffPAT0Jx//I/+L/piB2Yb2nBUhyIb+dZ/WAaKFrpNNvjg9HxO2ZhZcBXE+UbMyeOl5LdYiJFF/lgjVn9+1YEDUCHyfSbbzI7us23Krh2UvlJKQcRlt0bMDCuxINIAKnkUPSubnOxbx0QGqw2OAlKsmAvKoZsgdkT8TMiGojKpsDEP7K5CcRt7AND0P0Pbz5ApGqfpo8uGuAhb3Mrph0Zmnc0S4FyfyLVp7CIHJCk5gNKKdo3V2Ax+DS0673oKJev5S01GHpamfwPtRJHuDulfoc4/GVTKmEVwlgGKamou+EqcqtwLZoiF8ubyqOQYEv9SnnCah1DdxZ6Qch4svNv/yNucLnXlSD8dXzuLN36vOMAIMJzU0lJk59L+lwtYkbQbkOW1H+WxagetThhQ==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(956004)(107886003)(2616005)(316002)(36736006)(356005)(921005)(86362001)(81166007)(6666004)(1076003)(8676002)(70586007)(4326008)(6506007)(70206006)(6512007)(508600001)(26005)(2906002)(36756003)(36860700001)(40460700003)(6486002)(186003)(118246002)(8936002)(82310400005)(83380400001)(336012)(47076005)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:08:39.2617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4aaac0-2aaf-47a9-4181-08da3e4fafb8
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The units after application of scale are 100*m/s^2,
The scale calculation is only for the device
with the range of 3, 6, 12, and 24g,
but some other chips have a range of 2, 4, 6, and 8g.

Modified the scales from formula to a list, the scales in the list are
calculated as 9.8/32768*pow(2,reg41+1)*1.5, refer to datasheet 5.3.4.
The new units after the application of scale are m/s^2.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index d74465214feb..3f38967c5a0a 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -73,6 +73,8 @@
 #define BMI088_ACCEL_FIFO_MODE_FIFO			0x40
 #define BMI088_ACCEL_FIFO_MODE_STREAM			0x80
 
+#define BMIO088_ACCEL_ACC_RANGE_MSK			GENMASK(1, 0)
+
 enum bmi088_accel_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -119,6 +121,7 @@ struct bmi088_accel_chip_info {
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	const int scale_table[4][2];
 };
 
 struct bmi088_accel_data {
@@ -280,6 +283,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
+	int reg;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -330,13 +334,14 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 				return ret;
 
 			ret = regmap_read(data->regmap,
-					  BMI088_ACCEL_REG_ACC_RANGE, val);
+					  BMI088_ACCEL_REG_ACC_RANGE, &reg);
 			if (ret)
 				goto out_read_raw_pm_put;
 
-			*val2 = 15 - (*val & 0x3);
-			*val = 3 * 980;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
+			reg = FIELD_GET(BMIO088_ACCEL_ACC_RANGE_MSK, reg);
+			*val  = data->chip_info->scale_table[reg][0];
+			*val2 = data->chip_info->scale_table[reg][1];
+			ret = IIO_VAL_INT_PLUS_MICRO;
 
 			goto out_read_raw_pm_put;
 		default:
@@ -432,6 +437,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1794}, {0, 3589}, {0, 7178}},
 	},
 };
 
-- 
2.25.1

