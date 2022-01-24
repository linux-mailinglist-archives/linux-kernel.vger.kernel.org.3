Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D12498065
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiAXNFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbiAXNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:05:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC4C06173B;
        Mon, 24 Jan 2022 05:05:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j2so56315654edj.8;
        Mon, 24 Jan 2022 05:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8fBXY9y+B/UZieDYHyV/zX9M9aQLxZf2QHzOhRNlaTw=;
        b=fO6YXCW9cQZT4O6NdbY9KOhQ7JNQmKiD19mgBPU0jgC/PKkLsq3E6fNhZ6MYhyQxkU
         I57gmxucZrSCpK3J+9F/QOO24Cg4d12OiHvn6TxJBr405uMqskx/YUbYC7i4PLE8M2W8
         rpGQ1DRYotr1m+dp7HhOUBMO7mjixxm9EMGLxUKFVzyH8g2ROy5cVnbwl/cX7rK2+YER
         UugygSLh/bem9sW2VaVBdjNoRictd6KsDilKnwdxA7kiunTZtlMPIY53gB45ZaPGFCVG
         xgjkvVCn0turN0sFeEntFXQqJmHxb8bpgoM14Q/DCemR4plNtaxsnqonIIxpR9gkSvDt
         lyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8fBXY9y+B/UZieDYHyV/zX9M9aQLxZf2QHzOhRNlaTw=;
        b=6jjjWgx4StbpCx+1fVyKRUoA6k4kep8YiZdC6/7Yb+rDhlVl+BnAw1+ygKq2T6gKml
         BEZGdeCseQccp8JGOJ/ALv6BT9ufa61zmw3+xJJnRNfd9fWszUgP1te1hj7fQchBBOG6
         w/PrELdev7mzKIa2iAVfQQZF3EZrGfKVIwkAyHxRM6HrlmHeo8wMl02rSUh4NDe7rsEv
         Wpv+UOgzZPpgJh+QJdT+iTpDltUpWMsUvfT6nGcmDkBtS9TvxWUmAlYYr4QTOadrhTDe
         iPSotmuDa7piSKFKl3YpgbYmICyX8ZwgdeAjDl6YG1m3sv0nIfolkBpEhpPDbeIlt/hr
         Bw/g==
X-Gm-Message-State: AOAM530KxbhMHfcyYnOs1muCrhFuuGf8RSuljVL6mPrTOVwPwGMaIB/m
        p1homzgUG8AI/ggt8+ZSyYapI/P5fxE25iJmdUc=
X-Google-Smtp-Source: ABdhPJxdwhP3/+VeTJ6BVnORrG6hptosz2Me/CCmRIbaOE1dxhPeNdcM3Ba8qysZtfm6PI2/fH216CLR4Zukh45PGKQ=
X-Received: by 2002:a05:6402:35d5:: with SMTP id z21mr8623508edc.29.1643029498465;
 Mon, 24 Jan 2022 05:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn> <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 Jan 2022 15:03:18 +0200
Message-ID: <CAHp75VfC7UzKx1i0aTRTZO2REe=PET3turKzH_iuUzWvTJZOtg@mail.gmail.com>
Subject: Re: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation modes.
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:39 AM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> The acceleration scale and the frequency were set via operation modes,
> the scal and frequency are both non-uniqueness,

scale

> this leads to logic confusion for setting scale.and.frequency.
> it getting worse if add more different sensor types into the driver.

It gets
if you add

> The commit add an interface for set and get the operation modes.
> the following interfaces added:

> in_accel_op_mode_available
> in_op_mode

Please indent them by let's say 2 spaces.

> SCA3300 operation modes table:
> | Mode | Full-scale | low pass filter frequency |
> | ---- | ---------- | ------------------------- |
> | 1    | =C2=B1 3 g      | 70 Hz                     |
> | 2    | =C2=B1 6 g      | 70 Hz                     |
> | 3    | =C2=B1 1.5 g    | 70 Hz                     |
> | 4    | =C2=B1 1.5 g    | 10 Hz                     |

...

> +static const char * const sca3300_op_modes[] =3D {
> +       [OP_MOD_1] =3D "1",
> +       [OP_MOD_2] =3D "2",
> +       [OP_MOD_3] =3D "3",

> +       [OP_MOD_4] =3D "4"

+ Comma.

> +};

...

> +       int mode;
> +       int ret;
> +       struct sca3300_data *data =3D iio_priv(indio_dev);

Here and everywhere else, can we keep reversed xmas tree order?

       struct sca3300_data *data =3D iio_priv(indio_dev);
      int mode;
       int ret;

--=20
With Best Regards,
Andy Shevchenko
