Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32401516519
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348898AbiEAQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiEAQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:15:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B43DFEA;
        Sun,  1 May 2022 09:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21E9BB80E5A;
        Sun,  1 May 2022 16:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758C0C385AA;
        Sun,  1 May 2022 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651421540;
        bh=+JCdHDwwPGGZ+rAC+3PkQyPI2jD46/M4umIy3xmT3B8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSqMEvHkYyQwoShxYhQuXUuPAoEg0dhDviXIPkhPjOAG6JnHhdsjJrMsBmtcowfjn
         MsBNzCE684Csvxjd9N5JNnVXkFJ+ILsslyv9KZn8JjVQjDuupYgQxDTRSiuJkNJfbK
         aQB4EzM/Obw6ebxLKVH65iMCcJKcgAsDRVlgN50vb8WRY6oiMOJooT1K1S60rtCKyN
         NzRLDOLRn/gQtpwrIELuFBAepdRN9MRoRkufY6iIIBQ/4EluuH2jlS7thUWv9I7su2
         gYE/kLtX4khiV4RoUYDxA9wEQWoZtidj5eZesgo2TOvjOGg6ytJl3Lvu3vH4mz0vtg
         o3BzemKWEexdA==
Date:   Sun, 1 May 2022 17:20:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220501172037.5f3d446f@jic23-huawei>
In-Reply-To: <CAHp75Vf5pS_TGm5ptN7TyNmhZe_Oz8pVmETT27VeC=BZk9+ezg@mail.gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
        <20220420211105.14654-5-jagathjog1996@gmail.com>
        <CAHp75Vf5pS_TGm5ptN7TyNmhZe_Oz8pVmETT27VeC=BZk9+ezg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Wed, 27 Apr 2022 14:34:57 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Added trigger buffer support to read continuous acceleration
> > data from device with data ready interrupt which is mapped
> > to INT1 pin.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Agreed.  A couple of 'comments' inline but no actual need to change anything.
One is contingent on a fix I've not sent out yet for the rest of IIO.
The other is potentially a minor improvement for the future.

Thanks,

Jonathan

> 
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > ---
> >  drivers/iio/accel/Kconfig       |   2 +
> >  drivers/iio/accel/bma400.h      |  10 +-
> >  drivers/iio/accel/bma400_core.c | 162 +++++++++++++++++++++++++++++++-
> >  drivers/iio/accel/bma400_i2c.c  |   2 +-
> >  drivers/iio/accel/bma400_spi.c  |   2 +-
> >  5 files changed, 170 insertions(+), 8 deletions(-)

> >
> >  #include "bma400.h"
> >
> > @@ -61,6 +66,14 @@ struct bma400_data {
> >         struct bma400_sample_freq sample_freq;
> >         int oversampling_ratio;
> >         int scale;
> > +       struct iio_trigger *trig;
> > +       /* Correct time stamp alignment */
> > +       struct {
> > +               __le16 buff[3];
> > +               u8 temperature;
> > +               s64 ts __aligned(8);
> > +       } buffer ____cacheline_aligned;

If you are rolling again, could you change this to
__aligned(IIO_ALIGN);  See
https://lore.kernel.org/linux-iio/20220419121241.00002e42@Huawei.com/
for why.
Note that I'll be sending a fix patch out for IIO_ALIGN to define
it as ARCH_KMALLOC_ALIGN in next few days.

If you'd pref not to get caught up in that, send it as it stands
and I'll fix up once that fix is in place.  What's one more driver
on top of the 80+ I have to do anyway :)



> > +       __le16 status;
> >  };
> >

> > +
> > +static const unsigned long bma400_avail_scan_masks[] = {
> > +       GENMASK(3, 0),
> > +       0
> > +};
> > +
> >  static const struct iio_info bma400_info = {
> >         .read_raw          = bma400_read_raw,
> >         .read_avail        = bma400_read_avail,
> > @@ -814,7 +869,72 @@ static const struct iio_info bma400_info = {
> >         .write_raw_get_fmt = bma400_write_raw_get_fmt,
> >  };
> >
> > -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> > +static const struct iio_trigger_ops bma400_trigger_ops = {
> > +       .set_trigger_state = &bma400_data_rdy_trigger_set_state,
> > +       .validate_device = &iio_trigger_validate_own_device,
> > +};
> > +
> > +static irqreturn_t bma400_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf = p;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct bma400_data *data = iio_priv(indio_dev);
> > +       int ret, temp;
> > +
> > +       /* Lock to protect the data->buffer */
> > +       mutex_lock(&data->mutex);
> > +
> > +       /* bulk read six registers, with the base being the LSB register */
> > +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> > +                              &data->buffer.buff, sizeof(data->buffer.buff));
> > +       if (ret)
> > +               goto unlock_err;
> > +
> > +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);

Given the temperature read is a separate action, it seems like you could sensible
add another entry to bma400_avail_scan_masks() for just the accelerometer axis
and then only perform this read if the temperature is requested.

It would be a feature though, so no need to have it in this patch if you
prefer not to.

> > +       if (ret)
> > +               goto unlock_err;
> > +
> > +       data->buffer.temperature = temp;
> > +
> > +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> > +                                          iio_get_time_ns(indio_dev));
> > +
> > +       mutex_unlock(&data->mutex);
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +       return IRQ_HANDLED;
> > +
> > +unlock_err:
> > +       mutex_unlock(&data->mutex);
> > +       return IRQ_NONE;
> > +}

