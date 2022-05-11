Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE752328F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbiEKMFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiEKMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:05:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847752457B9;
        Wed, 11 May 2022 05:05:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks9so3624986ejb.2;
        Wed, 11 May 2022 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRZONrGo4m4Zm2BqEddQgsDFQo2tMgIMWJHr5BUt6uo=;
        b=HTw8xfh98P0wFyCqbCo+SYlgB3C2HguxWqDe64GMHYYWUFCmjLFjjqRQbJ3rOCF4db
         lhhSmr/k+HNBqpLnb1Fjvc4jFhvDw0b6Dd1Ir9eW3mWzlpUtbhjzsRaxivkZeUXP4EEo
         hA/WgSUN69y77Cq6YOYx6k2H9fzROtOCroCxqvxh9GP/yFpuLQalN2jwH4Hu0Hzcr4nF
         U5/wVcSQwMCckyvRFw/s+NUMc7PxSUA8TqBjtv9HB4cNUuSe+YzVHn0pr0rN+1sMe0sA
         4TQSb6CnM+39U5ad/FJhoO4dd+YSeVxLRBsIGrN4yD7TnJH3ZBaTB3wCRuPLECyGJpxB
         FGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRZONrGo4m4Zm2BqEddQgsDFQo2tMgIMWJHr5BUt6uo=;
        b=uRnFsYdu2UECuSbBy5dDQTWRWDbVeXNBfpDhxuvvjG9kA9XJUKfiJqDwYiuTyc6N/8
         +5uhz7VK9c4q847XyAPgZP42cRkdqNi6+jfsdHdJuaKqgsvy+U6Hmuo2Sk8memNNOq3w
         JzEiPQ53UzlC8kZ7GIfaIFthWR7P6mI0IwRWTFiovEosD8A8rymcxqNezMbKEFpN38gt
         HndvPIvmIrqAZyxcpsRRtWWbhDwWbeTbGZFx1hN/WDeS/35dV+c0/vNq/Cg6qN8xkPTI
         BzPQnZXLvhc4dSowg6egt5D/ulTenxG0ET8eVMMcym5MbjPslJTl86YOHACXZSaf6Cph
         lnjQ==
X-Gm-Message-State: AOAM533Oy/Xii7sPXXIG2tC5oYx6neAgi450u/CeFPLfOm6MnD336s++
        67I4ORzHJlcMduGS7v5qcsoDaotuKAL7uTP0KxM=
X-Google-Smtp-Source: ABdhPJzd1HUuROh8FWEqtZFE3BJGucDjSyp7qGUusUQZeLxhSifLp1o9HdqKMMpaz9LsFZesf2zKVx2JcxMlzEeF06w=
X-Received: by 2002:a17:907:3e8c:b0:6f4:4fdb:6f24 with SMTP id
 hs12-20020a1709073e8c00b006f44fdb6f24mr24271617ejc.44.1652270726904; Wed, 11
 May 2022 05:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220511094024.175994-1-shreeya.patel@collabora.com> <20220511094024.175994-4-shreeya.patel@collabora.com>
In-Reply-To: <20220511094024.175994-4-shreeya.patel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 14:04:50 +0200
Message-ID: <CAHp75VdfCh0nTc1cYZYxKmvYPfUMg8W4-KREu5RisP=cGykg+Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 1:11 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>
> Add initial support for ltrf216a ambient light sensor.

> Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf

What is the protocol? https? git? ssh?

...

> +obj-$(CONFIG_LTRF216A)         += ltrf216a.o

I believe alphabetically it goes after the below one.

>  obj-$(CONFIG_LTR501)           += ltr501.o

...

> +#include <linux/bitfield.h>

+ bits.h

...

> +static const int ltrf216a_int_time_available[5][2] = {

You may drop 5 here and below, correct?

> +       {0, 400000},
> +       {0, 200000},
> +       {0, 100000},
> +       {0, 50000},
> +       {0, 25000},
> +};

...

> +/* open air. need to update based on TP transmission rate. */

I didn't get the small letters in conjunction with the period in the
middle of the phrase. Can you update grammar or spell the shortened
form of "air." fully?

> +#define WIN_FAC        1

