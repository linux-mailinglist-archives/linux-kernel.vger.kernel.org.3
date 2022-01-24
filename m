Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E20497C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiAXJjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:39:37 -0500
Received: from mail-eopbgr150120.outbound.protection.outlook.com ([40.107.15.120]:65034
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233950AbiAXJj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PENJdqg4xmXvSRhOhb9c+2igRHmk6xfY9g7pS3iBb2vm5b6y0S2cCYqIFNdQ/0NooY/inyUGTv2wzhFixmgmJJc0a/x9Nvuf6hy18Lao5sQ44PQTSkfc2cCLAhIUeG6/z5901GJg8Y4jvH8UfGwgPh+A0UioPAK8/9mcea3753cS4ayISO4vcyrWrMJv1r1ts0b5GujAfV45FI06ZB9ZlN8isGzl7hEIjQgaYS7Csa4Blp1Gk0iQqWx2bMN+RrLM8h17jHH3H/i6e71kROdZInZHvk+cisSA73vTzm/wMzdN+ciAUChgfRIhkIIo66egv1Ii0Pi6qunr9Dnz8k4l8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhqAFsN97U4dO5Zj0HEIC+w68gzr4kkdIikied9i2gs=;
 b=SdZ0had2NZkDNyp4mQCv6rtkTRYfs48y/bsHsrm7pEynUDoSSzGC+7+xeW5HDZHVbnbEkXrV0hbMAfmVrI1MND0b2nShTCZKCgFgqebapgGMMuxUTiajOqE1T/WhYAhjR7Vb6PleD9VVoOweZc95cjTicI8HhMiPOrCRXCgJ0ubOkJhGzM8eszwzEP7d1KU7xCZh1WYRLgXtSAV18xVclrZywRUGCfTjq1e1XhfOc/yH/6b1Zd55PbUEfcpAmscUOGcD2Y1okjBP6ak7lfqlr6Kx1KaxC+7y3iA/aaeBnBOFx6D7g7dRKDp1RUoeRVkdilGFNFingj4GSxsRO0PTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.8.40.112) smtp.rcpttodomain=leica-geosystems.com.cn
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=leica-geosystems.com.cn; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhqAFsN97U4dO5Zj0HEIC+w68gzr4kkdIikied9i2gs=;
 b=EfNFGXF7YRHgKE8nLMWKn1lPL/gbpQy6jGuPRWk7emd1d5DMAWFksqJAP2HcGpvn6UuMM078rkKMyP1OK2ccTQvVLr7BJiNDlB+0Jhb3AXbk9lXHekyAstcnaJGw7r/y+0QjwAU+fYSHz3NqDgHfowI3TC/jprTOGEgAv5n1G2Q=
Received: from AS9PR06CA0045.eurprd06.prod.outlook.com (2603:10a6:20b:463::30)
 by AM8PR06MB6849.eurprd06.prod.outlook.com (2603:10a6:20b:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 09:39:25 +0000
Received: from VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::7b) by AS9PR06CA0045.outlook.office365.com
 (2603:10a6:20b:463::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Mon, 24 Jan 2022 09:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 193.8.40.112)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine
 header.from=leica-geosystems.com.cn;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 leica-geosystems.com.cn discourages use of 193.8.40.112 as permitted sender)
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by
 VE1EUR02FT049.mail.protection.outlook.com (10.152.12.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:39:24 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     qing-wu.li@leica-geosystems.com.cn, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 4/6] iio: accel: sca3300: Add support for SCL3300
