Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3B4C4228
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiBYKUZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Feb 2022 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBYKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:20:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E01C232D;
        Fri, 25 Feb 2022 02:19:49 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K4ly61VnRz67nLn;
        Fri, 25 Feb 2022 18:14:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:19:46 +0100
Received: from localhost (10.47.69.56) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Feb
 2022 10:19:45 +0000
Date:   Fri, 25 Feb 2022 10:19:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cixi Geng <gengcixi@gmail.com>
CC:     Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "=?UTF-8?Q?=E6=9C=B1=E7=8E=89=E6=98=8E?= (Yuming Zhu/11457) " 
        <yuming.zhu1@unisoc.com>, <linux-iio@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and
 optimization
Message-ID: <20220225101942.00002f43@Huawei.com>
In-Reply-To: <CAF12kFtV_dpHukd2v0UwSoAFsDbNXZLPSnSSK9dqq7hnoJh9UQ@mail.gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
        <20220106125947.139523-4-gengcixi@gmail.com>
        <CADBw62pBCdrbRspTV9Yck4DP8DE=ECGmEtD74NOtm1YRT3DM8w@mail.gmail.com>
        <CAF12kFu6O-gfiqp4j24zxC_GqCwJ2Q5KGYYaCtnagmUFB_bsVg@mail.gmail.com>
        <CADBw62rSdWN-L8HbnyMrUNp=x0pDdKR6MyKO4yfu00MnrN4L-g@mail.gmail.com>
        <CAF12kFvUfykKfeRAJACFRk31pmEBQEPw402x0JN4i1uv0EK1zg@mail.gmail.com>
        <CADBw62pmtbzr78c9J20cFbNRuTrntGg_E8TH_g=LciCVGYrYqQ@mail.gmail.com>
        <CAF12kFtV_dpHukd2v0UwSoAFsDbNXZLPSnSSK9dqq7hnoJh9UQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.69.56]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 20:46:08 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> Baolin Wang <baolin.wang7@gmail.com> 于2022年2月10日周四 16:07写道：
