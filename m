Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88314AD7E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359402AbiBHLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358995AbiBHLuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1189C033258
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644320647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ze2ok6U2dUNlyFHTiL48rRdUl5NktkbKOQVaBuFaMHs=;
        b=BcKj6CMLMyX9Icdko1JlS3VGNy97bVrQ1K12p/4nB4vCLPIB5Vz9YX1dbccMx0qg9qEdGX
        j/B35oIkWOpRv1ticQi4zvR3JzOI2UIMDXHfdcE7g3KHiW7PkH+0V9AIE5D9Sm6Y8sWr3f
        RJvGen3BCeyYL+2dInHRoh6NYxzx1x8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-TJQekKzTOP6i-JR1V3wtrw-1; Tue, 08 Feb 2022 06:44:06 -0500
X-MC-Unique: TJQekKzTOP6i-JR1V3wtrw-1
Received: by mail-wm1-f72.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so945980wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 03:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ze2ok6U2dUNlyFHTiL48rRdUl5NktkbKOQVaBuFaMHs=;
        b=nBTHnGdbf+xs3o+XP9dwP5aa+8iWzEiCgY4twmhhKK4HvuXtYD1FrLzGnZgQ+1Xe2v
         uwbVe5sodDSAd8XyutFZWOjOsJn00ab7gJAj05+xXiQqqWDzYncuf9sPURWVhj+IsnND
         +wWmMVCDGnFHzlGNyt0gfkcTV9m4S+y2DMKF50fiehJgmckmk0PufvKANVnWjQVp8Dc1
         JsQRj/F6NOZSX8ytrkSCpHgH2ldEkOPxqpiXiewinJNdQKGe329hDH2a1BeHIrUD2TsO
         yNlkK4iHm+dUqfq1T0mxcO8VwxV03lcsMqQBxcNYrriCMz55+wxWT6RSe8b/aS/t4WkX
         wZjw==
X-Gm-Message-State: AOAM532/hchKA4jVju3MI3upM15K6HBbVh+zXA5+39NNKIQQpuWAC+po
        h53XMbe1m/qcpzlIZCP2XKy1GnZAr4sx33aPoompa8h9FR/nu45Bc2IFl7k2NzIiXvoS+VJRsBf
        TIDYJvGUM3THp+G+0oD6z/Rar
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr765570wmg.151.1644320644768;
        Tue, 08 Feb 2022 03:44:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOe2+6m1ZZLQr+0fJdBiNSKwp03uS1/8kFo/+PO6MTytpGrUJZleRcmSvBwnl7Q2NoKzrT2A==
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr765547wmg.151.1644320644496;
        Tue, 08 Feb 2022 03:44:04 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id ay3sm1849349wmb.44.2022.02.08.03.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:44:04 -0800 (PST)
Message-ID: <9e55f768356892fcf10de3241419f97124efd4f7.camel@redhat.com>
Subject: Re: [PATCH 2/6] drivers/input/joystick: sensehat: Raspberry Pi
 Sense HAT joystick driver
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 08 Feb 2022 12:44:03 +0100
In-Reply-To: <20220203002521.162878-3-cmirabil@redhat.com>
References: <20220203002521.162878-1-cmirabil@redhat.com>
         <20220203002521.162878-3-cmirabil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-02 at 19:25 -0500, Charles Mirabile wrote:
