Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221A53E8D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiFFO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbiFFO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:59:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A1C308ACF;
        Mon,  6 Jun 2022 07:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONwfrCMAlEvnt0ldULH2GJvafS6i04siigFb/kyF82mkhkqkGnuPYXW3EHQYHeOwelIBctELXmpLvNYgrCgSGLzer27iab9oJNvE86w/LQ8Qbk7fQ7TREs5IQ5seoFhQkX2TZ5ORLQ2LoSIlYh0vBJUSelY74VBkbSB7y6B0ujesjLssSmffObWx7UcgVHoHcOL3GvcvEuptsLFC0rIxI/WwDqqxvgC+V1Ewdtu+7ABIk9y3zxEvzc3sxqjkjTBNwqP9lLDbKzvtlgtJ8k0+ZKGv3cLVpER3kbWAx1SedzqBxJ1bVclkmAkROpgoh84xB1EXEgMObTTGeiIYmaR1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyNpoCT7r41AoXMWM43RUrGi67Z/OWD0xufT9om0iCk=;
 b=ZBrwf9BIfU5iEA8l2XHoG/kRjcRL5CnYFh18HF4AQPSFj7mXQiijDg+KxBf8Jmo4YOx4j9ZURGr3+5TqnNdMh8zGy8VzS6cAF3wNM/bo9GxEwRku66w3Ykj7Xa1CSafLStjtoArUm/VoWVhRlD8B9GzcTwVi+90kbvDIaL5JM0k+KWGpEhVrdTh95EuFsFHjnOymAGb4fI1U+CMvxjnPzvZ3FZAhiBm4qsQC9/9furCkarYNwjM4jOgmiRfNcsDIoX+4XbeWlEs4Cpp525SC+zCvPEw+Ki7pQar/v7J8EoNHCxNZIjFmASZIOmtifHHBCPSPd++vCBh9JQkSkzOUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyNpoCT7r41AoXMWM43RUrGi67Z/OWD0xufT9om0iCk=;
 b=hUp1LPJoPd+Hm9qwC74I7hntQHlSLMPIhmcwDGn7E+YvXyTd+2Y18S56maGEgQLyNEGymHeV5Sa1TUvUx9+7ldBLppTrQrpkZzScWm2BEZZVvkSawB2n9ueOYZORrAZYFKo4WQ/ENGD02opFD5ysC7u/y+nyBfIJZTdRTibtTb3kU/APps1JgH4tE81D78AIBejQlvsbCQB1+BZ2rqfcfDvqladi7x9GQIwYlf/dz8ZRuUoTntxIQOBCFWTj1Bk/2nGmmMjVnyufMEraJylA0XwtyRkioJGKdB1xgz54O1Pf70S9/cDzluZZe8Qz9fFHFblGyIi/VH0nk2UWtSwvJg==
