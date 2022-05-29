Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10C8536FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiE2GT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiE2GTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:19:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2117.outbound.protection.outlook.com [40.107.104.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2206C0E4;
        Sat, 28 May 2022 23:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaxEOpV2jXhstdpmOzArJ/dmF8hy7axDerabJ88mnnl/Sq3ISQ+3yghqrWtVC/NK5aFJBHly64cMM9/r0KLMCi4lK9b93yasa2CJzdUAFQtBpqU0Lb7hHEpTjkTPdDyNVAAX2AqDwm6bLzexvcxBHaclhUqgxU3kigsmZU48y9IIQTyglKrY4+s+HCZONx3xS9HOBmwQSncxgpsUkL7Rdf/ALcXHxjFZr3P72sLtByf+JMyFtFms3t6MQ+s9Gt/ZLhdDR9dpQX4OOgdM4qsiD4GDDfsbAWspXA468fM6Ms6gjLh3VTMPBcVmPinJViXKiRt1jlLuWbn0XEovNVmmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxN4ZCNWz6VRgVj1BL6mki+n0goKOKfCF+2TlynNUbo=;
 b=HycYUY07GVdboJnsMlYAEKXc80GniWkfYKPwNkfxaWxivMOx/lqsuMqApy69bkteX9ppSbbhZRH6ftziJRnXTXPgcmcK7VfWDQVMRGVNrMmH4bErIB0DaE8rq0FBeMj8KzxM6YQgDzdFZwoL/rkckfkDYeUCryF+DJgAtxHFeS3TDwMg+A1Fnn8AR+uscLWQhvbhWI5KG5XOIzyRMxMQK2VTEe1SResxbtCDRmlIULnNg7VmI0O7/MAdOHvpnoOZ9mqja79Km+aw37x7KYrokSAKlTQJvHbeXJz8zDuW4ZAv16z3ylwUWfibX5C7HvoV1IFvLGBjBdCDp74cL9B9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=none action=none
 header.from=leica-geosystems.com.cn; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxN4ZCNWz6VRgVj1BL6mki+n0goKOKfCF+2TlynNUbo=;
 b=jBxduFJkhLOOXLfTjiP/dKRd462Uopv5X4SoRFiK+bWYbPqD7vxj8u/VmZwr6nD5jmruarklY2jC8nuyV32iLS+TtPWmfXSc91KNDlJzO0XqggnZ0BL3XB17RKbZ22iML5Fr44Bq0Y75beG3TX398Jh9LKpKljISLF/gzZB1Fw0=
Received: from AS9P250CA0014.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::15)
 by GV1PR06MB8404.eurprd06.prod.outlook.com (2603:10a6:150:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sun, 29 May
 2022 06:19:01 +0000
Received: from VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::2c) by AS9P250CA0014.outlook.office365.com
 (2603:10a6:20b:532::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Sun, 29 May 2022 06:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT016.mail.protection.outlook.com (10.152.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Sun, 29 May 2022 06:19:00 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn,
        thomas.haemmerle@leica-geosystems.com
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V9 5/5] iio: accel: sca3300: Add inclination channels
Date:   Sun, 29 May 2022 06:18:53 +0000
Message-Id: <20220529061853.3044893-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3af195a1-3923-4b59-fc6f-08da413b1f27
X-MS-TrafficTypeDiagnostic: GV1PR06MB8404:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <GV1PR06MB840484CD1FA2BA082ACFC5F5D7DA9@GV1PR06MB8404.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0EZ1pkT8sfcpMt8VvhO39bZHe+4oWPVM0nfWMru8UHFOjA9FjoB6g2WZo4bbCpsTDbLoLhL5Usp4Quay/sgcgb0AuOApNWYQvESYLr35YwS0cFvoBZjF1R/srxFPEklZSSgmN42J2UHMIvtS6OK4wuYeLR/zHL7QhT14/MokkTw4vX4XQkm3v3cTikJKWanrMDGIhnlOGvdamrgZxA/N2Qh0x4V449cDPKQitFUOdlfCdzs6acYYr4XIP2ZAoO8yYfSM0M/+cMB0nh6B/kEfK6ACmX0FfPE+N45zaNRza8IC5gXIJ6VEvK8bFvMyF8+mkHtTP+nuNF5cpbzClzlU9EKt3v7jeyCXvz4WJm3lRGUeUXWUIcbm6Wi5SJ2A7sW5Sz4gWzWhCcmWJRS4aTmOySUCwl0DlzpTo6hcS+9lV9IFHWCTIcku8DZDD527T8pUrGFvD/V5X07/NPSPMAc3ZYIqJjI7Nh+rIheYrFZ3wnTnF+IT3bkbOYmLdz6F4RRs0gJOO4FQpNCSYiMl01VPlVzxYhNfK0ATTGRyiYgklMmpcqRF2MfTElkzcTWhgCR4Ba7l+hrwbWHCXmou7i5pHHHPq1tzx0jxGtYjWT6ADQUiq09A3VPIQoiM3WDghWgOYhk6wOBKhsP+0SF1yIIUMASwy3iwrN9oI5IbcOHBWcL/rxIPYyQdQ0PMvhXyZfC
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(956004)(2616005)(8676002)(6512007)(70586007)(70206006)(316002)(4326008)(5660300002)(82310400005)(36736006)(26005)(36756003)(81166007)(118246002)(186003)(6666004)(336012)(6506007)(2906002)(47076005)(6486002)(508600001)(8936002)(83380400001)(36860700001)(1076003)(86362001)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 06:19:00.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af195a1-3923-4b59-fc6f-08da413b1f27
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB8404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different from SCA3300, SCL3300 can output inclination angles.
Angles are formed from acceleration with following equations:
ANG_X = atan2(accx , sqrt(pow(accy , 2) + pow(accz , 2)))
ANG_Y = atan2(accy , sqrt(pow(accx , 2) + pow(accz , 2)))
ANG_Z = atan2(accz , sqrt(pow(accx , 2) + pow(accy , 2)))

The commit adds the output of the raw value, scale
and scale_available of angles.

New interfaces:
  in_incli_scale
  in_incli_scale_available
  in_incli_x_raw
  in_incli_y_raw
  in_incli_z_raw
Data converted by application of scale to degrees.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 76 +++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 9683dce21073..861f6906beee 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -44,12 +44,18 @@
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
 
+#define SCL3300_REG_ANG_CTRL 0x0C
+#define SCL3300_ANG_ENABLE   0x1F
+
 enum sca3300_scan_indexes {
 	SCA3300_ACC_X = 0,
 	SCA3300_ACC_Y,
 	SCA3300_ACC_Z,
 	SCA3300_TEMP,
 	SCA3300_TIMESTAMP,
+	SCA3300_INCLI_X,
+	SCA3300_INCLI_Y,
+	SCA3300_INCLI_Z,
 };
 
 #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
@@ -73,6 +79,23 @@ enum sca3300_scan_indexes {
 	},								\
 }
 
