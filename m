Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0657DB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiGVHSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiGVHRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:17:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1346370
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:17:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m8so4774538edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4Hy5WgIDA8MDhrVZeCSzDh9bIrR7DewLXi+Th66sO4=;
        b=VdeANNwCgjhfUld5l1Pc3g0E7LeDnDhLCBfGR0v3Hvw1QqvbErcHV/IeKhh/V4uswb
         98nwmgJN175BsxWhBi6zmb0TJT8/E0Dqa6IDfMy1ZU2Q1hXEB0HvVlYb1HyU7ILlDpSg
         O9E2qDzXKgJGNP5WaZ9Ztx/HkaX5VVyKjQB4PI0+PyzUlGpoHoel9TnSHg93LW23eWqy
         iXHzA7n5W3kbfr+kpR19mf4HAS2uPZ/U9rBYQOf/nFNkM2zoUtM2PlD8JbG2yDU5J3Lm
         Uq3Q+C5tO4doplog5qpcyoJFO/xPFtF5B2NIHz+pBhYzKuK2XuhNRZkev/nSSy8XB6LN
         +LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4Hy5WgIDA8MDhrVZeCSzDh9bIrR7DewLXi+Th66sO4=;
        b=LnL4AaNRCiJgvVE4BcuNNdPnKf4GAEw0LF3rnna9bgQm/vusS0Wjqg6jogxyl5Ytfl
         wl4zejUDzy96XRjIgTlq2PkuWhD+YfZxMkipZpW6oAPQ4P8HjXAdabM7sHKDtP7Nk3fP
         sGAfkrYuDIb+hu6SdHNpTWwu0IVWWTP+9JvgE0PWB7H3InMIdAVBKHT1xxLzZrnRY7Iz
         H1D1E5W0HH5xF6Xq584BHM0Xn5PCQPscBGXHxNj1l3OoLB4wxCdn8NDXkFNCVA+u2Z7g
         mNulzy2GZ7Qv6IoXmEzEBu4pClKkg4b/HwaajfNgCCjKFEPPrs5F1s864Ak/pick/awO
         O9NQ==
X-Gm-Message-State: AJIora+49Heynqk/d06CkA13ltKvf6mMQznijbm+U3OWzBqd2xJcMdeQ
        33UoLB0bpiCBH/Pz+pp8PlhFtsf9YbQFQ+ppdaThkA==
X-Google-Smtp-Source: AGRyM1uvxQhLbdSsrYRIkBBgMe5Qn2G5+7VHHnmOdmo9zB5hNuUqbyaX4qH2arEh1pgjXjdOWeiXYi8MgYTaYN3DdhQ=
X-Received: by 2002:a05:6402:26d6:b0:43a:daa5:9f12 with SMTP id
 x22-20020a05640226d600b0043adaa59f12mr2038424edd.408.1658474263288; Fri, 22
 Jul 2022 00:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220721073909.23318-1-srinivas.neeli@xilinx.com>
In-Reply-To: <20220721073909.23318-1-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Jul 2022 09:17:32 +0200
Message-ID: <CAMRc=Mefhk4i8_1j2=JO63SwfHEb3TrRMj45+CC1i1DUr8VULw@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-xilinx: Fix integer overflow
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        neelisrinivas18@gmail.com, shubhrajyoti.datta@xilinx.com,
        srinivas.neeli@amd.com, sgoud@xilinx.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 9:39 AM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:
>
> Current implementation is not able to configure more than 32 pins
> due to incorrect data type. So type casting with unsigned long
> to avoid it.
>
> Fixes: 02b3f84d9080 ("xilinx: Switch to use bitmap APIs")
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
>  drivers/gpio/gpio-xilinx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index b6d3a57e27ed..7f8e2fed2988 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -99,7 +99,7 @@ static inline void xgpio_set_value32(unsigned long *map, int bit, u32 v)
>         const unsigned long offset = (bit % BITS_PER_LONG) & BIT(5);
>
>         map[index] &= ~(0xFFFFFFFFul << offset);
> -       map[index] |= v << offset;
> +       map[index] |= (unsigned long)v << offset;
>  }
>
>  static inline int xgpio_regoffset(struct xgpio_instance *chip, int ch)
> --
> 2.17.1
>

Applied, thanks!

Bart
