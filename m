Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2F47A0B8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhLSNsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhLSNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:48:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4D2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 05:48:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bm14so14734026edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDw8C0oiQt8krM7GPl59F/SHmEkDcuvz/QP/KiGHzGc=;
        b=tDq3jJ0Jfjv8roeqADo2cS65CRt1dPQigjxyfk9BrR4WFccgqyTkjbJ0da4Z9Mdtb6
         wEyiQETEG6qJ3wGHzbXQcQtsp/CSVWGm2Jj8w+v8lIUZ1TGJZUiSYSbWzzct6R/vdaKS
         h3bLapiirIA8xg2x/QLX5ubCks0y0f2maBRgbwDxR0aVyNBG2zoqkirJ1G8pG4UXdgqi
         fAn9CBg1kVz/zGMYu/xt6JUxJJ0dA9VFdPrBQRwRbanuKgN2fkjXaLcwwgzrTvvvS1uj
         Y4DeI0Z8G+3KnVQBQWzvdcUVhdOtAD/2bZe1qu+SU23LeTv1aATkay4zQhEFRykw4Mi5
         X0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDw8C0oiQt8krM7GPl59F/SHmEkDcuvz/QP/KiGHzGc=;
        b=PlnBeCYti+VQMkeyf0aZ9W26u0rl4alHBI3YMRCjMzh65InX2FkKA/xGd/y6RuLEcC
         PAsuaUk1cGNlIO29ahy9AUEzhELlQqq/TeDormb7KwggF8oP3GQzebvvGlpb7bjuFiGi
         EtVAqvala4G9XG/9XFRmZ1ZKFgwABsggmGuJrx0wXOxUhivL0RbICnuzZvVnWAlZN2IP
         8ycWjqTJpn3Ik/V1waF4wxRr5SbQS+P+inGmlci6I6kh+DipEiC9amSy+uzhiqCDHJjZ
         fOFnLgsJJVMzp4HZNvZivxyaA7aMeYEr/LZQZwO7H9qbWM3iSIJhMQKX6Vx05WE7w0Ma
         hr5w==
X-Gm-Message-State: AOAM533ZCeFMDsoM9w3KLquMtcq6UXMV/UKiHub37Yw+SSCZHIT033u9
        XMnMtDJe0xYcFzL8zmK5AzdEDO9+79U1vz20DQ9M+XGrgOQ=
X-Google-Smtp-Source: ABdhPJzRohxotF39Bs+wpTjUL/P/dXK8VIR3E96T8ZEEXKcZ19/PnOSHQCC5M5ao7RmwWjnw+f+CBnuXdx+VvzpqGKc=
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr11474208edd.365.1639921729252;
 Sun, 19 Dec 2021 05:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20211218152712.2832502-1-trix@redhat.com>
In-Reply-To: <20211218152712.2832502-1-trix@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 19 Dec 2021 14:48:38 +0100
Message-ID: <CAMRc=Md5xqpu1vkipN+boN-=SnC4MOkHz=Cj3UnGnvr_Qv+21g@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: fix uninitialized ret variable
To:     trix@redhat.com
Cc:     Linus Walleij <linus.walleij@linaro.org>, nathan@kernel.org,
        ndesaulniers@google.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 4:27 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Building with clang returns this error:
>
> gpio-sim.c:889:7: error: variable 'ret' is uninitialized
>   when used here
>
> ret should be the status of the call to
> gpio_sim_make_bank_swnode stored in bank->swnode.
>
> Fixes: 83960fcf4818 ("gpio: sim: new testing module")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpio/gpio-sim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index ef6145f51c8ae..bef00dcc4dc8f 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -886,7 +886,8 @@ static int gpio_sim_device_activate_unlocked(struct gpio_sim_device *dev)
>
>         list_for_each_entry(bank, &dev->bank_list, siblings) {
>                 bank->swnode = gpio_sim_make_bank_swnode(bank, swnode);
> -               if (ret) {
> +               if (IS_ERR(bank->swnode)) {
> +                       ret = PTR_ERR(bank->swnode);
>                         gpio_sim_remove_swnode_recursive(swnode);
>                         return ret;
>                 }
> --
> 2.26.3
>

Applied, thanks!

Bart
