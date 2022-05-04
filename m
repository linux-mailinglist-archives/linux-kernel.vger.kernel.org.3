Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F374751A109
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350670AbiEDNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350663AbiEDNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:40:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60110.outbound.protection.outlook.com [40.107.6.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E267924BC9;
        Wed,  4 May 2022 06:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APLUdT6iyOJHNxSK2VsScME3WLSsPMJQ/fpsiL8dORcSoUsYzykw85Ua/oHUIID2fsRUu3xO/Lr1vVLV7Au+LmqWqaREQ8qfXxNoQf4xtRD8iNbuZkuvGbyY8cB5GJTRSv7wf2g5oMCsjM6jZ4UJ2pFs4Luw/ibVOU6nKgcqKV2CpODOxX1d39BFOedtdfb+6q/PDZZCVSzHpapQVasUHPdEZfFNNrcUL7MuXNsSZU4JaQ+sGcNzB3QNFPN+E7XjuByvUAtotfLhs3ZpPdbRW1UR/NEVMYzsRfeFZeXMSF2ZVO5sw0d6+sH4yM7jB5A1sJiKYZHyLYHO7xep//8v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xCGUCuSDLGTJuXRZI98hvUTqJnk0E2N7Q+HvE5qIAU=;
 b=NXFh1/82OwKRdbr3Q1plVhG5ScjxY43xxsCAFt2cEI1dpxlXTgLrt+5kSywgPXFMar5ccH4HRMNV+oMBCid3ijXgSW3wH91kgv+F5300NQFA+CK6rQzoVKq0bzw5rQYz+0hVSaYxtOfmW4V3/st56INk9N1JUSyeQxlp+TIoQ2PTXs+Uabjkd+1fqRI+hZCerjIgUOGGakUYR5vcsi/3es/2jjah+GNxqQ8Bc/hNbteFWI667SVXdp5/ip8YFG1+Q8oAjORJjbgWK3LH8pbnVtsmZDvW8u9648wJMx05EdNh1bhrUrFllQrAgROdScuoGT17jHHHx3hlLOxDSgoGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xCGUCuSDLGTJuXRZI98hvUTqJnk0E2N7Q+HvE5qIAU=;
 b=Ss0P8PwxwYAt4msovAXh0t3QWmq7p3ZIeiYaqd7PFP8j+WcEbdbsgHeM83snT9ss5j1mpqqwZTY+se8JxTZvdmJMMEX/Zp6cUY/41BRX6FzjxvcdGkCKUEYDV6p5ra5Nqng0M9wbl598i+WKVmtGYDyJ4ue+JFNJdx56xiD5QpQ=
Received: from AM6PR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::22) by AM0PR06MB5619.eurprd06.prod.outlook.com
 (2603:10a6:208:11d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Wed, 4 May
 2022 13:36:33 +0000
Received: from VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::d2) by AM6PR01CA0045.outlook.office365.com
 (2603:10a6:20b:e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Wed, 4 May 2022 13:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT101.mail.protection.outlook.com (10.152.13.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:36:32 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi chips
Date:   Wed,  4 May 2022 13:36:10 +0000
Message-Id: <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 603aa8f8-a816-4867-e3d6-08da2dd31a41
X-MS-TrafficTypeDiagnostic: AM0PR06MB5619:EE_
X-Microsoft-Antispam-PRVS: <AM0PR06MB5619E6D90BB4BCA5281D91E9D7C39@AM0PR06MB5619.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYm2wVEZlJA2QzCs3oTNlcFqKby98sm5HurJqgFJN0JJTCuvHruGa5w+/ByWbIumYLTLlc4FfXH1RItDDhZtpwNZPaJ9VjlE9jIhwuvS/YY+pLIyx06HCwK5S2iwIVbKCBkEUfZ+N87Df/uXYVYmU29gaTLTK16f9LKvtYa1MvWnuXEvr7eW/11eqoolcNWTNBwt0RUZ3NUOBFVFIZtOi40z4/B4KHHP3sj2VZU9zGEG4prGiQmj/e4ou11ccLbFPP2ddTyi9Chl2lAUjq0F4ER6wPrVirBFg6lZzsijRutHwUGohaGBJHkcQb2UbWf0+yBbBpp5DMm9D13vgCqq8hLwtshvYuWx/kjr3MlfbpUZ3zgUtUi4Be8eYvFNB0LUZQu3LCfHSj7hcXIbBOeBDCVZBfRrbtqiTJZfp4Sd8ymBfRa3koRvh1ZmHmVlcacRklYW3+ekvBMm817/P873CBWyngPQQNMhwSeyYRwylCsK020tFRTSxmIBJz+s1Zv3eME+BhQxKp0gsFdSrWeFnLxpbzdiaXpPtOYK8NO7IzKzX11kAh0dKRmktvQEi6VDtqrH5BHqqrQY77WROLBFrH6asHMkIZ7j991ppPhwOkqpX+zrmIyXxhOHPWNuUZljaG324gFJj9cvt3dVlr9x4fPvCCN56GDRQHz4zYmVlmJ3xWFb3wUZzi79MJwqD7Fm
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(40460700003)(356005)(8936002)(83380400001)(26005)(118246002)(82310400005)(8676002)(4326008)(6512007)(36736006)(6666004)(316002)(6506007)(6486002)(2906002)(86362001)(336012)(36756003)(1076003)(47076005)(508600001)(186003)(956004)(2616005)(36860700001)(81166007)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:36:32.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603aa8f8-a816-4867-e3d6-08da2dd31a41
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB5619
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drive support sca3300 only.
There are some other similar chips, for instance, SCL3300.
Prepare the way for multiple chips and additional channels.
Modify the driver to read the device id.
Add the tables for the corresponding id to support multiple chips.
Add prepares for the addition of extra channels.
Add prepares for handling the operation modes for multiple chips.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 180 ++++++++++++++++++++++++++++--------
 1 file changed, 141 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ff16d2cc8c70..1e0e6a2f7a63 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -37,7 +37,6 @@
 
 /* Device ID */
 #define SCA3300_REG_WHOAMI	0x10
-#define SCA3300_WHOAMI_ID	0x51
 
 /* Device return status and mask */
 #define SCA3300_VALUE_RS_ERROR	0x3
@@ -93,15 +92,35 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-static const int sca3300_lp_freq[] = {70, 70, 70, 10};
-static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
+static const int sca3300_freq_tbl[] = {70, 10};
+static const int sca3300_freq_modes_map[] = {0, 0, 0, 1};
 
+static const int sca3300_accel_scale_tbl[][2] = {{0, 370}, {0, 741}, {0, 185}};
+static const int sca3300_accel_scale_modes_map[] = {0, 1, 2, 2};
+
+static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
 	0
 };
 
+struct sca3300_chip_info {
+	const struct iio_chan_spec *channels;
+	const int (*accel_scale_table)[2];
+	const int *accel_scale_modes_map;
+	const unsigned long *scan_masks;
+	const int *avail_modes_table;
+	const int *freq_modes_map;
+	const int *freq_table;
+	const u8 num_accel_scales;
+	const u8 num_avail_modes;
+	const u8 num_channels;
+	const u8 num_freqs;
+	const u8 chip_id;
+	const char *name;
+};
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
@@ -117,10 +136,28 @@ struct sca3300_data {
 		s16 channels[4];
 		s64 ts __aligned(sizeof(s64));
 	} scan;
+	const struct sca3300_chip_info *chip;
 	u8 txbuf[4] ____cacheline_aligned;
 	u8 rxbuf[4];
 };
 
