Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3147C2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhLUPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhLUPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:22:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678DC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:22:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id bm14so40555259edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXqZoCi6bFzrtVtfX7brMYS+xGEp73oZA5ti3zFyQHs=;
        b=Di2qnlX38KdMWngxFVbSDFQfjq/BigeQIN75VnyGhGL88sn2N8bWzoZt1G5JN20YyW
         6VOuVAfyh12OGwZx8fSN3MJEAofIXI/pBDvGad3HFaARAbuQQbanJx744HGNPiETjKyC
         //Px55seoFD5lqHAdUYxkE7M3giUf+znX0082+zbVRrNH8mGkWsPerV2w2SifpvAGuXE
         mf7nr65PcIWpvqxuqVQspyqB0hmBt7uqb+Q0P7OIBqECz2e5bnig3jYOTxRewml/fFHA
         yoMBz5UfCg8IQYGel2BTWfQjzNTeA3I4/+5q8hlHlx5/2R+QLUSwNhVSLWiBWP0Q4mO2
         s8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXqZoCi6bFzrtVtfX7brMYS+xGEp73oZA5ti3zFyQHs=;
        b=ctLoYKjGXr3r7z7AzqGKV0FOC7wnOdZDNYFrxgkV0xAhzjT33JKiORYU4gstSEu1kM
         pFWs8VXzcncD4u2cCAzvb7YFDkgsBm3I9kIempILikh+M8/8clwJB5sVOp2Z5p6BmFvd
         JLOSirSp5ZOT/t8/PdAG6f44HKfovuZ4yd27syxIj3qdllcbgkwOLE7UnOyc83WNr1w3
         oXZHk+RLaf7C/e58zJx6vcSUsH5RJ6R+/j7T62drks6OfD9aTD70JRBOEzh8PQGx553f
         c/r967vqziG+COdfnDAU24zD+K5kxR0z9a9uxj40S1P7qVi/6rB3v/BIET+PLgeQgaso
         As+w==
X-Gm-Message-State: AOAM530LU4xFJpnqOil66gx7yIY83lwa5bV4Gp0aoPTsPaGNJOVtFLJj
        anBcajzrt5tIawbr+kUWdg+lCJuqkZNXSKMIu1sF2Q==
X-Google-Smtp-Source: ABdhPJxC8jMk+u361VafMW+SAgJhdjljhacITgcBclmQ37kVkk1G/wIdZPndCGxJ4zNkvuTNnXEIxtopJ73Hi1pUg/s=
X-Received: by 2002:a17:906:4c8f:: with SMTP id q15mr3197240eju.736.1640100153188;
 Tue, 21 Dec 2021 07:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20211221113825.334782-1-yangyingliang@huawei.com>
In-Reply-To: <20211221113825.334782-1-yangyingliang@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 21 Dec 2021 16:22:22 +0100
Message-ID: <CAMRc=Md7xfn5-XtbVs_sEWt7YtdzMF0eUCqUME4_W6Bxv4d84g@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: sim: add missing fwnode_handle_put() in gpio_sim_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 12:32 PM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> Calling fwnode_handle_put() when break out of device_for_each_child_node(),
> or the device node reference will be leakd.
>
> Fixes: 83960fcf4818 ("gpio: sim: new testing module")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/gpio/gpio-sim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index ef6145f51c8a..520ee923b516 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -444,8 +444,10 @@ static int gpio_sim_probe(struct platform_device *pdev)
>
>         device_for_each_child_node(dev, swnode) {
>                 ret = gpio_sim_add_bank(swnode, dev);
> -               if (ret)
> +               if (ret) {
> +                       fwnode_handle_put(swnode);
>                         return ret;
> +               }
>         }
>
>         return 0;
> --
> 2.25.1
>

Applied, thanks!

Bart
