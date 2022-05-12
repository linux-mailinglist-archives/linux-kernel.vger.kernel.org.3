Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B75251D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356221AbiELQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356176AbiELQD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:03:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2122.outbound.protection.outlook.com [40.107.21.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8135F26F;
        Thu, 12 May 2022 09:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Teg0XyJrIARNzFcCHAaR70y5J4OVghOFdywrXxDRJmSswFLVfebU3rbNTVEYJQfU1E3TZ35oBcrnxbeMBTNmTpPTxtf0VQvW3B6rkR6zkeIX1IafB80tb3cEO4sd6Q6BxKrAWIezNtULfOTN0E1n04Qdu9LEsLAAmIvMmEoaEOHA7UPElSOYHs2o8hUqUIjlOol3RFM5xdYoBug0VQjPT2wanas2GOk5ahIjK8Xl+KbHizQkRNXZamIuLWVC6nNMi6blopK/VIJkVbUWRu7ZQERg+nXxNeLZGMmVlGThhc5p+hg0/IGSiK7bMLn+iWjftD9XRHVj1Yet/Ffm671TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZEwcN33gvwMvi/n4QyU8Zd9aOU4b0tWYXCjjWPkU4=;
 b=fxhOP7OCuZlzLR2v37pz+9QbrpHS03Hab9fIcVeaf5tbx+Js+KOm4HICxaii/tbrnLxyWVIA3dFoLF6mQ1f6S5qMiJnHSL9Xlzc+aH1VqdqruVygdXFQpNAQZjza3s4dJVk9w9eWyp8zis8RYaBSoG81bkxhA9nrXD8owXQaBdi7PctkrFx6UthxF0hffXPrcil80F2Mzbd9eEJ19kBNlzpXioma5RVMLgHOTccqduCbobj2HpAMlZn8PamwzUbGX4y5OZ3zbwuQfZ9wS6Yszbk5iWUwKXLGHfoJygzH65NlfTLbGKPzbzIJwe55tTFVkEN52KWF998Bn5TYqBQkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZEwcN33gvwMvi/n4QyU8Zd9aOU4b0tWYXCjjWPkU4=;
 b=zcxWoAIRDj+ADdAtiWQeYR1og7CfIcZ0yucX1WqbTPVi8zp3LQzQ+ZmsCGQvS+w/CJajMMMWs9HenTDvjv/XBas+/FbzCsByDwSsTkBfZCfiCre+1iLnMgsNHVdK34JjH5jSiDQwyd3o1dlMWdjiH0+awcC5x4Jt2BcPLO3zqec=
Received: from OL1P279CA0040.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::9) by
 AM0PR06MB6419.eurprd06.prod.outlook.com (2603:10a6:208:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 16:03:21 +0000
Received: from HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::11) by OL1P279CA0040.outlook.office365.com
 (2603:10a6:e10:14::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 16:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT005.mail.protection.outlook.com (10.152.10.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 16:03:20 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V5 5/5] iio: accel: sca3300: Add inclination channels
Date:   Thu, 12 May 2022 16:03:12 +0000
Message-Id: <20220512160312.3880433-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b909f1e-3954-496b-963d-08da3430efb2
X-MS-TrafficTypeDiagnostic: AM0PR06MB6419:EE_
X-Microsoft-Antispam-PRVS: <AM0PR06MB64198C8ED817065619C1F5F1D7CB9@AM0PR06MB6419.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +25vFYhVscarVjA3qeHFq5yLMCTDbnlUYpKTcdliXRR7ckZfS2qAErjl10JvfDkCs/FTdBMJmXfJ7CBb6uvpItHHoieZdI8SYZerfpAaRqDyZMERqEOMvl/9P+gQ2cjj35PWQxGUDvYokHK3S0dSjdJNu9Ts/1Tkqh1QDUHW6TD36TeppME7F4R7lGveDD/qPdZ2+xlWu7H73Ck9Kzb8NIMYzbhqmDt5gFQvvh1ftUv0koYTWIYYeKktvauHRsZbfk+lazxGLRFEvKyYHpbvh8PhNA4rB0SGsMYbnBE4VJxxFoEICvh5vwgGuKMqWLsf2uZIVRk30OSJXilxeca8wrj+UvTtjNUmJDuUO0AWxdJqCfjo4BtdNOAtp6AtI/HW9hyRItdKHsk7UBFl7YFqvOuo040YIbVQohwjUPpUM6QsfbkUh/lE/jeAJoEElRu95DzLMvZUq3JVXiTvXBCSSWcq7RWmGDTX3CxIc7E2hIj7OX3dPv/b1BHOkq9jyOOwjEWhPn3SnN/1sXfjBMrbhPgoAKE9Rsa1J3oz8nHXsQW/m48NX6IM2NZkAOKWPtJhxrjKW3VazW3bGm79Tv8fwlznalT0re42JLNBSfpp3oWZccQROdLZjNebJsC5X9V8H5x34CRJZlonTCFTThlVJjzSR0R1Nda+nEIuLI5ini0DJIad9k1j9fANaS4SdMBv
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6486002)(8936002)(40460700003)(70586007)(36860700001)(508600001)(8676002)(5660300002)(336012)(186003)(83380400001)(1076003)(47076005)(118246002)(36756003)(86362001)(2616005)(2906002)(6666004)(81166007)(356005)(316002)(36736006)(4326008)(6512007)(6506007)(82310400005)(956004)(26005)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:03:20.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b909f1e-3954-496b-963d-08da3430efb2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6419
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
index dc53e7ed3925..8057133c97e6 100644
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
 	const unsigned long *scan_masks;
 	const struct iio_chan_spec *channels;
@@ -122,6 +167,9 @@ struct sca3300_chip_info {
 	u8 num_accel_scales;
 	const int (*accel_scale)[2];
 	const int *accel_scale_map;
+	const int (*incli_scale)[2];
+	const int *incli_scale_map;
+	u8 num_incli_scales;
 	u8 num_freqs;
 	const int *freq_table;
 	const int *freq_map;
@@ -129,8 +177,10 @@ struct sca3300_chip_info {
 	const int *avail_modes_table;
 	u8 num_avail_modes;
 	u8 chip_id;
+	bool angle;
 };
 
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
@@ -158,6 +208,9 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
 		.accel_scale = sca3300_accel_scale,
 		.accel_scale_map = sca3300_accel_scale_map,
+		.incli_scale = NULL,
+		.incli_scale_map = NULL,
+		.num_incli_scales = 0,
 		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
 		.freq_table = sca3300_lp_freq,
 		.freq_map = sca3300_lp_freq_map,
@@ -165,13 +218,18 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
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
@@ -179,6 +237,7 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
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

