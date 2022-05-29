Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED044536FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiE2GTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiE2GTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:19:09 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10130.outbound.protection.outlook.com [40.107.1.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B816C0D7;
        Sat, 28 May 2022 23:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJBdeqywe5gW1qC751QtxGskJgbFyOn3VgjoPUXV3DW5x7XVbPTiqlVy5pKNGBxnljBrzBL2YNiDG/heLAB+P8xLdlhOHF2ejb7VZvJdQ5I2N4lZKI9B45XiBfpze+on0YzWFVKPiUy2kMLul2HLGJXyP+tGSzOjchX0+LPz7W7nnCjYPZF9YfFnyezMkoryT/OoSh8cnMQgQX9oLGC62O/vMELeX5V6NJg1Z9Z8DJDu+ti4vrxWd958ASSr3I0+XSz5fM3FLc0WAu+FIBICOS1dd3h8FwMjYxjjF7HDBF4ZI0+5cDLYrgwqtbSZ2/aEy0Bn3omB3vWFPxSXufzFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMlwocUh4mUyagz5ivOTQPxjhix5xbWhneJnEU5MCSo=;
 b=jU4U6Ud2gw1GHJpAttQu3G4yvWrkKr28vaCESMiQ5jSCbktWZkZtgVK8yk88GjbzM8Q1aK30xCjE+gHMkoVdqVeZTXISy+oaP9AuptixltLZ9oFS3ZYzsSIn/FbgD2WphDftVxukIKQE5zrOKr0hweCyWO9wloTLLAb6s5nXk9rqf1mL3kHZJ4rrd9H/d6i3G1bwWZNxPD3rDl8QrIV9cEfLJIGKZaUJF5SwshPEvcqPZpvQwpZRYpasXVZZ+cpNxGkyKUN0NeM7Oj0LQdzUZXMI0VusOnsSQawH1VQCmXcFcaTlmS8xtr6qGCBk9Yp3LwZvdx1/tKKK+SHs3YNwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMlwocUh4mUyagz5ivOTQPxjhix5xbWhneJnEU5MCSo=;
 b=oYHCefkRwB+slU1INHM02AgYoEaM5jxktIwQ26VKzS4ZBw7YFB03IjBHxDIsJ0pwr5cQNFRKltlf4xtGe7QvrsUy3L2unq7MAGDSMtMo0+287KKboGvC8inEzY37AOZB2jO3oac55cCl5DuMAAuX3Tu0Rwaklbve57VMqidxw4k=
Received: from AS9P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::23)
 by VI1PR06MB6432.eurprd06.prod.outlook.com (2603:10a6:800:11e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sun, 29 May
 2022 06:18:59 +0000
Received: from VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::88) by AS9P250CA0019.outlook.office365.com
 (2603:10a6:20b:532::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Sun, 29 May 2022 06:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT016.mail.protection.outlook.com (10.152.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Sun, 29 May 2022 06:18:58 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn,
        thomas.haemmerle@leica-geosystems.com
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V9 3/5] iio: accel: sca3300: modified to support multi chips
Date:   Sun, 29 May 2022 06:18:51 +0000
Message-Id: <20220529061853.3044893-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 552efea6-b983-4915-a798-08da413b1e2d
X-MS-TrafficTypeDiagnostic: VI1PR06MB6432:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB643257C4285463D0639A8DEED7DA9@VI1PR06MB6432.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXt7e342loXA2YjQI8+iATob1jT9ej/xxdukvzIBv2yQkZqjn9abfbxNFzvlIt8THEgdFbxdyFH1y72+N8k6h3thiEZiB2MmhufGdyOukXyyyI3GyqtF4qoGMhrKRz5+cogp0eCRv7Pc3vxk76prWNuVi316tG+wjw0VuaryYQQnuEePVXVMA44Oyz1ofXpghV455EQnn98GzQXJx4m+7nW/9AvWRYI5eIRXhXS+Z1eS4rmjfoWafnRnpdqR+J28H0wQ8IeLN/TILabyP8IdzArxLuweRCDHANOAmGSWtnidddxeIDo+FNSrWkV387D3vq+TFI+4j3hj/W3QPwMxSoaoEbxRFp1Q+8D3xByRHfzq4JcW5lIcgCLQHWs/V6xlIgpavcZek6dtodPAp2p34bcXWFMEcfikEuGkvpe4bVmpFyEn1YifWXkMiC43YiQtY1jcIMtZzkhK52pFcm5MVoGTIaVDwZHI0R9cF5iUQNQnZ9FKii923uaTdBIxqpTDqisc0bRZNu/dGYLRcDKB0qe3d8O+mlx2VPWHSSXMvVdHLUyMPB2YLCTOAjb+u5npDNYc2By1CzF1dtJ0nSntDFUEoU2257Hx8Ki48pNvMYgVdXuR6/Mjc2J2UiBfIT95Vezkp5lfO7ZdDCc8X0yfkU/TbmlIMuR6x5JKAqwgYgTMnRPUZD/Moo5X1vzBuVXz
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(40460700003)(82310400005)(336012)(2616005)(86362001)(956004)(5660300002)(6666004)(6486002)(6506007)(70586007)(70206006)(36736006)(36756003)(8936002)(1076003)(316002)(8676002)(4326008)(356005)(6512007)(81166007)(118246002)(186003)(2906002)(36860700001)(26005)(508600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 06:18:58.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552efea6-b983-4915-a798-08da413b1e2d
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6432
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the way for multiple chips and additional channels:
- Modify the driver to read the device ID and load the corresponding
  sensor information from the table to support multiple chips
- Add prepares for the addition of extra channels
- Prepare for handling the operation modes for multiple chips

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 197 ++++++++++++++++++++++++++++--------
 1 file changed, 156 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ff16d2cc8c70..21bf439e5c84 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -93,19 +93,40 @@ static const struct iio_chan_spec sca3300_channels[] = {
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
+	const char *name;
+	const unsigned long *scan_masks;
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+	u8 num_accel_scales;
+	const int (*accel_scale)[2];
+	const int *accel_scale_map;
+	u8 num_freqs;
+	const int *freq_table;
+	const int *freq_map;
+	const int *avail_modes_table;
+	u8 num_avail_modes;
+	u8 chip_id;
+};
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
  * @lock: Data buffer lock
+ * @chip: Sensor chip specific information
  * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
  * @txbuf: Transmit buffer
  * @rxbuf: Receive buffer
@@ -113,6 +134,7 @@ static const unsigned long sca3300_scan_masks[] = {
 struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
+	const struct sca3300_chip_info *chip;
 	struct {
 		s16 channels[4];
 		s64 ts __aligned(sizeof(s64));
@@ -121,6 +143,24 @@ struct sca3300_data {
 	u8 rxbuf[4];
 };
 
+static const struct sca3300_chip_info sca3300_chip_tbl[] = {
+	{
+		.name = "sca3300",
+		.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
+		.accel_scale = sca3300_accel_scale,
+		.accel_scale_map = sca3300_accel_scale_map,
+		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
+		.freq_table = sca3300_lp_freq,
+		.freq_map = sca3300_lp_freq_map,
+		.avail_modes_table = sca3300_avail_modes_map,
+		.num_avail_modes = 4,
+		.chip_id = SCA3300_WHOAMI_ID,
+	},
+};
+
 DECLARE_CRC8_TABLE(sca3300_crc_table);
 
 static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
@@ -227,36 +267,91 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
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
+		if (sca_data->chip->avail_modes_table[i] == reg_val)
+			break;
+	}
+	if (i == sca_data->chip->num_avail_modes)
+		return -EINVAL;
+
+	*index = i;
+	return 0;
+}
+
+static int sca3300_set_frequency(struct sca3300_data *data, int val)
+{
+	const struct sca3300_chip_info *chip = data->chip;
+	unsigned int index;
+	int *opmode_scale;
+	int *new_scale;
+	unsigned int i;
+
+	if (sca3300_get_op_mode(data, &index))
+		return -EINVAL;
+
+	/*
+	 * Find a mode in which the requested sampling frequency is available
+	 * and the scaling currently set is retained.
+	 */
+	opmode_scale = (int *)chip->accel_scale[chip->accel_scale_map[index]];
+	for (i = 0; i < chip->num_avail_modes; i++) {
+		new_scale = (int *)chip->accel_scale[chip->accel_scale_map[i]];
+		if ((val == chip->freq_table[chip->freq_map[i]]) &&
+		    (opmode_scale[1] == new_scale[1]) &&
+		    (opmode_scale[0] == new_scale[0]))
+			break;
+	}
+	if (i == chip->num_avail_modes)
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
+		/*
+		 * Letting scale take priority over sampling frequency.
+		 * That makes sense given we can only ever end up increasing
+		 * the sampling frequency which is unlikely to be a problem.
+		 */
+		for (i = 0; i < data->chip->num_avail_modes; i++) {
+			index = data->chip->accel_scale_map[i];
+			if ((val  == data->chip->accel_scale[index][0]) &&
+			    (val2 == data->chip->accel_scale[index][1]))
+				return sca3300_set_op_mode(data, i);
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
@@ -267,8 +362,8 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
+	int index;
 	int ret;
-	int reg_val;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -277,17 +372,24 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
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
+			*val  = data->chip->accel_scale[index][0];
+			*val2 = data->chip->accel_scale[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		ret = sca3300_get_op_mode(data, &index);
 		if (ret)
 			return ret;
-		*val = sca3300_lp_freq[reg_val];
+		index = data->chip->freq_map[index];
+		*val = data->chip->freq_table[index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -331,6 +433,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 {
 	int value = 0;
 	int ret;
+	int i;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
 				SCA3300_MODE_SW_RESET);
@@ -347,12 +450,17 @@ static int sca3300_init(struct sca3300_data *sca_data,
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
 
@@ -384,15 +492,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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
@@ -424,11 +538,6 @@ static int sca3300_probe(struct spi_device *spi)
 	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
 
 	indio_dev->info = &sca3300_info;
-	indio_dev->name = SCA3300_ALIAS;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sca3300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
-	indio_dev->available_scan_masks = sca3300_scan_masks;
 
 	ret = sca3300_init(sca_data, indio_dev);
 	if (ret) {
@@ -436,6 +545,12 @@ static int sca3300_probe(struct spi_device *spi)
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

