Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C882470E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhLJXVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhLJXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:21:09 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6FC061746;
        Fri, 10 Dec 2021 15:17:33 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x131so9713147pfc.12;
        Fri, 10 Dec 2021 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KAk1dOM50tRYJWXmhUA/suKdjkGfYG+3Q7EV8Ria4hw=;
        b=mySaTyHfP6Hv6lJo2apR3fCTN3n48X6GJBF+97g8gvHNZpk7hFrK2bhP+D5jWawF9h
         +Tpi0jwlyBD9TzGibD2sshLL16qur5DqYLGhUH571J/hyaPmOII5StvXegwm+kcmffkj
         oIrNJiqJBLmIN4YTcS2lwhY0tdUAFVIgUm7NuacWcEONnz2QmQJYi8y0eEYAOyNtAQwQ
         fhjEoZajzULWxjUqaocX1eL7WqrWPtPkg2yoVjL8H/99xHOtmazTLZRruCR9WKXA7faY
         6RNA9z0kUXoLTtJIEEdm6FDidwobEel5lxKZ+xvM7P8HcZaiY9Bj3Oy6JDtJNXAQcko/
         46Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KAk1dOM50tRYJWXmhUA/suKdjkGfYG+3Q7EV8Ria4hw=;
        b=YOxZRJypeoN1fJuLL0/cajCkUVu5hTJbMouxw6g1bDwh9aYJGZVn/Mtk7AzMwjyIIs
         oBy0XrAEyRWnxbYaDY1Jo7AjOPaJvQKfiVgW3jBTQDFUB7WWjw6CrKXY6fRvl8vuCw5q
         bP+Zvpyi+B5vKG8FZVaEsMlUahQOTA9lPnuv+bO3vLAFoEPTPGdd0VhG0leeoxfCGBZv
         OojxLdCIny/feq+W2KWgEeMZJBrIQ6FqC2/2prOQ/R5/2GikgABawXq8ucuHZ3kq+nBR
         4kIBwZGFhbveNE/nJuVD/pIJ7dbB8croFvnZbHsFdFEoG4mE6e7ig7oanSon18bIbu5E
         6LSg==
X-Gm-Message-State: AOAM530AXU6VRb3C99VKviUjlj8PeGe7GDyMjjL9xDRDc/DdmKWHtKId
        IADivmoMNmYAbaNav3gbbuc=
X-Google-Smtp-Source: ABdhPJyUoc14ZyiK69nKLlW70PlhTByuR3g3Rb41JcS86QV7lfRQmZMBcxcynkQfDqwmZNJkFmFviQ==
X-Received: by 2002:a63:1554:: with SMTP id 20mr28463924pgv.617.1639178253046;
        Fri, 10 Dec 2021 15:17:33 -0800 (PST)
Received: from google.com ([2620:15c:202:201:749:db5e:6dc8:be24])
        by smtp.gmail.com with ESMTPSA id j7sm75231pjf.41.2021.12.10.15.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 15:17:31 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:17:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH V5 2/6] drivers/input/joystick: sensehat: Raspberry Pi
 Sense HAT joystick driver
Message-ID: <YbPgCdkVpEJw5XQM@google.com>
References: <20211210221033.912430-1-cmirabil@redhat.com>
 <20211210221033.912430-3-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210221033.912430-3-cmirabil@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Fri, Dec 10, 2021 at 05:10:29PM -0500, Charles Mirabile wrote:
> This patch implements support for the joystick.
> It supports left/right/up/down/enter and is
> attached via i2c and a gpio pin for irq.

This is not really a joystick, at least not in current incarnation, but
rather a set of keys. I'd also question whether the selected set is
right for the application, I'd look into BTN_DPAD_* maybe? 

Or, if you want it to be a joystick, map ABS_X/ABS_Y.

> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  drivers/input/joystick/Kconfig             |   8 ++
>  drivers/input/joystick/Makefile            |   1 +
>  drivers/input/joystick/sensehat-joystick.c | 119 +++++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/input/joystick/sensehat-joystick.c
> 
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index 3b23078bc7b5..d5c5ffe13903 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -399,4 +399,12 @@ config JOYSTICK_N64
>  	  Say Y here if you want enable support for the four
>  	  built-in controller ports on the Nintendo 64 console.
>  
> +config JOYSTICK_SENSEHAT
> +	tristate "Raspberry Pi Sense HAT joystick"
> +	depends on GPIOLIB && INPUT && I2C

I do not see I2C accessed directly in this driver, nor GPIO interface.
You also do not need to depend on INPUT explicitly here.

