Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFC47F390
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhLYOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhLYOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:54:48 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99295C061401;
        Sat, 25 Dec 2021 06:54:48 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id d1so10499917ybh.6;
        Sat, 25 Dec 2021 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBGlg7qlhItAhYkrWGTkpAVTxIvhqhnK7RQZrai9dFA=;
        b=moat/QAYdAlWL+w8CnZXJ5gW4B5psYYzOeGpbeuzV9zq2soUlTjSbzoYml2nOvTLkv
         C8iWYl1MoyUonrU9pwiVzgqCa7KQx4EZTs4ItsJCHbP4KwqYCAgNRq51gCuEHjoXdmiX
         rwNUGMjGWheJYKT168c1eTt5yUI7M1heRV3Y+Q4e0I9ZP4yGaekAsT98lTSZTpinoBbR
         p/loxybXy+tprBCawtJ3BZOu9UVXnYat4aKnZxBYmgth3eJnCpova6vrvf+U/XastDkr
         InqMX1huWySTtp3KwKG3U0BT/LksEZ5xiLqM+zkn2+HOdKHewYDCXmYK8rvud21IH4sq
         w7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBGlg7qlhItAhYkrWGTkpAVTxIvhqhnK7RQZrai9dFA=;
        b=fD6zJCA60Cnn0Rrp6ZqYzPGll3g/iEanOnDjnvhMMU8oob13WG+KaPZCH8HX0D+9AC
         s5a6eklFSSlzDQZ46buTiuEXIdNx4tmtoNIOcd8OewM+vxLVoQS/KpN4lQWjsIxqKVPF
         bpZJwA51BHiKI8i406UOqLiZpID55PEezeyLxGIde0gTQKjlzdoOXQNW2N8+I5HJ/jsl
         nN5iZX3dycsTNjwmc/7LsR5fPCgvy+G0Yaa3K/1LkO0ZcurChG3XYE2lVwBRdGiI5Bo4
         mYEBZX3AAGqWPR3fkxJsYJcH2PJO5EIk475JUUCHei1Iom+YwKlG/CnMjQn2ezPE41jb
         +VYA==
X-Gm-Message-State: AOAM533auA1vwPpTmz84m8TL5GPNnnj8rZHyJ7+S0Ju3t1mMvWJYlYHS
        y2D8hHk6j+MLoJYbgagZSlkwcbdZZQqY+bg2uwk=
X-Google-Smtp-Source: ABdhPJxA1aRf0ZUCbr3ObJDnGWLmORjqw1InceX+9Ux3+CJoGe6jWac1mtvunISrnZU6AhO20em5/tc8pnlylUYKSus=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr13417273ybo.613.1640444087068;
 Sat, 25 Dec 2021 06:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20211222171915.9053-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222171915.9053-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75VccFMoTxR=ws=Us4UW=-Qsr6hVWcKH+pgShJQMdPfKQ_Q@mail.gmail.com>
In-Reply-To: <CAHp75VccFMoTxR=ws=Us4UW=-Qsr6hVWcKH+pgShJQMdPfKQ_Q@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 25 Dec 2021 14:54:21 +0000
Message-ID: <CA+V-a8uHJmVVMHD-kdPXb=f-5wkoeVvDEwG7=siTYuv6_r=xgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: rcar: Use platform_get_irq() to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Sat, Dec 25, 2021 at 2:49 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Dec 24, 2021 at 9:21 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq().
>
> ...
>
> > -       if (devm_request_irq(dev, irq->start, gpio_rcar_irq_handler,
> > +       if (devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
> >                              IRQF_SHARED, name, p)) {
> >                 dev_err(dev, "failed to request IRQ\n");
> >                 ret = -ENOENT;
>
> While at it, you may unshadow the error code
> ret = devm_request_irq(...);
> if (ret) {
>   ...
> }
>
Agreed, will do.

Cheers,
Prabhakar
