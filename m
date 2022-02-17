Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D64B9943
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiBQG1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:27:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiBQG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2120.outbound.protection.outlook.com [40.107.22.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E59201901;
        Wed, 16 Feb 2022 22:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG4rAzVKC/yzwx8Q11+l/070aUxTJJQTlF7uZvlfBMP35ETUvyyIwoTFf1Q3h3akCm9xP9rrKkjV1/Crr49dqQ5+5qchZOJDRzlcw3pCpZBhdBpkW3/13T/4PKu3UmNZJKtfeEFQKoEABDl7RiV3MXAt9Cn2G5uLV5zleXl75GUmd9nTiVQiH48rvNMne0meH35irWjr2oYJEykmNyU9dftjKdUV12u7+KdYPtWKNZAyhfbHiOTXhul6+1e2uYKisD+cFpBXHj0lAMdoU8KE1EuYQaQAyY80PpUa6bXLxsHKHSQl4jbi0/xIzzyDWhL/vmsyEVevPYWGGmU0njLstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeo3P6bcWH+w7eQPcd7Ts/60gi4ZllQduypxLPWV6N4=;
 b=I5a2Qp14ZRG7edScp/ccLxlABA9ClcvYIVJOhT7uWjSyAf+H8xJ1X9C+nrvbi0ie8HoTOXJkfGjoLfFdeS0xrtO2B5lugERxRiqp5o3ftBM6XRhGlgwVNLR9fZVS6HXXB04d0pzZHEX0Mw/LNCBMsPB+/MTywWG2HYkFlVe7yCYetb78xfq8/jJbQguy5QD019Id1lWfcls8zo+NdR/E4NqeNN2lJBdhgYYQHRrC/+1RVx4ypa4cgXCq0DxAZRwhTMeFA/4QeEfX67Oom6r73wu7fsZCuHk4IRyWte5U8FzumVbtd/rknkRwnmgt/mJqhaJJZu80Vo6NcpSbzjqwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeo3P6bcWH+w7eQPcd7Ts/60gi4ZllQduypxLPWV6N4=;
 b=ghRZ5lRW8SgWevi3ER9NXX+Rme2R5oQI2Jey7mE4JFTh/yILFHL5+2/oVwUe1Wo96K5IlSRQIKssf9fAUP0ZazMX52eT+2dmVktVGmEBD3fvhA9c+KmalulYZnWsmJU2g/e3F5Sa5/A17Vm5pD15CdirN7gaWKgeDqTAy7aXcs0=
Received: from AM6P192CA0077.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::18)
 by DB3PR0602MB3739.eurprd06.prod.outlook.com (2603:10a6:8:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 06:27:10 +0000
Received: from AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::22) by AM6P192CA0077.outlook.office365.com
 (2603:10a6:209:8d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 06:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT043.mail.protection.outlook.com (10.152.9.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 06:27:10 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V2 3/5] iio: accel: sca3300: modified to support multi chips
Date:   Thu, 17 Feb 2022 06:27:03 +0000
Message-Id: <20220217062705.2867149-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6500703b-87c3-4430-977e-08d9f1de876a
X-MS-TrafficTypeDiagnostic: DB3PR0602MB3739:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0602MB37397381602455B7DEBDA975D7369@DB3PR0602MB3739.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4+shCNl7cRuYQM5OuV3k0gJwQp5sJB7Z0q04q+H/SVo8AfNZbVFL/pMt2hizJv35vRxQVWelkQ77YmRG6YhpixeWZVuYu2etJjnjeoD650Gajgy+U1h6yOHlxQIkwuC8v/9Nik/eYJhR58mkVlg+q/R46OKJZoJkx1AEqS6Z9UDQTDATobQI8iEr23VyrLap2DYjCzMhS+eZ34w4hvhdiv2Sx6R/gUkqNSyjqMIIebgZJ2KpYNUtHj00ga3ERt6OmK/DgSICEm/nd6zbhxeOTnkJsqXe9dG4qMR+RbxsI9og4t6p99V1zQVmvlui39GGW/1+gl2I3J+Y5Y9hSf0InahpUObt2JYTMFLQneANvQ1U5qZxvnMRoKD+UDN4T8S3exy2bOdCoezgE9wXQYA9UfskDnsQftTxW8tEdjYZ4+xmsoU2dg0A3AJ1nC1fC2cQutM7HD8U6r7DODs39owtD+2Opmf2aJXByY7cVQoOg+5SQu1xjGH5cSz7SBuYSXN7/0VCo7WHtFUIZWWy+QnV5v3NZT6shQ8mYpLHvkADAgul4fg0KU9XCUhKxehxoGx0yiqf9XkqEZTrPeZE4c7O/IVDxvCLdsli3ntdMR9zmUN+Xt6X5L5z3It6Qe0ADQRkW0n4W7uVLUU1Lr1GRnyeUrqcngUq50tzR48zuicWQgDf8gXVspbZMFxUgDae8ra
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(26005)(186003)(8936002)(118246002)(6506007)(6666004)(956004)(40460700003)(1076003)(6512007)(508600001)(6486002)(2616005)(70586007)(83380400001)(2906002)(36860700001)(36736006)(86362001)(47076005)(70206006)(8676002)(356005)(336012)(5660300002)(316002)(36756003)(4326008)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 06:27:10.3819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6500703b-87c3-4430-977e-08d9f1de876a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0602MB3739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drive support sca3300 only,there are some other similar chips,
for instance, SCL3300.
modified the driver to read the device id,
add the tables for the corresponding id to support multiple chips.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 156 +++++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ff16d2cc8c70..b1748874c02d 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -37,12 +37,24 @@
 
 /* Device ID */
 #define SCA3300_REG_WHOAMI	0x10
-#define SCA3300_WHOAMI_ID	0x51
 
 /* Device return status and mask */
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
 
+enum sca3300_op_mode_indexes {
+	OP_MOD_1 = 0,
+	OP_MOD_2,
+	OP_MOD_3,
+	OP_MOD_4,
+	OP_MOD_CNT,
+};
+
+enum sca3300_chip_type {
+	CHIP_SCA3300 = 0,
+	CHIP_CNT
+};
+
 enum sca3300_scan_indexes {
 	SCA3300_ACC_X = 0,
 	SCA3300_ACC_Y,
@@ -91,15 +103,29 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
 	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
+	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
 };
 
-static const int sca3300_lp_freq[] = {70, 70, 70, 10};
-static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
+static const int sca3300_lp_freq_table[] = {70, 70, 70, 10};
+static const int sca3300_accel_scale_table[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
 
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
-	0
+	0,
+};
+
+struct sca3300_chip_info {
+	const struct iio_chan_spec *channels;
+	enum sca3300_chip_type chip_type;
+	const int (*accel_scale_table)[2];
+	unsigned int num_accel_scales;
+	unsigned long scan_masks;
+	unsigned int num_freqs;
+	const int *freq_table;
+	const char *name;
+	int num_channels;
+	u8 chip_id;
 };
 
 /**
@@ -114,13 +140,29 @@ struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
 	struct {
-		s16 channels[4];
+		s16 channels[SCA3300_TIMESTAMP - 1];
 		s64 ts __aligned(sizeof(s64));
 	} scan;
+	const struct sca3300_chip_info *chip_info;
 	u8 txbuf[4] ____cacheline_aligned;
 	u8 rxbuf[4];
 };
 
+static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
+	[CHIP_SCA3300] = {
+		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale_table)*2-1,
+		.accel_scale_table = sca3300_accel_scale_table,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.freq_table = &sca3300_lp_freq_table[2],
+		.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.chip_type = CHIP_SCA3300,
+		.name = "sca3300",
+		.chip_id = 0x51,
+		.num_freqs = 2,
+	},
+};
+
 DECLARE_CRC8_TABLE(sca3300_crc_table);
 
 static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
@@ -227,36 +269,57 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
 	return sca3300_error_handler(sca_data);
 }
 
+static int sca3300_set_op_mode(struct sca3300_data *sca_data, unsigned int mode)
+{
+	if ((mode < OP_MOD_1) || (mode >= OP_MOD_CNT))
+		return -EINVAL;
+
+	return sca3300_write_reg(sca_data, SCA3300_REG_MODE, mode);
+}
+
 static int sca3300_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
+	int mode = -1;
 	int reg_val;
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
+		for (i = 0; i < OP_MOD_CNT; i++) {
+			if ((val == data->chip_info->accel_scale_table[i][0]) &&
+			(val2 == data->chip_info->accel_scale_table[i][1])) {
+				mode = i;
+				break;
+			}
 		}
-		return -EINVAL;
-
+		return sca3300_set_op_mode(data, mode);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
-		/* freq. change is possible only for mode 3 and 4 */
-		if (reg_val == 2 && val == sca3300_lp_freq[3])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
-		if (reg_val == 3 && val == sca3300_lp_freq[2])
-			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
-		return -EINVAL;
+		for (i = 0; i < OP_MOD_CNT; i++) {
+			if (val == data->chip_info->freq_table[i]) {
+				mode = i;
+				break;
+			}
+		}
+		switch (data->chip_info->chip_type) {
+		case CHIP_SCA3300:
+			/* SCA330 freq. change is possible only for mode 3 and 4 */
+			if (reg_val == OP_MOD_3 && mode == OP_MOD_4)
+				return sca3300_set_op_mode(data, mode);
+			if (reg_val == OP_MOD_4 && mode == OP_MOD_3)
+				return sca3300_set_op_mode(data, mode);
+			return -EINVAL;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -267,8 +330,8 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
-	int ret;
 	int reg_val;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -280,14 +343,18 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
-		*val = 0;
-		*val2 = sca3300_accel_scale[reg_val][1];
-		return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->type) {
+		case IIO_ACCEL:
+			*val =  data->chip_info->accel_scale_table[reg_val][0];
+			*val2 = data->chip_info->accel_scale_table[reg_val][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+		return -EINVAL;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
-		*val = sca3300_lp_freq[reg_val];
+		*val = data->chip_info->freq_table[reg_val];
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -330,6 +397,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
 			struct iio_dev *indio_dev)
 {
 	int value = 0;
+	int i = 0;
 	int ret;
 
 	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
@@ -347,12 +415,22 @@ static int sca3300_init(struct sca3300_data *sca_data,
 	if (ret)
 		return ret;
 
-	if (value != SCA3300_WHOAMI_ID) {
-		dev_err(&sca_data->spi->dev,
-			"device id not expected value, %d != %u\n",
-			value, SCA3300_WHOAMI_ID);
+	for (i = 0; i < ARRAY_SIZE(sca3300_chip_info_tbl); i++) {
+		if (sca3300_chip_info_tbl[i].chip_id == value)
+			break;
+	}
+	if (i == ARRAY_SIZE(sca3300_chip_info_tbl)) {
+		dev_err(&sca_data->spi->dev, "Invalid chip %x\n", value);
 		return -ENODEV;
 	}
+
+	indio_dev->available_scan_masks = sca3300_chip_info_tbl[i].scan_masks;
+	indio_dev->num_channels = sca3300_chip_info_tbl[i].num_channels;
+	indio_dev->channels = sca3300_chip_info_tbl[i].channels;
+	sca_data->chip_info = &sca3300_chip_info_tbl[i];
+	indio_dev->name = sca3300_chip_info_tbl[i].name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
 	return 0;
 }
 
@@ -384,15 +462,22 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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
+			*vals = (const int *)data->chip_info->accel_scale_table;
+			*length = data->chip_info->num_accel_scales;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+		return -EINVAL;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		*vals = &sca3300_lp_freq[2];
-		*length = 2;
+		*vals = (const int *)data->chip_info->freq_table;
+		*length = data->chip_info->num_freqs;
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	default:
@@ -424,11 +509,6 @@ static int sca3300_probe(struct spi_device *spi)
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

