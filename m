Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6407951F4FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiEIHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiEIGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E34119CED7;
        Sun,  8 May 2022 23:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx3EsVaDxiPSNqnq1X6dYXrE78Lx7BvSoY+zNRIeNsTE8NtuehKyr8ZUe2ao/Hes93wNU+jkC6qJBczpGgKW1gpMaKhfuNvz0ly+iAlB8DXyzvJANvMnC2s8nwB6+HYjPiCkI+1ZoXQp24Dp3Q43OVfc2lwTXCmR5MEG96NVnxk7LSK3wsounfqMxaqCp0r7gYOjKWL42j1geojYRTFeoXKEF0tLiTXTxz41TXItwsm0qF4EiJcbWFrP8ep6tf+/TKAzmjSFFEsTVePY1UQO78jTpo8Jw4m7rP0fD5FX7PNUEvox5ya3U/r/qT4JwTnh3/Iz5bxI0ttFBfGfaejsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeSz0fhmgis+L/1a9AQDdLJzOKbEiClYIR70D3qiwPk=;
 b=e7DFETQsgYkXFMflDwmjAQdTnfVGhG06PUKKkIK2NuVwNzEgXl9mRGvjbe5GYdU3zKxXVtaAoj1U0khmuAKF6QVs41nJvcyJrznoPZ4SQ4IogOp8u64iPqncb8hiGTaeUtVMxOtPo5Qvs6g+NYwggR9I8AOudz3tJ8QTMft7+CJJ7wxM6KvTBwUHZbv+doBIORm3JfOX0BBNTE3d4Bexe8geEeXAddG5g66XqEzHV6+BIQDFQk3F4g1tiO3KUustD90cC9GuvEWrwuuzO+jO8upggl+hhWxN5K9w/WrPsqymYeF9R9fJfQH7sFk5z/cuSWL0LcP53iBLbXIg0NW0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeSz0fhmgis+L/1a9AQDdLJzOKbEiClYIR70D3qiwPk=;
 b=zr5ZVtGqlzH4V5qlg7aEfMV+FugYURewU/gJHTpm9NG0BO0z7IuZLbq7lQTdFTQKdllbLYEblZk3WyWXxEc1LBtz4OXswLofBuc9VqcO731UrXIF7VZJCRKtTPCIdGtHBDuc91dV9u0yfIchMddOa3qMNgjiXyJIC75miw3hxAw=
Received: from BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::16) by
 DB6PR0602MB3271.eurprd06.prod.outlook.com (2603:10a6:6:10::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Mon, 9 May 2022 06:49:37 +0000
Received: from HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:b10:a:cafe::a6) by BE0P281CA0006.outlook.office365.com
 (2603:10a6:b10:a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 06:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT040.mail.protection.outlook.com (10.152.11.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 06:49:36 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V4 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Mon,  9 May 2022 06:49:27 +0000
Message-Id: <20220509064928.2352796-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6b2ec6bd-7029-49bb-93a0-08da3188152e
X-MS-TrafficTypeDiagnostic: DB6PR0602MB3271:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0602MB32719692326EB5618DA8E23CD7C69@DB6PR0602MB3271.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0p7cFJRV3s1gM5TBDmmRtJxHDIcGHpx3z3JB0d99HzKpRwHfprwH+NST0grhnMC49KYyRY9wj4/g9Y5ACKmPIWBNfHYgglkbqdO8lvRTLZuND7s1faJJ9kRxXyvg3zRISBghd+6ABe++k4JvtzRegujf4S/t3uWpX2er+EZK7IMGx33mHeqee05v0OrJOaWvfneSSCNhmpf+Dfmd+WOAHpmqQijEKXKhUJbvhsvvKOlCcYhKrSM/PN3CHTU+JVdSkU+8OOlAi/dC69L4c5p+QQPsWQ4y+5ujaZEaK1B9b2T5uu1MG4HUPlFWcDMs3EU/CZUXACwl99ggjaQqg3y9n7jYiooztOWG9oC9DSb5AqErSlDgxYhGn/HTcHlJ7ZgR7Epr951kawmAVYsuRQrKI8RC0vfZ2SgSB7IDXIM79OEg5tWIZqR89Ijp8EHXinqjuKAI9OIfrDCDI0FMSQafc613o0jYccldWSVYI6zsc0Z2IWjstP4Ysip7lSvuactvKmSHWTtEL57rcWjjK2YZu+XzkNMwFXHXAoQuB+okGRbcfrukzmF2qeletECoDn1aAzpwnfBcnyV/KG1aJrKISbaakWMjvAnVZ5sS6sQ/ZDsnkYanbFgNCq/3UXFuk0mXDVxZ3ykRMDyMKwueMrCnamF025dq+FZjqGU2SqyELByqPJcmCCiFFxw/Dx+j1cu4NvYEjdxoZZXG94wnRZhqGquMv3j6k4gXywIzBwjVmaZ9oZLqPFJD3gxEjAt2osLvTbctAwwk3RdZdhJpAE4Zg==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(6506007)(956004)(15974865002)(6666004)(2906002)(2616005)(36860700001)(356005)(82310400005)(6512007)(8936002)(86362001)(36756003)(508600001)(26005)(4326008)(8676002)(6486002)(1076003)(81166007)(118246002)(5660300002)(186003)(36736006)(316002)(336012)(70206006)(47076005)(70586007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 06:49:36.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2ec6bd-7029-49bb-93a0-08da3188152e
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB3271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
Same as SCA3300, it has the accelerometer and temperature output.
Datasheet:
www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 39e6f9f162f2..618991c8da92 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -38,6 +38,7 @@
 /* Device ID */
 #define SCA3300_REG_WHOAMI	0x10
 #define SCA3300_WHOAMI_ID	0x51
+#define SCL3300_WHOAMI_ID	0xC1
 
 /* Device return status and mask */
 #define SCA3300_VALUE_RS_ERROR	0x3
@@ -96,10 +97,18 @@ static const struct iio_chan_spec sca3300_channels[] = {
 static const int sca3300_lp_freq[] = {70, 10};
 static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
 
+static const int scl3300_lp_freq[] = {40, 70, 10};
+static const int scl3300_lp_freq_map[] = {0, 1, 2};
+
 static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
 static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
 
+static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
+static const int scl3300_accel_scale_map[] = {0, 1, 2};
+
 static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
+static const int scl3300_avail_modes_map[] = {0, 1, 3};
+
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
@@ -157,6 +166,20 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.name = "sca3300",
 		.chip_id = SCA3300_WHOAMI_ID,
 	},
+	{	.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.scan_masks = sca3300_scan_masks,
+		.accel_scale = scl3300_accel_scale,
+		.accel_scale_map = scl3300_accel_scale_map,
+		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
+		.freq_table = scl3300_lp_freq,
+		.freq_map = scl3300_lp_freq_map,
+		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
+		.avail_modes_table = scl3300_avail_modes_map,
+		.num_avail_modes = 3,
+		.name = "scl3300",
+		.chip_id = SCL3300_WHOAMI_ID,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -556,6 +579,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

