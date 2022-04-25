Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D035750DFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiDYMGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiDYMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:06:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DECC28E01;
        Mon, 25 Apr 2022 05:03:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y14so13811872pfe.10;
        Mon, 25 Apr 2022 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhnjAWnGrJGP8BwfRPqb2+KgOagr+BqM4s/xGlcapnY=;
        b=EGClnj43K/BmII2FAnpQ/YpEPGsYydbCJvSxUvg1jGXV0u74F8kkHtHuLsw4YaLTvu
         HhNDhju02s8gT5dFaAxeBD80C0yFwpCgppQO8waqQj2cHErzU9HR4VpTO+fsBH/MoWXc
         FLE3HXW68oQnfvaEweXkiybGkTTsQe9NXsY4XzLbulB8PfH1o1ZfJePnJlw2LHb8IC1e
         MX+JojERGey3dzaJHFMeEwmwpnwzbwZKfgmAlTnBJkYPS/UEvhs8Jo9OrdW9QVf61qqk
         4awK1G+Rk4mpPeEmN+R598gXuKEpjmNMOjymFfyjZbi0KkzZOjE6MTao71IYsutxgJmu
         atdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhnjAWnGrJGP8BwfRPqb2+KgOagr+BqM4s/xGlcapnY=;
        b=Wnxelnn5PTcdkAZ7gpBgHUHJ8pjswSSdIGEJmc19kJokU+YPxuIBmvwCTdOdlCqLQg
         4cATUqZ6HEq7+ocBgCzY0BknTA4srunaMMn8sS6eSQKALL+8J0qYy5lZoE9v1Gkm3byp
         fs23rIV+VxQSEMYmO3CpeX2vX/BcU4CsWI01Qe8uf5L+0I9VQlLXj/JaDcxM0U5wgosk
         7EZKFrKBv3nlBscTLFjcIGjod7gqtBYVd6nOjnADBR5vkqog//HAzWhgd4czHgSR7iDp
         GTfM6yMjGD1qqrsr4O/VN5jThzQhktP0Crg34Hk5eNyO5NoN+5QO7oZBbIX89vMtglL4
         x14Q==
X-Gm-Message-State: AOAM530lAQ2/LnWMedQcODJHs1+lgt+b3vKn5XlGxDTtEKnEfZ1GFbpG
        dVEnjc21Gem8RCbMt1vdo+fPdHq8CAr/rMBZhro52O6UT+U=
X-Google-Smtp-Source: ABdhPJwWbz8+yT0cpqXJbJZJITJ6NDweRqmSFGZY1DWmgPyToylc6n6tO/kabLSdNPLCEcij9O4/Uxx3KIrRwFueur4=
X-Received: by 2002:a63:8ac9:0:b0:3ab:dab:16b4 with SMTP id
 y192-20020a638ac9000000b003ab0dab16b4mr7859875pgd.129.1650888200481; Mon, 25
 Apr 2022 05:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
 <20220411203133.19929-10-jagathjog1996@gmail.com> <20220416175537.193cfc10@jic23-huawei>
 <20220418220941.GA16030@jagath-PC> <20220424164020.4d0bdf95@jic23-huawei>
