Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE06B47F70B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 15:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhLZOBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 09:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLZOBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:01:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41569C06173E;
        Sun, 26 Dec 2021 06:01:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so51816929eds.10;
        Sun, 26 Dec 2021 06:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpJIUbj9tBFYqlvv9yvDGLLOioxncOCxtxthXuJR5jk=;
        b=HAJP3eQJ6YmuhVuh1u4jcJqBthQhBJAWQbYRUMSo6wnuYFbjYErut4KBp+Sau6Dy73
         2fDaH0tsQMg+HMipngLmAvCbRUuk4biUpUMCfCJx5FMHKfY3eWcFXWnIeUSjc841d+nC
         5mISGMsDVJ2Q5WmmaRXd9+m++FIo9OgREYJzH3+puQa8VpHiPdmOLcAzXPXdyvUEUstL
         4jqQHECwm58KwiWp7u5TFy7XWr4FDq/FQETv/iQQ2gfFqbDKY0K0DWLFXOXAzLV3ehR9
         SK7bWkeog6L8x6fqb4j1WvaR1H0/QXCTh4hIna/hh1xc+p7MZfAcaRWyFvJV1Xg7NwCT
         yunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpJIUbj9tBFYqlvv9yvDGLLOioxncOCxtxthXuJR5jk=;
        b=g7tOhcoItpZTvY+D/lsXEh+TuuVyenXDsWGqdMj7J/z0ilkv5idvaajAcxBKhktIKX
         /065HQCg6ZbkIjaIDZa/U2Itdm897Y0LvH/CUI0CS/vb1wnsLy1nAgYdsoUAmGqPUbN9
         ThOAf96K6NVbtAKebY1ojcXD33SewcAGn3JqaUz4gMC6uPBVCLAmVjKaz7rQX1xYfQrK
         RHlXvfMG7QEWIgjrWfuWGyBDwpXbC+VT2u5At4t8Rhb9L1WHIiglGypanDt/QPMQT0pp
         HK5E+x8Po87xBsAelsIir4TtRWufTLkg3n1vvEpwYppNTQarG17H/QvjB9FpvU4PYDtI
         zRWQ==
X-Gm-Message-State: AOAM531QsSexvJLJiT+x/S4CnBfUhj6RbdUtRvbcVTrC1rrcq6nuUObj
        rGQ6r3tMUC6OLBMGaZ0+zRuLN2YsteRKBiwuXrA=
X-Google-Smtp-Source: ABdhPJy8YSypp1U3p7uN6w3i/OJLZZZzxtLVOBZz1MUbCsqSBqnzweBiNog30d2xuCFSgXtjdPEpLU+86XwJ81v3ubY=
X-Received: by 2002:a50:e611:: with SMTP id y17mr12618798edm.270.1640527299727;
 Sun, 26 Dec 2021 06:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20211215130711.111186-1-gsomlo@gmail.com> <20211215130711.111186-4-gsomlo@gmail.com>
 <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com>
 <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu> <CAHp75VfDq+QM30tmCy2Wg+fj+mqervh2=1LVD5BwyVmbm1PYgQ@mail.gmail.com>
 <Ychv7z6ggZGRY08l@glsvmlin.ini.cmu.edu>
In-Reply-To: <Ychv7z6ggZGRY08l@glsvmlin.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Dec 2021 16:01:03 +0200
Message-ID: <CAHp75VcTZzqvOLEOs50PD48P55f_EnBHjDiNBS-LPfSXhMxRAQ@mail.gmail.com>
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

On Sun, Dec 26, 2021 at 3:36 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Sun, Dec 26, 2021 at 03:13:21PM +0200, Andy Shevchenko wrote:
> > On Sun, Dec 26, 2021 at 1:45 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > On Sat, Dec 25, 2021 at 06:43:22PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Dec 15, 2021 at 10:00 PM Gabriel Somlo <gsomlo@gmail.com> wrote:

...

> > > > > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > > >
> > > > Why under ifdeffery?
> > >
> > > Because I only want to do it on 64-bit capable architectures.
> > >
> > > The alternative would be to call
> > >
> > >   dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > >
> > > on *all* architectures, but ignore the returned error (-EIO,
> > > presumably on architetures that only support 32-bit DMA).
> >
> > I don't understand why you are supposed to ignore errors and why you
> > expect to get such.
>
> If I call `dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));`
> on a machine where `CONFIG_ARCH_DMA_ADDR_T_64BIT` is *not* set, I
> expect an error. The implicit default
> (per Documentation/core-api/dma-api-howto.rst), is DMA_BIT_MASK(32).
> I'm working under the impression that on machines with
> CONFIG_ARCH_DMA_ADDR_T_64BIT I should increase that to DMA_BIT_MASK(64).
>
> So if I don't #ifdef it, that call will fail on machines supporting
> only 32-bits.
>
> What am I missing?

This thread: https://lkml.org/lkml/2021/6/7/398 ?

-- 
With Best Regards,
Andy Shevchenko
