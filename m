Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1151D51A110
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbiEDNk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350673AbiEDNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:40:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2136.outbound.protection.outlook.com [40.107.20.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6627FC8;
        Wed,  4 May 2022 06:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS9yQ9otSjXwYPSAxLaKNPT2/aJq1k6/iuenTlx5XrZtjm8a5uIqJ2X8ghJBYn9EWFPofSpwSJH8CKRuxQ1TNWAEGOdo54IW+U2/jC6euT1xOovPtslvDveFmpG7mCwVTNrQw0yiAsXJrOTt4BVPEzRxUw3QSw71H7VnNrEgrMrrySwh2fC0aGOuqFKlp84geQ7SQaqeGSqhoE9y7532ZwzSmAPTf7xAh/67T6mmen2bNEvW58WNn2htw4Zg9zPb6DZeg0DN3r0GZl3O1G0yj62NvegD6QdgRtBnjRWBj5qhB9wFJ4rNu9tXCYzejzA7X2IErL+FnKr0i8xmizaHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJUmEvv2c6LraUNp/KlZPX+OSdAyISjFAXhudAgYtDM=;
 b=HusOqUCXV0cQJE9l92q3L5k4U+Jv/cJ7zl+cjOuL1QsqfLjO1AuXgPtPn0BqNNaNapb4YnLuw7Ti3BDePWqcaOAHEsHCwj3GA14AXR0jRwcHguIwEWaVYhVny2bs+vKapwnhRKnVs6CWyLpKnnA+taJ/0i8tAhBoClVqHr0Vv0FIZTdmLa/xmvrOg/YMRudc98gC4tfii5rH0xc3iy3a65pHoBkA7gI1yJWSACcB593dtBPXFb0aPtsk31rmPFv//GhpaGaBnac6+W5w99/NGDNYJC+0GzM70ShmEpDvSaAHi7khKSNNP6KhdTlumX4bm0gAru8BT7WnSasY8AbjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJUmEvv2c6LraUNp/KlZPX+OSdAyISjFAXhudAgYtDM=;
 b=oyL2695Jr0jlLmBIyexZolK7nuLaLK0e7ahFQv9Su74nPLdVNVPu9XX/M0P7DjFF81xmKw7cshzFkzKVh7PXnnvRPmRJ3uzTfrUS5wIwXJOlg6t8iWR7Zl3JEZ7MSIZysi0vX21l2jx4lYhta6FVvuYlpw48huziEsneQjpRhTY=
Received: from AM6PR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::39) by HE1PR0601MB2634.eurprd06.prod.outlook.com
 (2603:10a6:3:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 13:36:31 +0000
Received: from VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::c3) by AM6PR01CA0062.outlook.office365.com
 (2603:10a6:20b:e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 4 May 2022 13:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT101.mail.protection.outlook.com (10.152.13.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:36:30 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V3 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Wed,  4 May 2022 13:36:09 +0000
Message-Id: <20220504133612.604304-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 65cfd1e6-9a8d-49e8-1ebd-08da2dd31913
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2634:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0601MB26348845A9BC08DDF0E7DFB8D7C39@HE1PR0601MB2634.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iONPeTdKqYmU9qetYyEeJcNLXf7edUpzS95/lfkmD5tFtMZxqVQ1LbT0vcdtEWT9H8FF62oTZWWf43FbqAxUuO7xnUJgyADJL+hnkSFC+VmMpU4oNPJd+laTe+hCgFY5Nd6gjlLCJg7saE6p+BsxUcFOurghMtlaKqenXDpSAK9usnOESQfDkzweS3pc6bLPu4AiNlx5R6Ck6cgh0ol1wdJTpzivJaOq7RiS76jQbHx7NIxx3qHGouGjOfEhg2mLkTvWczKWsWO15KgOGvD5Ar1/3tw81ucW9+HHVPW62US9AaFgvqvteNVQ4xJuZUMr3DwnGcQTRrngcnVwJ0OPIuoptEv4YlkfreHi460LvjA++EIWcRwXweJhJSGdgD0meFzr7x0Qui7JIxH75jwaWS0VJPwuzX6fhnCWPKFPmX8qi+UDlKmyHFDGXM71jedwGcCy8g7dvGJbgCoXujM0Fm6iy4BicjxJmM5Dfa6rK5B8drK8JsSHcb/kSfC8ebEIy8GKlSrTupCkyfOEpvGA2tSsouNfFt3/EVkpdJ5FSrK1Oz/Jbnq1SeoRYlmOz424pREi/Dy9a2FW4/kmczJzkIXe7v/InbEbmZ5DMI2/iaLebGZ7tp1HIuXvj+pNlGFEnsDHcUlwjFIwwDBWD959ylrBIDTvYwcMoYLeWOsoAmNMCTRW3+IbwMFazeElABr3
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(186003)(40460700003)(6512007)(26005)(6666004)(1076003)(5660300002)(6506007)(36860700001)(956004)(2616005)(83380400001)(47076005)(2906002)(8936002)(82310400005)(8676002)(36736006)(4326008)(70206006)(70586007)(6486002)(316002)(508600001)(118246002)(356005)(36756003)(86362001)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:36:30.6035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cfd1e6-9a8d-49e8-1ebd-08da2dd31913
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2634
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
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

