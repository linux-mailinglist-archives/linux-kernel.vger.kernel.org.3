Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8146B0D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhLGCtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLGCtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:49:47 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17438C061746;
        Mon,  6 Dec 2021 18:46:18 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id p4so13296101qkm.7;
        Mon, 06 Dec 2021 18:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SElHe6V0YIn8colM6BdilzON7/VtRRQaE57fWBbme4w=;
        b=j+HfX+x3n+d58EEidEQwNvGEmYKdyLpokG49/XjKUfTHUGXs31CRN0OQOlZke/zeWo
         p1wLIblH0iNthwvMeStNAqsf5J3QsY+7Jt1yzrH9Pl0uZDOTKtJW/+ki+soBQDRSzTqe
         3XXyTjJbf3tYvad0LbqKQyNJy8Z0/K/j37Ojw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SElHe6V0YIn8colM6BdilzON7/VtRRQaE57fWBbme4w=;
        b=tNOxLnqJGDJtjXk+9IACQ6ObRdgTiNinYOPOUISIzydxvnAnkwrTGcXSmZFeiH6X/A
         ohMGaSTphB4trBOikPziIyCzgJLUArXc/BuQhZHm2nmTVzhoypANAyU7U9SxxB5qc2Oj
         hzIlo7AX2Yr1OPVIJui2koACXuEEYqXjPBnMP5ep80hz+m8FGOXTt1Am0445V5JlTAhH
         +rh/Nke2F1+ZCwpPRGZMYx/FkFaDELeVz9FloZt+2gVt3E+ZfqhZkFevne3AEYeMZIE/
         3MO402vjKC9OFt1CV+43qIOHfLWF2MP4HSVN5s0Kd3H0vuW8p06XXzLsufmyEXJ3IScC
         c7Lw==
X-Gm-Message-State: AOAM532XfVvEVWD38M78ExG/Oh7DeY1ZimzQVXoPFKxnx9gz0GSeaGiG
        ZrRZr510AhcLtZwyvRXk/jMJFwNkDhumjmAI+6A=
X-Google-Smtp-Source: ABdhPJxdO+vcgbH9/n5MHHody6QQzCajhH0mrh7jeXVqDcyalUyocJUw/GB0vHySRmA4DDXXHyGt6XppaSYhFtUTB4s=
X-Received: by 2002:a05:620a:4081:: with SMTP id f1mr36607665qko.165.1638845177061;
 Mon, 06 Dec 2021 18:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20211203234155.2319803-1-gsomlo@gmail.com> <20211203234155.2319803-4-gsomlo@gmail.com>
 <CACPK8XfO_8=vgedmZddz1YmWbyxiM1-azF_j88wEBHzXnP6y_g@mail.gmail.com> <Ya63gv21Dmhi6J0s@errol.ini.cmu.edu>
In-Reply-To: <Ya63gv21Dmhi6J0s@errol.ini.cmu.edu>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 7 Dec 2021 02:46:03 +0000
Message-ID: <CACPK8Xeg2UoAqp55R+UrRLFJqerc1Kqrubh3BiEpSon+Q6bGyQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 at 01:23, Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> I can remove dependency on "LITEX" and, with that, succesfully build
> the driver as a module -- same principle as the LiteETH driver.
> I'm queueing that up for the long promised v3, soon as I clear up a
> few remaining questions... :)

If we have the driver as a 'tristate' we should make sure it loads and
works as a module.

>
> Right now I have:
>
>         depends on OF || COMPILE_TEST

The OF dependency is a requirement for the symbols you're using. See
the discussion I had with Greet, I think going with this is reasonable
for the first pass:

 depends on OF
 depends on PPC_MICROWATT || LITEX || COMPILE_TEST

