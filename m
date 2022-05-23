Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D55312B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiEWNY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiEWNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:24:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9BEC00
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTx+zeGrg+ogD24In7u+kL8NyDMrJxZJNUNTsJRgKoQL+mOMYNGX+/v+O6mWaYBfLZv32CLmsqDPME/n0J8QEVxJjNH2FGOerSL2WyA64y8YUl1O1XoUhSwtLNygajbpI0KBWv6mcfkqyfRTkISDg+URECMBOCWNfcSeJosf2To0dunV12wr4DtBTEhHytlP4UEqIp5c4uymd4XhrP8sNpjGGz1S8z/XVFX+FQr4HPbchlTDspC9Yb0RXaEl7oS7W0dM00EOeJfNUk3/D4rxhtp6PBFB79xF417Zu1XYae657IE+W1bAiL7qRg6Lo00qQHf0wBPTULvZDhXruBKg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB7usY6TY5aC8uwECWtZHncAfD9SlJF44hol320T66k=;
 b=XstdDDwecwsPjXAGIynVpgRAJc7n+VMSUOBd+iLOi3wufw70VCKffI2Lwo4Lk50ZRWVYBPwsnPYTBLZYjhiYEFzxgpP2/HUz/D4PIqpMw9wXOjoWsSvz0cjqAzIddnPr4AzgjlvTusp50Lg/6nyY6FA3Az9laJwVcCUV7r+0WdV7x/c7MWiBLyZTbRXzu79wWKP/MyZHZLcsXz2Hu1cvTPgwD4Z/VD7BG0GR/ACD0c04GolLh9wfwLCJpEeoESA/v89Y6XhIc51ecPXLkfu1xAnpbLl16UqI/5v6iAkrZauITeErkgyfbKGBTqjhiqAwcDfKu3s71dJ0OBFYKuz7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB7usY6TY5aC8uwECWtZHncAfD9SlJF44hol320T66k=;
 b=vREyyGV56tMOzPEApSkinuWjkA56ooemUjTdYxcmyennUhJYxsy/7kSxpepsuVrrlyqc1e7EC89pXsItN/Tesxhy5EyUUBnJKc3eulahv3OAqN2jsOO6HNbY/kIy4+BujnK58913RF/aPHr/NoO+FXc+Vm/C15fDXtZbkx5iiXE=
Received: from DM5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:3:12b::15)
 by BN6PR12MB1618.namprd12.prod.outlook.com (2603:10b6:405:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 13:24:17 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::53) by DM5PR04CA0029.outlook.office365.com
 (2603:10b6:3:12b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19 via Frontend
 Transport; Mon, 23 May 2022 13:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 13:24:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 08:24:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 06:24:16 -0700
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Mon, 23 May 2022 08:24:06 -0500
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
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] ASoC: amd: acp: Add support for rt5682s and rt1019 card with hs instance
Date:   Mon, 23 May 2022 18:53:53 +0530
Message-ID: <20220523132353.1767614-3-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523132353.1767614-1-Vsujithkumar.Reddy@amd.com>
References: <20220523132353.1767614-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f783a5a2-9533-47e9-c788-08da3cbf89cc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1618:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1618C4D35FE942121F7B01E592D49@BN6PR12MB1618.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGscB1nBbgvoS/NDOlaQ6aIBn/VGzstZ0dCy1Gms944Xl9m/gzfZscgrWJH8w70Fh9iO3nNlmaxi2OrbwA7bSFtC93AsKHCKe/5NMHh5alypMue7wVftTUxhjZX3L/WsxHIe9Fh3RgaXFDuFRoD+84whmKZ1kYqW7lsXNrmQnHVKrHx/nnPI2Ue8tU7jEflIUpjTMn1yGMo02gTr7cs8zDyi5E0DYe2Whgt6ZicFfQNGXfc9gtZ6H8nowiwlJ01HHm4QA6lciDyiyR8ev/XBEr8eAk9yoNy7nUNNYb3RhbnSYni+4NA3gr7xC4bOMWOw2cUCUzrttLqlb1mJdtZlDjY5Uby2WYhnBj+k/rRffbtesjd4mA9jp13uwqwNI7i4zbid/y50YvBnDPGLLdTPDinMVKdNSO0x7c9J5+O7oANq8AHDbDxVjZGp6bhxYzayMHlE34dUyx/W7se53VKqwJOXB6/PXHIkx7uCnG4A+/lqWBDV35dkd7F8DAWOix+kijVlD8iFQAlQ/c5Ort4oMbkiUAY5khFK2QdZM7YoPFBg21Q+AY441HwLihze4rM8IzGrw01I5YTBMZ555QMfatB/t5vPLHU4T3PwMiXBMXjxh8pYzOH0JAIdyPzsO0Xu/+XPmuIQJ5pskW2hIRdpKRb4kwYOtqv19An9FlmpW3G3jQeKMhWSf+ftkbIfAkiyUmK6o8cIECPMP5PC7Ta04w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(356005)(81166007)(1076003)(70206006)(70586007)(6666004)(26005)(4326008)(8676002)(2616005)(86362001)(7416002)(8936002)(5660300002)(7696005)(336012)(54906003)(110136005)(36860700001)(316002)(82310400005)(186003)(83380400001)(508600001)(36756003)(47076005)(426003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:24:17.3571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f783a5a2-9533-47e9-c788-08da3cbf89cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1618
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
index 4f5cfa26c58d..1ce0e0080515 100644
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
@@ -618,6 +647,12 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
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
 
@@ -674,6 +709,18 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
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

