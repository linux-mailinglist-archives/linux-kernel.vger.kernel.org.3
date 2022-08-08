Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A558C516
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiHHIx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiHHIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:53:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8352D11471;
        Mon,  8 Aug 2022 01:53:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s2so6002463qtx.6;
        Mon, 08 Aug 2022 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=06U8E+kkdcGYHatHElwJVouvOAddvHNck0H9FBHDuRM=;
        b=cVNY3ibkN6rkAC6vUeiJw+Wz4hBi1SAlgYndgWeTy7IRaMSpSj7dW4Hc4LZGDlyzEL
         9PJdwUK3ir7hkZwrBE1BYCu/QT5EcnECF1xgblRESMpFJ6yGDdZAZIfzsUfUUqW+vsGP
         JozX+u2h9rVyrfiT9rGTBp8Bl4abqGpRd688nJdh6Cd8FXfw+YOIa4VgbE++stO2s9+9
         4cUpafXRx3pabUygbe9v+TCg3m9PJM5vxBkLh5rpYvQggbo9l48o3WNT123xH9ee+oXT
         gYHa2sIqWORuizyGnYKYJ1vV1+AJWgmqyVDiV3nbrAOQXOX5lOKEGzEFRCGLy+FQQxV4
         ygzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=06U8E+kkdcGYHatHElwJVouvOAddvHNck0H9FBHDuRM=;
        b=sObTUnR742IEG8oGJSHZ8Qb3O01qeNvmeJrRffmgOFF5YDF40NOZCigBXEzlK0swmE
         NuKfvcHIZT5E2wwgIQKK+eLIJOMzPr+kakIt8/5zCvXVe1ep6kiJYUH5sghNYGLWuzV5
         vB790KC5drBrlQL64eE8MGYb20Yo6gA0KtSIFHq8xyjJdW/jIdmskJqn1gn4TfKIQNEB
         3i6j5ae+LFUjv4JWw2C2R10QoOhdYjRh3U0vhN1VWvOUhl2AbCOyVyidCfMBok4cQ//4
         ZKAM9sYo/CcT1uhUlpceFXr1VUNP+8hR93dPiKYNA8IjBS8qUg2GqwXr6tV0WEmHUBLa
         NRhQ==
X-Gm-Message-State: ACgBeo2bYbZoaanGpoGh+Cz3MR3kmfaN2gEIvSo6kwGmyrj0Bphob+E0
        S3bUJJD4eNJz6UworgyPlmeWeO7t/AmwqsMLIG+FpnCbVcg=
X-Google-Smtp-Source: AA6agR51GQFFuSSU9o+i/AhpVSNAnz90fs6SKyV+R/YBLIGJoACP5q0PpZpJUfmsq10ffbMgRSrmX+tO85pJ6ViVv2A=
X-Received: by 2002:a05:622a:1105:b0:342:fb95:d7a with SMTP id
 e5-20020a05622a110500b00342fb950d7amr1856144qty.61.1659948832601; Mon, 08 Aug
 2022 01:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659872590.git.ang.iglesiasg@gmail.com> <49086f5c1401d7d28ebf921a67b49f8403ddb16a.1659872590.git.ang.iglesiasg@gmail.com>
In-Reply-To: <49086f5c1401d7d28ebf921a67b49f8403ddb16a.1659872590.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 10:53:16 +0200
Message-ID: <CAHp75Vfanb+tZe_D5_hPWn2BrOEkds9i7AZzD5Xc1M5a9GK6qg@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] iio: pressure: bmp280: Fix alignment for DMA safety
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Aug 7, 2022 at 1:56 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Adds DMA-safe buffers to driver data struct to store raw data from sensors
>
> The multiple buffers used thorough the driver share the same memory
> allocated as part of the device data instance. The union containing
> the buffers is aligned to allow safe usage with DMA operations, such
> as regmap bulk read calls.

...

>  #include <linux/completion.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>

+ Blank line.

> +#include <asm/unaligned.h>

...

> +       union {
> +               /* sensor data buffer */
> +               u8 data[3];
> +               /* calibration data buffers */
> +               __le16 bmp280_cal[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> +               __be16 bmp180_cal[BMP180_REG_CALIB_COUNT / 2];
> +       } buf __aligned(IIO_DMA_MINALIGN);

Hmm... And which field in the struct defines which of the buffers is being used?
Also, do you need a non-anonymous union?

>  };

...

> +       /* parse temperature calibration data */

Be consistent! Check all your patches for the consistency (comments,
other code style, etc).

...

> +       calib->H5 = sign_extend32(((get_unaligned_le16(data->buf.data) >> 4) & 0xfff), 11);

(It's not directly related to this change, but good to ask)
Are you going to change all those masks to use GENMASK()?

...

> +       struct bmp180_calib *calib = &data->calib.bmp180;
>         int ret;
>         int i;
> -       struct bmp180_calib *calib = &data->calib.bmp180;

Exactly my point given the previous patch, now you have a ping-pong
style of changes: the introduced line in the series is being touched
again in the very same series without any need.

...

>         u8 oss = data->oversampling_press;
> +       int ret;

Ditto.

-- 
With Best Regards,
Andy Shevchenko
