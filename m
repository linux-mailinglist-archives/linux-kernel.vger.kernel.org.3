Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B85891C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbiHCRuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiHCRuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:50:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C95C7E;
        Wed,  3 Aug 2022 10:50:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e13so3484843edj.12;
        Wed, 03 Aug 2022 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qasC3HWPx6PH1+kvajAZ6EY5Z+jLltPhwmiv29VZxXo=;
        b=dMeflMAk0cL0Dctr4+70NE20mGXlN8sGDdJ5pgQ+ggWywPvgcx/giTjy4be/WczrK5
         9LMe3QHVAYXpqrpsDBn1Y10R6mLNpXlYqovmU/XrlXnsgSx11hLEvQmYANryGrwkzzgM
         hysQqsUTLHZ7wAf6bxG1nNWVHtGst4ex+3v6GV3v7KtEwnlJQL1nERhZ4/SUik3p2oi0
         dEAnHfBbhN8GFAN6yWaOpZRwA5kB6tPd+O01cZKcj99FnvQebyELeMQpeNaBLRcO7EBp
         9UFBMGf9efvvQT26zjGztXdBqvPEMbtWnc0KBube39otJv9mwmETfi0GbZG5aixpHQ0r
         WUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qasC3HWPx6PH1+kvajAZ6EY5Z+jLltPhwmiv29VZxXo=;
        b=gtWt/WnxA4YpXa3/ZVEy8dae2oVZbEn/G29Gywg6fbXL8qYigEkrhdhrNsjMfzRosP
         3F85YqsC8wDcaypuF9QfRDHqGyHdeqPwut+555j8qFeQjUF9rIaX+n+tZdpMDBm4J4Lb
         EOO8UETYQx3l3WnoV7Q7ohLext+LqtlWdj25dn6NS90s5lwO3rIsQrk0xN3jVC0lOUSR
         bgCzhQC7yqGB2glrm6oa7i0e1gHvPTF7Zuv3ILrt51XfdYvvUs76tOQmkKy+sMR0tW9C
         fSN9CqVaBafgmL7sYbywmMWrZf+iRHsHiAE68BPVsS6G7ID2W0mNNkSlgE97T7jTAact
         40dQ==
X-Gm-Message-State: AJIora/9tnNebw35BFw+bSsYvqszB8nMzKWC2x4YGo07AYy6LPa7LRs8
        BNpPHHT6UfDeCUXNCFMFDVYgX9gncsi2C2Caqjs=
X-Google-Smtp-Source: AGRyM1td3UmNFzVupi/RO1oITPC3utYLr8zjoBjd5q6yDX20oWIbNN5QnEGk4lP7vVTAlWrhSzcwijqnVL20a2h9DqY=
X-Received: by 2002:a05:6402:280b:b0:43b:5d75:fcfa with SMTP id
 h11-20020a056402280b00b0043b5d75fcfamr26157597ede.114.1659549010663; Wed, 03
 Aug 2022 10:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru> <20220803131132.19630-3-ddrokosov@sberdevices.ru>
In-Reply-To: <20220803131132.19630-3-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Aug 2022 19:49:33 +0200
Message-ID: <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 3:11 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamic user-selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
>
> Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
>
> This driver supports following MSA311 features:
>     - IIO interface
>     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
>     - ODR (Output Data Rate) selection
>     - Scale and samp_freq selection
>     - IIO triggered buffer, IIO reg access
>     - NEW_DATA interrupt + trigger
>
> Below features to be done:
>     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
>     - Low Power mode

Thanks for an update, my comments below.

...

> +#include <linux/i2c.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

I would split this group out of generic headers...

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/string_helpers.h>
> +#include <linux/units.h>
> +

...and move it here to clearly show that the driver belongs to the IIO
subsystem.

...

> +/*
> + * Possible Full Scale ranges
> + *
> + * Axis data is 12-bit signed value, so
> + *
> + * fs0 = (2 + 2) * 9.81 / (2<<11) = 0.009580
> + * fs1 = (4 + 4) * 9.81 / (2<<11) = 0.019160
> + * fs2 = (8 + 8) * 9.81 / (2<<11) = 0.038320
> + * fs3 = (16 + 16) * 9.81 / (2<<11) = 0.076641

I'm not sure if you are using programming language here or math language?
In math we refer to powers like 2^11, the 2<<11 puzzles me.

> + */

...

> +static const struct {
> +       int val;
> +       int val2;
> +} msa311_fs_table[] = {
> +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> +};

Besides that this struct is defined not only once in the file, this is
very well NIH struct s32_fract. Why not use the latter?

...

> +static const struct {
> +       int val;
> +       int val2;
> +} msa311_odr_table[] = {
> +       {1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
> +       {31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}
> +};

See above.

...

> +static const char * const msa311_pwr_modes[] = {
> +       [MSA311_PWR_MODE_NORMAL] = "normal",
> +       [MSA311_PWR_MODE_LOW] = "low",
> +       [MSA311_PWR_MODE_UNKNOWN] = "unknown",
> +       [MSA311_PWR_MODE_SUSPEND] = "suspend"

Leave a comma here even if we know that in the nearest future it won't
be changed.

> +};

...

> +       .cache_type = REGCACHE_RBTREE,

Tree hash is good for sparse data, do you really have it sparse (a lot
of  big gaps in between)?

> +};

