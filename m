Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABF4B993B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiBQG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:27:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBQG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:30 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145021FC7C;
        Wed, 16 Feb 2022 22:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mER4DnPgdLfJsMTCC3ZybvF3dkkXuLslaSJpHuvuiBXt+2yirToGxuyjLxHdPz26T0AHVEu+Qnbcq94xZUuBP3rc7WIXnJc2Oq/r0D1a4WR0Aw3u1GYNe43ZO1iVb4irAbVzaWLls13M6ddI1F9gP8JmIpKA1k8G1cphA4ngQfRocqOS/Ui9v567u1Vj2BGRY/hsMf9nWKWOuxJmCQiO5W9Bz6jaZUnIDuKRD2JoCWd7S0y0H0UpdHJtzIT3RA+XJiZHvedsGfCWCK00by+vCv5rlVj2sSMTurcnwrjM15lUWeQDLDpLDM67fk5LoH1zhgkdKI4k5cNBx7c0PyX95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ijaw5tV938xk33WOJJS+JUKjmLcWtbs1VPS+aMEqCU=;
 b=TU5qjJ2hFB7ob8vdvGeNMM8/FpSOPPBpRWb5+e6AsyjXZ2Pw/Q4OEQ84El0npddtFSVkT8yKrMRpTJkdSR7mxvS8ZxQAZGNXozWvMkAQQymGQjferIUkszUVqagXSZXfa1lurzJHJRvp9s8kQzfTBUb57v2ckpIW68RdeqWX1PNvlmayiLdY7vMQ3EFHI8EZkjFrRl8zCchpPFCCtSUIZdr/kDJSNPs2onkMPEykut3QoAgWbBtOonFs4B6RMOSud6hII0C3XbpLfVIJCc9cax44ujm/UiGo5ST3Bfr1kbvuY+Q4BVNsr+uKJk8Mil0QSh+qpJ4a4CcH+9hGPPSaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ijaw5tV938xk33WOJJS+JUKjmLcWtbs1VPS+aMEqCU=;
 b=l5E9co6WttKRCTZhGyaJXxuyJkzXH4jxt99WfzMKMILzaojSR48V1NkwcxWKJ0g5U3K8Vj/NGkqwo3c0VTHZvW/+jf1DuUEZHbS7ij1jZW/2mguW35gLpA4yDPJwTLp2ht1b7FYOpj3YdME3rB8OrBNA8eQhno3xarbJ3nulRcI=
Received: from AM6P192CA0092.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::33)
 by AS4PR06MB8565.eurprd06.prod.outlook.com (2603:10a6:20b:4e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 06:27:12 +0000
Received: from AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::d7) by AM6P192CA0092.outlook.office365.com
 (2603:10a6:209:8d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Thu, 17 Feb 2022 06:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT043.mail.protection.outlook.com (10.152.9.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 06:27:11 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: [PATCH V2 5/5] iio: accel: sca3300: Add inclination channels.
Date:   Thu, 17 Feb 2022 06:27:05 +0000
Message-Id: <20220217062705.2867149-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c46dc0a-69b6-4393-936a-08d9f1de883a
X-MS-TrafficTypeDiagnostic: AS4PR06MB8565:EE_
X-Microsoft-Antispam-PRVS: <AS4PR06MB85651E89E77D66FB28086902D7369@AS4PR06MB8565.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /C7+WLJFXVDfQW+1ViBWoFpaDBNbuR4biLBX2byoREbVqirQwodhefJlrRzf62T9w9wNhk4FJnReqeXuoQcbNxASkOS/rZWqXDls/54XwwJ0cmIVgf6JOcL1Ir2LpIvSOVF+3xIOBfW8NajDwg5yrzhjYUOuVrP4NcigZxuKdJ9+6nRlySAOIx1JQqfLtu/vCh+8oCBAuLTHO8FzqYwP5A9Q5nHEvpPbfudQZeo5lw1IDD3ASn4b6n6IJXY9pgtE7e1T8ST9TYbJ/tpehrFfQPt6zJCgVyNVGYfmw4CHTtWhZe+xK/7VAnX3xnLNcPgnuCUuoELg4W2mIzR1TPvSBfAdv9RyAmQ9bhnNkmMrIxERb3j+K2QykVUacWLgWaEYG9PC6IskADXxPK/UZvkTVTp9yyhJIipiibClOQ3IumY3iPqbXqbPUVPZIU5e/9DiIY+Y+tIIzC2r2VOGuZzpurYP1oleSCjgnoV5yjXKQJc57GokS+lOmPR6sCxjwVSaWeWX0psuqP1LxlzJgR+rcsXaLQlqvuLvfqzAmkx/W7oCLkvwxH/yfMfZ9y5IiQPp751Doqq5oxnjAAB35p9ChqleMla0TjI9MhZVaN1oLcQHjVKR+o+I5SL+SECAsoFlRgV8p6QdShfdsSq7CUCo6idEmFjQDVrbxL33dh4WmbQiHRzyFNqbKRJ7so/Iorj+
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(956004)(2616005)(5660300002)(8676002)(36860700001)(70586007)(86362001)(6666004)(107886003)(6512007)(6486002)(26005)(186003)(6506007)(36756003)(1076003)(336012)(118246002)(508600001)(40460700003)(2906002)(4326008)(36736006)(356005)(47076005)(82310400004)(70206006)(316002)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 06:27:11.7674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c46dc0a-69b6-4393-936a-08d9f1de883a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR06MB8565
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different with SCA3300, SCL3300 can output inclination angles.
Angles are formed from acceleration with following equations:
ANG_X = atan2(accx / √(accy^2 + accz^2)),
ANG_Y = atan2(accy / √(accx^2 + accz^2)),
ANG_Z = atan2(accz / √(accx^2 + accy^2)),

The commit add output of the raw value,scale
and scale_available of angles.

New interfaces:
  in_incli_scale
  in_incli_scale_available
  in_incli_x_raw
  in_incli_y_raw
  in_incli_z_raw

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 123ab9a784d2..5c86b143d17a 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -64,6 +64,9 @@ enum sca3300_scan_indexes {
 	SCA3300_ACC_Y,
 	SCA3300_ACC_Z,
 	SCA3300_TEMP,
+	SCA3300_INCLI_X,
+	SCA3300_INCLI_Y,
+	SCA3300_INCLI_Z,
 	SCA3300_TIMESTAMP,
 };
 
@@ -88,6 +91,24 @@ enum sca3300_scan_indexes {
 	},								\
 }
 
+#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
+	.type = IIO_INCLI,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type_available =				\
+	BIT(IIO_CHAN_INFO_SCALE),					\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
 #define SCA3300_TEMP_CHANNEL(index, reg) {				\
 		.type = IIO_TEMP,					\
 		.address = reg,						\
@@ -115,6 +136,9 @@ static const struct iio_chan_spec scl3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
 	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
+	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
 	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
 };
 