Received: from DM5PR19CA0031.namprd19.prod.outlook.com (2603:10b6:3:9a::17) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 14:59:26 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::77) by DM5PR19CA0031.outlook.office365.com
 (2603:10b6:3:9a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 14:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 14:59:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 6 Jun
 2022 14:59:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 07:59:24 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 6 Jun
 2022 07:59:21 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [RESEND PATCH v3 3/6] ASoC: tegra: AHUB routes for OPE module
Date:   Mon, 6 Jun 2022 20:28:54 +0530
Message-ID: <1654527537-31038-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
References: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63640e1b-e31e-409e-e8b3-08da47cd2649
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4337D9FDBDFE28E572D3BBACA7A29@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lD4f+0XRX0JREHNhlSsg+JQL9uatDVOqXx2tHwS3ZkVQKGyp0SZ5ShCk1cc16wTDXnKnuBlcFoz9vSNg4B1SZ4xMQbC35D2W6Q+i4i9lN8tbdk1lEEXeqkxvZYnLsNzazB4FxqhA3QZhsCefaGAejumbRqZh4yGzkNLhVHZv//BsAmjiv48GSCTJyuUBFoc0XUKZh/WtlVjZ5afdecHfBvBHyR1UhUU5B259UhFXyJc5UU7R2g15Y3Et/7zRdTTFY+xTgpTm5ztfyIhzSi6dOlV13mJwkWitx1i1dDbiI8U13wVfiRBJrW/xKNKG0OQpq4ma6m4zblYFVBj0an4Bjg1IAclovMwUawjwj0NOz7TTXzB/EqNGoK+KYC23BRs6cZCzwAgr66hLaT6t4BmueUvHwh9WdIxEDQldyX0Etx2xSocXigjEadtWvNxhhXVxaeFbbwON56AqLWIbRqk1WLh2r+jbIPrfv6iO0FMMWPtPnoxSWormjRVw3q8WA3WbopoyjVLPwJh4IU/xmfACXq/SOinxhyfCDNgRbNDxQW7Lwfok+zewDjc8Y7ANAkpN93D7P+pi1QekeTXXKPNrVvQP1mBpuMrkKO1x7mqY70Jzt4ovLEoARKTRWP3nrvi3Dhl2r77R88VWU7EAMQMWhZd6xFX24gEilaKHLsxK+6BygjCKGraAeuch+pC9E+Rs37fNnfxZrDLgVccQHbVyEQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(186003)(336012)(82310400005)(36756003)(70586007)(4326008)(36860700001)(70206006)(107886003)(2616005)(426003)(81166007)(6666004)(8676002)(7696005)(26005)(110136005)(8936002)(356005)(40460700003)(54906003)(5660300002)(316002)(47076005)(7416002)(508600001)(86362001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:59:26.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63640e1b-e31e-409e-e8b3-08da47cd2649
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AHUB routes for OPE module. The OPE module can be plugged into audio
path as per the need. The routing controls can be used to setup the audio
path with OPE similar to the already existing routes. The support is added
on Tegra210 and later Tegra SoCs where OPE module is present.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_ahub.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index e1f90da..b38d205 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -170,6 +170,11 @@ static struct snd_soc_dai_driver tegra210_ahub_dais[] = {
 	DAI(MIXER1 TX3),
 	DAI(MIXER1 TX4),
 	DAI(MIXER1 TX5),
+	/* XBAR -> OPE -> XBAR */
+	DAI(OPE1 RX),
+	DAI(OPE1 TX),
+	DAI(OPE2 RX),
+	DAI(OPE2 TX),
 };
 
 static struct snd_soc_dai_driver tegra186_ahub_dais[] = {
@@ -294,6 +299,9 @@ static struct snd_soc_dai_driver tegra186_ahub_dais[] = {
 	DAI(ASRC1 RX6),
 	DAI(ASRC1 TX6),
 	DAI(ASRC1 RX7),
+	/* XBAR -> OPE -> XBAR */
+	DAI(OPE1 RX),
+	DAI(OPE1 TX),
 };
 
 static const char * const tegra210_ahub_mux_texts[] = {
@@ -337,6 +345,8 @@ static const char * const tegra210_ahub_mux_texts[] = {
 	"MIXER1 TX3",
 	"MIXER1 TX4",
 	"MIXER1 TX5",
+	"OPE1",
+	"OPE2",
 };
 
 static const char * const tegra186_ahub_mux_texts[] = {
@@ -408,6 +418,7 @@ static const char * const tegra186_ahub_mux_texts[] = {
 	"ASRC1 TX4",
 	"ASRC1 TX5",
 	"ASRC1 TX6",
+	"OPE1",
 };
 
 static const unsigned int tegra210_ahub_mux_values[] = {
@@ -459,6 +470,9 @@ static const unsigned int tegra210_ahub_mux_values[] = {
 	MUX_VALUE(1, 2),
 	MUX_VALUE(1, 3),
 	MUX_VALUE(1, 4),
+	/* OPE */
+	MUX_VALUE(2, 0),
+	MUX_VALUE(2, 1),
 };
 
 static const unsigned int tegra186_ahub_mux_values[] = {
@@ -540,6 +554,8 @@ static const unsigned int tegra186_ahub_mux_values[] = {
 	MUX_VALUE(3, 27),
 	MUX_VALUE(3, 28),
 	MUX_VALUE(3, 29),
+	/* OPE */
+	MUX_VALUE(2, 0),
 };
 
 /* Controls for t210 */
@@ -584,6 +600,8 @@ MUX_ENUM_CTRL_DECL(t210_mixer17_tx, 0x26);
 MUX_ENUM_CTRL_DECL(t210_mixer18_tx, 0x27);
 MUX_ENUM_CTRL_DECL(t210_mixer19_tx, 0x28);
 MUX_ENUM_CTRL_DECL(t210_mixer110_tx, 0x29);
+MUX_ENUM_CTRL_DECL(t210_ope1_tx, 0x40);
+MUX_ENUM_CTRL_DECL(t210_ope2_tx, 0x41);
 
 /* Controls for t186 */
 MUX_ENUM_CTRL_DECL_186(t186_admaif1_tx, 0x00);
@@ -657,6 +675,7 @@ MUX_ENUM_CTRL_DECL_186(t186_asrc14_tx, 0x6f);
 MUX_ENUM_CTRL_DECL_186(t186_asrc15_tx, 0x70);
 MUX_ENUM_CTRL_DECL_186(t186_asrc16_tx, 0x71);
 MUX_ENUM_CTRL_DECL_186(t186_asrc17_tx, 0x72);
+MUX_ENUM_CTRL_DECL_186(t186_ope1_tx, 0x40);
 
 /* Controls for t234 */
 MUX_ENUM_CTRL_DECL_234(t234_mvc1_tx, 0x44);
@@ -758,6 +777,8 @@ static const struct snd_soc_dapm_widget tegra210_ahub_widgets[] = {
 	TX_WIDGETS("MIXER1 TX3"),
 	TX_WIDGETS("MIXER1 TX4"),
 	TX_WIDGETS("MIXER1 TX5"),
+	WIDGETS("OPE1", t210_ope1_tx),
+	WIDGETS("OPE2", t210_ope2_tx),
 };
 
 static const struct snd_soc_dapm_widget tegra186_ahub_widgets[] = {
@@ -867,6 +888,7 @@ static const struct snd_soc_dapm_widget tegra186_ahub_widgets[] = {
 	TX_WIDGETS("ASRC1 TX4"),
 	TX_WIDGETS("ASRC1 TX5"),
 	TX_WIDGETS("ASRC1 TX6"),
+	WIDGETS("OPE1", t186_ope1_tx),
 };
 
 static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
@@ -976,6 +998,7 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
 	TX_WIDGETS("ASRC1 TX4"),
 	TX_WIDGETS("ASRC1 TX5"),
 	TX_WIDGETS("ASRC1 TX6"),
+	WIDGETS("OPE1", t186_ope1_tx),
 };
 
 #define TEGRA_COMMON_MUX_ROUTES(name)					\
@@ -1018,7 +1041,11 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
 	{ name " Mux",		"MIXER1 TX2",	"MIXER1 TX2 XBAR-RX" },	\
 	{ name " Mux",		"MIXER1 TX3",	"MIXER1 TX3 XBAR-RX" },	\
 	{ name " Mux",		"MIXER1 TX4",	"MIXER1 TX4 XBAR-RX" },	\
-	{ name " Mux",		"MIXER1 TX5",	"MIXER1 TX5 XBAR-RX" },
+	{ name " Mux",		"MIXER1 TX5",	"MIXER1 TX5 XBAR-RX" }, \
+	{ name " Mux",		"OPE1",		"OPE1 XBAR-RX" },
+
+#define TEGRA210_ONLY_MUX_ROUTES(name)					\
+	{ name " Mux",          "OPE2",         "OPE2 XBAR-RX" },
 
 #define TEGRA186_ONLY_MUX_ROUTES(name)					\
 	{ name " Mux",		"ADMAIF11",	"ADMAIF11 XBAR-RX" },	\
@@ -1050,10 +1077,11 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
 	{ name " Mux",		"ASRC1 TX5",	"ASRC1 TX5 XBAR-RX" },	\
 	{ name " Mux",		"ASRC1 TX6",	"ASRC1 TX6 XBAR-RX" },
 
-#define TEGRA210_MUX_ROUTES(name)						\
-	TEGRA_COMMON_MUX_ROUTES(name)
+#define TEGRA210_MUX_ROUTES(name)					\
+	TEGRA_COMMON_MUX_ROUTES(name)					\
+	TEGRA210_ONLY_MUX_ROUTES(name)
 
-#define TEGRA186_MUX_ROUTES(name)						\
+#define TEGRA186_MUX_ROUTES(name)					\
 	TEGRA_COMMON_MUX_ROUTES(name)					\
 	TEGRA186_ONLY_MUX_ROUTES(name)
 
@@ -1121,6 +1149,8 @@ static const struct snd_soc_dapm_route tegra210_ahub_routes[] = {
 	TEGRA210_MUX_ROUTES("MIXER1 RX8")
 	TEGRA210_MUX_ROUTES("MIXER1 RX9")
 	TEGRA210_MUX_ROUTES("MIXER1 RX10")
+	TEGRA210_MUX_ROUTES("OPE1")
+	TEGRA210_MUX_ROUTES("OPE2")
 };
 
 static const struct snd_soc_dapm_route tegra186_ahub_routes[] = {
@@ -1215,6 +1245,7 @@ static const struct snd_soc_dapm_route tegra186_ahub_routes[] = {
 	TEGRA186_MUX_ROUTES("ASRC1 RX5")
 	TEGRA186_MUX_ROUTES("ASRC1 RX6")
 	TEGRA186_MUX_ROUTES("ASRC1 RX7")
+	TEGRA186_MUX_ROUTES("OPE1")
 };
 
 static const struct snd_soc_component_driver tegra210_ahub_component = {
-- 
2.7.4

