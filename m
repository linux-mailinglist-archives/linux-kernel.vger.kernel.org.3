Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0813251F8C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiEIJfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiEIJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:27:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82D1202B1D;
        Mon,  9 May 2022 02:23:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gh6so25635262ejb.0;
        Mon, 09 May 2022 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBn4dTWE6t2YjSxYVSZ+XHjDtUdnCLlr7Yub++AF2JY=;
        b=UMu99fQ7EvMM4azPSGgoeypDXe4MYng1mEZ0U21NvAcrEz1gntIWP1xBSZkWmXmk7F
         CtpTZeQFa1+/kiBhnXjmM6LvhsoEModffF/1A2VG0q3jwVSUaS5xOF6mztXXnh1etJMb
         z1yfkcB6Z3iY7Nv3cfYqN7kgyoBM4AbbaUyaUvpshu0X5PkLf1kYrUlIpEFiKcjh6CCb
         LY2+ypStUcoiH1P/oQWrBIatVc71LtRUUDpNR2RULXF1A9++gxQNRBV7KWp7DdF+mbVo
         idt0DpZFmRleGWqkd4ti7Rwojh2RsGWU73piA14Z2HLTp8o84T3YcXvBcHj1xGKoNxwk
         dKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBn4dTWE6t2YjSxYVSZ+XHjDtUdnCLlr7Yub++AF2JY=;
        b=DGobrNnbvRM2DncV82gg08LqQ7prH9s4l5ivgIezn+evsOLUFh14XYUHnSE/V9e2CS
         nU+StEPrFwAjRd7IH1g5sipxL/u4IUUdZwOozKDNNgHe/3pVVj20pmIHvAlu1EjUk4bk
         yuAEwi4M4OhAzi+ubav1u7hItMO39Zldxrlrfqgm5JB7COi2BcNmLVgZ0bOwdj/SAqhk
         XtYd1JSMhFknmnGw5mrwZD3M4YlKM2MDCNmrp5jskI9sj5QiAyC1IdoOHEhV+vS1W+hd
         +criqnseZ0nI7b2wgi+T9wYRaQJBFMLjIvCWhWTyn53WudvFQP+6EB9t8xllfQnMAuzW
         N5Tw==
X-Gm-Message-State: AOAM530p8XD/GucnHki00SfEEWKCWQiOPVOvNiJ8FdG72+zuh9cS+etU
        T+Kp7nb2tqApX1EG+E1Td2n2phYLUKGddyCc1ic=
X-Google-Smtp-Source: ABdhPJytr5Q53vJpxm+rLJz+lGQrPYFhRJ+0SJnhlbHOhGV5P7N4d3f0afif01iB4K46QbH/ug85c5+SUNjBcOj2+mI=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr13501745ejc.132.1652088229173; Mon, 09
 May 2022 02:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn> <20220509064928.2352796-4-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220509064928.2352796-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 May 2022 11:23:13 +0200
Message-ID: <CAHp75VcAvRkM84XzYtE7T=Zwoa0Ee=OfCbOV-KbsDELAsy+ZiA@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] iio: accel: sca3300: modified to support multi chips
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
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

On Mon, May 9, 2022 at 8:49 AM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> The driver supports sca3300 only.
> There are some other similar chips, for instance, SCL3300.
> Prepare the way for multiple chips and additional channels.
> Modify the driver to read the device id.
> Add the tables for the corresponding id to support multiple chips.
> Add prepares for the addition of extra channels.
> Add prepares for handling the operation modes for multiple chips.

Fancy style. Utilize the entire width of the line, i.e. ~72 characters.

...

> +struct sca3300_chip_info {
> +       const struct iio_chan_spec *channels;
> +       u8 num_channels;
> +       const unsigned long *scan_masks;
> +       const int (*accel_scale)[2];
> +       const int *accel_scale_map;
> +       u8 num_accel_scales;
> +       const int *freq_table;
> +       const int *freq_map;
> +       u8 num_freqs;
> +       const int *avail_modes_table;
> +       u8 num_avail_modes;
> +       const char *name;
> +       u8 chip_id;

I recommend to shuffle it in a way that u8 members go closer to each
other if possible.

Like:

       const unsigned long *scan_masks;
       const struct iio_chan_spec *channels;
       u8 num_channels;
       u8 num_accel_scales;
       const int (*accel_scale)[2];
       const int *accel_scale_map;

It will save a few bytes per object instance due to padding reduction.

The idea about grouping all of them also can be done despite the
comment given previously by someone.

> +};

...

> +       for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
> +               if (sca_data->chip->avail_modes_table[i] == reg_val) {
> +                       *index = i;
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;

Can be modified to use standard pattern (return errors first), but
it's up to maintainers, because the latter requires an additional
check after the loop.

...

> +       for (i = 0; i < chip->num_avail_modes; i++) {
> +               if (val == chip->freq_table[chip->freq_map[i]]) {
> +                       if (chip->accel_scale[chip->accel_scale_map[index]] ==
> +                           chip->accel_scale[chip->accel_scale_map[i]])
> +                               return sca3300_set_op_mode(data, i);

The
  if (a) {
    if (b) {
      ...
    }
  }

can be replaced by

  if (a && b) {
    ...
  }

> +               }
> +       }
> +
> +       return -EINVAL;

As per above.

-- 
With Best Regards,
Andy Shevchenko
