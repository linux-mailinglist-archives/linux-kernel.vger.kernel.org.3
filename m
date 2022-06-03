Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB28C53C512
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbiFCGgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbiFCGgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:36:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4799377E9;
        Thu,  2 Jun 2022 23:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETGgpbmW/1LwAuXJlfvgLNyPFa6pZOYiYizk+xBPKoa41yWqoI4hxKmGCKTCQMm59sd2w4lx4r/g3w5BrDDcW+grszYvhZ39aLbjQoPSe2quhH5xgl0CPClpac/2KfVTnj2CfweQal6xKiTQbQwIJSKLifKinm4uR0x4RqdlN4w28/+ihNUq70oQes/EfNdFZLwzkyx16LsAoIw0Gxi2n0rWRDMMq3PaHJlAn0nod4YO5jfpYExUqzL+TWQpfcH0WYQPAizbRJGB9O1Jtus5INpHXEESqbhTy0Ia7tiSY7vwTLFTneHZdHRrnY+7ZhpXeiVfclZZm1H1rEpVW6lqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyNpoCT7r41AoXMWM43RUrGi67Z/OWD0xufT9om0iCk=;
 b=CcTjlaCUbNsrSgR/MFi230xtb77TkEIU/jy6k8S4qD0TSp9h0JP5FWELnB33ij1ioIPTTrXaS/weKdQDAfYI7LU4EZJ4vCa7Qs8V7SeixLQxNuD/TNNA0wvYF0UlEO50Ie50jmZWJLYc+NRljStrb7SCxRLUrZ1EnFfmmgVHS/pOOoyfxzTS/8MKZz5iK4uXqQ4Mn/a/v9E/mkxPVciHfGhxBAWv5TAyxL4nFbAbsI1XrDMY3YR/ZfWCX2fEoiPdDqlW6BInUZofhZEps6UbKJJMOg0qcxuI0xWEJEcUJV0UIsKK4CjGLKrnz9nSmTSh90BHFD1vtpsyxnZ75J8qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyNpoCT7r41AoXMWM43RUrGi67Z/OWD0xufT9om0iCk=;
 b=nKMh/HiH1NbvRWHi/2HUNcqr1iC7JDtOa+Z9TU95IbRuAs4bfd9ZCWd7uAlCruLtEd6pgFHKD7iz0Ctto15Qn3c0jUP+Da1Y5qj/MA/QXzd0mRoOplWnmkK858v792y/WCXp7QOI8yTkHxDeR/qZtg1U66po2zkesiZc4ps2efu5nabx1Ot9GbrTViCPUIMI6dAuzPqpSt+R55j1EZ9XZn5qjjMrfLZGvVZEdc/rjopMHA5nJjOcEUHDKcy5Jg6JqGNQ13Sia/wckRGOZzwyYPaa0FM/QiNWazln37lto3rJIeICplDu3mumG2FRlRlXztneU+ZPoo47KJ117fFCJw==
Received: from BN6PR22CA0032.namprd22.prod.outlook.com (2603:10b6:404:37::18)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 06:36:39 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::63) by BN6PR22CA0032.outlook.office365.com
 (2603:10b6:404:37::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 06:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 06:36:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 3 Jun
 2022 06:36:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 23:36:37 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 2 Jun 2022 23:36:33 -0700
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
Subject: [PATCH v3 3/6] ASoC: tegra: AHUB routes for OPE module
Date:   Fri, 3 Jun 2022 12:06:09 +0530
Message-ID: <1654238172-16293-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec068df4-efe3-433c-a031-08da452b69ef
X-MS-TrafficTypeDiagnostic: MN0PR12MB5834:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5834F10A331EB5060604A3F6A7A19@MN0PR12MB5834.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3yT0WDIl7Gdib+cLvRihX5Y2vHxwUuIwTUdIUUf59Zs6uZpzjoDRUOiYHsZrgaPM4ZIsdql8BvRgqbVbqTpdwtUuA/DFJ8y7Qh2zFItcToYF4MC/E6I0P1wwwRoBvdsHMSAgPIDyaTH3J51l/CqHT879LG75Hf3evWJHVqlyAjNq/vF48TQqCU2vJ/Z6XFdp6ovJiqmZuLW7EipCh/+FtUmA6d69+2M2RBPJy5vhgWNQvc/wL857y5SP1BRy81xziZNRTffNdBeYQLAemnMLabBTMKY3Z0I1fJBPe9osEgxK97W4WYEu1HWjTn2FzW1RiQTV0x/1LzbIZvb3D7vGVAtdIEGkiSSlxSqCckXp3ANnlZ0fSggHBL24hF2X1M3dOJMSZrZ4vqgQWwsVjQioeTt1QLaK0Kw2EGwZV+gLMpMqmRlb5YvVp3u/2wpBoYycTdSuQhwpyZgnt0LQrJGvovbcYVcbXAB9M/V3vk/5Puplui9oKMKyR553dOnQgkPjAK/VD82gfXKSvzO/XAg3CFmQqm05cP7cAiurtcoXM/o+DEUq8BEenzU/3o8/y0WmZE3LB1Nje4vvHbKCzwLgCRPBKUhRTw3wPtNZNnxJlHndJIx12+1cbGuNJKbpTAP+mdzhj/3yUh1hjaI7zcnrLGCN1TnP3q/MYokiX2r9lyWWvpvgmYA4k3OYZcdI7zr5XDhgptUay7QEAUwRa04YQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(316002)(8676002)(86362001)(4326008)(81166007)(36860700001)(110136005)(54906003)(508600001)(356005)(2616005)(5660300002)(40460700003)(6666004)(107886003)(2906002)(7696005)(26005)(8936002)(36756003)(82310400005)(47076005)(83380400001)(426003)(7416002)(336012)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 06:36:38.7693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec068df4-efe3-433c-a031-08da452b69ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

