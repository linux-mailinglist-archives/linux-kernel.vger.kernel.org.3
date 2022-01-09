Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B174C488936
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiAIMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiAIMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:08:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D091EC06173F;
        Sun,  9 Jan 2022 04:08:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q25so33574706edb.2;
        Sun, 09 Jan 2022 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfLVhNm5XSK49l/x3EdeulrRe8mQSBcMZtSRNuQH4ho=;
        b=pvp4XRYyP+cuYhxbH/tLr5RyKE1XxktRJ4YZi8rkI75C7zQkJNi709KHKhqZfu7k6H
         SCDJvq8t5qEqN8J5YG7Pl5SbT5bR9PFm1lSzB2JX5R5DkGJiHFil5/aXeRYzVxMPdLJR
         Mgn58j9gySWGpy9fyOWnW0M/sAC+Vq9Ruuy9rE2qv1nCVm4j3cwR34salAZPs6gWuT7e
         4nPVjsixDnfJ0CoZpfSOS5QMAF/xxfFkCCTz+LyKoEcRR3kacBBzK+mzCR85P/NvoX7/
         iAnZDbDDMaIxXZJebVrzxDDRRMiCePHOX9WhdtyLol4Fi2isjTueGV1rB4ZL3EXHHsAG
         8z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfLVhNm5XSK49l/x3EdeulrRe8mQSBcMZtSRNuQH4ho=;
        b=PkVOPAbz94nfbpKbIU3/DtowZK8Yt/ZzsojLcT2pMIz6gtkh/Hu1w5yaBmKxlsVU6q
         vd3Uqc8zJFQmdy+mshPrkMgr1sj8ZUlPbfmSnBt6nwjwRqzekv13802EyHbAreErT6vH
         sm7zJc8trYc9HuHrB8PbULEgsofuAd5Td/OZcSn1qz4KViplu/kAN2OyU3qFDHM9ylYS
         B5L+odmVKJ7Vwijsxnma+CfNyPRLFxlW/YAKJ7RGLumR992VCYj9lzMNOzR4UmqMDu5l
         q0qSKmTkFcMZMMyYAN7DEX3ahWhUUlPpMnnr3TyU0V3R70KvwZ9LXUxHT+ZqAqvmxjLR
         Qa2w==
X-Gm-Message-State: AOAM5323mnb8VJaxtJkVLFiGVVi2lnKHzDRWT0JZx0XbbTZHzICMdpPe
        UU0TDApHB3+AmNJTHE60mqmE9N9NBzK84vrcSI0=
X-Google-Smtp-Source: ABdhPJxlHIbIVq4/v2ncp/jn/sZYMFqkCbluA7awGCEsROML31+Tf7qc1NGW1VKTqin/yuemutomSVygJje9AJfWAO4=
X-Received: by 2002:a05:6402:2696:: with SMTP id w22mr2266038edd.296.1641730083463;
 Sun, 09 Jan 2022 04:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
In-Reply-To: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 14:07:27 +0200
Message-ID: <CAHp75VdsJn0zn8bvS+3h4zaTKKQnyHV7P2BAkyP2EHX=kbmERA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: addac: ad74413r: use ngpio size when iterating
 over mask
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 7:34 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> ngpio is the actual number of GPIOs handled by the GPIO chip,
> as opposed to the max number of GPIOs.

Fixes?

> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  drivers/iio/addac/ad74413r.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 5271073bb74e..6ea3cd933d05 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -288,7 +288,7 @@ static void ad74413r_gpio_set_multiple(struct gpio_chip *chip,
>         unsigned int offset = 0;
>         int ret;
>
> -       for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
> +       for_each_set_bit_from(offset, mask, chip->ngpio) {
>                 unsigned int real_offset = st->gpo_gpio_offsets[offset];
>
>                 ret = ad74413r_set_gpo_config(st, real_offset,
> @@ -334,7 +334,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
>         if (ret)
>                 return ret;
>
> -       for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
> +       for_each_set_bit_from(offset, mask, chip->ngpio) {
>                 unsigned int real_offset = st->comp_gpio_offsets[offset];
>
>                 if (val & BIT(real_offset))
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
