Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96F497C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiAXJj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:39:29 -0500
Received: from mail-vi1eur05on2139.outbound.protection.outlook.com ([40.107.21.139]:56800
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234335AbiAXJjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md71kW1ic2b/tLzTyPnalMDmFusrACZ+U6Z8S5uu10QWR5PEjoix9w1x8GT+qCc5iXiU83qmHAB984TcV5nNe2S9K077FWH/OVH+s199s9r/OXwCf3/BbUHh7UY7wmF8ZX/XN1QbQeXNLqDwfDFuvvbtfs1RuB5Q/tYan1ve8Jhw87BMnMa/16jDFrT1Cea0sT2I88Sz/xintDKo+cfiQb1V49Ga9fDvSETX120AEjiWOobWtPF2aHRpvJngdx4DuQNfrW1iaap5eriXctHm1SQnHvkugfQFYN+YR5RYobLq5XcrybowN9293WeFFqYS7Ajo5VCqIA4+AcymsS4vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrxAD9kFSGTM1pNAfizhmNFJ1Ka0Yc0uPuI5CR1FW8g=;
 b=ar0oLh8xmqltPOPtvDyXKZaP66kn08ZJbMogewhbSTqwLhiXfFVTX43NjLan+A4mNW5C/IQE4kUdrrFju1SwvOoc5Qcrcph1cF+0nx+0GpJOdOkjSI57YvJ3pHPMGNh8lKl9Wos8/7J+0enzZOTt2SrN1VF/9ZgAWwvIA03ZTzY2wIY066MeH1pGgXT9XkiWvfd1kzIfCyxZwrzGD6qj5r2h5RXFRJASf92yqOV7iCbTiy47VpRWhOZLaz59eSZUmAEVNuN/G2PvtC83B7KCzan3qGZohhqx+XEr0f9sIA2w82RzeMmRafL58t/J+vcJ9ri9R6102idGbjEVzRk2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.8.40.112) smtp.rcpttodomain=leica-geosystems.com.cn
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=leica-geosystems.com.cn; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrxAD9kFSGTM1pNAfizhmNFJ1Ka0Yc0uPuI5CR1FW8g=;
 b=BvMleYTZAjElM3CXk6pFDFmwJaSIgwDCQoqElaoQWjTx06KhAu/ENfjgazxjzzElublWq54GGM9CPA+WoNfiiww/FiLN1ZCIOuKxXYdkALOSNL/1ADjzxr+UIhY8vaPGFOZbwvYCSwlUsECFSsFMkAeaPezCUggRp0Kc5D/gIY0=
Received: from AS9PR06CA0050.eurprd06.prod.outlook.com (2603:10a6:20b:463::13)
 by HE1PR06MB3114.eurprd06.prod.outlook.com (2603:10a6:7:1e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 09:39:21 +0000
Received: from VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::9c) by AS9PR06CA0050.outlook.office365.com
 (2603:10a6:20b:463::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Mon, 24 Jan 2022 09:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 193.8.40.112)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine
 header.from=leica-geosystems.com.cn;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 leica-geosystems.com.cn discourages use of 193.8.40.112 as permitted sender)
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by
 VE1EUR02FT049.mail.protection.outlook.com (10.152.12.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:39:21 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     qing-wu.li@leica-geosystems.com.cn, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 3/6] iio: accel: sca3300: modified to support multi chips
