Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3951FEB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiEINuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiEINuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:50:32 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140138.outbound.protection.outlook.com [40.107.14.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7073E164CB4;
        Mon,  9 May 2022 06:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXQEHR1m/kkmW0qrIkGOMnyoY7+bDc9ojkdxlvsjC5NUh7Ja41gOcmumSbWCdqjjC8lQW5hO1DVjN1zsncZjOh5ZtD2+tQwBW4CL3pI4XKDWDnS1NARbfPZLpZHMQP3ftxJ23TzdhcavEuCNgEKKEYVJfHHjA4/cy/S2gTUAtlVlBXPy+797ofY7U75lky/yC6/9mCUV3fxIfpZsz7j5H5JM0iVWDANSLkZHaSK40gGrf/cUpBxhfUQONyLEIthIafFdxXQ4BTPUIWn+G5BHc3wOeOHsT7mIHWHDHvwPdLeiMkfL7GwhJlUmCypoxY4+k7oHTj1UYt3LUDr4ymDi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLJg/fGggZqqZKRQIsgHFd7ZgVxK8VPebIBuSxIlG1c=;
 b=YOJXyeoCpbf5P6DQu5pEk35SInqqdDJERyv0lIFDvNYm6SkHXYPD4v2lMR2DQ4AsUiDupDthl8wBMGoitYiGh3h/dE/DFIsyB7JIyUSJz8DVwuUPAT1trGv7aexPKDE+d18txkwb/911GujIHoKnmhvqyOtaxcCPulJhtUgHyqJx2kPzRQ5MXlfrGscRAU150/7Aexy2qxGQ+SP6rbnSsRJiO6Kmc1cVg+uNrLQbbwPeTvw99rFNJaKNvHqBn75i3MnbgsPWISyKwk96jugTrDIm4BhztbhlqTB85siz3oWyzHIdwiUHz+JL4KPj+Zaqa9dhF+kFuxeCScoh4NJpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLJg/fGggZqqZKRQIsgHFd7ZgVxK8VPebIBuSxIlG1c=;
 b=aCOiuMMmh7F9uToGbrnO9I1fw0eZWloNoqHBuZgvRmdUxdCVDUSx/V64uGyxjN8GAXHkxz9eBQpTDHbA/8qCc1hX3WEe3JrOlTjHHRboKHoUmcX25v0G0mYFHJP2reLXUldwsaxrxuPubu6nwTRvd0RjkrSrTAYXt9CtWH+VZAw=
Received: from AS9PR04CA0083.eurprd04.prod.outlook.com (2603:10a6:20b:48b::29)
 by PAXPR06MB7552.eurprd06.prod.outlook.com (2603:10a6:102:157::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 13:46:34 +0000
Received: from VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::cd) by AS9PR04CA0083.outlook.office365.com
 (2603:10a6:20b:48b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 13:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT056.mail.protection.outlook.com (10.152.13.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 13:46:33 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Subject: [PATCH V1 1/5] iio: accel: bmi088: Modified the scale calculate
Date:   Mon,  9 May 2022 13:46:25 +0000
Message-Id: <20220509134629.440965-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8647cb0f-6a4d-48c5-0fb0-08da31c254a4
X-MS-TrafficTypeDiagnostic: PAXPR06MB7552:EE_
X-Microsoft-Antispam-PRVS: <PAXPR06MB75529952D6C1A16A1D769BA1D7C69@PAXPR06MB7552.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEgUwS3ftV90oC4JY1xv06ts/ckFd4Qx7ZVOpT8sTdbQjh0DOlEyGOzMKbDFlH/8yZ9bI2PnDUIPIeuoKavUfIjFXWrUdV+V+xMYEhEULxoLovzJsYxKVXahoowfusyUN0AC2Matq+ld5tZEaJX7kJn/3PLoyvGPZknxI36u0kYO/RSh/j07T6D35xNAbHq6JVpam7kh5MxZmKx+Zrf2pF3A5T3g/x9fy1HwGLHjUcbaoJVMdEysFA8GWuwmJ/UJ7giw7cODR1avT0iTld+zZKqle2q/1Dyr0i+CnUyEfKkMcrdNVjqeG0zLTwB2a00CqUoz/DpDc2VfYX9ZzEAPu/GWmJ9N78cPnww+hgce/o5asZAxj13uat6q16iCsA8qqPyanM86Xta3p45p+XdyMAXrWL+iijbbfr74XguSb6B9jXbf5R5rqPBmrqODJ9QAXnS1XevCtlpcq1dl4VPCEe2VKMs/iFVk9RmIPVg2y+mqXTCZZcXUf2YCeFI4GQOmaVo4JJgoYa4uUOsIFbyAVRISClA4zRNxXY/o2hciA0o1kvCh5JP/O99Uhdk7PIG40DJ7F6orFBtmIQsBMPA74AKDRQqeH/9xeu7c8inQc4ByAkpQGHcy0vbAEMGSQ8cSoXMzBJFKqqUwDCFKJXye6nA/asIflExYKi8Km64IxYWMExB5A0klohXU1FbmAIIm
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(6512007)(2616005)(956004)(118246002)(40460700003)(26005)(8676002)(82310400005)(36756003)(47076005)(186003)(316002)(336012)(1076003)(70586007)(70206006)(36736006)(2906002)(6666004)(5660300002)(6506007)(86362001)(6486002)(8936002)(508600001)(81166007)(83380400001)(356005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:46:33.8082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8647cb0f-6a4d-48c5-0fb0-08da31c254a4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7552
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

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index a06dae5c971d..0c58ffdd00e3 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -119,6 +119,7 @@ struct bmi088_accel_chip_info {
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	const int scale_table[4][2];
 };
 
 struct bmi088_accel_data {
@@ -280,6 +281,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 	struct bmi088_accel_data *data = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
+	int reg;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -330,13 +332,12 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 				return ret;
 
 			ret = regmap_read(data->regmap,
-					  BMI088_ACCEL_REG_ACC_RANGE, val);
+					  BMI088_ACCEL_REG_ACC_RANGE, &reg);
 			if (ret)
 				goto out_read_raw_pm_put;
-
-			*val2 = 15 - (*val & 0x3);
-			*val = 3 * 980;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
+			*val = data->chip_info->scale_table[reg][0];
+			*val2 = data->chip_info->scale_table[reg][1];
+			ret = IIO_VAL_INT_PLUS_MICRO;
 
 			goto out_read_raw_pm_put;
 		default:
@@ -432,6 +433,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
 	},
 };
 
-- 
2.25.1

