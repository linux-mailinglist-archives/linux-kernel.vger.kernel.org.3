Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E95516B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358496AbiEBHLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354251AbiEBHLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:11:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0FE38DBC;
        Mon,  2 May 2022 00:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1714DB81147;
        Mon,  2 May 2022 07:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB14C385B4;
        Mon,  2 May 2022 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651475289;
        bh=X5DDZ5cu8Ec0v5TpZDEASVCpiKVJTD3WHl3xILny+5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ftc66P1KRLtIxbphpeXSRKGK+ku85pG3xcLnI/ILm+zDUqAWSpZi/jH68+mJyw4e4
         qrSk4knKQzczwh6juw3h25W1EEaFoJp13UogCVeUFApS4IlTRxkiRu31rw+h42AEEo
         yVvI3NHLHqZRZMWf/GwdXrO0fkciYsoEJY1TJDzJqiHn5YRljNyBweeocP1TAdMDIW
         SjWUyPk2BlfHWlnvCbBf3F73MPSMg+TT/ecnNgdjKm4f099yYZrBX2f5FXLl9T5/YR
         SvkcpkVzscWXQHMTAsjSEd0WcjGhlhqUMXSf9/gRaXtg84BSH7Y053ojFgR2kKR7NX
         cyQX12I4WnqMQ==
Received: by mail-yb1-f182.google.com with SMTP id m128so24603743ybm.5;
        Mon, 02 May 2022 00:08:09 -0700 (PDT)
X-Gm-Message-State: AOAM533YXgNgVBCaIk7s9X4l2uGaKY7PX9fESMeQGr95OIWvy9Hgok5G
        skFANhKVeVZqhSpAEiicidyCvsqdenyuPV2U89E=
X-Google-Smtp-Source: ABdhPJzh1sjDRx5OtKZisw0kK2teD3n3NIRAbZSwmRkDNwDLe6EnG5RDGjvENlJGwWWdkEOx8bePQy1Q38g26+xkjEA=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr9381815ybx.472.1651475288728; Mon, 02
 May 2022 00:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-19-arnd@kernel.org>
 <CACRpkdac8dGKSEmc-HpgooJefrDtiKK+_A1Mv7AJM8yQV9UY-w@mail.gmail.com>
In-Reply-To: <CACRpkdac8dGKSEmc-HpgooJefrDtiKK+_A1Mv7AJM8yQV9UY-w@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 2 May 2022 09:07:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0w3gFzZoBzyRsi1Ta4prESf8Fp0=quAPSKMnaXvbXNTQ@mail.gmail.com>
Message-ID: <CAK8P3a0w3gFzZoBzyRsi1Ta4prESf8Fp0=quAPSKMnaXvbXNTQ@mail.gmail.com>
Subject: Re: [PATCH 18/48] ARM: pxa: hx4700: use gpio descriptors for audio
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 11:41 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> (...)
> > +static struct gpiod_lookup_table hx4700_audio_gpio_table = {
> > +       .dev_id = "hx4700-audio",
> > +       .table = {
> > +               GPIO_LOOKUP("gpio-pxa", GPIO75_HX4700_EARPHONE_nDET,
> > +                           "earphone-ndet", GPIO_ACTIVE_HIGH),
>
> This looks wrong. The n in nDET in the end of the name of the GPIO line
> means active low does it not?
>
> What I usually do when I see this is to properly set it to
> GPIO_ACTIVE_LOW in the descriptor table, then invert the logic
> where it's getting used.
>
> Also rename to earphone-det instead of -ndet

Thanks for taking a look! I changed it now, but I don't know if
I got the correct number of inversions in the end. How does this look?

          Arnd

commit 9d452c9cbee59fc58c940b5f7ae5a40579aab0d2
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Sep 11 14:27:13 2019 +0200

    ARM: pxa: hx4700: use gpio descriptors for audio

    The audio driver should not use a hardwired gpio number
    from the header. Change it to use a lookup table.

    Cc: Philipp Zabel <philipp.zabel@gmail.com>
    Cc: Paul Parsons <lost.distance@yahoo.com>
    Acked-by: Mark Brown <broonie@kernel.org>
    Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
    Cc: alsa-devel@alsa-project.org
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-pxa/hx4700-pcmcia.c
b/arch/arm/mach-pxa/hx4700-pcmcia.c
index e8acbfc9ef6c..e2331dfe427d 100644
--- a/arch/arm/mach-pxa/hx4700-pcmcia.c
+++ b/arch/arm/mach-pxa/hx4700-pcmcia.c
@@ -10,7 +10,7 @@
 #include <linux/irq.h>

 #include <asm/mach-types.h>
-#include <mach/hx4700.h>
+#include "hx4700.h"

 #include <pcmcia/soc_common.h>

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 140a44cb2989..2ae06edf413c 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -41,7 +41,7 @@

 #include "pxa27x.h"
 #include "addr-map.h"
-#include <mach/hx4700.h>
+#include "hx4700.h"
 #include <linux/platform_data/irda-pxaficp.h>

 #include <sound/ak4641.h>
@@ -834,6 +834,19 @@ static struct i2c_board_info i2c_board_info[]
__initdata = {
        },
 };

+static struct gpiod_lookup_table hx4700_audio_gpio_table = {
+       .dev_id = "hx4700-audio",
+       .table = {
+               GPIO_LOOKUP("gpio-pxa", GPIO75_HX4700_EARPHONE_nDET,
+                           "earphone-det", GPIO_ACTIVE_LOW),
+               GPIO_LOOKUP("gpio-pxa", GPIO92_HX4700_HP_DRIVER,
+                           "hp-driver", GPIO_ACTIVE_HIGH),
+               GPIO_LOOKUP("gpio-pxa", GPIO107_HX4700_SPK_nSD,
+                           "spk-sd", GPIO_ACTIVE_LOW),
+               { },
+       },
+};
+
 static struct platform_device audio = {
        .name   = "hx4700-audio",
        .id     = -1,
@@ -895,6 +908,7 @@ static void __init hx4700_init(void)

        gpiod_add_lookup_table(&bq24022_gpiod_table);
        gpiod_add_lookup_table(&gpio_vbus_gpiod_table);
+       gpiod_add_lookup_table(&hx4700_audio_gpio_table);
        platform_add_devices(devices, ARRAY_SIZE(devices));
        pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));

