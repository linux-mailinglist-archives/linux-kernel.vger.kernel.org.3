Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271BF567567
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiGERSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiGERSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:18:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C71EED0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:18:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n8so16211993eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEQiJwLVIjyTlJf7HNAXyAoKFYo5LpiNnShf4EStzn8=;
        b=pWseJXioZgMct7K8f+2RA7Qrdt5KhvujYt/kkV2zEGyUXuvW9+jmN61iN9A1mdwrs8
         MII6aS2AkrvNf0Qv2ZMvvzS67ZZs5tFsnZuXtwBTr2MJaTA+YGuvlgHjaEW6GQL68s1v
         e5dWtuQFl2WfbpM2wXUKyPYTIIxifxGp8ZhgdJrXb/4WeZjz1pbmN2zlQJjZx8geRFZY
         uI1kReZIs07I5zTP6hRHzDydjwtZvH1M7QNcZrY5HbLuwbBdMSBEyEosAYA/1+Hq4P39
         CsgvNvfsAO6l0rZdy7YTHT1Owp7+gZOlk47X3nmSPi9x3L5iqLKClb9oHD8zJJvcnCCc
         lPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEQiJwLVIjyTlJf7HNAXyAoKFYo5LpiNnShf4EStzn8=;
        b=LhzZrp4X5MVOMoNG0iI4YgZbPRsl97JP0oXnJZHxM8ihxzRPL9MQLkdImV8bV9NBjJ
         CzARDzoqJPGEHgReYcq3be6igxiHDo6m1MAfzH2JUVrPiFZ/Ln1OSsSalJVPxMoVX8Fb
         swqWxNtgrvvm6I+1habURk33VNeEUfOQ3QhELnr0AA+HdWc9fCmKJpR6l87pKU6SY4ht
         OdSA9Oz98MUp8ymMhV+DTsJCJXFcmdJrvzh1+od1mTLNx3d2LtcoNvsWuwEQrc9rtCyP
         uoj5rQOg31vqrGdD8nh+4JCZjySGXCpLTriaJV7XoFyu3fgpxzqFVZe4yR4d3sJoaBjL
         7bpQ==
X-Gm-Message-State: AJIora8/7TTR33/Q3E/DzyVaWWcg7+2i/UT2rMkdQmRceDkgJactHPy2
        CRAL6ZrM7dhVvvqtd82j0Fgpwn/a4EfEC63KEAkRwQz3ouQ=
X-Google-Smtp-Source: AGRyM1sMx/jIeA9Ia9X4c5q9Q89VPxh0msPgXzDPU8gzggcCVWNOoY9hLnJRDLW04lV+CvnEpil743x1NoFPdPOVVYg=
X-Received: by 2002:a05:6402:4518:b0:43a:3b90:7457 with SMTP id
 ez24-20020a056402451800b0043a3b907457mr18494917edb.422.1657041494616; Tue, 05
 Jul 2022 10:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220704130323.104294-1-yuancan@huawei.com>
In-Reply-To: <20220704130323.104294-1-yuancan@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Jul 2022 19:18:04 +0200
Message-ID: <CAMRc=MfLxOd7kVTzFmjkxfSOssrFaW=ih=eNVeXUUUWTLv=oew@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: pxa: Add missing clk_disable_unprepare() in pxa_gpio_probe()
To:     Yuan Can <yuancan@huawei.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 3:05 PM Yuan Can <yuancan@huawei.com> wrote:
>
> Add clk_disable_unprepare() on error path in pxa_gpio_probe().
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/gpio/gpio-pxa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
> index c7fbfa3ae43b..08963975dd1b 100644
> --- a/drivers/gpio/gpio-pxa.c
> +++ b/drivers/gpio/gpio-pxa.c
> @@ -676,6 +676,7 @@ static int pxa_gpio_probe(struct platform_device *pdev)
>         /* Initialize GPIO chips */
>         ret = pxa_init_gpio_chip(pchip, pxa_last_gpio + 1, gpio_reg_base);
>         if (ret) {
> +               clk_disable_unprepare(clk);
>                 clk_put(clk);
>                 return ret;
>         }
> --
> 2.17.1
>

Hi Yuan!

This patch is not wrong but it's incomplete. A quick glance at the
driver is telling me that once probe succeeded, nobody ever disables
or releases the clock on remove. There's no remove callback and no
devm action set for that. Please take a look at the patch I just sent.

Bart
