Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E71539053
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbiEaMI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344073AbiEaMIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:08:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D762A09
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZMoc5xElSboU7q7JiRbO2LsFeqFD30XlZYPZV3ljNPSYDsQAdaVF3Hd1SYzMyL3RgA+bT+3KszzPKaNBzPojA6iwyUnVIo2KsOrA+C09Q7ifE7aqFLqv7E1ZJCUAGovjjVojKG4fOed/SVUowyjwOkuqXLV8LC9Sg7jHGla8aUpk5614hfwhfLqrDXp9cSupt/5Ua4ZPliQuxfp6u6tsPKYxSNfDijuNBenOdIlo/+AdO64KKf+M4xTUBwCrRY/FWGUDzo6LEeZA7umrCVEeI3BgIY+DXvL2z/E9GkkgHraFEeP7W/zd71GSM5F4cFV0BXv6mKhVXkeuhtg8A+Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+yiWdStfW+a7Hy0C9NIvL6dPHRp495Uo7hs7r/ynHk=;
 b=hl9kqRYdaHml9+g8QmolMvnbYjPZfypDLpQCsFhyAfDDJfEu06n3fnYZ+2aUuO6PNT34EHeHa+kBxJ6/7JnkZkm5BJ6eVRPFNF7NvHUkKVnavg+F2pLdiQwFsQs0UWERXjC7TNer5pWXsL7dKXRx8jZs37Iy2RT/R3segs6j4KJ11/9QSNxD4iIKBblW8jNmXr/E106MAK1gMwy9ux6HCAAxiNV30RXvB7Cc7iVdDxR3KkRCRY5NdkLnUGSm8qXPNN5rIFHHBBx2pkBN6sDRDZLru6HB99eEPVb9u0ZBoXZZsEp0qMeKlWE8fUXse6h7Wh33S3VjF5IAKQh2UpqLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+yiWdStfW+a7Hy0C9NIvL6dPHRp495Uo7hs7r/ynHk=;
 b=T9gpAlu0qnKGVZKULjr0V45nvrGDlUMiHzAPwrd2YS9ngI4EerYtV6UUY7a0DF+v8zVfi9G8sKRD6ehFppQKtw10paoPdVMqPBpOptI3qTM671EcVeEt2zuuHrX9jP7rtfs9MJAI/kHj7YhDKTNJKTamlVIAsxgr52VLFtM5PFA=
Received: from BN9PR03CA0722.namprd03.prod.outlook.com (2603:10b6:408:110::7)
 by CY4PR12MB1672.namprd12.prod.outlook.com (2603:10b6:910:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 12:08:17 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::54) by BN9PR03CA0722.outlook.office365.com
 (2603:10b6:408:110::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 12:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 12:08:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 07:08:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 07:08:10 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 31 May 2022 07:07:59 -0500
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        "Jia-Ju Bai" <baijiaju1990@gmail.com>,
        Bard Liao <bard.liao@intel.com>,
        "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/2] ASoC: amd: acp: Add support for nau8825 and max98360 card
Date:   Tue, 31 May 2022 17:38:11 +0530
Message-ID: <20220531120813.47116-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531120813.47116-1-Vsujithkumar.Reddy@amd.com>
References: <20220531120813.47116-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad5907e-5242-4cf9-a817-08da42fe3f12
X-MS-TrafficTypeDiagnostic: CY4PR12MB1672:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16726471A4E9ECAD3CBB5D7892DC9@CY4PR12MB1672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXlfF6SJsMyP6Z840pPborDHwlZyGANsab+CgA1HLj6O2zQsKVcNjhZJl/EJbpwrNOINNkkuyM3cntqzNM4nC3wdzp6Zc+p642PegVyYwKhwoBaJUfqyVGJ3ow1nAQNhaQMkoGYq9GBMynlnzB7ASUV8/WmYXC7M+uemoAwqhp+irsZgS2YZ+h069C6wl+czhnnob6c6H3a4i31qXOJjuCjq80n+tgmVO6heeaO6CVsrPM0w+YcaiTGvwHBKApk9+f8SXS5UsHOCuhtMvWYe6j7Zisx0B+tGPdg9WQUam99qrU1qmvg8utZ2XB47bnJS7xo3fvVcoUiV/R24x5UsGI9zpwJ6Z9JtvvlGvaO3tevuvYlb9r9qfFM2DNs2noGHxMal0ot09+lhaz1s15+O7XYtQDAu8UOTuNB4gWopuzsL+I2Zfm4Lg+nOR161uoi/Qv0XjLmcnLNWe4FgTJnyUnuSZmOvAqwbBf26Q4mr31qbhLSdiw5eqJceWQL7Bp+8ADyGQbUb0YSLq3lYMx1JKFYTTQ7kVJK+sst66yKVX9mfestJsjlu9oRGtlKAdbMSeq7H3DSInfKhWsBDilopmxvUdnWtD4dS7LdGsTcydeeynciRkLG5pcLjwFKqnTInyUPN2aig2bJOaQUB7OrFve4EV7OBzIRplYvLNFa0TzLcjT7GIpWY4w0+mdQY7cP2sFYr1O+ehARMOdGxO7wpRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(2616005)(54906003)(2906002)(36756003)(316002)(82310400005)(26005)(40460700003)(110136005)(36860700001)(81166007)(70586007)(70206006)(186003)(5660300002)(7696005)(4326008)(8676002)(356005)(86362001)(6666004)(47076005)(83380400001)(426003)(336012)(8936002)(508600001)(7416002)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 12:08:17.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad5907e-5242-4cf9-a817-08da42fe3f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have new platform with nau8825 as a primary codec and max98360 as an
amp codec. Add machine struct to register sof audio based sound card
on such Chrome machine.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/amd/acp-config.c          |  21 ++++
 sound/soc/amd/acp/Kconfig           |   1 +
 sound/soc/amd/acp/acp-mach-common.c | 166 +++++++++++++++++++++++++++-
 sound/soc/amd/acp/acp-mach.h        |   3 +
 sound/soc/amd/acp/acp-sof-mach.c    |  15 +++
 sound/soc/amd/mach-config.h         |   1 +
 6 files changed, 201 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 5cbc82eca4c9..3b9f851bf50d 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -130,4 +130,25 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_sof_machines);
 
+struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
+	{
+		.id = "AMDI1019",
+		.drv_name = "rmb-dsp",
+		.pdata = &acp_quirk_data,
+		.fw_filename = "sof-rmb.ri",
+		.sof_tplg_filename = "sof-acp-rmb.tplg",
+	},
+	{
+		.id = "10508825",
+		.drv_name = "nau8825-max",
+		.pdata = &acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_max,
+		.fw_filename = "sof-rmb.ri",
+		.sof_tplg_filename = "sof-rmb-nau8825-max98360.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL(snd_soc_acpi_amd_rmb_sof_machines);
+
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 9dae2719084c..7e56d2644105 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -49,6 +49,7 @@ config SND_SOC_AMD_MACH_COMMON
 	select SND_SOC_RT1019
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5682S
+	select SND_SOC_NAU8825
 	help
 	  This option enables common Machine driver module for ACP.
 
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 6ae454bf60af..a03b396d96bb 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -24,6 +24,7 @@
 #include "../../codecs/rt5682.h"
 #include "../../codecs/rt1019.h"
 #include "../../codecs/rt5682s.h"
+#include "../../codecs/nau8825.h"
 #include "acp-mach.h"
 
 #define PCO_PLAT_CLK 48000000
@@ -175,7 +176,8 @@ static void acp_card_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 
-	clk_disable_unprepare(drvdata->wclk);
+	if (!drvdata->soc_mclk)
+		clk_disable_unprepare(drvdata->wclk);
 }
 
 static const struct snd_soc_ops acp_card_rt5682_ops = {
@@ -363,7 +365,7 @@ static int acp_card_amp_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
-	int ret;
+	int ret = 0;
 
 	runtime->hw.channels_max = DUAL_CHANNEL;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
@@ -371,10 +373,13 @@ static int acp_card_amp_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				      &constraints_rates);
 
-	ret = acp_clk_enable(drvdata);
-	if (ret < 0)
-		dev_err(rtd->card->dev, "Failed to enable AMP clk: %d\n", ret);
-
+	if (!drvdata->soc_mclk) {
+		ret = acp_clk_enable(drvdata);
+		if (ret < 0) {
+			dev_err(rtd->card->dev, "Failed to enable AMP clk: %d\n", ret);
+			return ret;
+		}
+	}
 	return ret;
 }
 
@@ -409,6 +414,104 @@ static const struct snd_soc_ops acp_card_maxim_ops = {
 	.shutdown = acp_card_shutdown,
 };
 
