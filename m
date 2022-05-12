Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CD15251D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356204AbiELQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356165AbiELQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:03:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2094.outbound.protection.outlook.com [40.107.21.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1B62205;
        Thu, 12 May 2022 09:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1u+7Vy8TTstIrRu2i1NZbH2jAsruMzE75LtUaGibs/L2BN20j8pVSZPn0LUzlhPEFjcIYB1ZKB9dJM0jcqqGnNr2+fobK9W2oxS3zew745vl4A/7H284ITl0gN3s3qCvdL54OZ/2CvcliUMDduPa1KPBns8evQr4GIu8vlIU34F39AVGJqYA+IR6uVdVheripNK5dOdHr6JzEZLwD/af167SkF6MDWAPCRm6qO+hpgkdpMWNXaxlElvYQDDvYiFSG9XXhfwCef6von5gHimuoP5prtAA6aVFA4JT+aoIfy6kDQgTnRtOW9MDIxQ+KhNZGsJTsg49sYqnpkz3KucKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMssC8u6DNzhzOrLeXF9jkYO7TZ0xF8MfgyIjvvJsTY=;
 b=V3BLlCOyUQMoNPMhxnttuI9jCy3dm+SdZBqSPPRN1Dtbtcmnji5J60hQzcGiLiXjpg3/9+O12153PZeemAxxZy1RPv8sbJ0suhgJSLNpICGcTvt3ZW+C+35XTM+PTr82mSCC+gvFO7sgSQOVqJEN/W/81pdmSs5ejm1FFpL/zo7asKy77Oc+kRmtanX5ZShYVxV9ctqRdVacmgaJWgntpnxMN6qVNVP4yuZcIAfY7x+PW8veDuU7+yrTOd0pnMqGuWzyzpL/HAMPzdUReqqE2H6g081SY7nhCvkfANJkEvrW5wFCpuQ2so8ZFKWZaXxRw8TVM+AKHB4/b+TgPs7M+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMssC8u6DNzhzOrLeXF9jkYO7TZ0xF8MfgyIjvvJsTY=;
 b=mQ6hNfoanNI0Yin47bMH/rdW1Yk/AVGfr7UlqgxxBMln2rbrYvxrEdIy/xGTMICqf/ByF7LbaiGXa4ZDd9vl6NFj+1m+JHAcCbCEqV3Fg0BoVb0hYfz8roaL5LBtQOfPlJX3viz5M+B93k7pmIuU90LCOCfVLblZeMq93ikelzc=
Received: from OL1P279CA0049.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::18)
 by HE1PR06MB3995.eurprd06.prod.outlook.com (2603:10a6:7:9f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 16:03:19 +0000
Received: from HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::a3) by OL1P279CA0049.outlook.office365.com
 (2603:10a6:e10:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 16:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT005.mail.protection.outlook.com (10.152.10.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 16:03:18 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V5 3/5] iio: accel: sca3300: modified to support multi chips
Date:   Thu, 12 May 2022 16:03:10 +0000
Message-Id: <20220512160312.3880433-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1217c7b3-731f-4792-a035-08da3430ee7c
X-MS-TrafficTypeDiagnostic: HE1PR06MB3995:EE_
X-Microsoft-Antispam-PRVS: <HE1PR06MB3995FE1EE8C53FE959B34136D7CB9@HE1PR06MB3995.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gn6IkFO0IE5easGcOWL4N2asyVB6zYG9wx4kqTaE5vPo459mRcD7nVcPOyJeurLuL9WlinPlFWSvkhBL9JgRcDH2XeVRbsLxgG8uOwUGm/5AP8mTw9wSfIc2/yG9ef1Jqu2brTpjiTiU25Z+2exz2IkbgE2adZ0I6V1tJSxBpuKuD4dfATgCEYd7uIS+0aiaNN4tESA0ZMkvjkYnS6lOjhkOTdDH3fWQex++Ox62STM31iyu8+0JSOf7elyPJm3Rv1zQfmiQFcvhAez6wQq1E2CCf8w1n07sm+bUo0z4wkvQeF+6o1wiWrXV0VlrsBz0BX0lPJkGiZSzcZaRbMbOqfHXm4OrgEq6TBv25kCifr/RRps6yS97Fcm1CKkLCeRE8GW6YPvmtR3Sf3rySJv4j1mLLSWAkId86opFHHvNuFpWxixRRBK5Zom6ut0m4vjozCAcRGgRoFiwIZwGZszLGze6AnEGM+epYPlw2x+RHAk+sJsJ2zQNLUPxRU+Ht6x0IBZjRfm3pxjOoyE029iuDgq1ZqcGSH5RIFuq1o8t80TM9kfam6/ohCfqnfTFBMaxoUfihiJ/pggaK//tENgB4nH9YcPqzcKdxlShS7Bl+cO+mZlYf6K/5EVFGEjOkPPv+vxSic/e4yqyxpg7T9NxG6fYcn+PL7JfYa/egNfRu2PJNufXTIh/K8PGKR8hWpAx
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(6486002)(956004)(2906002)(81166007)(118246002)(2616005)(1076003)(356005)(86362001)(508600001)(6506007)(186003)(5660300002)(36860700001)(8936002)(336012)(316002)(36756003)(82310400005)(6512007)(26005)(83380400001)(4326008)(8676002)(70586007)(70206006)(36736006)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:03:18.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1217c7b3-731f-4792-a035-08da3430ee7c
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports sca3300 only, there are some other similar chips,
for instance, SCL3300. This commit prepares the way for multiple chips
and additional channels. Modify the driver to read the device ID and load
the corresponding sensor information from the table to support multiple
chips. add prepares for the addition of extra channels. Add prepares for
handling the operation modes for multiple chips.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 186 ++++++++++++++++++++++++++++--------
 1 file changed, 145 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ff16d2cc8c70..80168f926b9d 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -93,15 +93,35 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-static const int sca3300_lp_freq[] = {70, 70, 70, 10};
-static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
+static const int sca3300_lp_freq[] = {70, 10};
+static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
 
+static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
+static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
+
+static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
 	0
 };
 
