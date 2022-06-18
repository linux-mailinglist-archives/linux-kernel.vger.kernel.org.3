Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7295505A6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiFRPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiFRPQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:16:57 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C1B12D;
        Sat, 18 Jun 2022 08:16:56 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id x6so3268580vkn.2;
        Sat, 18 Jun 2022 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V1K9EPliBWptrDcB8osFSELGBvWJExaG2oFR85I4vnQ=;
        b=p55oymC2KHlFoHPD0G6os4L61pdN6Did9HHdmflMvSDSc2GE3UUOjV7mKT1/7Yx6IJ
         Bj7+PzI2WRrvUZwUbjxYK8QewnFnjSfiDc4wXcdlm7Gowas9W279LD1O6Rsl/g83zAsD
         hwaoKAnKzh7wapNImPutfc+BOOrUONmE/1fLwlXZBEjmsmpLbOminhCO/4b0O+oVHI3m
         1Cq8xfV/LKZMyJNLvUsfRBV47K0rm9s6Qz+PkSu9dAh7T9jTvwu02xjkMGJdTEb2rUjl
         xh6ypW3UbC6Bqzwijkmaw9McrzaCFZGuDtUQ079tKctYLZDOMvRm8WWjlG12meUyfaah
         ZDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V1K9EPliBWptrDcB8osFSELGBvWJExaG2oFR85I4vnQ=;
        b=Ek03L4q6RpxRDz8xYrSEwlIFdn33b9A5+AVw5H4UQFEfCazS43kHqijsaVB/t59261
         HkkAO8bwj/A6AvoPir6Vyw1qW6qnbbXL8NS+g3mnZvItKdSQ86zOAl3lWAzgSswKbDNh
         xwhgvSwJbQMlBJ3BuOkbjPfHtZ4RkCEAa58I6AoFhGYIydrcrwnu/yJ9nyshHExULVIr
         noTgI8aqtT2ilUrfyWnB/W4vnhscxR9kboR77ix22IugS5YICswny0I/bas2ZLhTZf5P
         1z0hpCJAVXueYxcyb8W+wcqAvshkdFL8qWh+BSBeZXwXmEvLsZZSxeT2/jmT0rdZd7Ea
         +YfA==
X-Gm-Message-State: AJIora/XEUZrkyb3rN6KqAaZ7PMlPAmE0SJatmNAMUWQFfSLv/F4gwl/
        nKTbket7dfyQbbCn+gttLYIc/kjA6kCmt6kNRtFGDwPCP9k=
X-Google-Smtp-Source: AGRyM1vJXAjSKT+yq4uvpp7zY+dWBd4Lju0O+lC7tWuONHzmOcysy62ypAnFnh2v3uXh1jP8kvO2rcP9LNj0XjIe5g0=
X-Received: by 2002:a1f:d4c5:0:b0:368:a100:4b9a with SMTP id
 l188-20020a1fd4c5000000b00368a1004b9amr6452732vkg.27.1655565415594; Sat, 18
 Jun 2022 08:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-3-git-send-email-u0084500@gmail.com> <CAHp75VfEQ6tu4-NQKwA+63Ae5busUwV+ZRqD6BtbUA+EkCZnWw@mail.gmail.com>
