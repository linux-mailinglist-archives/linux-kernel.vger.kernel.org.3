Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80DE590E91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiHLKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiHLKAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:00:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E9CAB192;
        Fri, 12 Aug 2022 02:59:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso4087470wma.2;
        Fri, 12 Aug 2022 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=w7HHUsthlvCaPPfev+PgO7rPSOqE/STKD8LCTzXfXdg=;
        b=qs8Um/HJuvzMCKW9FaZZZqWYFmMMAVtxtBtkQ0CyzRjeJfeBnByAsI3eDVTAFNwSez
         /hUIyU2jjjaiHibv96+iNd+9h7JX+q50yvAvLn5xKuenMILaEgWSYYy2lWEUY1dfUWWR
         BMJDeVKM71EFaM1BJb9+bJUV8O6C9K01yPog7wF96rbuHfVwCvYDkV/PCa6ocwAy9oY3
         8Jjd55vqV161v58xCSFJIYWC2PGvs8iQQTIS0Zf8CqFVPbZnxPnBVTqvOZn11Ab400FJ
         Wma27gZrh5LJP+G9OhCIiED0A6POKhF7TyolR/hjcyjrnCPq8LRTim5Ni31reKx9z79x
         Oezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=w7HHUsthlvCaPPfev+PgO7rPSOqE/STKD8LCTzXfXdg=;
        b=EXH/dDsOpI7aoNSFSBC8Ou3yCXnuJeljkotl3efY03laCEbNrZrb9upNy9am3pdl74
         cMmDxLCMWSxPK28eajNUKtgQrROrLEQDzOajrJC9idbKGdOfhAI/kg4FRo8KA9tkdhfy
         oSPlw2p3GNQOBPGg3FwMrxQ4xMgeThrG44SDDfwp8Y8+W4YmpttothMlZ63e6Q3QRU8o
         CvIpzpa+HRPXNBUkQ/z/2mECvR21n07i5MBKfHt03kvr0gts3fzmlZT6GduRbmqjkphW
         /+Vmm+m7/Y9O5grDD5izyQxFar8AcDBZMFVLLtspqYouXBTzlQGROcIyf+KOgZryd+K+
         h5gQ==
X-Gm-Message-State: ACgBeo3iNLkJ8cBwgOXjLje6qdzXvFJKLoIt43zqPhL0h+A4/YxxvSdI
        7wXDOZGZfPolKqfMY8EXxvw=
X-Google-Smtp-Source: AA6agR7EVPMbY4w98zQXZKJMK+nGDjEgy4GvGudWKn6/5cFxJ6fNTcXjLRSJQuzx+My+CNzAe6eNBw==
X-Received: by 2002:a7b:cb0c:0:b0:3a3:2a38:5066 with SMTP id u12-20020a7bcb0c000000b003a32a385066mr2141026wmj.74.1660298392563;
        Fri, 12 Aug 2022 02:59:52 -0700 (PDT)
Received: from [192.168.90.166] (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6849000000b0021eb309c97dsm1557041wrw.25.2022.08.12.02.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 02:59:51 -0700 (PDT)
Message-ID: <ba71ba74e9115bebce82a2afbd5d62a2e4ecf666.camel@gmail.com>
Subject: Re: [PATCH v5 2/5] iio: pressure: bmp280: Fix alignment for DMA
 safety
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Aug 2022 11:59:50 +0200
In-Reply-To: <CAHp75Vfanb+tZe_D5_hPWn2BrOEkds9i7AZzD5Xc1M5a9GK6qg@mail.gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
         <49086f5c1401d7d28ebf921a67b49f8403ddb16a.1659872590.git.ang.iglesiasg@gmail.com>
         <CAHp75Vfanb+tZe_D5_hPWn2BrOEkds9i7AZzD5Xc1M5a9GK6qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun, 2022-08-08 at 10:53 +0200, Andy Shevchenko wrote:
> On Sun, Aug 7, 2022 at 1:56 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> > 
> > Adds DMA-safe buffers to driver data struct to store raw data from sensors
> > 
> > The multiple buffers used thorough the driver share the same memory
> > allocated as part of the device data instance. The union containing
> > the buffers is aligned to allow safe usage with DMA operations, such
> > as regmap bulk read calls.
> 
> ...
> 
> >  #include <linux/completion.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/random.h>
> 
> + Blank line.
> 
> > +#include <asm/unaligned.h>
> 
> ...
> 
> > +       union {
> > +               /* sensor data buffer */
> > +               u8 data[3];
> > +               /* calibration data buffers */
> > +               __le16 bmp280_cal[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> > +               __be16 bmp180_cal[BMP180_REG_CALIB_COUNT / 2];
> > +       } buf __aligned(IIO_DMA_MINALIGN);
> 
> Hmm... And which field in the struct defines which of the buffers is being
> used?

There's no concurrent use of the buffers. Calibration data is read during the
initialization of the sensor. The data buffer is then used to store the raw data
read from the measurement regs, and is also used a few times to read a the humid
calibration on BME280, but again, in a sequential, non concurrent manner.

Regarding which calibration buffer is used, is the same situation as the
calibration data union, helper functions and callback for the sensor use the
buffer reserved for the sensor. I don't know if this is the best approach, I
just followed what I saw previously on this drivers and others from IIO
subsystem.

> Also, do you need a non-anonymous union?

No I could use an anonymous function. Should I change it to an anonymous union?

> >  };
> 
> ...
> 
> > +       /* parse temperature calibration data */
> 
> Be consistent! Check all your patches for the consistency (comments,
> other code style, etc).
> 
> ...
> 
> > +       calib->H5 = sign_extend32(((get_unaligned_le16(data->buf.data) >> 4)
> > & 0xfff), 11);
> 
> (It's not directly related to this change, but good to ask)
> Are you going to change all those masks to use GENMASK()?

I thought I made sense refresh previous code on the driver to use GENMASK() and
FIELD_PREP and FIELD_GET helpers to use the same standards on the BMP380
codepath. Having in mind other feedback you gave me on this iteration, this
GENMASK() and FIELD_PREP/FIELD_GET changes make more sense in a prerequisite
patch and not as part of patch 1.

> ...
> 
> > +       struct bmp180_calib *calib = &data->calib.bmp180;
> >         int ret;
> >         int i;
> > -       struct bmp180_calib *calib = &data->calib.bmp180;
> 
> Exactly my point given the previous patch, now you have a ping-pong
> style of changes: the introduced line in the series is being touched
> again in the very same series without any need.

Yup, apologies. I'll be more careful

> ...
> 
> >         u8 oss = data->oversampling_press;
> > +       int ret;
> 
> Ditto.
> 

