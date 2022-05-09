Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881F51F518
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiEIHGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiEIGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2121.outbound.protection.outlook.com [40.107.21.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D86419CEE1;
        Sun,  8 May 2022 23:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqbhZ1ibaVORcglk0NNC99YnI12/XQrY5LiBJl6EE3MXIsQkPe9FsYdYX37ytS5gihTAqZjdDPWahcvNzGJx5mj7WrTLDyjtySQI62CnibWDTlu92W+pxMrklVaWQg5NWpmTrp+Dm04rYFCjsOV34ic112DyKSN7SkCkPxIzj9y7WxqNtkU7ZVgkoKXvsqHDh+ECS2TDGUzXc07PqjxljU+Cs2NWP+bXXttX3sFzucHmzwdhoQr05DYVnQlDQd0gpB/KPshLYK9f5cP49MobXVhp6obxPtS+SKaBiiiVtTzcvLbUw6hqT1VH4apSc/RqLI/dG6LCKLLpJVkbBErOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=fOnxO5zCod/dAEfvi2iY4Q+4Da6WQWSsOiqhkhMl5hSJKJnV9hDjW25Cb3qeBOPkU8bNS38F8jx4qZXmybZ+hAKxY105V4Zr+ss5dMCZr0/LLdPime89XfopyhAbdD4laA0gXa+jHq4q0/UnU7zRXItSknf5KzoSaF/3oG9VL//qkxh9Lt5vGRVRNjmrL07GTqcK05xDGzwc3zD+kiwOegyXmpZPCbWzGwxtwFzbjHwOxA2p0BwYoW53IrfAneAaGdvTC/drbHzqdFcDgEsJCMGWzh23K95BwvKSAJjMRaLKTvQ0MTJBMbYPnvKu+ZatKZAeFDZxBFq5pCUV0lMCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=PwjlEA4qNoSEBmBF2B83MOYUx/3/MYafrd5HDHdKm4/mYaJzWmrjVlbS1LhhqqDVVDcbZaeJ1KSENvJI5/+3atPzdObNeU4MDOLUvWXuFBYXnf3NB7qBF4gGtR3IyaZkOrZh1JnuZlopsAOZCmxCeoWeX3e59RD/9U1NZXQqhBM=
Received: from BE0P281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::15) by
 DBAPR06MB7078.eurprd06.prod.outlook.com (2603:10a6:10:1ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Mon, 9 May 2022 06:49:34 +0000
Received: from HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:b10:a:cafe::8b) by BE0P281CA0005.outlook.office365.com
 (2603:10a6:b10:a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 06:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT040.mail.protection.outlook.com (10.152.11.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 06:49:33 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V4 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Mon,  9 May 2022 06:49:25 +0000
Message-Id: <20220509064928.2352796-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 02f8ef4b-9125-4415-bbcf-08da318813cd
X-MS-TrafficTypeDiagnostic: DBAPR06MB7078:EE_
X-Microsoft-Antispam-PRVS: <DBAPR06MB7078ED64C69D22CCF0A31C45D7C69@DBAPR06MB7078.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKl4Lm42ZFBzJFAXEaPWv2k2FtrNotKTYEeFUNm8KrHxd64nAmK6L34YKRO23PamU/jt9rFuxaSVwB+/iR+mrkcjglg9mfaAeRbyTF1vpg5TNdxSkSRkEtPwapkceh9cmNelDqCcQGJvXfUNkuzlc3ZOpKeXbh3D1udnzuDpsjwwHJplfpeNpFvXuDt5qUE4OY2UgsCUTuUvdMphkfHqpgpwAHhcTMdHpPsB9ypyLT78TQs7F4IGHifWDmUFAdudz4Ny2K4W+VAuz3sDGQ7e7tEZS1aqsHC+nx/wupHt+ZFb9QOfmKVZJI/BYjqmkkRcJq2j4EwbnSJSaBPDb5E5CILkeAK3B8vJAGkB6heZlO0Knc2aIYbXJ4PFNREs2NlF93dxznVOaWPrTfS5PMRfcxu0H+nWg+TpiwY7DgNb5adgs7U2rzqUCf65YoDwyATDLO5pSMulerQEqUhzPFb75MS9fNOn9ZWH2ArkVB0UqcdO84xIPQQygU/ueJXdPfLnc0ufzjZtOBNI0ZfwFbNJ0efTMkwBjpK0HIHwElPmCOe2RNdJdZHdov52l8Fr/E0GwKdyIVfh1f0tNI77sTYpHw/giaCBk2S38OiKzGCrg6NJBmuuiEHBwwaVEGwQqDcsTU4tUIv4oo1a6FXvpPhACyPQnQ6GxyhHWsKQlZ/44yjUKdTYFGDREJYKMVTLErEJ
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(40460700003)(508600001)(6512007)(336012)(956004)(26005)(36860700001)(6486002)(186003)(6666004)(86362001)(316002)(1076003)(6506007)(2906002)(5660300002)(36756003)(356005)(81166007)(118246002)(83380400001)(2616005)(82310400005)(70586007)(4326008)(70206006)(8676002)(36736006)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 06:49:33.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f8ef4b-9125-4415-bbcf-08da318813cd
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB7078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add define of SCA3300_TEMP_CHANNEL for reuse.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index f7ef8ecfd34a..ff16d2cc8c70 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -72,22 +72,24 @@ enum sca3300_scan_indexes {
 	},								\
 }
 
+#define SCA3300_TEMP_CHANNEL(index, reg) {				\
+		.type = IIO_TEMP,					\
+		.address = reg,						\
+		.scan_index = index,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_CPU,				\
+		},							\
+}
+
 static const struct iio_chan_spec sca3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
-	{
-		.type = IIO_TEMP,
-		.address = 0x5,
-		.scan_index = SCA3300_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.scan_type = {
-			.sign = 's',
-			.realbits = 16,
-			.storagebits = 16,
-			.endianness = IIO_CPU,
-		},
-	},
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-- 
2.25.1

