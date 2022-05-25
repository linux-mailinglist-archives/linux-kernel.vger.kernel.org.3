Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089FE5344F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbiEYUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbiEYUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:34:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCA50039
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1vkRO5QCfoRhSbrqudRJb5fJEIXxw9NLLehPHdPl0kuX+LDV4deK77CZylCYnQ7C0NHHEokQAWtg0w/runfdRjObcxGYQ6wlnMhnIRQ4uoqSWoPWwbIlRk9IYHZicBcoGcLZwUhhYIO6rZDochoW7F9j7z5Jly3mrxIe1y66ElTJK+s/UC3rUU10TnWutzSgHjCB6K/+maziR7w+TQDpIPYdKrRqNSUQAJHBUZyOy+S8312fUX7sAC4vsEyQi9S5w51+3puFiGAdiZBkyaqSsk7rPpyi0KD58bSFjuVwl6Of8RWWAaKCMPS3zxac9w9HFpUe52iBwZ1s2yqbuCCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwBcUDjE2u49klEuKKZKjKQpwnfLsN4Udm4IB+vosU0=;
 b=RhPXcWopFZ5UGdI0xm5CvZxwoh29DzRW3Zf602mMbQ6Cc2EnBY9AAKICvKbM9yRScQhwa1vh6d+A2QehcNbGAynkHKCoKQLP8mJ0wBYvKzxOClrC4zmzw+2TIXKLJdPTnWUXXONjexeU+57Pa85iEfTE+TUYS5vFq0g+Jl4AbHKYpcSTlnvWQoTeAnRe2UeDmhJM1oYfrZLa5j2qcyOb1hpXtWDsGD5ujm2YqT1HJ22hA0v/i+BdhAbylAtpJOehIFaPop6umbVphvhvV8/LIMjy6N8913ov4iEZ3qURzZMtXZ6UV29ufiHL7ZQSplRm5YD5gFksZYHSmDTtoeGjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwBcUDjE2u49klEuKKZKjKQpwnfLsN4Udm4IB+vosU0=;
 b=H63YKLT5NON97IfMetDym9Hb83M2Vt3vzbzdWHh9et+YUU0klhcqSJLgqqbk2o3ZHoQHcG1yRzJ2Y5bvV2ZOOmYM7IZc6fiSKwsmn+6BuizvVOkAFZoUhqqBHVGsR+PAvov3puL5+OgX+Bgv5DcCLs66G3wgNXJhAq65ULkC4P0=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by CY4PR1201MB0086.namprd12.prod.outlook.com (2603:10b6:910:17::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Wed, 25 May
 2022 20:34:38 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::fd) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Wed, 25 May 2022 20:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 20:34:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 15:34:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 15:34:36 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Wed, 25 May 2022 15:34:27 -0500
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
Subject: [PATCH v4 2/2] ASoC: amd: acp: Add support for rt5682s and rt1019 card with hs instance
Date:   Thu, 26 May 2022 02:04:14 +0530
Message-ID: <20220525203415.2227914-3-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525203415.2227914-1-Vsujithkumar.Reddy@amd.com>
References: <20220525203415.2227914-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3890c430-4a3b-4b6d-c8ce-08da3e8dfceb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0086:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0086E399F2D63C43DA20047292D69@CY4PR1201MB0086.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/js+UhGGE9lb4B+fXrW0m+yRo26e2V0nL+TCalFHIC/JOZY+OrRag6W5CvE5DCrypUR+X99i103dvrIXvXxws54u8vJACqjzMexcUnE268AgCP5u+x+S8dDxxJT5g000hH/EBC3uOY+AjLIcnfeoTHKrc8XH2IGDc58IjCdf1P6HLXFoCr6E3Cbad8fn814HWdBB7rRJPXn0i3R3xbN9yGyg2NK5Axjfn5biHlXALsrIPRJau5D/reRdZnM2bFxm5alCFgVA3gaZrqdsnunN11daE8c5xu3b9NTa3n7ZMGXZt8+IoDn6lkOvmGnV6eTnHhILwUDB41AuASmQ6BSgODLfJrIF4irpAHSmEjJ7OttjYSCI92/MTCUJBe9iVQ1gfOPYFP8m5RZE+Rkxu46ej0U8YOpyA6Ehw4xfPya3JHMJIEGA6I+VFIJMRTKnSSdwumDqkjdt/6OKgvTPl0PNx/Oo9LfBhUAhDmG91jYJUUJUAShIm5oLpUIs5Dl18nQm44YriUR3Tpo02iOHvYEKT5RQpqPUpLsoD6YEMbLcMFJrZUz7fB9NN5ZoB+MSnuCeU4l6pnNdlmvrtmwWbMKH8rc4fVZEbm0Ed+w4TW6pUiZdco/cJFUwTh/yS4onyTt0zormZTwsttlh07odXhRTv7s4FlOkmRG/GPiKYKpW0EK/rx20QcxdaI4zOTLOkjWCzIi3FoXFc80+AXAfqU3WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(82310400005)(83380400001)(47076005)(186003)(426003)(336012)(1076003)(36860700001)(36756003)(7696005)(356005)(6666004)(316002)(70586007)(110136005)(508600001)(54906003)(40460700003)(2906002)(2616005)(8676002)(4326008)(26005)(7416002)(5660300002)(8936002)(86362001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 20:34:37.8937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3890c430-4a3b-4b6d-c8ce-08da3e8dfceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0086
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
index ba9e0adacc4a..39ca48be7be9 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -147,6 +147,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
 		.fw_filename = "sof-rmb.ri",
 		.sof_tplg_filename = "sof-acp-rmb.tplg",
 	},
+	{
+		.id = "RTL5682",
+		.drv_name = "rt5682s-hs-rt1019",
+		.pdata = &acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_rt1019,
+		.fw_filename = "sof-rmb.ri",
+		.sof_tplg_filename = "sof-acp-rmb.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_rmb_sof_machines);
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index a03b396d96bb..4aad3fee51cf 100644
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

