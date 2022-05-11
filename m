Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A049A522DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbiEKHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiEKHzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:55:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F55535B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:55:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i17so1099577pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7gDnW0XSqikMUlMZPgjhyW8BpXJpmKZKb9FEE4UL+c=;
        b=sFBcYvwsb1SAhyTA9KooIqeZamTb5k25SJeG4T96QyIVXnGFSq7MaH8YQ/QWyhL8kW
         ySAUGhMt1dkcDhpys4dbjaURIjltDuMIiMD5JL9CMBUePFRl8cLnc7LuDIi7IaC1Il+6
         xgO07aePuZfFhY5u1zSO+1jSK4fDWxBFW2e5G733CBYd19U0BztbmC3MjIA3aV9Sez0d
         jRHb9GW8VchISJuPbaWNh+uEhHIpn6+G3mi7tyXBmYsKMM/NU6QTew+3qYwEge8BRddK
         MPklW1QvVyQ2r6eBGicGjBIJPMruBYpCZ9gdqA5dTndDlnN/8m2rBuNmy8JOAqIAkrRw
         ssPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7gDnW0XSqikMUlMZPgjhyW8BpXJpmKZKb9FEE4UL+c=;
        b=zdXgGyWrVC+8O2bo3vngRkWoBD2Byq99KArlwHXdRNE/ZIqpbP9wXLzFrCYb7eqWQS
         L4pCjcedwzgzl36irQg9ZcFOm/0O7USbYGnf1s3sPaFGBVBgf6HreWfwt0t19NBLmRx8
         ZZMkk5KAXDf0LgM5ggn80BlL5QRI1xXWTrjgyEATcd1m6P09wN70iKcfOmAZ9Ma6PbPt
         Gp1IhNUu17dmM0v8Yzqx+EvTVTuep6b7lWMaaroxF7KMmfshHyPR0ncAWYeh3yHlFar4
         mXr1yBKyVwS/xTfn8v69d0dsSflzo6t/qv0t69hKWNpVkcYKn6ROE+22yUM0VrMXCMYY
         1DuQ==
X-Gm-Message-State: AOAM531c+YmR09wGLWjBCcM6HYeEb4894xFVkk+dEYJrvrttVUnzcVIU
        /H2KyVJXQ3sCsjq3B/a7ZFm8vA==
X-Google-Smtp-Source: ABdhPJyx5oh9Y0wWD4Cn4kNmbCeZxqZuiUsSYPhBYC4yp3eB4rT4FEUDo+FMvWv0PXgE8wpRKh0Mdw==
X-Received: by 2002:a17:90a:a82:b0:1da:3763:5cf5 with SMTP id 2-20020a17090a0a8200b001da37635cf5mr4041161pjw.55.1652255731522;
        Wed, 11 May 2022 00:55:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:478:2175:da2c:5d1f:57bd:6e64])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b0050dc7628197sm911765pfv.113.2022.05.11.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 00:55:31 -0700 (PDT)
From:   Terry Chen <terry_chen@wistron.corp-partner.google.com>
To:     alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        brent.lu@intel.com, cujomalainey@chromium.org,
        seanpaul@chromium.org, terry_chen@wistron.corp-partner.google.com,
        casey.g.bowman@intel.com,
        mark_hsieh@wistron.corp-partner.google.com,
        vamshi.krishna.gopal@intel.com, mac.chiang@intel.com,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [v5]  ASoC: Intel: sof_cs42l42: adding support for ADL configuration and BT offload audio
Date:   Wed, 11 May 2022 15:55:22 +0800
Message-Id: <20220511075522.1764114-1-terry_chen@wistron.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to do  driver data for adl_mx98360a_cs4242 which supports
two max98360a speaker amplifiers on SSP1 and cs42l42 headphone codec
on SSP0 running on ADL platform. Also add the capability to machine driver
of creating DAI Link for BT offload. Although BT offload always uses SSP2
port but we reserve the flexibility to assign the port number in macro.

Signed-off-by: Terry Chen <terry_chen@wistron.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_cs42l42.c          | 92 ++++++++++++++++++-
 .../intel/common/soc-acpi-intel-adl-match.c   |  7 ++
 2 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index ce78c18798876..442f13de6cd55 100644
--- a/sound/soc/intel/boards/sof_cs42l42.c
+++ b/sound/soc/intel/boards/sof_cs42l42.c
@@ -41,8 +41,13 @@
 #define SOF_CS42L42_DAILINK_MASK		(GENMASK(24, 10))
 #define SOF_CS42L42_DAILINK(link1, link2, link3, link4, link5) \
 	((((link1) | ((link2) << 3) | ((link3) << 6) | ((link4) << 9) | ((link5) << 12)) << SOF_CS42L42_DAILINK_SHIFT) & SOF_CS42L42_DAILINK_MASK)
-#define SOF_MAX98357A_SPEAKER_AMP_PRESENT	BIT(25)
-#define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(26)
+#define SOF_BT_OFFLOAD_PRESENT			BIT(25)
+#define SOF_CS42L42_SSP_BT_SHIFT		26
+#define SOF_CS42L42_SSP_BT_MASK			(GENMASK(28, 26))
+#define SOF_CS42L42_SSP_BT(quirk)	\
+	(((quirk) << SOF_CS42L42_SSP_BT_SHIFT) & SOF_CS42L42_SSP_BT_MASK)
+#define SOF_MAX98357A_SPEAKER_AMP_PRESENT	BIT(29)
+#define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(30)
 
 enum {
 	LINK_NONE = 0,
@@ -50,6 +55,7 @@ enum {
 	LINK_SPK = 2,
 	LINK_DMIC = 3,
 	LINK_HDMI = 4,
+	LINK_BT = 5,
 };
 
 /* Default: SSP2 */
@@ -278,6 +284,13 @@ static struct snd_soc_dai_link_component dmic_component[] = {
 	}
 };
 
