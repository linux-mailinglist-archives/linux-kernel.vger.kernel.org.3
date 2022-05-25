Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB01533D59
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiEYNIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243831AbiEYNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:08:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2122.outbound.protection.outlook.com [40.107.22.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C9A0051;
        Wed, 25 May 2022 06:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBrpTXqB2gyCEtkXAVnTsbjt3fAWli89E66ehT2WW372B4xp5nrPV9OlU1xiTF+JFsMapP9RcELGufzkPKKuiHVZHnxtch1gfvjKHy7NF5WKN7bndAQw5Ljm05b/kSW1slyso/IrZjk/w9o+sCLsZJBZw5TIavuGaC4JGYuiLkOTBRqOdPhWWluOBychNDCCIVo8PPset13QfsQzlgzpQx6YMA2eUOJ3XZ6dh1neXdBZZylMo+ZyVoco6DldzqDskks/8q8+xbRiHpfJC+hz+0iXJsl2ZLL4xbUP5WdYyfoTJEiFQhoq1lwcAf5P8uyGWkfcT18vt6G/YS3L/9sU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPNV8OcUZQZwvA1Ho/8hfSfgM+Q1/QC75fmVd0hzYFc=;
 b=e1ogvbvpom5VaKa1nbQCJeGTUjDDgdyAdgG6rDoOI8D6B7UaKDIq3vS+lw2Rpt/ay7xKn6OjsvQOfHP8K+lPy9piJpk97y4iQGYN4grpXfkr49JttefwL9/IWQWnVt/QTonjOoWpOTd4KHjL6pKxC5VkgAyNYmjN8BVQDBHod6mvDyifA3islhxihTCupfrGN9XHdbOGpm/EOAIlw3diuCwXFO+BMeBw7w73ra6hNzCYqXVRl+1Dqgjtn2FokV21MMWRk8G8R/UVGs6eJ4HS0bZZEGYmelfgEPi142C4HxGzkYiDtUKa7N6/Is/JW60EYtQhvHXdF4BRfF3moGFSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPNV8OcUZQZwvA1Ho/8hfSfgM+Q1/QC75fmVd0hzYFc=;
 b=eK6NnZH5MSk+9By3F3f8Tym0Sk9pR106W+1Kq1g9GsLzsAxxaoN3JgHTCMTXoo1JWY4VWeVmKDi76IeZJwYc650vBg+s8LH9IOYGys44WUuXQ0hWrzmsF6xbtB6LgFAjFQjsNi9k5DaefIgjuw85uMI/+y3Pg9f86Fm7GwWIACA=
Received: from AS9PR07CA0016.eurprd07.prod.outlook.com (2603:10a6:20b:46c::27)
 by AM0PR06MB5252.eurprd06.prod.outlook.com (2603:10a6:208:fe::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 13:08:40 +0000
Received: from HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::6d) by AS9PR07CA0016.outlook.office365.com
 (2603:10a6:20b:46c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 13:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT051.mail.protection.outlook.com (10.152.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 13:08:40 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V4 2/6] iio: accel: bmi088: Make it possible to config scales
Date:   Wed, 25 May 2022 13:08:24 +0000
Message-Id: <20220525130828.2394919-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 13032b85-9a90-4b7b-c45d-08da3e4fb03d
X-MS-TrafficTypeDiagnostic: AM0PR06MB5252:EE_
X-Microsoft-Antispam-PRVS: <AM0PR06MB5252404B4072533485FC7F6ED7D69@AM0PR06MB5252.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9LYALvPs2UolsKFmOTAbu2pGl41qeb3+V4dTmA07BkHZr0lOWFQfnxXOqaEuqUijSLqfLjyBusOhLnTW4uNUigxHLtjYEMbDmXmDXBCd5AtQQPHJxxGAMczwHNv/x+EH9g86mdgxqCa10eXDLrDIljTTC2j0g6IfUfbqR99jITRVl/P6V8LkCbK0Mf7wJBCQydZ35v7AjAZw764+el+k7d+MBE6PlNlPgL4pgYbUTbajJK/JP2MEsL3TuC+1zgWbIJXhLhk61PbQZad4Vlw5x8yW/9hV45rONdVYW3HbM+jiMoFyUX3MidZgIB/PqE0+4K7+1CfdciUeKREypLH2OLK7B8iTMOksnb6o3/exEQnsl9OrsKiVsM9UUHBqqIrsGaNVDQrUme0lFWBJ6qfVDhwOfDlmSbSb58W710p+mVRSgJQf4iIBuAvBQ3j0pubOby5Leh7sNdwD1xfn+MArXVvzev5On+T5l4kvilVLH6NrCsbjFjHXQtmiqHBVe5I4VMaXo+xgnPKzZKf5iZrRAFGFKfYJFLmow01TNXdRmUdt5NnAFnNR+kg8pX3uDh1WJfrFYVqi+sms0wQTsuOadCDj8KhclO5nVVRWD+toX/WqVImvFuhcCvliy0wLtGkZGvXwj6RisQuJ2WH2P1PJoH6yEdqpexg4XnAyk0k5tVp3Udf7smoObTZN4HTib4j
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(956004)(36736006)(107886003)(6512007)(2616005)(356005)(2906002)(47076005)(36756003)(26005)(316002)(82310400005)(81166007)(6486002)(5660300002)(8936002)(4326008)(6506007)(83380400001)(118246002)(508600001)(36860700001)(40460700003)(86362001)(70586007)(6666004)(70206006)(1076003)(921005)(186003)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:08:40.1523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13032b85-9a90-4b7b-c45d-08da3e4fb03d
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB5252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sensor can set the scales by writing the range register 0x41,
The current driver has no interface to configure it.
The commit adds the interface for config the scales.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 3f38967c5a0a..16c95d90f829 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -239,6 +239,21 @@ static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
 				  BMI088_ACCEL_MODE_ODR_MASK, regval);
 }
 
+static int bmi088_accel_set_scale(struct bmi088_accel_data *data, int val, int val2)
+{
+	unsigned int i;
+
+	for (i = 0; i < 4; i++)
+		if (val  == data->chip_info->scale_table[i][0] &&
+		    val2 == data->chip_info->scale_table[i][1])
+			break;
+
+	if (i == 4)
+		return -EINVAL;
+
+	return regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE, i);
+}
+
 static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
 {
 	int ret;
@@ -372,7 +387,13 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
+	struct bmi088_accel_data *data = iio_priv(indio_dev);
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)data->chip_info->scale_table;
+		*length = 8;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		*vals = bmi088_sample_freqs;
@@ -392,6 +413,15 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			return ret;
+
+		ret = bmi088_accel_set_scale(data, val, val2);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = pm_runtime_resume_and_get(dev);
 		if (ret)
@@ -413,7 +443,8 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
 				BIT(IIO_CHAN_INFO_SAMP_FREQ), \
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+				BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = AXIS_##_axis, \
 }
 
-- 
2.25.1

