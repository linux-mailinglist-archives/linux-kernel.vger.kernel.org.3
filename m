Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28053535008
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbiEZNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344624AbiEZNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:10 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50101.outbound.protection.outlook.com [40.107.5.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE958D9E81;
        Thu, 26 May 2022 06:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCcQWcs8W6vB0tqn4mm7xgCxpcfmdUaotFCsYfdTJGH+7EAp3/z1Cpsfdfy2HsuhoODtPcgnTBZYPadSgjMqcaSOHCuz87Jj7u1QukhnelAXg8y0PJspXR6adZ1I/V/Pl3E6v5qPdEOQVKJaKx+bqV1nnYcPh47NHNgxiGKhCV79hglWnNwrMQTCQPOjV4Y6Nm7Qce1c5JrOtXTlfUjl4D6aPoqVAmZXtwOTxQck0mbSVXS3LC9q/pW3/1Nmv9r5ljOw5bYatimKBLJyVCmrciuuBPg9kO+dr2MDvuTAjxnrYNBtDO0xoyd1qQ6uOo0OvhO2bJdl8O803NRFW4CwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgCGdDDBSAqvRcdGjnIEp9nn9rDOS1bL+oaOpqShqpc=;
 b=mniGKrLXsQVbo8DrJUDdLMBov7MHN7yBXjfk1fZMBn965zkxLuXMVB0XUzC1duN0FdcpU8xWTNwh+EDDZEn+OtEQzEwsHTQk400ETIVxCAkWxAQ3VHSxLHP4D2d4djcHvqQD7qdHiW3Gr9dmkYnGrIjxevex+U4bw5di6Yl1MQ89CrihBd83qhSigZip4C66Pyvjo8KRf48mQhaFjHJp84WLr1bYs1KUbkwY30UdBHKliJxRnnqza2kWzZo9AQ528Xl1WsR80EYscvAUxFnwx4v7poQD2p58jIZi1vrBhs8WZiAzISj9c+lYa3N9z57xyWbMuyzmqpLEW/MFzoR8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgCGdDDBSAqvRcdGjnIEp9nn9rDOS1bL+oaOpqShqpc=;
 b=EWY0Ve5po+jIL61PFhJuR7O15KCCA/9AHFOHdpje0lbyttcFicwgaL6wZxcYw9fgXHVXzpFaFWOSYbLUhbynUlutQhwK6Zhrjfajfplve2yDTsPtDE8zBd0muo4pMUdYNAsf4AIyWU/i1/0CNDlCK71rzgENS/BQslV1aqwc/VE=
Received: from AS9PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:20b:462::31)
 by AM6PR0602MB3525.eurprd06.prod.outlook.com (2603:10a6:209:6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 13:34:06 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::ef) by AS9PR06CA0001.outlook.office365.com
 (2603:10a6:20b:462::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 13:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 13:34:05 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V5 4/6] iio: accel: bmi088: Add support for bmi085 accel
Date:   Thu, 26 May 2022 13:33:57 +0000
Message-Id: <20220526133359.2261928-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23bd680d-468b-4a32-b0c4-08da3f1c67cd
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3525:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0602MB35258789D0374CFB59C71542D7D99@AM6PR0602MB3525.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlhC+S2OsPP83jQWbEhLWP+v65+8CKISy2tikHFOvHtQZX5X4gakvZoBsXkB7FJbJC91MIuCatN4Q3yo2p3L5Waf9ge/ELHpAlziCICv9gWESzn+BoXZmJp3ivxC5tiDwVseDbyrPf8QGQGNnU+EN2sR8Wx+VI947C0nZeUe+7zdfX6i/7MZlT88pcqW6BidUYHcpJSuugc5LaECc0IdzEjH1U/GiDUs/rm+ix23WoGsek24+GkTf3EWdhysUTK6QdJLEGkUxkIKHMX8FXOVPNZexX7OPwFBrtuPUofMMf2Pjn5o7MLTvV9mLgnH3hEqlY3XbXxCSfRgEjCY1QhKK5uOOShw3MwSwhoVAr3DKdfimVQRGBFP9LyhbCLWvFn2/QOsSjRdVVw7I68iQYbQvre3Vhjmylph1qpFFnn95FtNyM3wvJREQHIDg3CUdu0ohXr6Bb+kDC8j5kIFfVvuf0VrrxRjMSyVQANALSg4ezTqiT62o7PvbAI+1AkWDEw3fvb4tzVUF/g21/PU9X+Jc0fDPlX3TAJGXi7qSfSj6aGhjjDz/fcWzwUyH9nLsjnrqeJmxvPX6aEeX8IEla+d9iFgzS76pSJ9Ah97wuangWxUy4MBFQXq+5luJgUWLIX83BjCguY7zps8o96gUUYHcRdgs91azMZD/QfuWy4aEXS/DFSXB3y1FGRRFeu81HVf
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(2906002)(6486002)(1076003)(2616005)(508600001)(956004)(186003)(40460700003)(36860700001)(5660300002)(81166007)(107886003)(356005)(4326008)(921005)(8676002)(86362001)(6512007)(47076005)(336012)(36736006)(70206006)(82310400005)(70586007)(8936002)(316002)(26005)(6506007)(6666004)(118246002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:34:05.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bd680d-468b-4a32-b0c4-08da3f1c67cd
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3525
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
Unlike BMI088, the BMI085 accelerometer ranges are +/-2, 4, 6,
and 8g, the scales are calculated as 9.8/32768*pow(2,reg41+1).

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
 drivers/iio/accel/bmi088-accel-spi.c  | 2 ++
 drivers/iio/accel/bmi088-accel.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index f6e44b36f5fc..f6ecb081456b 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -465,6 +465,13 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
 };
 
 static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
+	[BOSCH_BMI085] = {
+		.name = "bmi085-accel",
+		.chip_id = 0x1F,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
+	},
 	[BOSCH_BMI088] = {
 		.name = "bmi088-accel",
 		.chip_id = 0x1E,
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index c77aec01bc67..b14a1e5b986a 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -62,12 +62,14 @@ static void bmi088_accel_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id bmi088_of_match[] = {
+	{ .compatible = "bosch,bmi085-accel" },
 	{ .compatible = "bosch,bmi088-accel" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bmi088_of_match);
 
 static const struct spi_device_id bmi088_accel_id[] = {
+	{"bmi085-accel",  BOSCH_BMI085},
 	{"bmi088-accel",  BOSCH_BMI088},
 	{}
 };
diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
index 65338a1bf97d..044999eb4fd6 100644
--- a/drivers/iio/accel/bmi088-accel.h
+++ b/drivers/iio/accel/bmi088-accel.h
@@ -9,6 +9,7 @@
 struct device;
 
 enum bmi_device_type {
+	BOSCH_BMI085,
 	BOSCH_BMI088,
 	BOSCH_UNKNOWN,
 };
-- 
2.25.1

