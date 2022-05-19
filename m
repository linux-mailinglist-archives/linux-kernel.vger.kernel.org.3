Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF04252CBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiESF4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiESF40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:56:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34063385
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi9DSb/tBfrMt2yyPGiIjTwyvEUfVC25uPWA5gRAYV0qd7KMErbBt8zH2NVnveJQwnybbCIAJUgq+M69vjFCj4hB8CEI+x2+Ua5CJNY+11JglNIYDHpYZzlBywVIcRJXG1104gMyUylImKhSXEeQV+1KYrMhE0FDQw7OpiXw0Adu/wwmyZaYdodPt9QtI9vmgJSwlLsyi+Gf2Pr45QMoOTuiaQOhm8+75WwWBFVPKoRgGQ5WA5mvb/qbuiR9ZDxoD2A1Bqljv1/FHoNwf9APh+l0NDf0RJG1dbOXgTAv8Mfy2VeT20kiMy9dfPEDkOb7+62gwqYcaAXJgBOPkk7oyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4LfUVVhjVyvqxKfXccaw3DExbIdegnrse/P1Vc0YGY=;
 b=f4cHn4jG4Z/GLTJx0K0OcwYunw6+9vCqwQvAdLUi7gDc/dT+RIADB5kaFWkWyoq1ZyC4kLTU+YZLMGzGpBAhYwv2hDEfP3dgATvJ88WN5w2QfU69R5khF+kv77uZblNwmEAaOPEGanY4Wglf//IPMBg3oUxAXsQg/jtfEIzbRbpxdtPYNQMVmjT9Y4dhhShlXH3fx/yT5Lp71w2cRVDFH2aMsKuEvMcvnypGHvB3hH9LDt5MB3Eil8IgPbtov1H84b7V3daB/VCJeC21RjxYnzemJA/y+iNRB7sKzusHb19KulLfuoc+r22bjhODWscAXVqZay5LfQmAFWUaXqPNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4LfUVVhjVyvqxKfXccaw3DExbIdegnrse/P1Vc0YGY=;
 b=20x0AV/ENdUmRJ0BobVNiJr+jbzp0bMQIrGjQd8vMf6qhG85eKI5On2mWb1dYUpw4pMQdOFZZ0PLV39+TXAKZ0bb6MFtepj2pIrue+8yAB89ar22Psmavb/def/QwhtQNvEgPPUl/Y/u8KXioTxxGQn+LhEsW6BZWdmQwHCVVBU=
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by MN2PR12MB3070.namprd12.prod.outlook.com (2603:10b6:208:c1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Thu, 19 May
 2022 05:56:21 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::bb) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Thu, 19 May 2022 05:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:56:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 00:56:03 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Thu, 19 May 2022 00:55:53 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <ajitkumar.pandey@amd.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] ASoC: amd: acp: Add support for rt5682s and rt1019 card with hs instance