+struct sca3300_chip_info {
+	const unsigned long *scan_masks;
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+	u8 num_accel_scales;
+	const int (*accel_scale)[2];
+	const int *accel_scale_map;
+	u8 num_freqs;
+	const int *freq_table;
+	const int *freq_map;
+	const char *name;
+	const int *avail_modes_table;
+	u8 num_avail_modes;
+	u8 chip_id;
+};
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
@@ -117,10 +137,28 @@ struct sca3300_data {
 		s16 channels[4];
 		s64 ts __aligned(sizeof(s64));
 	} scan;
+	const struct sca3300_chip_info *chip;
 	u8 txbuf[4] ____cacheline_aligned;
 	u8 rxbuf[4];
 };
 
+static const struct sca3300_chip_info sca3300_chip_tbl[] = {
+	{	.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
+		.accel_scale = sca3300_accel_scale,
+		.accel_scale_map = sca3300_accel_scale_map,
+		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
+		.freq_table = sca3300_lp_freq,
+		.freq_map = sca3300_lp_freq_map,
+		.name = "sca3300",
+		.avail_modes_table = sca3300_avail_modes_map,
+		.num_avail_modes = 4,
+		.chip_id = SCA3300_WHOAMI_ID,
+	},
+};
+
 DECLARE_CRC8_TABLE(sca3300_crc_table);
 
 static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
@@ -227,36 +265,81 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
 	return sca3300_error_handler(sca_data);
 }
 
+static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
+{
+	if ((index < 0) || (index >= sca_data->chip->num_avail_modes))
+		return -EINVAL;
+
+	return sca3300_write_reg(sca_data, SCA3300_REG_MODE,
+				 sca_data->chip->avail_modes_table[index]);
+}
+
+static int sca3300_get_op_mode(struct sca3300_data *sca_data, int *index)
+{
+	int reg_val;
+	int ret;
+	int i;
+
+	ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
+		if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
+			break;
+	}
+
+	if (i >= sca_data->chip->num_avail_modes)
+		return -EINVAL;
+
+	*index = i;
+	return 0;
+}
+
+static int sca3300_set_frequency(struct sca3300_data *data, int val)
+{
+	const struct sca3300_chip_info *chip = data->chip;
+	int index;
+	int i;
+
+	if (sca3300_get_op_mode(data, &index))
+		return -EINVAL;
+
+	for (i = 0; i < chip->num_avail_modes; i++) {
+		if ((val == chip->freq_table[chip->freq_map[i]]) &&
+		    (chip->accel_scale[chip->accel_scale_map[index]] ==
+		     chip->accel_scale[chip->accel_scale_map[i]]))
+			break;
+	}
+
+	if (i >= chip->num_avail_modes)
+		return -EINVAL;
+
+	return sca3300_set_op_mode(data, i);
+}
+
 static int sca3300_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
