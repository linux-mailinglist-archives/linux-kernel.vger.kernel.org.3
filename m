Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FDD47CFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhLVKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbhLVKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:21:39 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F2C061574;
        Wed, 22 Dec 2021 02:21:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w16so6602123edc.11;
        Wed, 22 Dec 2021 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TU7dyJKQKtUa7Bp992pXfOwL0ZeVphvql4VDb9W1uSE=;
        b=SCwI4pttJkVZfAaYOFBQTFCh9jhK4Le26UvobhIjJsqDrdonlYFwSwOMIimkKd/R1z
         mdk/5wsw+IaUIzNPQGMTQ+XPRHwprMcWxWYEAoPWH68XaRgwSRLJ7Wjzn5TQNhGY7QZi
         GoSPR2bqv4Z9dDNWkZXhq9MzEs7aIkwUsDJXU8o+ucThFyA2aXQKZlv/uDw4vjDbWCP+
         LWwqk3gugDPJoihlT4xy6joCOtPF8bCiYjX8qvONLhmsGnOKlHqtK+t4I+/fEXUSyph7
         oSB75AYAd5TG0SRzGVkPC55wdQ13W9Gdsan+TDbm1V5cykis8pjK+Kl/eC6QDtM0lJrg
         cr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU7dyJKQKtUa7Bp992pXfOwL0ZeVphvql4VDb9W1uSE=;
        b=OaJwzFt2+To/rWsjdq1qxsJHyiIEcYx9WaXasSGcSRRyUTTHLupJ0YooBj7vpKYn0N
         I29B0D7uipBzB9q3BJDVlb3045htkG3jI1xCO4d2VeF3pcO4gKS0QF4TP5cwVph4pAsq
         NfcvU8Ri+ZFT0InCeAMLWtd9xW9X+p/KpWEnQ192UXO49cnOB+cOIadNU0AKLGsmGNAn
         8Pylkd3uP/A8WwIhbt1nwCw3l0tz84hBU/BQ1IO+dI3suhm4YkK4EB2u0YZPTu0t4lOF
         yIT4z2Bkqy7GlCfH4kdvZxFocTlOVjDOTtSxq/3Wr0/P4ZfNXN9JG5YLhEAbu1FxsFln
         4EEw==
X-Gm-Message-State: AOAM533r9bzrLECk3uVjFSHCAIK85qdbXZzUke+YrwQROXBcUzFLg1Oy
        IOVJUjOnviyKaKA6uDRD1aoVpJruMULbCvYbOa9+wIzFyGD+lA==
X-Google-Smtp-Source: ABdhPJyhZIjLhbrjZZCaoOxbVuoWLmJbZAnmJRjj4wvpf/lS3YOi45QDeSykT7cyVLSPJKuIhSWkbWt3De4HN6hyx1g=
X-Received: by 2002:aa7:cd75:: with SMTP id ca21mr2204212edb.242.1640168497416;
 Wed, 22 Dec 2021 02:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-5-liambeguin@gmail.com>
In-Reply-To: <20211222034646.222189-5-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 12:21:01 +0200
Message-ID: <CAHp75Vc009o5EunYP3QAB8up8hMrRL7oNax7cjphCFVUgSKXRw@mail.gmail.com>
Subject: Re: [PATCH v11 04/15] iio: afe: rescale: expose scale processing function
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

On Wed, Dec 22, 2021 at 5:46 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> In preparation for the addition of kunit tests, expose the logic
> responsible for combining channel scales.

...

>  #include <linux/gcd.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/afe/rescale.h>

It should go before the consumer.h, no?

And I would rather move the entire IIO group of headers...

>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>

... somewhere here (with blank line above).

>
> -struct rescale;

...

> +#ifndef __IIO_RESCALE_H__
> +#define __IIO_RESCALE_H__
> +
> +#include <linux/iio/iio.h>

Missed types.h and forward declarations like
struct device;

-- 
With Best Regards,
Andy Shevchenko