Can it be namespaced?

...

> +static const struct iio_chan_spec ltrf216a_channels[] = {
> +       {
> +               .type = IIO_LIGHT,
> +               .info_mask_separate =
> +                       BIT(IIO_CHAN_INFO_PROCESSED) |
> +                       BIT(IIO_CHAN_INFO_INT_TIME),
> +               .info_mask_separate_available =
> +                       BIT(IIO_CHAN_INFO_INT_TIME),
> +       }

+ Comma.

> +};

...

> +static int ltrf216a_set_int_time(struct ltrf216a_data *data, int itime)
> +{
> +       int i, ret, index = -1;

Redundant assignment, and actually not needed variable 'index', see below.

> +       u8 reg_val;
> +
> +       for (i = 0; i < ARRAY_SIZE(ltrf216a_int_time_available); i++) {
> +               if (ltrf216a_int_time_available[i][1] == itime) {
> +                       index = i;
> +                       break;
> +               }

if (...)
  break;

> +       }

> +

You can drop this blank line in order to show the tough connection
between for-loop and if-cond.

> +       if (index < 0)
> +               return -EINVAL;

if (i == ARRAY_SIZE(...))
  return ...

And use i here, which actually can be typed as unsigned int above.

> +       reg_val = ltrf216a_int_time_reg[index][1];
> +       data->int_time_fac = ltrf216a_int_time_reg[index][0];
> +
> +       ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RES, reg_val);
> +       if (ret < 0)
> +               return ret;
> +
> +       data->int_time = itime;
> +
> +       return 0;
> +}

...

> +static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
> +{
> +       int ret = -1, tries = 25;

No need to assign ret. And please avoid assigning returned values to
some negative values that may be misinterpreted as error codes.

> +       u8 buf[3];
> +
> +       while (tries--) {
> +               ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_STATUS);
> +               if (ret < 0)
> +                       return ret;
> +               if (ret & LTRF216A_ALS_DATA_STATUS)
> +                       break;
> +               msleep(20);
> +       }

NIH of a macro from iopoll.h. Use the appropriate one.

> +       ret = i2c_smbus_read_i2c_block_data(data->client, addr, sizeof(buf), buf);
> +       if (ret < 0)
> +               return ret;
> +
> +       return get_unaligned_le24(&buf[0]);
> +}

...

> +       greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +       cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);
> +
> +       if (greendata < 0 || cleardata < 0)

> +               return -EINVAL;

I am expecting that each of them may contain the actual error code,
so, please decouple the condition and return the actual error codes.

...

> +       switch (mask) {
> +       case IIO_CHAN_INFO_PROCESSED:
> +               ret = ltrf216a_get_lux(data);
> +               if (ret < 0) {

> +                       mutex_unlock(&data->mutex);
> +                       return ret;

Wouldn't 'break' suffice?

> +               }
> +               *val = ret;
> +               ret = IIO_VAL_INT;
> +               break;
> +       case IIO_CHAN_INFO_INT_TIME:
> +               ret = ltrf216a_get_int_time(data, val, val2);
> +               break;
> +       default:
> +               ret = -EINVAL;

Missed break;.

> +       }
> +
> +       mutex_unlock(&data->mutex);
> +
> +       return ret;

...

> +       ret = ltrf216a_init(indio_dev);
> +       if (ret < 0)
> +               return dev_err_probe(&client->dev, ret,
> +                                    "ltrf216a chip init failed\n");

One line? Esp. if you create a temporary variable to hold a device pointer.

...

> +       ret = devm_add_action_or_reset(&client->dev, als_ltrf216a_disable,
> +                                      indio_dev);

Ditto.

> +       if (ret < 0)
> +               return ret;

...

> +static struct i2c_driver ltrf216a_driver = {
> +       .driver = {
> +               .name = LTRF216A_DRV_NAME,
> +               .pm = pm_sleep_ptr(&ltrf216a_pm_ops),
> +               .of_match_table = ltrf216a_of_match,
> +       },
> +       .probe_new      = ltrf216a_probe,
> +       .id_table       = ltrf216a_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(ltrf216a_driver);

-- 
With Best Regards,
Andy Shevchenko
