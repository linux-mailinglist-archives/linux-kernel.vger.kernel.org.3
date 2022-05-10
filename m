Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757DD521D34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbiEJO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbiEJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6A237276;
        Tue, 10 May 2022 07:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZzi5LUULo98sYngxuUKHGy/BMG1ISPFdJT60Pri5hGnbqGecoEHoKhG40A7fBEuOsrg3117xTdv0Z0B/UYL62KQ2e50YcBnW8ZnhqyMwNAg0XSFVvi+S6lnxUCtZkWPC74MRid8q+fCqwadfWdRmdjXHuXEj5H0DDxE77lmSVxILrw1yq4UxbprKO305nhSuSQiwynbicShAiFlpLi+rGZ3/ufrPGx6M/Lchhxa9Dkf0PhvhfLrsWgl7k9vtOKzBCGGW8tt45lfNMda/b24u81Qvj7v5YOnI9sOMjxVj56DmlIRwA74izu8LUC9mAUW2TrqrC6OHwwYWLnIAe3M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A7WWVA43TAKcQUTkVh7sMPLv6MeYPk75wIlP1Hoxeo=;
 b=i3LTKnSOQ+2NZff9bxgz1pCmYXH2e42DP2fLpoVHnF7mcqTpWgcnCUo+R+OX0LfhlR3TscnqHtNUI4I86qgQ0IltLXmGOGePPeU9QUEu+YjNlpzfdoQSLeMZX9kZpuVelZJf0K9M8/Vi9SMVmJIpjFcDRRCfRixh4DcA47CAkaphSNbQtb1WE1yv/gBAhGpE4+UdOF4IsFGRtHWLWFsYEFrOmMxOJRofQwIWE3SgnC+qfz64p+RqetmmKwZfS7TuXZh3V9GuBU0M/3qU34PDY3BPqkMlqLj+XK6thOVxoxkrF97jA5q10ShmB4fXEmq48yQ0zPiZWLTfLYQTsWJl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A7WWVA43TAKcQUTkVh7sMPLv6MeYPk75wIlP1Hoxeo=;
 b=LdlGjhilojU6Sc0iqJV23uWZJMqy4fMjz51lVwpJ0w2KhFW7itQoZFt/SSG9Y4i94PLyZRx9UTpgROwPbdqktBVErVLijHTwD4aKmx7cjxyHjKwbH2icaG7CDz8nZZZDijMubSSBubjxvQx9jHoTUNFt/DwxnZSnwGK4F2dR45E=
Received: from AS9PR06CA0338.eurprd06.prod.outlook.com (2603:10a6:20b:466::32)
 by DB7PR06MB4695.eurprd06.prod.outlook.com (2603:10a6:10:57::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 14:17:59 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::70) by AS9PR06CA0338.outlook.office365.com
 (2603:10a6:20b:466::32) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:17:58 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: [PATCH V2 4/6] iio: accel: bmi088: Add support for bmi085 accel
Date:   Tue, 10 May 2022 14:17:51 +0000
Message-Id: <20220510141753.3878390-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 123d3e46-02c9-455e-4852-08da328fe2b0
X-MS-TrafficTypeDiagnostic: DB7PR06MB4695:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB4695FF030F2CC538E489562BD7C99@DB7PR06MB4695.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3xAy7fmf7Gq2tPShBuo4E8L9coojDlxVesNkulc374ovQED1cbUuZaalHfYjLmYdYSh7Yc3cSLI+rb/PVLk/kkeUFOhkDe/gusW5GEj+ceE9vXeq0D8nl8FdCioMffTTp47Gt/7kzJacRerV0NXSjmPyMkzUeRpXhwjSNuDVhctin1zuvElk140Y+4JSL7lQVdo/fgmHl53lBrg1spdY0jsm0tSujXG+FO95fZflRlIYA+kGNkX2B5/R/Nm39vb88U1usvUNRyqwtg5N0BGJFFpT9WBfr+lQbwOXq7bPiiRUsKXPNBeqfLaAyeOa26gUx6ZX98PzCXmEpD26D77NCeTgOwa/Ks1KkwAvlHtCjoHFr7Gd54Ozjpv8yEd6ywpLGOW5+kRcOuWfIHl6eHvYtiOMCJA9aQpAWJudInD9GqMNYeOMNYy2vTXcML2JOZqNMz3+QQTrpAqeG5S0Yh2p5qveasxVPdEsjnDbaufw0f9urOXVSzIyoaVfncFzXMeRZmtZdiC+lTFdwlo5YLyFBbR1AJZRsxJerxo1aviZ8aLC5GFdjFaIDyYpaihI4/q4H6WP8UVPV5CbBN+aw7+Q8uwy4gSJLrSQ1nzUan7pTv69aiqCEWiZFjWMXmoNbVj0shG3Q2pch+DL78oEsm7wj0/2cXKe15trUwng9GqnklqR1o38XHXlD5sniUkGS8EilbKT11BA1vOj/IyeBDMLg==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(118246002)(5660300002)(6506007)(6666004)(26005)(70586007)(8676002)(70206006)(6512007)(2906002)(8936002)(47076005)(186003)(36756003)(336012)(82310400005)(1076003)(2616005)(956004)(36860700001)(508600001)(6486002)(86362001)(921005)(356005)(316002)(81166007)(36736006)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:17:58.8918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123d3e46-02c9-455e-4852-08da328fe2b0
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
 drivers/iio/accel/bmi088-accel-spi.c  | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index de2385e4dad5..13bb3d96a3a6 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -465,6 +465,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
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
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index 0fed0081e1fd..e7a1daab8f3c 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -61,6 +61,7 @@ static int bmi088_accel_remove(struct spi_device *spi)
 
 static const struct spi_device_id bmi088_accel_id[] = {
 	{"bmi088-accel", },
+	{"bmi085-accel", },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
-- 
2.25.1

