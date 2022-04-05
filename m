Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67A14F3BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359200AbiDEL46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244813AbiDEIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8370A3D4AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2760DB81A32
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6ECC385A3;
        Tue,  5 Apr 2022 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649148257;
        bh=uhKJmxT3GYJYDFhq4RAKEABMP4Bn3KnkAH57wFkqNFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTfExkiT5n0S3rRXKmF8jZEuyyuyp4J40hHEOLpJP3/RIa0a0H4X4fCKThZLrSkez
         GuL12YtlnPIccMGZX/gg+aKC1crtMV6u3lcnPd/zyOn2oJSV7zFyesqdX5PzdWjxO5
         gwBmWnCxuU1LzdvMlmV9ccyoyfatCz3c0u5b5jHzga/hVwH/GGr8hpMpfANw8zUutC
         wXpM+qcDbHlxQoD+ly47Z3TSrZJe8qzE/5qhPTVdPgN4mfa0DiCZ6VRjgKn3r0odUy
         MKN/kLwNe8vjYQJpvZ6UsBJcNH5UZrF3DIHZNSb+keEufTt40Ngt79xBPoSzyq5PfH
         uJsNWTg0KbjIQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nbenP-001IBn-Cp; Tue, 05 Apr 2022 10:44:15 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 1/2] ASoC: Intel: sof_es8336: support a separate gpio to control headphone
Date:   Tue,  5 Apr 2022 10:44:12 +0200
Message-Id: <0f1e8233fc6744c3d78353e4a20f9669035e693d.1649147890.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649147890.git.mchehab@kernel.org>
References: <cover.1649147890.git.mchehab@kernel.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Some devices may use both gpio0 and gpio1 to independently switch
the speaker and the headphone.

Add support for that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/2] at: https://lore.kernel.org/all/cover.1649147890.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 60 ++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index 5e0529aa4f1d..bcd80870d252 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -30,6 +30,7 @@
 #define SOF_ES8336_TGL_GPIO_QUIRK		BIT(4)
 #define SOF_ES8336_ENABLE_DMIC			BIT(5)
 #define SOF_ES8336_JD_INVERTED			BIT(6)
+#define SOF_ES8336_HEADPHONE_GPIO		BIT(7)
 
 static unsigned long quirk;
 
@@ -39,7 +40,7 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 struct sof_es8336_private {
 	struct device *codec_dev;
-	struct gpio_desc *gpio_pa;
+	struct gpio_desc *gpio_pa, *gpio_pa_headphone;
 	struct snd_soc_jack jack;
 	struct list_head hdmi_pcm_list;
 	bool speaker_en;
@@ -51,15 +52,28 @@ struct sof_hdmi_pcm {
 	int device;
 };
 
-static const struct acpi_gpio_params pa_enable_gpio = { 0, 0, true };
+static const struct acpi_gpio_params pa_enable_gpio0 = { 0, 0, true };
+static const struct acpi_gpio_params pa_enable_gpio1 = { 1, 0, true };
+
 static const struct acpi_gpio_mapping acpi_es8336_gpios[] = {
-	{ "pa-enable-gpios", &pa_enable_gpio, 1 },
+	{ "pa-enable-gpios", &pa_enable_gpio0, 1 },
 	{ }
 };
 
-static const struct acpi_gpio_params quirk_pa_enable_gpio = { 1, 0, true };
 static const struct acpi_gpio_mapping quirk_acpi_es8336_gpios[] = {
-	{ "pa-enable-gpios", &quirk_pa_enable_gpio, 1 },
+	{ "pa-enable-gpios", &pa_enable_gpio1, 1 },
+	{ }
+};
+
+static const struct acpi_gpio_mapping quirk_acpi_headphone_es8336_gpios[] = {
+	{ "pa-enable-gpios", &pa_enable_gpio0, 1 },
+	{ "pa-enable-headphone-gpios", &pa_enable_gpio1, 1 },
+	{ }
+};
+
+static const struct acpi_gpio_mapping quirk_tgl_acpi_headphone_es8336_gpios[] = {
+	{ "pa-enable-gpios", &pa_enable_gpio1, 1 },
+	{ "pa-enable-headphone-gpios", &pa_enable_gpio0, 1 },
 	{ }
 };
 
@@ -71,6 +85,8 @@ static void log_quirks(struct device *dev)
 	dev_info(dev, "quirk SSP%ld\n",  SOF_ES8336_SSP_CODEC(quirk));
 	if (quirk & SOF_ES8336_ENABLE_DMIC)
 		dev_info(dev, "quirk DMIC enabled\n");
+	if (quirk & SOF_ES8336_HEADPHONE_GPIO)
+		dev_info(dev, "quirk headphone GPIO enabled\n");
 	if (quirk & SOF_ES8336_TGL_GPIO_QUIRK)
 		dev_info(dev, "quirk TGL GPIO enabled\n");
 	if (quirk & SOF_ES8336_JD_INVERTED)
@@ -83,13 +99,24 @@ static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
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
 
 	gpiod_set_value_cansleep(priv->gpio_pa, priv->speaker_en);
 
+	if (!(quirk & SOF_ES8336_HEADPHONE_GPIO))
+		return 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		msleep(70);
+
+	gpiod_set_value_cansleep(priv->gpio_pa_headphone, priv->speaker_en);
+
 	return 0;
 }
 
@@ -114,7 +141,7 @@ static const struct snd_soc_dapm_route sof_es8316_audio_map[] = {
 
 	/*
 	 * There is no separate speaker output instead the speakers are muxed to
-	 * the HP outputs. The mux is controlled by the "Speaker Power" supply.
+	 * the HP outputs. The mux is controlled Speaker and/or headphone switch.
 	 */
 	{"Speaker", NULL, "HPOL"},
 	{"Speaker", NULL, "HPOR"},
@@ -233,8 +260,14 @@ static int sof_es8336_quirk_cb(const struct dmi_system_id *id)
 {
 	quirk = (unsigned long)id->driver_data;
 
-	if (quirk & SOF_ES8336_TGL_GPIO_QUIRK)
+	if (quirk & SOF_ES8336_HEADPHONE_GPIO) {
+		if (quirk & SOF_ES8336_TGL_GPIO_QUIRK)
+			gpio_mapping = quirk_tgl_acpi_headphone_es8336_gpios;
+		else
+			gpio_mapping = quirk_acpi_headphone_es8336_gpios;
+	} else if (quirk & SOF_ES8336_TGL_GPIO_QUIRK) {
 		gpio_mapping = quirk_acpi_es8336_gpios;
+	}
 
 	return 1;
 }
@@ -592,6 +625,13 @@ static int sof_es8336_probe(struct platform_device *pdev)
 		goto err_put_codec;
 	}
 
+	priv->gpio_pa_headphone = gpiod_get_optional(codec_dev, "pa-enable-headphone", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpio_pa_headphone)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->gpio_pa_headphone),
+				    "could not get pa-enable-headphone GPIO\n");
+		goto err_put_codec;
+	}
+
 	INIT_LIST_HEAD(&priv->hdmi_pcm_list);
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
2.35.1