> This patch adds the driver for the Sense HAT joystick. It outputs BTN_DPAD
> key events when moved in any of the four directions and the BTN_SELECT
> event when depressed.
> 
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> ---
>  drivers/input/joystick/Kconfig             |  11 ++
>  drivers/input/joystick/Makefile            |   1 +
>  drivers/input/joystick/sensehat-joystick.c | 128 +++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/input/joystick/sensehat-joystick.c
> 
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index 3b23078bc7b5..505a032e2786 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -399,4 +399,15 @@ config JOYSTICK_N64
>  	  Say Y here if you want enable support for the four
>  	  built-in controller ports on the Nintendo 64 console.
>  
> +config JOYSTICK_SENSEHAT
> +	tristate "Raspberry Pi Sense HAT joystick"
> +	depends on INPUT && I2C
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	  Say Y here if you want to enable the driver for the
> +	  the Raspberry Pi Sense HAT.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sensehat_joystick.
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
> index 000000000000..a688cc8fbde3
> --- /dev/null
> +++ b/drivers/input/joystick/sensehat-joystick.c
> @@ -0,0 +1,128 @@
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
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/of_irq.h>
> +#include <linux/property.h>
> +
> +struct sensehat_joystick {
> +	struct platform_device *pdev;
> +	struct input_dev *keys_dev;
> +	unsigned long prev_states;
> +	u32 joystick_register;
> +};
> +
> +static const unsigned int keymap[] = {
> +	BTN_DPAD_DOWN, BTN_DPAD_RIGHT, BTN_DPAD_UP, BTN_SELECT, BTN_DPAD_LEFT,
> +};
> +
> +static irqreturn_t sensehat_joystick_report(int n, void *cookie)
> +{
> +	int i, error, keys;
> +	struct sensehat_joystick *sensehat_joystick = cookie;
> +	struct regmap *regmap =
> +		dev_get_regmap(sensehat_joystick->pdev->dev.parent, NULL);

I think it's better to get this during probe and save it in 'struct
sensehat_joystick'. You'll avoid having to search for it everytime.

> +	unsigned long curr_states, changes;
> +
> +	error = regmap_read(regmap, sensehat_joystick->joystick_register,
> +			    &keys);
> +	if (error < 0) {
> +		dev_err(&sensehat_joystick->pdev->dev,
> +			"Failed to read joystick state: %d", error);
> +		return IRQ_NONE;
> +	}
> +	curr_states = keys;
> +	bitmap_xor(&changes, &curr_states, &sensehat_joystick->prev_states,
> +		   ARRAY_SIZE(keymap));
> +
> +	for_each_set_bit(i, &changes, ARRAY_SIZE(keymap)) {
> +		input_report_key(sensehat_joystick->keys_dev, keymap[i],
> +				 curr_states & BIT(i));
> +	}
> +
> +	input_sync(sensehat_joystick->keys_dev);
> +	sensehat_joystick->prev_states = keys;
> +	return IRQ_HANDLED;
> +}
> +
> +static int sensehat_joystick_probe(struct platform_device *pdev)
> +{
> +	int error, i;
> +	struct sensehat_joystick *sensehat_joystick = devm_kzalloc(
> +		&pdev->dev, sizeof(*sensehat_joystick), GFP_KERNEL);
> +
> +	sensehat_joystick->pdev = pdev;
> +	sensehat_joystick->keys_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!sensehat_joystick->keys_dev) {
> +		dev_err(&pdev->dev, "Could not allocate input device.\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(keymap); i++)
> +		set_bit(keymap[i], sensehat_joystick->keys_dev->keybit);
> +
> +	sensehat_joystick->keys_dev->name = "Raspberry Pi Sense HAT Joystick";
> +	sensehat_joystick->keys_dev->phys = "sensehat-joystick/input0";
> +	sensehat_joystick->keys_dev->id.bustype = BUS_I2C;
> +	sensehat_joystick->keys_dev->evbit[0] =
> +		BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +
> +	error = input_register_device(sensehat_joystick->keys_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "Could not register input device.\n");
> +		return error;
> +	}
> +
> +	error = device_property_read_u32(&pdev->dev, "reg",
> +					 &sensehat_joystick->joystick_register);
> +	if (error) {
> +		dev_err(&pdev->dev, "Could not read register property.\n");
> +		return error;
> +	}

I don't think you really need to pass this information through the devicetree.
It's just the address to a register, not a HW design detail (i.e. how the board
is layout). Using a define is good enough.

> +
> +	error = devm_request_threaded_irq(&pdev->dev,
> +					  of_irq_get(pdev->dev.of_node, 0),

Use platform_get_irq() and remember the function may fail, both unrecoverable
errors and EPROBE_DEFER when the irqchip isn't ready yet.

> +					  NULL, sensehat_joystick_report,
> +					  IRQF_ONESHOT, "keys",
> +					  sensehat_joystick);
> +
> +	if (error) {
> +		dev_err(&pdev->dev, "IRQ request failed.\n");
> +		return error;
> +	}

nit: space here

> +	return 0;
> +}
> +
> +static const struct of_device_id sensehat_joystick_device_id[] = {
> +	{ .compatible = "raspberrypi,sensehat-joystick" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sensehat_joystick_device_id);
> +
> +static struct platform_driver sensehat_joystick_driver = {
> +	.probe = sensehat_joystick_probe,
> +	.driver = {
> +		.name = "sensehat-joystick",
> +		.of_match_table = sensehat_joystick_device_id,
> +	},
> +};
> +
> +module_platform_driver(sensehat_joystick_driver);
> +
> +MODULE_DESCRIPTION("Raspberry Pi Sense HAT joystick driver");
> +MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
> +MODULE_LICENSE("GPL");

-- 
Nicolás Sáenz

