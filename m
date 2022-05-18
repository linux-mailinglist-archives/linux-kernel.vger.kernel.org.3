Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0852BE37
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiERPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbiERPE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:04:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2093.outbound.protection.outlook.com [40.107.22.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E374012698A;
        Wed, 18 May 2022 08:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y74Qel23OLDYrjNf6MzxhLEDxPLwDxkbYFlPGaZ4bJAuuGrtRYKXnuRbShcIsNNdtZH5ynQqWYZBhCX3uuBSe6jyDNR2387U98MMCNn4dWZ43nqnm4tGUUnZ/+ZkgY5H028cLRc3AhuBzPuIc1Dp6wbfQeQDgwyTu8pr00QO8PH1GqlNQ2hMOp2hY95FJBe3cEWJNAUTtBkwJG+0MkPSwltaTv5dtIeWYKitjG8jC7+VAT55BKCoeeGuVN5RzMDmR4LdQOXBI5PcbJ/p+uvxiu8H/Fppyff4LeAkRkLgdP8p9h6/lZmYCRsZmTkkNLbIQvLDbYU7+JZMt5End/v3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3nVlUY3arakgnEbteJ31RLOHcKDB3NTycYAmSOOfek=;
 b=ahLI3QYrHsRPEvYTNnXCtCb9D97BM2wqD/2Z8tqXc/FVptDnlL1JbvhmAmQOvmWIvW0s7FUZW+JM6cWffiZu/44FSkBzwqKOwEr1wVqxPWecHXyHzxcoReeEIdGzZQf8n7poLccQiRb3iudFf5AFCQ22mlgQc21Wy/pd+qUO2Kyie86/2PKd7Oi7l6NIqcYU/0mGGkvyKno/9cvoSKI2jQQYbMeH2ZDzCjUw3u0oYY7tjIEQXeOdiUMvsYaUQt2RO1LU9aL7bl2D0brz6wYt0KjJSHtFn9Jr8/TIhdh3brcSoic9q6ouExy57Eucuj+TKOITMUo5eYa92jjno8RPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3nVlUY3arakgnEbteJ31RLOHcKDB3NTycYAmSOOfek=;
 b=TgK0NbWdfeG8EpPgXQBrOA7dstKywyC7cfv/gOc1xqKEDoTbAHYWBOmA0VarW+ANKcmbi0yymNYgm9IcLIKKxFvRqubWpH9I4WGK48tYG34U/U7McurUNEs7HNkndEcoWoeqmoUbk4Jv7OtX8mDRcTJDHpYp9cs957sipYL5SYs=
Received: from AM6P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::21)
 by AM6PR06MB4962.eurprd06.prod.outlook.com (2603:10a6:20b:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 18 May
 2022 15:04:56 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::6b) by AM6P195CA0008.outlook.office365.com
 (2603:10a6:209:81::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Wed, 18 May 2022 15:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 18 May 2022 15:04:56 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V3 4/6] iio: accel: bmi088: Add support for bmi085 accel
Date:   Wed, 18 May 2022 15:04:23 +0000
Message-Id: <20220518150425.927988-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 20e06780-eab0-4a9f-33f4-08da38dfc566
X-MS-TrafficTypeDiagnostic: AM6PR06MB4962:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB4962FDF82CB571BD3528D9A6D7D19@AM6PR06MB4962.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /joqSPPlr7tYB3bz3rWERkBRVy1x7P2qZrHTwpdCxKuSHjaMcytmD6gvWdGNiCPACDMN7EW1+1KB721TVRFBKeQ/1AEwz/33DtHZPLr4lbCM20jZ5g9M3KmUWognZyb6iqqAZlmnCZJir5MUc+Er2XcIeQt38rhob/LHh5YALD+Ti7XdpST7c2yCq0aC0ddJoY4Kk3JKwyrL9PJ4Itb42HwvofaA9kzqJ32NYbzWwO/LbgkkqKWKVK4DWkbkjdPHsKJtptJOm6D7SOdMkGKf/scPt4uOiFmaJ4iUEif4VOaGUgfI0V8oIlZEPcCWyV4XvDsEYztdtzg4CvjDJHK5X8GOzmOXcFrCl+8/QBbI24w5y0gq/mgmMXZP89vQp88ZDLsuCvk2cbzFP1TZ/q/sk4MHjS4Vw+F1CFZkRiNsUqdMHIEIsMgMqLh+QxTAZu3eUC7p7LYssY48YanFmF3QDN3ZBMg+MK9ou0JhFAx5VH6OqinKx55JtiThmDeeRfyI/OF/MUqjqrDTf490bN3a5EM6YIjwu4BTE2JKyvxlNxMK0dotoxx0MDipUonKxI6lGG6m4NngzY0JU/0zVPJ+jq1yxqIp9wpxS/lB0KYpXkjxCQjGNa3UgWXhohms/Mw/6BdIzp9iKKDZrCQm7gByrMhQuOKqLQ8WDZnsc/PJn1AfTxOFWGGlE7lG+htF/4TG
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36736006)(70586007)(70206006)(36756003)(8936002)(316002)(81166007)(40460700003)(356005)(36860700001)(82310400005)(508600001)(6666004)(336012)(8676002)(5660300002)(6486002)(6512007)(1076003)(6506007)(118246002)(186003)(26005)(2906002)(956004)(2616005)(86362001)(921005)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:04:56.4206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e06780-eab0-4a9f-33f4-08da38dfc566
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports for BMI085, an Inertial Measurement Unit,
with an accelerometer and gyroscope.
The commit adds the accelerometer driver for the SPI interface.
The gyroscope part is already supported by the BMG160 driver.
Different from BMI088, the BMI085 accelerometer has the range of
+/-2, 4, 6, and 8g.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
 drivers/iio/accel/bmi088-accel-spi.c  | 2 ++
 drivers/iio/accel/bmi088-accel.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index c30c2d510b92..d5e93ac7f1e1 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -464,6 +464,13 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
 };
 
 static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
+	[BOSCH_BMI085] = {
+		.name = "bmi085-accel",
+		.chip_id = 0x1F,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
+	},
 	[BOSCH_BMI088] = {
 		.name = "bmi088-accel",
 		.chip_id = 0x1E,
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index 24cdeb41d2a6..f2cd70f362b8 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -62,12 +62,14 @@ static int bmi088_accel_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id bmi088_of_match[] = {
+	{ .compatible = "bosch,bmi085-accel" },
 	{ .compatible = "bosch,bmi088-accel" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bmi088_of_match);
 
 static const struct spi_device_id bmi088_accel_id[] = {
+	{"bmi085-accel",  BOSCH_BMI085},
 	{"bmi088-accel",  BOSCH_BMI088},
 	{}
 };
diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
index b6a0281a847f..9b23f50c8271 100644
--- a/drivers/iio/accel/bmi088-accel.h
+++ b/drivers/iio/accel/bmi088-accel.h
@@ -9,6 +9,7 @@
 struct device;
 
 enum bmi_device_type {
+	BOSCH_BMI085,
 	BOSCH_BMI088,
 	BOSCH_UNKNOWN,
 };
-- 
2.25.1

