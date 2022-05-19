Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0837C52CBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiESF4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiESF4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:56:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417D2BF4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlhMPmp6PwJkinpHXVXknKrAdX5w4BpeHRaY6E3iDb4z/3tb+CPiHQccbsRtnIyatBAGeXJ/2kGeZNZetLoDF6xWdoHpgAJkHzhtD0mOvAqEbhvDCmQ+Q7b5uU93NCxxkGxPPVvKcC66C3nWqy3acv/Sw12gAkcuU6LpOuFFB452Xdkl+jb+qI0IBlANa9iYOvfgFGjVGofIdwbCT5p2D2ePOKHpxmjV7Y/CaDCU+gPeOKqXV+yGdH8hYZ89cMRkLtlmRDnSKAsgW5z13P8UlrMEstF/ngY5apbeuNzHUI1if4NFpOAvKU0VIsgfFiaFeE10seu8aviQQoqPwDYiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM0ec8zE+d8Vh6hwrgTjzCEGeE1GkPBj5C4Om4rcvHI=;
 b=aU3FjyDNwTd28KyPbDepHuIgF+yqobgRTBfTdRzGSgfXp17JZRtbAVEBZe9qYq/nQEBmkxtnDhf3lY2Fs+hcj6uygE20DlCnsm1e6KJPq1l9RymhUElShGyx6DhLQyUYHWosDNDgrw8gaiAwCGkg/BjfQGSRA8t8z0F7L9bQfpiyYH06QixDGIvgYD8abW+jntKmqbq+bS6rZcYsOdsX217fDsXBYpyQ7/bt36CTl0BBaz/uZvOqMxZQJc/v4V1KmCxMlYFkiVOl9OUCxsrUZPtDisNFSqe7tIXsEdFy13l9IADN2TpejGj3gEoPi/+SUBI1DWH1wyZisG7rFxJo2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM0ec8zE+d8Vh6hwrgTjzCEGeE1GkPBj5C4Om4rcvHI=;
 b=UP99t3TBMVJpsJzdYGJOPQNmDCfC24CT2zE6RaYDFc/VZOWxMPjEqsObT9eKkkFdDPp+wuhf+6VE9hXl7duBMqHOKpbiTH8d6Ju/Bp26yRMVFtobYbmvHLPnXYeiuFmhaYFAKa1UTnqRSVjxX7FH67tciTseaRdp+ZXjwoJA1Wg=
Received: from DM6PR17CA0027.namprd17.prod.outlook.com (2603:10b6:5:1b3::40)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 05:55:48 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::ce) by DM6PR17CA0027.outlook.office365.com
 (2603:10b6:5:1b3::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 19 May 2022 05:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:55:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 00:55:34 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Thu, 19 May 2022 00:55:23 -0500
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] ASoC: amd: acp: Add support for nau8825 and max98360 card
Date:   Thu, 19 May 2022 11:25:21 +0530
Message-ID: <20220519055522.1613813-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519055522.1613813-1-Vsujithkumar.Reddy@amd.com>
References: <20220519055522.1613813-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b100252-fd62-4bac-aabe-08da395c360a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5771:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB577143B29A53FFE0B75DED5692D09@DM4PR12MB5771.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57n98q7bl3GfvuycI4bb3DzQoVuFcGwSgH9C5k4tfATrumxOMkMsppqp9c9mxgC7ktlRHh+8xgqna/drLzaGQZtxLI1itwwCZtqyoeYhJJD7Pq87gtE4Zwaj1SYwazQyUDolFZ54lkSTjrAyzXC6D6wwDFCwMOKkRX41hm0xcY7jw/wBOvW6c59gdgzrjedrVPMDhHt7XuAJyt1U3reizJM+itxirBv5/qphCalPbFofZt6syzPuRfLl4lEST+J89SXmeJfaqqK2y2msLu57+OsVx/PJE3bY0cBogHu7Nt9TDR+SCbq9ALSQFDP6q1KKhyXM2LEa/9G3QWoqjGhVKFoB5n4rmqrSaFFz9lqAKv5Ja6feItKxCM7L4rzMRw4wl82Ia2aFY4vPfsThRPq9thC49vW66BFFjG+z4VL6rC9WZuiR1J2RDZADA/mL/Cn3fbvbm8aZCuKzUQ5R+882COM3STt8FJX9Nvnu6QmL62YiylRO9CBk+GFlIGNTOXwDV/PLjuTUUee5lXs4ZvVeuDU9QyUVwKChUIWBDPLuIBD+jAW2OUesUyhqcvCVM98cSniWAZOhpfwvOIOPwYJ5c/G4zR1PXeYCNwNWj9RQaMJTqmjfGsIUkdXoDM6A95zD/9ISrM7nlgRBuJiacjSuc/5lEOpSUwSRwevL+hB0kDu30octDcmKwZRDY5oMweeIpmF73UYpH3pclnQYJi2tbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(26005)(7416002)(70586007)(4326008)(8676002)(336012)(110136005)(8936002)(508600001)(86362001)(81166007)(5660300002)(54906003)(1076003)(7696005)(36860700001)(186003)(356005)(30864003)(2906002)(2616005)(316002)(83380400001)(36756003)(47076005)(426003)(82310400005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:55:43.1852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b100252-fd62-4bac-aabe-08da395c360a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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
 sound/soc/amd/acp/acp-mach-common.c | 159 ++++++++++++++++++++++++++--
 sound/soc/amd/acp/acp-mach.h        |   3 +
 sound/soc/amd/acp/acp-sof-mach.c    |  15 +++
 sound/soc/amd/mach-config.h         |   1 +
 6 files changed, 194 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 5cbc82eca4c9..f73c187fee03 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -130,4 +130,25 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_sof_machines);
 
+struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
+	{
+		.id = "AMDI1019",
+		.drv_name = "rmb-dsp",
+		.pdata = (void *)&acp_quirk_data,
+		.fw_filename = "sof-rmb.ri",
+		.sof_tplg_filename = "sof-acp-rmb.tplg",
+	},
+	{
+		.id = "10508825",
+		.drv_name = "nau8825-max",
+		.pdata = (void *)&acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_max,
+		.fw_filename = "sof-rmb.ri",
+		.sof_tplg_filename = "sof-acp-rmb.tplg",
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
index 6ae454bf60af..3ffe816c59c9 100644
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