Date:   Mon, 24 Jan 2022 09:39:10 +0000
Message-Id: <20220124093912.2429190-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5e952ed1-37d5-4974-f888-08d9df1d686f
X-MS-TrafficTypeDiagnostic: AM8PR06MB6849:EE_
X-Microsoft-Antispam-PRVS: <AM8PR06MB6849ADC514A3B0641A675D45D75E9@AM8PR06MB6849.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOTTzAAUL4VktwwRbfMTITeVvGieefv+fY5Bajlf/Blbzxlqk8MHONqcmVRD0V9N+RP2dV3Cjpp1tilvjbTvWx3ui6w1Z6FfL5+Ffk45cvveH9jngM3QhjHxswnLQ6HB+BdNs/3Y3Rd+5+rMnJm7R/oJScmyOPzD2EWoan2J3wfIhpnVmOGeqvyDDYzWCnUDl8J6vQRvMHNyS53dV59pjGMAJvrGcCuOEMxAy54ipI9JyPR94Bbyan9Abm/NPuGEVlBU3Q5T+ssoKAvxnyJFp6d+zqpp918rSTa7p9+zxc75KTsHUi1TbAvHJ5lBwddGXw3HsZXUrriqPI82FSD7lYFZXzZV9B0kve+CU1tAD/n+nM9l2aycCnNzde7XdUlko9mao0pAqFomHlEEG9VD7wtOoh1hJ0KBRKdDe1PT4zVewu9WeMY/jwPPi6Zyf2DfpKGdG7RCjAfv1MZieAjujHaYCNIrMYrmtPc7GPQPlp82y8QDASpVQw1d2YHnK04U4NN8zjzxvruFUhZpuUIKM9qZgdh3gK5C/4EJs2UeDRGqE5BMCZha/CbBSBinwDz22wphSQe7xl+gQ3FnARTqBW1AdrWvK3WoteaOn/yauaaZt468/o7PHNTGXez/4swv6WuYWYJNPRV0AsYlw+Mz2tosQZr8JKlx40OrBJY51Ag6glpWi+h7UxIx4n058RAjXoYEz5WFE9jOR913cHWlf5NiLeJAsphY0FbouzkiHLwpnOXIKX9m2iM8BEYdNyOQg5sfNcIw82jadPGX7dO0twRB1LXhATjpOCNrR0NNrJwF/azGw8+dSw9ljcGj6BPNwNSYGUVW03lzER8sslkDWlfXnC3D7EDzSEXOAmMJmWo=
X-Forefront-Antispam-Report: CIP:193.8.40.112;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:mailhost.polymeca.com;CAT:NONE;SFS:(4636009)(40470700004)(36840700001)(46966006)(2906002)(70206006)(2616005)(36756003)(356005)(5660300002)(36860700001)(81166007)(4326008)(107886003)(8936002)(336012)(83380400001)(118246002)(6666004)(8676002)(70586007)(6506007)(508600001)(47076005)(82310400004)(6486002)(26005)(316002)(15974865002)(86362001)(36736006)(186003)(1076003)(956004)(40460700003)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:39:24.6662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e952ed1-37d5-4974-f888-08d9df1d686f
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.112];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Murata SCL3300, a 3-axis MEMS inclination.
same as SCA3300, it has accel and temperature output.

Datasheet link:
www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 26e6fab88a8f..7ea3e202d474 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -68,7 +68,6 @@ static const struct iio_enum sca3300_op_mode_enum = {
 	.get = sca3300_get_op_mode,
 	.set = sca3300_set_op_mode,
 };
-
 static const struct iio_chan_spec_ext_info sca3300_ext_info[] = {
 	IIO_ENUM("op_mode", IIO_SHARED_BY_DIR, &sca3300_op_mode_enum),
 	IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
@@ -77,6 +76,7 @@ static const struct iio_chan_spec_ext_info sca3300_ext_info[] = {
 
 enum sca3300_chip_type {
 	CHIP_SCA3300 = 0,
+	CHIP_SCL3300,
 	CHIP_CNT
 };
 
@@ -131,12 +131,23 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4)
 };
 
+static const struct iio_chan_spec scl3300_channels[] = {
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+
 static const int sca3300_lp_freq[CHIP_CNT][OP_MOD_CNT] = {
 	[CHIP_SCA3300] = {70, 70, 70, 10},
+	[CHIP_SCL3300] = {40, 70, 10, 10},
 };
 
 static const int sca3300_accel_scale[CHIP_CNT][OP_MOD_CNT][2] = {
 	[CHIP_SCA3300] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}},
+	[CHIP_SCL3300] = {{0, 167}, {0, 333}, {0, 83}, {0, 83}}
 };
 
 static const unsigned long sca3300_scan_masks[] = {
@@ -184,6 +195,14 @@ static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(sca3300_channels),
 		.scan_masks = sca3300_scan_masks,
 	},
+	[CHIP_SCL3300] = {
+		.chip_type = CHIP_SCL3300,
+		.name = "scl3300",
+		.chip_id = 0xC1,
+		.channels = scl3300_channels,
+		.num_channels = ARRAY_SIZE(scl3300_channels),
+		.scan_masks = sca3300_scan_masks,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -310,10 +329,14 @@ static int sca3300_write_raw(struct iio_dev *indio_dev,
 		}
 		return -EINVAL;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (data->chip_info->chip_type == CHIP_SCL3300) {
+			/*SCL3300 freq.tied to accel scale, not allowed to set separately.*/
+			return -EINVAL;
+		}
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
 			return ret;
-		/* freq. change is possible only for mode 3 and 4 */
+		/* SCA330 freq. change is possible only for mode 3 and 4 */
 		if (reg_val == 2 && val == sca3300_lp_freq[data->chip_info->chip_type][3])
 			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
 		if (reg_val == 3 && val == sca3300_lp_freq[data->chip_info->chip_type][2])
@@ -459,7 +482,6 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct sca3300_data *data = iio_priv(indio_dev);
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_ACCEL) {
@@ -553,6 +575,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