diff --git a/arch/arm/mach-pxa/include/mach/hx4700.h
b/arch/arm/mach-pxa/hx4700.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/hx4700.h
rename to arch/arm/mach-pxa/hx4700.h
index 0c30e6d9c660..ce2db33989e1 100644
--- a/arch/arm/mach-pxa/include/mach/hx4700.h
+++ b/arch/arm/mach-pxa/hx4700.h
@@ -10,7 +10,7 @@

 #include <linux/gpio.h>
 #include <linux/mfd/asic3.h>
-#include "irqs.h" /* PXA_NR_BUILTIN_GPIO */
+#include <mach/irqs.h> /* PXA_NR_BUILTIN_GPIO */

 #define HX4700_ASIC3_GPIO_BASE PXA_NR_BUILTIN_GPIO
 #define HX4700_EGPIO_BASE      (HX4700_ASIC3_GPIO_BASE + ASIC3_NUM_GPIOS)
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 7334fac758de..a0734b742322 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>

 #include <sound/core.h>
 #include <sound/jack.h>
@@ -18,10 +18,10 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>

-#include <mach/hx4700.h>
 #include <asm/mach-types.h>
 #include "pxa2xx-i2s.h"

+static struct gpio_desc *gpiod_hp_driver, *gpiod_spk_sd;
 static struct snd_soc_jack hs_jack;

 /* Headphones jack detection DAPM pin */
@@ -40,9 +40,7 @@ static struct snd_soc_jack_pin hs_jack_pin[] = {

 /* Headphones jack detection GPIO */
 static struct snd_soc_jack_gpio hs_jack_gpio = {
-       .gpio           = GPIO75_HX4700_EARPHONE_nDET,
-       .invert         = true,
-       .name           = "hp-gpio",
+       .name           = "earphone-det",
        .report         = SND_JACK_HEADPHONE,
        .debounce_time  = 200,
 };
@@ -81,14 +79,14 @@ static const struct snd_soc_ops hx4700_ops = {
 static int hx4700_spk_power(struct snd_soc_dapm_widget *w,
                            struct snd_kcontrol *k, int event)
 {
-       gpio_set_value(GPIO107_HX4700_SPK_nSD, !!SND_SOC_DAPM_EVENT_ON(event));
+       gpiod_set_value(gpiod_spk_sd, !!SND_SOC_DAPM_EVENT_ON(event));
        return 0;
 }

 static int hx4700_hp_power(struct snd_soc_dapm_widget *w,
                           struct snd_kcontrol *k, int event)
 {
-       gpio_set_value(GPIO92_HX4700_HP_DRIVER, !!SND_SOC_DAPM_EVENT_ON(event));
+       gpiod_set_value(gpiod_hp_driver, !!SND_SOC_DAPM_EVENT_ON(event));
        return 0;
 }

@@ -162,11 +160,6 @@ static struct snd_soc_card snd_soc_card_hx4700 = {
        .fully_routed           = true,
 };

-static struct gpio hx4700_audio_gpios[] = {
-       { GPIO107_HX4700_SPK_nSD, GPIOF_OUT_INIT_HIGH, "SPK_POWER" },
-       { GPIO92_HX4700_HP_DRIVER, GPIOF_OUT_INIT_LOW, "EP_POWER" },
-};
-
 static int hx4700_audio_probe(struct platform_device *pdev)
 {
        int ret;
@@ -174,26 +167,26 @@ static int hx4700_audio_probe(struct
platform_device *pdev)
        if (!machine_is_h4700())
                return -ENODEV;

-       ret = gpio_request_array(hx4700_audio_gpios,
-                               ARRAY_SIZE(hx4700_audio_gpios));
+       gpiod_hp_driver = devm_gpiod_get(&pdev->dev, "hp-driver",
GPIOD_OUT_HIGH);
+       ret = PTR_ERR_OR_ZERO(gpiod_hp_driver);
+       if (ret)
+               return ret;
+       gpiod_spk_sd = devm_gpiod_get(&pdev->dev, "spk-sd", GPIOD_OUT_LOW);
+       ret = PTR_ERR_OR_ZERO(gpiod_spk_sd);
        if (ret)
                return ret;

+       hs_jack_gpio.gpiod_dev = &pdev->dev;
        snd_soc_card_hx4700.dev = &pdev->dev;
        ret = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_hx4700);
-       if (ret)
-               gpio_free_array(hx4700_audio_gpios,
-                               ARRAY_SIZE(hx4700_audio_gpios));

        return ret;
 }

 static int hx4700_audio_remove(struct platform_device *pdev)
 {
-       gpio_set_value(GPIO92_HX4700_HP_DRIVER, 0);
-       gpio_set_value(GPIO107_HX4700_SPK_nSD, 0);
-
-       gpio_free_array(hx4700_audio_gpios, ARRAY_SIZE(hx4700_audio_gpios));
+       gpiod_set_value(gpiod_hp_driver, 0);
+       gpiod_set_value(gpiod_spk_sd, 0);
        return 0;
 }
