Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916C347F6A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhLZLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhLZLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:45:51 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE9C06173E;
        Sun, 26 Dec 2021 03:45:51 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id de30so12164227qkb.0;
        Sun, 26 Dec 2021 03:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gx/LVdOKVPdIIVvf4kyiCxApl3cQNs623jcW1dhS9hU=;
        b=Al9dgbWzBEwdfuT96o+TcXkIBfx7ocEh3tmtx9JhFMpFH06smCctMD2Mes3tgBY3D3
         y4kw1/Ke4AI6C/eOi2LLigoFiLI0B2i/lL0kOKaCbWCfchowJ35yFaXRMLAvBDkkfNdG
         NjKE2VSWvUWzzPjCxbfK+zsf+tjBtOtTPueLUIEwpxP4kb9WQM/htjAp8HzKPGFliJjn
         ckxNrKYB/aw5Bkm4ec2SpVbqtDB8wPg4N/2SMLqPJS2E/rajgAcMoEPO9NBY+rjPGhPs
         syMiW1OQPy3ufn9KFrudKpkVF3zp1tIoL8oq/JflOdCbsN1AiQPasKbzCJA4+MnxHLVw
         PBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gx/LVdOKVPdIIVvf4kyiCxApl3cQNs623jcW1dhS9hU=;
        b=YR+RRw6Ie0bVpfF1ZG+8bhngkn1nO8T8Fw6p75TZ0eZ2QvYSDEJqVvQos1fHwg/1/H
         jTnU/aFlTAWYQP3lPtIcMUNE5XXX1vYh8jKn4pXjYZrLT9XHYFk6wi/7Yk6OZl7/YdOA
         Fx9hc9M3vbyDlRUbba6rMEnPR1xSckiqTzK5pvksbXkmcTXknoErSGOMlwCaoOgzt/cn
         tuKzg7CoTOEve5yv3tkVVfW8fN6PaiqHmip5j8h+XtBA94rx88E6XvT7M5wc6LBtI7g+
         WhSF0Suk1uzCdbYiyeU4iO9ai0gqA1Auqladt4In++o2fhrB1YxMTVJk/TQoSXFFsBUE
         +F+Q==
X-Gm-Message-State: AOAM532eYbA8ZfB8161FYJ+sbEsk6Hxkr8irWxtT1Wwv0K0S9Jk9eI92
        +oEQ/MtmszUpr6SkF8qTS3o=
X-Google-Smtp-Source: ABdhPJy1IYbqV/qswHELJr7WC102HRuwe7+KWGO5MuEJHgJOC/fFUUzePeV/Id3N64oBaz6mw3q++A==
X-Received: by 2002:a05:620a:22c3:: with SMTP id o3mr9017961qki.748.1640519149801;
        Sun, 26 Dec 2021 03:45:49 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id l15sm11474488qtx.77.2021.12.26.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:45:49 -0800 (PST)
Date:   Sun, 26 Dec 2021 06:45:41 -0500
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
Message-ID: <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu>
References: <20211215130711.111186-1-gsomlo@gmail.com>
 <20211215130711.111186-4-gsomlo@gmail.com>
 <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the feedback!

On Sat, Dec 25, 2021 at 06:43:22PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 15, 2021 at 10:00 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> 
> ...
> 
> > +       int ret;
> > +
> > +       host->irq = platform_get_irq_optional(host->dev, 0);
> > +       if (host->irq <= 0) {
> > +               dev_warn(dev, "Failed to get IRQ, using polling\n");
> > +               goto use_polling;
> > +       }
> 
> [Same comment as per v3.]

> This is wrong. It missed the deferred probe, for example.
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

Thanks for the example. I still need to work in a decision to use
polling, though. How about something like this instead:

ret = platform_get_irq_optional(...);
if (ret == -ENXIO)
  goto use_polling;
if (ret < 0)
  return ret; // deferred probe (-EAGAIN likely?)
if (ret > 0)
  ...we got it, keep going...

> 
> ...
> 
> > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> 
> Why under ifdeffery?

Because I only want to do it on 64-bit capable architectures.

The alternative would be to call

  dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));

on *all* architectures, but ignore the returned error (-EIO,
presumably on architetures that only support 32-bit DMA).

Do you think that would be cleaner?

Thanks,
--Gabriel

> > +       /* increase from default 32 on 64-bit-DMA capable architectures */
> > +       ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > +       if (ret)
> > +               goto err;
> > +#endif
> 
> With Best Regards,
> Andy Shevchenko
