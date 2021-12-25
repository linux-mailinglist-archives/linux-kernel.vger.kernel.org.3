Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED92447F413
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhLYR2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYR2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:28:11 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5DC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:28:11 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id w184so12043849ybg.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 09:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1qLIvrTw1D3bCRhZw96HarlOs/PMrWHeiq9DapCt1g=;
        b=gMLEIUqC4QRi022j7haW7SrzvaQO4ZMj1ZGrzrhCs/kff6dIgNdULKtYhLdPhV+kTR
         Q/3aR0rzUqVRtwNOUv8E4sycTy9JPH6OP2UL3gW0BoGPv/5Nc9yuq+iNwlR17I1YrQVP
         FLT8ueQp6rNKQU/+PWafW8eX1uJZ7AOTxkkKUEM0Q8HE7AQ757qzcAgVrigpdDktkFJ2
         UuH7E/D0ombQqwnkEP3AUhqP8wo8qS8R08mRSSo+7+fLkl3JjM33+rYc4cgxcYGDQSQx
         byM3mbzwFrbeWuVoEQK4eZq8OIzUt2NhuBjuDN1wqeZee71PLsw2q0nwjZ2mZItRj4Hg
         49AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1qLIvrTw1D3bCRhZw96HarlOs/PMrWHeiq9DapCt1g=;
        b=sD5b0NRWf4GvxTBoHZ1BRJeGlXRJcxxSd32MGrV6+UsUmOgk1LwkTqJNjHluGRtZGE
         E7Hn0dfKUAyrzwt+34eDaakxEnXFP9wdQNSIZ9JZMzuZMuMEh/j5C60/4zz8SCQFcmKb
         yYLhpkAfLz+6M1dsBOgPZgWN2LHUAa72/J1BblWhpgCcAsXGpS1q2A9MZ1cH/HAfw3tI
         b2nXjwInuX9KA/2/vZ8PJnTwB7bGgXubU/hlsV3Fq6oaWctXY/IW/TGrEJ/6hn2NHl+O
         5svgy7ZDRgl/bCh2E1EFGsSByLM05sysgEgctCWhmmAjr2Is+CS8HjQI5Jftoq+5Y+g8
         v9qQ==
X-Gm-Message-State: AOAM530Nc1nZrf7dR6antXM8PjwDqitxVAeZeq0cLwJG4s13fDAcmyUv
        cjNFWQVRkkWFArcp6LAkOPT8eIWFI+awsDBKikg=
X-Google-Smtp-Source: ABdhPJwoZ5G9IkzDTs3gx3/1x2Wuq5TGB7Wk0aVKL/Dy+X/l8kQ9FDmC1CmNb3okTwb4L6iiDRPAAEFeIScT/AKX9pw=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr14147237ybe.422.1640453290693;
 Sat, 25 Dec 2021 09:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
In-Reply-To: <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 17:27:45 +0000
Message-ID: <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
>
>
> > +               ret = platform_get_irq_optional(pdev, k);
> > +               if (ret == -EPROBE_DEFER)
> > +                       goto err_runtime_pm_disable;
> > +               if (ret < 0)
> >                         break;
>
> The best approach is
>
> ret = platform_get_irq_optional(...);
> if (ret < 0 && ret != -ENXIO)
>   return ret;
> if (ret > 0)
>   ...we got it...
>
> It will allow the future API fix of platform_get_irq_optional() to be
> really optional.
>
Later patch [0] (merged into -next) does check for -ENXIO first.

[0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/

Cheers,
Prabhakar