> +	select MFD_SENSEHAT_CORE
> +
> +	help
> +	  This is the joystick driver for the Raspberry Pi Sense HAT
> +
>  endif
> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
> index 5174b8aba2dd..39c8b5c6e5ae 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)		+= n64joy.o
>  obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
>  obj-$(CONFIG_JOYSTICK_PXRC)		+= pxrc.o
>  obj-$(CONFIG_JOYSTICK_QWIIC)		+= qwiic-joystick.o
> +obj-$(CONFIG_JOYSTICK_SENSEHAT)         += sensehat-joystick.o
>  obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
>  obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
> diff --git a/drivers/input/joystick/sensehat-joystick.c b/drivers/input/joystick/sensehat-joystick.c
> new file mode 100644
> index 000000000000..1f6bb09b4d1f
> --- /dev/null
> +++ b/drivers/input/joystick/sensehat-joystick.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Raspberry Pi Sense HAT joystick driver
> + * http://raspberrypi.org
> + *
> + * Copyright (C) 2015 Raspberry Pi
> + * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * Original Author: Serge Schneider
> + * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + */
> +
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>

Don't think you need this.

> +#include <linux/interrupt.h>
> +#include <linux/gpio/consumer.h>

Not needed.

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/sensehat.h>
> +
> +#define SENSEHAT_KEYS 0xF2
> +
> +static int sensehat_get_joystick_state(struct sensehat *sensehat);
> +
> +static unsigned char keymap[] = {
> +	KEY_DOWN, KEY_RIGHT, KEY_UP, KEY_ENTER, KEY_LEFT,
> +};

Because you allowing manipulating keymap from userspace you need to make
a copy of it when setting up input device so that changes do would not
persist across bind/unbind.

This array needs to be marked const.

> +
> +static irqreturn_t sensehat_joystick_report(int n, void *cookie)
> +{
> +	int i;
> +	static s32 prev_keys;
> +	struct sensehat *sensehat = cookie;
> +	struct sensehat_joystick *sensehat_joystick = &sensehat->joystick;
> +	s32 keys = sensehat_get_joystick_state(sensehat);
> +	s32 changes = keys ^ prev_keys;
> +
> +	prev_keys = keys;
> +	for (i = 0; i < ARRAY_SIZE(keymap); ++i) {
> +		if (changes & (1 << i)) {
> +			input_report_key(sensehat_joystick->keys_dev, keymap[i],
> +					 keys & (1 << i));
> +		}
> +	}

If you go with keys/buttons approach, then use
bitmap_xor()/for_each_set_bit() - see
drivers/input/keyboard/cypress-sf.c::cypress_sf_irq_handler() for
example of use.

> +	input_sync(sensehat_joystick->keys_dev);
> +	return IRQ_HANDLED;
> +}
> +
> +static int sensehat_joystick_probe(struct platform_device *pdev)
> +{
> +	int ret;

Please call it "error";

> +	int i;
> +	struct sensehat *sensehat = dev_get_drvdata(&pdev->dev);
> +	struct sensehat_joystick *sensehat_joystick = &sensehat->joystick;

This structure (struct sensehat_joystick) should probably be private to
this driver.

> +
> +	sensehat_joystick->keys_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!sensehat_joystick->keys_dev) {
> +		dev_err(&pdev->dev, "Could not allocate input device.\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(keymap); i++) {
> +		set_bit(keymap[i], sensehat_joystick->keys_dev->keybit);
> +	}
> +
> +	sensehat_joystick->keys_dev->name = "Raspberry Pi Sense HAT Joystick";
> +	sensehat_joystick->keys_dev->phys = "rpi-sense-joy/input0";
> +	sensehat_joystick->keys_dev->id.bustype = BUS_I2C;
> +	sensehat_joystick->keys_dev->evbit[0] =
> +		BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	sensehat_joystick->keys_dev->keycode = keymap;
> +	sensehat_joystick->keys_dev->keycodesize = sizeof(unsigned char);
> +	sensehat_joystick->keys_dev->keycodemax = ARRAY_SIZE(keymap);
> +
> +	ret = input_register_device(sensehat_joystick->keys_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not register input device.\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, sensehat->i2c_client->irq,
> +					NULL, sensehat_joystick_report,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,

Do not specify trigger type, whoever set up client's interrupt should
have set up appropriate trigger.

> +					"keys", sensehat);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "IRQ request failed.\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +int sensehat_get_joystick_state(struct sensehat *sensehat)
> +{
> +	unsigned int reg;
> +	int ret = regmap_read(sensehat->regmap, SENSEHAT_KEYS, &reg);
> +
> +	return ret < 0 ? ret : reg;

I do not see the point in having this wrapper.

> +}
> +
> +static struct platform_device_id sensehat_joystick_device_id[] = {
> +	{ .name = "sensehat-joystick" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, sensehat_joystick_device_id);
> +
> +static struct platform_driver sensehat_joystick_driver = {
> +	.probe = sensehat_joystick_probe,
> +	.driver = {
> +		.name = "sensehat-joystick",
> +	},
> +};
> +
> +module_platform_driver(sensehat_joystick_driver);
> +
> +MODULE_DESCRIPTION("Raspberry Pi Sense HAT joystick driver");
> +MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.31.1
> 

Thanks.

-- 
Dmitry
