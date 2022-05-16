Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6340B52897A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbiEPQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiEPQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:06:49 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0299736309
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZoSdS8SJQh+xX7TPtNZDFCDLKbTIlIDsktQWZkG2tqpk7OAj6U9FcOkRy3/04yHH5Qmwng6silZ+wo8y9XBWeqndhok4P7mJvgrQqn73KorlW9aYA6xOwTH1DQUK2OvVrLN1rs7IWiVw9JwCMCz9qmgfWpnEFqFTpTa0vkBV5kZMBF7QaXx2E2JiCSaSVP6ig9nlP6woFh90CoRsBYvyDuI1vew9e2BxA3rJCivx7Eagaf47JACaDohSbEhtflQrd72s/mCWsrJ/+CLS6OSg+pLAZO8u/jaoVKNMwSkzuPAxw9J6nWMC3ObzBuLmNTP0YIvGQwIqRi82QB9UzFcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRtpiGBzjPMhd/hrbF9i2h1jt8EG6AeCyS4bF0tS3dg=;
 b=njfKb3Jc11gioljkJ9XYslcIyl6KWZ2fmKjHHS9hs9jutZjDHtNz+dqk1V99pbFqkiuR4ZCIVLvKO2RcDIFoMzzwf+wiu8RHpuzLsBFr3EHReNcjDeA4UBAhVLIoxuWWMlkmvfp9HWb6pvF/LmSaekHGbcu5a4YYhjUbWTZMvtOZxVoNkqqBnH+NSo/E3jPhHVCU1g5DOYDlMPn2om1pv7U34mlotuc1aznlvY5CEQxeBwmr7f0jLPg5fuxLrerkGk/WwPPToCRHiLcDFnkmwcPFZmuJJeP9CKOGaAvAfcWkBRPJpxmJdwHqUXAK6c/r31Xu6+OMMyiV7FdcBBcUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRtpiGBzjPMhd/hrbF9i2h1jt8EG6AeCyS4bF0tS3dg=;
 b=OzQNqrcuOH+lqITTCSpeZnKxGxRh7eSsg0rgne4bBzjxColeHfS1EY8M4scgr1ClxoNPAYr8oLHJesqXMX9ocPPZX7P+e1F4YPzNtbwYSDpZ3GuEJ/lQE+C1/T6JDxvsYH84Ik0TOlTuh1cTn1xiBeSa5fnwSR5tCFDU3g4RByg=
