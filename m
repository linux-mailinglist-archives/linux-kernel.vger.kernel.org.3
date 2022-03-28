Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38A4E8DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiC1GIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiC1GIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:08:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25904739F;
        Sun, 27 Mar 2022 23:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3HlQhq32bwKNWPDzOBKRQPRALxphialHM2kZZFa/2GPrtK/XKs2ab8hlG+rL2agGnOy+pmLTV3dQDHPjZDK8Goz7F+8EJq0mcQxoDhecfuYx/QrlSghfNBzfOO5DQhkTciIvW+J/li7EXY+hg3+Bk57qwbEMfv+HqtZ901sYfCwYeZ/VnCVcj+YGI3ZuCGWP08Gy5OplEtNVXUXFOPzeD7ZruBkDpLwGJ24Ssr10r86GRIvI9PNfg07vDuh2AbSKIR275N13jktctK6jdBijeRKA7ubcGPdyqfTCPJiy9GmlXHIdniyq53nLpeWy9bQ7KtAIlQlH8Ezuhy0uTm72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe5SYG1TP+sQ5em8T8L2BI8X1qzj8arzo+ME4eAewaQ=;
 b=Zo/bg26uGaa+xpeMVu7FbkXvWM/bKlyNNUx/Rfn5fFOHot/fBmcKgRSq9GRclrNVi6M5egB5oftzZrSub+hpWQjXUIH+fNBrdc2bapL1+elBnqY0mtAKWcZEyjFP2+vxnhJ+7o9xXhUv12felvUuKsDSlDlbXG+dpBv7w0DOhTwpe8z8PcVkz44nCZa3o4Ald+kvzaqRL1cWArelEuMgk1Oe2GIvNWSAeNSOa2kPPyFo01nDoFPwl5+hzUinZuulqF7E4KHgV3Jwc5rZ6NBufaBh0/YZoSxMjrnCe2hwrJhw3pYDuO8YAQqCcMWbTSwOmp6E2M//+CGHNJSw5SyJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe5SYG1TP+sQ5em8T8L2BI8X1qzj8arzo+ME4eAewaQ=;
 b=tslhgcHF8cf0RwepmlBS1xVNOJIiwWDdMWaDHtSWIceCRCqRZilZoAmftUDNu2W441P1M1dsPGV/zYTLzPypuopPXoIlDwoIVx5BwKvFxvcEkW4Z8JyKYMwd6JMTqc9UbiTNhA387+W/vMqoLwFxKD8xC6BWZmqfO7/BToxiLiRXs0bgX0YeLWdKdd3t5JbTBPv/aoUPuizjotr0H9fg2Daq3/+4fN96Fo7JaqBFV6Ukdc+rp+biKftu2WXtE75vTp6Sa0aSWFeQrAv7ouaa3PhZmg97ButR8oGp2WyX2Wxp4qJKDdqI2Dllk9wr5j51qJ/iocqrFLxiNlsP+I6YGw==
Received: from DM5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:3:d4::22) by
 CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Mon, 28 Mar 2022 06:06:48 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::b8) by DM5PR05CA0012.outlook.office365.com
 (2603:10b6:3:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:06:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:06:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:06:46 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:06:42 -0700
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
Subject: [PATCH 3/6] ASoC: tegra: AHUB routes for ASRC module
Date:   Mon, 28 Mar 2022 11:35:23 +0530
Message-ID: <1648447526-14523-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
References: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2295bb59-2784-4e54-2d0d-08da108124a6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4134:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41344B55AA6624237BB553FFA71D9@CH2PR12MB4134.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsqd7dhvcc0c5N57xvKDO2gEaVG3WjimWq5PTbQF5hJmTY6OJqCgDFompoqy+SMShOY4hajjIOHGxk58IP1PWWQmAZ85bcDPY2dk/CtkTYWPvrya8vR23tmU4CJ9h9TVN6eccgEotngKbYw3ZS2dFdk9zDLJZdM9BYm1wOMmkVV0X/mzrdPjYC1xr1TfY5RXny+D6G+KhFow/XYL0CQc2GQ52kmfMFV+DZDedrZgb6bSl3SNwSc6Zm0UBjUaYBYZiWAa7xed6PaxMZsEj1fkOyTDpts4G9wAaO/r6wqGMfQJLd3+X0aJjvtRcZfxzer4jHge8vY33EHW9dUTdkJE3z+aHTKdRaiLTdTCMvCkB+Xfs7sfA0n/5L8vKtf0DZgvGamTPGTJdv4YHY6lM6lR2VIDHX9x07fL2srWasU2fCqRQbiMU5GuR68d07eaJIrbUdedvybX+1QwJP3y9hF1B54oxs5mXIJaZsVBZYrSR9koLKw2u4gBi2EMcDBcY6H//Jg76Tid0tYT97/ACm9/UTWtS4tSi5GKMoKPha0pYG3KYYAi62THAaW98wCocVajLPTPNwwrOof281aHR618jzPwgb+hHqR6lVBGKSQlYtJIx4bq+uY0SJBtz08qjg29Yz2MZJz6uHeasAhW1kGj8LBlyUOm8HcHzf99yddKjgVMYaoMFJxTpL/HOBloNCx0GQf9t032ccY+9Um1XMTT5A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(8936002)(110136005)(316002)(2906002)(70586007)(426003)(336012)(107886003)(4326008)(8676002)(7416002)(6666004)(47076005)(36860700001)(26005)(70206006)(186003)(5660300002)(40460700003)(356005)(81166007)(83380400001)(2616005)(86362001)(7696005)(508600001)(54906003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:06:47.6792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2295bb59-2784-4e54-2d0d-08da108124a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

