Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0160E526236
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380390AbiEMMm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378504AbiEMMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:41:46 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30111.outbound.protection.outlook.com [40.107.3.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A2B36E1C;
        Fri, 13 May 2022 05:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd1X9Gutb1yxEGM5MrPgoCn7QR17dtSmwbFVIbfs+ZvaKi1iYqFtM49N7/Ihu/UrdJjA3lK0lahcdEf+9NQFXjMq1n+PI/j1/0C6wtPL8NKztuGM/WqS0yuqae61RG3W7Mc7XM6ltlW/woahep9Gpn2/23iQjbu0p4SLMRYioxC6CtQLldLz1J1+oYQEC06KZRzyaPq0MwTpREWxODAHdW35LFlgklX80EiXL6hZMziG7TOBti+W9wIaQTPUW/5tYUrVscjooa/JyhGlq+2hwsUwu08uK2jEMSXs0yDlxDfO+PEpxMBXgF6YL6bFylecji5VAbgPnXslY7pttPi/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG0uZlI8o+UNy9oS/hoK1dwvR0zWg5vlwduMmazLtJg=;
 b=FbwyvfombExD8r8rZ3Og9lsdyZ7L/7lEjEPkghVxdY0QitbEDUusM5cnUTcPAhZLXkd6oZlID/+eqqq4O2B3rj5CmGYmaoTSOYI997GiciQSDi4u6jh/fWQJdMjQHJbaG6x1PHIkm0skQSvQYq/+i1CV9lEBxUF9e0lMHAs1B8i1JgPQYNuilkY8iuIYEViPS9Rkw/seKJm02BbIueHNPXcrwMa/e/KARFVN45NswHUNJTkH4cW6C3ZT7L4IBDzbjTBrjMLQOudKBvV0mtjbD0o24N9G1aQFr8tYX0ue4plijy77pFZohqsstrDqFW9pdH0v0yfBL92/DRbuQ5PrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG0uZlI8o+UNy9oS/hoK1dwvR0zWg5vlwduMmazLtJg=;
 b=ZwF166GjbJ1WNmxuYJCpuWBeum0DscOotkFRVSlKw00fgiOVPtgzxhO1ZfG8alqSPWIjMRew4m7w/lQv+mm7kJoCyohonuNa0givL2kHSyaWTKCRQcLjPObq9AYCCq7Odk/NleR6g5kvkwV7gEMQNNqir2NEEkr7hyg/Kjnczvw=
Received: from AM6P194CA0078.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::19)
 by HE1PR0601MB2698.eurprd06.prod.outlook.com (2603:10a6:3:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 12:41:42 +0000
Received: from VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::9b) by AM6P194CA0078.outlook.office365.com
 (2603:10a6:209:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 12:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT036.mail.protection.outlook.com (10.152.13.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 12:41:42 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V6 5/5] iio: accel: sca3300: Add inclination channels
Date:   Fri, 13 May 2022 12:41:35 +0000
Message-Id: <20220513124135.1295822-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06101efc-3151-4c3f-e3cf-08da34ddeea1
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2698:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2698460EFCEE841B32D91383D7CA9@HE1PR0601MB2698.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/o+VdOWnkyNu9Ytz30bsobObnUxn7Vb9/qH0bqMIIXh4/XdAml3fjLnailWpmpWhwtUuvkHP57y/uBzV0QDq5g/ula3EQ55/ECjdg67d1JpEq0Ri+nYB8T8pGuQxL4N6AI8aSJTSnpzMSuQNnr0GJlUt9+pzA0N7M5+KZMaWSwFQIqHMCvv9bH0OzYc+vk0e7V8Wl5qeS7HuTg5TlYKUZxrBzObim1f8KGzqASVoeN7zwQBxrMfnECS+j14NAJF5zqH4/MPzaHovlmAZADHtzuN2OPs9NrW/qHcTQ8xny7/rNjLWZc4h4cL9iiSFSL9yfkN63kIZS5i8Fhm40DVVvnV2jS3aY0lM0B1dib4K3Qhfwa56kKTDjG+OmBXlqJXhyK5F+lzHYa5QZUSXUA0GbERP0zSiDaVtopmgRnMIBRqYzxKQHiPjBZ2hxwgr9WLcM4XI3q2RF8YIdTiGFe1QaIizgPzj88Ypdl/XC+5Kc1G2WatULH+DWuVbxO3n43WyRswf265jaObyb4A2F3LcPjztBIM+rHVyHIZt4mfL9s8Djr3VUqhgC1IOtKlypZXtkUd25XngTeVoqzH8ByhxPwcSRBEGgPL+w4wRrK9Abf6v0yfNjGs49PkD3MZ7b+pE+tDwMb8svFa+tzE12RGvT+Ud8q7ojwm+tnZ0q42ORQdYwvfaXOe4I9uMnt6c/by
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6512007)(36860700001)(70206006)(70586007)(2906002)(36756003)(6486002)(508600001)(86362001)(316002)(4326008)(8676002)(36736006)(336012)(6506007)(83380400001)(356005)(81166007)(40460700003)(118246002)(5660300002)(26005)(8936002)(1076003)(186003)(82310400005)(47076005)(2616005)(956004)(6666004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 12:41:42.0319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06101efc-3151-4c3f-e3cf-08da34ddeea1
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/iio/accel/sca3300.c | 82 +++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 3dcb4296fad2..7060eba360ae 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -44,12 +44,18 @@
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
 
+#define SCA3300_REG_ANG_CTRL 0x0C
+#define SCA3300_ANG_ENABLE   0x1F
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
@@ -73,6 +79,24 @@ enum sca3300_scan_indexes {
 	},								\
 }
 
+#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
+	.type = IIO_INCLI,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type_available =				\
+	BIT(IIO_CHAN_INFO_SCALE),					\
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
@@ -106,15 +130,36 @@ static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
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
+	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
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
@@ -123,14 +168,19 @@ struct sca3300_chip_info {
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
+	bool angle;
 };
 
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
@@ -160,19 +210,27 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
 		.accel_scale = sca3300_accel_scale,
 		.accel_scale_map = sca3300_accel_scale_map,
+		.incli_scale = NULL,
+		.incli_scale_map = NULL,
+		.num_incli_scales = 0,
 		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
 		.freq_table = sca3300_lp_freq,
 		.freq_map = sca3300_lp_freq_map,
 		.avail_modes_table = sca3300_avail_modes_map,
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
+		.angle = false,
 	},
-	{	.scan_masks = sca3300_scan_masks,
-		.channels = sca3300_channels,
-		.num_channels = ARRAY_SIZE(sca3300_channels),
+	{
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
@@ -180,6 +238,7 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.avail_modes_table = scl3300_avail_modes_map,
 		.num_avail_modes = 3,
 		.chip_id = SCL3300_WHOAMI_ID,
+		.angle = true,
 	},
 };
 
@@ -387,6 +446,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		switch (chan->type) {
+		case IIO_INCLI:
+			index = data->chip->incli_scale_map[index];
+			*val = data->chip->incli_scale[index][0];
+			*val2 = data->chip->incli_scale[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			index = data->chip->accel_scale_map[index];
 			*val = data->chip->accel_scale[index][0];
@@ -473,6 +537,13 @@ static int sca3300_init(struct sca3300_data *sca_data,
 
 	sca_data->chip = &sca3300_chip_tbl[i];
 
+	if (sca_data->chip->angle) {
+		ret = sca3300_write_reg(sca_data, SCA3300_REG_ANG_CTRL,
+					SCA3300_ANG_ENABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -508,6 +579,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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