Date:   Mon, 24 Jan 2022 09:39:09 +0000
Message-Id: <20220124093912.2429190-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d800b73f-a3e5-485e-1b32-08d9df1d6642
X-MS-TrafficTypeDiagnostic: HE1PR06MB3114:EE_
X-Microsoft-Antispam-PRVS: <HE1PR06MB3114B09FCCB78109B1E055F9D75E9@HE1PR06MB3114.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOGuGlL5LVrlZs6lRr+S2lL8f9ygm/QYMJ8EH7LvF9/uFv24Bsy68KyRsbA8f1b80Wc4st/Q947UzdhbLuxmHa9kMWjGfenLTV5OngEINrU/p2CNAEgsqt+aiXQEzHwQSZ8rdeBqcAwaffWa/anYvy2m2XSIZrcbqzXBFIyS7EGCJq9qYAcYkG3Y+PyW1gW+rfdKTS1ywnhnKq2Lh1X2i0VywxXgpGH1eK/n5t2KSP/97/GknQxdhHH3rkCLQVvb+FEDBCnEZADjhvkQKQEPqH0wBYHdoR+j+eIE954ob6qD6FX3VZw2bFouNC/K6xC0Rv20Vx7kZIpAVXWprf2HjCKGr2H9MP2f9D0fkEjeBropCDXloivafJFChVdQJrp3VmGGWhrJrvLLqugj2lQkaP1WahYJhhLwrFPDgRGnovKgn+msUt5GqXgMEYEIsOHD6Elr+Ztm9Qqo+LEYA51mau0/+PbLymdP/bV2dHHR02qBMlevkf30vUAR0IBhGYJbElJ1A3e0HaObc0fbEsWEFgn+L9ZW1+yld9hi6s5TUnlrJAYtD0aio8R8LKa7Pq6WdYJVSN+9248Rc6zSRz0Tfbib/NwO46xo0obRul8r1P/KwVYSA53MeGgDBK07lzo96zfbQ/fwr+R1SMkWDVMhtwPhSSj2bWNHNe823iKfvI/Ycsl/feEo+Bz3ZmaonIBrLV0/055Vnl5uCs3nZVzf7ZPJuBpPP9Vwu8Dxe31XT498flDVCcZcoTdA58sP/yv8ewZ8EpJ6ktAC6Q+zw/mdtA==
X-Forefront-Antispam-Report: CIP:193.8.40.112;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:mailhost.polymeca.com;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(82310400004)(40460700003)(336012)(36860700001)(508600001)(6486002)(5660300002)(6512007)(26005)(86362001)(186003)(2616005)(36756003)(956004)(47076005)(4326008)(83380400001)(81166007)(356005)(70586007)(8676002)(316002)(70206006)(1076003)(107886003)(6666004)(6506007)(118246002)(2906002)(8936002)(36736006);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:39:21.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d800b73f-a3e5-485e-1b32-08d9df1d6642
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.112];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drive support sca3300 only,there are some other similar chips,
for instance, SCL3300.
modified the driver to read the device id,
add the tables for the corresponding id to support multiple chips.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 108 +++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index e26b3175b3c6..26e6fab88a8f 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -37,11 +37,11 @@
 
 /* Device ID */
 #define SCA3300_REG_WHOAMI	0x10
-#define SCA3300_WHOAMI_ID	0x51
 
 /* Device return status and mask */
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
+
 enum sca3300_op_mode_indexes {
 	OP_MOD_1 = 0,
 	OP_MOD_2,
@@ -75,6 +75,11 @@ static const struct iio_chan_spec_ext_info sca3300_ext_info[] = {
 	{ }
 };
 
+enum sca3300_chip_type {
+	CHIP_SCA3300 = 0,
+	CHIP_CNT
+};
+
 enum sca3300_scan_indexes {
 	SCA3300_ACC_X = 0,
 	SCA3300_ACC_Y,
@@ -126,8 +131,13 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4)
 };
 
-static const int sca3300_lp_freq[] = {70, 70, 70, 10};
-static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
+static const int sca3300_lp_freq[CHIP_CNT][OP_MOD_CNT] = {
+	[CHIP_SCA3300] = {70, 70, 70, 10},
+};
+
+static const int sca3300_accel_scale[CHIP_CNT][OP_MOD_CNT][2] = {
+	[CHIP_SCA3300] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}},
+};
 
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
@@ -135,6 +145,15 @@ static const unsigned long sca3300_scan_masks[] = {
 	0
 };
 
+struct sca3300_chip_info {
+	enum sca3300_chip_type chip_type;
+	const char *name;
+	u8 chip_id;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	unsigned long scan_masks;
+};
+
 /**
  * struct sca3300_data - device data
  * @spi: SPI device structure
@@ -150,8 +169,21 @@ struct sca3300_data {
 		s16 channels[4];
 		s64 ts __aligned(sizeof(s64));
 	} scan;
+	const struct sca3300_chip_info *chip_info;
 	u8 txbuf[4] ____cacheline_aligned;
 	u8 rxbuf[4];
+
+};
+
+static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
+	[CHIP_SCA3300] = {
+		.chip_type = CHIP_SCA3300,
+		.name = "sca3300",
+		.chip_id = 0x51,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.scan_masks = sca3300_scan_masks,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -271,23 +303,20 @@ static int sca3300_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		if (val)
-			return -EINVAL;
-
-		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
-			if (val2 == sca3300_accel_scale[i][1])
+		for (i = 0; i < OP_MOD_CNT; i++) {
+			if ((val == sca3300_accel_scale[data->chip_info->chip_type][0]) &&
+			    (val2 == sca3300_accel_scale[data->chip_info->chip_type][1]))
 				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
 		}
 		return -EINVAL;
-
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
 		/* freq. change is possible only for mode 3 and 4 */
