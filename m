Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D853016F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiEVHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiEVHEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:04:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088212E696;
        Sun, 22 May 2022 00:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm7x8K5mkJwBGX10KtKEcodu+ABH+NoZp448ZJ+LaTzwMH4wrV3RZdZ39L0EramRjCvi8qtfT/JJL5L+9rJEFQcyIjMq5L0MV/gSB8zUMhX7muT7DP2YoStDvnUVgube4SrvRV4osJUlYq5YC309HrTBuJcSeZkhKAZyA0FS3v/Ytk5TVaW/ILZDY5bSPCzXWGXTFh567YRZ89+xfz4B9r9XRfodakJmgQqRBr3tR3HUQZ3jV8lFu4qvOWO32caSj2z24ljJDFVV4pARudTJQzHOkiyKnT6w0kbmk/TXGqR2BWIa8BdmWXoHnPoWbaN0gqPOJxxEPrdY89JNm5x6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqc4tEjwcUJvoam8Yn9VSv17EgBDCmd9rRIqAknCkkE=;
 b=CppOfAkXMfJZ0dljaQFzCbudglk5/76eFOPvaa/Hudb1NRW4FQE54HMOMunBGGOw3PqG0KFiFKIdtVhtVJE6bZWkxdAorvV+ZFHWrxXsD4PlpgSTbUy/qQmWQngOxhK0B/MwEXGenAAuUDHDMsmWW4GC78K28xJGxmpQgpUCNLGisUQnBLPcJAsrTiupErjSCVEWH9ik/vf2Tp+M2foTtO4pguelTcVJBWkVC4vZqc0v1Dfmw7RRepQ0DABEnToI9pPpgfvu9Y7cPzi9nHUfcw/XgjQzf/58I01FAZpJAP7I9mkMimFjcY2P62dp84ZpGTDlmBQaAo0ADOE+cDJFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqc4tEjwcUJvoam8Yn9VSv17EgBDCmd9rRIqAknCkkE=;
 b=na7n0FXOgRLZrdlWcmSRC8MBE38s9AMmgQ74Jnec1wPLXQhE4BCM07Qu67WJ2CncXsC8hFTju4jrv2gdDTnb0xyv+RTmgYwe3zHWyDZL/5rubOQY3lVeHHdNGlC/GptXoJGs6GXDCIS+CPEOZCVX529PCubRAXXlhE+3ku+KDj0=
Received: from AM0PR10CA0127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::44)
 by DB7PR06MB4506.eurprd06.prod.outlook.com (2603:10a6:10:21::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Sun, 22 May
 2022 07:04:26 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:e6:cafe::c1) by AM0PR10CA0127.outlook.office365.com
 (2603:10a6:208:e6::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Sun, 22 May 2022 07:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 07:04:25 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V7 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Sun, 22 May 2022 07:04:18 +0000
Message-Id: <20220522070419.409556-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70e8c583-a91b-4818-c3b1-08da3bc14e7f
X-MS-TrafficTypeDiagnostic: DB7PR06MB4506:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB45060CA8DF5068C2714E2C9DD7D59@DB7PR06MB4506.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulBjkvK4OP8xVrBD/bAXvSXmpCdP888OyJQL0ov5NQyUqm7ZvIPPjmDGS8kGVSMcV7z4q7sH6HRImdXBKLL8r+gjiXEmYkS2iHv5wPiRn35KgqCW/xRaH3sX0P6BNL2xsv/MxfePnGG1Z1Z2FmgR50XhgT1+E8mUGT0L2+rO8vL0rE7/7xxQ1wEschngG2fpjq4ufFeOyq05d6gkyomgIvy+xnGbtl2BxEInYXVX8d9yNpfcKuVh+pl+9b28dwYlLTIGZwpYBTbHPhzF0PNvZYXJQ5sSldNtlXnrGIzM67FUjw9+0+fvB/vpgfCKCaUkjlaZ502+AoSkApLBIRQn5if7h1TNKnNrZMn98x+7ZZfWXULc4dgGm9DfHsZ4nTr20e8tCjL20gbwE/AOj67QMjK9Mo0gqk6baerTWuK9htEW0USbzSpA1GCekLtr4UE712tjp6AzqhAvyEKp4HNhvhVyySBlBAiwP/JT2RDMLkuhRYhKaeJjiP06cS9z/fNc1btRWLA2ylZf+WlZoOuV5O/uBA9ZjFrMesLY7SzMdW7d5cgXK5PIrhN3sZS/XDUOmqpYHhOtdla+htxdAzTdqjDkV75VKSeklq4rAv6GXGsZiowIKFEqdZ6Q3VeLwj1xBcTmO+/OMuLQTkocaHb5qvvoXvVyqyLjY5MTtQzewd0O+y0tFV3/TOqRgC3BCFQVO8Jcrd1YZ1qb3o8GItlh+ILttRnlrWj05jP5Qw1bSraUdXY+yy9nnx1fxtMYzKu9ML+tbG2HPc/N8R/fJbrgOQ==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(118246002)(8676002)(316002)(36736006)(8936002)(356005)(15974865002)(70586007)(6666004)(2906002)(86362001)(4326008)(5660300002)(70206006)(81166007)(36756003)(83380400001)(36860700001)(6486002)(508600001)(1076003)(336012)(6512007)(6506007)(186003)(82310400005)(26005)(47076005)(40460700003)(956004)(2616005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 07:04:25.5882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e8c583-a91b-4818-c3b1-08da3bc14e7f
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4506
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
 drivers/iio/accel/sca3300.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index e57aba79c32b..10bedb14d4f0 100644
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
@@ -159,6 +168,20 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
 	},
+	{	.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
+		.accel_scale = scl3300_accel_scale,
+		.accel_scale_map = scl3300_accel_scale_map,
+		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
+		.freq_table = scl3300_lp_freq,
+		.freq_map = scl3300_lp_freq_map,
+		.name = "scl3300",
+		.avail_modes_table = scl3300_avail_modes_map,
+		.num_avail_modes = 3,
+		.chip_id = SCL3300_WHOAMI_ID,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -444,9 +467,9 @@ static int sca3300_init(struct sca3300_data *sca_data,
 
 	/*
 	 * Wait 1ms after SW-reset command.
-	 * Wait 15ms for settling of signal paths.
+	 * Wait 25ms for settling of signal paths.
 	 */
-	usleep_range(16e3, 50e3);
+	usleep_range(26e3, 50e3);
 
 	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
 	if (ret)
@@ -573,6 +596,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

