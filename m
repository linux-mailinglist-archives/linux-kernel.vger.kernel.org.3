Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E552726E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiENPHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiENPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:07:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD6632C;
        Sat, 14 May 2022 08:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05214B80908;
        Sat, 14 May 2022 15:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8A7C36AE2;
        Sat, 14 May 2022 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652540824;
        bh=EcqRIDx0ujmGekBnNMQW7sqA4Kb1kqn6wGKblyiQebw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTtbCq04Jj+ptLzxk8Myg/jYgkkLDnbdKAKhLkLXZWCPhsIvFG2CMZ8SGTzlx35Yd
         HKCPvn4Gbnzdt4yg7kjSvGiPoXlSDMmU/Iblb/2Lj3t1YqzQALCOlAA6JVWC/d6OXH
         A7GRKSC6AwmOSgQw6HIvuXazc0NAeOPIv75U0gC/sKZtvl/fyxQzNBqcFYGssdlf0Z
         wXL8J3vi3mm6cqDz2qFuEE2Yq6xWn8e6qO2STYYKDV9MJPBE3VzddcDZkGrK1/o8Gf
         ISg5+rxBaaXAy6e6vosMrtn4CRm6biA4HG1jx+9mJs3e0LJ7wcjC20D8w0ZT0ZI0lS
         uQZLTp+1Z56+Q==
Date:   Sat, 14 May 2022 16:15:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2 1/6] iio: accel: bmi088: Modified the scale calculate
Message-ID: <20220514161539.3805bf87@jic23-huawei>
In-Reply-To: <CA+U=DsqUztHxrkYsWTNz8Xm1OxRK2Wkb7L7Csque4r1tEDz_ig@mail.gmail.com>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-2-Qing-wu.Li@leica-geosystems.com.cn>
        <CA+U=DsqUztHxrkYsWTNz8Xm1OxRK2Wkb7L7Csque4r1tEDz_ig@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 10:14:47 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Tue, May 10, 2022 at 5:17 PM LI Qingwu
> <Qing-wu.Li@leica-geosystems.com.cn> wrote:
> >
> > The units after application of scale are 100*m/s^2,
> > The scale calculation is only for the device
> > with the range of 3, 6, 12, and 24g,
> > but some other chips have a range of 2, 4, 6, and 8g.
> >
> > Modified the formula to a scale list.
> > The scales in the list are calculated by 1/sensitivity*9.8.
> > The new units after the application of scale are m/s^2.
> >  
> 
> Strictly on the code:
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> On the change of IIO_VAL_FRACTIONAL_LOG2 -> IIO_VAL_INT_PLUS_MICRO  is
> still up for discussion.
It's fine as far as I'm concerned.

Jonathan

> 
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > ---
> >  drivers/iio/accel/bmi088-accel-core.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> > index a06dae5c971d..9300313b63cb 100644
> > --- a/drivers/iio/accel/bmi088-accel-core.c
> > +++ b/drivers/iio/accel/bmi088-accel-core.c
> > @@ -119,6 +119,7 @@ struct bmi088_accel_chip_info {
> >         u8 chip_id;
> >         const struct iio_chan_spec *channels;
> >         int num_channels;
> > +       const int scale_table[4][2];
> >  };
> >
> >  struct bmi088_accel_data {
> > @@ -280,6 +281,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> >         struct bmi088_accel_data *data = iio_priv(indio_dev);
> >         struct device *dev = regmap_get_device(data->regmap);
> >         int ret;
> > +       int reg;
> >
> >         switch (mask) {
> >         case IIO_CHAN_INFO_RAW:
> > @@ -330,13 +332,12 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> >                                 return ret;
> >
> >                         ret = regmap_read(data->regmap,
> > -                                         BMI088_ACCEL_REG_ACC_RANGE, val);
> > +                                         BMI088_ACCEL_REG_ACC_RANGE, &reg);
> >                         if (ret)
> >                                 goto out_read_raw_pm_put;
> > -
> > -                       *val2 = 15 - (*val & 0x3);
> > -                       *val = 3 * 980;
> > -                       ret = IIO_VAL_FRACTIONAL_LOG2;
> > +                       *val = data->chip_info->scale_table[reg&0x03][0];
> > +                       *val2 = data->chip_info->scale_table[reg&0x03][1];
> > +                       ret = IIO_VAL_INT_PLUS_MICRO;
> >
> >                         goto out_read_raw_pm_put;
> >                 default:
> > @@ -432,6 +433,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
> >                 .chip_id = 0x1E,
> >                 .channels = bmi088_accel_channels,
> >                 .num_channels = ARRAY_SIZE(bmi088_accel_channels),
> > +               .scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
> >         },
> >  };
> >
> > --
> > 2.25.1
> >  