-	int reg_val;
-	int ret;
+	int index;
 	int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		if (val)
+		if (chan->type != IIO_ACCEL)
 			return -EINVAL;
-
-		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
-			if (val2 == sca3300_accel_scale[i][1])
-				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
+		for (i = 0; i < data->chip->num_avail_modes; i++) {
+			index = data->chip->accel_scale_map[i];
+			if ((val  == data->chip->accel_scale[index][0]) &&
+			    (val2 == data->chip->accel_scale[index][1])) {
+				return sca3300_set_op_mode(data, i);
+			}
 		}
 		return -EINVAL;
-
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
-		if (ret)
-			return ret;
-		/* freq. change is possible only for mode 3 and 4 */
-		if (reg_val == 2 && val == sca3300_lp_freq[3])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
-		if (reg_val == 3 && val == sca3300_lp_freq[2])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
-		return -EINVAL;
+		return sca3300_set_frequency(data, val);
 	default:
 		return -EINVAL;
 	}
@@ -267,8 +350,8 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
+	int index;
 	int ret;
-	int reg_val;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -277,17 +360,25 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		ret = sca3300_get_op_mode(data, &index);
 		if (ret)
 			return ret;
-		*val = 0;
-		*val2 = sca3300_accel_scale[reg_val][1];
-		return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			index = data->chip->accel_scale_map[index];
+			*val = data->chip->accel_scale[index][0];
+			*val2 = data->chip->accel_scale[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+
+		ret = sca3300_get_op_mode(data, &index);
 		if (ret)
 			return ret;
-		*val = sca3300_lp_freq[reg_val];
+		index = data->chip->freq_map[index];
+		*val = data->chip->freq_table[index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -331,6 +422,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 {
 	int value = 0;
 	int ret;
+	int i;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
 				SCA3300_MODE_SW_RESET);
@@ -347,12 +439,17 @@ static int sca3300_init(struct sca3300_data *sca_data,
 	if (ret)
 		return ret;
 
-	if (value != SCA3300_WHOAMI_ID) {
-		dev_err(&sca_data->spi->dev,
-			"device id not expected value, %d != %u\n",
-			value, SCA3300_WHOAMI_ID);
+	for (i = 0; i < ARRAY_SIZE(sca3300_chip_tbl); i++) {
+		if (sca3300_chip_tbl[i].chip_id == value)
+			break;
+	}
+	if (i == ARRAY_SIZE(sca3300_chip_tbl)) {
+		dev_err(&sca_data->spi->dev, "unknown chip id %x\n", value);
 		return -ENODEV;
 	}
+
+	sca_data->chip = &sca3300_chip_tbl[i];
+
 	return 0;
 }
 
@@ -384,15 +481,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 			      const int **vals, int *type, int *length,
 			      long mask)
 {
+	struct sca3300_data *data = iio_priv(indio_dev);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		*vals = (const int *)sca3300_accel_scale;
-		*length = ARRAY_SIZE(sca3300_accel_scale) * 2 - 2;
-		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*vals = (const int *)data->chip->accel_scale;
+			*length = data->chip->num_accel_scales;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		*vals = &sca3300_lp_freq[2];
-		*length = 2;
+		*vals = (const int *)data->chip->freq_table;
+		*length = data->chip->num_freqs;
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	default:
@@ -424,11 +527,6 @@ static int sca3300_probe(struct spi_device *spi)
 	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
 
 	indio_dev->info = &sca3300_info;
-	indio_dev->name = SCA3300_ALIAS;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sca3300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
-	indio_dev->available_scan_masks = sca3300_scan_masks;
 
 	ret = sca3300_init(sca_data, indio_dev);
 	if (ret) {
@@ -436,6 +534,12 @@ static int sca3300_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	indio_dev->name = sca_data->chip->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sca_data->chip->channels;
+	indio_dev->num_channels = sca_data->chip->num_channels;
+	indio_dev->available_scan_masks = sca_data->chip->scan_masks;
+
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      sca3300_trigger_handler, NULL);
-- 
2.25.1

