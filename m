Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B6C4C20D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiBXAu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiBXAuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:50:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37058F210E;
        Wed, 23 Feb 2022 16:49:44 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vz16so1055619ejb.0;
        Wed, 23 Feb 2022 16:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i55z3pOW9V6Bu0WaroA/XOCY0+AorvQDiheA/c25Gxg=;
        b=lrreJxet9kc+GEpo9F4jktMaOeiwvvyc45FRfBb6zIssQ3F1Vj2LsRMKKQe8swMOEa
         GVYUey1uv+8KueY6TfbLzKto9r5KJNeMuhquzFjFwf/a9fmHcHfm4NMRHiPY9lhs/vIT
         85sp2CHhRl7GpPdG1M1NQhETMlkQT8kRjmp2BcvEl8yk8J3kOf2xroi+PL1XStKlay60
         Yo6gqYw7aS2arvLnPWMMXpg0FqhEv/QPX+R+03cKQW5+JnW4qE3m9T4YUmV+4QQfo+0N
         rAioGSEt1UHy85mdTRZ2Zconj4Cm6B9qkn58o5NZrUeFER6rsyL7ohGFR2HdTcBAGshp
         sjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i55z3pOW9V6Bu0WaroA/XOCY0+AorvQDiheA/c25Gxg=;
        b=lQyedV9+HC707kPQZU0iws8dMZ3tZLA3XyPILJBosGX9pdT0SBZq0OvhWKQj0V5F3T
         OX+m8wPQvH0Bu7DSLeRMUhWmr3+D7crwXV8NKIOlQmLfKMSklYRL8kV1SJ2juzM5jadl
         7DTZQOrZLqZDZt4b/kavCiZJRG4sTglEYJhU51EnV9lvfb41cW2K4OENRO4rPuMzv0L3
         XG39yx0p//hj9kkMzB8Rx7wEWSgYv/03Y8iH490sHa9dPSCh+ZGWRqsYLcz+m3UAMOUV
         CFu2QxCGSik4ihtIUOAxNJEH1VMGQvbo+b9wRgX0QxvGfTod3g40tbZLmCJhMxb0bzYO
         C3Cw==
X-Gm-Message-State: AOAM532FOU5Gm033BbL0xKXGS8dIcIK8HcVmob47J6/kvnWpjIzg/R0g
        b2Pg2kbKgbn74S5XoejHu0z3cCA+n66g3ATCDUc=
X-Google-Smtp-Source: ABdhPJx8zlivLeViTos7obPP26bYJDrPc9PrrP6klqoVBCJQlD3yP1us5OvN7wxyECzQTn7vQiLszYVvSBST9YGeppU=
X-Received: by 2002:a17:906:5950:b0:6b3:65b7:82d3 with SMTP id
 g16-20020a170906595000b006b365b782d3mr225501ejr.636.1645663677923; Wed, 23
 Feb 2022 16:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20220223163525.13399-1-jagathjog1996@gmail.com> <20220223163525.13399-6-jagathjog1996@gmail.com>
In-Reply-To: <20220223163525.13399-6-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Feb 2022 02:46:34 +0200
Message-ID: <CAHp75VcKvXi6oUm2Ysx_F+Myu6Dy9-Vxp9MwTcrT5si0Fe6c7w@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] iio: potentiometer: Add device specific read_raw function
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Feb 23, 2022 at 6:35 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added function pointer in the device specific structure to
> call the appropriate device read_raw function, so that the
> other type of devices with different read method can be
> handled.
>
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/potentiometer/ds1803.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> index aeb74ee46fbc..878188351f8f 100644
> --- a/drivers/iio/potentiometer/ds1803.c
> +++ b/drivers/iio/potentiometer/ds1803.c
> @@ -32,6 +32,8 @@ struct ds1803_cfg {
>         int kohms;
>         const struct iio_chan_spec *channels;
>         u8 num_channels;
> +       int (*read)(struct iio_dev *indio_dev,
> +                   struct iio_chan_spec const *chan, int *val);
>  };
>
>  struct ds1803_data {
> @@ -55,6 +57,22 @@ static const struct iio_chan_spec ds1803_channels[] = {
>         DS1803_CHANNEL(1, DS1803_WIPER_1),
>  };
>
> +static int ds1803_read(struct iio_dev *indio_dev,
> +                      struct iio_chan_spec const *chan,
> +                      int *val)
> +{
> +       struct ds1803_data *data = iio_priv(indio_dev);
> +       int ret;
> +       u8 result[ARRAY_SIZE(ds1803_channels)];
> +
> +       ret = i2c_master_recv(data->client, result, indio_dev->num_channels);
> +       if (ret < 0)
> +               return ret;
> +
> +       *val = result[chan->channel];
> +       return ret;
> +}
> +
>  static const struct ds1803_cfg ds1803_cfg[] = {
>         [DS1803_010] = {
>           .wipers = 2,
> @@ -62,6 +80,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
>           .kohms =  10,
>           .channels = ds1803_channels,
>           .num_channels = ARRAY_SIZE(ds1803_channels),
> +         .read = ds1803_read,
>         },
>         [DS1803_050] = {
>           .wipers = 2,
> @@ -69,6 +88,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
>           .kohms =  50,
>           .channels = ds1803_channels,
>           .num_channels = ARRAY_SIZE(ds1803_channels),
> +         .read = ds1803_read,
>         },
>         [DS1803_100] = {
>           .wipers = 2,
> @@ -76,6 +96,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
>           .kohms = 100,
>           .channels = ds1803_channels,
>           .num_channels = ARRAY_SIZE(ds1803_channels),
> +         .read = ds1803_read,
>         },
>  };
>
> @@ -84,20 +105,15 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>                            int *val, int *val2, long mask)
>  {
>         struct ds1803_data *data = iio_priv(indio_dev);
> -       int pot = chan->channel;
>         int ret;
> -       u8 result[ARRAY_SIZE(ds1803_channels)];
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> -               ret = i2c_master_recv(data->client, result,
> -                                     indio_dev->num_channels);
> +               ret = data->cfg->read(indio_dev, chan, val);
>                 if (ret < 0)
>                         return ret;
>
> -               *val = result[pot];
>                 return IIO_VAL_INT;

> -

Seems like a stray change. Up to Jonathan to decide what to do (no
need for resend b/c of this).

>         case IIO_CHAN_INFO_SCALE:
>                 *val = 1000 * data->cfg->kohms;
>                 *val2 = data->cfg->avail[2]; /* Max wiper position */
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
