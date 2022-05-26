Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C184053500A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347570AbiEZNeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiEZNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:09 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140130.outbound.protection.outlook.com [40.107.14.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A5D80AC;
        Thu, 26 May 2022 06:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f63YuR6KlvUssD2en1JlJ3mGJnGtIFyl1+dPSEqUsUc5O4BSv1v+t9rP1FD4Q3UxK/+KWieeKdwq7BbyEqYIOwv2RtwHxLAu0qMT9xdV4WlINjS8xs5HcDeH0GB6u/s+mesn8yhqiny5aIxKuxeuxOPSAfgD0QIZ2cexaTZo51BzVUBtFlL/7Rsd8OCW/p6IyLFrZwWndSj/W8y5SBTNYa8UlJ5+bJmv8BcSgOZs99kuem5+YMqMVw5lq3WCpStyIWV81/cdVxhDMdpl0rJR8hJ+aKIpqcrD75t6QMusJV8RbTGa2c9SiADxHbuDb1fa91ImIGHjqBngSIlEKx9ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Y26y7ZUZ+0wCnfwjyWGfVU1MS3F8zg9V2N6ayDMPk=;
 b=bhhOKOG7nPjG63CDDxey4Z4tOJnC0zr0e5f+GoY1UdsU773TKTJNTTYjVUfMa/swHHFt4m2a6yn7WxhKk7S0ISj+AyEZDQg/Uh5wUfdbfAxKxU9WNqXLAOF54i4aoyW0qkZbbyNd1WVhpAekTF8KGMeJly/YqvVXKyXpu6WOUGnipyWfTHTBO+NlvR8IpCJFU6PR6PkAm0mm9yP2RebFfOQFg55vnE+L3/0Sk84KFdyd+JfD8ZyBgehF2zebF/OtcDevbd/Na/e9vIG4ODLUNF+SRvBai3kZKzauoGOzIMQQvtjQQmANsraEfW53vIK8XPxqnYmWvX3KDeHD9IQWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Y26y7ZUZ+0wCnfwjyWGfVU1MS3F8zg9V2N6ayDMPk=;
 b=lC1GYdnCPqxafhh3QK6C4OGOzMpKQR0Bbca7tUgvgaFqlcS5j1sEDyyQSg0zZGQccEnKSXfNPBqLD8M8wTHQV1FMtk9BfyylQ4A2ixa2w0rXEnsTbzSMkDEikm74gpQ+16YCbKYUqasTQrJgJew5o7qtZG9MjUQHBRwv1wiyit4=
Received: from AS9PR06CA0007.eurprd06.prod.outlook.com (2603:10a6:20b:462::19)
 by AM5PR06MB2994.eurprd06.prod.outlook.com (2603:10a6:206:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 13:34:04 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::5f) by AS9PR06CA0007.outlook.office365.com
 (2603:10a6:20b:462::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 26 May 2022 13:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 13:34:03 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V5 1/6] iio: accel: bmi088: Modified the scale calculate
Date:   Thu, 26 May 2022 13:33:54 +0000
Message-Id: <20220526133359.2261928-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d1528c77-7724-40df-9b2d-08da3f1c6671
X-MS-TrafficTypeDiagnostic: AM5PR06MB2994:EE_
X-Microsoft-Antispam-PRVS: <AM5PR06MB2994E70D018DC85AC4860E8ED7D99@AM5PR06MB2994.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uf82L/0/+m6HgHHpnr9+PQOQF78SUFyoIwiBwasuSdoOchBDCPznKdUOZQIG8OdllQoja6013WpeMyd3ttrGmvr8oxk+Xny2dnjddkCs++Dt67aBOv0RepPUHsgVIlNbumxkglHrKqG/VpnCdEwqzqADOouuOgVBnybuCJTAAZtCcxkKoKabysvmtMUXFZMlmc9LzFedItNKktOH8Ie3K2qXA9oEI/FoX5zRLsGs4Co9Y1Y93fYjPUjUykRi/U4MiWLR3iX+GtQqhpfea39zy1SCxmEUUpzYTqcsw99g45ppOnAaYEfA6oZZm94vpOL0qBbGyAL6LEhosrCA9H7I4Q/g6XfSRELJg+IlLRvPYjfBQKjxoHBAYRHa58tf0K8gjhNl6/jRtoUL4YLh46yamohIkDyHPNtgoxQBfQyvNhBLI+IcwMlCpC3wv4w14n+7tTbmZICTvtqN+GZNcqQV1lD9znh111x1jCeGDmk1sHeWGCdG7zW78HYZ+kiOMbrPuUP5RJhVQh5nmjhs1ASJtA4i6CUJF8uT7xuvffZjVy0RWUJyWey0lTBL8XHYnAQP1aGNGO0V8lhOJBqyfA+yb1/9eWpEgBoCqzlvFsOzNia2ExNaLVu+FmAEHAuTSHOXYCka2wk7uY5UdWpNSwMsTj2lSQOFm93kItDJ9e48aR4yOcVkgfBcAHUhBDzItjjnEtlE7YLewfH7jcnfKNeJfA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36736006)(186003)(956004)(1076003)(2616005)(316002)(8676002)(336012)(118246002)(86362001)(4326008)(6506007)(6512007)(6666004)(36756003)(107886003)(26005)(83380400001)(70206006)(70586007)(47076005)(81166007)(36860700001)(8936002)(2906002)(82310400005)(921005)(356005)(5660300002)(6486002)(508600001)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:34:03.4202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1528c77-7724-40df-9b2d-08da3f1c6671
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR06MB2994
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

Modified the scales from formula to a list, the scales in the list are
calculated as 9.8/32768*pow(2,reg41+1)*1.5, refer to datasheet 5.3.4.
The new units after the application of scale are m/s^2.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index d74465214feb..fd812802b71d 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2018-2021, Topic Embedded Products
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -73,6 +74,8 @@
 #define BMI088_ACCEL_FIFO_MODE_FIFO			0x40
 #define BMI088_ACCEL_FIFO_MODE_STREAM			0x80
 
+#define BMIO088_ACCEL_ACC_RANGE_MSK			GENMASK(1, 0)
+
 enum bmi088_accel_axis {
 	AXIS_X,
 	AXIS_Y,
@@ -119,6 +122,7 @@ struct bmi088_accel_chip_info {
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	const int scale_table[4][2];
 };
 
 struct bmi088_accel_data {
@@ -280,6 +284,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
+	int reg;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -330,13 +335,14 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
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
@@ -432,6 +438,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1794}, {0, 3589}, {0, 7178}},
 	},
 };
 
-- 
2.25.1

