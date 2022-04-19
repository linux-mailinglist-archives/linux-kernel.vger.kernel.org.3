Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E45075C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355533AbiDSQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354973AbiDSQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:44:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8F23BF4;
        Tue, 19 Apr 2022 09:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5D23B81BE5;
        Tue, 19 Apr 2022 16:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45319C385A7;
        Tue, 19 Apr 2022 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386512;
        bh=QiDjZY966XEBc6DDR2J3pcVF2OHhXSmFgleX733S9R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAb4FzNkgoM3kCYs/HBpqHCO1xMlxG5aT22Kue78YyBRs5uYsdsLCEDp2uFk/Vpzj
         hBDEq0hPQ68ZrCETwUOUBIQ2Db2JnIDFmuhgzGViMIGfnVQ2WxWAJUyKuIHYvbfq1m
         JXSPFaIX/U6ER3sOlUmZBa1lA6lTZ2W4rIZqUFJhqPLVeSnIq0rECTEwLS9CEDhCB8
         LhU1ezCsE89PPHvmS5iP2R/xWcyyTkdL0NJVZF/DNBTFkKyMS50SZFGSjKPwZ+uEQr
         hIdROGX5ZctaUoAgIY+3w7w75y6TV79tuXyYb0/fV3nVTh/49O18UBQ5KVVCtSnWp3
         alA42Hgz/7LBw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 23/48] ARM: pxa: magician: use platform driver for audio
Date:   Tue, 19 Apr 2022 18:37:45 +0200
Message-Id: <20220419163810.2118169-24-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The magician audio driver creates a codec device and gets
data from a board specific header file, both of which is
a bit suspicious. Move these into the board file itself,
using a gpio lookup table.

Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/magician.c |  50 +++++++++++++
 sound/soc/pxa/magician.c     | 141 +++++++++--------------------------
 2 files changed, 87 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index d105deb1e098..598c977a8ae6 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -53,6 +53,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/ads7846.h>
+#include <sound/uda1380.h>
 
 static unsigned long magician_pin_config[] __initdata = {
 
@@ -898,6 +899,53 @@ static struct platform_device strataflash = {
 	},
 };
 
