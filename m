Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7285997A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347468AbiHSImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347453AbiHSIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:42:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B6F65272;
        Fri, 19 Aug 2022 01:42:32 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j6so2827432qkl.10;
        Fri, 19 Aug 2022 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VzSuewIjUQpDvic1Fgqa68zOGD3yBqaHvGhRdaClA3o=;
        b=QudVAM6e29c3BuhMZSG1meem9oEv8vhzd9ac0cblLFbTKxCrZFYxcpWseE60QxQDMO
         xpVysrbpSU+DI/sScbpd0OTEa1EPOni0+oEbUbWcX9kF2aOlA1tlho3MX1zBZZffo7hb
         YLOhKTlScvnAUaQYkc1UcYmFdShrtv15LY5aCSgXpMFnXyR3dfHvYtltOjmEMJLDBvcV
         tS6D6oAFmHvvhx0kYmH+nelet2CJ8s2wZWGWALYNC/qa8bvBuV1dURsX71b0vX6F7CLs
         6Q2EQjVBMFxtemZEd3Q7VxHStmvj3tu/DQ8fqdtWGWRFoGaFe2vffVzFoTQdvgZR9HI0
         +EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VzSuewIjUQpDvic1Fgqa68zOGD3yBqaHvGhRdaClA3o=;
        b=0gBe24q8MemPMFtTbLYztvyYpWvrfj6KjcrYwRgcWagyG5ubh8oXPaQ3X7WQyBINs0
         bf7yr9YKmC9uWxAza2iFc1cmuKhRl/V6uSGIH8CGdEO5GqLG9SGM+cwaomK3OuiaqhUl
         VJXOa+6ufdnvNEitbqHJ7VdE44QVu+Axbm/86sA5rOfWWN+Ywzje/oprCX26JszWMDrE
         bqPEzfO8++T/fSGar6Y2Po0MEKNCUjFiqv6wtLLQBZgRVVNB5Nvt/NEJc3QHi5JuMfKT
         RQFaLR3UTDsye9+0al9LsMhrkwa3jwld5X6E4kqiwnC9/xVpwwq2+EC314qxv6+mv60r
         sDWA==
X-Gm-Message-State: ACgBeo2wixmvfTGlFuYnH4A/3oDm18UsIb/h9sY9Oju7RVLZ3GL/p7cm
        thBnAG8dG/bFf2hRTp68tXPj4amOFiwrYfd8P0FIdIb9Px0=
X-Google-Smtp-Source: AA6agR4e0ZjOWhcEmlN7CTN9pP31wSyMszjqo4JWtvtu5JWPM7UqVmowAdRcPEa5Em2eyaKswk3qEIZYp32z+IOrziU=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr4631678qkp.734.1660898551279; Fri, 19
 Aug 2022 01:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220816191842.14020-1-ddrokosov@sberdevices.ru> <20220816191842.14020-4-ddrokosov@sberdevices.ru>
In-Reply-To: <20220816191842.14020-4-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 11:41:55 +0300
Message-ID: <CAHp75VewJ1taLhsCb4_yEQHpw4VDXRhkxpL0jzdu-JsajfF6oA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:18 PM Dmitry Rokosov
<DDRokosov@sberdevices.ru> wrote:
>
> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamic user-selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
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

> Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf

Have you ever seen such a tag?
We have the Datasheet that is more or less established for this kind of links.

The comments below are not a big deal, though.

...

> +static const struct iio_decimal_fract msa311_fs_table[] = {
> +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}

I would still keep the trailing comma for better consistency with a style.

> +};

...

> +static const struct iio_decimal_fract msa311_odr_table[] = {
> +       {1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
> +       {31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}

Ditto.

> +};

...

> +struct msa311_priv {
> +       struct regmap *regs;
> +       struct regmap_field *fields[F_MAX_FIELDS];
> +
> +       struct device *dev;
> +       struct mutex lock;

> +       char chip_name[10];

Why limit it to 10? You may use devm_kasprintf()

> +       struct iio_trigger *new_data_trig;
> +       struct regulator *vdd;
> +};

...

> +static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)

Why inline?

> +{
> +       struct device *dev = msa311->dev;
> +       unsigned int pwr_mode;

> +       bool good_odr = false;

Can it be split to see the assignments together below?

> +       int err;
> +
> +       err = regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
> +       if (err)
> +               return err;
> +
> +       /* Filter bad ODR values */
> +       if (pwr_mode == MSA311_PWR_MODE_NORMAL)
> +               good_odr = (odr > MSA311_ODR_1_95_HZ);

else
  good_odr = false;

> +       if (!good_odr) {
> +               dev_err(dev,
> +                       "can't set odr %u.%06uHz, not available in %s mode\n",
> +                       msa311_odr_table[odr].integral,
> +                       msa311_odr_table[odr].microfract,
> +                       msa311_pwr_modes[pwr_mode]);
> +               return -EINVAL;
> +       }
> +
> +       return regmap_field_write(msa311->fields[F_ODR], odr);
> +}

...

> +       if (wait_ms < unintr_thresh_ms)
> +               usleep_range(wait_ms * USEC_PER_MSEC,
> +                            unintr_thresh_ms * USEC_PER_MSEC);
> +       else
> +               return msleep_interruptible(wait_ms) ? -EINTR : 0;

Can be refactored to simple

else if (msleep...)
  return -EINTR;

Same amount of LoCs, but more readable.

> +       return 0;

...

> +err:

We usually name labels after what they are doing, I don't see any
error here, but notify done. Hence,

out_notify_done:

> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;

...

> +       used = scnprintf(msa311->chip_name, sizeof(msa311->chip_name),
> +                        "msa311-%hhx", partid);

How 'used' is being used?

> +       return 0;
> +}

...

> +       const char zero_bulk[2] = {0};

0 is not needed, '{ }' will work.

...

> +       /*
> +        * Register powerdown deferred callback which suspends the chip
> +        * after module unloaded.
> +        *
> +        * MSA311 should be in SUSPEND mode in the two cases:
> +        * 1) When driver is loaded, but we do not have any data or
> +        *    configuration requests to it (we are solving it using
> +        *    autosuspend feature).
> +        * 2) When driver is unloaded and device is not used (devm action is
> +        *    used in this case).
> +        */

...

> +static struct i2c_driver msa311_driver = {
> +       .driver = {
> +               .name = "msa311",

> +               .owner = THIS_MODULE,

Redundant.

> +               .of_match_table = msa311_of_match,
> +               .pm = pm_ptr(&msa311_pm_ops),
> +       },
> +       .probe_new      = msa311_probe,
> +       .id_table       = msa311_i2c_id,
> +};

-- 
With Best Regards,
Andy Shevchenko
