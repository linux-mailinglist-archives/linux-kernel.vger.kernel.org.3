Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7932F4EDB16
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiCaOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiCaOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:05:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83D5AA75;
        Thu, 31 Mar 2022 07:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+gtsZ5YGpw1gGupQ1wUWdoHUoL863TOTXdAhY8FH3YHskjeWC2CIYQnFaNfjpyL0OddOvwfnHtj+GPwEXTWm7vNOlRAYDmUVfroExVkIVCVRSJgeh4Jo85hfMKxpu1EuJ53B2H21VwgbZEgt+ltasDAIb8yAKGkFc6ScJCxmJIstgmfV3rogRy0om2PfGs8DrYLOh6PxEdpTWn6sQLKciydFX4K9DSVvmH8zfYP4qeikhSKK/V2w/ekiyx1qVvdRbecIb37PelzuOhAcdgnl36tV7WXILMITY7gaO1IDchgR8efq2MJdRoLgaFQhO3+72UZB1uMnDZfhgwDkwGJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe5SYG1TP+sQ5em8T8L2BI8X1qzj8arzo+ME4eAewaQ=;
 b=JcXSlxO/th6V0hwnOFJqMEG/xvI+FIwcXNSWXkAIq0lHhhye8r9lP/h/h2X3oHknQYQ2iwm9CvHoNyUTBJ5xBtmVlko/Bh4IfadTvoBb/SXpGlLDRbgzMs7FLHHGaiYlToEb0bI9wAWc6oHO17IuvvrZP3qeCfQyX5kx4tYKVT51x8NOeWxZajyvZsIhCB0WUPi3ewMPCTDkXRl+GvHfQ42T4d6NwpGYlmMhNYkbuMTpaXNLD+KLR/v/fZ5B0QTU0IF5PSRPKAuGntdH/tdtlJh7ykC78EgAMdBctnSARAMgqy6vANUIDHIyhzBuoskU1GiZ6lnxobLwW0NuXWqh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe5SYG1TP+sQ5em8T8L2BI8X1qzj8arzo+ME4eAewaQ=;
 b=U4Fgarmua9onLPkBCS4rprkuh2BEOWD7t2Kbrr43c0Fa8rsZK3s4NbQG+EzQ2nOPEhzC7WVXFRhxKbhPJYQLQE0ukDtfOBHZS4VHXRFuRUR2otjKtqeDSCyw6KKiYIHozOQ12Nn9zYYesRHg4WySzgMf2LRv9IjedLtUVk0QBjZ3ksW9DtqCkDro+zo/QmT/h2rjxI2sLD0Elc0CgVwXBJPlqhGu5y8nwTKdmQ5w8VYNwwIPgc/kqf9dCXrHn1cDyjRCN5vs0pmGiJzZ+xZ/DO3OqiObd/Evf3UIHDMjMUzhUCcbfk+JgIj+UeICm0ihIFvoYoJyxxjFn5aWnTbafg==
Received: from BN0PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:143::35)
 by MN2PR12MB3390.namprd12.prod.outlook.com (2603:10b6:208:c9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 14:04:01 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::25) by BN0PR10CA0003.outlook.office365.com
 (2603:10b6:408:143::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 14:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 14:04:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 31 Mar
 2022 14:03:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 07:03:58 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 31 Mar
 2022 07:03:54 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 3/6] ASoC: tegra: AHUB routes for ASRC module
