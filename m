Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF7530176
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbiEVHE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbiEVHEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:04:32 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60138.outbound.protection.outlook.com [40.107.6.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612822E0BE;
        Sun, 22 May 2022 00:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK1One38S9V+zGdUQXBKEj7QjUFkGPkRdbVRkGIlx5IIEgWqeD3jPoDiV0ePT7/vEiyWv5H/KLzV6qWRCiBZrCWbbf6jg7RdNtIlzzBRTvFnBWVZlfPXJWNH35JlZJjYXE6C+JIfxPxPZm0ofXw4fKhXFcwfpsdN3Z66md6uqKHO3Dn0FlcI86uWUqGiAxiXS6ZtneQtMCRm9YPmBwuBTJy6yzPVI7J8YVvvmmGak6QvWwPXFDaXdilzx3sqIjTiOhUDIFLQsSNnfHZGrk/O2pExVmu7OdDXkm89FruJEZhYe87pTEIZHT+mWzX8AsBSRpdswIi4bsZQcVQ+U07meA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=iX74rba4ff0sw4Af/Nx5d0+ZgHFH9K00kdZGKU6CCULUJ/PNnHE3MWVc1jLaCUnUdkyf+5iqAGy83iP4h6G7pk+/0NO2HaL/d7zikIMqCaCIWe6hRryeb+9uYxhRSECycywZeKNh0tkI3miyOhfEMLV/Ve3Q2A2NiuEwovjVyAYtYwxZ4az0RsW3AMqCbcopV+JQJUh9XfJbcfzso6h2ZbjYQfh+MX0w21Raa7s7LX1lHH09OYx56s1ZUKniFXMFMF/JQ0iVmjSK3o5kv04StuuvYFHRt9bNCWK9Mk0AMAr7kcdqCYjWI27CSFdDD0ub+wqq8+PWOLIfckqv7e4/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=qLH77DncOiAdI8hhQOlhkwOA+gzfAB5QiA+ryoj9ce6Rt3XrlVnfsKFvyUscwBa0dg8vth2Nr8etVrMbctffTG7QS7VFDvY0u8Cnnpipob2HsK2csCo+u/YndN3LRrpZzmucAcLf1pTXNMfS1ivIme3Pasx39CvGnoSRJsuZYUA=
Received: from AM0PR10CA0108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::25)
 by AS8PR06MB7735.eurprd06.prod.outlook.com (2603:10a6:20b:334::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Sun, 22 May
 2022 07:04:24 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:e6:cafe::a9) by AM0PR10CA0108.outlook.office365.com
 (2603:10a6:208:e6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Sun, 22 May 2022 07:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 07:04:24 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V7 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Sun, 22 May 2022 07:04:16 +0000
Message-Id: <20220522070419.409556-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d857b1f-e5bf-46c3-6e66-08da3bc14da4
X-MS-TrafficTypeDiagnostic: AS8PR06MB7735:EE_
X-Microsoft-Antispam-PRVS: <AS8PR06MB7735991299F86E443C127AE3D7D59@AS8PR06MB7735.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2lrVNpftFomrvc8FPbaSh+YQ8tJd62EjdgBDnnDTUgqErocA4H0YqB+bGIFtTTz+uzk+KtfGVDywlx0jzbkHFLaaH510bmQuax10M8hR/ZRqYfjLKZk7KdIyNhSHdlyk1xc36RHMRdEfBJnHPX56ypJnEUpoinMaZag6IcxgK0nJoJEet8MRbEAnEsdT0u9j9LjtKI1F0F5McMxlJHd2j4b6QOGxRgnDYWN8tqXBoI0q7Cq4PmTN3fB8vV1xD6XL2PMxVYdftAxxWUY1PLxTzSFkxZh89yYNkes/g4KfsTRy5Lrhvllz1hW+syHf0Qjz6P4C2fh7XcibxOQA/X8rjw7VIs3KY3K/k4at/6l/PtHpLp1qBAn1a+a19BfZCRnj4RMs1AvIII5DotvoEzUCWqXi/DOtdDhIwPEBPsVZzxX6sS3AR0MVds7Mk3X/mU6kNHm7tAcK+kNh9kL6uwY7FuPVsB6u8PUz6FaVj7ionVT6KBMDrbHGZpThOhy5imXHEFDm5EA4i/pqBhhELc2TD/FpwJev/P+kHdmPIlc602sLoKD03zTjzXbdmcHooUY77HV+EpkrZzG1vpW75Cqn6mWDXbVJcm9zB3o9a9FNdMrxjlJMyrlxn2FNf8OIF1zJEzC63eIZd5NR7SuzgZxY7Unn+3In4ACZFIAf7hiMv9olkYJqktupH8ZLqAPNLPs
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(6486002)(36860700001)(86362001)(508600001)(8936002)(82310400005)(5660300002)(118246002)(356005)(36756003)(81166007)(83380400001)(4326008)(47076005)(70206006)(70586007)(6512007)(6506007)(2616005)(956004)(26005)(1076003)(8676002)(186003)(316002)(36736006)(336012)(6666004);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 07:04:24.1507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d857b1f-e5bf-46c3-6e66-08da3bc14da4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7735
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

