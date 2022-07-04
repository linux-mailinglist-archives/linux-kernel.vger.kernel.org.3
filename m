Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A720A56584A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiGDOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiGDOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:09:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F295FA7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1UPducnr7H4I64IV19Aw7U/XXTA5jHSyAq1qPY0JoAh6hiYfbpRZ+mftGhPDcGvGhdRCmHsNdFAFqlXMRlybGOMavHwT9NMBBtHZkTXHxhnSRP5gR1n1TVK/Rrrbsd/dO1qnsX9ATjDScUHUtuhkdIhvdmtYYCcZMEfmAP43X5FQ2auSo8GKWV9Uf4fZcUHaNs79OcvkmJ/Wl1H9cRhONhbI359BQ+DCPOngyiQtBk1d6zadYprwCjGbG0AvroxHyaWl8g/2tklX9DCKMyGLrUgvK6O16/Rwy4AZ0i+/td8NN5lgCnH94xs9pC8z/vfNKjydjjiCyTedBRZHRqq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDfxYz3ylHAAfHM5U317utt1dQ0zSoIOoY46/Zl1W9w=;
 b=BAeOLnIppQwEve4QJju8LAFH862faT8NqakQXCWLAbzxhRzlfAeOOOd0jPRzkpTpJxK5SGoemKb1vz5HoO49wBOnxOACoKogSEQ5oCq5NkKEXcOa25BYGHzeLxsiDrwz1tQMeF3i0pOCjCqe93TdOSWboaWRi5nzyBxfrZKtbFv8Mwz9Lh/dBi03lwz5h1R0KQqLtpY5HSEi2itYUvcpRf3qtNXPc7QRKqqnOKOx+FVR83rWLcEmk6yc5wfTD7kmjAfNKDFKzZ0X6DNF8cm4v/hvgYMw4IxJCOxbF2CZiODuOunx+HAwMpBl1NcF/0oytlXZUwgtj3gCcDcico8Lkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDfxYz3ylHAAfHM5U317utt1dQ0zSoIOoY46/Zl1W9w=;
 b=Jzp+O1HkCOT/3MWZhRhOZQkkVpqzQGEAYXqkb/1QAgPsao0IfvNY7rcPWW+TUcDOmPWypPAhGH5WWjIbl5dGmeseZQYTu7DnyGEp3fgdkpwIrmORbx1epQm3rhkYzUrrYBBC2tJoadiNvG6u/nsIIFCHs5sgNsH3pXB9shoZ9j0=
Received: from MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::24)
 by DM6PR12MB2908.namprd12.prod.outlook.com (2603:10b6:5:185::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 14:08:59 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::43) by MW4P220CA0019.outlook.office365.com
 (2603:10b6:303:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 14:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 14:08:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 09:08:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 09:08:57 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 4 Jul 2022 09:08:54 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <zhuning@everest-semi.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND V2 2/3] ASoC: amd: add Machine driver for Jadeite platform
Date:   Mon, 4 Jul 2022 19:38:34 +0530
Message-ID: <20220704140837.1215534-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704140837.1215534-1-Vijendar.Mukunda@amd.com>
References: <20220704140837.1215534-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b342eaf9-4653-4d9e-b356-08da5dc6bd83
X-MS-TrafficTypeDiagnostic: DM6PR12MB2908:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5nrA/+2qcRsgM86Rn+YRgurH9zsH1xxfU0wIgonW5RekuO0CNMevQSiDLFPiun68giHTM0/fp1QDMf5a9XXyRy6wP1fPzSS764MpTEBnRa6loJH6Mz/cCz/UAQmFf4+TcmyXFvlGh7QfZtOL4A4DYEzIqv9uLx1bo61FuuUIfWO1f0gpjzdi0VEZlHG25AdXd3CKAYg4Evt40n6ayJWzXHGYwSdVLr6gtED4qfvZAQnQmcbZaVmHl8onui8a1ddaQJk9nHnUM6D4wCA8+m+tmmnnZZLA/L/HlRe77n42AlumvhgauXfn2KZqZSXFBvFJTwedVO9M5Yj0cLF6vq3FDZtCiAYcrwT+azRRnIlRfXq3vaQgiKkFhTUJCpQhmVfIdDyfKJfYwJe4PYcPxSfWgS7OXH7SA3UjJ6zjYtke4rlGrqmX6Jt9mFATrCTi2kPpM87I9lwOPirOMTiOOEJZHo8xOmakXo9MoUhZUnKTUUqqJbCSfQYMp/Ru4QpFrIjq55zFB/7TY3Fv8vOOJ9DNxNoCw4KXfBEUMeCJWExHqL0Add1Ex02hRkLzwviqGpLUXQoA/KuRtcpLdOopn+grbBK+Yc8KEQpqYJ65AQY0yLOaxPhmsb28ViTeXLFP2rFC1LWfY/Ytrbi/QcBVZE2spl//5vJp7gW+j9wf/xQ7exit6iUmReGbyOWrT8WmCO+q3NL1LNGjx+070i6KhQEStqMrW7SEEn62KsictKYzVdtvKzxgSCFPXyrp3bE0KKy6VaUqLQkmsKM4+jchE/EarXSZXKOgxmyPoTA5TbbkcfdZgTgkYhcLA7C4iMnmyLx4VZ7rjDYi1V4vpAIbx3e21a0v6n2E4GRuil9R0C53IaNEKa6crlaKgTH7AafPELP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(2906002)(8936002)(5660300002)(40480700001)(82310400005)(40460700003)(83380400001)(34020700004)(36860700001)(356005)(36756003)(81166007)(82740400003)(4326008)(478600001)(8676002)(70206006)(110136005)(54906003)(316002)(2616005)(1076003)(70586007)(186003)(41300700001)(336012)(6666004)(7696005)(47076005)(426003)(86362001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 14:08:58.8904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b342eaf9-4653-4d9e-b356-08da5dc6bd83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Machine driver for Jadeite platform which uses ES8336 codec.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Changes since v1:
      - as sysclk is fixed, moved code to startup() callback.
      - Removed unused macros (ST_PLAT_CLK & ST_ES8336_GPIO_QUIRK) from code. 