Received: from MWH0EPF00056D17.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1b) by BN8PR12MB2930.namprd12.prod.outlook.com
 (2603:10b6:408:69::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 16:06:34 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by MWH0EPF00056D17.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.3 via Frontend
 Transport; Mon, 16 May 2022 16:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 16:06:33 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 11:06:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 09:06:32 -0700
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Mon, 16 May 2022 11:06:23 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <ajitkumar.pandey@amd.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] Revert "ASoC: amd: acp: Power on/off the speaker enable gpio pin based on DAPM callback."
Date:   Mon, 16 May 2022 21:36:10 +0530
Message-ID: <20220516160619.17832-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516160619.17832-1-Vsujithkumar.Reddy@amd.com>
References: <20220516160619.17832-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4acf4f43-9148-48d8-d144-08da37560c60
X-MS-TrafficTypeDiagnostic: BN8PR12MB2930:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29301ED240AA474A71484CFD92CF9@BN8PR12MB2930.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBXsjYOtg66lwjh7QYVW6n8ykTWIUIelGIsnULtMJLhpRrXq1f6Dh5+He5RJXBuArYbF4p8Y0uFT8Uk9CxUzUHl2yKrZhCrZck6UdG3EXxQeCQjyf29D1HZU/rmtipLxMESHxRTHb1gm3caC4yTZAVpgDlOSfQs86VqK0D/2wh/3wilh4su+XAHBgMkBSJqJDBoikJtSyEe1zL4lxStWJAmdiyV9FbK/4RArCh0QicIcf0cW1YlsaPYZdXaBWD51pHLDBK41ooC6EEBhVOQetLtPRB4xwgJxkqDag8aTDkwEWTIZJlaY3Ue1BpAM/HHA93168VDx2Vc2ALijP+rw65FWJlbG+VS452ocQx7L/umRjS4Pnl1k8a6BvIWmHdnE/a24zXDVCtOtNeb+E+IVHIFFuVosdmT2Eadd6OMBVdbqYdkw6lveHfwMe0FR4TPHXiMoAwKdd1i+dkSVuDSI1YmmwZaRzlGQURrvVigFyJjvTnO+4VOo2ydc5ODle9ny6Em+hoGMdN6OULlcZGBDi96FE6N3NhwR0BO2rwKa/TK6+UeUH1aa1NSmtOZyvhA1GXbMCy6rQ5iKOfrAxGn5lX+mYtKeHn6oHTXYZ2FNCEkCGaDix+w7D3VqduWvVRZAGR+MCqmtczZq44CEiP063fRlyQWphUy8WCsg71k4eS1429EknwKnyFMESPAEvGsD6D2zqyza+elE9vD/dGLJtXN/TcSGnxTEe3SgUR09M+4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(81166007)(70206006)(4326008)(26005)(8676002)(70586007)(8936002)(508600001)(1076003)(7696005)(356005)(186003)(336012)(7416002)(5660300002)(36860700001)(2906002)(54906003)(6666004)(2616005)(316002)(36756003)(83380400001)(47076005)(426003)(82310400005)(40460700003)(110136005)(461764006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 16:06:33.8858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acf4f43-9148-48d8-d144-08da37560c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC: amd : acp : Set Speaker enable/disable pin through rt1019 codec driver.

RT1019 codec has two ways of controlling the en_spkr.
one way is controlling through gpio pin method the another way is through codec register update through driver.

Now Speaker enable/disable is controlled  through codec register updated by codec driver.
This patch reverts gpio logic.

This reverts commit 5c5f08f7fc0bee9a1bc3fbdcb7a21cfd0648ab14.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/amd/acp/Kconfig           |  6 +++---
 sound/soc/amd/acp/acp-legacy-mach.c | 21 +++------------------
 sound/soc/amd/acp/acp-mach-common.c | 25 -------------------------
 sound/soc/amd/acp/acp-mach.h        | 10 +---------
 sound/soc/amd/acp/acp-sof-mach.c    | 21 +++------------------
 5 files changed, 10 insertions(+), 73 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 626e4a5cb06a..9dae2719084c 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -42,7 +42,7 @@ config SND_AMD_ASOC_RENOIR
 
 config SND_SOC_AMD_MACH_COMMON
 	tristate
-	depends on X86 && PCI && I2C && GPIOLIB
+	depends on X86 && PCI && I2C
 	select CLK_FIXED_FCH
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_DMIC
@@ -54,14 +54,14 @@ config SND_SOC_AMD_MACH_COMMON
 
 config SND_SOC_AMD_LEGACY_MACH
 	tristate "AMD Legacy Machine Driver Support"
-	depends on X86 && PCI && I2C && GPIOLIB
+	depends on X86 && PCI && I2C
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables legacy sound card support for ACP audio.
 
 config SND_SOC_AMD_SOF_MACH
 	tristate "AMD SOF Machine Driver Support"
-	depends on X86 && PCI && I2C && GPIOLIB
+	depends on X86 && PCI && I2C
 	select SND_SOC_AMD_MACH_COMMON
 	help
 	  This option enables SOF sound card support for ACP audio.
diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 442d5644e0f3..7f04a048ca3a 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -27,7 +27,6 @@ static struct acp_card_drvdata rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_GB,
 };
 
 static struct acp_card_drvdata rt5682s_max_data = {
@@ -37,7 +36,6 @@ static struct acp_card_drvdata rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_NONE,
 };
 
 static struct acp_card_drvdata rt5682s_rt1019_data = {
@@ -47,7 +45,6 @@ static struct acp_card_drvdata rt5682s_rt1019_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_NONE,
 };
 
 static const struct snd_kcontrol_new acp_controls[] = {
@@ -62,16 +59,15 @@ static const struct snd_kcontrol_new acp_controls[] = {
 static const struct snd_soc_dapm_widget acp_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_SPK("Spk", event_spkr_handler),
-	SND_SOC_DAPM_SPK("Left Spk", event_spkr_handler),
-	SND_SOC_DAPM_SPK("Right Spk", event_spkr_handler),
+	SND_SOC_DAPM_SPK("Spk", NULL),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
 };
 
 static int acp_asoc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
-	unsigned int spkr_gpio;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -89,20 +85,9 @@ static int acp_asoc_probe(struct platform_device *pdev)
 	card->controls = acp_controls;
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
-	spkr_gpio = ((struct acp_card_drvdata *)(card->drvdata))->gpio_spkr_en;
 
 	acp_legacy_dai_links_create(card);
 
-	if (gpio_is_valid(spkr_gpio)) {
-		ret = devm_gpio_request(dev, spkr_gpio, "spkren");
-		if (ret) {
-			dev_err(dev, "(%s) gpio request failed: %d\n",
-				__func__, ret);
-			return ret;
-		}
-		gpio_direction_output(spkr_gpio, 0);
-	}
-
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 51adb8f3f83e..6ae454bf60af 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -71,31 +71,6 @@ static const struct snd_soc_dapm_route rt5682_map[] = {
 	{ "IN1P", NULL, "Headset Mic" },
 };
 
-int event_spkr_handler(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *k, int event)
-{
-	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct snd_soc_card *card = dapm->card;
-	struct acp_card_drvdata *drvdata = snd_soc_card_get_drvdata(card);
-
-	if (!gpio_is_valid(drvdata->gpio_spkr_en))
-		return 0;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		gpio_set_value(drvdata->gpio_spkr_en, 1);
-		break;
-	case SND_SOC_DAPM_PRE_PMD:
-		gpio_set_value(drvdata->gpio_spkr_en, 0);
-		break;
-	default:
-		dev_warn(card->dev, "%s invalid setting\n", __func__);
-		break;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(event_spkr_handler, SND_SOC_AMD_MACH);
-
 /* Define card ops for RT5682 CODEC */
 static int acp_card_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 {
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index fd6299844ebe..5dc47cfbff10 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -17,12 +17,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <sound/soc.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
-
-#define EN_SPKR_GPIO_GB                0x11F
-#define EN_SPKR_GPIO_NK                0x146
-#define EN_SPKR_GPIO_NONE      -EINVAL
 
 enum be_id {
 	HEADSET_BE_ID = 0,
@@ -55,11 +49,9 @@ struct acp_card_drvdata {
 	unsigned int dai_fmt;
 	struct clk *wclk;
 	struct clk *bclk;
-	unsigned int gpio_spkr_en;
 };
 
 int acp_sofdsp_dai_links_create(struct snd_soc_card *card);
 int acp_legacy_dai_links_create(struct snd_soc_card *card);
-int event_spkr_handler(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *k, int event);
+
 #endif
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 8243765d490f..d1531cdab110 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -27,7 +27,6 @@ static struct acp_card_drvdata sof_rt5682_rt1019_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = RT1019,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_GB,
 };
 
 static struct acp_card_drvdata sof_rt5682_max_data = {
@@ -37,7 +36,6 @@ static struct acp_card_drvdata sof_rt5682_max_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_NK,
 };
 
 static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
@@ -56,7 +54,6 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_NK,
 };
 
 static const struct snd_kcontrol_new acp_controls[] = {
@@ -70,16 +67,15 @@ static const struct snd_kcontrol_new acp_controls[] = {
 static const struct snd_soc_dapm_widget acp_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_SPK("Spk", event_spkr_handler),
-	SND_SOC_DAPM_SPK("Left Spk", event_spkr_handler),
-	SND_SOC_DAPM_SPK("Right Spk", event_spkr_handler),
+	SND_SOC_DAPM_SPK("Spk", NULL),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
 };
 
 static int acp_sof_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
-	unsigned int spkr_gpio;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -97,20 +93,9 @@ static int acp_sof_probe(struct platform_device *pdev)
 	card->controls = acp_controls;
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
-	spkr_gpio = ((struct acp_card_drvdata *)(card->drvdata))->gpio_spkr_en;
 
 	acp_sofdsp_dai_links_create(card);
 
-	if (gpio_is_valid(spkr_gpio)) {
-		ret = devm_gpio_request(dev, spkr_gpio, "spkren");
-		if (ret) {
-			dev_err(dev, "(%s) gpio request failed: %d\n",
-				__func__, ret);
-			return ret;
-		}
-		gpio_direction_output(spkr_gpio, 0);
-	}
-
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.25.1

