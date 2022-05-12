Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB95251C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356185AbiELQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356153AbiELQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:03:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2126.outbound.protection.outlook.com [40.107.22.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8515F26F;
        Thu, 12 May 2022 09:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEtfRoFcIt5+3SN+1qXvla5h2se4XppMj7LUOBNKG9tTzJyxpFhj3SsarC5VVX6f/dwiNaCTPIuRpYrhvDkKm5jB4wqdeYLt27ZIAW77FNAmIOTy91fFl7pmmkMs1DrJXDlpzyhaqoXmAUR0O20DYXmaor9HD4AjhjiFZ9pDqwneOTYa/W2tQ6JW66PFW/Z8j6mOLeumDvHnO3PHYuD3nTUNB4DlEegFVNlFyE48aYJm3Aw3hAKhaJBgo8CMyjQHWJeGbL5OgKe3jwa8f2PNEGcS9Y74+12QHPXGkVeNXA1HI7/anoiOj6ywp5wh5XFuW75DWuKi3zJgoN+c4bVC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=CkMDr98K5aiwzx9LPKvHPcyGWVZAYo6N9o4PNmTKra+DO76vH1/6sR06BUvtl0ItVVDDKjqzdKzQo7ax+yJRJJ2HYHTRBPc+8EAYJvHgC6KetYof2fJYwujajrQzWDnl5iXxTXIUCnXNqvY3oZ2bo600BexzWkeUJgq4FbUg0PxwwN0RzM1bG4T43qZAphaw3uzCxyAQqEhIn+zGD6c2TAIciESzUPszVY+8ZReJp/Mvtb7MCwnkjfSmFA4+SxffVlESsP+Imflpu6NliU5/v5jzicpXf4TrepLZZuxREC+4bJGBCscr7gXmckKqUJ9FFOzH7kEEmKyz7rLJ913kYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=kBynsgwhShzZREiytvqVdPLfwjrmbrl1Ud1of2BCuT3iFNgeJ/DC1j99xBRIKCZoPCxjp/qWg5A4QVHbJAN8iIqGBR3XYtMBj5taL2qNPkxLnPZT1Kw0TXoYiKax0YJl5IuyXqSduKnvMtgWVu1hcdaKfZo1yB5fzysi+1jhxBY=
Received: from OL1P279CA0051.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::20)
 by PA4PR06MB7357.eurprd06.prod.outlook.com (2603:10a6:102:d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 16:03:18 +0000
Received: from HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::be) by OL1P279CA0051.outlook.office365.com
 (2603:10a6:e10:14::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 16:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT005.mail.protection.outlook.com (10.152.10.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 16:03:17 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V5 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Thu, 12 May 2022 16:03:09 +0000
Message-Id: <20220512160312.3880433-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8014b091-9c19-4d23-aa11-08da3430ede1
X-MS-TrafficTypeDiagnostic: PA4PR06MB7357:EE_
X-Microsoft-Antispam-PRVS: <PA4PR06MB7357A25C164A0744693F32C2D7CB9@PA4PR06MB7357.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gkv0U6V/DrV59mwsRB0xXHE38IRhFDk+vhuK84o/ImVyU2uLoqaMpvt/AEoWbLTv7Krqp8Fu4YtRP12BhuqhZ2IxDUrvx81ncQSNj57TQyu08bSH4qDCZb5CbFiLB0V0esWOyxUmsC1g01PXbm+gU56vJqWXdSrFBJYtWit/jAdj1KpsfvehEBIbZEulO1E7Ez7RK/pUumRHjjHGIdD9KtdZjB+RSSNsdidxV0HRRRZ3/12JnM95lN8bJBoylNLDf5Q9yTcIWvdZVYtesrPfhjhx9LFLMAARH+GOPOJuDtE01/MuM5+w1SJQko3v2d7NLJeiT+WC4YNltfKEC+HX82wAJzjZlJGMyb2nsB3EuCrqu4Ij20pSQWF9paGbsMJriuCOxgefgyZxp701VogXpWH5wYP5EeJ3sJ8UNVzagbpRAAbdlPkM8SLIVPzBm2cy8Hv40YMcScAgh0wDYGarwu/+GgdCN/rGEn5L6SShSx6NR36mAZ84vDoWMdYRn9YFaOFgFjY60XJoTbnGI4H0W/VolYF4VKCKcU3QDeP2RthcgpYfpeDcd4+lHvMcMFFsqmSnbkuIx2swgCFsQcSrKRD/spFGGNPikLCsksFtZ5aeOSM5fSIKiWyCrzWoCwBDFvMeQfppEZ3+KnJvZ4yR5WUt9qNYvj6iBi5U2pn9amoIl58mpVD/obUb+0KM5Thp
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(316002)(1076003)(2906002)(186003)(36756003)(956004)(8936002)(356005)(81166007)(5660300002)(2616005)(83380400001)(36736006)(8676002)(508600001)(6506007)(36860700001)(6486002)(4326008)(70206006)(70586007)(118246002)(6512007)(6666004)(26005)(336012)(47076005)(86362001)(82310400005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:03:17.6035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8014b091-9c19-4d23-aa11-08da3430ede1
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7357
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

