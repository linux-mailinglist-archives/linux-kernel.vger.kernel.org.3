Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1876051A115
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiEDNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350664AbiEDNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:40:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD0522B28;
        Wed,  4 May 2022 06:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoemqdYXkn8Cr2q2eTg56OTQEGsuXqcxSYujDmJhs27zSWM8N3P/1QGyJdVAL4ImQoh58rssQHhDWZ7IpUHhv2V4jBok+qr8HSDVV+GVJhxsx4TaqKfrwjknpIpLDWYSf37h/3MK9ivwbtppLZpD60R5E2EfaikhSc+CY09zRTaN3JpE4OfUMqqAXh69mz3JeCPU+mL7brGt1jx7C4tPk72EVS/DNlOIpDav8ZbuJoqQYwUtrdZ7BhD9jZwzWfMWn1RUE21N3aZm7GlzjRbLoObsixguR9IAmj7cE53O8zwrf4kvQIOK5QUndM6GhJ4rrHnUBukxFNtBEXBsrxL/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUw7FLnItlo2Z/rcvGSTRTNbb9vIGIeuEh5QsFtFNVM=;
 b=CzcM7wyQNde32q6Tn+GLbmhJyDvfbhlfPAzQl6mDFg58WICWkSHXl4y99QuquJDcJ/u7zHDewEFSTV09hF2f9zhuznp1VFSzUMVrDgsprpnqYmwJI2knmJGLqOTDdDl5BhoWC5Mvetza/93dBODaNxQzKLxbbaCsoZfm4VPOTTfZ89vtc7WGOA23ioAX85Nn5tAuspvPwyAjQzKfkofO4UwazmNEHkv4hbubOE8iSHn4xrMxKmDteczag4jUeI4ySqwwiy5cN3wzZNVD8GpuPHx7w0gULnAs83E1K02ijRtDmqRfxsZch7SwjMED6As3QY13jvtUZq5INvjyHBzazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUw7FLnItlo2Z/rcvGSTRTNbb9vIGIeuEh5QsFtFNVM=;
 b=JKX2Nrtykw3tlmh+6WaoeGqjmgUspWpJhsgxMd6YHJL4DUmI582bz48e2NV7bvuVYCXo3uiJZUdKJYrRlFqwm+uVvM8mz8fliQ/E7bbXcDjSWNAqYHEWFgYz94wmR7B3x6biHiO3xR1yPDTKZqqJzC7Fv04qwup8XiLsZiIhOLc=
Received: from AM6PR01CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::27) by DB7PR06MB4725.eurprd06.prod.outlook.com
 (2603:10a6:10:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 13:36:41 +0000
Received: from VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::ae) by AM6PR01CA0050.outlook.office365.com
 (2603:10a6:20b:e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 4 May 2022 13:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT101.mail.protection.outlook.com (10.152.13.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:36:37 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V3 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Wed,  4 May 2022 13:36:11 +0000
Message-Id: <20220504133612.604304-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e5ae4aed-99d6-43bb-d4de-08da2dd31d8d
X-MS-TrafficTypeDiagnostic: DB7PR06MB4725:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB47252FA6C660080A2BAF9CAED7C39@DB7PR06MB4725.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDGlRPxpLFPPCHR1y+f+bR0PyTXjTpAEfV1x2M2WKHDWJepRFgggdIZ6oVt/Vb+7seBitD1HQmC1zvOCBD9Y2iUzlCN5ZiBoV57BLMawKZUHC4DEF1aj19uuU6xSVILMCOdZMbShQKWoWainkdg7M6MjnvPhzPkXXWzhn5OilyunCk3P0sJ1U0VLt3xCIW/gx1BfHIdESAaQkUdWEZ7T73JM4zudc+MGmNQdWUmnpJaUk3Q3slbvxHsY543zx5nGjGkALXj3ydL44qet9vAaj0qZ/FYU4yYkR70HCYNWmcjOookpt+yeUs+DsAcu2Koe3IIqK+zLV7y6lpLyUAi7/VqJzjpdsk4Z0i9DVSELQe5etd9T4C8ui1oJGGKAtJiBv2T0JE9VryByBV8JtpTh+SJdKxdUiM48MgC5OUd0e/4di2yd2ElYl94wiwAAIs/BgigubZqfzaTFmms8UTCwVddlgAXEquf5fv9X6b9xv5KMC51ysHW9E+vMHudglbwckYbBQqdNeEKScJ3DcuO4AYOXyUf8Aj5nJ/ZqATVOlh3UFkzPt4qXKUcqG7jrEVqp5QFtv5cVPimpl06jC5x5BRCWM6V9NLgrorDg78TXgyK6DrOKCl1ZWZQqeJlvlREAZvueoZQaFrMTtv/0f6CrcuikUd/wQQmJjl8dfQtQ51ImFBeaqLGbCvcjbpERT1kwaOfu55VSHtXT9g8SSNaBbzhlmOfyqHQoIyzy9FyHB5VNOen3QM1W/2sU8unukl5TbVd4tKNukiJtYWM+XX1N9Q==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(956004)(2616005)(118246002)(82310400005)(316002)(47076005)(8936002)(15974865002)(26005)(1076003)(6666004)(6506007)(6512007)(4326008)(81166007)(356005)(36736006)(36860700001)(508600001)(186003)(336012)(8676002)(70586007)(70206006)(40460700003)(2906002)(36756003)(6486002)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:36:37.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ae4aed-99d6-43bb-d4de-08da2dd31d8d
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4725
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 1e0e6a2f7a63..040f8e1a1327 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -93,12 +93,17 @@ static const struct iio_chan_spec sca3300_channels[] = {
 };
 
 static const int sca3300_freq_tbl[] = {70, 10};
+static const int scl3300_freq_tbl[] = {40, 70, 10};
 static const int sca3300_freq_modes_map[] = {0, 0, 0, 1};
+static const int scl3300_freq_modes_map[] = {0, 1, 2};
 
 static const int sca3300_accel_scale_tbl[][2] = {{0, 370}, {0, 741}, {0, 185}};
+static const int scl3300_accel_scale_tbl[][2] = {{0, 167}, {0, 333}, {0, 83}};
 static const int sca3300_accel_scale_modes_map[] = {0, 1, 2, 2};
+static const int scl3300_accel_scale_modes_map[] = {0, 1, 2};
 
 static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
+static const int scl3300_avail_modes_map[] = {0, 1, 3};
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
@@ -156,6 +161,20 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.chip_id = 0x51,
 		.num_freqs = 2,
 	},
+	{	.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale_tbl)*2,
+		.accel_scale_modes_map = scl3300_accel_scale_modes_map,
+		.accel_scale_table = scl3300_accel_scale_tbl,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.avail_modes_table = scl3300_avail_modes_map,
+		.freq_modes_map = scl3300_freq_modes_map,
+		.scan_masks = sca3300_scan_masks,
+		.freq_table = scl3300_freq_tbl,
+		.channels = sca3300_channels,
+		.num_avail_modes = 3,
+		.name = "scl3300",
+		.chip_id = 0xC1,
+		.num_freqs = 3,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -558,6 +577,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

