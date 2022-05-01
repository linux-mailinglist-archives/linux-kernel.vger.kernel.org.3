Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB955167C6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354458AbiEAU3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354561AbiEAU33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:29:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FB63F30C;
        Sun,  1 May 2022 13:26:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p8so10904573pfh.8;
        Sun, 01 May 2022 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poTw99el8hA8UvREnNqZRyuvNRDohAjbzuyQQ6m9nA0=;
        b=ESH8sti45yasa2IrckGbf5eR2XodldnSQEg3z+ZAtsbSDjzi6WGsRKNU9d3gwwiSQQ
         GFJyEsvfXhUmfnGoeNMYD6eI8vJE+cYoc/8rxuutDFvzrMppMsH/TG/bd8gLlC/aDBHb
         ALaVtYmLP6ez1ZO95NaHTSW+glODHwiO5A2bjraS57jgfr0tiRc5MqcONMJYz6HtbPc0
         iF5sb9Adxw4rWxQyK2X8Rc7g2hsfa2twoYVGYwtLmWuAc0erHZyl2XZLNe7bUXSvIQoB
         tAeQXnYhHAhhWvKw1YiLSE/MzjvXrEaAwiaJuRskAvCATLQWf3VpouoCEPjRPSnKbIzk
         q/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poTw99el8hA8UvREnNqZRyuvNRDohAjbzuyQQ6m9nA0=;
        b=Ava/JIZ9P28wtej3PuTR/tyPbQmptzSIeNOK7tBVneh2LoqguID60Ex3F8Uoe66Hzp
         xgysKydbVV69iUVpw2vpEcyokx6lwYzlosnuTj/d2KzxfqjNMHvd1bWwwnLWJ8dAE/os
         npEVoP7iO84a86WR4fvvMWIkzGuMgzyvs5eYb9ss/0vGtXUnDDEBnbyGF2PBiDX+WW5+
         iUgoxb7ysm97Cbo8wWF7iViKcyfCNjjTarZBNXWq19XwKXOoimfvUNgSkqCUhBwbm3aX
         mrZN+E48ccOikcTyOdscQKHr4B2Ba1t2zn4NmNS+kvK5u8Z//1zvH1EcejUORHfVyczF
         9h/Q==
X-Gm-Message-State: AOAM533jJBhHDrOTs+uL7DWJ5eqKkPazOyqQ0UgR5ORCAW0Y5kNkfhQT
        0Y3PSgdom3M2iMNT4vKmqxtNMUlv86U1xFd/TSPEZoG3dxT0xA==
X-Google-Smtp-Source: ABdhPJwXFf/e4kdq8gcjbrEsFwJB+GL1XHoOTvpxCSwBmV+0X3Mj3xZKQ49A/5cZMYm1b1UbXyAXSILQcbCn3y4dAT0=
X-Received: by 2002:a63:6c8a:0:b0:3ab:8c07:4d93 with SMTP id
 h132-20020a636c8a000000b003ab8c074d93mr7240626pgc.431.1651436761019; Sun, 01
 May 2022 13:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
 <20220420211105.14654-5-jagathjog1996@gmail.com> <CAHp75Vf5pS_TGm5ptN7TyNmhZe_Oz8pVmETT27VeC=BZk9+ezg@mail.gmail.com>
 <20220501172037.5f3d446f@jic23-huawei>
