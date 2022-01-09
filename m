Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723C0488A67
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiAIQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiAIQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 11:08:08 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4AC06173F;
        Sun,  9 Jan 2022 08:08:07 -0800 (PST)
Received: from [81.101.6.87] (port=35370 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6ajd-000448-9h; Sun, 09 Jan 2022 16:08:01 +0000
Date:   Sun, 9 Jan 2022 16:13:49 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Cixi Geng <gengcixi@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] iio: adc: sc27xx: add support for PMIC sc2720 and
 sc2721
Message-ID: <20220109161341.19484fc0@jic23-huawei>
In-Reply-To: <CADBw62oowgYKa74BuF3CnjdwiuK8tPpqLB7u9+E8zKD27ADYdA@mail.gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
        <20220106125947.139523-5-gengcixi@gmail.com>
        <CADBw62oowgYKa74BuF3CnjdwiuK8tPpqLB7u9+E8zKD27ADYdA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 15:16:15 +0800
Baolin Wang <baolin.wang7@gmail.com> wrote:

> On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > sc2720 and sc2721 is the product of sc27xx series.
> >
> > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 198 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 198 insertions(+)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> > index d2712e54ee79..7b5c66660ac9 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -9,11 +9,13 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >
> >  /* PMIC global registers definition */
> >  #define SC2731_MODULE_EN               0xc08
> >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > +#define SC2721_ARM_CLK_EN              0xc0c
> >  #define SC2731_ARM_CLK_EN              0xc10
> >  #define SC27XX_CLK_ADC_EN              BIT(5)
> >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> > @@ -37,7 +39,9 @@
> >  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
> >  #define SC27XX_ADC_CHN_ID_MASK         GENMASK(4, 0)
> >  #define SC27XX_ADC_SCALE_MASK          GENMASK(10, 9)
> > +#define SC2721_ADC_SCALE_MASK          BIT(5)
> >  #define SC27XX_ADC_SCALE_SHIFT         9
> > +#define SC2721_ADC_SCALE_SHIFT         5
> >
> >  /* Bits definitions for SC27XX_ADC_INT_EN registers */
> >  #define SC27XX_ADC_IRQ_EN              BIT(0)
> > @@ -67,8 +71,21 @@
> >  #define SC27XX_RATIO_NUMERATOR_OFFSET  16
> >  #define SC27XX_RATIO_DENOMINATOR_MASK  GENMASK(15, 0)
> >
> > +/* ADC specific channel reference voltage 3.5V */
> > +#define SC27XX_ADC_REFVOL_VDD35                3500000
> > +
> > +/* ADC default channel reference voltage is 2.8V */
> > +#define SC27XX_ADC_REFVOL_VDD28                2800000
> > +
> > +enum sc27xx_pmic_type {
> > +       SC27XX_ADC,
> > +       SC2721_ADC,
> > +};
> > +
> >  struct sc27xx_adc_data {
> > +       struct iio_dev *indio_dev;  
> 
> Why add an unused member?
It's very very rarely a good architecture structure to have
the data stored in iio_priv() have a pointer back to the indio_dev.
Normally it implies somewhere the wrong level of structure is being
passed to a function.

So I'm glad it's not used :)

> 
> >         struct device *dev;
> > +       struct regulator *volref;
> >         struct regmap *regmap;
> >         /*
> >          * One hardware spinlock to synchronize between the multiple
> > @@ -87,6 +104,7 @@ struct sc27xx_adc_data {
> >   * in the device data structure.
> >   */

...

> 
> > +
> >  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> >  {
> >         int i;
> > @@ -239,6 +373,24 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> >                 return ret;
> >         }
> >
> > +       /*
> > +        * According to the sc2721 chip data sheet, the reference voltage of
> > +        * specific channel 30 and channel 31 in ADC module needs to be set from
> > +        * the default 2.8v to 3.5v.

That's horrible... :) Ah well...

> > +        */
> > +       if (data->var_data->pmic_type == SC2721_ADC) {
> > +               if ((channel == 30) || (channel == 31)) {  
> 
> Combine the two branches please.
> 
> > +                       ret = regulator_set_voltage(data->volref,
> > +                                               SC27XX_ADC_REFVOL_VDD35,
> > +                                               SC27XX_ADC_REFVOL_VDD35);
> > +                       if (ret) {
> > +                               dev_err(data->dev, "failed to set the volref 3.5V\n");
> > +                               hwspin_unlock_raw(data->hwlock);
> > +                               return ret;
> > +                       }
> > +               }
> > +       }
> > +
> >         ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> >                                  SC27XX_ADC_EN, SC27XX_ADC_EN);
> >         if (ret)
> > @@ -293,6 +445,16 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> >         regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
> >                            SC27XX_ADC_EN, 0);
> >  unlock_adc:
> > +       if (data->var_data->pmic_type == SC2721_ADC) {
> > +               if ((channel == 30) || (channel == 31)) {
> > +                       ret = regulator_set_voltage(data->volref,
> > +                                                   SC27XX_ADC_REFVOL_VDD28,
> > +                                                   SC27XX_ADC_REFVOL_VDD28);
> > +                       if (ret)
> > +                               dev_err(data->dev, "failed to set the volref 2.8V\n");
> > +               }
> > +       }
> > +
> >         hwspin_unlock_raw(data->hwlock);
> >
> >         if (!ret)
> > @@ -522,6 +684,7 @@ static void sc27xx_adc_disable(void *_data)
> >  }

...

> 

