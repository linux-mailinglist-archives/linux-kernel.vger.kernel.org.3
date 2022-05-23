Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D615309D0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiEWHGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiEWHGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:06:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20708.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::708])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32722DA06;
        Mon, 23 May 2022 00:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJKK/5fspzwHSWNGT7fcB0V4crpEInzJEtGM6pxTIKjpjfxRwMxC2EI+updu2SmZjz0RNf8Rs10hZ8T3pegLL8c6iDlU0Y+P4aTyw0U6/NVCqcx6PdMtdOyce79FQsuM9Aj69MT3Mzr2mUnoaKy5XArnMKJs9/CQ0Y1d5NPD0/w8bkB2VUn15u75u6dXs8se4UfXAtL3imS2p8RX+kn+08LEmgrDZps6fvgv6c1MtLOk8PwPO17ySJMlzdZVQlQMxL+0vlkbuTOTauXuQxluQn8UGSnLk8bluaa+M9CJL1UXlVYxTX4+npP88RYy4I9ZNt2bvoCP092zV4GlWZg/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8yoyF68Bxn4Gfq3xAadWluBVti5y8fchFtvTFTU50I=;
 b=e/S2L0OBMtemDs8ZUG+1PP1xjj6U/A139AFquQ1HR6rlYvmlENR6s+3SK7/ZCIkDWGEqE/QHchUd66FbdSVQVFiZau2jGRzWFCibFZ4B5+mO4h67mkyPatul1vOzE6sZFM1Rkxt//gN+EWCBH2O4BdKCt4NNVFrWlP7H5fLPRtnAoQ20hXvJhFK1uTYhWLznDVKR0+21YgjVPaxszPP3tPwZc0xaoxsg6qHLEXKYLEkC+YXUIvwNoWRh0Tpyr2+AD3OlYDsusr2HTa137YBDCG/YRG+ujTck3tDmFa7zZCyqoNcUN0fYG0zzLEcwZoGG+DlB7qGJc4YQmhR7e9PIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8yoyF68Bxn4Gfq3xAadWluBVti5y8fchFtvTFTU50I=;
 b=mMcy2oz+87k/t62GcSKYYOOz49EW73NJa2MEWagCNZvATVWqxu5Xx3vss7NXTHL52Ola2f76IPBPT/p0s24lyNFeQ2Cqt5CMLFR9TcApA8+NpntxdBheHwatKOc13LAhlZM+QtjCu5Stm04uHAUcIWjVFxT+DytlTQ4LcnF4YD4=
Received: from OL1P279CA0056.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::7) by
 AM6PR0602MB3509.eurprd06.prod.outlook.com (2603:10a6:209:5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Mon, 23 May
 2022 06:23:21 +0000
Received: from HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::16) by OL1P279CA0056.outlook.office365.com
 (2603:10a6:e10:15::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Mon, 23 May 2022 06:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT087.mail.protection.outlook.com (10.152.11.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 06:23:20 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: [PATCH V8 4/5] iio: accel: sca3300: Add support for SCL3300
Date:   Mon, 23 May 2022 06:23:11 +0000
Message-Id: <20220523062312.1401944-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85a062f6-38f2-4202-f263-08da3c84bbad
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3509:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0602MB3509F8A308293C432531CECAD7D49@AM6PR0602MB3509.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGpsH59m22onbtuweZl1oiEaP1fZ3e2UZRzqwJr4bj8JxsYuypg1YbeGkrFeEVmxwLX6GhPRReYylBIxhah2xsHnheVyAAtnl9JLbOThkEM1VeoPDHO9Be0hclKBaje7RwvthVs+yTXSuxdVt8Qf/JHWuT+YEgoEOe2CLeQVK2v+ffWLJi9qAh8ND/NlbF2ikHWVX9rDn38l1X6nJ+y4nPfd5z3Rf6Nwl7Ik+uxLV1qq5+7p729EDwdWrqb3k52sj6UENqeb5tEc2TZ2Xkkcid+aPXUY1fgChYjTuSx9tlhrcoyjvInHOqns8B5LjDJ0/O2VOUa3LYcirZw5vNP/1oNEbAVtCFS+ckjMaan0o/NCLnr1Ars1LMPcbuedSqQHsK0WFEu10qKCGPan1RPzGOC9bmojCw/SMGBO2mq0WJjtkOYqh+wioHlvpaG3XAsSwroxvXY9XAeQlJr0aWOtYzs+8EqQ6YelxqdA7qDQ11sQMVM1fJHjXWnHNERFzEQQFN/UUHtoS0IcUy2xQ2PCr7tT3+gUqERqGBVwh4lKd0xjQf0CgoOOXhhCYw9CHcDQLSSHSflAHaErmroohW7XmTP34j3+0V+hQpdvBre5rCdFYssunP0wzCioM2C3F9k69LtG87msSe6Y5rTV/28jWW2EmW95wMfz7SXNH9Bvv8dzvJGTOXH2Z1YuLl7Tc8ikQsrd9NQtAe+6kyTeYqUyvGf2clwb5IZY9y4r8xudicLZ5HUfgnYX2iXxSUkMKUzfJu7MUbrQJjMU3fqsSqx6sA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(81166007)(6486002)(5660300002)(36756003)(508600001)(70586007)(70206006)(82310400005)(356005)(4326008)(15974865002)(40460700003)(36736006)(26005)(36860700001)(8676002)(316002)(86362001)(186003)(336012)(956004)(2616005)(1076003)(47076005)(118246002)(83380400001)(8936002)(6506007)(6666004)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:23:20.3758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a062f6-38f2-4202-f263-08da3c84bbad
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0602MB3509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
Same as SCA3300, it has the accelerometer and temperature output.

Datasheet: www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 6463d12a9ab9..74e780a7ffcd 100644
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
@@ -159,6 +168,21 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 		.num_avail_modes = 4,
 		.chip_id = SCA3300_WHOAMI_ID,
 	},
+	{
+		.name = "scl3300",
+		.scan_masks = sca3300_scan_masks,
+		.channels = sca3300_channels,
+		.num_channels = ARRAY_SIZE(sca3300_channels),
+		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
+		.accel_scale = scl3300_accel_scale,
+		.accel_scale_map = scl3300_accel_scale_map,
+		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
+		.freq_table = scl3300_lp_freq,
+		.freq_map = scl3300_lp_freq_map,
+		.avail_modes_table = scl3300_avail_modes_map,
+		.num_avail_modes = 3,
+		.chip_id = SCL3300_WHOAMI_ID,
+	},
 };
 
 DECLARE_CRC8_TABLE(sca3300_crc_table);
@@ -443,9 +467,11 @@ static int sca3300_init(struct sca3300_data *sca_data,
 
 	/*
 	 * Wait 1ms after SW-reset command.
-	 * Wait 15ms for settling of signal paths.
+	 * Wait for the settling of signal paths,
+	 * 15ms for SCA3300 and 25ms for SCL3300,
+	 * take the max of the then.
 	 */
-	usleep_range(16e3, 50e3);
+	usleep_range(26e3, 50e3);
 
 	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
 	if (ret)
@@ -572,6 +598,7 @@ static int sca3300_probe(struct spi_device *spi)
 
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
+	{ .compatible = "murata,scl3300"},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
-- 
2.25.1

