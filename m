Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246FE507548
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355402AbiDSQtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355091AbiDSQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:44:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C323BF4;
        Tue, 19 Apr 2022 09:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DEB5B819DE;
        Tue, 19 Apr 2022 16:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B048C385A5;
        Tue, 19 Apr 2022 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386504;
        bh=F7MBpdNOWf67bimqHOji31bTXpJ1ZCUAsldDqvgUu28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9+kiqJIfUhfsFE1H4YAU921VV0VonfY9j1NKObGUwzCjRXR46YiY5Nj5Dl5rsV5L
         iADk6/ddM85QG95gOh8OUVYyoEgAxa4D3s0bKJkfzDri4GMhVZSzQQuTx0F/9H+wsJ
         MVlTyeihlRVWFJ5B3aJxEUdAG2tMIaPk7ers3/ONTltRkZsg/z88XIF9SNvMLClZls
         I6TvEKcDx5DRBX76OZrUNtcSo4m6dLcfqZX2lAkhvSfR9zZVl354Yk7Zy6TbAGL6Ya
         K7sfhczH1+GW+wFu7/eCNYeSzMXgdYelcxwq9ivucHJV+x+FdLYDsJhrGZDEpOBDtI
         Wp06/+3vmFtwg==
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
Subject: [PATCH 22/48] ARM: pxa: z2: use gpio lookup for audio device
Date:   Tue, 19 Apr 2022 18:37:44 +0200
Message-Id: <20220419163810.2118169-23-arnd@kernel.org>
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

The audio device is allocated by the audio driver, and it uses a gpio
number from the mach/z2.h header file.

Change it to use a gpio lookup table for the device allocated by the
driver to keep the header file local to the machine.

Acked-by: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/z2.c | 11 +++++++++++
 sound/soc/pxa/z2.c     |  5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 7eaeda269927..bb854e903c8f 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -651,6 +651,15 @@ static void __init z2_spi_init(void)
 static inline void z2_spi_init(void) {}
 #endif
 
+static struct gpiod_lookup_table z2_audio_gpio_table = {
+	.dev_id = "soc-audio",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO37_ZIPITZ2_HEADSET_DETECT,
+			    "hsdet-gpio", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /******************************************************************************
  * Core power regulator
  ******************************************************************************/
@@ -755,6 +764,8 @@ static void __init z2_init(void)
 	z2_keys_init();
 	z2_pmic_init();
 
+	gpiod_add_lookup_table(&z2_audio_gpio_table);
+
 	pm_power_off = z2_power_off;
 }
 
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index dc6c48e4738b..7f1c6bc69510 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -13,7 +13,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -22,7 +22,6 @@
 
 #include <asm/mach-types.h>
 #include <linux/platform_data/asoc-pxa.h>
-#include <mach/z2.h>
 
 #include "../codecs/wm8750.h"
 #include "pxa2xx-i2s.h"
@@ -89,7 +88,6 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 /* Headset jack detection gpios */
 static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 	{
-		.gpio		= GPIO37_ZIPITZ2_HEADSET_DETECT,
 		.name		= "hsdet-gpio",
 		.report		= SND_JACK_HEADSET,
 		.debounce_time	= 200,
@@ -195,6 +193,7 @@ static int __init z2_init(void)
 	if (!z2_snd_device)
 		return -ENOMEM;
 
+	hs_jack_gpios[0].gpiod_dev = &z2_snd_device->dev;
 	platform_set_drvdata(z2_snd_device, &snd_soc_z2);
 	ret = platform_device_add(z2_snd_device);
 
-- 
2.29.2

