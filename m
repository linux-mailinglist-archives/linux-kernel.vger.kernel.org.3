Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C634648D047
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiAMBy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiAMByY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:54:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F676C06173F;
        Wed, 12 Jan 2022 17:54:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so1802712wmb.1;
        Wed, 12 Jan 2022 17:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nk7OH+nOiRxeK+/bJunmQEJyfwz+0sa8qIG16MO4xZ8=;
        b=QMwC23ZSc0Xwq9R4i37vWfNRm4kkKetWYWqAdriZlNa9SKArjmXeyoFnzToU7pfSg+
         d5g4Z7l7ajuA9Lbck2zE1Ll9kncGhhaQrorYK5Q3qACK2d2jtJpfbTaWGoDuQQ4qhnSg
         PPLch2b96md9ToEDfwXpM11Sk6K1MS15825lgmu52hT2Ivr70TQ+k1ChXpTcTezslypx
         5MfMe+hzowz3/EgsbvV2ZM5MClOztfKjw1D7D2wouW8i6XWQieQUnd4xF+2pwxL0sIWL
         OzFVh7OYWkk8TIHg3aFDjqw4Kwdjmfu8jyaPY81ROCmx5sqx1IMugwirwax2DQmr+loh
         Ybvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nk7OH+nOiRxeK+/bJunmQEJyfwz+0sa8qIG16MO4xZ8=;
        b=5zdXTSt0wHBW8m9WSXa+JCyJT/TyytKbuL5QoajHd7+PfPb0FIMzAbI67VS7MvSpuK
         s0SrQF5TsOorB5tSh6Mu23iUL1YFF6oOifEf8WiTHdgwBHCCr2JHjyLN3c0rM+rL6Qmw
         xyPhPNpA3SDjtiPVauBO0t6zS90ciWKvKT3MBt7Lyq9TP+aAafQq32psTUt6kc5+mIYo
         W/sZVwDuW5E2F7fsOfHuLj3Zwmu9htJLRsdfQm8J3VUH0pc9P24savBaZhe6LyS2M2yN
         8QSNtid207Z7VMstZhHECuOJvDXwfFfg9c6qKLOyzIquJl+VGbV9NOlvlb9B01y4l4dW
         Sygg==
X-Gm-Message-State: AOAM533SLXbhLRmpAJBwE6SFwaAvJ6hXz0ce75OzAanSKfDAbGsexwYL
        1/2e6BXsuwfdMzEej5pbZxpqKBlJ3DDpgw60W3Q=
X-Google-Smtp-Source: ABdhPJz0wYdsqmkdfAue8Q70i6h82CifssqNeOwi2IqNDIICb7OzR9D32moJHfqvOUaVA8tPtXz4ljQZlqD0pO3XxAs=
X-Received: by 2002:a1c:770b:: with SMTP id t11mr1776414wmi.61.1642038862648;
 Wed, 12 Jan 2022 17:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-4-gengcixi@gmail.com>
 <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
In-Reply-To: <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Thu, 13 Jan 2022 09:53:25 +0800
Message-ID: <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and optimization
To:     Baolin Wang <baolin.wang7@gmail.com>
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