+#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
+	.type = IIO_INCLI,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
 #define SCA3300_TEMP_CHANNEL(index, reg) {				\
 		.type = IIO_TEMP,					\
 		.address = reg,						\
@@ -106,15 +129,36 @@ static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
 static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
 static const int scl3300_accel_scale_map[] = {0, 1, 2};
 
+static const int scl3300_incli_scale[][2] = {{0, 5495}};
+static const int scl3300_incli_scale_map[] = {0, 0, 0};
+
 static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
 static const int scl3300_avail_modes_map[] = {0, 1, 3};
 
+static const struct iio_chan_spec scl3300_channels[] = {
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
+};
+
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
 	0
 };
 
+static const unsigned long scl3300_scan_masks[] = {
+	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
+	BIT(SCA3300_TEMP) |
+	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
+	0
+};
+
 struct sca3300_chip_info {
 	const char *name;
 	const unsigned long *scan_masks;
@@ -123,12 +167,16 @@ struct sca3300_chip_info {
 	u8 num_accel_scales;
 	const int (*accel_scale)[2];
 	const int *accel_scale_map;
+	const int (*incli_scale)[2];
+	const int *incli_scale_map;
+	u8 num_incli_scales;
 	u8 num_freqs;
 	const int *freq_table;
 	const int *freq_map;
 	const int *avail_modes_table;
 	u8 num_avail_modes;
 	u8 chip_id;
+	bool angle_supported;
 };
 
 /**
@@ -167,21 +215,26 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.avail_modes_table = sca3300_avail_modes_map,
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
+		.angle_supported = false,
 	},
 	{
 		.name = "scl3300",
-		.scan_masks = sca3300_scan_masks,
-		.channels = sca3300_channels,
-		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.scan_masks = scl3300_scan_masks,
+		.channels = scl3300_channels,
+		.num_channels = ARRAY_SIZE(scl3300_channels),
 		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
 		.accel_scale = scl3300_accel_scale,
 		.accel_scale_map = scl3300_accel_scale_map,
+		.incli_scale = scl3300_incli_scale,
+		.incli_scale_map = scl3300_incli_scale_map,
+		.num_incli_scales =  ARRAY_SIZE(scl3300_incli_scale)*2,
 		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
 		.freq_table = scl3300_lp_freq,
 		.freq_map = scl3300_lp_freq_map,
 		.avail_modes_table = scl3300_avail_modes_map,
 		.num_avail_modes = 3,
 		.chip_id = SCL3300_WHOAMI_ID,
+		.angle_supported = true,
 	},
 };
 
@@ -400,6 +453,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		switch (chan->type) {
+		case IIO_INCLI:
+			index = data->chip->incli_scale_map[index];
+			*val  = data->chip->incli_scale[index][0];
+			*val2 = data->chip->incli_scale[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			index = data->chip->accel_scale_map[index];
 			*val  = data->chip->accel_scale[index][0];
@@ -486,6 +544,13 @@ static int sca3300_init(struct sca3300_data *sca_data,
 
 	sca_data->chip = &sca3300_chip_tbl[i];
 
+	if (sca_data->chip->angle_supported) {
+		ret = sca3300_write_reg(sca_data, SCL3300_REG_ANG_CTRL,
+					SCL3300_ANG_ENABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -521,6 +586,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
+		case IIO_INCLI:
+			*vals = (const int *)data->chip->incli_scale;
+			*length = data->chip->num_incli_scales;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
 		case IIO_ACCEL:
 			*vals = (const int *)data->chip->accel_scale;
 			*length = data->chip->num_accel_scales;
-- 
2.25.1