In-Reply-To: <CAHp75VfEQ6tu4-NQKwA+63Ae5busUwV+ZRqD6BtbUA+EkCZnWw@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 18 Jun 2022 23:16:44 +0800
Message-ID: <CADiBU3-wO0-0c9y-GpE15ra2AqkAG-ftqTh+hCvYEY-TojZ-pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add rtq6056 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A81:08=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Fri, Jun 17, 2022 at 11:37 AM cy_huang <u0084500@gmail.com> wrote:
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Richtek RTQ6056 supporting.
> >
> > It can be used for the system to monitor load current and power with 16=
bit
>
> 16-bit
>
Ack in next.
> > resolution.
>
> Overall looks good, needs some cosmetic work.
>
> ...
>
> > +KernelVersion: 5.18.2
>
> Wrong version, this won't be part of a stable kernel.
>
From kernel.org, currently the stable kernel version is 5.18.5.
Change to 5.18.5?
> ...
>
> > +#include <linux/of.h>
>
> Any users of this?
>
function 'of_property_read_u32'.
But from Jonathan's reply, I may change it to 'device_property_read_u32'.
And also property.h will be included.
> But for sure you missed
>
>   mod_devicetable.h
>   types.h
>
Ack in next. But for types.h, i2c.h already include device.h.
And device.h already include types.h.
Is it still needed to declare explicitly for types.h??
> ...
>
> > +#define RTQ6056_DEFAULT_RSHUNT 2000
>
> _mOHMs ?
>
From Jonathan's reply, I may remove this value defined.
Since it's already a straight value. To define it, seems to decrease
the readability.
> ...
>
> > +enum {
> > +       F_OPMODE =3D 0, F_VSHUNTCT, F_VBUSCT, F_AVG, F_RESET,
> > +       F_MAX_FIELDS
>
> Hard to read this way. Split to be one emum entry per line.
>
Ack in next.
> > +};
>
> ...
>
> > +struct rtq6056_priv {
> > +       struct device *dev;
> > +       struct regmap *regmap;
>
> Swapping these two might give less code in the generated binary. Have
> you run bloat-o-meter?
>
I never know about this tool.
I'll check it before I submit the next revision.
Thanks for the reminding.

But from Jonathan's reply, I may remove 'struct regmap *regmap'.
If all function need the 'regmap', a local variable 'regmap' need to
be declared.
To use struct regmap *regmap =3D dev_get_regmap(dev, NULL) is more effectiv=
e.
> > +       struct regmap_field *rm_fields[F_MAX_FIELDS];
> > +       u32 shunt_resistor_uohm;
> > +       int vshuntct; /* vshunt conversion time in uS */
> > +       int vbusct; /* vbus conversion time in uS */
> > +       int avg_sample;
> > +};
>
> ...
>
> > +       IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL)
>
> Keep a comma.
>
Ack in next
> ...
>
>
> > +       /* Only power and vbus channel is unsigned */
> > +       if (channel =3D=3D RTQ6056_CH_VBUS || channel =3D=3D RTQ6056_CH=
_POWER)
> > +               *val =3D regval;
> > +       else
>
> > +               *val =3D (s16)regval;
>
> Why casting? At very minimum this requires a comment.
The value is already the 16-bit 2's complement value. That's why the
casting is here.
From Jonathan's reply, will replace it by sign_extend32.
>
> ...
>
> > +       if (val > 8205 || val < 139)
> > +               return -EINVAL;
>
> This strange range requires a good comment with possible references to
> the datasheet.
>
Ack in next.
> ...
>
> > +static const int rtq6056_avg_sample_list[] =3D {
> > +       1, 4, 16, 64, 128, 256, 512, 1024
>
> Keep a comma at the end.
>
> > +};
>
> ...
>
> > +static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 char *label)
> > +{
> > +       return snprintf(label, PAGE_SIZE, "%s\n",
> > +                       rtq6056_channel_labels[chan->channel]);
>
> sysfs_emit()
>
> > +}
>
> ...
>
> > +static IIO_DEVICE_ATTR(shunt_resistor, 0644,
> > +                      rtq6056_shunt_resistor_show,
> > +                      rtq6056_shunt_resistor_store, 0);
>
> IIO_DEVICE_ATTR_RW()
>
> ...
>
> > +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> > +                        indio_dev->masklength) {
>
> On one line it's better.
>
Ack in next
> > +
>
> Redundant blank line.
>
Ack in next.
> > +               ret =3D regmap_read(priv->regmap, RTQ6056_REG_SHUNTVOLT=
 + bit,
> > +                                 &raw);
> > +               if (ret)
> > +                       goto out;
> > +
> > +               data.vals[i++] =3D raw;
> > +       }
>
> > +       ret =3D of_property_read_u32(i2c->dev.of_node,
> > +                                  "richtek,shunt-resistor-uohm",
> > +                                  &shunt_resistor_uohm);
>
> device_property_read()
>
From you and other's reply, I may refine this part about the resistor parsi=
ng.
> > +       if (ret)
> > +               shunt_resistor_uohm =3D RTQ6056_DEFAULT_RSHUNT;
>
> Can be done without branch
>
OK
> ... =3D DEFAULT;
> device_property_read_u32(...); // no error checking.
>
> ...
>
> > +static int rtq6056_remove(struct i2c_client *i2c)
> > +{
> > +       struct rtq6056_priv *priv =3D i2c_get_clientdata(i2c);
> > +
> > +       /* Config opmode to 'shutdown' mode to minimize quiescient curr=
ent */
>
> quiescent
>
Sorry for the typo
> > +       return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> > +}
> > +
> > +static void rtq6056_shutdown(struct i2c_client *i2c)
> > +{
> > +       struct rtq6056_priv *priv =3D i2c_get_clientdata(i2c);
> > +
> > +       /* Config opmode to 'shutdown' mode to minimize quiescient curr=
ent */
>
> quiescent
>
Sorry for the typo
> > +       regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
