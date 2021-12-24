Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED7647EC40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351562AbhLXGtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:49:18 -0500
Received: from mail-dm3nam07on2085.outbound.protection.outlook.com ([40.107.95.85]:39840
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351547AbhLXGtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:49:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyf6hIRaalgrkm3bhkYrmmoEt0wxpunUWOxpE0u7HgqUbKoae1R9mpat5ZEiFyEjb5lTAKZOtVrQaB77e8TtdheUfekheVQPpV/aCmhcLMC/u7ac824Mx0u/yK3NOCrFTwyiWB5yaLdkOWmPT95c1xjpEcA+CgqW2vGwEc7vZvgW9cRGdrOHW8YvKG1ee1bcmyrzpVxlvga2lxGvZPLiuwF9eenuWpmZl7H1aPOOCeW3uCLnnH9NCaiEIhLS7/2dE9aRjI6bO1o5SMBAWkpDl5oOR7WyDRVdghAs66yOuv5bOhWtJJwX2pEBZslU7+50t1YrPtxopI+0POYkKqFysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6LMz7Yoi27L63wZ/I3ay6P8cXRud0Rk7r6R3yJ+jsU=;
 b=cqJYty5G4YBcKgJdc9bCIlSXqhtEvEdmGysqoyYUlGhUtjtBJh6h2EN5BTLiivViWdSjuAmHTKJHNUZf8QPT2LEmGq5y5DTlCQhKS9TbHlQe8ERVBYqB5WGLvXa0QezXBMTSChTRpGt5fU4q4bZv8iZYzvDJWz0WyZPJA0MSAdWNCzIh12VWYSMCgNn3NALUQ4vmgret9CxvYUEoqg+lKlJZXCEvpw7XcsKRwnwUtY6iWlN6PgOgILZ+R3PE8dSzcg2l1nghVX8Fhsw/e8lZ+10/F4Yk3KWpbtGEb8l8exSV6RYShlH3AP34EA/hVai/tiDAnF9oS1HCTR3toYX+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6LMz7Yoi27L63wZ/I3ay6P8cXRud0Rk7r6R3yJ+jsU=;
 b=mXZUAYECeYjG86XSXAGAcfpmVQpTC3Lm/pqIB/6bC5OaUbPmy4AzSh/YG2yB8jWgfNjR78QAJdMMiHZIqWWbsGuTMwZkSEAJXXm7YCp9WD4UBt8f7n9zacQ0FawyVDdVuMexNZifIZpW5i51Ntplqj/4L7U24Zvf+Dde0rNY1XA=
Received: from DM5PR15CA0050.namprd15.prod.outlook.com (2603:10b6:3:ae::12) by
 BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 06:49:15 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::37) by DM5PR15CA0050.outlook.office365.com
 (2603:10b6:3:ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14 via Frontend
 Transport; Fri, 24 Dec 2021 06:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 06:49:14 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 24 Dec
 2021 00:49:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 22:49:13 -0800
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Fri, 24 Dec 2021 00:49:05 -0600
From:   V sujith kumar Reddy <vsujithkumar.reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ajitkumar.pandey@amd.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Power on/off the speaker enable gpio pin based on DAPM callback.
Date:   Fri, 24 Dec 2021 20:30:43 +0530
Message-ID: <20211224150058.2444776-1-vsujithkumar.reddy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab977388-1be9-430a-0ae1-08d9c6a98000
X-MS-TrafficTypeDiagnostic: BN9PR12MB5082:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB508231B6E50F4E4C0D0B5F22927F9@BN9PR12MB5082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9Yl8VtTskCjfV9dmkKPz9so+TEPwXXZlI7hCtZPz/yTiX021Eg3igmIs1wMfbQucEOOeHgKU2n6GYfGRnwnkJzID9fALui5WM3JsGcS3YdJQhCti7jA8SDU/rn7vrq7K3kgj7L/C6uU+IqiuU+owUW48+odS62NUrviiEqcavdfsDEHgbVY+Dwhcd6FCrmqVE42W89KLcFjWX+y9goWCLetgYv+mJYi1F4wjnNWzm0GX++OCuaEYkSqJdyodAJOk7waeuFKVedlK5M1uBxbn6A7lrE8tzdPPC2aWkb1IJT/A5dDtGzoMYXJxDxH2C2rFvRcQL9ieSlizcIwuCchITNeobBYNZFqwfSioMNGBTSxA6xkWhdhLuzTOhSQ1daNrSPYAnyNDbhctypJVdE7nBp3sgZcJV+nzue64PIo+CtCUP/5rgfYtUMSbDymK4readOjdb4PBBFAu3L4RXal/1ACnwe9EuPccvZ4vgP4j6ryAdbl+GlnUMrNZemaB1M4ueadljhLyY7sijkOQz+Te6PwdzleEARisr/l3bZ+RyzRAs+26ZUoi1W182TJ07ixcWUP0YoqiZnQgibNCgZjZL+WnkHiTBgYcwjaodD8zsbfse3HiLhoty6JrmDn4SYk6Uz4bCwXVSSkDLxpf49zSV1rd+E4YvidRTW8CTi0bLLL1EX6ZjwDhcR5Y9qGel6+b/H5Ck1+unt84ZJ8piZcJdvduef1wHh/K/BLzojkXCjr6tYBegk7MWMRmFW0JQiMLix8K+7xMPglZrdEF97nqHhQraaKfjxOoJqZCdDnkghhnolfFuVzNvOlJO+vx7bq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(336012)(83380400001)(70206006)(2616005)(40460700001)(508600001)(82310400004)(5660300002)(70586007)(426003)(8936002)(4326008)(8676002)(7696005)(1076003)(6666004)(81166007)(36756003)(110136005)(36860700001)(54906003)(86362001)(26005)(2906002)(186003)(356005)(47076005)(316002)(461764006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 06:49:14.7957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab977388-1be9-430a-0ae1-08d9c6a98000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the speaker gpio pin based on power sequence of the DAPM
speaker events.
Enable speaker after widget power up and Disable before widget  powerdown.

Signed-off-by: V sujith kumar Reddy <vsujithkumar.reddy@amd.com>
---
 sound/soc/amd/acp/Kconfig           |  6 +++---
 sound/soc/amd/acp/acp-legacy-mach.c | 19 ++++++++++++++++---
 sound/soc/amd/acp/acp-mach-common.c | 25 +++++++++++++++++++++++++
 sound/soc/amd/acp/acp-mach.h        | 10 +++++++++-
 sound/soc/amd/acp/acp-sof-mach.c    | 21 ++++++++++++++++++---
 5 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 154be5e70821..d5838df3064b 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -32,7 +32,7 @@ config SND_AMD_ASOC_RENOIR
 
 config SND_SOC_AMD_MACH_COMMON
 	tristate
-	depends on X86 && PCI && I2C
+	depends on X86 && PCI && I2C && GPIOLIB
 	select CLK_FIXED_FCH
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_DMIC
@@ -44,14 +44,14 @@ config SND_SOC_AMD_MACH_COMMON
 
 config SND_SOC_AMD_LEGACY_MACH
 	tristate "AMD Legacy Machine Driver Support"
-	depends on X86 && PCI && I2C
+	depends on X86 && PCI && I2C && GPIOLIB
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables legacy sound card support for ACP audio.
 
 config SND_SOC_AMD_SOF_MACH
 	tristate "AMD SOF Machine Driver Support"
-	depends on X86 && PCI && I2C
+	depends on X86 && PCI && I2C && GPIOLIB
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables SOF sound card support for ACP audio.
diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index de0f8024e2fb..0ad1cf41b308 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -27,6 +27,7 @@ static struct acp_card_drvdata rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = NONE,
+	.gpio_spkr_en = EN_SPKR_GPIO_GB,
 };
 
 static const struct snd_kcontrol_new acp_controls[] = {
@@ -41,15 +42,16 @@ static const struct snd_kcontrol_new acp_controls[] = {
 static const struct snd_soc_dapm_widget acp_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_SPK("Spk", NULL),
-	SND_SOC_DAPM_SPK("Left Spk", NULL),
-	SND_SOC_DAPM_SPK("Right Spk", NULL),
+	SND_SOC_DAPM_SPK("Spk", event_spkr_handler),
+	SND_SOC_DAPM_SPK("Left Spk", event_spkr_handler),
+	SND_SOC_DAPM_SPK("Right Spk", event_spkr_handler),
 };
 
 static int acp_asoc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
+	unsigned int spkr_gpio;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -67,9 +69,20 @@ static int acp_asoc_probe(struct platform_device *pdev)
 	card->controls = acp_controls;
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
+	spkr_gpio = ((struct acp_card_drvdata *)(card->drvdata))->gpio_spkr_en;
 
 	acp_legacy_dai_links_create(card);
 
+	if (gpio_is_valid(spkr_gpio)) {
+		ret = devm_gpio_request(dev, spkr_gpio, "spkren");
+		if (ret) {
+			dev_err(dev, "(%s) gpio request failed: %d\n",
+				__func__, ret);
+			return ret;
+		}
+		gpio_direction_output(spkr_gpio, 0);
+	}
+
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 7785f12aa006..03d8d1af14b3 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -71,6 +71,31 @@ static const struct snd_soc_dapm_route rt5682_map[] = {
 	{ "IN1P", NULL, "Headset Mic" },
 };
 
+int event_spkr_handler(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct acp_card_drvdata *drvdata = snd_soc_card_get_drvdata(card);
+
+	if (!gpio_is_valid(drvdata->gpio_spkr_en))
+		return 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		gpio_set_value(drvdata->gpio_spkr_en, 1);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		gpio_set_value(drvdata->gpio_spkr_en, 0);
+		break;
+	default:
+		dev_warn(card->dev, "%s invalid setting\n", __func__);
+		break;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(event_spkr_handler, SND_SOC_AMD_MACH);
+
 /* Define card ops for RT5682 CODEC */
 static int acp_card_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 {
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 5dc47cfbff10..fd6299844ebe 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -17,6 +17,12 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <sound/soc.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+
+#define EN_SPKR_GPIO_GB                0x11F
+#define EN_SPKR_GPIO_NK                0x146
+#define EN_SPKR_GPIO_NONE      -EINVAL
 
 enum be_id {
 	HEADSET_BE_ID = 0,
@@ -49,9 +55,11 @@ struct acp_card_drvdata {
 	unsigned int dai_fmt;
 	struct clk *wclk;
 	struct clk *bclk;
+	unsigned int gpio_spkr_en;
 };
 
 int acp_sofdsp_dai_links_create(struct snd_soc_card *card);
 int acp_legacy_dai_links_create(struct snd_soc_card *card);
-
+int event_spkr_handler(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event);
 #endif
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 854eb7214cea..07de46142655 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -27,6 +27,7 @@ static struct acp_card_drvdata sof_rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
+	.gpio_spkr_en = EN_SPKR_GPIO_GB,
 };
 
 static struct acp_card_drvdata sof_rt5682_max_data = {
@@ -36,6 +37,7 @@ static struct acp_card_drvdata sof_rt5682_max_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
+	.gpio_spkr_en = EN_SPKR_GPIO_NK,
 };
 
 static struct acp_card_drvdata sof_rt5682s_max_data = {
@@ -45,6 +47,7 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
+	.gpio_spkr_en = EN_SPKR_GPIO_NK,
 };
 
 static const struct snd_kcontrol_new acp_controls[] = {
@@ -58,15 +61,16 @@ static const struct snd_kcontrol_new acp_controls[] = {
 static const struct snd_soc_dapm_widget acp_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_SPK("Spk", NULL),
-	SND_SOC_DAPM_SPK("Left Spk", NULL),
-	SND_SOC_DAPM_SPK("Right Spk", NULL),
+	SND_SOC_DAPM_SPK("Spk", event_spkr_handler),
+	SND_SOC_DAPM_SPK("Left Spk", event_spkr_handler),
+	SND_SOC_DAPM_SPK("Right Spk", event_spkr_handler),
 };
 
 static int acp_sof_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
+	unsigned int spkr_gpio;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -84,9 +88,20 @@ static int acp_sof_probe(struct platform_device *pdev)
 	card->controls = acp_controls;
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
+	spkr_gpio = ((struct acp_card_drvdata *)(card->drvdata))->gpio_spkr_en;
 
 	acp_sofdsp_dai_links_create(card);
 
+	if (gpio_is_valid(spkr_gpio)) {
+		ret = devm_gpio_request(dev, spkr_gpio, "spkren");
+		if (ret) {
+			dev_err(dev, "(%s) gpio request failed: %d\n",
+				__func__, ret);
+			return ret;
+		}
+		gpio_direction_output(spkr_gpio, 0);
+	}
+
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.25.1

