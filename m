Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0385536FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiE2GTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiE2GTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:19:06 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140104.outbound.protection.outlook.com [40.107.14.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD856C0E6;
        Sat, 28 May 2022 23:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiSa4OpYXodgbtaz9jUgZWUCeKOp+rd4JsrKS1VGYyB2E4QopdANY1e3UDwmIbsT1/hq6xD6C+3PiZoUMX2uoYxQr3ZqSqrpPs9H17vOlHzgmxvC6yoXEGfR8cWLaPtjNVT1PjtWnH9HwFxjZETtbKEhBAR3kxvKKYzUze2Zsg79r27v0Pk767qPxX0pT9KgU2ONZ1Fbn+DGLFBDb2df24K7obo9dlLuxtPF8rAlO+0BZWxVZb5BJbdzwFOX/URf8Z51fGr62PF/v1YAr9Rpq+1Yr01qonZz2YAvrv2j2YzTmdCS9Eq2PpwMbmUnmsItP1tdCX8dICpe1ASUtDeyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJt9lJNlz3+UQ6Iz2VBjYuU/jgU29/L3N/OHH4uCr4k=;
 b=npGMxtIWG4ktYJIgdjoZxUgt1hrFbGe+02EJyCI6v46Y/haK+NGDUyBs6O97wByBEct7CZV/wkuIEZOwHVle9HF0mdptSgJ41ntPWZBgMGCk4m+olB76U3O0vb3WwCQ3VE4U6sRK1AZtXwcp9zskT+0wpQao1n2uwPebSohJVrD0SM7u/5VVvDfQm27KgC6xcL+qMHMtpjX1Dkgl/fO1Jm5yXVR6oGapEzeCTY4SgxDBMK7KM+toTGo2dhGY7W6sLZsJNBfxTK4IlISdUW87Bk2igwtw3+9rYOmTYQUs+3h+cr9jlRZuuIyDS/kloHsIABVWxIOrXpEnrzpbFNCtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJt9lJNlz3+UQ6Iz2VBjYuU/jgU29/L3N/OHH4uCr4k=;
 b=o3u991GLrudX8yzwwb9m/1dW5XSdSOHeHfW1OJ6NkXBjvQM4O4xCUhihL+WbdeBy5jCOzJYgrGl8AxnfJJvUPb9SV8RqzYAV670FRcZiRNlfkvTHdJ70zyP1tfeswhKWrDvKGgb7bCqJ8oZ4t9DCt7tVSTi7l9lbKykyWOmc4cU=
Received: from AS9P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::23)
 by PR3PR06MB6844.eurprd06.prod.outlook.com (2603:10a6:102:84::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Sun, 29 May
 2022 06:19:00 +0000
Received: from VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::88) by AS9P250CA0019.outlook.office365.com
 (2603:10a6:20b:532::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Sun, 29 May 2022 06:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT016.mail.protection.outlook.com (10.152.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Sun, 29 May 2022 06:18:59 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn,
        thomas.haemmerle@leica-geosystems.com
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V9 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Sun, 29 May 2022 06:18:52 +0000
Message-Id: <20220529061853.3044893-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11cbf49c-be38-447a-15dc-08da413b1ebf
X-MS-TrafficTypeDiagnostic: PR3PR06MB6844:EE_
X-Microsoft-Antispam-PRVS: <PR3PR06MB68448E93272B21CC363F21E7D7DA9@PR3PR06MB6844.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoZQUTXBvgLdLGOCTJ03YLiW9K+9k//0RsTsqKaz+WnexjX9CqK8shHgd6gltckKjo6EMf5J7yVuXFaWPblA91Jp+3sI0YXvFyFSh4f5XNUBTDEssFcG2XreEp4scKdMCAkfUZV5sDIwuPnysJ+B2DMMn4jn+rs2yfaTt4qGPDrenagNBjpS7xOXujkcG1nUk2pbNYl9W8hz3ZEhE+RBkIENbuSW1Dw8ardRzEYXkRmEwcUG/q/KnJeGnU86mSnH4OIZvVUhVyzAEk44WfQxHA3XDciaDveBxfAWM3rI9GQjP8MGYTHwL89pdj4tx5vLLA0I8S3wYo92/Q35m9tihKNQKqZKDkEgW9vJYqoZj9gxq5n5yX4t27nqlQkvR2VWL0M07D+VpNmotIceFns9uQi2hCNo3pJVUUAtMchXX/2lj1ROBJczCwPjWjHrxE8tnnJhyRMawAnJQGFNpB8xR490ARaOc01WeFQSUa+i3s/JB360Zb5X2uKBbLcl62wG8Rv7LlWR/j3uY5+ua74q+72n7nqvQBsCFig+B5FxP1sAlta022MbokTLj0HWxHVmoR7feeAkBfKMDhyx4iS9pX9bwkBgiuPhJs4ivif7pfX4p/0wyDKNa8U9/GntdFHMJGfyUH5D+35kb69FkY5gvzqN9zpTVc5af7Vnx69fIjTkoPNU4JKeqkWPux4YLl3TvrRqXh1efpch7wK/QVQ8hpi9PElSvRGJB0rQKxex7ocaynSNvrqry5uj8sbPMgc65MNpqkoxa02T+9ux5uOCig==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(336012)(47076005)(26005)(86362001)(6506007)(15974865002)(956004)(6666004)(2906002)(82310400005)(316002)(36756003)(70206006)(4326008)(70586007)(8676002)(36736006)(36860700001)(6486002)(81166007)(83380400001)(6512007)(40460700003)(186003)(1076003)(508600001)(8936002)(5660300002)(356005)(118246002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 06:18:59.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cbf49c-be38-447a-15dc-08da413b1ebf
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6844
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

Datasheet: www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 21bf439e5c84..9683dce21073 100644
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
@@ -159,6 +168,21 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
 	},
+	{
+		.name = "scl3300",
+		.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
+		.accel_scale = scl3300_accel_scale,
+		.accel_scale_map = scl3300_accel_scale_map,
+		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
+		.freq_table = scl3300_lp_freq,
+		.freq_map = scl3300_lp_freq_map,
+		.avail_modes_table = scl3300_avail_modes_map,
+		.num_avail_modes = 3,
+		.chip_id = SCL3300_WHOAMI_ID,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -442,9 +466,10 @@ static int sca3300_init(struct sca3300_data *sca_data,
 
 	/*
 	 * Wait 1ms after SW-reset command.
-	 * Wait 15ms for settling of signal paths.
+	 * Wait for the settling of signal paths,
+	 * 15ms for SCA3300 and 25ms for SCL3300,
 	 */
-	usleep_range(16e3, 50e3);
+	usleep_range(26e3, 50e3);
 
 	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
 	if (ret)
@@ -571,6 +596,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

