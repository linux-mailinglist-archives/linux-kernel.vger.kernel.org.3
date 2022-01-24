Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB331498085
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242833AbiAXNKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbiAXNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:10:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A00C06173B;
        Mon, 24 Jan 2022 05:10:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id n10so40877673edv.2;
        Mon, 24 Jan 2022 05:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ii7ywF9YTsgxUZ8BJSe/h1Y/FMQ0hLAIMS3wBsXZ6bo=;
        b=R5E5QxUdxVK/9Ca7x/MyQKlnBzZR2twm8WE1Hwg3LmAsOJajNi2N2qz9uNhn2PJcHS
         lTchITPR7duzj6dUDvDVOMeEcxNM7y1e5EaCWWwA91nfqWnDRZLZwYUPOfoIJ1Wd++ex
         cjyL6Mnp4H3ncuHCh9Sy2C3ptIrgKZRgeH9nwX7AAiBMja6c6T2sYuR6nHJg2pXlrj9L
         aWWNIXFtbR+ymuyIBfwl3qmFCT0JInIizWJWyqk8HVnH++9jWCXX+8mCBJGFyB6Dq0Lv
         Cl7lp/FLzio/bXGyp5UwJ2GW00mZ+LeM5TQymlWlxZecWBozLDGXOK95E0pLM9gFAxPg
         StEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ii7ywF9YTsgxUZ8BJSe/h1Y/FMQ0hLAIMS3wBsXZ6bo=;
        b=I2wsCVDP/lX4m7TIaZ5rYzY2CQtQTXxKZR3zFY5FyI++GaeulcFRPZLPjZZ2B1iQnH
         IU7sfTzRZoEjpLgH3q0XVADW4L7BYSJA4NsGCR3RaxuWlwkgmHdyi4X4Y0QtLtDHdM3s
         bU/bbIxFmLe+qXmUiBmHZnvSIbdmfdWWwPekLIt3nO3AZ5Dz5rCTdtDTh9q+vKnaccrq
         AzsolWHtp8IJ4UQxkK1o7C/qyTcxq5/4gW0Dqe+rn+6elOqa6ucNOam8TqewRrivsV5F
         PuH0HzaOgPSlaDUY3uofKOk4E+2ECRhCspFDYRATgkfxZQgUZIvG7T7T09Cb7d/u13DV
         G02Q==
X-Gm-Message-State: AOAM531bwub5Pwx2mkieCbA5m+27wK8dB4m0fVX4+TW5CqJd0T2/ixxV
        V8DBqE8PO3kLRQN1lE9SAH1V/PpjGySqHb5SgrBM+zJDiTHr2u2r
X-Google-Smtp-Source: ABdhPJxe9gG7GmwLNzIqUqnXptTYfVi++yYk4b57rKeuLa9kbpKKL1Tf4IIP/DKbUVTsBkAnMFS9uv8bHhvRrk63vI8=
X-Received: by 2002:aa7:c0c9:: with SMTP id j9mr15579423edp.270.1643029837684;
 Mon, 24 Jan 2022 05:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn> <20220124093912.2429190-4-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220124093912.2429190-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Jan 2022 15:08:57 +0200
Message-ID: <CAHp75VdgcB-U3+H0=R3s7xRP6nQKu+iGKaa2pV4QsGjrrfVpgg@mail.gmail.com>
Subject: Re: [PATCH V1 3/6] iio: accel: sca3300: modified to support multi chips
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:39 AM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> The drive support sca3300 only,there are some other similar chips,
> for instance, SCL3300.
> modified the driver to read the device id,
> add the tables for the corresponding id to support multiple chips.

...

>  /* Device return status and mask */
>  #define SCA3300_VALUE_RS_ERROR 0x3
>  #define SCA3300_MASK_RS_STATUS GENMASK(1, 0)
> +
>  enum sca3300_op_mode_indexes {
>         OP_MOD_1 = 0,
>         OP_MOD_2,

Stray change ?

...

> +struct sca3300_chip_info {
> +       enum sca3300_chip_type chip_type;
> +       const char *name;

> +       u8 chip_id;
> +       const struct iio_chan_spec *channels;
> +       int num_channels;

Ordering these as

       const struct iio_chan_spec *channels;
       int num_channels;
       u8 chip_id;

will save 4 bytes in some cases.

> +       unsigned long scan_masks;
> +};

...

>                 }
>                 return -EINVAL;
> -
>         case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>                 ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);

Another stray change?

...

>         int value = 0;
>         int ret;
> +       int i = 0;

Reversed xmas tree order?

...

>          * Wait 15ms for settling of signal paths.
>          */
>         usleep_range(16e3, 50e3);
> -

Leave this blank line, so you will have a better reading of the code
and comment.

> +       for (i = 0; i < ARRAY_SIZE(sca3300_chip_info_tbl); i++) {
> +               ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
> +               if (ret)
> +                       return ret;

> +               if (sca3300_chip_info_tbl[i].chip_id == value) {

> +                       sca_data->chip_info = &sca3300_chip_info_tbl[i];
> +                       indio_dev->name = sca3300_chip_info_tbl[i].name;
> +                       indio_dev->channels = sca3300_chip_info_tbl[i].channels;
> +                       indio_dev->num_channels = sca3300_chip_info_tbl[i].num_channels;
> +                       indio_dev->modes = INDIO_DIRECT_MODE;
> +                       indio_dev->available_scan_masks = sca3300_chip_info_tbl[i].scan_masks;

You may do it after the below check. Thus here

               if (sca3300_chip_info_tbl[i].chip_id == value)
                       break;

> +                       break;
> +               }
> +       }
> +       if (i == ARRAY_SIZE(sca3300_chip_info_tbl)) {
> +               dev_err(&sca_data->spi->dev, "Invalid chip %x\n", value);
>                 return -ENODEV;
>         }
>         return 0;

...

>         indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sca_data));
>         if (!indio_dev)
>                 return -ENOMEM;
> -
>         sca_data = iio_priv(indio_dev);
>         mutex_init(&sca_data->lock);

Stray change for sure.

...

>         indio_dev->info = &sca3300_info;
> -       indio_dev->name = SCA3300_ALIAS;
> -       indio_dev->modes = INDIO_DIRECT_MODE;
> -       indio_dev->channels = sca3300_channels;
> -       indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
> -       indio_dev->available_scan_masks = sca3300_scan_masks;

> +

Ditto.

>
>         ret = sca3300_init(sca_data, indio_dev);

-- 
With Best Regards,
Andy Shevchenko
