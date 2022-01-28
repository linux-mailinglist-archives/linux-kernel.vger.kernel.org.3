Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132A849F98E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348543AbiA1MiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:38:14 -0500
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:24289
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234635AbiA1MiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:38:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzw7eS3n94rooPBx5pH6jcFRJqUqOiKa8wrfbDeVT6TPc91w6jDBjGSaxy0vbSK6N/lALa00fnYSFIQL6b0rTYQNQEgZoygTxAVmXGdYBFfVgrH3mfbXRxScKW60UVbdh2KXI7qHDR1Xqfv0tTFyE8Ezw8I92FpOZr7A2xsxS7QwJcfDYXIsQdSm7bbZnBrjh1Lj8euR8ck0HlTrXLtjJDOv2UvvRzUcNfkyjmIzpexlim55YndcwdD79l4xXvjGRQOAbTaH5PQKlODciWXZsGJbxIt0q79JRUsFNbGIfUHC2r0ipoa5WcHOfC+iBb+NwN9v7hRjfcQUDxiDbAGSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxD2vp+rDjB1B8hxzC4KWJ4rcJQg7ZteIxL1I5AFiY0=;
 b=JpEDaUtSDA29AgPoJe7YO8eRG9fjQMYEUwpKwBbofL/ZC7jsZzgMTUcg+Ck0lYoEeTeWrMjGhEOXN+fFYUixoo3t046s43W9SWj5p6d5muWZ/Ig6YVDpo6JHBkT9mu1Onj21/05M4Hi3oROeu0KjnFRmP2t3/YxnUCJmojwohgOHe9TT1ei2AViAEySS/QpBhxawsjHCmoVfSvMdGWvcmQKqOCO0VY6As4V/xkdJ5bNe7PDwimC6YgVjhDZAGOpGMAmvl6jQD8fzhfSQHMRY0oj9WOfLzrgOYg/qefzU0RPx5hjREaJra8KpXmQBiqfqitZWOZw6O4kKSfBEHDjYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxD2vp+rDjB1B8hxzC4KWJ4rcJQg7ZteIxL1I5AFiY0=;
 b=livad7Ife335fM2aNafUtTAHOeL8BRRNNT1PcaeyjxFPcOEHnCLSjSVhw0l0um/d6C2NGyTSORLjnwr2f+ZA4Mnj7aDJWx4L8z1wJ4F7YeRj42VPyVKVe8bMxpI/yk9eaDCcs3Gtco9pGL5F29alT1iwrocVKZDl0MLSewrlvi2JuUafKSdxtbmufTdZ3SDQwKJC5vIM23KSOCJO3OXOTxRXors7tyH8LPeKJLkAILf2NWSnLMyUDGLfwMCLVU67cmJmz+28gJPtTuifcibxWLqZMGCmbDDJ0YHlMNuluSI9k2uKnSIjcTo8NHtkCKhwx7tm6PxoUwjwJCyLRyBf0w==
Received: from BN8PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:94::38)
 by DM5PR12MB1562.namprd12.prod.outlook.com (2603:10b6:4:d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 12:38:11 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::3b) by BN8PR03CA0025.outlook.office365.com
 (2603:10b6:408:94::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 12:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 12:38:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Fri, 28 Jan 2022 12:38:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Fri, 28 Jan 2022 04:38:09 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 28 Jan 2022 04:38:06 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 1/5] ASoC: tegra: Update AHUB driver for Tegra234
