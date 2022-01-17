Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DDC49083E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiAQMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:06:49 -0500
Received: from mail-co1nam11on2085.outbound.protection.outlook.com ([40.107.220.85]:60673
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239659AbiAQMGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:06:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY7cbUVRAvkXCcSIY0YwJdAo95kuYfX6Mjg4Zt/CuVsInwInWAHWfcza1S5T7+Y+/eVN6rHT816NxzoUs/KWE4au5pimgwlJizOc6ObiQjliEbkd1aRZcZBt5E0RzydVFcu7PNQNRa0zALSOlF4tNrUl4M8dWccW+ogpNwmWfTwG2sDwLc731jV8KE7mH+ETowLb3/IlCIkAkRdwUSC7TwXI5rIn1YPv5wOmAsjGPmcNBDkgelbu2NAF6O1hvuWyIS/LQOKBf5CMRPHMlA6lPE5uiFHSQnJotT+JFpV9ldeFOvriUR82kPQlor+QD8kGk6oa/wfNT38LqA6O43y1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppHUfDUk+agPrmWRC0tuEquQUmFJfTzq6QJ8FNbIKZ4=;
 b=Go6HLj5RZx5wFzUSXq8+brAMuzp2xemAzrSLcpBIKmBCYc4iRAEVySMLLD2O1ysmmiwJNsiIOf1zzl2lnuhhXwOz8XicjKDbXsR+CPUrORhi7rCNnUNA9gbm8OZUSGtAWZlrGWtfriQTMbviH7/nFgp2z/V3INsjAd5ERgWjnexBtp4vof+qEkP0qCPB5pKtrA9/UJ9BTGqKVffYT3ZPpoJCC+BxTefiiok4OOjCowqEopkzyS9coSfwaPo9UbNQkFRIkg7lJsIbS5AXk1V/ADX7g2ulmuU4QOfPAnley+KwX95sa0pVcFaYtTVeQV1cZ0Ku9YkYOc8j6esQ4MMm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppHUfDUk+agPrmWRC0tuEquQUmFJfTzq6QJ8FNbIKZ4=;
 b=GgkHPLoKVXR4tlbAa9z1ulsBFPtT0INhsZ8MsYUB1MGJbSYxq4a04VLq8ERJ8+qc07TzqZ3Kg+Bu9mISJSzzAk3WGcwUC2w/1L3OZ3wiIPpCv2Bwu86pcKQJfsyu6gDO2iFjsE7w+lpz3ECGpOQYrQm9UN3HPvJHiFdM4AA9PEM=
Received: from MWHPR2001CA0016.namprd20.prod.outlook.com
 (2603:10b6:301:15::26) by CY4PR1201MB0085.namprd12.prod.outlook.com
 (2603:10b6:910:1c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 12:06:42 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::47) by MWHPR2001CA0016.outlook.office365.com
 (2603:10b6:301:15::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 12:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 12:06:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 06:06:41 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Mon, 17 Jan 2022 06:06:31 -0600
From:   V sujith kumar Reddy <vsujithkumar.reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ajitkumar.pandey@amd.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Julian Braha <julianbraha@gmail.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] CHROMIUM:ASOC: amd: Add Machine driver Support for rt5682s codec
Date:   Tue, 18 Jan 2022 01:48:52 +0530
Message-ID: <20220117201856.3299086-1-vsujithkumar.reddy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b92f251-75fc-49a0-6367-08d9d9b1d33f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0085:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00858876BF39F9F9425AB99492579@CY4PR1201MB0085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6ufGReY978MhmUwT/XL3vtebQ3p1II5H1dir6L8L2f8sUDGyT1B30Ux4btz2TJ8jPVA4vK+YBguHLbIlwljWC7N8/MsKPYyTUVIcjjUBR4FQAcULTtJ5mwIJmIaluC9gqhWz8FctTzPtLrQVBX6f2br7emul+pwljhvPq5P0s3K7W2YM7TL+WAZJ/kLV+TkXXkNPT5JxUlcZgNEfGRCZKKEChrp/wdVCl0NqX9xpcSlpF6GqzWIXA2dZ6d284iISitbm/UJsMFD7qkqBhe/2paZD8zPtw76s7igddHbg/Mni7gVD2SwScpMFQ7wNrS8AGOJVJ5qa/IP0rLrwkmhE8L44jxNZPN/eBlJwqhySdhQjOEak+DksnOUiacEP7EJ0ZoFhGEaPLYUkI387hZ2XLAtlZ9PZ/bjx23mLsi3+LAmCRkfOE9zICc25sSp2S9s9GCZwGYZeCe14XJHrr7mQy8uodYFVmGvLUN066whWo11OKD6kvuZObheXAD8v/Rx7YI3JpVy6TxE9wzbgZ3F5JeOqKDQB0EnR/YmZ7QOScdX+6uBuu9AOBqwotdohK+d9eRmdLIocAwf4erQCnaQ8ct71d999Aq+dsRJ9rdXdOGykOToqum6xRzaJDzuZnCMS06Oll0eEv7rXhUOTk23n/5JHtTtk9eviqTzUcthvrEqyhIzQFZVjqea3FMAq6uvUsWbdrcK2cidsT77ZUpfQWsIN80hWx8yNH3BZCTaxYOuQ//HGk6LFqEjg6giU+eOulNflUnCILEMxpf59OvmJuSFPjuItjmag1AjNJODXIg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(8676002)(70206006)(426003)(83380400001)(356005)(40460700001)(82310400004)(316002)(7696005)(36756003)(110136005)(86362001)(186003)(8936002)(1076003)(26005)(6666004)(2616005)(54906003)(336012)(36860700001)(7416002)(4326008)(47076005)(508600001)(5660300002)(70586007)(2906002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 12:06:42.4659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b92f251-75fc-49a0-6367-08d9d9b1d33f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sound card  support with rt5682s as headset codec and max98357 as
speaker amp codec on Raven based chrome platform

Signed-off-by: V sujith kumar Reddy <vsujithkumar.reddy@amd.com>
---
 sound/soc/amd/Kconfig                |   1 +
 sound/soc/amd/acp3x-rt5682-max9836.c | 111 ++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 7a9e45094f37..5eb855eb4b7e 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -36,6 +36,7 @@ config SND_SOC_AMD_RV_RT5682_MACH
 	select SND_SOC_MAX98357A
 	select SND_SOC_CROS_EC_CODEC
 	select I2C_CROS_EC_TUNNEL
+	select SND_SOC_RT5682S
 	select SND_SOC_RT1015
 	select SND_SOC_RT1015P
 	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC && GPIOLIB
diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index dad70436d063..9b74b2a8da26 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -20,6 +20,7 @@
 #include <linux/acpi.h>
 
 #include "raven/acp3x.h"
+#include "../codecs/rt5682s.h"
 #include "../codecs/rt5682.h"
 #include "../codecs/rt1015.h"
 
@@ -39,6 +40,77 @@ enum {
 	EC,
 };
 
+static int acp3x_5682s_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_component *component = codec_dai->component;
+
+	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
+
+	/* set rt5682s dai fmt */
+	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+			| SND_SOC_DAIFMT_NB_NF
+			| SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		dev_err(rtd->card->dev,
+			"Failed to set rt5682s dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	/* set codec PLL */
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL2, RT5682S_PLL_S_MCLK,
+				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set rt5682s PLL: %d\n", ret);
+		return ret;
+	}
+
+	/* Set codec sysclk */
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682S_SCLK_S_PLL2,
+				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev,
+			"Failed to set rt5682s SYSCLK: %d\n", ret);
+		return ret;
+	}
+
+	/* Set tdm/i2s1 master bclk ratio */
+	ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+	if (ret < 0) {
+		dev_err(rtd->dev,
+			"Failed to set rt5682s tdm bclk ratio: %d\n", ret);
+		return ret;
+	}
+
+	rt5682_dai_wclk = clk_get(component->dev, "rt5682-dai-wclk");
+	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");
+
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &pco_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "HP jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
@@ -271,6 +343,8 @@ SND_SOC_DAILINK_DEF(acp3x_i2s,
 SND_SOC_DAILINK_DEF(acp3x_bt,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp3x_i2s_playcap.2")));
 
+SND_SOC_DAILINK_DEF(rt5682s,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-RTL5682:00", "rt5682s-aif1")));
 SND_SOC_DAILINK_DEF(rt5682,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5682:00", "rt5682-aif1")));
 SND_SOC_DAILINK_DEF(max,
@@ -458,6 +532,19 @@ static struct snd_soc_card acp3x_1015p = {
 	.num_controls = ARRAY_SIZE(acp3x_mc_1015p_controls),
 };
 
+static struct snd_soc_card acp3x_5682s = {
+	.name = "acp3xrt5682s98357",
+	.owner = THIS_MODULE,
+	.dai_link = acp3x_dai,
+	.num_links = ARRAY_SIZE(acp3x_dai),
+	.dapm_widgets = acp3x_1015p_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(acp3x_1015p_widgets),
+	.dapm_routes = acp3x_1015p_route,
+	.num_dapm_routes = ARRAY_SIZE(acp3x_1015p_route),
+	.controls = acp3x_mc_1015p_controls,
+	.num_controls = ARRAY_SIZE(acp3x_mc_1015p_controls),
+};
+
 void *soc_is_rltk_max(struct device *dev)
 {
 	const struct acpi_device_id *match;
@@ -468,6 +555,27 @@ void *soc_is_rltk_max(struct device *dev)
 	return (void *)match->driver_data;
 }
 
+static void card_hs_dai_link_present(struct snd_soc_dai_link *links,
+					const char *card_name)
+{
+	if (!strcmp(card_name, "acp3xrt5682s98357")) {
+		links[0].name = "acp3x-5682s-play";
+		links[0].stream_name = "Playback";
+		links[0].dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				   SND_SOC_DAIFMT_CBM_CFM;
+
+		links[0].codecs = rt5682s;
+		links[0].num_codecs = ARRAY_SIZE(rt5682s);
+		links[0].init = acp3x_5682s_init;
+		links[0].dpcm_playback = 1;
+		links[0].dpcm_capture = 1;
+		links[0].cpus = acp3x_i2s;
+		links[0].num_cpus = ARRAY_SIZE(acp3x_i2s);
+		links[0].platforms = platform;
+		links[0].num_platforms = ARRAY_SIZE(platform);
+	}
+}
+
 static void card_spk_dai_link_present(struct snd_soc_dai_link *links,
 						const char *card_name)
 {
@@ -497,7 +605,7 @@ static int acp3x_probe(struct platform_device *pdev)
 	machine = devm_kzalloc(&pdev->dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
-
+	card_hs_dai_link_present(card->dai_link, card->name);
 	card_spk_dai_link_present(card->dai_link, card->name);
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
@@ -523,6 +631,7 @@ static const struct acpi_device_id acp3x_audio_acpi_match[] = {
 	{ "AMDI5682", (unsigned long)&acp3x_5682},
 	{ "AMDI1015", (unsigned long)&acp3x_1015},
 	{ "10021015", (unsigned long)&acp3x_1015p},
+	{ "10029835", (unsigned long)&acp3x_5682s},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, acp3x_audio_acpi_match);
-- 
2.25.1

