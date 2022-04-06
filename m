Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADD4F6C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiDFVZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiDFVYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:24:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA82EC113
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65E9DB8252B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DBAC385A1;
        Wed,  6 Apr 2022 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649276363;
        bh=YnVi7SV63060gXbFMvlyQSuGHzRUsi/C5DeXjpmhkwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VA6xOLF9tQ+N0PXEvROHdUim3nXjkFoQXZ0Nv5oH3oKLO0+jNKJiUAdm3Sx/8wkmi
         wEB9ezvtTLEPj2kdcDMxuzbhTt6GhhL/59/p6Nr0aq3HWmALot9Jk7y7I43nKUpiiU
         QrHUYnGJMP0P7xqU7CALj3IYrokCzP7/oGERjLeingqM7a2wC69FdWXUf/c4TD6BSz
         8cO9CpAqZKBvslORpJ+/SA2Mr8vRktj2tK6bIHxsicwlIV3Dcn9Bf/OmR+W8osjRIj
         zPTTda7U30NZJeIy7eceJEAAEc6uQwADrPmDJgr8n0JEr3SqwPSiNfpCPYmlREAckK
         3uGJgUkOGtN1A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ncC7c-00GGaR-Ma; Wed, 06 Apr 2022 22:19:20 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     alsa-devel@alsa-project.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] ASoC: Intel: sof_es8336: add a quirk for headset at mic1 port
Date:   Wed,  6 Apr 2022 22:19:17 +0200
Message-Id: <baf412bc431650fc7f3a157c6ab96d08120940fc.1649275618.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649275618.git.mchehab@kernel.org>
References: <cover.1649275618.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headset/internal mic can either be routed as mic1/mic2
or vice-versa.

By default, the driver assumes that the headset is mapped as
mic2, but not all devices map this way.

So, add a quirk to support changing it to mic1, using mic2
for the internal analog mic (if any).

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1649275618.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index d15a58666cc6..bc5bc6124223 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -31,6 +31,7 @@
 #define SOF_ES8336_ENABLE_DMIC			BIT(5)
 #define SOF_ES8336_JD_INVERTED			BIT(6)
 #define SOF_ES8336_HEADPHONE_GPIO		BIT(7)
+#define SOC_ES8336_HEADSET_MIC1			BIT(8)
 
 static unsigned long quirk;
 
@@ -90,6 +91,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk headphone GPIO enabled\n");
 	if (quirk & SOF_ES8336_JD_INVERTED)
 		dev_info(dev, "quirk JD inverted enabled\n");
+	if (quirk & SOC_ES8336_HEADSET_MIC1)
+		dev_info(dev, "quirk headset at mic1 port enabled\n");
 }
 
 static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
@@ -145,13 +148,23 @@ static const struct snd_soc_dapm_route sof_es8316_audio_map[] = {
 	{"Speaker", NULL, "HPOL"},
 	{"Speaker", NULL, "HPOR"},
 	{"Speaker", NULL, "Speaker Power"},
+
+	{"Differential Mux", "lin1-rin1", "MIC1"},
+	{"Differential Mux", "lin2-rin2", "MIC2"},
+	{"Differential Mux", "lin1-rin1 with 20db Boost", "MIC1"},
+	{"Differential Mux", "lin2-rin2 with 20db Boost", "MIC2"},
 };
 
-static const struct snd_soc_dapm_route sof_es8316_intmic_in1_map[] = {
+static const struct snd_soc_dapm_route sof_es8316_headset_mic2_map[] = {
 	{"MIC1", NULL, "Internal Mic"},
 	{"MIC2", NULL, "Headset Mic"},
 };
 
+static const struct snd_soc_dapm_route sof_es8316_headset_mic1_map[] = {
+	{"MIC2", NULL, "Internal Mic"},
+	{"MIC1", NULL, "Headset Mic"},
+};
+
 static const struct snd_soc_dapm_route dmic_map[] = {
 	/* digital mics */
 	{"DMic", NULL, "SoC DMIC"},
@@ -225,8 +238,13 @@ static int sof_es8316_init(struct snd_soc_pcm_runtime *runtime)
 
 	card->dapm.idle_bias_off = true;
 
-	custom_map = sof_es8316_intmic_in1_map;
-	num_routes = ARRAY_SIZE(sof_es8316_intmic_in1_map);
+	if (quirk & SOC_ES8336_HEADSET_MIC1) {
+		custom_map = sof_es8316_headset_mic1_map;
+		num_routes = ARRAY_SIZE(sof_es8316_headset_mic1_map);
+	} else {
+		custom_map = sof_es8316_headset_mic2_map;
+		num_routes = ARRAY_SIZE(sof_es8316_headset_mic2_map);
+	}
 
 	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
 	if (ret)
-- 
2.35.1