+static const struct sca3300_chip_info sca3300_chip_tbl[] = {
+	{	.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale_tbl)*2,
+		.accel_scale_modes_map = sca3300_accel_scale_modes_map,
+		.accel_scale_table = sca3300_accel_scale_tbl,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.freq_modes_map = sca3300_freq_modes_map,
+		.avail_modes_table = sca3300_avail_modes_map,
+		.freq_table = sca3300_freq_tbl,
+		.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_avail_modes = 4,
+		.name = "sca3300",
+		.chip_id = 0x51,
+		.num_freqs = 2,
+	},
+};
+
 DECLARE_CRC8_TABLE(sca3300_crc_table);
 
 static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
@@ -227,36 +264,80 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
 	return sca3300_error_handler(sca_data);
 }
 
+static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
+{
+	int mode;
+
+	if ((index < 0) || (index >= sca_data->chip->num_avail_modes))
+		return -EINVAL;
+
+	mode = sca_data->chip->avail_modes_table[index];
+
+	return sca3300_write_reg(sca_data, SCA3300_REG_MODE, mode);
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
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int sca3300_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
+	int mode = -1;
 	int reg_val;
+	int index;
 	int ret;
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
+			index = data->chip->accel_scale_modes_map[i];
+			if ((val == data->chip->accel_scale_table[index][0]) &&
+			(val2 == data->chip->accel_scale_table[index][1])) {
+				mode = i;
+				break;
+			}
 		}
