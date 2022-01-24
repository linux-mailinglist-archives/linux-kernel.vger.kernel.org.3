Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD73497C31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiAXJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:39:45 -0500
Received: from mail-eopbgr150098.outbound.protection.outlook.com ([40.107.15.98]:19840
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236499AbiAXJja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmEVwy1pDzQdCirOZE2h/pOOpAXnv72xmTQ6g3aiBpuXRw5Q03qYtmz4pBEW/SK7X73BlEIgJG/M1VSJrDx0sj+yv0SIEJomX+WbBgIA6L6LDswe1X1XpQ8UbAetTiGx2u9HgKvoeHpV20B5P7XzPQLr0rR6HFqwjW32tCNznKqYaf6R13rgM3LWDkPX5dikYhBapSW8woldMSkiUz0SgezXK/Q6VdgQo8GzMOw+J6rl6kXZ1TV2fSUjE4oavQejZoTPN2xskKJRvXjbFTkBQNnWq7hj5Lx+ZILBuTlHnotJ0udG2/2x+drEN7FiROZfVgWQScfBy7dSRN8tYcO1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PIK00QILO01/9TkFYhmQF210cqQvDWMP8BQeAOGWNc=;
 b=hx25P13tVYHEzrg536nFwZByTKZK750HGKDKfalIqbjxhziGj2vVESS882JKUJQfxIXGby/nWMqiuXVpWCcYaTmnkreWfZxLBT8EDHew7i4RwFHSZzh2ACZL4qSM8LIClXCVuVQOQupRgCmjs7lqcww/D6Z1QKlDrLZOEn9myhvc8CyBbnrj6ZeTIAAXxT17M4ZHSA71d5xuog1AB8wvjb+HObbPq9WZyd9qLo2rbXef2mNl7HZ1sgEsj5TlwdtjgBIvvOsaL5YnttkWoZ5zihSauF5xUyI0vCna79ZiV/i+eM7F61/ABG8nmaqqIGUh9Yo+XIE30R3nPUd1e2wdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.8.40.112) smtp.rcpttodomain=leica-geosystems.com.cn
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=leica-geosystems.com.cn; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PIK00QILO01/9TkFYhmQF210cqQvDWMP8BQeAOGWNc=;
 b=h6deLUwJiiMVjw+eHadhuOvNOTaqi0Qn83c+dQy+ZSfRZ/sXX566mOky7hR7S2aPxxTOYC/TjF/1vXJ7dqP4a7HYfvxZrNuqF8ZKtuFq0CdBqe6MlyamcY/KaJfl8lUYDJ2kmL4UsyOYrg0yoDBOXQ02BWs14OXkO/WDjBvpPbg=
Received: from AS9PR06CA0046.eurprd06.prod.outlook.com (2603:10a6:20b:463::29)
 by AS1PR06MB8585.eurprd06.prod.outlook.com (2603:10a6:20b:4db::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 09:39:28 +0000
Received: from VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::6e) by AS9PR06CA0046.outlook.office365.com
 (2603:10a6:20b:463::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 09:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 193.8.40.112)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine
 header.from=leica-geosystems.com.cn;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 leica-geosystems.com.cn discourages use of 193.8.40.112 as permitted sender)
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by
 VE1EUR02FT049.mail.protection.outlook.com (10.152.12.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:39:27 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     qing-wu.li@leica-geosystems.com.cn, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 5/6] iio: accel: sca3300: Add inclination channels.
