Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B374901E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiAQGPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiAQGPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:15:32 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC44CC061574;
        Sun, 16 Jan 2022 22:15:31 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c190so16941356qkg.9;
        Sun, 16 Jan 2022 22:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=miI/KTSUJYn7JPetqRU0AB1f5MN5qyavg3LuiL7Shbo=;
        b=eJgC/w4tZZIDx/VIS/oo7EKER6fTg2++v8jMnNLwXrYepPhpSfGzdOKQE0t1dO3smU
         3TVeZWbQvadozW9FI2I/3eOLZhv73z7lmeod4a45ssJxwEvzY4wENIJOLXiFh4uGjIHK
         TM3AwlFaNdw4PS9wVGPPvGYvvEevf1m1JFvtJsaPkLJsSmy/i+ee/8g6PJ/oUDAO62Dk
         8mzsT3NquVi1dwtxPZeiv1/ef09SpO6yDfK/qONFYGdLqhcwILwYjmBgdpzoh633ZMoa
         Vb6hH9MU35hsUr4fKA0M5uP03a3tnf2xVs+MQzqTqOb62BtnxY3s0nREbZNx5l36CVMc
         kSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=miI/KTSUJYn7JPetqRU0AB1f5MN5qyavg3LuiL7Shbo=;
        b=GxK/cFcCzb25urJ/fVMajcxdcZU9qzwhSnobOVnLobvNdPXzuWtESkWPMI/pu7TTjV
         KG/xfY6CK0qiymRl5w4CLpWCH1mT4OzY5H1IpAUpDmOj7GBPr3Gz/K1vNR43tAK5qnmY
         /uX0qqD91DMj4fZmjwZvxL3fGS/wBzV3CH9y8EIEuzDZBP408vQO9RKoPdPm9Mw8UmhW
         cy6T8MJ3CKWmQG4EmjKokmmEX0pEfr8R1/pbwLarQCUWWhiRzv5uY9o5+6r0zTUigbaD
         +zb/2k7z7B/769rHw5xq8joKZhJoqgRQucUetg3c77OM0rsfz/WbUg4QP5UA3uj7dZGQ
         lIPw==
X-Gm-Message-State: AOAM531nanSw5/a5BRUiXb2gzxT18Ir/YdBAabm0VpIY4u7OpuTtdTCn
        dgb/qdx8atUXo5QHW8SBKSh7X+7fQdpyhkvRgF8u+0wSjFo=
X-Google-Smtp-Source: ABdhPJzQgpI2hG3be8BoUkulLrMdaE7te+AnDNiAOVWbFaB0wPvEmwxQA+mFS38TyMQZvDqZGmXf7CTlolhW6OPQoVQ=
X-Received: by 2002:a05:620a:470b:: with SMTP id bs11mr2825914qkb.210.1642400130779;
 Sun, 16 Jan 2022 22:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-4-gengcixi@gmail.com>
 <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com> <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com>
In-Reply-To: <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 17 Jan 2022 14:16:10 +0800
Message-ID: <CADBw62rSdWN-L8HbnyMrUNp=x0pDdKR6MyKO4yfu00MnrN4L-g@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, jic23@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:54 AM Cixi Geng <gengcixi@gmail.com> wrote:
>
> Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
> > >
> > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > >
> > > Introduce one variant device data structure to be compatible
> > > with SC2731 PMIC since it has different scale and ratio calculation
> > > and so on.
> > >
> > > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > ---
> > >  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 79 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_ad=
c.c
> > > index aee076c8e2b1..d2712e54ee79 100644
> > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > @@ -12,9 +12,9 @@
> > >  #include <linux/slab.h>
> > >
> > >  /* PMIC global registers definition */
> > > -#define SC27XX_MODULE_EN               0xc08
> > > +#define SC2731_MODULE_EN               0xc08
> > >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > > -#define SC27XX_ARM_CLK_EN              0xc10
> > > +#define SC2731_ARM_CLK_EN              0xc10
> > >  #define SC27XX_CLK_ADC_EN              BIT(5)
> > >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> > >
> > > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> > >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> > >         u32 base;
> > >         int irq;
> > > +       const struct sc27xx_adc_variant_data *var_data;
> > > +};
> > > +
> > > +/*
> > > + * Since different PMICs of SC27xx series can have different
> > > + * address and ratio, we should save ratio config and base
> > > + * in the device data structure.
> > > + */
> > > +struct sc27xx_adc_variant_data {
> > > +       u32 module_en;
> > > +       u32 clk_en;
> > > +       u32 scale_shift;
> > > +       u32 scale_mask;
> > > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > > +       int (*get_ratio)(int channel, int scale);
> > >  };
> > >
> > >  struct sc27xx_adc_linear_graph {
> > > @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph small_scal=
e_graph =3D {
> > >         100, 341,
> > >  };
> > >
> > > +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_c=
alib =3D {
> > > +       4200, 850,
> > > +       3600, 728,
> > > +};
> > > +
> > > +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph=
_calib =3D {
> > > +       1000, 838,
> > > +       100, 84,
> > > +};
> >
> > The original big_scale_graph_calib and small_scale_graph_calib are for
> > SC2731 PMIC, why add new structure definition for SC2731?
> >
> > > +
> > >  static const struct sc27xx_adc_linear_graph big_scale_graph_calib =
=3D {
> > >         4200, 856,
> > >         3600, 733,
> > > @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(struct =
sc27xx_adc_data *data,
> > >         size_t len;
> > >
> > >         if (big_scale) {
> > > -               calib_graph =3D &big_scale_graph_calib;
> > > +               calib_graph =3D data->var_data->bscale_cal;
> > >                 graph =3D &big_scale_graph;
> > >                 cell_name =3D "big_scale_calib";
> > >         } else {
> > > -               calib_graph =3D &small_scale_graph_calib;
> > > +               calib_graph =3D data->var_data->sscale_cal;
> > >                 graph =3D &small_scale_graph;
> > >                 cell_name =3D "small_scale_calib";
> > >         }
> > > @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(struct sc=
27xx_adc_data *data,
> > >         return 0;
> > >  }
> > >
> > > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > > +static int sc2731_adc_get_ratio(int channel, int scale)
> > >  {
> > >         switch (channel) {
> > >         case 1:
> > > @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channel, int=
 scale)
> > >         return SC27XX_VOLT_RATIO(1, 1);
> > >  }
> > >
> > > +/*
> > > + * According to the datasheet set specific value on some channel.
> > > + */
> > > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > > +               if (i =3D=3D 5)
> > > +                       data->channel_scale[i] =3D 1;
> > > +               else
> > > +                       data->channel_scale[i] =3D 0;
> > > +       }
> > > +}
> >
> > This is unnecessary I think, please see sc27xx_adc_write_raw() that
> > can set the channel scale.
> Did you mean that all the PMIC's scale_init function should put into
> the sc27xx_adc_write_raw?

No.

> but the scale_init is all different by each PMIC, if implemented in
> the write_raw, will add a lot of
> if or switch_case branch

What I mean is we should follow the original method to set the channel
scale by iio_info. Please also refer to other drivers how ot handle
the channel scale.

--=20
Baolin Wang
