Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365047D1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhLVMbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhLVMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:31:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EBC061574;
        Wed, 22 Dec 2021 04:31:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so7946378edd.13;
        Wed, 22 Dec 2021 04:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMaX0lKuQktXxMmVQGtZnLayQj18hwJIeuwONVJilzA=;
        b=LIXl2PrfYHlsCMTGrnSPnrF2khGmFa6QWFs2xOS6TQ50/dA2ozs+4OMkcmHTe1J8wX
         5a9q0lyRYEhMkXUDQLliDBlO9b0L0DSTPhcPhfB/PoTgHB/7wYVQWnyFfkUI1t2/yWTh
         kys316hMl3gKH7elNBJEcjoCbXWDQpcCp127iIESFfxrug4JNNe5B3BFbDUw1tjKlsJ4
         V9WH1DVdsg4wzGEwlElIEwl733C5GiUKNkTzcvxl2bpIcLtzrpcRK7j4e025uJaJXgvW
         fEyIQrRdp538JUW1+M+JwskLMgk8vw1F6T3Bk0yOivo/nOpLZFGV9+cBPIeoWGzEZ2qi
         8s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMaX0lKuQktXxMmVQGtZnLayQj18hwJIeuwONVJilzA=;
        b=y7WNyEqRZKuM9WPMZcPbcWi9LcROBC2mmnHPdEb0waauC5SSB2O5qgP5asTqsqsrfJ
         xxqXbhWcoTlas9hSi2QY0rcDgDo3r3PS1LNRtvgqhld+Vf55nhOCXhjIdg1Qj0Gr5FlI
         kwJHRpFju13JQ0z4hMkIZ5f7BosXelitMR31afZALDZD5zU847K7OTJhZUintfU05a2c
         VjVyQgcjf1MqnWd/CA2lwpDh8KRt6Kej2S3isNJSXMnkRKJ0Y4tYBF0jCIXcuHqRDAKT
         mNhkqGxuueQYybAl6d3IBDQg3M6pDHbehQw2GIURPRHUarsPN3JW/0QxQKSoNQsQBFTY
         Mi7Q==
X-Gm-Message-State: AOAM532Km4g2l7m/+xt1ggqp+VQftSj0BKSNPF+njki8dwj/udgpuCfY
        /ZgyKYKhY9vV/pGiyKrWybeYPITcF+iXuZZzMjI=
X-Google-Smtp-Source: ABdhPJwgEzFk3MKmLFc5X6NQ8Hlrw3kbS+30ebepKmInni5pwQCED/WW8lMfok7figXDcfczJFM3DyE6yf4UPars0rk=
X-Received: by 2002:a05:6402:2315:: with SMTP id l21mr2642915eda.135.1640176262479;
 Wed, 22 Dec 2021 04:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-10-liambeguin@gmail.com>
In-Reply-To: <20211222034646.222189-10-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 14:29:04 +0200
Message-ID: <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com>
Subject: Re: [PATCH v11 09/15] iio: afe: rescale: reduce risk of integer overflow
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
> Reduce the risk of integer overflow by doing the scale calculation on
> a 64-bit integer. Since the rescaling is only performed on *val, reuse
> the IIO_VAL_FRACTIONAL_LOG2 case.

...

> -               tmp = 1 << *val2;

At some point this should be BIT()
Rule of thumb (in accordance with C standard), always use unsigned
value as left operand of the _left_ shift.

> +               if (scale_type == IIO_VAL_FRACTIONAL)
> +                       tmp = *val2;
> +               else
> +                       tmp = 1 << *val2;


-- 
With Best Regards,
Andy Shevchenko