Baolin Wang <baolin.wang7@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Introduce one variant device data structure to be compatible
> > with SC2731 PMIC since it has different scale and ratio calculation
> > and so on.
> >
> > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++++------
> >  1 file changed, 79 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.=
c
> > index aee076c8e2b1..d2712e54ee79 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -12,9 +12,9 @@
> >  #include <linux/slab.h>
> >
> >  /* PMIC global registers definition */
> > -#define SC27XX_MODULE_EN               0xc08
> > +#define SC2731_MODULE_EN               0xc08
> >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > -#define SC27XX_ARM_CLK_EN              0xc10
> > +#define SC2731_ARM_CLK_EN              0xc10
> >  #define SC27XX_CLK_ADC_EN              BIT(5)
> >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> >
> > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> >         u32 base;
> >         int irq;
> > +       const struct sc27xx_adc_variant_data *var_data;
> > +};
> > +
> > +/*
> > + * Since different PMICs of SC27xx series can have different
> > + * address and ratio, we should save ratio config and base
> > + * in the device data structure.
> > + */
> > +struct sc27xx_adc_variant_data {
> > +       u32 module_en;
> > +       u32 clk_en;
> > +       u32 scale_shift;
> > +       u32 scale_mask;
> > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > +       int (*get_ratio)(int channel, int scale);
> >  };
> >
> >  struct sc27xx_adc_linear_graph {
> > @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph small_scale_=
graph =3D {
> >         100, 341,
> >  };
> >
> > +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_cal=
ib =3D {
> > +       4200, 850,
> > +       3600, 728,
> > +};
> > +
> > +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_c=
alib =3D {
> > +       1000, 838,
> > +       100, 84,
> > +};
>
> The original big_scale_graph_calib and small_scale_graph_calib are for
> SC2731 PMIC, why add new structure definition for SC2731?
>
> > +
> >  static const struct sc27xx_adc_linear_graph big_scale_graph_calib =3D =
{
> >         4200, 856,
> >         3600, 733,
> > @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(struct sc=
27xx_adc_data *data,
> >         size_t len;
> >
> >         if (big_scale) {
> > -               calib_graph =3D &big_scale_graph_calib;
> > +               calib_graph =3D data->var_data->bscale_cal;
> >                 graph =3D &big_scale_graph;
> >                 cell_name =3D "big_scale_calib";
> >         } else {
> > -               calib_graph =3D &small_scale_graph_calib;
> > +               calib_graph =3D data->var_data->sscale_cal;
> >                 graph =3D &small_scale_graph;
> >                 cell_name =3D "small_scale_calib";
> >         }
> > @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(struct sc27=
xx_adc_data *data,
> >         return 0;
> >  }
> >
> > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > +static int sc2731_adc_get_ratio(int channel, int scale)
> >  {
> >         switch (channel) {
> >         case 1:
> > @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channel, int s=
cale)
> >         return SC27XX_VOLT_RATIO(1, 1);
> >  }
> >
> > +/*
> > + * According to the datasheet set specific value on some channel.
> > + */
> > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > +               if (i =3D=3D 5)
> > +                       data->channel_scale[i] =3D 1;
> > +               else
> > +                       data->channel_scale[i] =3D 0;
> > +       }
> > +}
>
> This is unnecessary I think, please see sc27xx_adc_write_raw() that
> can set the channel scale.
Did you mean that all the PMIC's scale_init function should put into
the sc27xx_adc_write_raw?
but the scale_init is all different by each PMIC, if implemented in
the write_raw, will add a lot of
if or switch_case branch
>
> > +
> >  static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> >                            int scale, int *val)
> >  {
> > @@ -208,10 +250,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data=
 *data, int channel,
> >                 goto disable_adc;
> >
> >         /* Configure the channel id and scale */
> > -       tmp =3D (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MA=
SK;
> > +       tmp =3D (scale << data->var_data->scale_shift) & data->var_data=
->scale_mask;
> >         tmp |=3D channel & SC27XX_ADC_CHN_ID_MASK;
> >         ret =3D regmap_update_bits(data->regmap, data->base + SC27XX_AD=
C_CH_CFG,
> > -                                SC27XX_ADC_CHN_ID_MASK | SC27XX_ADC_SC=
ALE_MASK,
> > +                                SC27XX_ADC_CHN_ID_MASK |
> > +                                data->var_data->scale_mask,
> >                                  tmp);
> >         if (ret)
> >                 goto disable_adc;
> > @@ -262,8 +305,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc=
_data *data,
> >                                   int channel, int scale,
> >                                   u32 *div_numerator, u32 *div_denomina=
tor)
> >  {
> > -       u32 ratio =3D sc27xx_adc_get_ratio(channel, scale);
> > +       u32 ratio;
> >
> > +       ratio =3D data->var_data->get_ratio(channel, scale);
> >         *div_numerator =3D ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
> >         *div_denominator =3D ratio & SC27XX_RATIO_DENOMINATOR_MASK;
> >  }
> > @@ -432,13 +476,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_da=
ta *data)
> >  {
> >         int ret;
> >
> > -       ret =3D regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> > +       ret =3D regmap_update_bits(data->regmap, data->var_data->module=
_en,
> >                                  SC27XX_MODULE_ADC_EN, SC27XX_MODULE_AD=
C_EN);
> >         if (ret)
> >                 return ret;
> >
> >         /* Enable ADC work clock and controller clock */
> > -       ret =3D regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> > +       ret =3D regmap_update_bits(data->regmap, data->var_data->clk_en=
,
> >                                  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK=
_EN,
> >                                  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK=
_EN);
> >         if (ret)
> > @@ -456,10 +500,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_da=
ta *data)
> >         return 0;
> >
> >  disable_clk:
> > -       regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->clk_en,
> >                            SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0=
);
> >  disable_adc:
> > -       regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->module_en,
> >                            SC27XX_MODULE_ADC_EN, 0);
> >
> >         return ret;
> > @@ -470,21 +514,39 @@ static void sc27xx_adc_disable(void *_data)
> >         struct sc27xx_adc_data *data =3D _data;
> >
> >         /* Disable ADC work clock and controller clock */
> > -       regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->clk_en,
> >                            SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0=
);
> >
> > -       regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
> > +       regmap_update_bits(data->regmap, data->var_data->module_en,
> >                            SC27XX_MODULE_ADC_EN, 0);
> >  }
> >
> > +static const struct sc27xx_adc_variant_data sc2731_data =3D {
> > +       .module_en =3D SC2731_MODULE_EN,
> > +       .clk_en =3D SC2731_ARM_CLK_EN,
> > +       .scale_shift =3D SC27XX_ADC_SCALE_SHIFT,
> > +       .scale_mask =3D SC27XX_ADC_SCALE_MASK,
> > +       .bscale_cal =3D &sc2731_big_scale_graph_calib,
> > +       .sscale_cal =3D &sc2731_small_scale_graph_calib,
> > +       .init_scale =3D sc2731_adc_scale_init,
> > +       .get_ratio =3D sc2731_adc_get_ratio,
> > +};
> > +
> >  static int sc27xx_adc_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev =3D &pdev->dev;
> >         struct device_node *np =3D dev->of_node;
> >         struct sc27xx_adc_data *sc27xx_data;
> > +       const struct sc27xx_adc_variant_data *pdata;
> >         struct iio_dev *indio_dev;
> >         int ret;
> >
> > +       pdata =3D of_device_get_match_data(dev);
> > +       if (!pdata) {
> > +               dev_err(dev, "No matching driver data found\n");
> > +               return -EINVAL;
> > +       }
> > +
> >         indio_dev =3D devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
> >         if (!indio_dev)
> >                 return -ENOMEM;
> > @@ -520,6 +582,8 @@ static int sc27xx_adc_probe(struct platform_device =
*pdev)
> >         }
> >
> >         sc27xx_data->dev =3D dev;
> > +       sc27xx_data->var_data =3D pdata;
> > +       sc27xx_data->var_data->init_scale(sc27xx_data);
> >
> >         ret =3D sc27xx_adc_enable(sc27xx_data);
> >         if (ret) {
> > @@ -546,7 +610,7 @@ static int sc27xx_adc_probe(struct platform_device =
*pdev)
> >  }
> >
> >  static const struct of_device_id sc27xx_adc_of_match[] =3D {
> > -       { .compatible =3D "sprd,sc2731-adc", },
> > +       { .compatible =3D "sprd,sc2731-adc", .data =3D &sc2731_data},
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
> > --
> > 2.25.1
> >
>
>
> --
> Baolin Wang