Date:   Fri, 28 Jan 2022 18:07:52 +0530
Message-ID: <1643373476-8538-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
References: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb2cff0a-e29c-4eb6-0ca2-08d9e25b0b70
X-MS-TrafficTypeDiagnostic: DM5PR12MB1562:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB156253100A4D7156325129C5A7229@DM5PR12MB1562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C44YLiogoOcOh1NSQZowWTJfQsi1QS/DVqWJZBW/MBL0k7lMlnRwEFbG5KAoNPwlb53+pKDQGyPTZwOhYcZVE5P4BftVH02Jfp4DyU6T5Vn7A0iYAbIbYmWTtbSgKOwRnOeUWP3TwFFWTZCgx/ZOVC+IQdv1msYSASv76WEZO5VG04fUx39I+rA0coYh/TKBppnS0N330TYbtGxOOrO7AvzsPWl+Iy6Klui9w3zoUc9xPJH4TCoIuosRtOE3t3mMvfGgEC2a3pEGPJTVAbWmCjqmjMeHsgHaZijjmOmzFcRvdJnwS66dkX13VN/x3D65f4WjWmgpITmTb58RMjKOyBW+L0P7wFOn5Y6VpEBQVpcXcwDYmjbWuO7Jzi5l5/iUINZjsx1GHSIFtCD6Ipyp+r0/k7h2Vneou5hZrlxHkXGp8aiyRqY1fXM9dVJOmIrasBAScEPUQ7CqGHmNXGmh5+lvjRxYTk/DrsaKnren2un4g9RWzMZPOGoTmGv6xiVNr2pQNcLuAEzgVypfLeunTWKPjaTpusHMGfXjruGtYJYD67EPXo7mbSbqpCYvwPgWftFq92Ljzyrx1sFNET/s2vVlyYB1j8NVtzy5+2sTvDggiq822nn/eTALJjXdwv1UEpzAqvrnl0EclJ2L5fWRXVUr/C0ni3Cx+ydnO8d3uwltWVDkkZyITFG6Ul6SjamLAvkm3KumZhrdqisqpTGyuA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(356005)(82310400004)(86362001)(4326008)(508600001)(7696005)(6666004)(40460700003)(110136005)(316002)(54906003)(2616005)(70206006)(70586007)(8936002)(8676002)(36860700001)(7416002)(107886003)(426003)(336012)(186003)(26005)(5660300002)(47076005)(83380400001)(36756003)(2906002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 12:38:10.9711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2cff0a-e29c-4eb6-0ca2-08d9e25b0b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1562
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohan Kumar <mkumard@nvidia.com>

The register offsets of switches connecting various AHUB internal
modules have changed from previous chip. Address this variation by
making use of Tegra234 based compatible.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_ahub.c | 146 +++++++++++++++++++++++++++++++++++++++-
 sound/soc/tegra/tegra210_ahub.h |   4 +-
 2 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index 388b815..bccf8b8 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -2,7 +2,7 @@
 //
 // tegra210_ahub.c - Tegra210 AHUB driver
 //
-// Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2020-2022, NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -624,6 +624,34 @@ MUX_ENUM_CTRL_DECL_186(t186_mixer18_tx, 0x27);
 MUX_ENUM_CTRL_DECL_186(t186_mixer19_tx, 0x28);
 MUX_ENUM_CTRL_DECL_186(t186_mixer110_tx, 0x29);
 
+/* Controls for t234 */
+MUX_ENUM_CTRL_DECL_234(t234_mvc1_tx, 0x44);
+MUX_ENUM_CTRL_DECL_234(t234_mvc2_tx, 0x45);
+MUX_ENUM_CTRL_DECL_234(t234_amx11_tx, 0x48);
+MUX_ENUM_CTRL_DECL_234(t234_amx12_tx, 0x49);
+MUX_ENUM_CTRL_DECL_234(t234_amx13_tx, 0x4a);
+MUX_ENUM_CTRL_DECL_234(t234_amx14_tx, 0x4b);
+MUX_ENUM_CTRL_DECL_234(t234_amx21_tx, 0x4c);
+MUX_ENUM_CTRL_DECL_234(t234_amx22_tx, 0x4d);
+MUX_ENUM_CTRL_DECL_234(t234_amx23_tx, 0x4e);
+MUX_ENUM_CTRL_DECL_234(t234_amx24_tx, 0x4f);
+MUX_ENUM_CTRL_DECL_234(t234_amx31_tx, 0x50);
+MUX_ENUM_CTRL_DECL_234(t234_amx32_tx, 0x51);
+MUX_ENUM_CTRL_DECL_234(t234_amx33_tx, 0x52);
+MUX_ENUM_CTRL_DECL_234(t234_amx34_tx, 0x53);
+MUX_ENUM_CTRL_DECL_234(t234_adx1_tx, 0x58);
+MUX_ENUM_CTRL_DECL_234(t234_adx2_tx, 0x59);
+MUX_ENUM_CTRL_DECL_234(t234_adx3_tx, 0x5a);
+MUX_ENUM_CTRL_DECL_234(t234_adx4_tx, 0x5b);
+MUX_ENUM_CTRL_DECL_234(t234_amx41_tx, 0x5c);
+MUX_ENUM_CTRL_DECL_234(t234_amx42_tx, 0x5d);
+MUX_ENUM_CTRL_DECL_234(t234_amx43_tx, 0x5e);
+MUX_ENUM_CTRL_DECL_234(t234_amx44_tx, 0x5f);
+MUX_ENUM_CTRL_DECL_234(t234_admaif17_tx, 0x60);
+MUX_ENUM_CTRL_DECL_234(t234_admaif18_tx, 0x61);
+MUX_ENUM_CTRL_DECL_234(t234_admaif19_tx, 0x62);
+MUX_ENUM_CTRL_DECL_234(t234_admaif20_tx, 0x63);
+
 /*
  * The number of entries in, and order of, this array is closely tied to the
  * calculation of tegra210_ahub_codec.num_dapm_widgets near the end of
@@ -787,6 +815,102 @@ static const struct snd_soc_dapm_widget tegra186_ahub_widgets[] = {
 	TX_WIDGETS("MIXER1 TX5"),
 };
 
+static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
+	WIDGETS("ADMAIF1", t186_admaif1_tx),
+	WIDGETS("ADMAIF2", t186_admaif2_tx),
+	WIDGETS("ADMAIF3", t186_admaif3_tx),
+	WIDGETS("ADMAIF4", t186_admaif4_tx),
+	WIDGETS("ADMAIF5", t186_admaif5_tx),
+	WIDGETS("ADMAIF6", t186_admaif6_tx),
+	WIDGETS("ADMAIF7", t186_admaif7_tx),
+	WIDGETS("ADMAIF8", t186_admaif8_tx),
+	WIDGETS("ADMAIF9", t186_admaif9_tx),
+	WIDGETS("ADMAIF10", t186_admaif10_tx),
+	WIDGETS("ADMAIF11", t186_admaif11_tx),
+	WIDGETS("ADMAIF12", t186_admaif12_tx),
+	WIDGETS("ADMAIF13", t186_admaif13_tx),
+	WIDGETS("ADMAIF14", t186_admaif14_tx),
+	WIDGETS("ADMAIF15", t186_admaif15_tx),
+	WIDGETS("ADMAIF16", t186_admaif16_tx),
+	WIDGETS("ADMAIF17", t234_admaif17_tx),
+	WIDGETS("ADMAIF18", t234_admaif18_tx),
+	WIDGETS("ADMAIF19", t234_admaif19_tx),
+	WIDGETS("ADMAIF20", t234_admaif20_tx),
+	WIDGETS("I2S1", t186_i2s1_tx),
+	WIDGETS("I2S2", t186_i2s2_tx),
+	WIDGETS("I2S3", t186_i2s3_tx),
+	WIDGETS("I2S4", t186_i2s4_tx),
+	WIDGETS("I2S5", t186_i2s5_tx),
+	WIDGETS("I2S6", t186_i2s6_tx),
+	TX_WIDGETS("DMIC1"),
+	TX_WIDGETS("DMIC2"),
+	TX_WIDGETS("DMIC3"),
+	TX_WIDGETS("DMIC4"),
+	WIDGETS("DSPK1", t186_dspk1_tx),
+	WIDGETS("DSPK2", t186_dspk2_tx),
+	WIDGETS("SFC1", t186_sfc1_tx),
+	WIDGETS("SFC2", t186_sfc2_tx),
+	WIDGETS("SFC3", t186_sfc3_tx),
+	WIDGETS("SFC4", t186_sfc4_tx),
+	WIDGETS("MVC1", t234_mvc1_tx),
+	WIDGETS("MVC2", t234_mvc2_tx),
+	WIDGETS("AMX1 RX1", t234_amx11_tx),
+	WIDGETS("AMX1 RX2", t234_amx12_tx),
+	WIDGETS("AMX1 RX3", t234_amx13_tx),
+	WIDGETS("AMX1 RX4", t234_amx14_tx),
+	WIDGETS("AMX2 RX1", t234_amx21_tx),
+	WIDGETS("AMX2 RX2", t234_amx22_tx),
+	WIDGETS("AMX2 RX3", t234_amx23_tx),
+	WIDGETS("AMX2 RX4", t234_amx24_tx),
+	WIDGETS("AMX3 RX1", t234_amx31_tx),
+	WIDGETS("AMX3 RX2", t234_amx32_tx),
+	WIDGETS("AMX3 RX3", t234_amx33_tx),
+	WIDGETS("AMX3 RX4", t234_amx34_tx),
+	WIDGETS("AMX4 RX1", t234_amx41_tx),
+	WIDGETS("AMX4 RX2", t234_amx42_tx),
+	WIDGETS("AMX4 RX3", t234_amx43_tx),
+	WIDGETS("AMX4 RX4", t234_amx44_tx),
+	TX_WIDGETS("AMX1"),
+	TX_WIDGETS("AMX2"),
+	TX_WIDGETS("AMX3"),
+	TX_WIDGETS("AMX4"),
+	WIDGETS("ADX1", t234_adx1_tx),
+	WIDGETS("ADX2", t234_adx2_tx),
+	WIDGETS("ADX3", t234_adx3_tx),
+	WIDGETS("ADX4", t234_adx4_tx),
+	TX_WIDGETS("ADX1 TX1"),
+	TX_WIDGETS("ADX1 TX2"),
+	TX_WIDGETS("ADX1 TX3"),
+	TX_WIDGETS("ADX1 TX4"),
+	TX_WIDGETS("ADX2 TX1"),
+	TX_WIDGETS("ADX2 TX2"),
+	TX_WIDGETS("ADX2 TX3"),
+	TX_WIDGETS("ADX2 TX4"),
+	TX_WIDGETS("ADX3 TX1"),
+	TX_WIDGETS("ADX3 TX2"),
+	TX_WIDGETS("ADX3 TX3"),
+	TX_WIDGETS("ADX3 TX4"),
+	TX_WIDGETS("ADX4 TX1"),
+	TX_WIDGETS("ADX4 TX2"),
+	TX_WIDGETS("ADX4 TX3"),
+	TX_WIDGETS("ADX4 TX4"),
+	WIDGETS("MIXER1 RX1", t186_mixer11_tx),
+	WIDGETS("MIXER1 RX2", t186_mixer12_tx),
+	WIDGETS("MIXER1 RX3", t186_mixer13_tx),
+	WIDGETS("MIXER1 RX4", t186_mixer14_tx),
+	WIDGETS("MIXER1 RX5", t186_mixer15_tx),
+	WIDGETS("MIXER1 RX6", t186_mixer16_tx),
+	WIDGETS("MIXER1 RX7", t186_mixer17_tx),
+	WIDGETS("MIXER1 RX8", t186_mixer18_tx),
+	WIDGETS("MIXER1 RX9", t186_mixer19_tx),
+	WIDGETS("MIXER1 RX10", t186_mixer110_tx),
+	TX_WIDGETS("MIXER1 TX1"),
+	TX_WIDGETS("MIXER1 TX2"),
+	TX_WIDGETS("MIXER1 TX3"),
+	TX_WIDGETS("MIXER1 TX4"),
+	TX_WIDGETS("MIXER1 TX5"),
+};
+
 #define TEGRA_COMMON_MUX_ROUTES(name)					\
 	{ name " XBAR-TX",	 NULL,		name " Mux" },		\
 	{ name " Mux",		"ADMAIF1",	"ADMAIF1 XBAR-RX" },	\
@@ -1027,6 +1151,13 @@ static const struct snd_soc_component_driver tegra186_ahub_component = {
 	.num_dapm_routes = ARRAY_SIZE(tegra186_ahub_routes),
 };
 
+static const struct snd_soc_component_driver tegra234_ahub_component = {
+	.dapm_widgets		= tegra234_ahub_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tegra234_ahub_widgets),
+	.dapm_routes		= tegra186_ahub_routes,
+	.num_dapm_routes	= ARRAY_SIZE(tegra186_ahub_routes),
+};
+
 static const struct regmap_config tegra210_ahub_regmap_config = {
 	.reg_bits		= 32,
 	.val_bits		= 32,
@@ -1067,9 +1198,22 @@ static const struct tegra_ahub_soc_data soc_data_tegra186 = {
 	.reg_count	= TEGRA186_XBAR_UPDATE_MAX_REG,
 };
 
+static const struct tegra_ahub_soc_data soc_data_tegra234 = {
+	.cmpnt_drv	= &tegra234_ahub_component,
+	.dai_drv	= tegra186_ahub_dais,
+	.num_dais	= ARRAY_SIZE(tegra186_ahub_dais),
+	.regmap_config	= &tegra186_ahub_regmap_config,
+	.mask[0]	= TEGRA186_XBAR_REG_MASK_0,
+	.mask[1]	= TEGRA186_XBAR_REG_MASK_1,
+	.mask[2]	= TEGRA186_XBAR_REG_MASK_2,
+	.mask[3]	= TEGRA186_XBAR_REG_MASK_3,
+	.reg_count	= TEGRA186_XBAR_UPDATE_MAX_REG,
+};
+
 static const struct of_device_id tegra_ahub_of_match[] = {
 	{ .compatible = "nvidia,tegra210-ahub", .data = &soc_data_tegra210 },
 	{ .compatible = "nvidia,tegra186-ahub", .data = &soc_data_tegra186 },
+	{ .compatible = "nvidia,tegra234-ahub", .data = &soc_data_tegra234 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tegra_ahub_of_match);
diff --git a/sound/soc/tegra/tegra210_ahub.h b/sound/soc/tegra/tegra210_ahub.h
index 47802bbe..2728db4 100644
--- a/sound/soc/tegra/tegra210_ahub.h
+++ b/sound/soc/tegra/tegra210_ahub.h
@@ -2,7 +2,7 @@
 /*
  * tegra210_ahub.h - TEGRA210 AHUB
  *
- * Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2020-2022, NVIDIA CORPORATION.  All rights reserved.
  *
  */
 
@@ -74,6 +74,8 @@
 				  tegra_ahub_get_value_enum,		\
 				  tegra_ahub_put_value_enum)
 
+#define MUX_ENUM_CTRL_DECL_234(ename, id) MUX_ENUM_CTRL_DECL_186(ename, id)
+
 #define WIDGETS(sname, ename)						     \
 	SND_SOC_DAPM_AIF_IN(sname " XBAR-RX", NULL, 0, SND_SOC_NOPM, 0, 0),  \
 	SND_SOC_DAPM_AIF_OUT(sname " XBAR-TX", NULL, 0, SND_SOC_NOPM, 0, 0), \
-- 
2.7.4

