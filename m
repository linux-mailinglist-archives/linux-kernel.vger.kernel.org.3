Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A30E52C998
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiESCIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiESCIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:08:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B983DA47
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXX5MyNiwbgcosJiWz8jKcIPmil4tKk+RzYJBIekK/s0BGXlKNjGeV8dY3LRFhTPaU0X+Ghj2LtOa9AoDO4vE8jKslx8BJfVCYBwVf5EzraCyN0f3W9vwg8V55r/ZXVeWmWGrSdPiITzF4y4SeuMVnsv1rP/K3ybB2tZkGo3SY7G/IY5tV4v57jOX51jabnY/oHh/yx3z340VANxFN/0NR6ykiFNiKsGyuscQJpSRJelTzMQy46kZ+/wS2Zy42K7Vh7qdSQjq37Ub8SBp/zsbJ1jpN+/DUemNcyv4roytVjT/mClGcqXMD1mfTJVkQwqjEHPjY86FkHP1Zp7aMn3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuFkbC0iavo7tmnJmptCXW0JHdzOsqdrVIvjpnUkcto=;
 b=LSfJN1LCF0EU2IOcjtz57fr9YK9J+gQoOoadqmVOCayR6NL2lEJs1wPqyWLympMhUjwZyneKc93GXETWTf+5mc+SdR/YE1D5xnt8IGI4a5q5ZsxoGqV2M2vWo1xOor68Ff4skZWvCkI0pbm4m2y+FyvataTvy02QFWfUlhq6aksHGRlKTwjFQIKUJhF+lHfUmjpaIKPHn+wyAmYY4pKDceG+aedKgZkMLDP6BgOQw3Xj8QUWxuMOUo+bMmZNZZBvD9E9IU1EoM4amUCuhLkNmQiZBtpFIv8PWdZdVUHbqzmszSTTJDF8ulUE2VgnQ8VfSZ5W088T/BZlhHg9bup+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuFkbC0iavo7tmnJmptCXW0JHdzOsqdrVIvjpnUkcto=;
 b=EYkRpKXWT66b5OdjSZ+3EBpeCs3IeR4VD3g5tcv4thtfYItkpuKLpTmUkib2G4BS1IPPlt75bE+O9/Jl+gZoixUNO8lVb4gJ0P3+G2p3Z8AyBXJci/5qmjMZfaDHvwUsQnxtK3sY8FgDk7lbCrLvtLW98h6Qpjzw5Yc82fxnHyY=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 02:08:47 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::16) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Thu, 19 May 2022 02:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 02:08:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 21:08:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 21:08:46 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Wed, 18 May 2022 21:08:36 -0500
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
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] ASoC: amd: acp: Add support for nau8825 and max98360 card
Date:   Thu, 19 May 2022 07:38:40 +0530
Message-ID: <20220519020841.1607723-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519020841.1607723-1-Vsujithkumar.Reddy@amd.com>
References: <20220519020841.1607723-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d47bce32-8b92-41bd-fe93-08da393c8216
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1280E40415B4F4713233046292D09@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzYM1P4oFOOwhZuyYXVdDOVaqJ6KpyQ+4+g0pDvJFWRBkKQh+Z16Rveyo0vi0+fS2PTnApqlAQp8OB5S3fGfIsoZAgA1Wc9hsJ04JUMuvDBo7SDIUGENx/jF6gI7OwYKXIA4nd4ape0g6D+hVAgLfwRlpZkZL3PoJ3gd0ua0NWC4IU8WG3wGvsC8a3VZa+R/zXPMV9psWS3wXPLYBumkMYHCukiAAAj/5CV8zJv5SykybEZcXYJHzWRU2TMWZeSfZLEYu9nDkDVic+Za1lt7/fg2ODpXGmOzL23QvmlcKeXf8kZzXDeAyUOZnyNg5mrf9Jl8AF8UQHS9kTQheKZG60bNKKCkpIv+9vBkpO/mRSwnm2BVqo5SScz9W0pZ+ENKpERuJ448srU80Qtg8F/5h/QAewhB1P7eGWxdGZr1FI2/Ijz19kohCB2nhlQMwriw9LRBeapFG65F1uCQqEVBMx5FAQTPS5IwIjSnBSbB3D9VUZQnMEukK6qLnznWnCYTm7SUemZbp7Ntr9rd5Nom87s+LBiEEjgYUS0Xlp5Ibu4D0G98m01ABHTIA1R4JNMZmuq4ScqiU11VeO1uxh7Pj/S19GjEhdUEFCJZDBB3da0wlUHXCluF4vbvS2WRF/Bam/327HHPuvevtNVT6bdIlMch9Qf0uHxkfZPWJofBHAkiJn8dLPWZYk6QCPRLPAEYJnNQPs9AOq1ZOrII+E2KEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(82310400005)(70206006)(508600001)(4326008)(70586007)(110136005)(8676002)(316002)(36756003)(36860700001)(54906003)(7696005)(86362001)(1076003)(7416002)(81166007)(8936002)(83380400001)(6666004)(426003)(47076005)(5660300002)(40460700003)(356005)(30864003)(186003)(2906002)(336012)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 02:08:46.8931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d47bce32-8b92-41bd-fe93-08da393c8216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
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
 sound/soc/amd/acp-config.c          |   9 ++
 sound/soc/amd/acp/Kconfig           |   1 +
 sound/soc/amd/acp/acp-mach-common.c | 159 ++++++++++++++++++++++++++--
 sound/soc/amd/acp/acp-mach.h        |   3 +
 sound/soc/amd/acp/acp-sof-mach.c    |  15 +++
 5 files changed, 181 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index b28dadf778ae..49c571e92a20 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -138,6 +138,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
 		.fw_filename = "sof-rmb.ri",
 		.sof_tplg_filename = "sof-acp-rmb.tplg",
 	},
+	{
+		.id = "10508825",
+		.drv_name = "nau8825-max",
+		.pdata = (void *)&acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_max,
+		.fw_filename = "sof-rmb.ri",
+		.sof_tplg_filename = "sof-acp-rmb.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_rmb_sof_machines);
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
index 7da583112250..9e0f1399a5ab 100644
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
 
@@ -409,6 +414,97 @@ static const struct snd_soc_ops acp_card_maxim_ops = {
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
@@ -437,6 +533,8 @@ SND_SOC_DAILINK_DEF(i2s_sp,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-i2s-sp")));
 SND_SOC_DAILINK_DEF(sof_sp,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp")));
+SND_SOC_DAILINK_DEF(sof_hs,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs")));
 SND_SOC_DAILINK_DEF(sof_dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
 SND_SOC_DAILINK_DEF(pdm_dmic,
@@ -491,6 +589,31 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
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
@@ -523,6 +646,30 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
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
index dc2786cc81ef..eac858b1f20d 100644
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
@@ -142,4 +156,5 @@ MODULE_ALIAS("platform:rt5682-rt1019");
 MODULE_ALIAS("platform:rt5682-max");
 MODULE_ALIAS("platform:rt5682s-max");
 MODULE_ALIAS("platform:rt5682s-rt1019");
+MODULE_ALIAS("platform:nau8825-max");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