+/* Declare nau8825 codec components */
+SND_SOC_DAILINK_DEF(nau8825,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10508825:00", "nau8825-hifi")));
+
+static const struct snd_soc_dapm_route nau8825_map[] = {
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
+};
+
+static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_component *component = codec_dai->component;
+	unsigned int fmt;
+	int ret;
+
+	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
+
+	if (drvdata->hs_codec_id != NAU8825)
+		return -EINVAL;
+
+	if (drvdata->soc_mclk)
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBC_CFC;
+	else
+		fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBP_CFP;
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &pco_jack);
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
+	return snd_soc_dapm_add_routes(&rtd->card->dapm, nau8825_map, ARRAY_SIZE(nau8825_map));
+}
+
+static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS,
+				     (48000 * 256), SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, params_rate(params),
+				  params_rate(params) * 256);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set FLL: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int acp_nau8825_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = 2;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_list(runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+	return 0;
+}
+
+static const struct snd_soc_ops acp_card_nau8825_ops = {
+	.startup =  acp_nau8825_startup,
+	.hw_params = acp_nau8825_hw_params,
+};
+
 /* Declare DMIC codec components */
 SND_SOC_DAILINK_DEF(dmic_codec,
 		DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec", "dmic-hifi")));
@@ -437,6 +540,8 @@ SND_SOC_DAILINK_DEF(i2s_sp,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-i2s-sp")));
 SND_SOC_DAILINK_DEF(sof_sp,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp")));
+SND_SOC_DAILINK_DEF(sof_hs,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs")));
 SND_SOC_DAILINK_DEF(sof_dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
 SND_SOC_DAILINK_DEF(pdm_dmic,
@@ -491,6 +596,31 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 		i++;
 	}
 
+	if (drv_data->hs_cpu_id == I2S_HS) {
+		links[i].name = "acp-headset-codec";
+		links[i].id = HEADSET_BE_ID;
+		links[i].cpus = sof_hs;
+		links[i].num_cpus = ARRAY_SIZE(sof_hs);
+		links[i].platforms = sof_component;
+		links[i].num_platforms = ARRAY_SIZE(sof_component);
+		links[i].dpcm_playback = 1;
+		links[i].dpcm_capture = 1;
+		links[i].nonatomic = true;
+		links[i].no_pcm = 1;
+		if (!drv_data->hs_codec_id) {
+			/* Use dummy codec if codec id not specified */
+			links[i].codecs = dummy_codec;
+			links[i].num_codecs = ARRAY_SIZE(dummy_codec);
+		}
+		if (drv_data->hs_codec_id == NAU8825) {
+			links[i].codecs = nau8825;
+			links[i].num_codecs = ARRAY_SIZE(nau8825);
+			links[i].init = acp_card_nau8825_init;
+			links[i].ops = &acp_card_nau8825_ops;
+		}
+		i++;
+	}
+
 	if (drv_data->amp_cpu_id == I2S_SP) {
 		links[i].name = "acp-amp-codec";
 		links[i].id = AMP_BE_ID;
@@ -523,6 +653,30 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 		i++;
 	}
 
+	if (drv_data->amp_cpu_id == I2S_HS) {
+		links[i].name = "acp-amp-codec";
+		links[i].id = AMP_BE_ID;
+		links[i].cpus = sof_hs;
+		links[i].num_cpus = ARRAY_SIZE(sof_hs);
+		links[i].platforms = sof_component;
+		links[i].num_platforms = ARRAY_SIZE(sof_component);
+		links[i].dpcm_playback = 1;
+		links[i].nonatomic = true;
+		links[i].no_pcm = 1;
+		if (!drv_data->amp_codec_id) {
+			/* Use dummy codec if codec id not specified */
+			links[i].codecs = dummy_codec;
+			links[i].num_codecs = ARRAY_SIZE(dummy_codec);
+		}
+		if (drv_data->amp_codec_id == MAX98360A) {
+			links[i].codecs = max98360a;
+			links[i].num_codecs = ARRAY_SIZE(max98360a);
+			links[i].ops = &acp_card_maxim_ops;
+			links[i].init = acp_card_maxim_init;
+		}
+		i++;
+	}
+
 	if (drv_data->dmic_cpu_id == DMIC) {
 		links[i].name = "acp-dmic-codec";
 		links[i].id = DMIC_BE_ID;
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 5dc47cfbff10..c95ee1c52eb1 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -26,6 +26,7 @@ enum be_id {
 
 enum cpu_endpoints {
 	NONE = 0,
+	I2S_HS,
 	I2S_SP,
 	I2S_BT,
 	DMIC,
@@ -37,6 +38,7 @@ enum codec_endpoints {
 	RT1019,
 	MAX98360A,
 	RT5682S,
+	NAU8825,
 };
 
 struct acp_card_drvdata {
@@ -49,6 +51,7 @@ struct acp_card_drvdata {
 	unsigned int dai_fmt;
 	struct clk *wclk;
 	struct clk *bclk;
+	bool soc_mclk;
 };
 
 int acp_sofdsp_dai_links_create(struct snd_soc_card *card);
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index d1531cdab110..adbae809f2aa 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -56,6 +56,16 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.dmic_codec_id = DMIC,
 };
 
+static struct acp_card_drvdata sof_nau8825_data = {
+	.hs_cpu_id = I2S_HS,
+	.amp_cpu_id = I2S_HS,
+	.dmic_cpu_id = DMIC,
+	.hs_codec_id = NAU8825,
+	.amp_codec_id = MAX98360A,
+	.dmic_codec_id = DMIC,
+	.soc_mclk = true,
+};
+
 static const struct snd_kcontrol_new acp_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -124,6 +134,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "rt5682s-rt1019",
 		.driver_data = (kernel_ulong_t)&sof_rt5682s_rt1019_data
 	},
+	{
+		.name = "nau8825-max",
+		.driver_data = (kernel_ulong_t)&sof_nau8825_data
+	},
 	{ }
 };
 static struct platform_driver acp_asoc_audio = {
@@ -143,4 +157,5 @@ MODULE_ALIAS("platform:rt5682-rt1019");
 MODULE_ALIAS("platform:rt5682-max");
 MODULE_ALIAS("platform:rt5682s-max");
 MODULE_ALIAS("platform:rt5682s-rt1019");
+MODULE_ALIAS("platform:nau8825-max");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index 0a54567a2841..7b4c625da40d 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -19,6 +19,7 @@
 #define ACP_PCI_DEV_ID			0x15E2
 
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[];
 
 struct config_entry {
 	u32 flags;
-- 
2.25.1

