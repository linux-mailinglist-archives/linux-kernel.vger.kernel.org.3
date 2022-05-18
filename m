Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9652BE79
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiERPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbiERPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:04:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60109.outbound.protection.outlook.com [40.107.6.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1F66AEA;
        Wed, 18 May 2022 08:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWiXGlWivomJssOKbkihmXNq0wKhtIpLUNyV7hgad7z2fJsS6XXJedTVOzG3V+CkrHDGiNlozjdeG+gb1f8p2Pehj7ziRXVK2FU6y5hwNEfYXQMpJu0pbVuXNNBG7JM1ppuPmtCqw9ygDIW4+BSNmvTf0w9eu3S/Oqy8BcEIQY2fJrn5hmxmWFkHvBdvdRYRs81wiBXaocXOCVsY3zNojpgtCx0PymGBh4oSnIL0WzSTLZMDOCreUs299tK/bcu4wnt+g+zFPwGXcijulA0MP19XAQHJ0LQUmND6UqjAHRW96gASeNZrZJwUevZAxS0eRoCj/Oilf3igReCuadvUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTKetEO1dkr1bJcpovsjZfBULsfuWIAoVlCe3e9j71M=;
 b=eucGJCOdY1o6cGwFGlYeo1ZYo5LQDyjLDXgstik4fd7Lysk0YPfaTzxMPVpUZJRSSAUS0vTNeDCU1gVBriIiqx9RepgaUbKI/DCwOLmc+OdRU2xoXkaunihONK8tiic9WimJljRvbmh1+/xZoNK+FPD0j3z/2gdjaNQSxZq+a5G0ub748wYRbcT0Z5NSAsn8/FzMrRuAxiIl0m2q1ecqHE2NXqD/vdc6swXHK4VW8uXf8Ai2gvQbm/Al8oqI7HnOKp5EwdgZGqBe1M9a45ErxkCCWjDupJwpTFL7TmS3qociPz7/7fPQpb5HyotRJd00oKlfrVXaNQhMSnvo+4vZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTKetEO1dkr1bJcpovsjZfBULsfuWIAoVlCe3e9j71M=;
 b=tPo11pC3nt5uRStqOWlg5p0E0Ehbbn57u/Cur7dNJPdUQ3Q4aP6/BWiGanBkEqYawvqISYQbkDrN0MAvqgM1o8uIZV0UchM6Bw5uvdiBy7AjfgATcv0v0Vo9hA+86UgcB00YLm7gC7jNjugJTF6NxjP1RnSQb0Z++ByFcbDwazI=
Received: from AM6P195CA0034.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::47)
 by DB7PR06MB5020.eurprd06.prod.outlook.com (2603:10a6:10:6f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 15:04:55 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::df) by AM6P195CA0034.outlook.office365.com
 (2603:10a6:209:81::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 15:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 18 May 2022 15:04:54 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V3 2/6] iio: accel: bmi088: Make it possible to config scales
Date:   Wed, 18 May 2022 15:04:21 +0000
Message-Id: <20220518150425.927988-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 811b4249-bb6f-40da-0a47-08da38dfc454
X-MS-TrafficTypeDiagnostic: DB7PR06MB5020:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB5020A523AF855D7823ACAA57D7D19@DB7PR06MB5020.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9dqoUAscWWrWdYE7FKWz8rMVMIE38sBJJsPUrneF8mzx4MXBvW/iwUrOtHiixltqIkI9iywrlCamj+cGl3uFaaT+L8SLqhppyUrprP7f28nmUlhkmfumpNlf5bBcYJJxY3G3l68OSHpA2G0+xkMRvGPdxhuovuhUKINrgL6H2wYlN3gvjnFhVU5BU+Z/cJIe4ONJnnNshHfxRmJIO68AX+ROyB/6xEUUdZUWCyGGElcs2eqTDfh3rH0GLIn4pGCCYygPHP937C2BwWkz/vm5MEYD6AcpJTC/bpkP2y33+rP6O2kguaWomJWvTtlfCPF2MiNDzljqDKxhGRN/nK73XoYI0xHGMT19DMigsmWPD9bZZQUvVF2Vgs8z45ieRyRoUa4p5pF4mdiTbJhyrMCBKb5d7lhgNav9QtoTcuN+IlXnxaU3s16jHchkK1YGPewtipmd0JRHQzQJt1daOir+VRwSiyo6bEl2nxzFlNQqBwSXg/qSqv2cjMkc2d+2O3jKHWwds6HEjO8yoBdrCo/yWsOhA1AG+4Ve8Rc2gtjm6MCU8fWwFKRhD9VvFSgNBe066hwQFZlaR/yO0Ut5sl2jN1aoSth6x5yL4xejsJWjVyXYwLgpHoXRs3zkXq/3MotjeAT5ZlCoFIXQx1EzhuXGwbZQQ+gkPcUbfpBoToehwIW+Ljniz/QRuW1JLpsdEGh
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(83380400001)(36860700001)(40460700003)(86362001)(6486002)(81166007)(508600001)(356005)(921005)(186003)(8936002)(70206006)(6506007)(1076003)(36756003)(956004)(5660300002)(2906002)(82310400005)(2616005)(336012)(6666004)(47076005)(118246002)(36736006)(316002)(26005)(70586007)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:04:54.6238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811b4249-bb6f-40da-0a47-08da38dfc454
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5020
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
index 21bddee869af..563bcc311844 100644
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

