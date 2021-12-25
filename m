Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0426147F3E4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhLYQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:46:11 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FCC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:46:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so44535711edv.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zL1+4E4xmrW8u8bUjqstWaJv4Fnr4rWUE+7STrZsgY=;
        b=XfDZhry7hsYdJf4VFjXoa9mvCWEhCdcEsjqNkiDC74FAkTIokppZPtAyO2biV1P+sV
         NxZw9DRjCvRcBXpBv2BrJpKaYkdXdOt8VafJBu9prJ5Jda1mc2SuUfPC7I0SCxXvPcM9
         k8Rlk4gcy/BaR1GCmyg6BOKY07WT4+Yj5vTaFAWWf130O02CJvTdykTjg8XHK9pL8J6E
         MIFxn4AxLWeuepofT+p59m+x4xghX6u2qrUNK2w92pzRgV/kzo6UfEWCYmeESnOTWpHD
         /SqcH1svs5n6wqrpIcz4xrSK/qBDTGY3fjrQKVT6u8A9yoy+MQlmMq9bhLFUeFvBnQ36
         d0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zL1+4E4xmrW8u8bUjqstWaJv4Fnr4rWUE+7STrZsgY=;
        b=tgUkHMEk4IsNFalavHOXp47z4V3dyBbArhCxT6Own+r05p803TvXB3df2LWCkdJTCM
         MyxIzYdMus10waoxrf5O5UH59F8ipMA1psQHrn8SUMtUPdiaVeSSUnUb2SUaPXLKbBW6
         jaCQjJ3UDToDvN0e5o6ay1xeI0Wu8U/LYr2r1tfj5gOtF4t2VZ+sqy8xFXIit1IFfnqH
         ykVlYPtLpCes7C9UQ8JxZhwWpGxU+d6gpo6adb8Cjdsw8brOPcu3qQr+YLP9NFPdRWsd
         WEN+3/NL/ueEV56MUwe6fHshewrUyR3LSUWQ6rT15VW0BRXXW3qnybCtAJf27ob9wV+4
         xLug==
X-Gm-Message-State: AOAM532uzMxGzGWv7RPKfQpoojXtFIoCGTPqhv1lKhIrP1nASnGnsDiw
        XZ+2SquiUnH2ZT4V1dAFufxq1giviws2ex8OERmK9dgP+YE13bNn
X-Google-Smtp-Source: ABdhPJxyndgi+pHKr0bHgYOo+iSFWTT0MoXFuFxUfn0TOQ+g7dcAhjJb2vpD9yP0WmgSqC+tadHNiEURWYy1WjhlyuQ=
X-Received: by 2002:a50:e611:: with SMTP id y17mr9811812edm.270.1640450769160;
 Sat, 25 Dec 2021 08:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:45:33 +0200
Message-ID: <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().


> +               ret = platform_get_irq_optional(pdev, k);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err_runtime_pm_disable;
> +               if (ret < 0)
>                         break;

The best approach is

ret = platform_get_irq_optional(...);
if (ret < 0 && ret != -ENXIO)
  return ret;
if (ret > 0)
  ...we got it...

It will allow the future API fix of platform_get_irq_optional() to be
really optional.


--
With Best Regards,
Andy Shevchenko
