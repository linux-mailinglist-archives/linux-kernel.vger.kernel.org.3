Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D973B534FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbiEZNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiEZNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70097.outbound.protection.outlook.com [40.107.7.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE793D80B5;
        Thu, 26 May 2022 06:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSIpk2PyX8RPXmMRl0P3p/iCeqeDmE7TG5Euckc/t9xCmXHJNWXyyplfweEhADD4UyWvS8AbrNb+hbIMEz3oIk+XOJcOgWcqlcD7EoHWjOtJdZyqEkY3iHeNI1Gi/gk0Zcp/TfYrFfCXjDU39K+ggViqzygGO4CswjH3zxVJf6LpXDqRnZ24F8aYilC/4TFHAdTQHKUOwVCuK2N4otQYGDBln80moLH+Yk9KRPXSFxYP45daRcgQmrrlvsk/FUa+rryoS0b5jBwU1u5dZXxvadgsU/Io5tFnbEtitGKF375sPhCacUrm33Tdg8TlJa1+jOuA3kLWmObqxwRkiS0mzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j0k4hXL2RmH1aeoxuba3AmDLc28SHD03SYQXpnIzg4=;
 b=hmlyHGd3xL1rYsUUGQqiltxkx/feBzgSNUowWvxhkr2tbDtbbqq/PmWzpBDHhekNmWQSXz/pA4S06pBPMk7IRvfKdQEpoaeeBZNlXYRzHTCsXJj51MKlk1LcM0jSfhf+AoNjyS4YHH52Dzpq3QAjjNCtUP92bFe5B6or1FvE6vVfb0gTljiNev34i0XQ7z+GCgRqkC8brjBenXAftQIZ3MkUQCfAhLno9HLlVDsssXwBoyShsmozaYAVctNfmSRqm1MDYSARQix7dzpnPBLFgEVnXYDDGrYSkBm9VJXdBFWWWQz/FolEB36vNztEzJk1pvg/0kfpAQ9+gc3Fg0LKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j0k4hXL2RmH1aeoxuba3AmDLc28SHD03SYQXpnIzg4=;
 b=ZwPV73VxKYFti8/6CyrthPXhOXLXaII6s279omcYYQ4CGXb1pixf64KWSzSO2hPYoEjGQ+pWDGTeQbgklJPVsJjjkn7fnTuAtpptuoyFtJ5HciRhnb2HGe8EVUPJFiHaSG8XMQ5gpvu7JVC9UU8Wx4/FAZbBadBrUuoxhtgC5U8=
Received: from AS9PR06CA0006.eurprd06.prod.outlook.com (2603:10a6:20b:462::25)
 by AM8PR06MB7156.eurprd06.prod.outlook.com (2603:10a6:20b:1d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 13:34:04 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::e8) by AS9PR06CA0006.outlook.office365.com
 (2603:10a6:20b:462::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 13:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 13:34:04 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V5 2/6] iio: accel: bmi088: Make it possible to config scales
Date:   Thu, 26 May 2022 13:33:55 +0000
Message-Id: <20220526133359.2261928-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef797fc2-70eb-42ff-a78a-08da3f1c6700
X-MS-TrafficTypeDiagnostic: AM8PR06MB7156:EE_
X-Microsoft-Antispam-PRVS: <AM8PR06MB715649B3D3ACDE452237CBBDD7D99@AM8PR06MB7156.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXD38aBr97Uji3+GXKfirOy/Fb4AFUXtcq57UAhMsqPM7iKXaEtFCTIwgRJ6IKe8kKgu2ZBm34VL4m4kSzCiuyVMuUXT/DUm/vFVT1W9FMG71WXT7gqN8aF9bnRJPRIXEsCSXmYAL9VMxb2+ofDtUPTeOjrD3GkxSLNd8nvVrrkEFcdqqhL6xwv5IB5kDhzDZJlO0ocBC7TdRNtdghVAyfT9HvAVMbe/MaMGsLHCiz0fGeRSTj6A+/0WT73UYu7xfsiSgyjZBf+tEJ0nhxTvcvXH64CD3e4VflMPJJNJodPqvuCJtYaMQ0Qjgu9l0qQVaFvCkY1akHxA6Pfr/3DtYbmTzJDEfP/Tfbdc+5f+oQu3XCE7FO2FdPiZv1bQrt9ophprlJ1WzdsJbT6R86keTNEEtfiEeRKeYP5ibfE2K1u4x5rfhUSaZpxw20PAkFuEi4mzD3TCscAuuwVNSI4ZYiDqj4ZeUlergZY69X6BC6cUhwis0eqKteB7MV9a6kIzU3iyNKMRVmbpVfT9n0FX9VQcVMJ5BjeYiv7zC6tKYYBM7i9gShQlOPKhTC+pKZdWs7fJ6fXTgLHdBsicMg9lnqsnDcgyG/8CONIGa2Y6Rfadp93sg1dlsfT6WyOHzbE49vqZk2hiFy8XUOJjlHCtBNXio7f7lvdeRI6x+mv7+wJ62tYTEhQ5S0GUnEdyqO4q
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(921005)(2616005)(36860700001)(956004)(5660300002)(47076005)(107886003)(336012)(83380400001)(186003)(82310400005)(1076003)(2906002)(81166007)(6506007)(8936002)(316002)(86362001)(40460700003)(36736006)(36756003)(6486002)(508600001)(26005)(6512007)(118246002)(70206006)(70586007)(8676002)(6666004)(4326008);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:34:04.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef797fc2-70eb-42ff-a78a-08da3f1c6700
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7156
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
index fd812802b71d..73c1e2aecd7e 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -240,6 +240,21 @@ static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
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
@@ -373,7 +388,13 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
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
@@ -393,6 +414,15 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
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
@@ -414,7 +444,8 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
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

