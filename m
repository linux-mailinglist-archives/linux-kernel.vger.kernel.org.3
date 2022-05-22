Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ACB530171
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbiEVHEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbiEVHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:04:31 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00099.outbound.protection.outlook.com [40.107.0.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5AC286C7;
        Sun, 22 May 2022 00:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf4h5Rzne9pJYHbPojBk5BIG7A0s+B9TAsVrVc8hQfY8ViXiNGrV1EG5PTsu/AA50duhTa/k3TarZqi+tcZ9WG4eAfW/75TWHqrFsEqByPeSNBCseqeABkXG3k2u74R7m9dX22RUfAQvWoZEfQJeuNDJJdVwGJ4pRrr0ja8vYEm7J2zSh8aXdk5iLQwZlrlffkJu2Qp5RN1pTIsYeqKbVrQwLetP/iGgNZaHsqFFcMeu4E+HE3WJ33ecWbl9w3zrotbYXCBoPPXm74pg5PmLcVhsco/tBd0CwKw+I+a4PJTHAP9FLp93k2WnUYQSNmvr6wxXeC07VBXFmiLEXzR1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g9Zb5NQnBxSo77yxwtd/DyYZ7bPq41L2SEO4vag9wg=;
 b=aCVrXUrarSOgKebbkoj4vwHKH8cAcOycShO1LhQKTNN8zz6lghT0xa5kcRAYfjWVGU+fSXlap509Lwwfo5H3b2i5lKOYp4O8lEvudi1iczFUr2luqOj2adgZKqpdMlON+1yLuajzO6C/C10A6bhb/tfUZBLZW9hti6RR60nVQWxEhsc4bq3IoGdnkDGndfyMhsbGestxp9UlkOlKC/4S2/ZfjKRf53fHt+a0YSo7w64ejv5XtF/j6GDGlnZtWlqKESUR63zP0hU0vYoKqky6KZ8/PG/P5NLBq05PiErCDncYjW9YEXbPc/5y+SHIr/dGqzRzcCX9dZmHgweRS/cL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g9Zb5NQnBxSo77yxwtd/DyYZ7bPq41L2SEO4vag9wg=;
 b=kIRLKdRkB0eiuVj0uAXn54JGmlGH1j3OvOS4+wxxMKxwPw2s/VtwEfqpQVGgrwI3BXhkh0cRScYanDZGD5TTfeoGMk8fN7lQpZBxZ/QSXvX7vcWVwAmuALdfzbzBb/JjupLeWIjEEg3eW8EBcsu0ErcxwWLsWS4KNzBP4hqEIj4=
Received: from AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::29)
 by VI1PR0602MB3582.eurprd06.prod.outlook.com (2603:10a6:803:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Sun, 22 May
 2022 07:04:27 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:e6:cafe::8d) by AM0PR10CA0112.outlook.office365.com
 (2603:10a6:208:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Sun, 22 May 2022 07:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 07:04:26 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V7 5/5] iio: accel: sca3300: Add inclination channels
Date:   Sun, 22 May 2022 07:04:19 +0000
Message-Id: <20220522070419.409556-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 40795085-6dae-4d25-1e9e-08da3bc14efe
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3582:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0602MB358233372F74A8416F668D28D7D59@VI1PR0602MB3582.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46VdBQWb88YzdBG38WP6I2CXF7WzZEtySli7pq8FZHcyK8m56DRezt6zLScrDhMfIrCuo5cxE1xUdiD78mBbqTE7vWC05+iLFT2uszP+yVSEzrj1LRUu5ih5BlBUwKVATkb326AgmzN5zAgrlPN9ZzSSiV+8cDcg5wdKbtrLUN5O1o5b2koIpe32tdiEeLep15nYu4thUNP7ydH2cZxOKS4ZFVrGYo8I3BMDd0Ed9JEsnh1eS9XnT9geaR/Lp9TFTGKKVuvTWPAzuTZtYiXZ0Zy2sml1Intao9Is02kisEp1uTDvNaDckQhWa618t6NvfUi96SFRX9raYA7ve3327OpbtGZDJYecCsxEeFoNrW4R3fxF8CojWzrvZJ/X6AHUvRfrBuXTTS0mcOoeKpHxyS44XwAeZV6HDSnB2kMWxg9qpMi276CuT4aILYsUn0zn8x2e2COMitmWNEqZnnrGfKfoghlKyRqypj8Sqi74GKYuajD+oQC9pcRPDQz93xxjHR22ViOSmHmpELA1fC6ET57HU0JU+A5ld8pvRGLFKpix5h7EJW0rTFWNbDMbTOG0tXTYXbp3gC/ice0QbCud47B0k5g+bocNUG5xPoQnEDfnlXmfYnds7il4ZKylWRJgnfNc1AglwyBlW75p4DfPolrggBfGIrT050AFTa7MJabocOzWb/gmzu80X2gwm8OA
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6506007)(336012)(186003)(6512007)(118246002)(26005)(6486002)(956004)(2906002)(86362001)(82310400005)(2616005)(36860700001)(36756003)(6666004)(83380400001)(1076003)(81166007)(8936002)(356005)(5660300002)(316002)(70586007)(40460700003)(508600001)(8676002)(47076005)(4326008)(70206006)(36736006);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 07:04:26.4319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40795085-6dae-4d25-1e9e-08da3bc14efe
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3582
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
 drivers/iio/accel/sca3300.c | 76 +++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 10bedb14d4f0..9094f16458de 100644
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
@@ -123,6 +168,9 @@ struct sca3300_chip_info {
 	u8 num_accel_scales;
 	const int (*accel_scale)[2];
 	const int *accel_scale_map;
+	const int (*incli_scale)[2];
+	const int *incli_scale_map;
+	u8 num_incli_scales;
 	u8 num_freqs;
 	const int *freq_table;
 	const int *freq_map;
@@ -131,6 +179,7 @@ struct sca3300_chip_info {
 	u8 chip_id;
 };
 
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
@@ -168,12 +217,16 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
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
 
+	if (value == SCL3300_WHOAMI_ID) {
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