...

> +       .datasheet_name = "ACC_"#axis                                       \

Leave a comma here.

...

> +static const struct iio_chan_spec msa311_channels[] = {
> +       MSA311_ACCEL_CHANNEL(X),
> +       MSA311_ACCEL_CHANNEL(Y),
> +       MSA311_ACCEL_CHANNEL(Z),
> +       IIO_CHAN_SOFT_TIMESTAMP(MSA311_SI_TIMESTAMP)

Ditto.

> +};

...

> +               dev_err(dev,
> +                       "failed to set odr %u.%uHz, not available in %s mode\n",
> +                       msa311_odr_table[odr].val,
> +                       msa311_odr_table[odr].val2 / 1000,

KILO ?

> +                       msa311_pwr_modes[pwr_mode]);

...

> +       static const int unintr_thresh_ms = 20;

You seem not using it as _ms, but always as _us, why not define accordingly?
Also the other one is defined as unsigned long and this is as int. Why
not unsigned?

...

> +       for (fs = 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)

fs++ will work as well.

> +               /* Do not check msa311_fs_table[fs].val, it's always 0 */
> +               if (val2 == msa311_fs_table[fs].val2) {
> +                       mutex_lock(&msa311->lock);
> +                       err = regmap_field_write(msa311->fields[F_FS], fs);
> +                       mutex_unlock(&msa311->lock);

> +                       if (err)
> +                               dev_err(dev, "cannot update scale (%d)\n", err);

This can be done after putting the device back into (auto)sleep, right?

> +                       break;
> +               }
> +
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);

...

> +       for (odr = 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)

odr++ works well also.

...

> +                               dev_err(dev, "cannot update freq (%d)\n", err);

frequency

...

> +               dev_err(dev, "cannot %s register %u from debugfs (%d)\n",
> +                       readval ? "read" : "write", reg, err);

You may consider taking [1] as a precursor here and use str_read_write().

[1]: https://lore.kernel.org/linux-i2c/20220703154232.55549-1-andriy.shevchenko@linux.intel.com/

...

> +       struct device *dev = msa311->dev;

Isn't it the same as indio_dev->dev.parent?
Do you really need that member?

...

> +       int bit = 0, err, i = 0;

How is the bit initial assignment used?

...

> +       /*
> +        * We do not check NEW_DATA int status, because of based on

because based on the

> +        * specification it's cleared automatically after a fixed time.
> +        * So just check that is enabled by driver logic.
> +        */

...

> +       /* TODO: check motion interrupts status */

I don't see the patches for this, so I assume they _will_ come in the
nearest future. Otherwise, drop these TODO lines.

...

> +               dev_dbg(dev, "found MSA311 compatible chip[%#x]\n", partid);

Useless message.

...

> +               return dev_err_probe(dev, err, "cannot disable set0 intrs\n");

interrupts

...

> +               return dev_err_probe(dev, err, "cannot disable set1 intrs\n");

Ditto.

...

> +               return dev_err_probe(dev, err, "failed to unmap map0 intrs\n");

Ditto.

...

> +               return dev_err_probe(dev, err, "failed to unmap map1 intrs\n");

Ditto.

...

> +       /* Disable all axis by default */

axis...

> +       err = regmap_update_bits(msa311->regs, MSA311_ODR_REG,
> +                                MSA311_GENMASK(F_X_AXIS_DIS) |
> +                                MSA311_GENMASK(F_Y_AXIS_DIS) |
> +                                MSA311_GENMASK(F_Z_AXIS_DIS), 0);
> +       if (err)
> +               return dev_err_probe(dev, err, "cannot enable all axes\n");

...or axes?

...

> +               return dev_err_probe(dev, err, "failed to set accel freq\n");

frequency

...

> +               return dev_err_probe(dev, err, "failed to request irq\n");

IRQ

...

> +               return dev_err_probe(dev, -ENOMEM,
> +                                    "cannot allocate newdata trig\n");

trigger

...

> +               return dev_err_probe(dev, err, "can't register newdata trig\n");

Ditto.

...

> +               return dev_err_probe(dev, err, "cannot enable push-pull int\n");

interrupt

...

> +               return dev_err_probe(dev, err, "cannot set active int level\n");

Ditto.

...

> +               return dev_err_probe(dev, err, "cannot latch int\n");

Ditto.

...

> +               return dev_err_probe(dev, err, "cannot reset int\n");

Ditto.

...

> +               return dev_err_probe(dev, err, "cannot map new data int\n");

interrupt

...

> +               return dev_err_probe(dev, -ENOMEM,
> +                                    "iio device allocation failed\n");

IIO

...

> +       indio_dev->modes = 0; /* setup buffered mode later */

Why explicit assignment to 0? Doesn't kzalloc() do it for you?

...

> +               return dev_err_probe(dev, err, "cannot setup iio trig buf\n");

IIO trigger buffer

...

> +               return dev_err_probe(dev, err, "iio device register failed\n");

IIO

-- 
With Best Regards,
Andy Shevchenko