-		if (reg_val == 2 && val == sca3300_lp_freq[3])
+		if (reg_val == 2 && val == sca3300_lp_freq[data->chip_info->chip_type][3])
 			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
-		if (reg_val == 3 && val == sca3300_lp_freq[2])
+		if (reg_val == 3 && val == sca3300_lp_freq[data->chip_info->chip_type][2])
 			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
 		return -EINVAL;
 	default:
@@ -313,14 +342,18 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
-		*val = 0;
-		*val2 = sca3300_accel_scale[reg_val][1];
+		if (chan->type == IIO_ACCEL) {
+			*val = sca3300_accel_scale[data->chip_info->chip_type][reg_val][0];
+			*val2 = sca3300_accel_scale[data->chip_info->chip_type][reg_val][1];
+		} else {
+			return -EINVAL;
+		}
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
-		*val = sca3300_lp_freq[reg_val];
+		*val = sca3300_lp_freq[data->chip_info->chip_type][reg_val];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -364,6 +397,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 {
 	int value = 0;
 	int ret;
+	int i = 0;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
 				SCA3300_MODE_SW_RESET);
@@ -375,15 +409,22 @@ static int sca3300_init(struct sca3300_data *sca_data,
 	 * Wait 15ms for settling of signal paths.
 	 */
 	usleep_range(16e3, 50e3);
-
-	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
-	if (ret)
-		return ret;
-
-	if (value != SCA3300_WHOAMI_ID) {
-		dev_err(&sca_data->spi->dev,
-			"device id not expected value, %d != %u\n",
-			value, SCA3300_WHOAMI_ID);
+	for (i = 0; i < ARRAY_SIZE(sca3300_chip_info_tbl); i++) {
+		ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
+		if (ret)
+			return ret;
+		if (sca3300_chip_info_tbl[i].chip_id == value) {
+			sca_data->chip_info = &sca3300_chip_info_tbl[i];
+			indio_dev->name = sca3300_chip_info_tbl[i].name;
+			indio_dev->channels = sca3300_chip_info_tbl[i].channels;
+			indio_dev->num_channels = sca3300_chip_info_tbl[i].num_channels;
+			indio_dev->modes = INDIO_DIRECT_MODE;
+			indio_dev->available_scan_masks = sca3300_chip_info_tbl[i].scan_masks;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(sca3300_chip_info_tbl)) {
+		dev_err(&sca_data->spi->dev, "Invalid chip %x\n", value);
 		return -ENODEV;
 	}
 	return 0;
@@ -417,15 +458,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 			      const int **vals, int *type, int *length,
 			      long mask)
 {
+	struct sca3300_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		*vals = (const int *)sca3300_accel_scale;
-		*length = ARRAY_SIZE(sca3300_accel_scale) * 2 - 2;
+		if (chan->type == IIO_ACCEL) {
+			*vals = (const int *)sca3300_accel_scale[data->chip_info->chip_type];
+			*length = ARRAY_SIZE(sca3300_accel_scale[data->chip_info->chip_type]) * 2;
+		} else {
+			return -EINVAL;
+		}
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		*vals = &sca3300_lp_freq[2];
-		*length = 2;
+		*vals = (const int *)sca3300_lp_freq[data->chip_info->chip_type];
+		*length = ARRAY_SIZE(sca3300_lp_freq[data->chip_info->chip_type]);
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	default:
@@ -471,7 +518,6 @@ static int sca3300_probe(struct spi_device *spi)
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sca_data));
 	if (!indio_dev)
 		return -ENOMEM;
-
 	sca_data = iio_priv(indio_dev);
 	mutex_init(&sca_data->lock);
 	sca_data->spi = spi;
@@ -479,11 +525,7 @@ static int sca3300_probe(struct spi_device *spi)
 	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
 
 	indio_dev->info = &sca3300_info;
-	indio_dev->name = SCA3300_ALIAS;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sca3300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
-	indio_dev->available_scan_masks = sca3300_scan_masks;
+
 
 	ret = sca3300_init(sca_data, indio_dev);
 	if (ret) {
-- 
2.25.1

