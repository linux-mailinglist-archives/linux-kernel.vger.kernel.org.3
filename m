Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78181533D57
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbiEYNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiEYNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:08:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70137.outbound.protection.outlook.com [40.107.7.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C1CA3085;
        Wed, 25 May 2022 06:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBvDrgSFIQUdftEFTEbbbm0hNenCIEgF3XSpGTk9Rg3Ove6IIUIdRdF0M/AHxn5s7I6bwZ1seuJS6dwXZOC8xohEYabRXfbaX2xDQsZvkYAke/dPAGzPOgzYqAUczDfoQH1a6xmloMxVVBRkauhgPB/I4xCqB3qgLgVPvuFBp6vO9wf2jyxSQk5jS8w1cTqeNbl6w/FuADk4OSu/v1/iRMU64TwLeIqMsGHNYNnuOmtOqGamWS38eX8zirTb0Z19Y2lF3y3QvrNyiRv9uHwDZGF8S0EbGykPenALXWSwvJ/v3bpBiElluRfDvaUFQdrcurdSN0CCL8XotU0MMNu/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN1aFnLydPoTPm2oaAwRP1LHFnQEE/CLOPfQrCgL0oA=;
 b=NjRn3r0UvA5cL+P4o9JlXQTu8zIjQHgRuxz5y9o1OyKsWWTLpSlNSgqvLQKuFKDY7YtuCKjfxlvOU5+ua7Dfw3soGZS5+SiEA2RPNZjyfWOOFMwm5sZO3hgEQ/jneEzuf+Spb/iX3suvfwcmihjLNf1SnyKwVFnzGrjQiK5kvxjzhXw9tlOdZCL+xzOLWSeNvdUpcy+a7SX06nS8TBerGQMGgSqMg73JOD8jUgJvF8DqWENlEyiNGeqYL/ApQZPzdOAyzB5UFYqVaeVjVnE89QhokIM0l+GCuegPqaU9CsNVyL+dZ8iIuJtnBmxf0tWGR7CZxvUZ+vYJA0lPaqK8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN1aFnLydPoTPm2oaAwRP1LHFnQEE/CLOPfQrCgL0oA=;
 b=LdthVRAIB8634Yy7MC0QuqHauWT/tV9TVjJClAWTf1M91UplpmvBS/Em1+gi9oRge/q5qg0YTigjmmf64khBgOPpfDg0sM5Db6ag3jSefsWNPPsVyu08UMXRgeox07xgsLObcVmpyt15uR+Btexk0ZeHgUMxbQ9i/hXpeVkLtQI=
Received: from AS9PR07CA0019.eurprd07.prod.outlook.com (2603:10a6:20b:46c::23)
 by AM6PR06MB5747.eurprd06.prod.outlook.com (2603:10a6:20b:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 13:08:44 +0000
Received: from HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::52) by AS9PR07CA0019.outlook.office365.com
 (2603:10a6:20b:46c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 13:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT051.mail.protection.outlook.com (10.152.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 13:08:43 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V4 5/6] iio: accel: bmi088: Add support for bmi090l accel
Date:   Wed, 25 May 2022 13:08:27 +0000
Message-Id: <20220525130828.2394919-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73a4bde2-487a-41bc-0984-08da3e4fb26e
X-MS-TrafficTypeDiagnostic: AM6PR06MB5747:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB574717315FC64DBC492E619BD7D69@AM6PR06MB5747.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBkJ9VTDoln8Nqo6UbZOV8BiN6DpnXTmdgXCoyvtfqO6M4rc8yZYHvhmAYNwaV1e460RLfk+hmgapU7bLFkTqJ1PqIj+iLJxlE3F16Ym1Z2NnKiANkE1eBp3x1WOSrNiFJNhcwqb3dj0aGIdgr93Txf2QxSSmCwypt7S9QsooWOUU8GXTDKNbPBPJxx/PptRvKOqKQThbQ5EtclR4nu5esDwfGvMNLxyumGp0pa22VbQEEnPsiHn5uZv654YsbzSC4cDssH+TtHSYYNVTEM5C65mVRkYNMqbxscjuvoZsoS6n6wqQy4/7jBVrguY1hFwuyKSsdT0urYZbSLbY6f5n6gBR8AC/xGgkHnBVB340dVeLK8242zrMWsV/mtuOtIC15/ubg5mtoomudG8dyKHZpl09RBbGdFoGByZatwh7y2T9Giwix/I8rWA4Ct4Ofb11aDUpu5KSQ2XfMC8ODN42TaubPuSWTDzW50aKa1c/yrcjm+o37wVam0GzSGtJwynpyHCc4l2rali8AFy+5rF9kzftaGtVDUwckDwSFeymUtgYUGe5t+YUakSVPU7GMP/etB3EMo/uoBITAINPCCHj189gkUjtiaAmMF1UYwVr87txiXANWceWa0FhIX0n1g7OAyJI4nODlTGtqh4MXChfa0/I+1O9MaQsRoIJhoKW17p+6JFQPVlHpk7IEmHjWjm3xVKJIBj47b0HW5OU3EV2w==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(921005)(6506007)(6512007)(26005)(6666004)(81166007)(356005)(86362001)(107886003)(1076003)(336012)(2616005)(956004)(47076005)(36860700001)(118246002)(5660300002)(186003)(316002)(36736006)(40460700003)(4326008)(70586007)(8676002)(8936002)(70206006)(508600001)(36756003)(2906002)(6486002)(82310400005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:08:43.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a4bde2-487a-41bc-0984-08da3e4fb26e
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5747
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
index 18becc857d49..631cd66476ce 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -478,6 +478,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
 		.scale_table = {{0, 897}, {0, 1794}, {0, 3589}, {0, 7178}},
 	},
+	[BOSCH_BMI090L] = {
+		.name = "bmi090l-accel",
+		.chip_id = 0x1A,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1794}, {0, 3589}, {0, 7178}},
+	},
 };
 
 static const struct iio_info bmi088_accel_info = {
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index b14a1e5b986a..8aa25138f098 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -64,6 +64,7 @@ static void bmi088_accel_remove(struct spi_device *spi)
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
index 044999eb4fd6..80cd396a3141 100644
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