---
 sound/soc/amd/acp-es8336.c | 324 +++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)
 create mode 100644 sound/soc/amd/acp-es8336.c

diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
new file mode 100644
index 000000000000..eec3d57092fa
--- /dev/null
+++ b/sound/soc/amd/acp-es8336.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Machine driver for AMD Stoney platform using ES8336 Codec
+ *
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ */
+
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+#include <linux/gpio.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+
+#include "../codecs/es8316.h"
+#include "acp.h"
+
+#define DUAL_CHANNEL	2
+#define DRV_NAME "acp2x_mach"
+#define ST_JADEITE	1
+#define ES8336_PLL_FREQ (48000 * 256)
+
+static unsigned long acp2x_machine_id;
+static struct snd_soc_jack st_jack;
+struct device *codec_dev;
+struct gpio_desc *gpio_pa;
+
+static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
+					  struct snd_kcontrol *kcontrol, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpiod_set_value_cansleep(gpio_pa, true);
+	else
+		gpiod_set_value_cansleep(gpio_pa, false);
+
+	return 0;
+}
+
+static struct snd_soc_jack_pin st_es8316_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
+static int st_es8336_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+	struct snd_soc_card *card;
+	struct snd_soc_component *codec;
+
+	codec = asoc_rtd_to_codec(rtd, 0)->component;
+	card = rtd->card;
+
+	ret = snd_soc_card_jack_new_pins(card, "Headset", SND_JACK_HEADSET | SND_JACK_BTN_0,
+					 &st_jack, st_es8316_jack_pins,
+					 ARRAY_SIZE(st_es8316_jack_pins));
+	if (ret) {
+		dev_err(card->dev, "HP jack creation failed %d\n", ret);
+		return ret;
+	}
+	snd_jack_set_key(st_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	ret = snd_soc_component_set_jack(codec, &st_jack, NULL);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static const unsigned int st_channels[] = {
+	DUAL_CHANNEL,
+};
+
+static const unsigned int st_rates[] = {
+	48000,
+};
+
+static const struct snd_pcm_hw_constraint_list st_constraints_rates = {
+	.count = ARRAY_SIZE(st_rates),
+	.list  = st_rates,
+	.mask = 0,
+};
+
+static const struct snd_pcm_hw_constraint_list st_constraints_channels = {
+	.count = ARRAY_SIZE(st_channels),
+	.list = st_channels,
+	.mask = 0,
+};
+
+static int st_es8336_codec_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_card *card;
+	struct acp_platform_info *machine;
+	struct snd_soc_dai *codec_dai;
+	int ret;
+
+	runtime = substream->runtime;
+	rtd = asoc_substream_to_rtd(substream);
+	card = rtd->card;
+	machine = snd_soc_card_get_drvdata(card);
+	codec_dai = asoc_rtd_to_codec(rtd, 0);
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, ES8336_PLL_FREQ, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
+		return ret;
+	}
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &st_constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &st_constraints_rates);
+
+	machine->play_i2s_instance = I2S_MICSP_INSTANCE;
+	machine->cap_i2s_instance = I2S_MICSP_INSTANCE;
+	machine->capture_channel = CAP_CHANNEL0;
+	return 0;
+}
+
+static const struct snd_soc_ops st_es8336_ops = {
+	.startup = st_es8336_codec_startup,
+};
+
+SND_SOC_DAILINK_DEF(designware1,
+		    DAILINK_COMP_ARRAY(COMP_CPU("designware-i2s.2.auto")));
+SND_SOC_DAILINK_DEF(codec,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-ESSX8336:00", "ES8316 HiFi")));
+SND_SOC_DAILINK_DEF(platform,
+		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp_audio_dma.1.auto")));
+
+static struct snd_soc_dai_link st_dai_es8336[] = {
+	{
+		.name = "amdes8336",
+		.stream_name = "ES8336 HiFi Play",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBP_CFP,
+		.stop_dma_first = 1,
+		.dpcm_capture = 1,
+		.dpcm_playback = 1,
+		.init = st_es8336_init,
+		.ops = &st_es8336_ops,
+		SND_SOC_DAILINK_REG(designware1, codec, platform),
+	},
+};
+
+static const struct snd_soc_dapm_widget st_widgets[] = {
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+
+	SND_SOC_DAPM_SUPPLY("Speaker Power", SND_SOC_NOPM, 0, 0,
+			    sof_es8316_speaker_power_event,
+			    SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
+};
+
+static const struct snd_soc_dapm_route st_audio_route[] = {
+	{"Speaker", NULL, "HPOL"},
+	{"Speaker", NULL, "HPOR"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"MIC1", NULL, "Headset Mic"},
+	{"MIC2", NULL, "Internal Mic"},
+	{"Speaker", NULL, "Speaker Power"},
+};
+
+static const struct snd_kcontrol_new st_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+};
+
+static const struct acpi_gpio_params pa_enable_gpio = { 0, 0, false };
+static const struct acpi_gpio_mapping acpi_es8336_gpios[] = {
+	{ "pa-enable-gpios", &pa_enable_gpio, 1 },
+	{ }
+};
+
+static int st_es8336_late_probe(struct snd_soc_card *card)
+{
+	struct acpi_device *adev;
+	int ret;
+
+	adev = acpi_dev_get_first_match_dev("ESSX8336", NULL, -1);
+	if (adev)
+		put_device(&adev->dev);
+	codec_dev = acpi_get_first_physical_node(adev);
+	if (!codec_dev)
+		dev_err(card->dev, "can not find codec dev\n");
+
+	ret = devm_acpi_dev_add_driver_gpios(codec_dev, acpi_es8336_gpios);
+
+	gpio_pa = gpiod_get_optional(codec_dev, "pa-enable", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio_pa)) {
+		ret = dev_err_probe(card->dev, PTR_ERR(gpio_pa),
+				    "could not get pa-enable GPIO\n");
+		gpiod_put(gpio_pa);
+		put_device(codec_dev);
+	}
+	return 0;
+}
+
+static struct snd_soc_card st_card = {
+	.name = "acpes8336",
+	.owner = THIS_MODULE,
+	.dai_link = st_dai_es8336,
+	.num_links = ARRAY_SIZE(st_dai_es8336),
+	.dapm_widgets = st_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(st_widgets),
+	.dapm_routes = st_audio_route,
+	.num_dapm_routes = ARRAY_SIZE(st_audio_route),
+	.controls = st_mc_controls,
+	.num_controls = ARRAY_SIZE(st_mc_controls),
+	.late_probe = st_es8336_late_probe,
+};
+
+static int st_es8336_quirk_cb(const struct dmi_system_id *id)
+{
+	acp2x_machine_id = ST_JADEITE;
+	return 1;
+}
+
+static const struct dmi_system_id st_es8336_quirk_table[] = {
+	{
+		.callback = st_es8336_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMD"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jadeite"),
+		},
+	},
+	{
+		.callback = st_es8336_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "IP3 Technology CO.,Ltd."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ASN1D"),
+		},
+	},
+	{
+		.callback = st_es8336_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Standard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ASN10"),
+		},
+	},
+	{}
+};
+
+static int st_es8336_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct snd_soc_card *card;
+	struct acp_platform_info *machine;
+
+	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info), GFP_KERNEL);
+	if (!machine)
+		return -ENOMEM;
+
+	dmi_check_system(st_es8336_quirk_table);
+	switch (acp2x_machine_id) {
+	case ST_JADEITE:
+		card = &st_card;
+		st_card.dev = &pdev->dev;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, machine);
+	ret = devm_snd_soc_register_card(&pdev->dev, &st_card);
+	if (ret) {
+		return dev_err_probe(&pdev->dev, ret,
+				     "devm_snd_soc_register_card(%s) failed\n",
+				     card->name);
+	}
+	return 0;
+}
+
+static int st_es8336_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id st_audio_acpi_match[] = {
+	{"AMDI8336", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, st_audio_acpi_match);
+#endif
+
+static struct platform_driver st_mach_driver = {
+	.driver = {
+		.name = "st-es8316",
+		.acpi_match_table = ACPI_PTR(st_audio_acpi_match),
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = st_es8336_probe,
+	.remove = st_es8336_remove,
+};
+
+module_platform_driver(st_mach_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("st-es8316 audio support");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

