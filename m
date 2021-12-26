Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F147F6E2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhLZNCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:01:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD46C06173E;
        Sun, 26 Dec 2021 05:01:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o6so51454356edc.4;
        Sun, 26 Dec 2021 05:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWXG/wpOejQOdrx5XQxBTnJYDtdO0T6bCWMUqJj50R8=;
        b=Tscwg1pTF5kpW3XpiSi0x/c33OEie/J7Wn428BUMyI+oRzxaVqrc9oyPqEWu3LkV+d
         eFgPVQgQHiGyBKgz/Da7uXqp68a9hoezmQ+ZGlSAt2G+z48eU7y0Ll9CsHuCI2EA1hK/
         YguQZVKQbJ7vmpJlQffLV4rDB1EilN19HEKqcpDpzFsZbXKNj2uLJDOc9PlQX2JMeEeg
         7ROoC6xIxpW+LfbOJJPCX0McIz+QA0Ras/4Gu3IMCu4A09sAkUQcDxTTSYFifL3fyzTy
         2TdIG8Ma9WUr7tus+ILih+1+RmepgglDKgMIaZ3zTbfLk739YGSeKCH3uN0+cqdbDx24
         7sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWXG/wpOejQOdrx5XQxBTnJYDtdO0T6bCWMUqJj50R8=;
        b=oxkkENN4YblWBLSzNhcITNF2nN5RSJ2B38Ph1uJTRWoR7xb+DSiy5rWnpChYeIJh1R
         NIxNWE1H2fa7/KuTdqMRJByHvwpxNgz4BjYQPYhiNq62CqR2ILXZFrk3AhsIPGUUCojr
         GvTFaq5NlCNELxb1ekXNOos1VeiQ3DPsGzOshb+cB5uoF1ro+3SQ0TA5HpI+tUO22ftk
         G1FtK/XxlyLzjDZ704gHMlWU7ociGmmccRj/QjrT8cAH91blzvzna4RnPu6V7kNUyoWI
         J/y7C17fVahAR0zCdWlarPxPmCxzpKwPgil79AsjgC9/g3t3OV+KeOEARDLljzhUmlxj
         UHHw==
X-Gm-Message-State: AOAM531r8rDnvoDw1rc9MEmEYauWlA5zEc+6WefevkRpty+MxYyhaBHP
        AsHAaLN2vtJ8+HpblL6gcG4w8SEA1ENoEu7seWbrjZQ1rj/+Dw==
X-Google-Smtp-Source: ABdhPJzdQxmtM1oLI/CYExu+x0hic0HJqydHBOt9IJ/kN8cpOmHnfL+cE4MDBXAM+9XgZ0L9IJPzQmOxYbTUbJi14XE=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr11769126edc.125.1640523717117;
 Sun, 26 Dec 2021 05:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20211215130711.111186-1-gsomlo@gmail.com> <20211215130711.111186-4-gsomlo@gmail.com>
 <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com> <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu>
In-Reply-To: <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Dec 2021 15:01:20 +0200
Message-ID: <CAHp75VcESv4xEWcs5yRzCJ7AgC=ogMUybdWhQRDMfDvVgos6OA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 1:45 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
>
> Hi Andy,
>
> Thanks for the feedback!
>
> On Sat, Dec 25, 2021 at 06:43:22PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 15, 2021 at 10:00 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > >
> > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > SDCard core commonly used in LiteX designs.
> > >
> > > The driver was first written in May 2020 and has been maintained
> > > cooperatively by the LiteX community. Thanks to all contributors!
> >
> > ...
> >
> > > +       int ret;
> > > +
> > > +       host->irq = platform_get_irq_optional(host->dev, 0);
> > > +       if (host->irq <= 0) {
> > > +               dev_warn(dev, "Failed to get IRQ, using polling\n");
> > > +               goto use_polling;
> > > +       }
> >
> > [Same comment as per v3.]
>
> > This is wrong. It missed the deferred probe, for example.
> >
> > The best approach is
> >
> > ret = platform_get_irq_optional(...);
> > if (ret < 0 && ret != -ENXIO)
> >   return ret;
> > if (ret > 0)
> >   ...we got it...
> >
> > It will allow the future API fix of platform_get_irq_optional() to be
> > really optional.
>
> Thanks for the example. I still need to work in a decision to use
> polling, though. How about something like this instead:
>
> ret = platform_get_irq_optional(...);
> if (ret == -ENXIO)
>   goto use_polling;
> if (ret < 0)
>   return ret; // deferred probe (-EAGAIN likely?)
> if (ret > 0)
>   ...we got it, keep going...
>
> >
> > ...
> >
> > > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> >
> > Why under ifdeffery?
>
> Because I only want to do it on 64-bit capable architectures.
>
> The alternative would be to call
>
>   dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>
> on *all* architectures, but ignore the returned error (-EIO,
> presumably on architetures that only support 32-bit DMA).
>
> Do you think that would be cleaner?
>
> Thanks,
> --Gabriel
>
> > > +       /* increase from default 32 on 64-bit-DMA capable architectures */
> > > +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > +       if (ret)
> > > +               goto err;
> > > +#endif
> >
> > With Best Regards,
> > Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
