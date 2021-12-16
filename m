Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41941477F85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhLPVpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242309AbhLPVod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:44:33 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D00C08E7B1;
        Thu, 16 Dec 2021 13:43:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e136so920719ybc.4;
        Thu, 16 Dec 2021 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCvRIN88cvRRyNaT6C9m3J4R8+HA36mI5cyJE+PFjmo=;
        b=gtdSaMh94TK8rrahc+3/8Nzu5QLzB2HC011WXA3oIa3M0p1zxNKfqgvbde25n1EPUI
         +fwrquEQmW+6xEOkCBYPpzJuQXvsXsBwGxgNuw5vu96xcgD1GZZzqQRU9mzXuKnqrj4D
         lSNLvnGg4FnqG+OaMAI/CbTBZZmk+3156jFpOkUgjvtXml0ZH4AJNcUmABkCqUJNAnLH
         kSu8WRMV/imP0v6bxPHVwcaDeir8N1FL3pxwRWHMaUFkpoXzxKE8p0b4tstYMSuzMTOs
         sVeU7bVANKvCopp7gesCK5gcGLv+c3bf6owL5WNkSx9Of0VCnkoGRKo13JRO6fvb3YC1
         JhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCvRIN88cvRRyNaT6C9m3J4R8+HA36mI5cyJE+PFjmo=;
        b=c5eSlwYwLEyvke0ly+SYzSQYfxfitYQ7AHD02be0Wzw9Evv0Oj5PABsLZJLwd7i2u/
         gGibdeolmZX8i8+QteTOyv9DTLpA7U03A8rH7ymDnJjVwljm/9jPgw1OwfXrsOH+rOAS
         +T/Z7pMRnhjsN93LxtDnr0Ppu8t2E8KP/AdJty8AxJUvQMmqlJYf5bDd/rhpjTrIdEhY
         0KvsrYoI+e4/6GkqlRSgmLHEhROnDyC+Pn28o9ODwoWHO9PsAupbfTRyeN2mq9wTawXd
         jKaHF4UgNv39xakrInkHWh5SVEjKsBmRZajOySlZyK7ZC93Fv3MfXOP6Y41S8oCGXcNQ
         u8Vg==
X-Gm-Message-State: AOAM533+119miqu7uTfNIBouGqQyyxxU4hEj/VskaoMRDCXIHeAXvyrk
        1QgPkmVmMHZzMYfHoStg97b/Fr8D65qLSKt94jX4a8QthGA=
X-Google-Smtp-Source: ABdhPJwKu2cVmo3f5Ohp0DqRDtIJ5E4ZlhFFBipbvdQZt0VyPsDlrQmuE461BA/8qJGBmqJ/msZlaDDfjoki4wAKUXw=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr15572ybi.315.1639691004872;
 Thu, 16 Dec 2021 13:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20211216183639.7710-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <3733aa67-8606-58de-69cb-f7a167713da4@roeck-us.net>
In-Reply-To: <3733aa67-8606-58de-69cb-f7a167713da4@roeck-us.net>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 16 Dec 2021 21:42:58 +0000
Message-ID: <CA+V-a8v6-zO6rYDHyFsPZ15YyjVaoP9A=WWNLXaVfY=Kkgrr+g@mail.gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410: Use platform_get_irq() to get the interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you for the review.

On Thu, Dec 16, 2021 at 7:01 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 12/16/21 10:36 AM, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypassed the hierarchical setup and messed up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/watchdog/s3c2410_wdt.c | 13 ++++++-------
> >   1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> > index 2395f353e52d..f5aced344b7b 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
> > @@ -513,9 +513,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >   {
> >       struct device *dev = &pdev->dev;
> >       struct s3c2410_wdt *wdt;
> > -     struct resource *wdt_irq;
> >       unsigned int wtcon;
> >       int started = 0;
> > +     int wdt_irq;
> >       int ret;
> >
> >       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> > @@ -536,10 +536,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > -     wdt_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > -     if (wdt_irq == NULL) {
> > -             dev_err(dev, "no irq resource specified\n");
> > -             ret = -ENOENT;
> > +     wdt_irq = platform_get_irq(pdev, 0);
> > +     if (wdt_irq < 0) {
> > +             ret = wdt_irq;
> >               goto err;
>
> All those "goto err;" statements in this function are pointless since they
> just return ret. Since this is the first of those goto statements, please
> replace it with "return wdt_irq;".
>
Sure will do and post a v2.

> Thanks,
> Guenter
>
> >       }
> >
> > @@ -592,8 +591,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >                       dev_info(dev, "default timer value is out of range, cannot start\n");
> >       }
> >
> > -     ret = devm_request_irq(dev, wdt_irq->start, s3c2410wdt_irq, 0,
> > -                             pdev->name, pdev);
> > +     ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0,
> > +                            pdev->name, pdev);
> >       if (ret != 0) {
> >               dev_err(dev, "failed to install irq (%d)\n", ret);
> >               goto err_cpufreq;
> >
>
Cheers,
Prabhakar
