Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3675851F510
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiEIHGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiEIGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60110.outbound.protection.outlook.com [40.107.6.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7DD19CED5;
        Sun,  8 May 2022 23:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg93D8lIODWbE2CgFHn+hgLi8Cnfu28c+hFjPNRmO+8zGdaEBJnuvbUePWEB5zAadyI2jIXsmkAyQmexo1Tj5Vh9+dOAR16ftLSeMOpDFTU5G+K0Rd9sBe7kJeZsXu9DP3qx+b4agz/f87Ufl1U8KtLiSPRi12fyXnXWPWLYp8hB7RPAcKLBKJPj42x2HrzwPa/NLZtybBbhgWZhgl+lQGAriCp6RaP6fkoAE/0fQ8rE9VipFwDB+Pzz0zmvHKay26dz2Zb8qgyuH6GchnVmTK8JuMrZgLF/IMImYE7Z1RDxXQ6nLyB3SmnWRkJapxXp3T6DmrP3Gv5ecFkRER4S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6/IiB39Nv6gW1kAuAh0mPow8ixVVaBUx4lHppMBEyU=;
 b=e/hKoK+tRtAtXIVsqXXo1hjIbJP2VDPe50QTzSRWJNVzWErF/Cr+onvbxYBOzXxZdVNO0+kVFJi2R/Okw7nzwLZlE79uzsjUFAmbsdp/0WEiBSlpcVfGQuegP+XFzBz4Ap6LNquEaKsDLfwC0y2/ZpT+vI4w1nZglGNMTmr/SOGG0mQ1uWJjbPtjnI4qKKCb7kJt8svS48N3w6AwJMB6d7isHXv1+lT+uaLNVLJCo1Se18XqpDcbbtACNNy2zGa1AMp0ef8a3mb3yIb4Lf2xE9oP/sWmKwX8qUcxeplEiGBkQAfnuLBhlGYZGxDREBtTq4mjf9u3q7N5E5QXIQQ+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6/IiB39Nv6gW1kAuAh0mPow8ixVVaBUx4lHppMBEyU=;
 b=PEVLIh/4fj9bwlFrHKdEoQI5wp54+szaNT+pGFAy8L+ok4kBcivUo9EYBOYcq5bm7YwwlK4lFmlCGAoD0sXfy6WjyzGLLMruBlz4hVDhD7GMUr1zLvZstJT+soyRxet0GGAUkne/dUwPG6n+mu7Vnv+fzPNgHv3bUR19e/eAtgo=
Received: from BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::16) by
 HE1PR06MB3964.eurprd06.prod.outlook.com (2603:10a6:7:96::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.20; Mon, 9 May 2022 06:49:35 +0000
Received: from HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:b10:a:cafe::17) by BE0P281CA0006.outlook.office365.com
 (2603:10a6:b10:a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 06:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT040.mail.protection.outlook.com (10.152.11.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 06:49:35 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V4 3/5] iio: accel: sca3300: modified to support multi chips
Date:   Mon,  9 May 2022 06:49:26 +0000
Message-Id: <20220509064928.2352796-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8c5d5435-b6a5-48bd-1358-08da3188148a
X-MS-TrafficTypeDiagnostic: HE1PR06MB3964:EE_
X-Microsoft-Antispam-PRVS: <HE1PR06MB396419E56A3715B8C5B40031D7C69@HE1PR06MB3964.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEulrPkjCjd3Een2nma/Tf/rrcGjz7kjHn/W2ZYEKkxRYzokk1wIsAUBZLB70Z16eW0bzglSij9ED8XKSGwwF5EqpCyFe4kKtMdFHq88VreG8XTOCfrL80WuwPt1HzPPAETzLoh/wLCuYtxB7InxjW7zZei7Qg0ZVEfB3XJ/Q2kOObkaCJZMpjIb/rlhH2cZ6CERqiwSx6YNkUJ5+wVL475l2VojNCK2UXGnAWusoxdChZGKhuQ8rix6xr6Kv0AqnNgrpg1373AuRTr8J3CAi9gUrFtNv1abkjtMOg9oSTo60XVcE415ZJhw4qP3mFQdZ220XIlVqAfFOjSEBYV0fCO/0jLYfOm+x8VfzEh7hVh8EwtE4G6IsZX6iv/YcoNqaPAHy4NQFuHbsrcIJZ/exn7Ybnbif/j7HRfobqihpqrPXDbwyZsPfFzy14RMRbyMRP6rKK/FVtGwcOmvh5EP3tQSwYhm+ZLB5GfeSlksfoX8wx9RXJHr7rTwypJmuRrxt3R7a2NpyT6bJyaknmObKes66pfuvPU+IT+hhH8wFz0RzGCqIJHM8wn018myBviiNJFLjjpznvNI0+RPJX+SFmpAU20DWddsdnsplrGJWYsoX8FoCMSzbhSgVwA/26rxL8OEXhgXBoiWnS4/YUOtSnNFPf2KQZFQYnCTQUIMlUPT295/99LVhnBhup2SkgcR
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(186003)(508600001)(86362001)(336012)(1076003)(6512007)(316002)(118246002)(26005)(36736006)(6666004)(6506007)(356005)(70206006)(5660300002)(8676002)(81166007)(2906002)(70586007)(4326008)(956004)(2616005)(40460700003)(82310400005)(36860700001)(36756003)(6486002)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 06:49:35.1565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d5435-b6a5-48bd-1358-08da3188148a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver supports sca3300 only.
There are some other similar chips, for instance, SCL3300.
Prepare the way for multiple chips and additional channels.
Modify the driver to read the device id.
Add the tables for the corresponding id to support multiple chips.
Add prepares for the addition of extra channels.
Add prepares for handling the operation modes for multiple chips.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 182 ++++++++++++++++++++++++++++--------
 1 file changed, 141 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ff16d2cc8c70..39e6f9f162f2 100644
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
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+	const unsigned long *scan_masks;
+	const int (*accel_scale)[2];
+	const int *accel_scale_map;
+	u8 num_accel_scales;
+	const int *freq_table;
+	const int *freq_map;
+	u8 num_freqs;
+	const int *avail_modes_table;
+	u8 num_avail_modes;
+	const char *name;
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
+	{	.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.scan_masks = sca3300_scan_masks,
+		.accel_scale = sca3300_accel_scale,
+		.accel_scale_map = sca3300_accel_scale_map,
+		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
+		.freq_table = sca3300_lp_freq,
+		.freq_map = sca3300_lp_freq_map,
+		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
+		.avail_modes_table = sca3300_avail_modes_map,
+		.num_avail_modes = 4,
+		.name = "sca3300",
+		.chip_id = SCA3300_WHOAMI_ID,
+	},
+};
+
 DECLARE_CRC8_TABLE(sca3300_crc_table);
 
 static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