In-Reply-To: <20220424164020.4d0bdf95@jic23-huawei>
From:   jagath jogj <jagathjog1996@gmail.com>
Date:   Mon, 25 Apr 2022 17:33:09 +0530
Message-ID: <CAM+2EuKQdSGgeSKWc8pBhzORmERp1KsSUkLpYmFGwCCQHWrsrg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Sun, Apr 24, 2022 at 9:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 19 Apr 2022 03:39:43 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Hello Jonathan,
> >
> > Thanks for your suggestions, I will fix the locking and unlocking for all
> > patches in the next series.
> >
> > Please can you guide me for auto build test error reported by kernel test
> > robot for set_mask_bits(&data->generic_event_en, msk, field_value);
> > in this patch.
> >
> > On Sat, Apr 16, 2022 at 05:55:37PM +0100, Jonathan Cameron wrote:
> > > On Tue, 12 Apr 2022 02:01:33 +0530
> > > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >
> > > > Add support for activity and inactivity events for all axis based on the
> > > > threshold, duration and hysteresis value set from the userspace. INT1 pin
> > > > is used to interrupt and event is pushed to userspace.
> > > >
> > > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/bma400.h      |  11 ++
> > > >  drivers/iio/accel/bma400_core.c | 229 ++++++++++++++++++++++++++++++++
> > > >  2 files changed, 240 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > > > index bc4641279be3..cbf8035c817e 100644
> > > > --- a/drivers/iio/accel/bma400.h
> > > > +++ b/drivers/iio/accel/bma400.h
> > > > @@ -93,6 +93,17 @@
> > > >  #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
> > > >  #define BMA400_ACC_ODR_MIN_HZ       12
> > > >
> > > > +/* Generic interrupts register */
> > > > +#define BMA400_GEN1INT_CONFIG0      0x3f
> > > > +#define BMA400_GEN2INT_CONFIG0      0x4A
> > > > +#define BMA400_GEN_CONFIG1_OFF      0x01
> > > > +#define BMA400_GEN_CONFIG2_OFF      0x02
> > > > +#define BMA400_GEN_CONFIG3_OFF      0x03
> > > > +#define BMA400_GEN_CONFIG31_OFF     0x04
> > > > +#define BMA400_INT_GEN1_MSK         BIT(2)
> > > > +#define BMA400_INT_GEN2_MSK         BIT(3)
> > > > +#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> > > > +
> > > >  /*
> > > >   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
> > > >   * converting to micro values for +-2g range.
> > > > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > > > index b6c79cfabaa4..226a5f63d1a6 100644
> > > > --- a/drivers/iio/accel/bma400_core.c
> > > > +++ b/drivers/iio/accel/bma400_core.c
> > > > @@ -79,6 +79,7 @@ struct bma400_data {
> > > >   int steps_enabled;
> > > >   bool step_event_en;
> > > >   bool activity_event_en;
> > > > + u8 generic_event_en;
> > > >   /* Correct time stamp alignment */
> > > >   struct {
> > > >           __le16 buff[3];
> > > > @@ -188,6 +189,25 @@ static const struct iio_event_spec bma400_activity_event = {
> > > >   .mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
> > > >  };
> > > >
> > > > +static const struct iio_event_spec bma400_accel_event[] = {
> > > > + {
> > > > +         .type = IIO_EV_TYPE_MAG,
> > > > +         .dir = IIO_EV_DIR_FALLING,
> > > > +         .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > > > +                                BIT(IIO_EV_INFO_PERIOD) |
> > > > +                                BIT(IIO_EV_INFO_HYSTERESIS) |
> > > > +                                BIT(IIO_EV_INFO_ENABLE),
> > > > + },
> > > > + {
> > > > +         .type = IIO_EV_TYPE_MAG,
> > > > +         .dir = IIO_EV_DIR_RISING,
> > > > +         .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > > > +                                BIT(IIO_EV_INFO_PERIOD) |
> > > > +                                BIT(IIO_EV_INFO_HYSTERESIS) |
> > > > +                                BIT(IIO_EV_INFO_ENABLE),
> > > > + },
> > > > +};
> > > > +
> > > >  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> > > >   .type = IIO_ACCEL, \
> > > >   .modified = 1, \
> > > > @@ -207,6 +227,8 @@ static const struct iio_event_spec bma400_activity_event = {
> > > >           .storagebits = 16,      \
> > > >           .endianness = IIO_LE,   \
> > > >   },                              \
> > > > + .event_spec = bma400_accel_event,                       \
> > > > + .num_event_specs = ARRAY_SIZE(bma400_accel_event)       \
> > > >  }
> > > >
> > > >  #define BMA400_ACTIVITY_CHANNEL(_chan2) {        \
> > > > @@ -954,6 +976,17 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
> > > >   struct bma400_data *data = iio_priv(indio_dev);
> > > >
> > > >   switch (chan->type) {
> > > > + case IIO_ACCEL:
> > > > +         switch (dir) {
> > > > +         case IIO_EV_DIR_RISING:
> > > > +                 return FIELD_GET(BMA400_INT_GEN1_MSK,
> > > > +                                  data->generic_event_en);
> > > > +         case IIO_EV_DIR_FALLING:
> > > > +                 return FIELD_GET(BMA400_INT_GEN2_MSK,
> > > > +                                  data->generic_event_en);
> > > > +         default:
> > > > +                 return -EINVAL;
> > > > +         }
> > > >   case IIO_STEPS:
> > > >           return data->step_event_en;
> > > >   case IIO_ACTIVITY:
> > > > @@ -970,8 +1003,74 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
> > > >  {
> > > >   int ret;
> > > >   struct bma400_data *data = iio_priv(indio_dev);
> > > > + int reg, msk, value, field_value;
> > > >
> > > >   switch (chan->type) {
> > > > + case IIO_ACCEL:
> > > > +         switch (dir) {
> > > > +         case IIO_EV_DIR_RISING:
> > > > +                 reg = BMA400_GEN1INT_CONFIG0;
> > > > +                 msk = BMA400_INT_GEN1_MSK;
> > > > +                 value = 2;
> > > > +                 field_value = FIELD_PREP(BMA400_INT_GEN1_MSK, state);
> > >
> > > Hopefully you can use msk in here and the compiler can tell it's constant...
> >
> > field_value = FIELD_PREP(msk, state);
> > is this the fix for error reported by kernel test robot?
> No.  That issue seems to be triggered by the size of parameters passed
> to the underlying cmpxchg behind set_mask_bits.
> Specifically riscv cmpxchg only support 32 or 64 bit inputs.
> https://elixir.bootlin.com/linux/latest/source/arch/riscv/include/asm/cmpxchg.h#L302
>
> Easiest fix is probably just to make generic_event_en 32 bits.

In the patch series v4 I have declared generic_event_en as unsigned int.

> ..
>
> > > > +static int bma400_read_event_value(struct iio_dev *indio_dev,
> > > > +                            const struct iio_chan_spec *chan,
> > > > +                            enum iio_event_type type,
> > > > +                            enum iio_event_direction dir,
> > > > +                            enum iio_event_info info,
> > > > +                            int *val, int *val2)
> > > > +{
> > > > + struct bma400_data *data = iio_priv(indio_dev);
> > > > + int ret;
> > > > + u8 reg, duration[2];
> > > > +
> > > > + reg = get_gen_config_reg(dir);
> > > > + if (reg < 0)
> > > > +         return -EINVAL;
> > > > +
> > > > + *val2 = 0;
> > > > + switch (info) {
> > > > + case IIO_EV_INFO_VALUE:
> > > > +         mutex_lock(&data->mutex);
> > > > +         ret = regmap_read(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> > > > +                           val);
> > > > +         mutex_unlock(&data->mutex);
> > > > +         if (ret)
> > > > +                 return ret;
> > > > +         return IIO_VAL_INT;
> > > > + case IIO_EV_INFO_PERIOD:
> > > > +         mutex_lock(&data->mutex);
> > > > +         ret = regmap_bulk_read(data->regmap,
> > > > +                                reg + BMA400_GEN_CONFIG3_OFF,
> > > > +                                duration, sizeof(duration));
> > > > +         mutex_unlock(&data->mutex);
> > > > +         if (ret)
> > > > +                 return ret;
> > > > +         *val = get_unaligned_be16(duration);
> > >
> > > As well as dma safety question, you could just have used a __be16 for
> > > duration then you can use be16_to_cpu() as you know it is aligned.
> >
> > For dma safety, do I need to allocate memory by using local kmalloc() or
> > I can use __be16 local variable for regmap_bulk_read()?
>
> Ah. i've been unclear there.   Was pointing out that if we didn't need
> to force alignment larger for DMA safety then using __be16 would have
> ensured that this was correctly aligned.  However we do need to
> force it so either use a kmalloc'd buffer as you suggest or
> play games with an aligned buffer in the iio_priv() region.

In v4 series, I have used a __be16 buffer in the iio_priv() region for
duration so
that it can be used for both regmap_bulk_read() and regmap_bulk_write().

>
> Note however that we have a bug in IIO currently as we have
> been forcing alignment to L1 cache size which is wrong (not enough in some cases
> and far too much in others).  I'll be posting
> some patches to fix that in the next few days.
>
>
> >
> > >
> > > > +         return IIO_VAL_INT;
> > > > + case IIO_EV_INFO_HYSTERESIS:
> > > > +         mutex_lock(&data->mutex);
> > > > +         ret = regmap_read(data->regmap, reg, val);
> > > > +         mutex_unlock(&data->mutex);
> > > > +         if (ret)
> > > > +                 return ret;
> > > > +         *val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
> > > > +         return IIO_VAL_INT;
> > > > + default:
> > > > +         return -EINVAL;
> > > > + }
> > > > +}
> > > > +
> > > > +static int bma400_write_event_value(struct iio_dev *indio_dev,
> > > > +                             const struct iio_chan_spec *chan,
> > > > +                             enum iio_event_type type,
> > > > +                             enum iio_event_direction dir,
> > > > +                             enum iio_event_info info,
> > > > +                             int val, int val2)
> > > > +{
> > > > + struct bma400_data *data = iio_priv(indio_dev);
> > > > + int ret;
> > > > + u8 reg, duration[2];
> > > > +
> > > > + reg = get_gen_config_reg(dir);
> > > > + if (reg < 0)
> > > > +         return -EINVAL;
> > > > +
> > > > + switch (info) {
> > > > + case IIO_EV_INFO_VALUE:
> > > > +         if (val < 1 || val > 255)
> > > > +                 return -EINVAL;
> > > > +
> > > > +         mutex_lock(&data->mutex);
> > > > +         ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
> > > > +                            val);
> > > > +         mutex_unlock(&data->mutex);
> > > > +         return ret;
> > > > + case IIO_EV_INFO_PERIOD:
> > > > +         if (val < 1 || val > 65535)
> > > > +                 return -EINVAL;
> > > > +
> > > > +         put_unaligned_be16(val, duration);
> > > > +
> > > > +         mutex_lock(&data->mutex);
> > > > +         ret = regmap_bulk_write(data->regmap,
> > > > +                                 reg + BMA400_GEN_CONFIG3_OFF,
> > > > +                                 duration, sizeof(duration));
> > >
> > > I can't remember if we are safe or not with bulk_writes but at least
> > > in theory we might not be and should be using a dma safe buffer.
> >
> > Here also for regmap_bulk_write() can I allocate the memory locally by using
> > kmalloc().
>
> Yes though that's usually a pain to handle in comparison with a buffer in iio_priv()
> as you have to free it again.
>
> >
> > >
> > > Also locking not necessary in various places in here.
> >
> > I will fix the locking in all the patches in the next series.
> >
> > >
> > > > +         mutex_unlock(&data->mutex);
> > > > +         return ret;
> > > > + case IIO_EV_INFO_HYSTERESIS:
> > > > +         if (val < 0 || val > 3)
> > > > +                 return -EINVAL;
> > > > +
> > > > +         mutex_lock(&data->mutex);
> > > > +         ret = regmap_update_bits(data->regmap, reg,
> > > > +                                  BMA400_GEN_HYST_MSK,
> > > > +                                  FIELD_PREP(BMA400_GEN_HYST_MSK, val));
> > > > +         mutex_unlock(&data->mutex);
> > > > +         return ret;
> > > > + default:
> > > > +         return -EINVAL;
> > > > + }
> > > > +}
> > > > +
> > >
> >
> > Thank you,
> > Jagath
>
> Thanks,
>
> Jonathan
>
>
