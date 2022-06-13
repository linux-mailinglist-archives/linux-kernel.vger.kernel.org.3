Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21E54A16A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349315AbiFMVan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353143AbiFMV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:29:19 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865BE388
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y79so7496444iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NnE+Xgzg7AJlz/AVhS5h85z464OyTQxoGvdET9a4HY=;
        b=dGPjzDX0wzDFKyXDAUW16dsPz49CqHJLXNBHBiPeOgaE5d8xIbI0bX7Mtw+wOV7ghH
         YdkHbi8kLXpQAGTQENTv5yw/FQizJyoXOIltRHJDFSNGf7ugFCFAHx/drsOJszoBvwES
         3p+trjrQuIZ1rUqPy7JNsgwyvKgJewjazkJ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NnE+Xgzg7AJlz/AVhS5h85z464OyTQxoGvdET9a4HY=;
        b=n+oyut6UXdf34ldHS3BQ7mRQo/Z5KzluAqGUn5P38vVJqAo7tgdQfloX5UAGKh0emD
         HHnhcj0JFaYtbTNFD3Hq5jzQ4O9SIgsacyS/BWw9GgSXrHKDOxuVU/bQLGKG/cpb63AU
         +vdAie5/c9sjzUFK+pKjlxJz+OkrfwboF+98c+/Cso8JfsYF0sDZSBhLA2lol7y4U3Wl
         TrHueNAfejcHMyrScE55p1wOYDWCXBxJERU5XKrn3025P9Y2n0HFieneGMw9tSzPTDvQ
         l8XyGZFmwICdJ+fYQkeiyWCPi7Ua9oUxxDyxjzJtGpwhVipNLVunWh+n4Q6qczQ5/gmv
         dXBg==
X-Gm-Message-State: AOAM533AatcXXl0zxOq/y/skKyrhw1ul3ru3ZwgWmQBqCRnTE4RUPBHH
        W/+pbRaR4ZKJ2/bge4Z1Mya56Mp5A/zVHIcfsxXtrw==
X-Google-Smtp-Source: ABdhPJyIxaI4vfZUSuU/ut9uN+5eC6ns20NayC9QlK+nuCJcAcU7BG8to5jvy1RRIeWa4opwhwvNAExigeFrGbuL6o8=
X-Received: by 2002:a05:6602:13c3:b0:669:cb19:6fe6 with SMTP id
 o3-20020a05660213c300b00669cb196fe6mr818734iov.177.1655155531829; Mon, 13 Jun
 2022 14:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220530174326.1381-1-andriy.shevchenko@linux.intel.com> <20220603180618.4b643391@jic23-huawei>
In-Reply-To: <20220603180618.4b643391@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 13 Jun 2022 14:25:21 -0700
Message-ID: <CAPUE2usmrREACn+bjRfMyNvF1aeozJq+tHCQY6XT7KMXvp94Bg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: proximity: sx_common: Allow IIO core to take
 care of firmware node
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason we have the code ACPI_COMPANION_SET and dev.of_node set (by
commit 74a53a959028e ("iio:proximity:sx_common: Fix device property
parsing on DT systems") from Stephen is we are getting device propery
in ->get_default_reg(), which is called in sx_common_init_device(),
before devm_iio_device_register().

We have the same code path in other driver, like adc/stm32-adc.c,
where indio_dev->dev.of_node is set manually to be able to set the
resolution based on device tree properties.

Gwendal.

On Fri, Jun 3, 2022 at 9:57 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 30 May 2022 20:43:26 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > IIO core correctly will take care of firmware node if it's not set in
> > the driver. Drop ACPI and OF specifics from the driver and allow IIO
> > core to handle this.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Looks fine to me.  As such I'll apply it now, but Gwendal, you've
> been active with this driver recently so if you have time to sanity check
> that would be great.  Once I've caught up with new stuff I plan to check
> where we are with your various series on this driver.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/proximity/sx_common.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> > index 8ad814d96b7e..6bb68c1835da 100644
> > --- a/drivers/iio/proximity/sx_common.c
> > +++ b/drivers/iio/proximity/sx_common.c
> > @@ -5,7 +5,6 @@
> >   * Common part of most Semtech SAR sensor.
> >   */
> >
> > -#include <linux/acpi.h>
> >  #include <linux/bitops.h>
> >  #include <linux/byteorder/generic.h>
> >  #include <linux/delay.h>
> > @@ -520,8 +519,6 @@ int sx_common_probe(struct i2c_client *client,
> >       if (ret)
> >               return dev_err_probe(dev, ret, "error reading WHOAMI\n");
> >
> > -     ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> > -     indio_dev->dev.of_node = client->dev.of_node;
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >
> >       indio_dev->channels =  data->chip_info->iio_channels;
>