@@ -124,17 +148,28 @@ static const int scl3300_lp_freq_table[] = {40, 70, 10, 10};
 static const int sca3300_accel_scale_table[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
 static const int scl3300_accel_scale_table[][2] = {{0, 167}, {0, 333}, {0, 83}, {0, 83}};
 
+static const int scl3300_incli_scale_table[][2] = {{0, 5495}, {0, 5495}, {0, 5495}, {0, 5495}};
+
 static const unsigned long sca3300_scan_masks[] = {
 	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
 	BIT(SCA3300_TEMP),
 	0,
 };
 
+static const unsigned long scl3300_scan_masks[] = {
+	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
+	BIT(SCA3300_TEMP)  |
+	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
+	0,
+};
+
 struct sca3300_chip_info {
 	const struct iio_chan_spec *channels;
 	enum sca3300_chip_type chip_type;
 	const int (*accel_scale_table)[2];
+	const int (*incli_scale_table)[2];
 	unsigned int num_accel_scales;
+	unsigned int num_incli_scales;
 	unsigned long scan_masks;
 	unsigned int num_freqs;
 	const int *freq_table;
@@ -172,14 +207,18 @@ static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
 		.scan_masks = sca3300_scan_masks,
 		.channels = sca3300_channels,
 		.chip_type = CHIP_SCA3300,
+		.incli_scale_table = NULL,
+		.num_incli_scales = 0,
 		.name = "sca3300",
 		.chip_id = 0x51,
 		.num_freqs = 2,
 	},
 	[CHIP_SCL3300] = {
 		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale_table)*2-1,
+		.num_incli_scales = ARRAY_SIZE(scl3300_lp_freq_table)-1,
 		.num_channels = ARRAY_SIZE(scl3300_channels),
 		.accel_scale_table = scl3300_accel_scale_table,
+		.incli_scale_table = scl3300_incli_scale_table,
 		.freq_table = scl3300_lp_freq_table,
 		.scan_masks = sca3300_scan_masks,
 		.channels = scl3300_channels,
@@ -378,6 +417,10 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		switch (chan->type) {
+		case IIO_INCLI:
+			*val =  data->chip_info->incli_scale_table[reg_val][0];
+			*val2 = data->chip_info->incli_scale_table[reg_val][1];
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			*val =  data->chip_info->accel_scale_table[reg_val][0];
 			*val2 = data->chip_info->accel_scale_table[reg_val][1];
@@ -507,6 +550,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
+		case IIO_INCLI:
+			*vals = (const int *)data->chip_info->incli_scale_table;
+			*length = data->chip_info->num_incli_scales;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
 		case IIO_ACCEL:
 			*vals = (const int *)data->chip_info->accel_scale_table;
 			*length = data->chip_info->num_accel_scales;
-- 
2.25.1