Date:   Mon, 24 Jan 2022 09:39:11 +0000
Message-Id: <20220124093912.2429190-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bb04d18-c375-413e-8bd4-08d9df1d6a51
X-MS-TrafficTypeDiagnostic: AS1PR06MB8585:EE_
X-Microsoft-Antispam-PRVS: <AS1PR06MB8585F7FF5C38896097CDB268D75E9@AS1PR06MB8585.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8OsinhsaPxXNHIL7O8ok7PHZNBXi5p45meGvijUZg1oHV5PCdCzKPj6vhtYCkK+9eCxVRbkJL8yzXE48D74/VMy/zZYM30w5CbMHIJs7Pt8mUasM2otKKh/c7l+6CqmhTDvL+hcGz7tUvxQY8PtsAbiOLtfTE/j/u0qbpIgyB0o0WRrFQX4VTl0aSebuMBxuh2x0/hgZkGT0lBxZRGLeLjMncZT+YOxjyqbzW5hTJsHCPGcak5uBWVP4QyAg2CjtDMcM2PYw0ol53GqbrJ8WjTOKzDi1MlaWYhstA9OBC6QTZLcbu7uf+dVGEpabglWlIi67gINfhvSvW/LXzwXVP+Zq3czCK4lTkk5NeJGyAoxiHrGev6+LMat04Sl0VLSU5ZyUWopUq1F1dCH4wgDjs7a1BrfLz/AO5jPtT605AgQuh8DmWQBVlj2NHP5XmA+qKwF468g1K9JwQjftZDDRbmStd7MErwi1tIbY++bg93gqzZ7fLopoIUann1ksi5ws+2levhaw0kzW3VIB3BAz3HZyCfBEgckmCjxF9eAvJZyjSFrPGe54aZFWr4NTJOw8lol4uGt8Thw4wY2q4DctsiY15xkcFSyq2oxy6ZPKFegzL3sjC/SwiViAWlrLtFJKCf1Zq3zNlXZbINniNrJTwz+GtWP+CrHh+/wAY95tEKMPD8sGQX3OyphwnJVKDQB4UDSetACieFHo9GTJ2sod+Tb8T8PHtuN0qBMKIwZbKd0BgJLdMxIsWNUulkIN6OZ7My/nyxREss9RzMoyCT8jw==
X-Forefront-Antispam-Report: CIP:193.8.40.112;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:mailhost.polymeca.com;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(6506007)(82310400004)(2906002)(118246002)(5660300002)(8936002)(8676002)(508600001)(36736006)(316002)(107886003)(47076005)(70586007)(36860700001)(40460700003)(1076003)(4326008)(70206006)(356005)(36756003)(2616005)(186003)(6486002)(6666004)(956004)(86362001)(83380400001)(6512007)(26005)(81166007)(336012);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:39:27.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb04d18-c375-413e-8bd4-08d9df1d6a51
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.112];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR06MB8585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different with SCA3300, SCL3300 can output inclination angles.
Angles are formed from acceleration with following equations:
ANG_X = atan2(accx / √(accy^2 + accz^2)),
ANG_Y = atan2(accy / √(accx^2 + accz^2)),
ANG_Z = atan2(accz / √(accx^2 + accy^2)),

The commit add output of the raw value,scale
and scale_available of angles.
add interface for enable/disable of the angle output.

new interfaces:
in_incli_en
in_incli_scale
in_incli_scale_available
in_incli_x_raw
in_incli_y_raw
in_incli_z_raw

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 82 +++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 7ea3e202d474..535d14b58acf 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -42,6 +42,8 @@
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
 
+#define SCA3300_REG_ANG_CTRL 0x0C
+
 enum sca3300_op_mode_indexes {
 	OP_MOD_1 = 0,
 	OP_MOD_2,
@@ -85,6 +87,9 @@ enum sca3300_scan_indexes {
 	SCA3300_ACC_Y,
 	SCA3300_ACC_Z,
 	SCA3300_TEMP,
+	SCA3300_INCLI_X,
+	SCA3300_INCLI_Y,
+	SCA3300_INCLI_Z,
 	SCA3300_TIMESTAMP,
 };
 
@@ -110,6 +115,26 @@ enum sca3300_scan_indexes {
 	.ext_info = sca3300_ext_info,					\
 }
 
+#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
+	.type = IIO_INCLI,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+	BIT(IIO_CHAN_INFO_SCALE) |					\
+	BIT(IIO_CHAN_INFO_ENABLE),					\
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
@@ -128,7 +153,7 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
 	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
-	IIO_CHAN_SOFT_TIMESTAMP(4)
+	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP)
 };
 
 static const struct iio_chan_spec scl3300_channels[] = {
@@ -136,7 +161,10 @@ static const struct iio_chan_spec scl3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
 	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
-	IIO_CHAN_SOFT_TIMESTAMP(4),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP)
 };
 
 
@@ -150,12 +178,24 @@ static const int sca3300_accel_scale[CHIP_CNT][OP_MOD_CNT][2] = {
 	[CHIP_SCL3300] = {{0, 167}, {0, 333}, {0, 83}, {0, 83}}
 };
 
