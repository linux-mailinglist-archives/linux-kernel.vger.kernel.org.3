Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D1352BE52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiERPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbiERPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:05:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60124.outbound.protection.outlook.com [40.107.6.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407A1DF659;
        Wed, 18 May 2022 08:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1eUJozGcFzeVi9XV+cJgYqSbrLF2Q6uB7W4QBorhaE1tP1L4tjFVtwiEpnjRaf+eUfz3CKO1dW8Aqf66xs7jAkwZZMbmcjXYl8N3I5dMvLC2m2vH62ORDi0bb/6E7KKRdaL3qsbtjyCVfX5frpaN03PCvtEdUQM8wjMM8yAIKZl8X325gPy9XX41ljNxMlrdrVorjQ2bhhcytBig/SafaHJ38MlJOFiaALYNRoIdqZDxr7Qw1B6GfAjMA6iEcOWmXVSwko7asuDUz6VswjyaTHtM7kk3GMs+p3sFXeUViDemiWibG3g7W35t+eOcb6Uc1hHa6Bre8wZKoeoBpg7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pge+B86GgAWoO5oMnHYETK/lg/AE/VuzUzmyMbW4Pdo=;
 b=OiuW2qbdKmu9OmevGnmwoakZjVpPSVEwsPhv1c9c+cc49xOgOVA3oUSRUt/ueheC2k1o+yLN+ijS0YTwTAjK2QD4sHK8m45y6Gh4QJLXMscC3LU1x1gBgJHk6oo9vBUkwx6+4hoE1VCUIsGxkIHj8d2w0593lmhyQgTfiqLP9sdImzIFpokCbNtn8Or7tTpNf+/tl7RAKTPvjlgeeKyaNjFqoh5A1GDVRVN6M8URs2l7FViF2Urn7vxOP5JEZpC90oH0wCtQzwKfP6mVw5p/ZexTsamSQdQUIqK1XprZah1uxHt8GM3n8fRgWkwC0SPCTiD09EQuCyuaQ4jbTSfChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pge+B86GgAWoO5oMnHYETK/lg/AE/VuzUzmyMbW4Pdo=;
 b=f673qDPE9sRZfRBsjWqeOuC0y46pqEBUC9O9+daKeh/5RiCY1mc9jMs6YSiaBQtOwTy3j/cGqMN2vUs6kwbNuobJEd3LWhxwkCF84pLRWfALRlz/WjI1YY3WJAyVzO5Cr5MC67lbXW0o2fjm2d7YYPqI8ISO9ZfMHEFaRav8Sm4=
Received: from AS8PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:20b:311::8)
 by HE1PR06MB3996.eurprd06.prod.outlook.com (2603:10a6:7:a3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 18 May
 2022 15:04:29 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::39) by AS8PR05CA0003.outlook.office365.com
 (2603:10a6:20b:311::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Wed, 18 May 2022 15:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 18 May 2022 15:04:29 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V3 1/6] iio: accel: bmi088: Modified the scale calculate
Date:   Wed, 18 May 2022 15:04:20 +0000
Message-Id: <20220518150425.927988-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a359563-cfff-4f38-647f-08da38dfb515
X-MS-TrafficTypeDiagnostic: HE1PR06MB3996:EE_
X-Microsoft-Antispam-PRVS: <HE1PR06MB399611DFE6F2044BEA432AE9D7D19@HE1PR06MB3996.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxIODZHPXRlQOCkg4Pw3fVW2XW+WiGjS51uLa0y9B9w+Fggk8EHyYmtoIKwhhMKHa/3N7hc7AoWdzuv0mipBZN1MxQfpnHG+6jWqTin2/ovPN3sEfDh9jZAbN1Ak91TLa4nc+prs7kVbdLthVoKcVSbl1AJCjC0H9Dk6q7m/zzy8xDXJeKH69LUZzuLgdXxOyBGTCE43DINn1IjV+zXwmX88bSv3IOhnrxnEX7tGXs6ge3CyyccERMAMKsW7s6XEk57PxAP9RG3jgtpqQo5FVfchrRSe4seatl7s0SBLtzjLCElkNs1lrCov3mt5NBy8hJQ/qs7XjKM3ouiULo33EeLb4+lFjZdziXDvecGEIuZ226N2vtb7GBptFp/oGX0s/lO2fwc6/Fn/t5KU3nGP2I7mRI2tvkO5FzRd5eY9UMdEjpshySf8z7OlKTy1UBZNq8DVTFFsAZfrLQu7OIjy64joW0RQR0GRzuek0EGt0W4oHqbm1VeSC7en0WYyntqCjqDsVVpOd+UikOPlEOsV+6ArlJnxx1hG7L1hlNoTbPDHNIODi5Oxn711IrzHJno37T/+P4ChATRGN1BEd2AYMOxEJjV8VdLVi0snwHcVPLHfwbMXFrvM6VSGbc8O03t8Z22ptr8L92wni5I5Y4wU4KRjAM1H1vYb6ymZgx7svfuTvdlqSlSk0rYgNc42FzT/GnuQ5WSWLBvT+RovnptofA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(26005)(921005)(508600001)(1076003)(6512007)(2906002)(2616005)(956004)(186003)(36736006)(316002)(47076005)(86362001)(5660300002)(336012)(40460700003)(83380400001)(81166007)(82310400005)(6506007)(70586007)(70206006)(36756003)(8676002)(36860700001)(6486002)(118246002)(6666004)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:04:29.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a359563-cfff-4f38-647f-08da38dfb515
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The units after application of scale are 100*m/s^2,
The scale calculation is only for the device
with the range of 3, 6, 12, and 24g,
but some other chips have a range of 2, 4, 6, and 8g.

Modified the formula to a scale list.
The scales in the list are calculated by 1/sensitivity*9.8.
The new units after the application of scale are m/s^2.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index a06dae5c971d..21bddee869af 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -73,6 +73,8 @@
 #define BMI088_ACCEL_FIFO_MODE_FIFO			0x40
 #define BMI088_ACCEL_FIFO_MODE_STREAM			0x80
 
+#define BMIO088_ACCEL_ACC_RANGE_MSK			GENMASK(1, 0)
+
 enum bmi088_accel_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -119,6 +121,7 @@ struct bmi088_accel_chip_info {
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	const int scale_table[4][2];
 };
 
 struct bmi088_accel_data {
@@ -280,6 +283,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
+	int reg;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -330,13 +334,14 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 				return ret;
 
 			ret = regmap_read(data->regmap,
-					  BMI088_ACCEL_REG_ACC_RANGE, val);
+					  BMI088_ACCEL_REG_ACC_RANGE, &reg);
 			if (ret)
 				goto out_read_raw_pm_put;
 
-			*val2 = 15 - (*val & 0x3);
-			*val = 3 * 980;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
+			reg = FIELD_GET(BMIO088_ACCEL_ACC_RANGE_MSK, reg);
+			*val  = data->chip_info->scale_table[reg][0];
+			*val2 = data->chip_info->scale_table[reg][1];
+			ret = IIO_VAL_INT_PLUS_MICRO;
 
 			goto out_read_raw_pm_put;
 		default:
@@ -432,6 +437,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
 	},
 };
 
-- 
2.25.1

