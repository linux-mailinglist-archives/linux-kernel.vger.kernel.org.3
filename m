Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5370F54FBED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383207AbiFQRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383250AbiFQRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:08:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1CF3A5CC;
        Fri, 17 Jun 2022 10:08:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g25so9894433ejh.9;
        Fri, 17 Jun 2022 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGOk6FsrqRXMZ4vbSIHQhJs6+uCjgqOtgAZ7N+2CH2A=;
        b=mBRhhaoKoCMsMRJ16JCO9KF7gtxh921GO5pYbMVZLmYlqiiSLz+FkYhrsj3ozOOjKi
         XMBsJDHAdNwCpgf1rtme1VdfKvv71hVDpv7XYQVnyT78GrSltMrkKJvxR74k9GsmGmZ2
         qNvkCbCCcuLOwRN+0sTF+kDfo7eenwR+DzE8vN8Sn0LlQ7XpsSSVy3T7ZJYp5kHBbtXr
         MOviKgIlRL/yagy9niXBoQWBZ55fqXbZdV1zNQPNjSpUDzE/9V55hvmsJjssOk5qf4Er
         ijzbKn0ReWOM1DPva0ZfZ4bwH3EIcQ2QHeCfSixjGkGtYVvyOePROJLF/6iOk0SPxPti
         Kibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGOk6FsrqRXMZ4vbSIHQhJs6+uCjgqOtgAZ7N+2CH2A=;
        b=weakx/nZ1YPqe4LoWNU7ES005QQiZNfg2XlQuIxG/5KhM5JWcAFIM/mEejtbMSDHiH
         8Jvl4bAmjYNtk5RUXIlkKVunKvDed57fRq/qXqK0Ij18L9r9SShE8Uwrl3dJpPJH2h2V
         NlSwIvFTodXv8ci+QM6XeJDKFB+Hi0RzshysfbiBX7OCOMlUbgQJVJy9pQGnY3nr1DMX
         kc4rnOnMB+ePtpuC4s29y9CQ3gYfAyAzSP2TPMkdSlycLhhoqqOjGHUcn6VS0XtFO6Tm
         hNawwwGaNHawZvgb2cHj29Oh6teL5ykfc+uTupwycKLqrfd+bp0JQqS3EuNMoodLLFn+
         W5jA==
X-Gm-Message-State: AJIora/9lYEVaGB3mpQX1z+DaWeTrQfL//PI2OZEj0sK5Cemy+vGOwec
        i2CnhAFF8B6/PV5Z5SJUEkioLBNBf7bDuMVa5P8=
X-Google-Smtp-Source: AGRyM1uuX8QeC8aAoDmlgHjX/EnpM/rnU+ubv3666u02FQPcRwGnTtginlJKe/bqETovUtkaqwZk3C7zOWkAnOYlQ1I=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr10186705ejc.579.1655485703594; Fri, 17
 Jun 2022 10:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com> <1655458375-30478-3-git-send-email-u0084500@gmail.com>
In-Reply-To: <1655458375-30478-3-git-send-email-u0084500@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jun 2022 19:07:46 +0200
Message-ID: <CAHp75VfEQ6tu4-NQKwA+63Ae5busUwV+ZRqD6BtbUA+EkCZnWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add rtq6056 support
To:     cy_huang <u0084500@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>, cy_huang@richtek.com,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Fri, Jun 17, 2022 at 11:37 AM cy_huang <u0084500@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add Richtek RTQ6056 supporting.
>
> It can be used for the system to monitor load current and power with 16bit

16-bit

> resolution.

Overall looks good, needs some cosmetic work.

...

> +KernelVersion: 5.18.2

Wrong version, this won't be part of a stable kernel.

...

> +#include <linux/of.h>

Any users of this?

But for sure you missed

  mod_devicetable.h
  types.h

...

> +#define RTQ6056_DEFAULT_RSHUNT 2000

_mOHMs ?

...

> +enum {
> +       F_OPMODE = 0, F_VSHUNTCT, F_VBUSCT, F_AVG, F_RESET,
> +       F_MAX_FIELDS

Hard to read this way. Split to be one emum entry per line.

> +};

...

> +struct rtq6056_priv {
> +       struct device *dev;
> +       struct regmap *regmap;

Swapping these two might give less code in the generated binary. Have
you run bloat-o-meter?

> +       struct regmap_field *rm_fields[F_MAX_FIELDS];
> +       u32 shunt_resistor_uohm;
> +       int vshuntct; /* vshunt conversion time in uS */
> +       int vbusct; /* vbus conversion time in uS */
> +       int avg_sample;
> +};

...

> +       IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL)

Keep a comma.

...


> +       /* Only power and vbus channel is unsigned */
> +       if (channel == RTQ6056_CH_VBUS || channel == RTQ6056_CH_POWER)
> +               *val = regval;
> +       else

> +               *val = (s16)regval;

Why casting? At very minimum this requires a comment.

...

> +       if (val > 8205 || val < 139)
> +               return -EINVAL;

This strange range requires a good comment with possible references to
the datasheet.

...

> +static const int rtq6056_avg_sample_list[] = {
> +       1, 4, 16, 64, 128, 256, 512, 1024

Keep a comma at the end.

> +};

...

> +static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
> +                                 struct iio_chan_spec const *chan,
> +                                 char *label)
> +{
> +       return snprintf(label, PAGE_SIZE, "%s\n",
> +                       rtq6056_channel_labels[chan->channel]);

sysfs_emit()

> +}

...

> +static IIO_DEVICE_ATTR(shunt_resistor, 0644,
> +                      rtq6056_shunt_resistor_show,
> +                      rtq6056_shunt_resistor_store, 0);

IIO_DEVICE_ATTR_RW()

...

> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {

On one line it's better.

> +

Redundant blank line.

> +               ret = regmap_read(priv->regmap, RTQ6056_REG_SHUNTVOLT + bit,
> +                                 &raw);
> +               if (ret)
> +                       goto out;
> +
> +               data.vals[i++] = raw;
> +       }

> +       ret = of_property_read_u32(i2c->dev.of_node,
> +                                  "richtek,shunt-resistor-uohm",
> +                                  &shunt_resistor_uohm);

device_property_read()

> +       if (ret)
> +               shunt_resistor_uohm = RTQ6056_DEFAULT_RSHUNT;

Can be done without branch

... = DEFAULT;
device_property_read_u32(...); // no error checking.

...

> +static int rtq6056_remove(struct i2c_client *i2c)
> +{
> +       struct rtq6056_priv *priv = i2c_get_clientdata(i2c);
> +
> +       /* Config opmode to 'shutdown' mode to minimize quiescient current */

quiescent

> +       return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> +}
> +
> +static void rtq6056_shutdown(struct i2c_client *i2c)
> +{
> +       struct rtq6056_priv *priv = i2c_get_clientdata(i2c);
> +
> +       /* Config opmode to 'shutdown' mode to minimize quiescient current */

quiescent

> +       regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> +}

-- 
With Best Regards,
Andy Shevchenko
