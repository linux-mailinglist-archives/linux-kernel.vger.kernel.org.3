Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45C451E852
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385960AbiEGPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiEGPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08121B7BA;
        Sat,  7 May 2022 08:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D13612AB;
        Sat,  7 May 2022 15:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455DBC385A6;
        Sat,  7 May 2022 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651938701;
        bh=SgylqqFhnOT+/hcD4sAqkybiY5vyD7iv/twFPe7OHaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=guEAchjyjebfnzhVIoCAGaHdMf04FE+uglyskBbQZa3DtdBLF5zyF2RZvKxLXPYOQ
         PKSxqOyRnQ/KZXTFxzw9r1Kerf12SAy+Fj6KGYYcCfFNx8RJ2P61a2UiFyPlb/GSwH
         WxA4ns9CmvpcWEdQnTjTWPrmatbT7gfm5O1VMB2+wNTFm2kdY/e6UKbqjYd57gHlmD
         WUeSg2DCIAVpGSjlcSVtBGz5VO0R2X3D9hqekPGEapphmbzBLBuafpAGJL5hpumOol
         XmROb9yGM14D0xLFSfJ2+nrIU/1DN6jbPv0IKAgy1ssr8fUSEMAjkre7SVOERxyG1h
         P3F5XdLp/uvjg==
Date:   Sat, 7 May 2022 17:00:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220507170009.1cecf481@jic23-huawei>
In-Reply-To: <CAM+2EuLLRNarHkzr9YXTcSnhdSYcRNZj_tYZK7HN+Jzj0GC5ag@mail.gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
        <20220420211105.14654-5-jagathjog1996@gmail.com>
        <CAHp75Vf5pS_TGm5ptN7TyNmhZe_Oz8pVmETT27VeC=BZk9+ezg@mail.gmail.com>
        <20220501172037.5f3d446f@jic23-huawei>
        <CAM+2EuLLRNarHkzr9YXTcSnhdSYcRNZj_tYZK7HN+Jzj0GC5ag@mail.gmail.com>
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

On Mon, 2 May 2022 01:55:49 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sun, May 1, 2022 at 9:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed, 27 Apr 2022 14:34:57 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >  
> > > On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:  
> > > >
> > > > Added trigger buffer support to read continuous acceleration
> > > > data from device with data ready interrupt which is mapped
> > > > to INT1 pin.  
> > >
> > > LGTM,
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>  
> > Agreed.  A couple of 'comments' inline but no actual need to change anything.
> > One is contingent on a fix I've not sent out yet for the rest of IIO.
> > The other is potentially a minor improvement for the future.
> >
> > Thanks,
> >
> > Jonathan
> >  
> > >  
> > > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/Kconfig       |   2 +
> > > >  drivers/iio/accel/bma400.h      |  10 +-
> > > >  drivers/iio/accel/bma400_core.c | 162 +++++++++++++++++++++++++++++++-
> > > >  drivers/iio/accel/bma400_i2c.c  |   2 +-
> > > >  drivers/iio/accel/bma400_spi.c  |   2 +-
> > > >  5 files changed, 170 insertions(+), 8 deletions(-)  
> >  
> > > >
> > > >  #include "bma400.h"
> > > >
> > > > @@ -61,6 +66,14 @@ struct bma400_data {
> > > >         struct bma400_sample_freq sample_freq;
> > > >         int oversampling_ratio;
> > > >         int scale;
> > > > +       struct iio_trigger *trig;
> > > > +       /* Correct time stamp alignment */
> > > > +       struct {
> > > > +               __le16 buff[3];
> > > > +               u8 temperature;
> > > > +               s64 ts __aligned(8);
> > > > +       } buffer ____cacheline_aligned;  
> >
> > If you are rolling again, could you change this to
> > __aligned(IIO_ALIGN);  See
> > https://lore.kernel.org/linux-iio/20220419121241.00002e42@Huawei.com/
> > for why.
> > Note that I'll be sending a fix patch out for IIO_ALIGN to define
> > it as ARCH_KMALLOC_ALIGN in next few days.
> >
> > If you'd pref not to get caught up in that, send it as it stands
> > and I'll fix up once that fix is in place.  What's one more driver
> > on top of the 80+ I have to do anyway :)
> >
> >  
> 
> Sure, I will change that to __aligned(IIO_ALIGN); in the next series.
> 
> >  
> > > > +       __le16 status;
> > > >  };
> > > >  
> >  
> > > > +
> > > > +static const unsigned long bma400_avail_scan_masks[] = {
> > > > +       GENMASK(3, 0),
> > > > +       0
> > > > +};
> > > > +
> > > >  static const struct iio_info bma400_info = {
> > > >         .read_raw          = bma400_read_raw,
> > > >         .read_avail        = bma400_read_avail,
> > > > @@ -814,7 +869,72 @@ static const struct iio_info bma400_info = {
> > > >         .write_raw_get_fmt = bma400_write_raw_get_fmt,
> > > >  };
> > > >
> > > > -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> > > > +static const struct iio_trigger_ops bma400_trigger_ops = {
> > > > +       .set_trigger_state = &bma400_data_rdy_trigger_set_state,
> > > > +       .validate_device = &iio_trigger_validate_own_device,
> > > > +};
> > > > +
> > > > +static irqreturn_t bma400_trigger_handler(int irq, void *p)
> > > > +{
> > > > +       struct iio_poll_func *pf = p;
> > > > +       struct iio_dev *indio_dev = pf->indio_dev;
> > > > +       struct bma400_data *data = iio_priv(indio_dev);
> > > > +       int ret, temp;
> > > > +
> > > > +       /* Lock to protect the data->buffer */
> > > > +       mutex_lock(&data->mutex);
> > > > +
> > > > +       /* bulk read six registers, with the base being the LSB register */
> > > > +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> > > > +                              &data->buffer.buff, sizeof(data->buffer.buff));
> > > > +       if (ret)
> > > > +               goto unlock_err;
> > > > +
> > > > +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);  
> >
> > Given the temperature read is a separate action, it seems like you could sensible
> > add another entry to bma400_avail_scan_masks() for just the accelerometer axis
> > and then only perform this read if the temperature is requested.
> >
> > It would be a feature though, so no need to have it in this patch if you
> > prefer not to.  
> 
> Sure I will add another entry only for the accelerometer axis and I
> will make changes
> accordingly in the next series.
> 
> Do I need to add 'Reviewed-by' tag if the patch gets modified again
> after getting the
> tag?
> 
It's something you have judge based on whether you think a change
is significant enough to warrant dropping tags.
If you do drop them you should always state why in the cover
letter or change log.

Thanks,

Jonathan

> 
> >  
> > > > +       if (ret)
> > > > +               goto unlock_err;
> > > > +
> > > > +       data->buffer.temperature = temp;
> > > > +
> > > > +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> > > > +                                          iio_get_time_ns(indio_dev));
> > > > +
> > > > +       mutex_unlock(&data->mutex);
> > > > +       iio_trigger_notify_done(indio_dev->trig);
> > > > +       return IRQ_HANDLED;
> > > > +
> > > > +unlock_err:
> > > > +       mutex_unlock(&data->mutex);
> > > > +       return IRQ_NONE;
> > > > +}  
> >  

