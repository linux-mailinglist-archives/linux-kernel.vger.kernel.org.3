Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13747F700
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhLZNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:36:56 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8832C06173E;
        Sun, 26 Dec 2021 05:36:55 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id t66so820897qkb.4;
        Sun, 26 Dec 2021 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AKe6bYsQ8eQ5Hup/hskzkJ4Lun6ENaG2h3Ib+O7239E=;
        b=oEh4eQGNOFp/zT9ZcatgfzzBusvcvY1561V/WX1bpEejqKrxfnok3PxBbnBcoXvkOl
         vFgAvlTTkVe68hDlS6653ZxryisGQwLIONsx+9jg6plLOH2l+KpayChmcU39Otq8ytrC
         OZBd8Tpb9XaeKUyBuhEMcOx7WYRbF8cEYIYdwVsnCRndHvMUtuvqt1fo4YTk09xgQ6eX
         FPAGWAXEAb1nAGGKt6ZVjPGIFN0kbDuqZzbpLkwRYLMACChZ26PeQ0QQXVQ4kjen6umX
         duXTt00IoKiTqz/UA1b9gQNnzVIr5BzfzFNyLKwqyPvfLTxFKpLj8e/l9HZ5HEgnD0fM
         quKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AKe6bYsQ8eQ5Hup/hskzkJ4Lun6ENaG2h3Ib+O7239E=;
        b=dzQ8IMrA9bbBxe0yBUjPNdc4phRu03zYvoH0AqB2YODMFf+oNGBe2AwSHoNkviSkHo
         vbCVRAGmB7lI1l38ks7UdYtEvJvlX/39ajKt5fAUsPWbu+R+HkCf84cxceRqXZkmIkNn
         jd4v4cqu9ENxVcgy14zY3hJu00lF4WceVbm0OxBZQGA3SqYwlvgsoXUk2SuZ+NVwm2dA
         x8OZ7Z/zfQOt72aCni/U7R6d+SogPidlgihMRTilWgcqrfmErCZIdZy9Vl6qSiqIwCC6
         lkegLsb5jJSaugkylc9crmCB86oI1Viu5HysuIaNf9dBL5UQFUbYRREMGsQm5e97ws3n
         qAog==
X-Gm-Message-State: AOAM533I73gI9H6rFESrGRZi4kjE9oFqZ6Lht9DVRFgKVj+X/ka+RMnj
        m39lcLx/Qw4IZLPo4kikc2k=
X-Google-Smtp-Source: ABdhPJx5z+5o/XV5DEpU80Udc2m2E44EaFNaRVl+VJD90QbD8rqHsrrzbt7YIb4t9whRp8Fc7dCsjQ==
X-Received: by 2002:a05:620a:bc7:: with SMTP id s7mr9337086qki.20.1640525814827;
        Sun, 26 Dec 2021 05:36:54 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id c8sm11624580qkp.8.2021.12.26.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 05:36:54 -0800 (PST)
Date:   Sun, 26 Dec 2021 08:36:47 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ychv7z6ggZGRY08l@glsvmlin.ini.cmu.edu>
References: <20211215130711.111186-1-gsomlo@gmail.com>
 <20211215130711.111186-4-gsomlo@gmail.com>
 <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com>
 <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu>
 <CAHp75VfDq+QM30tmCy2Wg+fj+mqervh2=1LVD5BwyVmbm1PYgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfDq+QM30tmCy2Wg+fj+mqervh2=1LVD5BwyVmbm1PYgQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 03:13:21PM +0200, Andy Shevchenko wrote:
> On Sun, Dec 26, 2021 at 1:45 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 06:43:22PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 15, 2021 at 10:00 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> 
> ...
> 
> > > This is wrong. It missed the deferred probe, for example.
> > >
> > > The best approach is
> > >
> > > ret = platform_get_irq_optional(...);
> > > if (ret < 0 && ret != -ENXIO)
> > >   return ret;
> > > if (ret > 0)
> > >   ...we got it...
> > >
> > > It will allow the future API fix of platform_get_irq_optional() to be
> > > really optional.
> >
> > Thanks for the example. I still need to work in a decision to use
> > polling, though. How about something like this instead:
> >
> > ret = platform_get_irq_optional(...);
> > if (ret == -ENXIO)
> >   goto use_polling;
> > if (ret < 0)
> >   return ret; // deferred probe (-EAGAIN likely?)
> > if (ret > 0)
> >   ...we got it, keep going...
> 
> This doesn't define what you should do when you get 0.
> I suggest to take my variant with below modification
> 
> if (ret > 0)
>   ...we have IRQ...
> else
>   goto USE POLLING;
> 
> It will take care of the case.
 
OK, will do.

> ...
> 
> > > > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > >
> > > Why under ifdeffery?
> >
> > Because I only want to do it on 64-bit capable architectures.
> >
> > The alternative would be to call
> >
> >   dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >
> > on *all* architectures, but ignore the returned error (-EIO,
> > presumably on architetures that only support 32-bit DMA).
> 
> I don't understand why you are supposed to ignore errors and why you
> expect to get such.

If I call `dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));`
on a machine where `CONFIG_ARCH_DMA_ADDR_T_64BIT` is *not* set, I
expect an error. The implicit default
(per Documentation/core-api/dma-api-howto.rst), is DMA_BIT_MASK(32).
I'm working under the impression that on machines with
CONFIG_ARCH_DMA_ADDR_T_64BIT I should increase that to DMA_BIT_MASK(64).

So if I don't #ifdef it, that call will fail on machines supporting
only 32-bits.

What am I missing?

Thanks,
--Gabriel
 
> > Do you think that would be cleaner?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
