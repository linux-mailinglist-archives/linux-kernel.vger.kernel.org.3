Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539394F6C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiDFVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiDFVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:24:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A112EEF5F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EB20ACE227E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C9DC385A6;
        Wed,  6 Apr 2022 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649276363;
        bh=Hdm3pBtujf9iB+SnJDhmihEuCKW3y1jwAoZcdwehFf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EjBUL60fmdJSJcmglL+K6fwsHBt2f3Tgv5CPKAVS2A7c7oGkjPcdAu64kt5ns3f+/
         w/MyqseLMwaUBuxv8TAYif8GSQnt/TZtrdBwxjLg8imVD5Xdnl73IC6rXZFMBdg6Ch
         Z4obsMcr57QW9nIDwvZTvAnCx8H80ij4DkkKZ+VASnq2hfD9jKyLaEceuxryikB6/E
         +7jkKcjmDJ046LJ33yAv2/HCh6nm5MJwRKamK0EGQ0Dj+pIuWggx1C3zMQ9f9npIHb
         8bdLnRDWa1kXqMOP0wh+l4MRwtS25hR646S+ya7W6cpaq9Y6+F+rK5fmEb35PQ2Uer
         eYNnxRokz8wVQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ncC7c-00GGaM-KJ; Wed, 06 Apr 2022 22:19:20 +0200
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
Subject: [PATCH v4 2/4] ASoC: Intel: sof_es8336: support a separate gpio to control headphone
Date:   Wed,  6 Apr 2022 22:19:16 +0200
Message-Id: <535454c0c598a8454487fe29b164527370e2db81.1649275618.git.mchehab@kernel.org>
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

Some devices may use both gpio0 and gpio1 to independently switch
the speaker and the headphone.

Add support for that.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1649275618.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 59 ++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index e4829a376b79..d15a58666cc6 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -30,6 +30,7 @@
 #define SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK	BIT(4)
 #define SOF_ES8336_ENABLE_DMIC			BIT(5)
 #define SOF_ES8336_JD_INVERTED			BIT(6)
+#define SOF_ES8336_HEADPHONE_GPIO		BIT(7)
 
 static unsigned long quirk;
 
@@ -39,7 +40,7 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 struct sof_es8336_private {
 	struct device *codec_dev;
-	struct gpio_desc *gpio_speakers;
+	struct gpio_desc *gpio_speakers, *gpio_headphone;
 	struct snd_soc_jack jack;
 	struct list_head hdmi_pcm_list;
 	bool speaker_en;
@@ -51,15 +52,27 @@ struct sof_hdmi_pcm {
 	int device;
 };
 
-static const struct acpi_gpio_params speakers_enable_gpio0 = { 0, 0, true };
+static const struct acpi_gpio_params enable_gpio0 = { 0, 0, true };
+static const struct acpi_gpio_params enable_gpio1 = { 1, 0, true };
+
 static const struct acpi_gpio_mapping acpi_speakers_enable_gpio0[] = {
-	{ "speakers-enable-gpios", &speakers_enable_gpio0, 1 },
+	{ "speakers-enable-gpios", &enable_gpio0, 1 },
 	{ }
 };
 
-static const struct acpi_gpio_params speakers_enable_gpio1 = { 1, 0, true };
 static const struct acpi_gpio_mapping acpi_speakers_enable_gpio1[] = {
-	{ "speakers-enable-gpios", &speakers_enable_gpio1, 1 },
+	{ "speakers-enable-gpios", &enable_gpio1, 1 },
+};
+
+static const struct acpi_gpio_mapping acpi_enable_both_gpios[] = {
+	{ "speakers-enable-gpios", &enable_gpio0, 1 },
+	{ "headphone-enable-gpios", &enable_gpio1, 1 },
+	{ }
+};
+
+static const struct acpi_gpio_mapping acpi_enable_both_gpios_rev_order[] = {
+	{ "speakers-enable-gpios", &enable_gpio1, 1 },
+	{ "headphone-enable-gpios", &enable_gpio0, 1 },
 	{ }
 };
 
@@ -73,6 +86,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk DMIC enabled\n");
 	if (quirk & SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK)
 		dev_info(dev, "Speakers GPIO1 quirk enabled\n");
+	if (quirk & SOF_ES8336_HEADPHONE_GPIO)
+		dev_info(dev, "quirk headphone GPIO enabled\n");
 	if (quirk & SOF_ES8336_JD_INVERTED)
 		dev_info(dev, "quirk JD inverted enabled\n");
 }
@@ -83,13 +98,24 @@ static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_card *card = w->dapm->card;
 	struct sof_es8336_private *priv = snd_soc_card_get_drvdata(card);
 
+	if (priv->speaker_en == !SND_SOC_DAPM_EVENT_ON(event))
+		return 0;
+
+	priv->speaker_en = !SND_SOC_DAPM_EVENT_ON(event);
+
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		priv->speaker_en = false;
-	else
-		priv->speaker_en = true;
+		msleep(70);
 
 	gpiod_set_value_cansleep(priv->gpio_speakers, priv->speaker_en);
 
+	if (!(quirk & SOF_ES8336_HEADPHONE_GPIO))
+		return 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		msleep(70);
+
+	gpiod_set_value_cansleep(priv->gpio_headphone, priv->speaker_en);
+
 	return 0;
 }
 
@@ -114,7 +140,7 @@ static const struct snd_soc_dapm_route sof_es8316_audio_map[] = {
 
 	/*
 	 * There is no separate speaker output instead the speakers are muxed to
-	 * the HP outputs. The mux is controlled by the "Speaker Power" supply.
+	 * the HP outputs. The mux is controlled Speaker and/or headphone switch.
 	 */
 	{"Speaker", NULL, "HPOL"},
 	{"Speaker", NULL, "HPOR"},
@@ -233,8 +259,14 @@ static int sof_es8336_quirk_cb(const struct dmi_system_id *id)
 {
 	quirk = (unsigned long)id->driver_data;
 
-	if (quirk & SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK)
+	if (quirk & SOF_ES8336_HEADPHONE_GPIO) {
+		if (quirk & SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK)
+			gpio_mapping = acpi_enable_both_gpios;
+		else
+			gpio_mapping = acpi_enable_both_gpios_rev_order;
+	} else if (quirk & SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK) {
 		gpio_mapping = acpi_speakers_enable_gpio1;
+	}
 
 	return 1;
 }
@@ -592,6 +624,13 @@ static int sof_es8336_probe(struct platform_device *pdev)
 		goto err_put_codec;
 	}
 
+	priv->gpio_headphone = gpiod_get_optional(codec_dev, "headphone-enable", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpio_headphone)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->gpio_headphone),
+				    "could not get headphone-enable GPIO\n");
+		goto err_put_codec;
+	}
+
 	INIT_LIST_HEAD(&priv->hdmi_pcm_list);
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
2.35.1