-		return -EINVAL;
-
+		return sca3300_set_op_mode(data, mode);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		ret = sca3300_get_op_mode(data, &reg_val);
 		if (ret)
 			return ret;
-		/* freq. change is possible only for mode 3 and 4 */
-		if (reg_val == 2 && val == sca3300_lp_freq[3])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
-		if (reg_val == 3 && val == sca3300_lp_freq[2])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
-		return -EINVAL;
+		index = data->chip->accel_scale_modes_map[reg_val];
+		for (i = 0; i < data->chip->num_avail_modes; i++) {
+			int index_new = data->chip->accel_scale_modes_map[i];
+			int index_freq = data->chip->freq_modes_map[i];
+
+			if (val == data->chip->freq_table[index_freq]) {
+				if (data->chip->accel_scale_table[index] ==
+				data->chip->accel_scale_table[index_new]) {
+					mode = i;
+					break;
+				}
+			}
+		}
+		return sca3300_set_op_mode(data, mode);
 	default:
 		return -EINVAL;
 	}
@@ -267,8 +348,9 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
-	int ret;
 	int reg_val;
+	int index;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -277,17 +359,25 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		ret = sca3300_get_op_mode(data, &reg_val);
 		if (ret)
 			return ret;
-		*val = 0;
-		*val2 = sca3300_accel_scale[reg_val][1];
-		return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			index = data->chip->accel_scale_modes_map[reg_val];
+			*val = data->chip->accel_scale_table[index][0];
+			*val2 = data->chip->accel_scale_table[index][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+
+		ret = sca3300_get_op_mode(data, &reg_val);
 		if (ret)
 			return ret;
-		*val = sca3300_lp_freq[reg_val];
+		index = data->chip->freq_modes_map[reg_val];
+		*val = data->chip->freq_table[index];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -331,6 +421,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 {
 	int value = 0;
 	int ret;
+	int i;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
 				SCA3300_MODE_SW_RESET);
@@ -347,12 +438,22 @@ static int sca3300_init(struct sca3300_data *sca_data,
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
+		dev_err(&sca_data->spi->dev, "Invalid chip %x\n", value);
 		return -ENODEV;
 	}
+
+	indio_dev->available_scan_masks = sca3300_chip_tbl[i].scan_masks;
+	indio_dev->num_channels = sca3300_chip_tbl[i].num_channels;
+	indio_dev->channels = sca3300_chip_tbl[i].channels;
+	sca_data->chip = &sca3300_chip_tbl[i];
+	indio_dev->name = sca3300_chip_tbl[i].name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
 	return 0;
 }
 
@@ -384,15 +485,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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
+			*vals = (const int *)data->chip->accel_scale_table;
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
@@ -424,11 +531,6 @@ static int sca3300_probe(struct spi_device *spi)
 	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
 
 	indio_dev->info = &sca3300_info;
-	indio_dev->name = SCA3300_ALIAS;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sca3300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
-	indio_dev->available_scan_masks = sca3300_scan_masks;
 
 	ret = sca3300_init(sca_data, indio_dev);
 	if (ret) {
-- 
2.25.1

