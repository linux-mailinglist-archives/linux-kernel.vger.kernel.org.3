Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9464151FEC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiEINvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiEINuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:50:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097916F92C;
        Mon,  9 May 2022 06:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4hTWKt+Iv3sfe7CdYhQTv42ld2PFlWxNt40lRJjMW8A8GDzu474dj//uihWr7fK7D0i+4abTHD3+tpzT31QkX4hohymg7TiyJgdpJVGAmraXxxITrfCYETSxAM1pZ2nCkMcP4aHIXEFWww3DUdMPki0f1AO1/9dsejFPK0YL0QBhneEavs/Zcj5UqEbi15fCpfc9Y6JjVssZPFNpt+nlpFX/KH4U0RZP2ljbPXutga6vdFmN3TXCMSxUFR2cvKMWEvXZcak2lVHoRLIG3KTxaBsDwiDP4++zqR5qj6SAqZVMY1b2i7fHcsK0UT8zsdICevWki4UqLsEDK+7Vcy49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCiOJgBV1dOsX6E05lMH+yxQnQgXKL6VmsudgsMvsb4=;
 b=hXNhNE3iqKGlyV3glqyi1PrV6VGsMMgic6aVJrfxa+lCLJ02fElYLhjHkOtBUadfklBTNMfDEt3un1WbmRou+Bc6qE8dI2xHvQ5GhYCBuWrDmFU+J3qJuokJqf+S6KwlQyK85pNx+eB/CEli0VHQsJbh9uf8AOGg94aHIBLH/Z+oTMiqKI47k5BIDPUlWqomHuoQ7CjrRUmCiqFPb8JdXGrHuDFOUKPVRp3C3WTOX8d3DkltWy4sEoPZTUaJkqB2SyeAFnUkm68GbUHIEO1e421Ct6+UHPad/mwx8olOBG8NWEEpE0D+qClNh9cI73qCguGqrtWhQc5IW2u+1/zueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCiOJgBV1dOsX6E05lMH+yxQnQgXKL6VmsudgsMvsb4=;
 b=ATqlLHC9A5Sg+L39pXdu1JpSOmw/OCkMZWlEbd8W2QhdUdaCjADCSJizb2jvMubH8sXSayTRbIpsGNgOVfUGornk1s6S3NbTPCbglcDsupjvj+31+i8VH8zRq0S5XQiiTTxTxh2cwtwURYJZTFx5Tywjh2uCju+xst+U2vurheA=
Received: from AS9PR04CA0061.eurprd04.prod.outlook.com (2603:10a6:20b:48b::15)
 by DB7PR06MB5723.eurprd06.prod.outlook.com (2603:10a6:10:86::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 13:46:42 +0000
Received: from VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::23) by AS9PR04CA0061.outlook.office365.com
 (2603:10a6:20b:48b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 13:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT056.mail.protection.outlook.com (10.152.13.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 13:46:39 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Subject: [PATCH V1 4/5] iio: accel: bmi088: Make it possible to config scales.
Date:   Mon,  9 May 2022 13:46:28 +0000
Message-Id: <20220509134629.440965-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 332a6a5d-4111-4cdf-4b2c-08da31c2583c
X-MS-TrafficTypeDiagnostic: DB7PR06MB5723:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB5723B2939C7B39F7371FEC43D7C69@DB7PR06MB5723.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jo51wj8V2aHGzAtpGqaVnyc5DiQBHZ46j1EnfJlm2qt4EB+QQ6O7poOUJ0C80DebeJP40VH7PRLexTTHog99heh5iAvl0nP1EnUKmXwr/jHOKu5mu1NK8dPQxHbg+Uu5C/1/qjCPk2znBUxH8VHVI1Hc/GfEM1YIhVMH1H7Larj3JADCFZuAn/EUQTMUsjJmHqsQ8f3hICNcdP6FJ/hjAJCSIR4maW37VrXBaK8k3Qin1ynJuJOvQvYt/Gnquf3fRdGc2ollyJ+XhNiKcbtYx7/wHuLuDeaUX/RrN0tvdx4Ph1uKiEs5cfA0p8JLsQsZOdP751xfrmiIepij2GzF6dPv0V5mzLuuNLUnHbXXwMV40OHy+d2QAI9vMuFYgCWJ4/0seoy6NWDttR8w916nqQu67dT2g7rL2AOwA0+kzZmQkg9p4nAAbUDBuAcFxRbHfLTjGJoumngFvMqJnUb44kb9H+TsS/9p4X3ozIwKgdgw64lKKMb2EDMYR193ADgER/IIFpSM1UjoH/R3ppmwMFQH9sWs4KLLMW7ofjlj2KtXuBmYiF69YlXnJHw+xqQyzKxSjPN6Yat2vEhFM/Tvk7ypeypoDU7hPu21+LLRKlxjKL3Nob1EiIcAAnCplyH6in3dr4CZTf1gl+g4l7lhenZFuW8n+Sj1HwpfrEgvGHitk8LUY6DzKBzkChTvBAxH
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(6512007)(6506007)(6666004)(508600001)(26005)(40460700003)(6486002)(86362001)(81166007)(8676002)(36860700001)(82310400005)(336012)(47076005)(186003)(83380400001)(1076003)(2616005)(956004)(5660300002)(8936002)(36756003)(70206006)(36736006)(118246002)(70586007)(316002)(2906002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:46:39.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 332a6a5d-4111-4cdf-4b2c-08da31c2583c
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5723
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the sensors can set the scales by writing the range register 0x41,
The current driver has no interface to configure it.
The commit adds the interface for config the scales.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 44cbe098c093..7c78cfb321ee 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -237,6 +237,23 @@ static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
 				  BMI088_ACCEL_MODE_ODR_MASK, regval);
 }
 
+static int bmi088_accel_set_scale(struct bmi088_accel_data *data, int val, int val2)
+{
+	unsigned int i;
+	int ret;
+	int reg;
+
+	for (i = 0; i < 4; i++)
+		if (val == data->chip_info->scale_table[i][0] &&
+		    val2 == data->chip_info->scale_table[i][1])
+			break;
+
+	if (i >= 4)
+		return -EINVAL;
+
+	return regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE, i);
+}
+
 static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
 {
 	int ret;
@@ -368,7 +385,13 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
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
@@ -388,6 +411,14 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			return ret;
+		ret = bmi088_accel_set_scale(data, val, val2);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = pm_runtime_resume_and_get(dev);
 		if (ret)
@@ -410,6 +441,7 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
 				BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+				BIT(IIO_CHAN_INFO_SCALE ), \
 	.scan_index = AXIS_##_axis, \
 }
 
-- 
2.25.1

