Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AF652C16C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiERRii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbiERRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:38:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2058.outbound.protection.outlook.com [40.107.102.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8891FC2F2;
        Wed, 18 May 2022 10:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PplIjlESgKIkKcYLX6tyRfREmivGLs90u8IY6XNJdmmE6ynRLKPbvNwMoGRVq5zlTQN9/C0AljHnvZ+M5KIhcbvPD0UxSr7pi/OQWr2TvHZt72AgZ2w37rLuYT5GpHBgC8MLH808zOHXVkQgoJPyXb3HzZnPHfqSuyGAIDeSCpl0gL1S7cNbU5dxCMNF00/oAlyCxy7jkKaWufJlnYfOIn67B7HMv+6wqzYHJ9Dhlt3BsL/PUu6WUSUJoxBFnxNHCe0vEoh48PVs2VcB08hXtwXJxo3ap2ExBY6pjrKX80cyQj4CmORYAxdzhoXJITyK/pOkUq6W5EnwYiETU3bLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOgkGPe+rsHRKSb3hINYvKSJ43nq8Ug95+p5z9XDVYo=;
 b=WSlNnK8bPOau3Yp/m5VTPUXgTk6NHFllYA0N9Hi6P5n214d0DjGwEulgiF4iD7YEtRZu3WtUzBLh12j1SiZ87EuCmqkRb1I5u5i+IRabxIZh8ENPruJBdUIe+eE3XhQSQozSSKfyhYd53FafwaPmH7LWkrwIbfUh98+zq2F5Ua7lgVJ5SLdIQeCX5HzL27kXIOi7lNR20MZq7tcACcRgE5oMNBaze7lmskccDH9cQnABmsJVEIrZsOkjFSWcjPsrvodzkbTkPmiXTEWEXoQ5sUkzuqTQ6LgS7RRlDGB7ZiKMkP0DiOQQOfGA4z4Gdp5blUDSp8pl1WdLVRJvpQznmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOgkGPe+rsHRKSb3hINYvKSJ43nq8Ug95+p5z9XDVYo=;
 b=DlnAfl+3os8Y7iJnyWuyre3a0jgihJ+SxUd2zfcqNHPsxB2mDbBTIEfQo4YMvTGUcB5LMa10eRTEx9V4NU4TKHHnAR57AL4BPeXI+U3a3NsEbw5MLFuLgpNeQqNmiUXW57MwvAXfiptfZUTSgGcotaWlWjuC5MWkWl9X+y/qALfYOez/Fdg+e4hFXq0Nt8JI3dHjcx+VFEJINB7XUiMoHZvR7xlvdvaX5OmdoP4xGqIrG4b9f/B5tcU462lhwrrIBGiGX+2JjXGnNVH7JGMUmxvkKOqXckM6LqO/DfoVq0bCMhzD50I2xGfHyTJQxO6GmKvZUApVZgLhRIO7nP5wug==
Received: from DM6PR21CA0020.namprd21.prod.outlook.com (2603:10b6:5:174::30)
 by DM5PR1201MB0156.namprd12.prod.outlook.com (2603:10b6:4:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 17:38:25 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::e0) by DM6PR21CA0020.outlook.office365.com
 (2603:10b6:5:174::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.3 via Frontend
 Transport; Wed, 18 May 2022 17:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 17:38:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 17:38:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 10:38:24 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 10:38:20 -0700
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
Subject: [PATCH 3/6] ASoC: tegra: AHUB routes for OPE module
Date:   Wed, 18 May 2022 23:06:09 +0530
Message-ID: <1652895372-29885-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a95ab2-448d-445b-c909-08da38f53668
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0156:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0156CEAE98497AEE10ADE407A7D19@DM5PR1201MB0156.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVMtQq4ZVRCqfDZrcy8F5cnf7WrNOnkj11oePYV4GSCrijyV0YLZp9k6twuOClXMHEamMtVxeEP2tt72zrDBOW7TMbM+VizeAJJ58+A6jYrcvfPcGkyHSLkTPxlPLup6yKcT1Wp9yeJZ+G0hFoljYu2zMqFVb6xdtNYqfSoD/YYk2xNhHzDF4bGHNtmdOknyJhJJmdgsydR8dGDqn1yK4h50i3wzXjuF7If6ZdcVRWlP4UWbNPtM3MwHK1vmYRXtJBGjEVvcli0yry9i0byLNhy/aWABKj9iI/duOVRdw57CJGulIK5wXiUrlGQ8Coz+KHHCi95D986yg48ntYtLKRTPjivtks9eLav556Ovks05PwErSxyHqyVWB68nyiyxBYMuh/KJs4Clzln4x4khs1swX4lbZIQocODpE7s3YHPEAxt06Auw+cr9boNbE9ivlm2+2z+xhpWK5OtSJCRjs3QyB3Hh/oa2dYHh+mUR+W8VyUla8nMwIK1heU6U8SgnNCscBcX8ksWOuxpPRu4wDGxAcBFt1Ch0s5YkC4tMOctFNMps8ktq+g7OrgabGJ9YE4S9juq0Qs7EwUYV5Dw8nUQ+1KbPqT+rTwZpcFTzJuqSWT4sRDWkf4AhJBovdbzQcu5hCDo3YV/ZYOiQqsir2Dc1TKtdnI1vOzQxPeeEJRA5+iRB4DB5wRmF7kypvR2pFOYOOjjoRJTpI4CilDYIgA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(2906002)(316002)(54906003)(110136005)(70206006)(81166007)(6666004)(356005)(8676002)(86362001)(7696005)(4326008)(40460700003)(47076005)(2616005)(186003)(36860700001)(336012)(82310400005)(426003)(36756003)(107886003)(7416002)(8936002)(26005)(5660300002)(70586007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:38:25.6232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a95ab2-448d-445b-c909-08da38f53668
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0156
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 8980571..e429ffc 100644
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
@@ -753,6 +772,8 @@ static const struct snd_soc_dapm_widget tegra210_ahub_widgets[] = {
 	TX_WIDGETS("MIXER1 TX3"),
 	TX_WIDGETS("MIXER1 TX4"),
 	TX_WIDGETS("MIXER1 TX5"),
+	WIDGETS("OPE1", t210_ope1_tx),
+	WIDGETS("OPE2", t210_ope2_tx),
 };
 
 static const struct snd_soc_dapm_widget tegra186_ahub_widgets[] = {
@@ -862,6 +883,7 @@ static const struct snd_soc_dapm_widget tegra186_ahub_widgets[] = {
 	TX_WIDGETS("ASRC1 TX4"),
 	TX_WIDGETS("ASRC1 TX5"),
 	TX_WIDGETS("ASRC1 TX6"),
+	WIDGETS("OPE1", t186_ope1_tx),
 };
 
 static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
@@ -971,6 +993,7 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
 	TX_WIDGETS("ASRC1 TX4"),
 	TX_WIDGETS("ASRC1 TX5"),
 	TX_WIDGETS("ASRC1 TX6"),
+	WIDGETS("OPE1", t186_ope1_tx),
 };
 
 #define TEGRA_COMMON_MUX_ROUTES(name)					\
@@ -1013,7 +1036,11 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
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
@@ -1045,10 +1072,11 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
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
 
@@ -1111,6 +1139,8 @@ static const struct snd_soc_dapm_route tegra210_ahub_routes[] = {
 	TEGRA210_MUX_ROUTES("MIXER1 RX8")
 	TEGRA210_MUX_ROUTES("MIXER1 RX9")
 	TEGRA210_MUX_ROUTES("MIXER1 RX10")
+	TEGRA210_MUX_ROUTES("OPE1")
+	TEGRA210_MUX_ROUTES("OPE2")
 };
 
 static const struct snd_soc_dapm_route tegra186_ahub_routes[] = {
@@ -1205,6 +1235,7 @@ static const struct snd_soc_dapm_route tegra186_ahub_routes[] = {
 	TEGRA186_MUX_ROUTES("ASRC1 RX5")
 	TEGRA186_MUX_ROUTES("ASRC1 RX6")
 	TEGRA186_MUX_ROUTES("ASRC1 RX7")
+	TEGRA186_MUX_ROUTES("OPE1")
 };
 
 static const struct snd_soc_component_driver tegra210_ahub_component = {
-- 
2.7.4

