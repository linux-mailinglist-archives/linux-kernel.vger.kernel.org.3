Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9F5309D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiEWHHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiEWHHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:07:09 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02on0725.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe07::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DB6160B;
        Mon, 23 May 2022 00:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8DjPAM272hafXT9ZdRMGrNE0Me7VgBO5B0S5Gicbk7zuOmX92ky8iMhRUc6Lfk07NuUB7thxmy45jJsBDVNKuulREwdGmWKG5VIw9Oyigbkut6nhWnyhkR83QFVLhBfKKXVINrQxKVZXYJnsi8Ir2V5OBdvwgqHWGWBM+YLqPYMrvyXt209J2qz0u516+XPo/mmEqLEcROSHeI69WURYa+8p8wvLSO1bz9P9DP31BsiY4d6DfgwYDCqfCmFH4zLCqMT+fMEfKLk2WgT2ZgxhM7TQ+eDrkatqRPe/TMK4A2ScujASmhlfR1nALsvavAr+AaHQPobyX5lnnoGFw0O8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn2d8wAKJShjfj5uXedFfYAOJWlKWLtDuFr+7+rH4jo=;
 b=BlMNEpq/tUel1J3DVskPkKeBtuGiwWDAjKa0cu6FHxv0rlIuVvTnyFyAHeByp/qPGY8zxZ9MZ2wy7+zQxBaU1k6CIVRxa6v5rqANNVqKB+6y1+pbuEGpTIg6gKrMNtWchjm2I4/1JFHx2xgDLfvUHghFyimK7EJyxiK3FOuYBzSOS6xXMx/JmZXv8ClY9JkRwnnEDwtFQISkb/8y+Oy6EkRcgnMMl3nRslD9UOFl8S9WBSyN/n4182PEFmiBwqJXE4m5oyuNTPw3hT5Cbv3exx/tgdoJfPGURcdEPJSksUXd3FNR+0gVobRbDZrhpzUKO02ArpF/fdugIqFZ79k0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn2d8wAKJShjfj5uXedFfYAOJWlKWLtDuFr+7+rH4jo=;
 b=IYQsVh8QqTOeYLE7t7PwPeoFCDkdBxd3ivSKDVCFvnWgVpS4fLm8v43+z/OSgmVFSasJ+9Q+XQEbIh7Khfr6uCch5sGrvq4WIqnThnHYyCM136kOhkQr8BEL90+++lG0oDVifRkgKsx5Qk8bHsLrTtk+qJzyy5d9TujfNBC46D8=
Received: from OL1P279CA0070.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::21)
 by DB6PR0602MB3253.eurprd06.prod.outlook.com (2603:10a6:6:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Mon, 23 May
 2022 06:23:22 +0000
Received: from HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::71) by OL1P279CA0070.outlook.office365.com
 (2603:10a6:e10:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Mon, 23 May 2022 06:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT087.mail.protection.outlook.com (10.152.11.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 06:23:21 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: [PATCH V8 5/5] iio: accel: sca3300: Add inclination channels
Date:   Mon, 23 May 2022 06:23:12 +0000
Message-Id: <20220523062312.1401944-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 24495935-9358-4c29-e2e7-08da3c84bc45
X-MS-TrafficTypeDiagnostic: DB6PR0602MB3253:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0602MB3253DA361BC2A01F4EA78A44D7D49@DB6PR0602MB3253.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcXOgLu+jmWw/jA7sth9x1XqCa2fzq0kjznfc76MgmSpZHYKqI8ZoFwMhIMpVfrEWTnMeQtZsuF6+RkvdrqZkevo2IbMAVeaasWNOHZXdStfBkbkh+vIWdAZH4HzVQhPuI/MGweOYxXmXAu6lj1dNUTh3sECO4JngH/MqxuwZy84CyFV4poIl2X6EkwoNqfDwl6CDFHsRNLKI+d3bU5ZtrJHRIDeynDFLGT+qQMG7ZXjEPEpjYh+mzvV7lozcg/A8s6rSE55uFhDk7Ps6vP5a46NNdyYNTwwgYlGa8hJ5bSyG3OxM51r0uFaAA/muRqoS3veZfKc1hdXpiGghIGhVfynI1Nh63WB4+m6LMOMN2kK38PgTex+wkvEn9BH9LxgEIHcpHT1GNoed7C06m7lqj9qtWZ8/MsgVJIW8QxjegwendLZ3lAhmRwrDaNTf6XuJcLnRnRZYLVDtXmXtaAOUyir5hAi5VVCNxtquGLv2JP4FrZL1MXXTUyjz6VJi43UT2fuYUjrngcoGBSawGuDCEf5SHBMe9HUlWrXyql48c2uO9vKg/Hl6LZs1ISg6GJHiOFGfJYGrR23/DXdjNPCUK9kFzFaMdFaCYIafADBJKOTIuhqtpjoTXeL2v6qYO8JtfRBjpwoZ+BbaRilbPdFQFatxrRam2n9LttHRV1HDZaOzF5kzUI60Ica0Yyiy26v
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(70206006)(86362001)(70586007)(8676002)(118246002)(36736006)(36756003)(316002)(26005)(82310400005)(4326008)(6486002)(6506007)(6666004)(5660300002)(8936002)(6512007)(508600001)(2616005)(956004)(356005)(83380400001)(336012)(186003)(36860700001)(47076005)(1076003)(81166007)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:23:21.3725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24495935-9358-4c29-e2e7-08da3c84bc45
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB3253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 74e780a7ffcd..c7fcb0de5462 100644
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
+	bool angle;
 };
 
 /**
@@ -167,21 +215,26 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.avail_modes_table = sca3300_avail_modes_map,
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
+		.angle = false,
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
+		.angle = true,
 	},
 };
 
@@ -401,6 +454,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
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
@@ -488,6 +546,13 @@ static int sca3300_init(struct sca3300_data *sca_data,
 
 	sca_data->chip = &sca3300_chip_tbl[i];
 
+	if (sca_data->chip->angle) {
+		ret = sca3300_write_reg(sca_data, SCL3300_REG_ANG_CTRL,
+					SCL3300_ANG_ENABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -523,6 +588,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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