Date:   Thu, 31 Mar 2022 19:33:29 +0530
Message-ID: <1648735412-32220-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
References: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7ca5e4-bf88-4dab-6e75-08da131f4e49
X-MS-TrafficTypeDiagnostic: MN2PR12MB3390:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33908CC5714D3A776A7D2FBBA7E19@MN2PR12MB3390.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPSeKvBTeif/6/P9ODdGOUV3u4IzXLqFc4uZSFxhiC/qwpTzrZJe6CFwZcYRSFmZDvsrW1X6EElws27/Vzkc1mtj7DwuYG/j+6CXol5SYOvCPvHtNcAXNRmw7sLpO23mty8QTc+6NLX1+nVyqYfvgWnPWOvWbOpCkTN8/AO6hyGU9j/VW6Z6G7mjykInASemi4zhLrNoOgR/K6YO5tnxhsxy3iAsdsxPams2WAo6W+YN2dBe/YPYlFYssi+wG5ZjbMtT3IRNOFfdynCqltet53lTWVpiY6S+HNP45yD8fzaHQEOJbqk1R+NV7nHpcYttWCLb7fjxeKdRFdmXfClQ8qtRVCfaugXbYVRtd3/gskWRGIoSvpmcmIsFekYl+3Cm9neKADePodYy2/4e15k9pvbYE3bl1fI9jVYaJ494vyDSIRX6ROiCPehq+w7GVx0KNqOZgI0C6JNjUYaUAPQA70j2ysDB4p1qc9jk/vg6jbe829WcbMsviID352JCNHen6bn6Jrgb1skmA2uTwVA8L3lzeJOqSMQxciYH0VOxkD9ByGXdbV0MbZv7Qszyhy/tCTYFL+9D/RmFkDmCYWLpf/y9vmhMuJE/ioVRPurOhxdlMgWwx+Gb5BSMgP8HmY77jX28MSxxil5y0rmfemvj4tW9F5gQfdWvR8LU/KR8DwiVJ5FiDWR5GC6c3zfaJcE8LBJpgifD6Ujo1heUuPxHWQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(36756003)(6666004)(356005)(7696005)(5660300002)(508600001)(110136005)(7416002)(8936002)(2616005)(2906002)(54906003)(40460700003)(36860700001)(186003)(82310400004)(4326008)(8676002)(86362001)(26005)(47076005)(316002)(426003)(336012)(107886003)(83380400001)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:04:00.2976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7ca5e4-bf88-4dab-6e75-08da131f4e49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3390
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AHUB routes for ASRC module. The ASRC module can be plugged into audio
path as per the need. The routing controls can be used to setup the audio
path with ASRC similar to the already existing routes. The routes are added
to Tegra186 and later Tegra SoCs where ASRC module is present.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_ahub.c | 82 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index bccf8b8..e1f90da 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -280,6 +280,20 @@ static struct snd_soc_dai_driver tegra186_ahub_dais[] = {
 	DAI(MIXER1 TX3),
 	DAI(MIXER1 TX4),
 	DAI(MIXER1 TX5),
+	/* XBAR -> ASRC -> XBAR */
+	DAI(ASRC1 RX1),
+	DAI(ASRC1 TX1),
+	DAI(ASRC1 RX2),
+	DAI(ASRC1 TX2),
+	DAI(ASRC1 RX3),
+	DAI(ASRC1 TX3),
+	DAI(ASRC1 RX4),
+	DAI(ASRC1 TX4),
+	DAI(ASRC1 RX5),
+	DAI(ASRC1 TX5),
+	DAI(ASRC1 RX6),
+	DAI(ASRC1 TX6),
+	DAI(ASRC1 RX7),
 };
 
 static const char * const tegra210_ahub_mux_texts[] = {
@@ -388,6 +402,12 @@ static const char * const tegra186_ahub_mux_texts[] = {
 	"MIXER1 TX3",
 	"MIXER1 TX4",
 	"MIXER1 TX5",
+	"ASRC1 TX1",
+	"ASRC1 TX2",
+	"ASRC1 TX3",
+	"ASRC1 TX4",
+	"ASRC1 TX5",
+	"ASRC1 TX6",
 };
 
 static const unsigned int tegra210_ahub_mux_values[] = {
@@ -513,6 +533,13 @@ static const unsigned int tegra186_ahub_mux_values[] = {
 	MUX_VALUE(1, 2),
 	MUX_VALUE(1, 3),
 	MUX_VALUE(1, 4),
+	/* ASRC */
+	MUX_VALUE(3, 24),
+	MUX_VALUE(3, 25),
+	MUX_VALUE(3, 26),
+	MUX_VALUE(3, 27),
+	MUX_VALUE(3, 28),
+	MUX_VALUE(3, 29),
 };
 
 /* Controls for t210 */
@@ -623,6 +650,13 @@ MUX_ENUM_CTRL_DECL_186(t186_mixer17_tx, 0x26);
 MUX_ENUM_CTRL_DECL_186(t186_mixer18_tx, 0x27);
 MUX_ENUM_CTRL_DECL_186(t186_mixer19_tx, 0x28);
 MUX_ENUM_CTRL_DECL_186(t186_mixer110_tx, 0x29);
+MUX_ENUM_CTRL_DECL_186(t186_asrc11_tx, 0x6c);
+MUX_ENUM_CTRL_DECL_186(t186_asrc12_tx, 0x6d);
+MUX_ENUM_CTRL_DECL_186(t186_asrc13_tx, 0x6e);
+MUX_ENUM_CTRL_DECL_186(t186_asrc14_tx, 0x6f);
+MUX_ENUM_CTRL_DECL_186(t186_asrc15_tx, 0x70);
+MUX_ENUM_CTRL_DECL_186(t186_asrc16_tx, 0x71);
+MUX_ENUM_CTRL_DECL_186(t186_asrc17_tx, 0x72);
 
 /* Controls for t234 */
 MUX_ENUM_CTRL_DECL_234(t234_mvc1_tx, 0x44);
@@ -651,6 +685,13 @@ MUX_ENUM_CTRL_DECL_234(t234_admaif17_tx, 0x60);
 MUX_ENUM_CTRL_DECL_234(t234_admaif18_tx, 0x61);
 MUX_ENUM_CTRL_DECL_234(t234_admaif19_tx, 0x62);
 MUX_ENUM_CTRL_DECL_234(t234_admaif20_tx, 0x63);
+MUX_ENUM_CTRL_DECL_234(t234_asrc11_tx, 0x64);
+MUX_ENUM_CTRL_DECL_234(t234_asrc12_tx, 0x65);
+MUX_ENUM_CTRL_DECL_234(t234_asrc13_tx, 0x66);
+MUX_ENUM_CTRL_DECL_234(t234_asrc14_tx, 0x67);
+MUX_ENUM_CTRL_DECL_234(t234_asrc15_tx, 0x68);
+MUX_ENUM_CTRL_DECL_234(t234_asrc16_tx, 0x69);
+MUX_ENUM_CTRL_DECL_234(t234_asrc17_tx, 0x6a);
 
 /*
  * The number of entries in, and order of, this array is closely tied to the
@@ -813,6 +854,19 @@ static const struct snd_soc_dapm_widget tegra186_ahub_widgets[] = {
 	TX_WIDGETS("MIXER1 TX3"),
 	TX_WIDGETS("MIXER1 TX4"),
 	TX_WIDGETS("MIXER1 TX5"),
+	WIDGETS("ASRC1 RX1", t186_asrc11_tx),
+	WIDGETS("ASRC1 RX2", t186_asrc12_tx),
+	WIDGETS("ASRC1 RX3", t186_asrc13_tx),
+	WIDGETS("ASRC1 RX4", t186_asrc14_tx),
+	WIDGETS("ASRC1 RX5", t186_asrc15_tx),
+	WIDGETS("ASRC1 RX6", t186_asrc16_tx),
+	WIDGETS("ASRC1 RX7", t186_asrc17_tx),
+	TX_WIDGETS("ASRC1 TX1"),
+	TX_WIDGETS("ASRC1 TX2"),
+	TX_WIDGETS("ASRC1 TX3"),
+	TX_WIDGETS("ASRC1 TX4"),
+	TX_WIDGETS("ASRC1 TX5"),
+	TX_WIDGETS("ASRC1 TX6"),
 };
 
 static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
@@ -909,6 +963,19 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
 	TX_WIDGETS("MIXER1 TX3"),
 	TX_WIDGETS("MIXER1 TX4"),
 	TX_WIDGETS("MIXER1 TX5"),
+	WIDGETS("ASRC1 RX1", t234_asrc11_tx),
+	WIDGETS("ASRC1 RX2", t234_asrc12_tx),
+	WIDGETS("ASRC1 RX3", t234_asrc13_tx),
+	WIDGETS("ASRC1 RX4", t234_asrc14_tx),
+	WIDGETS("ASRC1 RX5", t234_asrc15_tx),
+	WIDGETS("ASRC1 RX6", t234_asrc16_tx),
+	WIDGETS("ASRC1 RX7", t234_asrc17_tx),
+	TX_WIDGETS("ASRC1 TX1"),
+	TX_WIDGETS("ASRC1 TX2"),
+	TX_WIDGETS("ASRC1 TX3"),
+	TX_WIDGETS("ASRC1 TX4"),
+	TX_WIDGETS("ASRC1 TX5"),
+	TX_WIDGETS("ASRC1 TX6"),
 };
 
 #define TEGRA_COMMON_MUX_ROUTES(name)					\
@@ -975,7 +1042,13 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
 	{ name " Mux",		"ADX4 TX1",	"ADX4 TX1 XBAR-RX" },	\
 	{ name " Mux",		"ADX4 TX2",	"ADX4 TX2 XBAR-RX" },	\
 	{ name " Mux",		"ADX4 TX3",	"ADX4 TX3 XBAR-RX" },	\
-	{ name " Mux",		"ADX4 TX4",	"ADX4 TX4 XBAR-RX" },
+	{ name " Mux",		"ADX4 TX4",	"ADX4 TX4 XBAR-RX" },	\
+	{ name " Mux",		"ASRC1 TX1",	"ASRC1 TX1 XBAR-RX" },	\
+	{ name " Mux",		"ASRC1 TX2",	"ASRC1 TX2 XBAR-RX" },	\
+	{ name " Mux",		"ASRC1 TX3",	"ASRC1 TX3 XBAR-RX" },	\
+	{ name " Mux",		"ASRC1 TX4",	"ASRC1 TX4 XBAR-RX" },	\
+	{ name " Mux",		"ASRC1 TX5",	"ASRC1 TX5 XBAR-RX" },	\
+	{ name " Mux",		"ASRC1 TX6",	"ASRC1 TX6 XBAR-RX" },
 
 #define TEGRA210_MUX_ROUTES(name)						\
 	TEGRA_COMMON_MUX_ROUTES(name)
@@ -1135,6 +1208,13 @@ static const struct snd_soc_dapm_route tegra186_ahub_routes[] = {
 	TEGRA186_MUX_ROUTES("MIXER1 RX8")
 	TEGRA186_MUX_ROUTES("MIXER1 RX9")
 	TEGRA186_MUX_ROUTES("MIXER1 RX10")
+	TEGRA186_MUX_ROUTES("ASRC1 RX1")
+	TEGRA186_MUX_ROUTES("ASRC1 RX2")
+	TEGRA186_MUX_ROUTES("ASRC1 RX3")
+	TEGRA186_MUX_ROUTES("ASRC1 RX4")
+	TEGRA186_MUX_ROUTES("ASRC1 RX5")
+	TEGRA186_MUX_ROUTES("ASRC1 RX6")
+	TEGRA186_MUX_ROUTES("ASRC1 RX7")
 };
 
 static const struct snd_soc_component_driver tegra210_ahub_component = {
-- 
2.7.4

