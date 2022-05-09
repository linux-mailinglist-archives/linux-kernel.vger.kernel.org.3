Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA151FEB6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiEINuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiEINuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:50:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2122.outbound.protection.outlook.com [40.107.22.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F031164CB4;
        Mon,  9 May 2022 06:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzPVUewWclPksBmqFHuTG8o4F1GX1mWKGORxtx7cqRQOBFE43duWtdy7u8jAcJLGWoLTQ8mIFjGbhIr2x/VRxROKcGxZM/t/mJFb2eaREKv0Jf7F/svfgGLBCrfmTkn+JCjp3QuVZUPA5ALT3q/GelMUrDq4uRFCf/k03BCfqMiGuHRkXhXjwZpnIdIFrO92N2aIt9/GW6fpHPzLy8IZ+l4bNCjZK8soyFeBTpd3z5huf+4C26iudoMD/NUfKFQqkm6m82CGUMQFJqhknwV2ee8Iwz1UdpXESUvxmCaNEPS6KEpzbbfMiMdoF+lPrxHvUsAtkiuFPVFHwR2BXVcS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irwy0KKOuYF/RdVeH4BkcdceXbkpF69gBW87N0K6pCo=;
 b=U15LlopzwPMpE1eHCFRtiZd7FK6ENxaFOvUdWQ/bZxb0t8cqapAN6w1tEkEGYrGVn9kdw7iSZn2oJakaEep7KX26keon7PpABI9cpG9IJHDO8a9ZCgYTsZRubrSaTqpNsqD90higSkyRcEnonTAkQq/6gltEq1Xy+VhkAFgZ+Cfc696DXtZXOLb8L5entzUkWAvnt1TsGN1wCUaGG5F+3ZjXA9BmuM1UqtEHFnax8f6WEFn217jLmBKofzzEiaDtB3nqKkxfgxzqmIP0qHujNABcif5sbglEfLvDmQMPMpwX8aWfMw5y8MVG/uTCXuEj8raIq1ngzA5QZujtY7x+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irwy0KKOuYF/RdVeH4BkcdceXbkpF69gBW87N0K6pCo=;
 b=m3upb7js2h7kixL7H47mr3pbBcy4LcE4H00DkaCEQ3nOJG12cricMVnZI9GovfUJDHJ/At2WMvSs5P0nCT9KLL64aNyI5E73M67Uts8ca3/PXAvnqiSEDu1RT6VFXsiCwNTPuM0UaIZ8olOyqkt92w9FNGVFmlruzDOb6KHnooE=
Received: from AS9PR04CA0067.eurprd04.prod.outlook.com (2603:10a6:20b:48b::14)
 by AM6PR06MB4963.eurprd06.prod.outlook.com (2603:10a6:20b:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Mon, 9 May
 2022 13:46:34 +0000
Received: from VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::1e) by AS9PR04CA0067.outlook.office365.com
 (2603:10a6:20b:48b::14) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 13:46:34 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Subject: [PATCH V1 2/5] iio: accel: bmi088: Add support for bmi085 accel.
Date:   Mon,  9 May 2022 13:46:26 +0000
Message-Id: <20220509134629.440965-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 833871ad-d871-4f9c-6c0f-08da31c25503
X-MS-TrafficTypeDiagnostic: AM6PR06MB4963:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB4963CD370FC7BD11F9998064D7C69@AM6PR06MB4963.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yIvmSlkjqKGEmvscCmRDntjE0bV2mQ/RUbM16RzAd4T2rPXLxGTSteK7T3edkufSvlCtckbDeP4hpCsKXlBQ2kH/51v6bytOL7qX88Ptm5/S4XcvR4/5zTFVA0EDk9DA9Rm+9hhoiOySkf2DHM8dbsekRY7A/JUwkur8AcNd4Qh07oYO8AGuQ/CoHW0DJMVncQSLUjvrPoQaGH/WJ1yIe5Eh0xKNWmHe/3J0HDYnFYaKNX7WJV5Ixk5RQT2ayLTfaPHVsTJX5+HLwha4j0AUYuOcQrXjvYO4vHsVDol1rJ0bpCruUEPkpFFN00TdIjIKZj16Mv1R1cMgN6vz6YjSnySbLYkoUxfGj8t6FeWxnlvEmnFFTSa7ij9nxTNAAdg4/XxuIoqGchh6Lm4z6k4TJDqLxLbwQ9jPLpNRRAsX+b9KaTC2UKyxcWy2MofaIIlgm10ZssBkzGz4yrK15O3VtOKnFslZAclL/MLI4+d47LpPcv7Vn1ECoaGaSw/tNP9TY2Du1MUG69j+eBQFFoYkMPaAH9oiw0zF0QYwHs+DUjSUnbSNLGE/r/KVyYRlfhnzJX9Jn1QaDw6RkXHS4RB8XGasDSAwoH9VenDtrWYXkrxi09OPmqIQ2mGvnNYEqRaoDqnQXxe5NIf/93wauaBIqHsta8ontpv75PIqxUDq4sxNPlxl+IX70avC/OqOS1y
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(70206006)(70586007)(316002)(1076003)(2616005)(36860700001)(186003)(336012)(956004)(82310400005)(356005)(8676002)(36756003)(5660300002)(2906002)(81166007)(8936002)(6486002)(26005)(118246002)(40460700003)(6666004)(6506007)(6512007)(36736006)(508600001)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:46:34.4331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 833871ad-d871-4f9c-6c0f-08da31c25503
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports for BMI085, an Inertial Measurement Unit,
with an accelerometer and gyroscope.
The commit adds the accelerometer driver for the SPI interface.
The gyroscope part is already supported by the BMG160 driver.
Different from BMI088, the BMI085 accelerometer has the range of
+/-2, 4, 6, and 8g.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 0c58ffdd00e3..ac8acf6e2ff0 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -435,6 +435,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
 		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
 	},
+	[1] = {
+		.name = "bmi085-accel",
+		.chip_id = 0x1F,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
+	},
 };
 
 static const struct iio_info bmi088_accel_info = {
-- 
2.25.1