> >
> > On Mon, Jan 24, 2022 at 4:07 PM Cixi Geng <gengcixi@gmail.com> wrote:  
> > >
> > > Baolin Wang <baolin.wang7@gmail.com> 于2022年1月17日周一 14:15写道：  
> > > >
> > > > On Thu, Jan 13, 2022 at 9:54 AM Cixi Geng <gengcixi@gmail.com> wrote:  
> > > > >
> > > > > Baolin Wang <baolin.wang7@gmail.com> 于2022年1月7日周五 15:03写道：  
> > > > > >
> > > > > > On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:  
> > > > > > >
> > > > > > > From: Cixi Geng <cixi.geng1@unisoc.com>
> > > > > > >
> > > > > > > Introduce one variant device data structure to be compatible
> > > > > > > with SC2731 PMIC since it has different scale and ratio calculation
> > > > > > > and so on.
> > > > > > >
> > > > > > > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > > > > > > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > > > > > > ---
> > > > > > >  drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++++------
> > > > > > >  1 file changed, 79 insertions(+), 15 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> > > > > > > index aee076c8e2b1..d2712e54ee79 100644
> > > > > > > --- a/drivers/iio/adc/sc27xx_adc.c
> > > > > > > +++ b/drivers/iio/adc/sc27xx_adc.c
> > > > > > > @@ -12,9 +12,9 @@
> > > > > > >  #include <linux/slab.h>
> > > > > > >
> > > > > > >  /* PMIC global registers definition */
> > > > > > > -#define SC27XX_MODULE_EN               0xc08
> > > > > > > +#define SC2731_MODULE_EN               0xc08
> > > > > > >  #define SC27XX_MODULE_ADC_EN           BIT(5)
> > > > > > > -#define SC27XX_ARM_CLK_EN              0xc10
> > > > > > > +#define SC2731_ARM_CLK_EN              0xc10
> > > > > > >  #define SC27XX_CLK_ADC_EN              BIT(5)
> > > > > > >  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> > > > > > >
> > > > > > > @@ -78,6 +78,23 @@ struct sc27xx_adc_data {
> > > > > > >         int channel_scale[SC27XX_ADC_CHANNEL_MAX];
> > > > > > >         u32 base;
> > > > > > >         int irq;
> > > > > > > +       const struct sc27xx_adc_variant_data *var_data;
> > > > > > > +};
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Since different PMICs of SC27xx series can have different
> > > > > > > + * address and ratio, we should save ratio config and base
> > > > > > > + * in the device data structure.
> > > > > > > + */
> > > > > > > +struct sc27xx_adc_variant_data {
> > > > > > > +       u32 module_en;
> > > > > > > +       u32 clk_en;
> > > > > > > +       u32 scale_shift;
> > > > > > > +       u32 scale_mask;
> > > > > > > +       const struct sc27xx_adc_linear_graph *bscale_cal;
> > > > > > > +       const struct sc27xx_adc_linear_graph *sscale_cal;
> > > > > > > +       void (*init_scale)(struct sc27xx_adc_data *data);
> > > > > > > +       int (*get_ratio)(int channel, int scale);
> > > > > > >  };
> > > > > > >
> > > > > > >  struct sc27xx_adc_linear_graph {
> > > > > > > @@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
> > > > > > >         100, 341,
> > > > > > >  };
> > > > > > >
> > > > > > > +static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
> > > > > > > +       4200, 850,
> > > > > > > +       3600, 728,
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
> > > > > > > +       1000, 838,
> > > > > > > +       100, 84,
> > > > > > > +};  
> > > > > >
> > > > > > The original big_scale_graph_calib and small_scale_graph_calib are for
> > > > > > SC2731 PMIC, why add new structure definition for SC2731?
> > > > > >  
> > > > > > > +
> > > > > > >  static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
> > > > > > >         4200, 856,
> > > > > > >         3600, 733,
> > > > > > > @@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
> > > > > > >         size_t len;
> > > > > > >
> > > > > > >         if (big_scale) {
> > > > > > > -               calib_graph = &big_scale_graph_calib;
> > > > > > > +               calib_graph = data->var_data->bscale_cal;
> > > > > > >                 graph = &big_scale_graph;
> > > > > > >                 cell_name = "big_scale_calib";
> > > > > > >         } else {
> > > > > > > -               calib_graph = &small_scale_graph_calib;
> > > > > > > +               calib_graph = data->var_data->sscale_cal;
> > > > > > >                 graph = &small_scale_graph;
> > > > > > >                 cell_name = "small_scale_calib";
> > > > > > >         }
> > > > > > > @@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > -static int sc27xx_adc_get_ratio(int channel, int scale)
> > > > > > > +static int sc2731_adc_get_ratio(int channel, int scale)
> > > > > > >  {
> > > > > > >         switch (channel) {
> > > > > > >         case 1:
> > > > > > > @@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channel, int scale)
> > > > > > >         return SC27XX_VOLT_RATIO(1, 1);
> > > > > > >  }
> > > > > > >
> > > > > > > +/*
> > > > > > > + * According to the datasheet set specific value on some channel.
> > > > > > > + */
> > > > > > > +static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
> > > > > > > +{
> > > > > > > +       int i;
> > > > > > > +
> > > > > > > +       for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> > > > > > > +               if (i == 5)
> > > > > > > +                       data->channel_scale[i] = 1;
> > > > > > > +               else
> > > > > > > +                       data->channel_scale[i] = 0;
> > > > > > > +       }
> > > > > > > +}  
> > > > > >
> > > > > > This is unnecessary I think, please see sc27xx_adc_write_raw() that
> > > > > > can set the channel scale.  
> > > > > Did you mean that all the PMIC's scale_init function should put into
> > > > > the sc27xx_adc_write_raw?  
> > > >
> > > > No.
> > > >  
> > > > > but the scale_init is all different by each PMIC, if implemented in
> > > > > the write_raw, will add a lot of
> > > > > if or switch_case branch  
> > > >
> > > > What I mean is we should follow the original method to set the channel
> > > > scale by iio_info. Please also refer to other drivers how ot handle
> > > > the channel scale.  
> > > Hi Baolin,  I understand the adc_write_raw() function is the method to set
> > > channal scale for the userspace, we can change the channel scale by write
> > > a value on a user code. did i understand right?
> > > out  scale_init is to set scale value when the driver probe stage, and I also
> > > did not found other adc driver use the adc_write_raw() during the driver
> > >  initialization phase.  
> >
> > Hi Jonathan,
> >
> > How do you think about the method in this patch to set the channel
> > scale? Thanks.
> >  
> Hi Jonathan,
> Could you have a loot at this patch ,and give some advice about the
> method to set the channel scale? Thanks very much.

Hi, thanks for poking me on this - I'd missed the question buried deep in the thread!

Anyhow, I don't quite follow the discussion but think it could be focused
on one of 2 questions...

1) Does setting an initial default make sense?  
   Yes, this is an acceptable thing to do if there is a particular set of defaults
   and there is no risk of regressions (i.e. the device wasn't previously supported
   with different defaults).
2) Should you use the write_raw callback to actually do the setting?
   Probably not as it has a set of parameters that don't make as much sense from within
   the driver.  It 'might' make sense to have a common _set() function for this
   feature which is called both in this initialization case and from the write_raw()
   function however as that could do bounds checking etc in one common place.
   However, it is very simple here, so perhaps not necessary.

Jonathan

> > --
> > Baolin Wang  