+static struct snd_soc_dai_link_component dummy_component[] = {
+	{
+		.name = "snd-soc-dummy",
+		.dai_name = "snd-soc-dummy-dai",
+	}
+};
+
 static int create_spk_amp_dai_links(struct device *dev,
 				    struct snd_soc_dai_link *links,
 				    struct snd_soc_dai_link_component *cpus,
@@ -467,9 +480,56 @@ static int create_hdmi_dai_links(struct device *dev,
 	return -ENOMEM;
 }
 
+static int create_bt_offload_dai_links(struct device *dev,
+				       struct snd_soc_dai_link *links,
+				       struct snd_soc_dai_link_component *cpus,
+				       int *id, int ssp_bt)
+{
+	int ret = 0;
+
+	/* bt offload */
+	if (!(sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT))
+		return 0;
+
+	links[*id].name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT",
+					 ssp_bt);
+	if (!links[*id].name) {
+		ret = -ENOMEM;
+		goto devm_err;
+	}
+
+	links[*id].id = *id;
+	links[*id].codecs = dummy_component;
+	links[*id].num_codecs = ARRAY_SIZE(dummy_component);
+	links[*id].platforms = platform_component;
+	links[*id].num_platforms = ARRAY_SIZE(platform_component);
+
+	links[*id].dpcm_playback = 1;
+	links[*id].dpcm_capture = 1;
+	links[*id].no_pcm = 1;
+	links[*id].cpus = &cpus[*id];
+	links[*id].num_cpus = 1;
+
+	links[*id].cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
+						   "SSP%d Pin",
+						   ssp_bt);
+	if (!links[*id].cpus->dai_name) {
+		ret = -ENOMEM;
+		goto devm_err;
+	}
+
+	(*id)++;
+
+	return 0;
+
+devm_err:
+	return -ENOMEM;
+}
+
 static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 							  int ssp_codec,
 							  int ssp_amp,
+							  int ssp_bt,
 							  int dmic_be_num,
 							  int hdmi_num)
 {
@@ -522,6 +582,14 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
 				goto devm_err;
 			}
 			break;
+		case LINK_BT:
+			ret = create_bt_offload_dai_links(dev, links, cpus, &id, ssp_bt);
+			if (ret < 0) {
+				dev_err(dev, "fail to create bt offload dai links, ret %d\n",
+					ret);
+				goto devm_err;
+			}
+			break;
 		case LINK_NONE:
 			/* caught here if it's not used as terminator in macro */
 		default:
@@ -543,7 +611,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 	struct snd_soc_acpi_mach *mach;
 	struct sof_card_private *ctx;
 	int dmic_be_num, hdmi_num;
-	int ret, ssp_amp, ssp_codec;
+	int ret, ssp_bt, ssp_amp, ssp_codec;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -568,6 +636,9 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "sof_cs42l42_quirk = %lx\n", sof_cs42l42_quirk);
 
+	ssp_bt = (sof_cs42l42_quirk & SOF_CS42L42_SSP_BT_MASK) >>
+			SOF_CS42L42_SSP_BT_SHIFT;
+
 	ssp_amp = (sof_cs42l42_quirk & SOF_CS42L42_SSP_AMP_MASK) >>
 			SOF_CS42L42_SSP_AMP_SHIFT;
 
@@ -578,9 +649,11 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	if (sof_cs42l42_quirk & SOF_SPEAKER_AMP_PRESENT)
 		sof_audio_card_cs42l42.num_links++;
+	if (sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT)
+		sof_audio_card_cs42l42.num_links++;
 
 	dai_links = sof_card_dai_links_create(&pdev->dev, ssp_codec, ssp_amp,
-					      dmic_be_num, hdmi_num);
+					      ssp_bt, dmic_be_num, hdmi_num);
 	if (!dai_links)
 		return -ENOMEM;
 
@@ -621,6 +694,17 @@ static const struct platform_device_id board_ids[] = {
 					SOF_CS42L42_SSP_AMP(1)) |
 					SOF_CS42L42_DAILINK(LINK_HP, LINK_DMIC, LINK_HDMI, LINK_SPK, LINK_NONE),
 	},
+	{
+		.name = "adl_mx98360a_cs4242",
+		.driver_data = (kernel_ulong_t)(SOF_CS42L42_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_CS42L42_SSP_AMP(1) |
+					SOF_CS42L42_NUM_HDMIDEV(4) |
+					SOF_BT_OFFLOAD_PRESENT |
+					SOF_CS42L42_SSP_BT(2)) |
+					SOF_CS42L42_DAILINK(LINK_HP, LINK_DMIC, LINK_HDMI, LINK_SPK, LINK_BT),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 7c8cd00457f81..311adeb3afbc4 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -384,6 +384,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_fw_filename = "sof-adl.ri",
 		.sof_tplg_filename = "sof-adl-cs35l41.tplg",
 	},
+	{
+		.id = "10134242",
+		.drv_name = "adl_mx98360a_cs4242",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_max98360a_amp,
+		.sof_tplg_filename = "sof-adl-max98360a-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_machines);
-- 
2.25.1