> > > +static int
> > > +litex_get_cd(struct mmc_host *mmc)
> > > +{
> > > +       struct litex_mmc_host *host = mmc_priv(mmc);
> > > +       int ret;
> > > +
> > > +       if (!mmc_card_is_removable(mmc))
> > > +               return 1;
> > > +
> > > +       ret = mmc_gpio_get_cd(mmc);
> >
> > Bindings.
>
> This was part of the original Antmicro version of the driver, but I
> have never actually used gpio based card detection. I'm inclined to
> remove it from this submission entirely (and keep it around as an
> out-of-tree fixup patch) until someone with the appropriate hardware
> setup can provide a "tested-by" (and preferably an example on how to
> configure it in DT).

Agreed, if it's untested and unused then delete it.

> > > +static u32
> > > +litex_response_len(struct mmc_command *cmd)

something else I noticed when re-reading the code; we can put the
return arguments on the same line as the functions. The kernel has a
nice long column limit now, so there's no need to shorten lines
unncessarily. Feel free to go through the driver and fix that up.

> > Can you put all of the irq handling together? Move the hardware sanity
> > checking up higher and put it together too:

> I moved it all as close together as possible, but it has to all go
> *after* all of the `dev_platform_ioremap_resource[_byname]()` calls,
> since those pointers are all used when calling `litex_write*()`.

Makes sense.

> I'll have it in v3, and you can let me know then if it's OK or still
> needs yet more work.

> > > +
> > > +       ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> >
> > Is this going to be true on all platforms? How do we handle those
> > where it's not true?
>
> I'll need to do a bit of digging here, unless anyone has ideas ready
> to go...

I'm not an expert either, so let's consult the docs:

Documentation/core-api/dma-api-howto.rst

This suggests we should be using dma_set_mask_and_coherent?

But we're setting the mask to 32, which is the default, so perhaps we
don't need this call at all?

(I was thinking of the microwatt soc, which is a 64 bit soc but the
peripherals are on a 32 bit bus, and some of the devices are behind a
smaller bus again. But I think we're ok, as the DMA wishbone is
32-bit).

>
> > > +       if (ret)
> > > +               goto err_free_host;
> > > +
> > > +       host->buf_size = mmc->max_req_size * 2;
> > > +       host->buffer = dma_alloc_coherent(&pdev->dev, host->buf_size,
> > > +                                         &host->dma, GFP_DMA);
> >
> > dmam_alloc_coherent?
>
> Does this mean I no longer have to `dma[m]_free_coherent()` at [1] and
> [2] below, since it's automatically handled by the "managed" bits?

Yep spot on.

> > > +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > > +       mmc->ops = &litex_mmc_ops;
> > > +
> > > +       mmc->f_min = 12.5e6;
> > > +       mmc->f_max = 50e6;
> >
> > How did you pick these?
> >
> > Are these always absolute? (wouldn't they depend on the system they
> > are in? host clocks?)
>
> They are the minimum and maximum frequency empirically observed to work
> on typical sdcard media with LiteSDCard, in the wild. I can state that
> in a comment (after I do another pass of double-checking, crossing Ts
> and dotting Is), hope that's what you were looking for.

Lets add a comment describing that.

> > > +
> > > +       return 0;
> > > +
> > > +err_free_dma:
> > > +       dma_free_coherent(&pdev->dev, host->buf_size, host->buffer, host->dma);
>
> [1] is this made optional by having used `dmam_alloc_coherent()` above?

Yes, we can remove this.

> > > +err_free_host:
> > > +       mmc_free_host(mmc);
> > > +       return ret;
> > > +}
> > > +
> > > +static int
> > > +litex_mmc_remove(struct platform_device *pdev)
> > > +{
> > > +       struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
> > > +
> > > +       if (host->irq > 0)
> > > +               free_irq(host->irq, host->mmc);
> > > +       mmc_remove_host(host->mmc);
> > > +       dma_free_coherent(&pdev->dev, host->buf_size, host->buffer, host->dma);
>
> [2] ditto?

Yep.

> Thanks again for all the help and advice!

No problem. Thanks for taking the time to upstream the code.
