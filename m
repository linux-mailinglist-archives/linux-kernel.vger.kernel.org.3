Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1A522C44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbiEKGZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241366AbiEKGZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:25:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25EA22B387
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:25:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p12so1179163pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wistron-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5C7OXci5nwdErfgICDesxwtivpbKyTExi4Vox7FELc=;
        b=FQWTpU+quExij5RCPnOU3jbV6rQpIFmAI694/Fy0FxoYtCSzOvuPp18azYSHLEE5aI
         fEvGE7W+hIxZ1IptkIiNXz3LLpRkd6xAKn1p2p7+uR3ckfmAOBwDNUGrXK2Gk17hAKb5
         Ga+OL780NGq7hZ+P+E+bCqEDChZXQgvz8lJOgj89q4WEGzlXPMDbz5Tg/76M8EGVFgf8
         FEWFWqeWNekP9lkzcKcgHoCyvMwMOL0EM+Ty1Cju1a8Mo9T80rm8eLLTRGy+YuBhB0NL
         4frSR+fuZIZeV4g53ubZr9yPqSwnmzsyiReLlhArC/huGfBg2NvabTPyvl/V+YbOFn9h
         AWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5C7OXci5nwdErfgICDesxwtivpbKyTExi4Vox7FELc=;
        b=50RogpJece8CwB85zTvXuPBnv03O5KroFQZgx+K9B4tc2ZUkfdjkg+NPIwAfhlzmy/
         VwhsFYV9Ti7kwrXKadMYJ7XMvdeDzmj0rQry3umJKbwq3S590R1pZJRA5F9iNOPx0rtg
         Uos0kheoJGIEsOU7VCfd4DsF9a0TEINV64IY8IyWL8e4LFnTk6QnPJXPyOFWkqVdvGdR
         EjApOOw5NTw0bbt5QWceWX2DokTR+aGwjeivLhyOf8G1qbVPFsTdv90QB1Vp/60wVNWz
         e4MpkIcKU5DV7xUUKaDahtCU6xnX15lUiAB05cbBXTFUMTwKEFEeFLkTF/VqU3kdlWPT
         hZGQ==
X-Gm-Message-State: AOAM532u7D5ZGi/tfJeX0npTZw6aIHLnMX9raOuappt90ObII56x10Wa
        PGayDHyxJ+bNZvEuWOCuhLq3+9RcEr6IyjwNimw=
X-Google-Smtp-Source: ABdhPJy/oQDgFkEh/tjm9dOvcT7za1mLaFGJQzSWvsGrFaolHaJawbYZUnPZfQ64jixTAsvL28QOVg==
X-Received: by 2002:a63:2a4f:0:b0:3c1:bf77:b81f with SMTP id q76-20020a632a4f000000b003c1bf77b81fmr19650508pgq.364.1652250324273;
        Tue, 10 May 2022 23:25:24 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:478:2175:74a6:2181:e968:3721])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a64c300b001cd4989ff4esm839533pjm.21.2022.05.10.23.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:25:24 -0700 (PDT)
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
Subject: [PATCH] [v3]FROMLIST: ASoC: Intel: sof_cs42l42: adding support for ADL configuration and BT offload audio
Date:   Wed, 11 May 2022 14:25:14 +0800
Message-Id: <20220511062514.1743838-1-terry_chen@wistron.corp-partner.google.com>
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
 .../intel/common/soc-acpi-intel-adl-match.c   |  8 ++
 2 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index ce78c18798876..e7711480922cd 100644
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
index 7c8cd00457f81..3f40519250a90 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -384,6 +384,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.sof_fw_filename = "sof-adl.ri",
 		.sof_tplg_filename = "sof-adl-cs35l41.tplg",
 	},
+	{
+		.id = "10134242",
+		.drv_name = "adl_mx98360a_cs4242",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_max98360a_amp,
+		.sof_fw_filename = "sof-adl.ri",
+		.sof_tplg_filename = "sof-adl-max98360a-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_machines);
-- 
2.25.1

