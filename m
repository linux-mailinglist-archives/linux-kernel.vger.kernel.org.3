Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB620521D35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345106AbiEJO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbiEJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:42 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150125.outbound.protection.outlook.com [40.107.15.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D524F237;
        Tue, 10 May 2022 07:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC9qFwWYORGGl5pzsOQk1ItxvfLqLdM2iM/K9OiJfQpfgE1VJClTbFpxo6MB5zfinrDDsFoHbNJvNCpL0P7Wd1QvdHT2HzVLvg/10SNmw7ARXbzIs+xaqNQutIeyX3VxiluSFxOAinNqw85I34cZamBsTWdnm5jNwXah/+guGVdYwUzRKupHtZc2DuMbQ1sP/PR2zBpLW1z0tbB7zjlABHXKNQbkBg5oe/GXU+V4Z/MF2nJbzz2CCXegvWq9AHVD1kpypD8++wwX2DsRTK9zihass2jtl0DewMH+t3J2e/Uh13uDo6ySjv1v15XvWAuPGoreWeETw6lZ7zo0Er7BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rePnLGKrCiQJJOX1zpZir3zA8/cvqQHZMrJeaP6b1RY=;
 b=IMB2XgYDb5N0yGCUWhW5MS9NsHiARRE0REj7fDdcoEBhSip1MHfo9/+Yg5CDso15FV6tJqp1H8hskFziTLzYfX1hAnjGRw6bxffGJ42Az8EnPcUP2iqzG0SaXMfeZ8zPGA4dha0GiLJiFziewsA1x9Ke+e6uejsuioycAE1kRZ0H9Y3rVNPbx3M+4DdtbaJ0IjYViEjxXybBdjBaJMqUByEuYPo+i5gQUqqGXLtcCU4Zoq+97YElrp7Coz9VbVHV9UIRLonqMx36Pb8D3FCrJVz0LgdTzSD+yHKkY540M6c4b7vUWhEFW1Oo9fQWbRr+IaHkyqB86xx0PKKuQd5Kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rePnLGKrCiQJJOX1zpZir3zA8/cvqQHZMrJeaP6b1RY=;
 b=0Triu3Gj7KuHMmVyRPpxA8BRAh6d614uXivwMC4+pb9BH9rANp0sooJzyrltSWqUTHMkpmc7FU6lhSFefRPiztfhbwjkZwXWWxp5NFPVgc6c/klgPMvJRg5JbzdQlcVgoagt7KdSF7gxz7FiR/iZE/9u6XakW9oT0F4mFtRcq5c=
Received: from AS9PR06CA0332.eurprd06.prod.outlook.com (2603:10a6:20b:466::11)
 by DB7PR06MB5337.eurprd06.prod.outlook.com (2603:10a6:10:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 14:18:00 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::8b) by AS9PR06CA0332.outlook.office365.com
 (2603:10a6:20b:466::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 14:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT083.mail.protection.outlook.com (10.152.13.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:17:59 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: [PATCH V2 5/6] iio: accel: bmi088: Add support for bmi090l accel
Date:   Tue, 10 May 2022 14:17:52 +0000
Message-Id: <20220510141753.3878390-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 51eb8d02-6d5b-4d62-1a0c-08da328fe325
X-MS-TrafficTypeDiagnostic: DB7PR06MB5337:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB533736488604F4EEC77ED60AD7C99@DB7PR06MB5337.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4hupG6XmGK2Rs6V5Gbi7N+rm2T1zK8dBXgrNMDAafzoK9nK6vilhbQd67jBSjKkzhGr9Io+8tVVM//9DfFG3CeebBgBjSzn+hQS9el6JBECHsK+8bbPH/qgqnF27jdD4P2I4E4tUJJUYREngMlA1vr8HXB6aIjV3xmZntukSsp9+hgdpaYIrK4oR28cT/EGIr+pMM6l2EXaSupVgR/Brk0xtdL6R9I7tUMoc27m2NtPTlQhoUGX3xu0S3oE2boZDBSqG0OSuMCtqtVg/X+gvajSAkXx2iPeOz2Q2JdYlduZPA5f02r5zxKOpSB/2ETJCf++V5q5xIB1UF1PYnGUttEuIDZQ6834mIZKKWxPBTEsy2t5kkz2MnIHqk5cu5spcTAdv2InazwFPu3NPBFiXCsM43g9AlVkxm48uzx/xz+vRK7DXYE67V/XERoLEtunNLpUkC7C6ELbF7x0kAaJ5lXmXBRoajWNfdv6Npg/NPxg6x8slfwlWxI8E8nXSueag8rxbhTvI6t6eBs/rkeH4CfP4muu5nzI3KOkvJVSChWJvoS9X1eq4/K+gynvLYvcaOlhOJL+j3zc9n/y2cYJkFNsZpWUTOkJb+vrksdmZoJX+p7za8kpWEszjR6fBaNIwZ9o1LmUcMZ+bS3gute5zMKlgOSTyCXLcsV4b9VHrgBDdaNXY2RD60SpAq/bTd5GqQBH2QZGIXvrsyfFAIvCBg==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(6506007)(508600001)(36860700001)(6486002)(956004)(921005)(2616005)(6512007)(5660300002)(356005)(316002)(1076003)(8936002)(118246002)(36736006)(70206006)(70586007)(6666004)(81166007)(82310400005)(186003)(8676002)(26005)(47076005)(336012)(2906002)(40460700003)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:17:59.6574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eb8d02-6d5b-4d62-1a0c-08da328fe325
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports for BMI090L, it's a high-performance Inertial
Measurement Unit, with an accelerometer and gyroscope.
The commit adds the accelerometer driver for the SPI interface.
The gyroscope part is already supported by the BMG160 driver.
Same as BMI088, BMI090L have the range of +/-3, 6, 12, and 24g.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
 drivers/iio/accel/bmi088-accel-spi.c  | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 13bb3d96a3a6..6d44e97b4906 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -472,6 +472,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
 		.scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
 	},
+	[2] = {
+		.name = "bmi090l-accel",
+		.chip_id = 0x1A,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
+	},
 };
 
 static const struct iio_info bmi088_accel_info = {
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index e7a1daab8f3c..58be73ebd2dd 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -62,6 +62,7 @@ static int bmi088_accel_remove(struct spi_device *spi)
 static const struct spi_device_id bmi088_accel_id[] = {
 	{"bmi088-accel", },
 	{"bmi085-accel", },
+	{"bmi090l-accel", },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
-- 
2.25.1

