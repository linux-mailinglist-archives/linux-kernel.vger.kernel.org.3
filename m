Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F154A5FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbiBAPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:16:53 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33470 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiBAPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:16:51 -0500
Received: by mail-pg1-f176.google.com with SMTP id 133so15620240pgb.0;
        Tue, 01 Feb 2022 07:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LY0Jv14zZsje7/vHQSOHToHuOdksSPX4R2A4AD12wOM=;
        b=BkP98Agy5ZJZBktiv84tDvBVxNYaPkwvfYwRiStrvqTIRGCb5PM78XThYVDFK3vKnK
         WN1W7YtPru9qzRM6ObYs5Jq36RD2jrk4jOTIPnTNXNlYJGUacDVOzhy7Jo1wPbfitHnQ
         +HQH49pcp5d0uhWsmwoqre+2JRWxf3Yg9A0PvEHNdrEXbmp1ull4YKL4cHVtYWoB78bE
         bB4HCULXSsXXFkTT+EB4Hxj+/0pWIx4OCxUW7vYAvlhVCsa/y0r71pkuH7AyVGoECLmw
         T116EjQhiicRKvR8wLGK65Od90SZnahdXZ+NyyXnNNIYsscHCBYuJQzHEck0noGS2sGM
         ZoIw==
X-Gm-Message-State: AOAM532y01bPiZl0z8QiGi43/HI6fHqrChXTk0DjozvrC8aPfKP6EoCW
        yFl+dM6pUNaOfj0Y1PNGfZVcp/FWetYXgKiQfA4=
X-Google-Smtp-Source: ABdhPJzMM6DKe2TD1hOG7K71ff+PLE71AdlCmcIrtDVMD21uR4nKDkEtbCJu7CJ3qll0XUJJEoo2PbmWHDla8a7YMKI=
X-Received: by 2002:a62:2982:: with SMTP id p124mr25626587pfp.53.1643728610762;
 Tue, 01 Feb 2022 07:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20220201120310.878267-1-maz@kernel.org> <20220201120310.878267-12-maz@kernel.org>
In-Reply-To: <20220201120310.878267-12-maz@kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 1 Feb 2022 16:16:39 +0100
Message-ID: <CANBLGcxCmeaXXFWi6GFSHN=RhjUp5BVRYTMXHQihsLJCocD1xg@mail.gmail.com>
Subject: Re: [PATCH 11/12] pinctrl: starfive: Move PM device over to irq domain
To:     Marc Zyngier <maz@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 at 13:19, Marc Zyngier <maz@kernel.org> wrote:
>
> Move the reference to the device over to the irq domain.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pinctrl/pinctrl-starfive.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
> index 0b912152a405..5be9866c2b3c 100644
> --- a/drivers/pinctrl/pinctrl-starfive.c
> +++ b/drivers/pinctrl/pinctrl-starfive.c
> @@ -1307,7 +1307,6 @@ static int starfive_probe(struct platform_device *pdev)
>         sfp->gc.base = -1;
>         sfp->gc.ngpio = NR_GPIOS;
>
> -       starfive_irq_chip.parent_device = dev;
>         starfive_irq_chip.name = sfp->gc.label;
>
>         sfp->gc.irq.chip = &starfive_irq_chip;
> @@ -1330,6 +1329,8 @@ static int starfive_probe(struct platform_device *pdev)
>         if (ret)
>                 return dev_err_probe(dev, ret, "could not register gpiochip\n");
>
> +       irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
> +

The gpio framework uses the irq_domain at sfp->gc.irq.domain, so
shouldn't this be set before registering the gpio_chip with
devm_gpiochip_add_data above?

>  out_pinctrl_enable:
>         return pinctrl_enable(sfp->pctl);
>  }
> --
> 2.30.2
>