Date:   Thu, 19 May 2022 11:25:22 +0530
Message-ID: <20220519055522.1613813-3-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519055522.1613813-1-Vsujithkumar.Reddy@amd.com>
References: <20220519055522.1613813-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db7bae5a-23ec-419e-b616-08da395c4c58
X-MS-TrafficTypeDiagnostic: MN2PR12MB3070:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30703300EBFBAEEBA08735F792D09@MN2PR12MB3070.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqq6qH1r7cduB+HbOZqoEp3I+55+VPSgsv3GZhXMjtY9e52HZ3Cbq3NFtwNSedjz/sr3+QCUrMUE5VV3dDhfJDm4YApBFSNr6sK3XuunyVVgwAE+7qxy+Mdo+1IobqCELScAYgwWj+IVDizaW9KEEELEKgF5cMfSPzjFVfMl5hGmy1sJbp/3Na1otxILNdACjgCuc8kH+1a+SXrTL+6njRyf49aLzkfZd0lnDQNQhCQ3mpDkQLZGx4P72Yk0hTeHmHBjYYBbcraRwwQL8kQbvutHLEwluJlSeu/u8tqZAey/LIyrkn/OOPEKoyHk2hNiNJ5QgJRAsUijaBpflzjmNLo2veFVxZ6mpbOIme48zjbwix2A3v4bIbNGG9vUuF9rA5PJwDPFHtxIpqBj9mXl7g8jcoWFQBY702KngORKIsF0JX4+opRRB4IvuVZlRnAj5cXnvLzO0ZUgNbG1SdQcFssfTSbIE/nUMmh1tzeIgMp4vguIvzOi/s9ycvtuEB7IqkWIRlFiE22DgV1sPE4vQOTHn+DHmMRGctwLPP0y9+b2Clz14d7cx/IOl8nvbfzhPzXQX9WdIcboo4OgJWg8Y+2mBCb6Y+abtKnhiTZCeseFiZ1X+WWaiLJbJC9Zv87nkFS3gPHYVrOTPryMjM303GbAwhi4g42bE2AciEeGMF4WB6uIObO7Kf++2Jj4dTerJBfBzcolwysXYJE30yav5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(2906002)(6666004)(47076005)(336012)(426003)(356005)(186003)(83380400001)(82310400005)(316002)(1076003)(36860700001)(110136005)(70206006)(40460700003)(2616005)(36756003)(508600001)(7416002)(5660300002)(8676002)(26005)(7696005)(8936002)(54906003)(70586007)(4326008)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:56:20.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7bae5a-23ec-419e-b616-08da395c4c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have new platform with rt5682s as a primary codec and rt1019 as an
amp codec. Add machine struct to register sof audio based sound card
on such Chrome machine.

Here we are configuring as a soc mclk master and codec slave.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/amd/acp-config.c          |  9 ++++
 sound/soc/amd/acp/acp-mach-common.c | 69 ++++++++++++++++++++++++-----
 sound/soc/amd/acp/acp-sof-mach.c    | 15 +++++++
 3 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index f73c187fee03..5c7b51b2ecfb 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -147,6 +147,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
 		.fw_filename = "sof-rmb.ri",
 		.sof_tplg_filename = "sof-acp-rmb.tplg",
 	},
+	{
+		.id = "RTL5682",
+		.drv_name = "rt5682s-hs-rt1019",
+		.pdata = (void *)&acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_rt1019,
+		.fw_filename = "sof-rmb.ri",
+		.sof_tplg_filename = "sof-acp-rmb.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_rmb_sof_machines);
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 3ffe816c59c9..cbde045b9dfe 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -148,10 +148,15 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	int ret;
+	unsigned int fmt = 0;
+	int ret = 0;
 
-	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
 		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
 		return ret;
@@ -162,10 +167,13 @@ static int acp_card_hs_startup(struct snd_pcm_substream *substream)
 				      &constraints_channels);
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &constraints_rates);
-
-	ret = acp_clk_enable(drvdata);
-	if (ret < 0)
-		dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
+	if (!drvdata->soc_mclk) {
+		ret = acp_clk_enable(drvdata);
+		if (ret < 0) {
+			dev_err(rtd->card->dev, "Failed to enable HS clk: %d\n", ret);
+			return ret;
+		}
+	}
 
 	return ret;
 }
@@ -201,6 +209,7 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct snd_soc_component *component = codec_dai->component;
+	unsigned int fmt;
 	int ret;
 
 	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
@@ -208,8 +217,12 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != RT5682S)
 		return -EINVAL;
 
-	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
 		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
 		return ret;
