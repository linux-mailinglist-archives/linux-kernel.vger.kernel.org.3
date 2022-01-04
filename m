Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601F64845A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiADPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiADPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF1EC061785;
        Tue,  4 Jan 2022 07:54:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so150170961edd.8;
        Tue, 04 Jan 2022 07:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2x+wXijL40/dBn2IHb9PB1Y4Yb2SM7TSz7hC/CJR1c=;
        b=G3VKiBMgnGBR5MDj5uF0N86Vzvo6T7dGXO6MIxWbOUPSPxMn/rHYHjuWxMDUzqSOeR
         C+u8M/PIUo0K0qnulZTIxVVC5Atebd+hnO6UyHTBE812WcsVDk/wRNWumHeASNrAnRkn
         qEEuwRfmqmSQjUB1Pxd56V9AdBkL05KncYj+XLFL1OrkGYzE6h2mEz9lqKEofX/4k1IB
         puPDDjmiuhmqeZtnRGV2Xlr7+bQJYcBJxmcW2IIMMBtOsklyX+bb5YbCsNj55E8UFzfW
         Crk+5AB7Y6HhQvoLNWkWtc/blONTUof0hf8SV3JdEnBAbDcUY7CWuRhwAn7mupJSrKmp
         YnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2x+wXijL40/dBn2IHb9PB1Y4Yb2SM7TSz7hC/CJR1c=;
        b=p3nqxKibuPmgznCm0v2/xSs27WEVgSSX15SqpQ8gXfgEm5uVwSwMXC/kuhCQBrsyg6
         dIbkuYPlHYhuwvwWVnH01NiEXP/3Jj2ReeNE2UIjV+w94P5aX56yt0pPWv4mFA79+jGC
         rJm1yBtw5VdtjMjjBCH6GFDumoUj3r/QSIop5F4/Jca7+xxvzG5OfsTnPgb8n4l7U2LD
         peevwOZjhUmBTDObxiULoqSb5scyn8S8Jd12QuYsq4utRoCd6FBX0s8LQIH3GK90GUwB
         j0UOx0uW7PmwpUlvm6GEB1hSSrFTZcrf7KrRnSo1+JjQIqPiU6Ju1K2N02dcuK427VmL
         xx7g==
X-Gm-Message-State: AOAM531oV/d8Q66rQVGLAShMfxNgWNFtzlEQT7q8sLexDWbXpNgTynpJ
        x6rStabsjPcEW/JTZ26jWWIUYqyBnpM9OMoXY0Xx4XM3mde96A==
X-Google-Smtp-Source: ABdhPJx0eixYSPcvoMtIwZgtLZN8h6wzaet0JBt24EZMmeBLSJCejoV82JSn1t4Q6m2jZeN6OEjYN32Zykghsbespc8=
X-Received: by 2002:a17:906:c450:: with SMTP id ck16mr38479995ejb.579.1641311666123;
 Tue, 04 Jan 2022 07:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20220104153615.13393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104153615.13393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Jan 2022 17:52:35 +0200
Message-ID: <CAHp75VcSQyPb8+5rGQ7=dZwTmstZy4JTJpxBJrjN35ghs2Ko4Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: rcar: Propagate errors from devm_request_irq()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 5:36 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> The driver overrides the error code returned by devm_request_irq() to
> -ENOENT. Switch to propagating the error code upstream.

Thanks, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> This patch depends on [1].
>
> [1] https://lkml.org/lkml/2021/12/22/633
> ---
>  drivers/gpio/gpio-rcar.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 437baecc434e..bd2e16d6e21c 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -552,10 +552,10 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>                 goto err0;
>         }
>
> -       if (devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
> -                            IRQF_SHARED, name, p)) {
> +       ret = devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
> +                              IRQF_SHARED, name, p);
> +       if (ret) {
>                 dev_err(dev, "failed to request IRQ\n");
> -               ret = -ENOENT;
>                 goto err1;
>         }
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