+/*
+ * audio support
+ */
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
+	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
+	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
+};
+
+static struct i2c_board_info magician_audio_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x18),
+		.platform_data = &uda1380_info,
+	},
+};
+
+static struct gpiod_lookup_table magician_audio_gpio_table = {
+	.dev_id = "magician-audio",
+	.table = {
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_SPK_POWER - MAGICIAN_EGPIO_BASE,
+			    "SPK_POWER", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_EP_POWER - MAGICIAN_EGPIO_BASE,
+			    "EP_POWER", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_MIC_POWER - MAGICIAN_EGPIO_BASE,
+			    "MIC_POWER", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_IN_SEL0 - MAGICIAN_EGPIO_BASE,
+			    "IN_SEL0", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_IN_SEL1 - MAGICIAN_EGPIO_BASE,
+			    "IN_SEL1", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static void magician_audio_init(void)
+{
+	i2c_register_board_info(0,
+		ARRAY_AND_SIZE(magician_audio_i2c_board_info));
+
+	gpiod_add_lookup_table(&magician_audio_gpio_table);
+	platform_device_register_simple("magician-audio", -1, NULL, 0);
+}
+
 /*
  * PXA I2C main controller
  */
@@ -1048,6 +1096,8 @@ static void __init magician_init(void)
 	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	gpiod_add_lookup_table(&gpio_vbus_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
+
+	magician_audio_init();
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index a5f326c97af2..9433cc927755 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -14,16 +14,14 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/uda1380.h>
 
-#include <mach/magician.h>
 #include <asm/mach-types.h>
 #include "../codecs/uda1380.h"
 #include "pxa2xx-i2s.h"
@@ -36,6 +34,9 @@ static int magician_hp_switch;
 static int magician_spk_switch = 1;
 static int magician_in_sel = MAGICIAN_MIC;
 
+static struct gpio_desc *gpiod_spk_power, *gpiod_ep_power, *gpiod_mic_power;
+static struct gpio_desc *gpiod_in_sel0, *gpiod_in_sel1;
+
 static void magician_ext_control(struct snd_soc_dapm_context *dapm)
 {
 
@@ -215,10 +216,10 @@ static int magician_set_input(struct snd_kcontrol *kcontrol,
 
 	switch (magician_in_sel) {
 	case MAGICIAN_MIC:
-		gpio_set_value(EGPIO_MAGICIAN_IN_SEL1, 1);
+		gpiod_set_value(gpiod_in_sel1, 1);
 		break;
 	case MAGICIAN_MIC_EXT:
-		gpio_set_value(EGPIO_MAGICIAN_IN_SEL1, 0);
+		gpiod_set_value(gpiod_in_sel1, 0);
 	}
 
 	return 1;
@@ -227,21 +228,21 @@ static int magician_set_input(struct snd_kcontrol *kcontrol,
 static int magician_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(EGPIO_MAGICIAN_SPK_POWER, SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_spk_power, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
 static int magician_hp_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(EGPIO_MAGICIAN_EP_POWER, SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_ep_power, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
 static int magician_mic_bias(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(EGPIO_MAGICIAN_MIC_POWER, SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_mic_power, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
@@ -328,106 +329,38 @@ static struct snd_soc_card snd_soc_card_magician = {
 	.fully_routed = true,
 };
 
-static struct platform_device *magician_snd_device;
-
-/*
- * FIXME: move into magician board file once merged into the pxa tree
- */
-static struct uda1380_platform_data uda1380_info = {
-	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
-	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
-	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
-};
-
-static struct i2c_board_info i2c_board_info[] = {
-	{
-		I2C_BOARD_INFO("uda1380", 0x18),
-		.platform_data = &uda1380_info,
-	},
-};
-
-static int __init magician_init(void)
-{
-	int ret;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-
-	if (!machine_is_magician())
-		return -ENODEV;
-
-	adapter = i2c_get_adapter(0);
-	if (!adapter)
-		return -ENODEV;
-	client = i2c_new_client_device(adapter, i2c_board_info);
-	i2c_put_adapter(adapter);
-	if (IS_ERR(client))
-		return PTR_ERR(client);
-
-	ret = gpio_request(EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
-	if (ret)
-		goto err_request_spk;
-	ret = gpio_request(EGPIO_MAGICIAN_EP_POWER, "EP_POWER");
-	if (ret)
-		goto err_request_ep;
-	ret = gpio_request(EGPIO_MAGICIAN_MIC_POWER, "MIC_POWER");
-	if (ret)
-		goto err_request_mic;
-	ret = gpio_request(EGPIO_MAGICIAN_IN_SEL0, "IN_SEL0");
-	if (ret)
-		goto err_request_in_sel0;
-	ret = gpio_request(EGPIO_MAGICIAN_IN_SEL1, "IN_SEL1");
-	if (ret)
-		goto err_request_in_sel1;
-
-	gpio_set_value(EGPIO_MAGICIAN_IN_SEL0, 0);
-
-	magician_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!magician_snd_device) {
-		ret = -ENOMEM;
-		goto err_pdev;
-	}
-
-	platform_set_drvdata(magician_snd_device, &snd_soc_card_magician);
-	ret = platform_device_add(magician_snd_device);
-	if (ret) {
-		platform_device_put(magician_snd_device);
-		goto err_pdev;
-	}
-
-	return 0;
-
-err_pdev:
-	gpio_free(EGPIO_MAGICIAN_IN_SEL1);
-err_request_in_sel1:
-	gpio_free(EGPIO_MAGICIAN_IN_SEL0);
-err_request_in_sel0:
-	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
-err_request_mic:
-	gpio_free(EGPIO_MAGICIAN_EP_POWER);
-err_request_ep:
-	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
-err_request_spk:
-	return ret;
-}
-
-static void __exit magician_exit(void)
+static int magician_audio_probe(struct platform_device *pdev)
 {
-	platform_device_unregister(magician_snd_device);
-
-	gpio_set_value(EGPIO_MAGICIAN_SPK_POWER, 0);
-	gpio_set_value(EGPIO_MAGICIAN_EP_POWER, 0);
-	gpio_set_value(EGPIO_MAGICIAN_MIC_POWER, 0);
-
-	gpio_free(EGPIO_MAGICIAN_IN_SEL1);
-	gpio_free(EGPIO_MAGICIAN_IN_SEL0);
-	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
-	gpio_free(EGPIO_MAGICIAN_EP_POWER);
-	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
+	struct device *dev = &pdev->dev;
+
+	gpiod_spk_power = devm_gpiod_get(dev, "SPK_POWER", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_spk_power))
+		return PTR_ERR(gpiod_spk_power);
+	gpiod_ep_power = devm_gpiod_get(dev, "EP_POWER", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ep_power))
+		return PTR_ERR(gpiod_ep_power);
+	gpiod_mic_power = devm_gpiod_get(dev, "MIC_POWER", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_mic_power))
+		return PTR_ERR(gpiod_mic_power);
+	gpiod_in_sel0 = devm_gpiod_get(dev, "IN_SEL0", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_in_sel0))
+		return PTR_ERR(gpiod_in_sel0);
+	gpiod_in_sel1 = devm_gpiod_get(dev, "IN_SEL1", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_in_sel1))
+		return PTR_ERR(gpiod_in_sel1);
+
+	snd_soc_card_magician.dev = &pdev->dev;
+	return devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_magician);
 }
 
-module_init(magician_init);
-module_exit(magician_exit);
+static struct platform_driver magician_audio_driver = {
+	.driver.name = "magician-audio",
+	.driver.pm = &snd_soc_pm_ops,
+	.probe = magician_audio_probe,
+};
+module_platform_driver(magician_audio_driver);
 
 MODULE_AUTHOR("Philipp Zabel");
 MODULE_DESCRIPTION("ALSA SoC Magician");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:magician-audio");
-- 
2.29.2

