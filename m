Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3B52BEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiERPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbiERPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:05:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2103.outbound.protection.outlook.com [40.107.22.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD8149D83;
        Wed, 18 May 2022 08:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSfomz6I1mT5f8bYcbsZhtfnyWGQl2hf2kccRYQsHwS2uXNCnYVVJvp+tfOk0Ebqsblz1spkHTGdYNkaeFL0cUsOhRMpLx/OQLWRj9lzJaGKqVzyvdmV4/nRXYzHVKVLbPsKr3dFLyN2VjMQxKQukNibuTzEKzQgGKwRoNuoCDqmJtd+fuqD22bSwJCpjMjHUTcGnibRhRguD3wc9kkUVeswLWie5Hl3PjnnbaNekAM/xQY/YjgKpi0YXnvwSCSZTbG9h/Y5mZ3e5s0I7fc2Vp2FNGg9YtNF3hmQsgWMZ/i4X/v/MPs3owVHFMGHfXRzD85wCKoqT8WfsWrHkmMXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49NFpHwbqaffxqAbX6nZky9D9CNDXFD2dgbOOlE7D98=;
 b=GNMrILuQBD358n8ba93kufZf9sKlDmNlNK19kT+QYG4CHjlrx/7t+nnUOtSXERRUWxY9panxb/K+fgDOgoJxE3FfomyTPv2U8uimNaGCxIj2p/nilHH39d9CS9SaW/M2Hw/pUQAkhSicAq7jzQIVS+Y4yu8cGi7c8hKsgon/9mvkRXY4Anl5fKdfwvm2lGhGxhd/rwR92sqnGugsF9HSu2ZSBnavl8GIglQ+40mKMMA1opec9MTV1Y7mEiOuFPHzp/a2uvy551yldTr9kzb8WUkhvfSXbG4ODOZZMRYw9szgO0zQLixlrPEMaXhk5zz4U2epPYZzDe6cAR5nz4LzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49NFpHwbqaffxqAbX6nZky9D9CNDXFD2dgbOOlE7D98=;
 b=PRYwYUQnciQvPsSIhhCDr0jGffXnJM5j1DmlAe3Gf6cemq2klGAOZMP2JkJUmOEazLXKxFyooLXpvm1xGaPsPazVgaGQkuXm7YI6rIIyFS1MpNJba1NaqWcEy2QFPV1K+dT6EmblmjLXz2NLtF3yOk48mh6apfAt2rbuW2hIthI=
Received: from AM6P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::28)
 by AM6PR06MB5794.eurprd06.prod.outlook.com (2603:10a6:20b:33::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 15:04:57 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:81:cafe::ef) by AM6P195CA0015.outlook.office365.com
 (2603:10a6:209:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 15:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 18 May 2022 15:04:56 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V3 5/6] iio: accel: bmi088: Add support for bmi090l accel
Date:   Wed, 18 May 2022 15:04:24 +0000
Message-Id: <20220518150425.927988-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220518150425.927988-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8b241681-09e1-4d69-7df8-08da38dfc5b2
X-MS-TrafficTypeDiagnostic: AM6PR06MB5794:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5794E2A878E1E240B627E381D7D19@AM6PR06MB5794.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5s2WAoEyNvkm4AETAN6sdFUP3WbLw/hcJOKJriNWK6wjH+va+kRrNk/41RVm6oqF/quq5usRnXTgFbAJx3fQNSA5O8pwdf7orDfhHR+9QO9fdVQLJ/ZgCcmtMljBtEz1WJscMR8cgYzfL6v7rW3eCm3KAnkc4kIoQzNQY3vevcaYV2Zb2BaBoWA2xv8SlyQ259zdvtXH5y8a4sSFoQmgod3+ZRtrePUFiU23mmFEV0CoBMhaNqnpBxCQLlvEmj+KuGeN2XJBN0WU1fS1POUvr1ZXdzMYhPrJ8m7j3hjGcGk/aPds/NfBdeTGgNmyjoMy1zaFoDkNCv0TDqA2xdZdBlU48ei4/d26zQ+Xy93o8gu9AnmoINk06sh4P3o14l1/kB2FMD/RmcJkr7rxmX95dkgAgzvV9HOV73hZ7sgoYTgyz5QZOV+hqCthKg/YHZgQR7+yEOhMDcGchevv9IP8kR5hfkhjBQj/lnOSuNA21NramCdNwM55NOg0JMX0IDizmHeyo6a9NByi94tkpvWF04HMQ4gQ/VMF5rVwZGi5bAhFRcBstqWOxRvRE4oVPc81a9nk1wN4m2+RdtU8/xyn4goDH45WbLNOngU6MzYgVBI+t2yBjvHi2FlC6G63y+LfEX5j3CJey6Xg0yOWGQ5kaq7dxIzjtBBdSIQNtjacUmORvEh+pdxoJ1qGou8cjFJ0T1fmQ/kO9Zbirc7KbJp5Kw==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(36736006)(70586007)(6666004)(8676002)(6506007)(118246002)(86362001)(36756003)(36860700001)(6486002)(508600001)(316002)(81166007)(1076003)(2616005)(336012)(956004)(47076005)(82310400005)(356005)(186003)(921005)(8936002)(2906002)(40460700003)(26005)(6512007)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:04:56.9362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b241681-09e1-4d69-7df8-08da38dfc5b2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iio/accel/bmi088-accel-spi.c  | 2 ++
 drivers/iio/accel/bmi088-accel.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index d5e93ac7f1e1..132781bfe872 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -478,6 +478,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
 		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
 	},
+	[BOSCH_BMI090L] = {
+		.name = "bmi090l-accel",
+		.chip_id = 0x1A,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
+	},
 };
 
 static const struct iio_info bmi088_accel_info = {
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index f2cd70f362b8..a35de34399bd 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -64,6 +64,7 @@ static int bmi088_accel_remove(struct spi_device *spi)
 static const struct of_device_id bmi088_of_match[] = {
 	{ .compatible = "bosch,bmi085-accel" },
 	{ .compatible = "bosch,bmi088-accel" },
+	{ .compatible = "bosch,bmi090l-accel" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bmi088_of_match);
@@ -71,6 +72,7 @@ MODULE_DEVICE_TABLE(of, bmi088_of_match);
 static const struct spi_device_id bmi088_accel_id[] = {
 	{"bmi085-accel",  BOSCH_BMI085},
 	{"bmi088-accel",  BOSCH_BMI088},
+	{"bmi090l-accel", BOSCH_BMI090L},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
index 9b23f50c8271..8ac9eec64d65 100644
--- a/drivers/iio/accel/bmi088-accel.h
+++ b/drivers/iio/accel/bmi088-accel.h
@@ -11,6 +11,7 @@ struct device;
 enum bmi_device_type {
 	BOSCH_BMI085,
 	BOSCH_BMI088,
+	BOSCH_BMI090L,
 	BOSCH_UNKNOWN,
 };
 
-- 
2.25.1

