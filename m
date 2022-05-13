Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D9526234
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380433AbiEMMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357809AbiEMMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:41:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70129.outbound.protection.outlook.com [40.107.7.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D036B5A;
        Fri, 13 May 2022 05:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRD3t80b8GB9AYeXYRzEHAOmYH896JasVDUncafZDX1O13iNLB6ZXSCOg/aJzXuWTfgnbRg6oSIGq9OooV6EEfDD3+5wnr97TgL+piVJYoWJsOHgT9QjmpE71ELWHvsO8DDchUJ5mlWAZBk4cpGz4TFDaszWvG3agnFDYKK+BohMA4Xef8MKb1hVKSTognwe2j1wB5bh5ySLW1vGZ1DHxoyqwaq/BCE7CWuOLQj4s6jWME2Mt9vBhEnAjSXRvUECmaT7Ji8XAbkngtAMBDyxFzKfE6JvIJJMjbZ3Ouiowt0ryGxjQQTD0KQuRd339zEMVYhVeX1f3Zxm9St13dPh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfxiAiriNxuUzPIrcGO0adv4+qAf+3+3PEw7v3cRLJs=;
 b=bolyhSmqKeZ8XiZ1V50fyvczuGpBcda+/zYne+Qsa4GIlbOEHPonVX4F4GCmAmx2tqNYwO6znxnhwAicuWPIDkoVygUOmFaA/VhWmhQf9KUHZWbV1zs7O11O9CRx7Ey2Mt2FMH05D84mUCgGtLpRvIDbj5J/4iCWtR+i1h3v6k/UT2rZZvckLSLJOb6WMyJSwKdPbD77L0gVOwDTXlTRBcSHN+4hR2571dPtTukZChJ6itiluw0j13iDf8SWY4RKToLBMGCAGEZT82iBjCspVOFeXV6U/tEhmmrkDNvSM/494m5eX2+GdB3xFeAgXtU6+PkFLX8hnjlgmXhFtgKTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfxiAiriNxuUzPIrcGO0adv4+qAf+3+3PEw7v3cRLJs=;
 b=S6JLSbLYnusCUcsWTHsxb7gnnrr+QMP/GIJHarQBPVhTo4hyrHllq2rblQ8rnqodcGypT1Hmf8JipXcn3Wf3IJ97fws033xn9Eht+2nsAo9Gq7t/+i2+P4yTq3WYK4K3xD1E/ZDiji0IpsM/aDqvjlHfO1YzruH2Cts3iDoigKs=
Received: from AM6P194CA0093.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::34)
 by DU2PR06MB8333.eurprd06.prod.outlook.com (2603:10a6:10:2e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 13 May
 2022 12:41:41 +0000
Received: from VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::c3) by AM6P194CA0093.outlook.office365.com
 (2603:10a6:209:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 12:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT036.mail.protection.outlook.com (10.152.13.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 12:41:41 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V6 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Fri, 13 May 2022 12:41:34 +0000
Message-Id: <20220513124135.1295822-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f9eec1de-3b5c-42d9-603d-08da34ddee3b
X-MS-TrafficTypeDiagnostic: DU2PR06MB8333:EE_
X-Microsoft-Antispam-PRVS: <DU2PR06MB8333E47A117AD40A58E343F0D7CA9@DU2PR06MB8333.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NbZ0i21SjAnJXy2cxFgDapz+XH3xyIixgVBKIKNlBS0+ccwOHRkwsxbCNTSCcYWCYsVJgIBV/MfiQSkYiN10YgbqRgdhUzr58c6Qb9bj5+i/c7dJn9n4x09+iWeZiJxlq+k1enzdBhIYIyRqjSglz5ZQ8hA6Nj0wIs2oYfLrHEEJ/9ldHBL91Jo9SGr9P36ve8pbhbE/i4ZsJ5P4RlnFQiCp/1DqP2SvAlpM5d8TVQTti9W8SsftewKI+8wC/BE/piHPVtQ5ObMOy8V7iWJvIh8WZv+yUQq6TQkfCIsQvnvGw+hN9m4I8IaM2WywQdjBCUMqVwzdxsccuB2QmlLb6UsPxm3jLJJcIRnyTQr4qNjUApS7XxNbvd4dAVXiv6M48TPVUWHlgDRQyDJmDyelNJe7JqLVbK+vEAA8p1d0H2CJwbPoqcH8+JVbO4ToatLw34XtKFIYOfzk/dVpYJsih/eJYHlyb54aIFfjq2r+rIMjn/RQj1/SuaVapcr6hmeuxiYHxLp8YugjolWVNK+b2onV1xaKyJSgjqc/qzTS8sS67dDDERM+UeUPBhJ6xDpYfL67a9YoMGeg5sr2orQrmGZmrqxC5QuP2+4EskdbKBpQTa+6iLwF7RsZRlIvbd0bLe/dSjNOCjS3DFG27IdrhfP+Fefd0hvCzrl49DmyhRORTEKnom+qUlW2nhUiqIOyiCfALnaophK9niXQyZdC7nzRY0NsM8QueGD54M4K1NC9duhxfakbr0TIa9QbnQxieG8pUKUKstG5iAk+Npkpw==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(6512007)(956004)(6666004)(70206006)(508600001)(26005)(81166007)(118246002)(8676002)(2906002)(6486002)(40460700003)(86362001)(4326008)(316002)(356005)(82310400005)(15974865002)(36860700001)(36736006)(5660300002)(8936002)(70586007)(6506007)(36756003)(2616005)(186003)(336012)(1076003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 12:41:41.3444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9eec1de-3b5c-42d9-603d-08da34ddee3b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR06MB8333
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
 drivers/iio/accel/sca3300.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index bc6e0213e4aa..3dcb4296fad2 100644
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
@@ -158,6 +167,20 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
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
@@ -560,6 +583,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

