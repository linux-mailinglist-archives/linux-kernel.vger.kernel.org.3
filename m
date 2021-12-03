Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD864679E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381640AbhLCPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381603AbhLCPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:03:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D49C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:00:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v1so12760292edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtY25LFKl7eTwEuZldGmVgghmm7bTt72/KAhGH0LlbA=;
        b=xZblMOLDD/4vn7XuHfYaLUYz8nzMlGw5OVJuJkQKzdTE+KgvZqhURXkgUYHiDKkJCc
         90Fh0VtXFstEEf84KgJxhrDr4bxyr7kakzODwLWCgO+0SfJQv6s6sJGNhEpZq6tcNT2r
         0h8uhV2L+wxQ46QB6RaFmH30r/kf+T/tR+m3/6Qa5Lvgcm87GG10SHnidvjXuvukbYoy
         4FdR/BPCk7cxFBV/24fnF22tZFwZwwSz+OVQXlpuPDDjvfe1A8Uvf0YjWD19I846/FLG
         NEXUJTvEuopX+8gvEPAR/VG2+Cr/AjjLhodDAukQM7hOfwl9yJuMRgD505pKD6bF5cTi
         PkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtY25LFKl7eTwEuZldGmVgghmm7bTt72/KAhGH0LlbA=;
        b=0dVy1s2rBEqF3abwuyrIOLY2TnXQ5VTdV2vCv3GYxqTZTigx8aK2z7HaeXw7UPbFb2
         4p1P7wiO0nuR6IGo8B/BlyXLSsh82MnBsxQ5oj+6R2Ba8H4A+R9AsLoojtUJa0Ma8v7c
         KlabK90prmNKnXpiRPshMAKp2bSuYllQ4ifXpYTBrooryzxu3+y83GsbHLuHDcddsMFe
         mxeKkC2C10ejGG60corF0BJTfh9BogEk++xEBwSK/vinL/R4NrmWd6YXTDQMxORUGfvJ
         XKOCVgYMGn+o/6KBglD7FXvw9SxBq3Kb3ylir+YQKVDR2Xnb8HwSM/GxxaLbvW/HsG9R
         6BZQ==
X-Gm-Message-State: AOAM530nuc1YM9GePHP02PBbxKaheSlK7dHRZZ6aPrD+cOmrLSgSvUs0
        XK6Nh5xE5DsNj+UdlhnSt+KPN9BWDFFoBYAOgj/R7A==
X-Google-Smtp-Source: ABdhPJy4TGv4Xq8YWqsEzg5l8Oga2d3eqJo4J7nkcgTKE3wluMMUK6+HGidcMspgGZho9/MvzfDTKV/Hl4J/2S9m9h4=
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr21287297ede.267.1638543602223;
 Fri, 03 Dec 2021 07:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20211202155022.2972779-1-john@metanate.com>
In-Reply-To: <20211202155022.2972779-1-john@metanate.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 3 Dec 2021 15:59:51 +0100
Message-ID: <CAMRc=MdPCTQm_4_D4WApkL8y1tL__qt-2jnnreGQL0d=tjCADg@mail.gmail.com>
Subject: Re: [PATCH] gpio/rockchip: lock GPIOs used as interrupts
To:     John Keeping <john@metanate.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 4:50 PM John Keeping <john@metanate.com> wrote:
>
> Use the standard gpiochip request/release resource functions so that any
> GPIOs used as interrupts are properly locked.  This allows libgpiod to
> correctly show these GPIOs as in-use.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index ce63cbd14d69a..c1b8e5dbbcc47 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -465,6 +465,22 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
>         return ret;
>  }
>
> +static int rockchip_irq_reqres(struct irq_data *d)
> +{
> +       struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +       struct rockchip_pin_bank *bank = gc->private;
> +
> +       return gpiochip_reqres_irq(&bank->gpio_chip, d->hwirq);
> +}
> +
> +static void rockchip_irq_relres(struct irq_data *d)
> +{
> +       struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +       struct rockchip_pin_bank *bank = gc->private;
> +
> +       gpiochip_relres_irq(&bank->gpio_chip, d->hwirq);
> +}
> +
>  static void rockchip_irq_suspend(struct irq_data *d)
>  {
>         struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> @@ -536,6 +552,8 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
>         gc->chip_types[0].chip.irq_suspend = rockchip_irq_suspend;
>         gc->chip_types[0].chip.irq_resume = rockchip_irq_resume;
>         gc->chip_types[0].chip.irq_set_type = rockchip_irq_set_type;
> +       gc->chip_types[0].chip.irq_request_resources = rockchip_irq_reqres;
> +       gc->chip_types[0].chip.irq_release_resources = rockchip_irq_relres;
>         gc->wake_enabled = IRQ_MSK(bank->nr_pins);
>
>         /*
> --
> 2.34.1
>

The title should be: gpio: rockchip: ...

Queued for next, thanks!

Bart