+static const int sca3300_incli_scale[CHIP_CNT][OP_MOD_CNT][2] = {
+	[CHIP_SCA3300] = {{0, 0}, {0, 0}, {0, 0}, {0, 0}},
+	[CHIP_SCL3300] = {{0, 5495}, {0, 5495}, {0, 5495}, {0, 5495}}
+};
+
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
 	0
 };
 
+static const unsigned long scl3300_scan_masks[] = {
+	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
+	BIT(SCA3300_TEMP)  |
+	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
+	0
+};
+
 struct sca3300_chip_info {
 	enum sca3300_chip_type chip_type;
 	const char *name;
@@ -177,13 +217,12 @@ struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
 	struct {
-		s16 channels[4];
+		s16 channels[SCA3300_TIMESTAMP-1];
 		s64 ts __aligned(sizeof(s64));
 	} scan;
 	const struct sca3300_chip_info *chip_info;
 	u8 txbuf[4] ____cacheline_aligned;
 	u8 rxbuf[4];
-
 };
 
 static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
@@ -201,7 +240,7 @@ static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
 		.chip_id = 0xC1,
 		.channels = scl3300_channels,
 		.num_channels = ARRAY_SIZE(scl3300_channels),
-		.scan_masks = sca3300_scan_masks,
+		.scan_masks = scl3300_scan_masks,
 	},
 };
 
@@ -322,11 +361,15 @@ static int sca3300_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
 		for (i = 0; i < OP_MOD_CNT; i++) {
 			if ((val == sca3300_accel_scale[data->chip_info->chip_type][0]) &&
 			    (val2 == sca3300_accel_scale[data->chip_info->chip_type][1]))
 				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
 		}
+		/*Inclination scale info tied to accel scale.*/
+		/*not allowed to set separately.      */
 		return -EINVAL;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (data->chip_info->chip_type == CHIP_SCL3300) {
@@ -342,6 +385,17 @@ static int sca3300_write_raw(struct iio_dev *indio_dev,
 		if (reg_val == 3 && val == sca3300_lp_freq[data->chip_info->chip_type][2])
 			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
 		return -EINVAL;
+	case IIO_CHAN_INFO_ENABLE:
+		if (data->chip_info->chip_type == CHIP_SCL3300) {
+			if (chan->type == IIO_INCLI) {
+				if (val != 0)
+					reg_val = 0x1F;
+				else
+					reg_val = 0x00;
+				return sca3300_write_reg(data, SCA3300_REG_ANG_CTRL, reg_val);
+			}
+		}
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
@@ -365,7 +419,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
-		if (chan->type == IIO_ACCEL) {
+
+		if (chan->type == IIO_INCLI) {
+			*val = sca3300_incli_scale[data->chip_info->chip_type][reg_val][0];
+			*val2 = sca3300_incli_scale[data->chip_info->chip_type][reg_val][1];
+		} else if (chan->type == IIO_ACCEL) {
 			*val = sca3300_accel_scale[data->chip_info->chip_type][reg_val][0];
 			*val2 = sca3300_accel_scale[data->chip_info->chip_type][reg_val][1];
 		} else {
@@ -378,6 +436,13 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = sca3300_lp_freq[data->chip_info->chip_type][reg_val];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		if (chan->type == IIO_INCLI) {
+			ret = sca3300_read_reg(data, SCA3300_REG_ANG_CTRL, &reg_val);
+			*val = reg_val;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
 	default:
 		return -EINVAL;
 	}
@@ -484,7 +549,10 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 	struct sca3300_data *data = iio_priv(indio_dev);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type == IIO_ACCEL) {
+		if (chan->type == IIO_INCLI) {
+			*vals = (const int *)sca3300_incli_scale[data->chip_info->chip_type];
+			*length = ARRAY_SIZE(sca3300_incli_scale[data->chip_info->chip_type]) * 2;
+		} else if (chan->type == IIO_ACCEL) {
 			*vals = (const int *)sca3300_accel_scale[data->chip_info->chip_type];
 			*length = ARRAY_SIZE(sca3300_accel_scale[data->chip_info->chip_type]) * 2;
 		} else {
-- 
2.25.1

