Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E814533D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiEYNJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbiEYNIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:08:49 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20110.outbound.protection.outlook.com [40.107.2.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF72A2062;
        Wed, 25 May 2022 06:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7VdczsEBB3vJrvtLfnxUENSZNaqooaXxzD7RQAV/m+rvi67iUiOjIIu/7E4UCUM5/MtP3R4BqMQHZAaaSv9S3uaFR73c9OBSV91qy39iHAkG2uGdeh2+Z7gKblGjlrTBlS4kQB4JVvCmP41olMJ18UaRnZqwMlQF9FSVmWXU2VCjkk0unvLtIZ6J2+DCI4O3B1nghgsWH5/Txtv0yiUYUnJRfH7sZ9KmyREJrkN78YAlAPc9QqEYcp1mnQa00bvjnwaBSx/tbN/VJzOwEoo5G0AUTMk6bC7CsAkr3ONMc73FDDEv3k1N95p+gWvrjCbhPo5SDCRRgLF074Linx9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3jdhWbWEgCxDYxcMZ3yohV5I+65uu+4kU3aTO5Y0s0=;
 b=VuKwhtyBSqXaDGU6BeTcN72qY3rmV+8+FNy+9mmgU9JX4mbpCNm3a648fhggAjvJFJdEyUj+c5QN+J46AK8Od1JYCgvYeLt/ZnqpbR7CvNGgOgxMtdecVhzUwtGvCUkCjTH6RpSnwLGWbWnhfQVy/pL5GyQ1YXKxlzryHFXRN8NUA94SdGxwxR0FWlO6VLqmhFaevLlvwXVXkMSRqPTu09NRwVx6nQUDCTa3ZO8NxD7LZYd2bodsT6GVKCNFWn2eUYEyXOwLiXaxAvxmCYNTzbQHpHHHYdVaVwdktsTSWvb/hPNUDHH1AXAyES59YFZx9yJX9XxDUrcBIgJs28lYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3jdhWbWEgCxDYxcMZ3yohV5I+65uu+4kU3aTO5Y0s0=;
 b=bVaVCMrj5rlam9hAZP9BBLydTTUCAI29VmugWMLJlfvMrueJ871pwwnlx/o1zrtWr4GrYVmyqTHUcZ2r98tVM3fb+NqWWk4jKDs7ab0etMc9Nwp375vg+GpKIfkauU2Ci0uwONrh0crSvIP4l0gse+gGZGs43TcbbhAHV3hcd6Y=
Received: from AS9PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:20b:46c::20)
 by VI1PR06MB4014.eurprd06.prod.outlook.com (2603:10a6:802:62::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 13:08:43 +0000
Received: from HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46c:cafe::b5) by AS9PR07CA0002.outlook.office365.com
 (2603:10a6:20b:46c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 13:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT051.mail.protection.outlook.com (10.152.11.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 13:08:42 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V4 4/6] iio: accel: bmi088: Add support for bmi085 accel
Date:   Wed, 25 May 2022 13:08:26 +0000
Message-Id: <20220525130828.2394919-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220525130828.2394919-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 62ee2fd3-af79-4ef2-c53e-08da3e4fb1a5
X-MS-TrafficTypeDiagnostic: VI1PR06MB4014:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB4014A2DB887155C0C2D5501ED7D69@VI1PR06MB4014.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uA4X5kuy+sVVLG5IUWk8C+bu6/i7vfXNJA2tR5nZSRHwsQ5hcaJFDZEY/e4dGyNXv5TV0b45QL2baiW9N69wPYVUNUPQD0/Q7p174chhE9ViMxnBMzLIaMNlBLXsqo5pNYebmJvkiy9lA/iNfNt+h9A49H68vtc/cKYhrZaFU6zrXDyho1BOStmzVKzeq8vz7unbg9GfhIRKiBI5y97Y4O8jYmFqCTBCoE6mSeRMLY/KEjI385Bt4/WhiuouC9LmlipQZbXe0uJsriMQdCySBEWutaHdkVSceTTkZF2iLHukEI4F//tjoOBBx2D2lInOq+UhuBQME0qNc/QMoCMLB7+VoY5Z2nkYnb+dnulEypOHpiDo30SF6Rx3544b36T416ZGZO+bX0eTr8iRMC3+hRxySf0Hb0eaeWj+98vQRTvAdXnGoWSdwb1+V9XakwD6LvKKaLXE1t/1ivNCVmcbPyrjrp/3Swk7l1qQN+LZZiO0ZAG/ADsI23wuPjcohVos5Gfe+Drr2f7y8McwGWANGrc1ofitl9pmYgfBkkqflMUcU8mjr3s8ewLB+l2rslnFDLfKarWz1qpZfMeHuDNZ9tkJupXeoWf94BYIbp+k/ea5VM+IFXaoKfJV1LeWQpBWXf4zwAX3lHaBakDlvRY4tIi94cpHb6G3xZ7LP07gBdMzhl11PqwGTwZWSXToAyCw
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(2616005)(47076005)(81166007)(82310400005)(118246002)(356005)(956004)(921005)(107886003)(186003)(70206006)(36736006)(336012)(70586007)(8936002)(4326008)(8676002)(1076003)(36756003)(316002)(36860700001)(86362001)(26005)(6506007)(508600001)(5660300002)(6486002)(6512007)(2906002)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 13:08:42.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ee2fd3-af79-4ef2-c53e-08da3e4fb1a5
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT051.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4014
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
index fe8db9615d69..18becc857d49 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -464,6 +464,13 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
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

