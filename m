Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B354CEBC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356340AbiFOQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356130AbiFOQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:33:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8162457B1;
        Wed, 15 Jun 2022 09:33:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so24297182eja.8;
        Wed, 15 Jun 2022 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37sI1USoy+xRQH8QbGSjnzweIUNwAt0HoK9F/1KuOZ4=;
        b=VDL9QmcQj8yIgSj4LMJxd1bT9DSNCD5IK1lckPMPlBcMaksnq3xla7UTUsu/fXVPbs
         eT80MVA5NJwXjMR37UiwDMwDqpi2s+9bWp5Ui56I6O8BYZaU1n/VLeEA6p4oVX7sH/6U
         onyymzSLt9QM5kO823hLqwx4KbcOy5RiCYi9FXemWzCshZMK+xuL60lzOKeHI1temeIt
         nh5KNquRW7ySATd2l6Iw5nd6GHt6Kw0kbFkNa/ZAQJUVEVG5b4BKnCCNBHrQDJbZiWLi
         SPWGk1vS6YRhsxjQCwT8pzpgxFJtPqIfXgvHJVfoB55Was/cQda3Fw5+cDYgFJkSFmjZ
         zbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37sI1USoy+xRQH8QbGSjnzweIUNwAt0HoK9F/1KuOZ4=;
        b=Pa2wwPYfKx+XZC4S/02tIct7LDBbnrOT0ib2rVqtOu/O0JOdqFo6uesLg3DwQIlMSK
         wAe9imRwgzijrFuQjNl3i2FgRKqBF3C4xvaPgOYFdMhTpWKagMllI4O7U4HGG5eL8ave
         8lVM/XYVYYb9Z+Ugwn8eDeJC7OGRCbM1BwXWcZCy0ZbrgIhcp2V1Mjk3evQzqEx5KbCL
         Vlno57sdj8QlkszYJAnMNjzvAUoppM68aIY8j5M7Ij1OET4+OQczP5ghLFXfSLnW4tK8
         HsnXeY85wp6TdjXG/FblFnLHefkhD+iCbUbXjQmv9sDpxspT2NpVo+JjMADCu94EKmAb
         9IyA==
X-Gm-Message-State: AJIora/P1NxyfcytZkZF7yKLBPK3rdZCeOdhObFtvw3o3dfVh3c0GDZB
        XWAUSFHXcbsNZ2ANjKBDNplpF6uYJEw2fuCqehg=
X-Google-Smtp-Source: AGRyM1vDmI64JtK+fXsJKnvDR2X1TpTWuCM7Z6iVIxs6wzLIMn4UVuyNvp9Mlkskq/lhEKHq6diUGBe2SKNN4/Jfg5E=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr602613ejm.636.1655310790302; Wed, 15
 Jun 2022 09:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220615135130.227236-1-shreeya.patel@collabora.com> <20220615135130.227236-3-shreeya.patel@collabora.com>
In-Reply-To: <20220615135130.227236-3-shreeya.patel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 18:32:33 +0200
Message-ID: <CAHp75VeU9oSJmMdyT_0BZDuG5WMiuJiCPv5So4DWG05EEDKrhw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: light: Add support for ltrf216a sensor
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com, Dmitry Osipenko <digetx@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 3:52 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>
> Add initial support for ltrf216a ambient light sensor.

This doesn't clarify why regmap API for SMBus can't be used.

...

> Datasheet: https://bit.ly/3MRTYwY

These kinds of links tend to disappear, please use the real link.

...

> Reported-by: kernel test robot <lkp@intel.com>

No, the new feature may not be reported.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>

+ blank line

> +#include <linux/iio/iio.h>

+ blank line

> +#include <asm/unaligned.h>

...

> +/*
> + * Window Factor is needed when the device is under Window glass
> + * with coated tinted ink. This is to compensate the light loss

compensate for the

> + * due to the lower transmission rate of the window glass and helps
> + * in calculating lux.
> + */

...

> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
> +{
> +       struct device *dev = &data->client->dev;
> +       int ret, suspended;
> +
> +       if (on) {
> +               suspended = pm_runtime_suspended(dev);
> +               ret = pm_runtime_get_sync(dev);

> +               /* Allow one integration cycle before allowing a reading */
> +               if (suspended)
> +                       msleep(ltrf216a_int_time_reg[0][0]);

Even if the get_sync() failed?

Also, how do you take care about reference count in the case of failed
get_sync90?

> +       } else {
> +               pm_runtime_mark_last_busy(dev);
> +               ret = pm_runtime_put_autosuspend(dev);
> +       }
> +
> +       return ret;
> +}

...

> +static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan, int *val,
> +                            int *val2, long mask)
> +{
> +       struct ltrf216a_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       mutex_lock(&data->lock);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_PROCESSED:
> +               ret = ltrf216a_get_lux(data);
> +               if (ret < 0)
> +                       break;
> +               *val = ret;
> +               ret = IIO_VAL_INT;
> +               break;
> +       case IIO_CHAN_INFO_INT_TIME:
> +               ret = ltrf216a_get_int_time(data, val, val2);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       mutex_unlock(&data->lock);
> +
> +       return ret;
> +}

You can refactor this function to call mutex lock/unlock as many times
as cases you have and return directly.

...

> +       /* reset sensor, chip fails to respond to this, so ignore any errors */
> +       ltrf216a_reset(indio_dev);
> +
> +       ret = pm_runtime_set_active(&client->dev);
> +       if (ret)
> +               goto error_power_down;

Why do you need to power down here?

> +       pm_runtime_enable(&client->dev);
> +       pm_runtime_set_autosuspend_delay(&client->dev, 5000);
> +       pm_runtime_use_autosuspend(&client->dev);
> +
> +       ltrf216a_set_power_state(data, true);

The below code suggests that you are mixing badly devm_ with non-devm_
APIs, don't do this. You have to group devm_ first followed by
non-devm_ calls.

...

> +static int ltrf216a_remove(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +       iio_device_unregister(indio_dev);
> +       pm_runtime_disable(&client->dev);
> +       pm_runtime_set_suspended(&client->dev);
> +       ltrf216a_disable(indio_dev);
> +
> +       return 0;

I believe the ordering of freeing resources and reverting state is not
in reverse. See above why.

> +}

...

> +static DEFINE_SIMPLE_DEV_PM_OPS(ltrf216a_pm_ops, ltrf216a_runtime_suspend,
> +                               ltrf216a_runtime_resume);

Are you sure you are using proper macro? SIMPLE is for system sleep,
while the function names suggest that this is about runtime PM.

-- 
With Best Regards,
Andy Shevchenko
