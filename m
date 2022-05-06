Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61CF51DB56
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442563AbiEFPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbiEFPFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:05:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E277237BE2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:01:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so9003504ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh9Sqbyn13sjjoIAw04mQl+yZsrs+e88nMF1+Rj3nhg=;
        b=C4ATGoLFGKHoQUaNmVja0AuY75V9kVbt6sh1BucMgbLBchNG6EiNl9CjYsTM30+Lce
         841iy/LOcDklFSR7lXyrAb2kDr7XeysXBK9NAa+YZH58esrE9NqFAOtEop4rIet6HoRl
         NlKOsWQMRK9GyDjOktjQJRrerF4TAOfWH56jX/Zrle6kg5K/clVcuRkVx50nO1JFkHD9
         jupSzTkXpGrGrMjw7W6A7XPoUoYVGojC/Uaupr667yG89VEjR3iUTYfICz7zishBnfRU
         uN2rVGel5QhrV0yHANYswR2/BcIBbB7MhBMUpO0qlgvNCFIZYjNkD6yaoVOaYTGCH4U+
         kk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh9Sqbyn13sjjoIAw04mQl+yZsrs+e88nMF1+Rj3nhg=;
        b=GuEGjg1qDCXDaP570MDfKmQpNz7+zaTd9S28i0dpSEoaV8Uvg3cVpX/Jnng7x8tbT9
         fsHVApvu3r6m3hUQPlBTt2Y9zmQVMx35z/D8hafdj9C3BPhj2sqvLr68kP758v4w5X9Y
         jbFGRJrFtZxHbRS6bihbD7XSERVTIcIRPDvue/afjrAZ8PWeak7ybhPZOOZ2k+e5ZKYB
         W/bNic/OrUUEiv6c+pOA39lYfEdd/wGC0n3LtfTb+Ya6WCDmhj8l19Qruk1FyXbm75bU
         TUHMfLUHasSXdbrVKJ/jgDJUnAry9S4TypLXv0lJxcsAjAkjsDUIWlBdTe5kw7SJX1iB
         2UxQ==
X-Gm-Message-State: AOAM532Cd2OmX5lK3OfC2V+Mqyo8Y1XzECNHKasvbAEBsezbq6ApELLA
        A68INcGkxq+58uQXdf2VPj5j5SRZaamMhGRKiKt+LA==
X-Google-Smtp-Source: ABdhPJyxpIefbpZt8xqFwsIPVrDZUzq9eCOh4xzY0qOduedsNRrKFFyrpnpLyMHr3IyWYdi7CZEaoFDy9QtWy8PMRbE=
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id
 ec12-20020a0564020d4c00b00410a415fd95mr3855937edb.288.1651849288453; Fri, 06
 May 2022 08:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220506080630.4151-1-puyou.lu@gmail.com>
In-Reply-To: <20220506080630.4151-1-puyou.lu@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 May 2022 17:01:17 +0200
Message-ID: <CAMRc=MfGNH9LTscsBHqL05PQHLO9tFNxBZ9H_381MrWszL0hJg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: pca953x: fix irq_stat not updated when irq is
 disabled (irq_mask not set)
To:     Puyou Lu <puyou.lu@gmail.com>
Cc:     stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@misterjones.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 10:06 AM Puyou Lu <puyou.lu@gmail.com> wrote:
>
> When one port's input state get inverted (eg. from low to hight) after
> pca953x_irq_setup but before setting irq_mask (by some other driver such as
> "gpio-keys"), the next inversion of this port (eg. from hight to low) will not
> be triggered any more (because irq_stat is not updated at the first time). Issue
> should be fixed after this commit.
>
> Fixes: 89ea8bbe9c3e ("gpio: pca953x.c: add interrupt handling capability")
> Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
>
> ---
>
> Change since v1:
> add fixes tag and commit message https://lore.kernel.org/lkml/20220501092201.16411-1-puyou.lu@gmail.com/
>
> ---
>  drivers/gpio/gpio-pca953x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index d2fe76f3f34f..8726921a1129 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -762,11 +762,11 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
>         bitmap_xor(cur_stat, new_stat, old_stat, gc->ngpio);
>         bitmap_and(trigger, cur_stat, chip->irq_mask, gc->ngpio);
>
> +       bitmap_copy(chip->irq_stat, new_stat, gc->ngpio);
> +
>         if (bitmap_empty(trigger, gc->ngpio))
>                 return false;
>
> -       bitmap_copy(chip->irq_stat, new_stat, gc->ngpio);
> -
>         bitmap_and(cur_stat, chip->irq_trig_fall, old_stat, gc->ngpio);
>         bitmap_and(old_stat, chip->irq_trig_raise, new_stat, gc->ngpio);
>         bitmap_or(new_stat, old_stat, cur_stat, gc->ngpio);
> --
> 2.17.1
>

Queued for fixes, thanks!

Bart
