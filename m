Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C005E5251D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiELQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356167AbiELQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:03:24 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2118.outbound.protection.outlook.com [40.107.104.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7031C6223B;
        Thu, 12 May 2022 09:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE/RkP6fWmKiiFbOSIhIv9qCoFnfTg6dCCclnWzEK9CosyPc8orCk1vTjNKc8bIieh+onfrQQ9F60hWhM8nFXbuctAHPnkzB/Mr1d+h08HCikh+1zMgtfiwpDtzhZnZLBaCHSkENjQQWgxmd34WqzAWCmihnQJH3cZ3UhBDpBG7vxEKhrSetaPcX4VEZXGAJQeSCjVk7alGDgTG16D6YWzv2fmZBYLkhiPolCkPnoLoAojLqip5xiBgL8K57OqYXWKu3q0qc7YROB+ozJnFBHOO/5OOAx2UpZilEhzGrRR3TLq2pP46lqoMWHaZMIrL2ZdTTsyc2Mb+J2Ul9XZgMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M84jlitE2mSHMNc2Q5CJija/Bbj2HJbzZlocwylgPIU=;
 b=ekOp16KS6IbHpiWMPSsCUczU5JWS8sITCDPBi6kqSw1VdXhDnl35p2jIOFWe+mm4Y4MU/T/zB8rt648hlV31vAaDPwF2gNTz4GhIwzYGLfVfYh9g45+EVkVMKMo65IRx+0X0kX8gtE0j0bOTbwp5BkZmzbJ1OtseHAOrnFq0DM2Qrk1ovhmIy5FGnE4W+r3QUMW7ul4YRI1Hv+glJ6B4ExOmIstjBN0YOKs7RF6CgSU25DVpBiM9a+etu8D9qGdNBG51x06b2ZGmqwKTscuLB+A19sIR5ZTxCgi7hJeG2ZSvKqgz3zLd01aKEhjJQ6WhTteehtVca1rMN9wsoaxJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M84jlitE2mSHMNc2Q5CJija/Bbj2HJbzZlocwylgPIU=;
 b=djJJZVbAYGUu7d8Il0+phWE3tnbuKP4y1zSlnL2YLXkUQ8xUu7+tcExDBCM2xuH28ygRCHDe7dzK/t1ygr27+NitmHOcDwzTZFh7zLlu21apFxzN2OVEI2KB6hsPxZbQUJeZhJgpsbX0p1DY/NpAb4E23b3dKFlCyYIHzzNjRf4=
Received: from OL1P279CA0047.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::16)
 by AM6PR06MB4181.eurprd06.prod.outlook.com (2603:10a6:20b:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 16:03:20 +0000
Received: from HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::d3) by OL1P279CA0047.outlook.office365.com
 (2603:10a6:e10:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 16:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT005.mail.protection.outlook.com (10.152.10.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 16:03:19 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V5 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Thu, 12 May 2022 16:03:11 +0000
Message-Id: <20220512160312.3880433-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27c9d0ba-4f4d-4112-1f98-08da3430ef21
X-MS-TrafficTypeDiagnostic: AM6PR06MB4181:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB41817CA22B2D235ACA32E353D7CB9@AM6PR06MB4181.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+CdO8+FFduCF9AwS6wuvjp3xluIOKOzsjOJ3x/0BQQcPxzjsPsqOJnxSc9QAd3tT8AGp8qeCvwmfjhPTi6PtHCxUUma6EOE9KkC7jObsotIfsPe7j5wVEK8mbXzx/IGA3h3E4U9o8N+XAIdILD4MnpRs8jSkVFNx9nVIhD95Ql/zS3iUJA7x/Oai2+ONxA6wN2d8hYtWi/uVyukT6jjQp57mb3BZSitw2kjFfn7OMFcyBA51NW0sQZJ6kPfvHHYbffuXTpnEeV9NGojPIyVjvwL1QhgUsYz1tN7X7AdMrsP2DCrxIYq8a1Pd9ZuKcFRLWhYx1nIh8xM8eStR/zb4dh4kGr2EceE+kGMUpCGss7mbR2AUFAMUvHCNdih5l3UnzuJESjVCOYKHrCKZcYs64o5goy1KkvKINjTII0VzUCBxy79ThMzwHebxvYni/US58pbzcWiYl2UZIhRIpUX93pVJSk/AkL2kjjuF4vyWXJzQjubDOznyXA98Iq+hsd5mbAu8XFdtfd6JWR9SSIpdrqFjSfBF+3KG49WZMF5C01OBYhtkxsdaC76+Fo7DkyNsgc8vn1d/Pu7HZY/SPUg8/aVZRujXocUukIEMzKnuDrKJS3kb6wq7NypmKgqkbDeVRru8t4inLrSBrGT1xO7L/+88VfKPPoaKrohUoYXazc75CydDWB43tNOilSzFkpK/fUre0Ty/0gIpmK8wWrmpA0KrkQpwoRRvNwS8Jj7Q5aGuKb8JLsiafQcDqOXpd/J1jhxWfQo0NOXUHyO+3kLbQ==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(956004)(1076003)(86362001)(8936002)(15974865002)(36756003)(2616005)(6506007)(6666004)(81166007)(70206006)(36736006)(70586007)(316002)(4326008)(8676002)(82310400005)(2906002)(508600001)(356005)(6486002)(336012)(36860700001)(47076005)(5660300002)(118246002)(6512007)(26005)(40460700003)(186003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:03:19.6971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c9d0ba-4f4d-4112-1f98-08da3430ef21
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT005.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
Same as SCA3300, it has the accelerometer and temperature output.
Datasheet:
www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 80168f926b9d..dc53e7ed3925 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -38,6 +38,7 @@
 /* Device ID */
 #define SCA3300_REG_WHOAMI	0x10
 #define SCA3300_WHOAMI_ID	0x51
+#define SCL3300_WHOAMI_ID	0xC1
 
 /* Device return status and mask */
 #define SCA3300_VALUE_RS_ERROR	0x3
@@ -96,10 +97,18 @@ static const struct iio_chan_spec sca3300_channels[] = {
 static const int sca3300_lp_freq[] = {70, 10};
 static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
 
+static const int scl3300_lp_freq[] = {40, 70, 10};
+static const int scl3300_lp_freq_map[] = {0, 1, 2};
+
 static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
 static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
 
+static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
+static const int scl3300_accel_scale_map[] = {0, 1, 2};
+
 static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
+static const int scl3300_avail_modes_map[] = {0, 1, 3};
+
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
@@ -157,6 +166,20 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
 	},
+	{	.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
+		.accel_scale = scl3300_accel_scale,
+		.accel_scale_map = scl3300_accel_scale_map,
+		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
+		.freq_table = scl3300_lp_freq,
+		.freq_map = scl3300_lp_freq_map,
+		.name = "scl3300",
+		.avail_modes_table = scl3300_avail_modes_map,
+		.num_avail_modes = 3,
+		.chip_id = SCL3300_WHOAMI_ID,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -560,6 +583,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