@@ -227,36 +265,77 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
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
+		if (sca_data->chip->avail_modes_table[i] == reg_val) {
+			*index = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
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
+		if (val == chip->freq_table[chip->freq_map[i]]) {
+			if (chip->accel_scale[chip->accel_scale_map[index]] ==
+			    chip->accel_scale[chip->accel_scale_map[i]])
+				return sca3300_set_op_mode(data, i);
+		}
+	}
+
+	return -EINVAL;
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
@@ -267,8 +346,8 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
+	int index;
 	int ret;
-	int reg_val;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -277,17 +356,25 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
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
@@ -331,6 +418,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 {
 	int value = 0;
 	int ret;
+	int i;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
 				SCA3300_MODE_SW_RESET);
@@ -347,12 +435,17 @@ static int sca3300_init(struct sca3300_data *sca_data,
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
 
@@ -384,15 +477,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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
@@ -424,11 +523,6 @@ static int sca3300_probe(struct spi_device *spi)
 	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
 
 	indio_dev->info = &sca3300_info;
-	indio_dev->name = SCA3300_ALIAS;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sca3300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
-	indio_dev->available_scan_masks = sca3300_scan_masks;
 
 	ret = sca3300_init(sca_data, indio_dev);
 	if (ret) {
@@ -436,6 +530,12 @@ static int sca3300_probe(struct spi_device *spi)
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

