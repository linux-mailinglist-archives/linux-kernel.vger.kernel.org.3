Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B75E4B9944
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiBQG1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:27:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiBQG1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:32 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30127.outbound.protection.outlook.com [40.107.3.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7132A22BC;
        Wed, 16 Feb 2022 22:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aav9X8ydRkUtXUGQ5o5V//SdGXEOQsOtJL7rnpPMOKUhNNpIPCU7C1enFSb6UdkDAvQECsVlNBhoQ2vo6itr0eIFgl04XwZBiOsSX/+zKjFUBZ+FdIMzRG9T2AB18tzJms+6WFcugFHYOImBHXOatYVcUg4eanIWqnUT6gB2FjN4PCKbl7iWIPQy5KVVEePLolXzVFfLzVuAu532ljd/agW6Da1KQMmMH0BdLORrmD3pevhuZn/5CdlkVyxPpModLvZ5mv3KI5gueqTDVrfFcAxuNO8vs7nQ2L+rMGqvUKYRynNJKnvfr6LuR7Msd6eJCgff/wXIhXRdJAY2xBr3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weo//E55ssFdOI1hxfBcmxIjPtQPGzmp2vMRR46A0WI=;
 b=Ru5DjtgdZIwK2zvftvB23vChQzUxWA62303lcpTh/yKkd2TT3Of6jcwKwk4khAeC7k2kybica7WSVaZZOpRhEG/hNx4zmpPD469gLpk/VKGps8CpTr3flI+lnvaC3WWcBAHpIcd1sc5QmgXi3ZL8v4y8SLd8bKmeIhJli59RdqwOTOzGkh1/OCBt+hcBMw8K0BfJvc6u1sHuqbRrdZWSbZDIEjhmZq6ldqQhP8rUQk+UrTRaeTUusJjgcGqFuRZlhw83vuWe1QRaDY9pTfndXRlWk4ualH5SEk9XoNOpa09iG6ij3Fga2nJ57cFUZQeOYAF+W6Ep+GCcQaLlzKlXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weo//E55ssFdOI1hxfBcmxIjPtQPGzmp2vMRR46A0WI=;
 b=NdyXlD7KclwjDnh7BRnRhNWvrtPBJu9qLtcmFgBM1ABIlLa2RHp6gmiLlYgriGpDvTZ22IYoSuNd4SLfG2g3IelqMkkOB8jX0E8qrFJ4hccu+B6XFuSXmaMJp7DhPalDZVqma88qjImFNIBYKfkXU1hJnsA8LZDo4ItRq0VjtfY=
Received: from AM6P192CA0083.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::24)
 by DB6PR0601MB2213.eurprd06.prod.outlook.com (2603:10a6:4:4f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 06:27:11 +0000
Received: from AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::1a) by AM6P192CA0083.outlook.office365.com
 (2603:10a6:209:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 06:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT043.mail.protection.outlook.com (10.152.9.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 06:27:11 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: [PATCH V2 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Thu, 17 Feb 2022 06:27:04 +0000
Message-Id: <20220217062705.2867149-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46d58a8c-63f7-4857-d982-08d9f1de87d2
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2213:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0601MB22133EA2320ED8F57BA0EA90D7369@DB6PR0601MB2213.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0mkJJKDbp1O2GGoD296eGpr9gyMM9Qsb3reUaQBgk+4gqAwG0hbsF+as/rdbF/3TmV3cwugMLZm1wjspgItpRb2MaL7CIPGaD+HgscG9452XoeHp0tiWts2+1gQyUmGuqpCjrnTSIHQSgkY4sg1uLys5JiC1Dsp9sdrDJsH6SeO6auPQlQ0iW0y3nn5M2C04bcbCdmqVh+k6IT9uI+P4QTwVgtn8Ep+ULGC/FuN1KzNWZJR9g4qCsZfOm+3ydrrEy9tDaR/Di9+ukOf9Vt71OBdCL9q0NrUx7mUL10JAd7Ie1EibjXDUPTcRpIyEbNEX/6Lz6pYpgZ5uWl19SOkEPMaJQ3gCIZuSoFOiGBrtF+1brCtt/Cf4eWoX2NDFKLx+NGbPuZTrdb1wwZ5R9epkEjJBhN5NzZvGkgDHCsD51zORzrsG/PAnYrLdqDX0oJQUGQ8d/BOJ8/nzs15MXpIKAhG873Mu2KvLp42HMEzhnXaq3Cw3VIZv8KtN9gQ7Z+vnQBLK+QqBHXgE48/MZrRxT60XdYuu9zUmITVZ5fpldxWPp73qadtOApilTepP0JvY08UaltCgDznkAsRrHXD4vo95BFTGvTFX9ibuEw6wOpH3Nyf0opjhm1aad7l8Xz7m6EEkWFZj4ui+jieQ6hMFQdjLrHIrsNUqaHfYWjC7YKSStCMMDZAQt5s37ImOczG1SEAu/xFbJIal+c+oIAbOQos1hzlDXbt0UtJHjp0DpOXxxyUKFkEERcefWMThdTQrHXtEOg6J5Om4AXUleUu0A==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6506007)(8936002)(86362001)(118246002)(82310400004)(83380400001)(36860700001)(336012)(2616005)(1076003)(956004)(107886003)(6666004)(26005)(186003)(47076005)(2906002)(6512007)(5660300002)(4326008)(508600001)(36736006)(70586007)(316002)(81166007)(356005)(36756003)(70206006)(15974865002)(6486002)(40460700003)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 06:27:11.0871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d58a8c-63f7-4857-d982-08d9f1de87d2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
Same as SCA3300, it has accelerometer and temperature output.
Datasheet:
www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 45 +++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index b1748874c02d..123ab9a784d2 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -42,6 +42,9 @@
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
 
+#define SCA3300_REG_ANG_CTRL 0x0C
+#define SCA3300_ANG_ENABLE   0x1F
+
 enum sca3300_op_mode_indexes {
 	OP_MOD_1 = 0,
 	OP_MOD_2,
@@ -52,6 +55,7 @@ enum sca3300_op_mode_indexes {
 
 enum sca3300_chip_type {
 	CHIP_SCA3300 = 0,
+	CHIP_SCL3300,
 	CHIP_CNT
 };
 
@@ -106,8 +110,19 @@ static const struct iio_chan_spec sca3300_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
 };
 
+static const struct iio_chan_spec scl3300_channels[] = {
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
+	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
+};
+
 static const int sca3300_lp_freq_table[] = {70, 70, 70, 10};
+static const int scl3300_lp_freq_table[] = {40, 70, 10, 10};
+
 static const int sca3300_accel_scale_table[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
+static const int scl3300_accel_scale_table[][2] = {{0, 167}, {0, 333}, {0, 83}, {0, 83}};
 
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
@@ -161,6 +176,18 @@ static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
 		.chip_id = 0x51,
 		.num_freqs = 2,
 	},
+	[CHIP_SCL3300] = {
+		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale_table)*2-1,
+		.num_channels = ARRAY_SIZE(scl3300_channels),
+		.accel_scale_table = scl3300_accel_scale_table,
+		.freq_table = scl3300_lp_freq_table,
+		.scan_masks = sca3300_scan_masks,
+		.channels = scl3300_channels,
+		.chip_type = CHIP_SCL3300,
+		.name = "scl3300",
+		.chip_id = 0xC1,
+		.num_freqs = 3,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -274,6 +301,11 @@ static int sca3300_set_op_mode(struct sca3300_data *sca_data, unsigned int mode)
 	if ((mode < OP_MOD_1) || (mode >= OP_MOD_CNT))
 		return -EINVAL;
 
+	/* SCL3300, mode 3 and 4 are same, use mode 4 only*/
+	if (sca_data->chip_info->chip_type == CHIP_SCL3300) {
+		if (mode == OP_MOD_3)
+			mode = OP_MOD_4;
+	}
 	return sca3300_write_reg(sca_data, SCA3300_REG_MODE, mode);
 }
 
@@ -317,6 +349,8 @@ static int sca3300_write_raw(struct iio_dev *indio_dev,
 			if (reg_val == OP_MOD_4 && mode == OP_MOD_3)
 				return sca3300_set_op_mode(data, mode);
 			return -EINVAL;
+		case CHIP_SCL3300:
+			return sca3300_set_op_mode(data, mode);
 		default:
 			return -EINVAL;
 		}
@@ -348,8 +382,9 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 			*val =  data->chip_info->accel_scale_table[reg_val][0];
 			*val2 = data->chip_info->accel_scale_table[reg_val][1];
 			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
 		}
-		return -EINVAL;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
 		if (ret)
@@ -431,6 +466,12 @@ static int sca3300_init(struct sca3300_data *sca_data,
 	indio_dev->name = sca3300_chip_info_tbl[i].name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (sca_data->chip_info->chip_type == CHIP_SCL3300) {
+		ret = sca3300_write_reg(sca_data, SCA3300_REG_ANG_CTRL, SCA3300_ANG_ENABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -474,7 +515,6 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		return -EINVAL;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*vals = (const int *)data->chip_info->freq_table;
 		*length = data->chip_info->num_freqs;
@@ -536,6 +576,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

