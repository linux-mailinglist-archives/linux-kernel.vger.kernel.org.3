Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480CF4C5780
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiBZSdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiBZSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:33:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3C14FFF9;
        Sat, 26 Feb 2022 10:32:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AFDE60EEF;
        Sat, 26 Feb 2022 18:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A076C340E8;
        Sat, 26 Feb 2022 18:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645900375;
        bh=Csg8unkLr4Ux6a7qCx2jnDAk15HDPzu9ev6OyC96Zlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MqU3eKey64+bo/qPZRZG5C54jKIRhMZWBrpUvuAwWjQ11uvHdHPvCG/zuB6JJ8ycw
         D9FBVoHfr4rvkZsWqSQaxexI6ZGkt+jGOiejQ8hMD/TgPDb7CmlnTktv/5PdWC/d6g
         ul6PKciU+/HTzA/xmXw2FYWWYh0QRli3+aSiUCD85ksxFG48R5Y6s0p5H5D/qs20FU
         oZekFfq7jHcWeUiFePu1PV3dem/tp8S6ocMtvalzCVXtsbhWZKd475VrxkEREsLnYj
         wqUqxi/3wQ/0G9ssooLkjy+kij3crx6N5N7uwSrM6i+Uz4j0nKg7bwEjslLkpkBay8
         ZDCo8h/5Ugfcw==
Date:   Sat, 26 Feb 2022 18:39:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/7] iio: potentiometer: Add device specific read_raw
 function
Message-ID: <20220226183956.199aef29@jic23-huawei>
In-Reply-To: <CAHp75VcKvXi6oUm2Ysx_F+Myu6Dy9-Vxp9MwTcrT5si0Fe6c7w@mail.gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
        <20220223163525.13399-6-jagathjog1996@gmail.com>
        <CAHp75VcKvXi6oUm2Ysx_F+Myu6Dy9-Vxp9MwTcrT5si0Fe6c7w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 02:46:34 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Feb 23, 2022 at 6:35 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Added function pointer in the device specific structure to
> > call the appropriate device read_raw function, so that the
> > other type of devices with different read method can be
> > handled.
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > ---
> >  drivers/iio/potentiometer/ds1803.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> > index aeb74ee46fbc..878188351f8f 100644
> > --- a/drivers/iio/potentiometer/ds1803.c
> > +++ b/drivers/iio/potentiometer/ds1803.c
> > @@ -32,6 +32,8 @@ struct ds1803_cfg {
> >         int kohms;
> >         const struct iio_chan_spec *channels;
> >         u8 num_channels;
> > +       int (*read)(struct iio_dev *indio_dev,
> > +                   struct iio_chan_spec const *chan, int *val);
> >  };
> >
> >  struct ds1803_data {
> > @@ -55,6 +57,22 @@ static const struct iio_chan_spec ds1803_channels[] = {
> >         DS1803_CHANNEL(1, DS1803_WIPER_1),
> >  };
> >
> > +static int ds1803_read(struct iio_dev *indio_dev,
> > +                      struct iio_chan_spec const *chan,
> > +                      int *val)
> > +{
> > +       struct ds1803_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +       u8 result[ARRAY_SIZE(ds1803_channels)];
> > +
> > +       ret = i2c_master_recv(data->client, result, indio_dev->num_channels);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *val = result[chan->channel];
> > +       return ret;
> > +}
> > +
> >  static const struct ds1803_cfg ds1803_cfg[] = {
> >         [DS1803_010] = {
> >           .wipers = 2,
> > @@ -62,6 +80,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
> >           .kohms =  10,
> >           .channels = ds1803_channels,
> >           .num_channels = ARRAY_SIZE(ds1803_channels),
> > +         .read = ds1803_read,
> >         },
> >         [DS1803_050] = {
> >           .wipers = 2,
> > @@ -69,6 +88,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
> >           .kohms =  50,
> >           .channels = ds1803_channels,
> >           .num_channels = ARRAY_SIZE(ds1803_channels),
> > +         .read = ds1803_read,
> >         },
> >         [DS1803_100] = {
> >           .wipers = 2,
> > @@ -76,6 +96,7 @@ static const struct ds1803_cfg ds1803_cfg[] = {
> >           .kohms = 100,
> >           .channels = ds1803_channels,
> >           .num_channels = ARRAY_SIZE(ds1803_channels),
> > +         .read = ds1803_read,
> >         },
> >  };
> >
> > @@ -84,20 +105,15 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
> >                            int *val, int *val2, long mask)
> >  {
> >         struct ds1803_data *data = iio_priv(indio_dev);
> > -       int pot = chan->channel;
> >         int ret;
> > -       u8 result[ARRAY_SIZE(ds1803_channels)];
> >
> >         switch (mask) {
> >         case IIO_CHAN_INFO_RAW:
> > -               ret = i2c_master_recv(data->client, result,
> > -                                     indio_dev->num_channels);
> > +               ret = data->cfg->read(indio_dev, chan, val);
> >                 if (ret < 0)
> >                         return ret;
> >
> > -               *val = result[pot];
> >                 return IIO_VAL_INT;  
> 
> > -  
> 
> Seems like a stray change. Up to Jonathan to decide what to do (no
> need for resend b/c of this).

Good spot. Given I was tweaking this series a fair bit anyway whilst
applying I tidied this up as well.

Thanks,

Jonathan

> 
> >         case IIO_CHAN_INFO_SCALE:
> >                 *val = 1000 * data->cfg->kohms;
> >                 *val2 = data->cfg->avail[2]; /* Max wiper position */
> > --
> > 2.17.1
> >  
> 
> 

