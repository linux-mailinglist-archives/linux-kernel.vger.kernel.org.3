Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C147D1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbhLVM3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244860AbhLVM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:29:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541FDC061574;
        Wed, 22 Dec 2021 04:29:01 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so9300158edc.0;
        Wed, 22 Dec 2021 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXVh+/KCd78FuQeBsJpAndrv54x5fAs5orWXadX/Xv4=;
        b=C8E4eGtWdT4CwC6+qigGuNKbnk6811BSLwO/QpCp3L69lzGP4Wu2nhoeZaD73SP+ZD
         XqWlvs2Ld5H2WdvrZ4PtdZwRrAoyTwkNx8XCAfLKU2snZYoFRnUedd6fwSR6vwpIcnzE
         Xdo2++1iwFyBMs3qWlSFiAO1jAqKEow0uhtKaKSqAB+iTM6cY+tKj2zGlAe1hcgzkLrl
         nivOwUKXfQYMDzqebf0yeB3E+cMByDDqPNl5DZL4TuXGFnZmafCwa18+TttM5HeJY0JK
         3eDhfkf8qUXuILR85/e3TLPT1jKEMB8bwHrjsFFHEbON7/c2+v2RjPbLPxil/IbGN8CJ
         s4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXVh+/KCd78FuQeBsJpAndrv54x5fAs5orWXadX/Xv4=;
        b=CkkVYAtFiQGGgvV/BC40Wek8xcpgOPyWxf5ybpgPDszBFJIOQBVpXMrDUkosH0KjNB
         /Z1cuICycV+HIsQlJq6GKtCEBtpFyOLF6Thy+4YoItx5wmoCRW1aZy8AHRDLUl732owS
         Q0h9QSgNBu3AMOuiH9U5CvYXDsGwT+EhrwV46/HchnLDzki2gXSEQ4nESkbCp8nCD4A3
         /Y8EctMcN3uW6ItR24uviwfDlEelOhEJJv36xycFnRwYR7eO9EvC6LbSuvakjk2ksCIF
         /aXRdkn9OnPCRQ1Us2dQ2O0LAZUkk6Xz3jW92nMsvHgdHeeXdEBipqVy8rwJUqVc3+++
         NBwA==
X-Gm-Message-State: AOAM531wKtfNxMGJQ4mMdWyegJkA2ItPB0Fk60iqMp2fRcKmNxxD7uEr
        aonT19pl3yudvafPKO7dBQC63+7FqKv+22yp83E=
X-Google-Smtp-Source: ABdhPJwUMRXKueFOj0yXX+rc1dekQSXG0gxC90penDiQclzAdgZIUtmZBajexd5RBV7Glqz3kgT8B/J0HRKN5bJ1osI=
X-Received: by 2002:a17:906:ced9:: with SMTP id si25mr2418305ejb.77.1640176139942;
 Wed, 22 Dec 2021 04:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-9-liambeguin@gmail.com>
In-Reply-To: <20211222034646.222189-9-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 14:27:01 +0200
Message-ID: <CAHp75VdonriGKBQz=pnJboPZ=HPfuYSakEGCorBath5iBxfX_Q@mail.gmail.com>
Subject: Re: [PATCH v11 08/15] iio: afe: rescale: fix accuracy for small
 fractional scales
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> The approximation caused by integer divisions can be costly on smaller
> scale values since the decimal part is significant compared to the
> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> cases to maintain accuracy.

...

> -               tmp = div_s64(tmp, 1000000000LL);
> +
> +               tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>                 *val = tmp;

> -               return scale_type;
> +

It seems you may add this blank line to one of the previous patches, may you?

> +               if (!rem)
> +                       return scale_type;

-- 
With Best Regards,
Andy Shevchenko