In-Reply-To: <20220501172037.5f3d446f@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Mon, 2 May 2022 01:55:49 +0530
Message-ID: <CAM+2EuLLRNarHkzr9YXTcSnhdSYcRNZj_tYZK7HN+Jzj0GC5ag@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] iio: accel: bma400: Add triggered buffer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, May 1, 2022 at 9:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 27 Apr 2022 14:34:57 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >
> > > Added trigger buffer support to read continuous acceleration
> > > data from device with data ready interrupt which is mapped
> > > to INT1 pin.
> >
> > LGTM,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Agreed.  A couple of 'comments' inline but no actual need to change anything.
> One is contingent on a fix I've not sent out yet for the rest of IIO.
> The other is potentially a minor improvement for the future.
>
> Thanks,
>
> Jonathan
>
> >
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > > ---
> > >  drivers/iio/accel/Kconfig       |   2 +
> > >  drivers/iio/accel/bma400.h      |  10 +-
> > >  drivers/iio/accel/bma400_core.c | 162 +++++++++++++++++++++++++++++++-
> > >  drivers/iio/accel/bma400_i2c.c  |   2 +-
> > >  drivers/iio/accel/bma400_spi.c  |   2 +-
> > >  5 files changed, 170 insertions(+), 8 deletions(-)
>
> > >
> > >  #include "bma400.h"
> > >
> > > @@ -61,6 +66,14 @@ struct bma400_data {
> > >         struct bma400_sample_freq sample_freq;
> > >         int oversampling_ratio;
> > >         int scale;
> > > +       struct iio_trigger *trig;
> > > +       /* Correct time stamp alignment */
> > > +       struct {
> > > +               __le16 buff[3];
> > > +               u8 temperature;
> > > +               s64 ts __aligned(8);
> > > +       } buffer ____cacheline_aligned;
>
> If you are rolling again, could you change this to
> __aligned(IIO_ALIGN);  See
> https://lore.kernel.org/linux-iio/20220419121241.00002e42@Huawei.com/
> for why.
> Note that I'll be sending a fix patch out for IIO_ALIGN to define
> it as ARCH_KMALLOC_ALIGN in next few days.
>
> If you'd pref not to get caught up in that, send it as it stands
> and I'll fix up once that fix is in place.  What's one more driver
> on top of the 80+ I have to do anyway :)
>
>

Sure, I will change that to __aligned(IIO_ALIGN); in the next series.

>
> > > +       __le16 status;
> > >  };
> > >
>
> > > +
> > > +static const unsigned long bma400_avail_scan_masks[] = {
> > > +       GENMASK(3, 0),
> > > +       0
> > > +};
> > > +
> > >  static const struct iio_info bma400_info = {
> > >         .read_raw          = bma400_read_raw,
> > >         .read_avail        = bma400_read_avail,
> > > @@ -814,7 +869,72 @@ static const struct iio_info bma400_info = {
> > >         .write_raw_get_fmt = bma400_write_raw_get_fmt,
> > >  };
> > >
> > > -int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
> > > +static const struct iio_trigger_ops bma400_trigger_ops = {
> > > +       .set_trigger_state = &bma400_data_rdy_trigger_set_state,
> > > +       .validate_device = &iio_trigger_validate_own_device,
> > > +};
> > > +
> > > +static irqreturn_t bma400_trigger_handler(int irq, void *p)
> > > +{
> > > +       struct iio_poll_func *pf = p;
> > > +       struct iio_dev *indio_dev = pf->indio_dev;
> > > +       struct bma400_data *data = iio_priv(indio_dev);
> > > +       int ret, temp;
> > > +
> > > +       /* Lock to protect the data->buffer */
> > > +       mutex_lock(&data->mutex);
> > > +
> > > +       /* bulk read six registers, with the base being the LSB register */
> > > +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> > > +                              &data->buffer.buff, sizeof(data->buffer.buff));
> > > +       if (ret)
> > > +               goto unlock_err;
> > > +
> > > +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
>
> Given the temperature read is a separate action, it seems like you could sensible
> add another entry to bma400_avail_scan_masks() for just the accelerometer axis
> and then only perform this read if the temperature is requested.
>
> It would be a feature though, so no need to have it in this patch if you
> prefer not to.

Sure I will add another entry only for the accelerometer axis and I
will make changes
accordingly in the next series.

Do I need to add 'Reviewed-by' tag if the patch gets modified again
after getting the
tag?


>
> > > +       if (ret)
> > > +               goto unlock_err;
> > > +
> > > +       data->buffer.temperature = temp;
> > > +
> > > +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> > > +                                          iio_get_time_ns(indio_dev));
> > > +
> > > +       mutex_unlock(&data->mutex);
> > > +       iio_trigger_notify_done(indio_dev->trig);
> > > +       return IRQ_HANDLED;
> > > +
> > > +unlock_err:
> > > +       mutex_unlock(&data->mutex);
> > > +       return IRQ_NONE;
> > > +}
>