@@ -236,8 +249,10 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	drvdata->wclk = clk_get(component->dev, "rt5682-dai-wclk");
-	drvdata->bclk = clk_get(component->dev, "rt5682-dai-bclk");
+	if (!drvdata->soc_mclk) {
+		drvdata->wclk = clk_get(component->dev, "rt5682-dai-wclk");
+		drvdata->bclk = clk_get(component->dev, "rt5682-dai-bclk");
+	}
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
@@ -298,6 +313,9 @@ static const struct snd_soc_ops acp_card_dmic_ops = {
 SND_SOC_DAILINK_DEF(rt1019,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:00", "rt1019-aif"),
 			  COMP_CODEC("i2c-10EC1019:01", "rt1019-aif")));
+SND_SOC_DAILINK_DEF(rt1019_1,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:02", "rt1019-aif"),
+		    COMP_CODEC("i2c-10EC1019:01", "rt1019-aif")));
 
 static const struct snd_soc_dapm_route rt1019_map_lr[] = {
 	{ "Left Spk", NULL, "Left SPO" },
@@ -315,6 +333,17 @@ static struct snd_soc_codec_conf rt1019_conf[] = {
 	},
 };
 
+static struct snd_soc_codec_conf rt1019_1_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF("i2c-10EC1019:02"),
+		.name_prefix = "Left",
+	},
+	{
+		.dlc = COMP_CODEC_CONF("i2c-10EC1019:01"),
+		.name_prefix = "Right",
+	},
+};
+
 static int acp_card_rt1019_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -611,6 +640,12 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			links[i].init = acp_card_nau8825_init;
 			links[i].ops = &acp_card_nau8825_ops;
 		}
+		if (drv_data->hs_codec_id == RT5682S) {
+			links[i].codecs = rt5682s;
+			links[i].num_codecs = ARRAY_SIZE(rt5682s);
+			links[i].init = acp_card_rt5682s_init;
+			links[i].ops = &acp_card_rt5682s_ops;
+		}
 		i++;
 	}
 
@@ -667,6 +702,18 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			links[i].ops = &acp_card_maxim_ops;
 			links[i].init = acp_card_maxim_init;
 		}
+		if (drv_data->amp_codec_id == RT1019) {
+			links[i].codecs = rt1019;
+			links[i].num_codecs = ARRAY_SIZE(rt1019);
+			links[i].ops = &acp_card_rt1019_ops;
+			links[i].init = acp_card_rt1019_init;
+			card->codec_conf = rt1019_conf;
+			card->num_configs = ARRAY_SIZE(rt1019_conf);
+			links[i].codecs = rt1019_1;
+			links[i].num_codecs = ARRAY_SIZE(rt1019_1);
+			card->codec_conf = rt1019_1_conf;
+			card->num_configs = ARRAY_SIZE(rt1019_1_conf);
+		}
 		i++;
 	}
 
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index adbae809f2aa..f19f064a7527 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -66,6 +66,16 @@ static struct acp_card_drvdata sof_nau8825_data = {
 	.soc_mclk = true,
 };
 
+static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
+	.hs_cpu_id = I2S_HS,
+	.amp_cpu_id = I2S_HS,
+	.dmic_cpu_id = DMIC,
+	.hs_codec_id = RT5682S,
+	.amp_codec_id = RT1019,
+	.dmic_codec_id = DMIC,
+	.soc_mclk = true,
+};
+
 static const struct snd_kcontrol_new acp_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -138,6 +148,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "nau8825-max",
 		.driver_data = (kernel_ulong_t)&sof_nau8825_data
 	},
+	{
+		.name = "rt5682s-hs-rt1019",
+		.driver_data = (kernel_ulong_t)&sof_rt5682s_hs_rt1019_data
+	},
 	{ }
 };
 static struct platform_driver acp_asoc_audio = {
@@ -158,4 +172,5 @@ MODULE_ALIAS("platform:rt5682-max");
 MODULE_ALIAS("platform:rt5682s-max");
 MODULE_ALIAS("platform:rt5682s-rt1019");
 MODULE_ALIAS("platform:nau8825-max");
+MODULE_ALIAS("platform:rt5682s-hs-rt1019");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

