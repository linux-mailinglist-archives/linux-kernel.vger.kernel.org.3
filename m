Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E626488718
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 01:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiAIA0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 19:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiAIA0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 19:26:07 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB4C06173F;
        Sat,  8 Jan 2022 16:26:07 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id a9so10075997qvd.12;
        Sat, 08 Jan 2022 16:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=uo8kcmFKOJnBHc39R815DUsjkRzM7D7xbUUaMw6memM=;
        b=EoXHNjiiKBcy91GeKimqGnoWZntDkrxWNdEmn+oW22t4UEbXZkMT4AbbvGVNp4GeZg
         ToK9LENP4SPehAxXnuwfUEcrIkdT4lTvGrsoy3D+wITwURS7DELWhsUzZ6yZJIpOUhnE
         reTqLcNABf3O8p+BlFP54OWNBlw4gSAKqkva6sHGkAQMs0eBVPMQjtAlOzJSqbPyuG/n
         c3bLksz89Iwip6MYLaPx1mPTIm/CRPA4f05Ih6ZzWOs/Ad7yl0kBsc2ZobdRYM/8X78X
         3HLJs6HISGEAKOufgji4Xy+qlxBRO3y7WaMQGqfekgW/MDhENx+515JUEjP24AsZLb89
         kKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=uo8kcmFKOJnBHc39R815DUsjkRzM7D7xbUUaMw6memM=;
        b=bG/QOmR6qF/593av3olZAViqAhMv6Me8lyA0BTmXoZ9MOEr5CUDmShT0iv0tc2wQfX
         hEs5EobqDeQ1dQTC5fGKZ4YSSg45u0UY9pK+jXtW3f05mPgowtgAOP9CKZhJMBrcXzZQ
         /QUDeQLEFThvU8IUbNAxBLSDjVwYxwqI4OoKzOCU2apbRd1o5t2PUbBUbO7niGMTF8pj
         8a5Sk0/nm4ZtOtEwtZfXv+Gjt1gHXEMUx5GZjLbT91lGj37F7KZIAmHUzWV/vZBUpbUy
         uG+fHqJoa+HED5R98MwpZl939nw46yFXMDftavTbhDxPgiHg6mynL5Ru1BLsJM7hLeeq
         fkCw==
X-Gm-Message-State: AOAM5331Nq6ST0DrXoWJyb2Fy8EkuesGcIYvYM73MTKFKbzOw5W6QA5a
        5IJcy+obOGtU8MJhEfn6GV0=
X-Google-Smtp-Source: ABdhPJyEBo2yuJD71y+e5WKS7p9R3BlNRqfxN9IVAkWtu0B2o/l4Mi8GF3otVV5ltJA3nThtB1owBg==
X-Received: by 2002:a05:6214:5018:: with SMTP id jo24mr62795026qvb.114.1641687966378;
        Sat, 08 Jan 2022 16:26:06 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id y11sm1919688qta.6.2022.01.08.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 16:26:05 -0800 (PST)
Date:   Sat, 8 Jan 2022 19:26:03 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v9 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ydorm5HirY2i/RCg@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeEvT-_47gKFAYdz-BR9y=KLEw2uMbRxYKo1rLQSQEfyg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 07:43:19PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 6:11 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > SDCard core commonly used in LiteX designs.
> >
> > The driver was first written in May 2020 and has been maintained
> > cooperatively by the LiteX community. Thanks to all contributors!
> 
> Thanks for an update, my comments below.
> 
> ...
> 
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/litex.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> 
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sd.h>
> 
> I would move this group of headers...
> 
> > +#include <linux/platform_device.h>
> > +
> 
> ...somewhere here to show that this driver belongs to the MMC subsystem.

OK, lined up for v10
 
> ...
> 
> > +#define LITEX_MMC_OCR (MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 | \
> > +                      MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 | \
> > +                      MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36)
> 
> Seems to me this is identical to
> https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/au1xmmc.c#L72
> 
> And may be reused in
> https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/vub300.c#L2168.
> 
> Perhaps it makes sense to have
> 
> #define MMC_VDD_27_36 ...
> 
> in mmc.h?
> 
> In any case, it can be postponed, just a side note for the future improvements.

I'm awaiting follow-up advice from Ulf Hansson, who originally suggested
this should be dynamically configured through a dummy voltage regulator
in DTS. Since LiteSDCard doesn't a (current or planned) option to
adaptively configure voltages via software, I think hard-coding the
valid range in the driver (in the exact way as au1xmmc.c) might be
cleaner, and if we end up agreeing on that, there might be opportunity
for factoring it out in the way you describe.

> 
> ...
> 
> > +       /* Ensure bus width will be set (again) upon card (re)insertion */
> > +       if (ret == 0)
> > +               host->is_bus_width_set = false;
> > +
> > +       return ret;
> 
> Please, switch to standard pattern, i.e.
> 
>   if (ret)
>     return ret;
>   ...
>   return 0;

OK, lined up for v10

> ...
> 
> > +       u32 div;
> > +
> > +       div = freq ? host->ref_clk / freq : 256U;
> 
> > +       div = roundup_pow_of_two(div);
> > +       div = clamp(div, 2U, 256U);
> 
> Not sure why it becomes two lines again.

Per my previous email, I have:

        div = clamp((u32)roundup_pow_of_two(div), 2U, 256U);

... lined up for v10 (pending also Geert's OK on the (u32) cast
to shut up compiler warnings) :)

> ...
> 
> > +       ret = devm_add_action_or_reset(dev,
> > +                                      (void(*)(void *))mmc_free_host, mmc);
> 
> One line?
> An actually preferable way is to define a separate wrapper function
> and use it here without any casting.

Done and lined up for v10:

    /* wrapper for use with devm_add_action_or_reset(), below */
    static void litex_mmc_free_host_wrapper(void *ptr)
    {
        mmc_free_host((struct mmc_host *)ptr);
    }

    static int litex_mmc_probe(struct platform_device *pdev)
    {
        ...
        ret = devm_add_action_or_reset(dev, litex_mmc_free_host_wrapper, mmc);
        ...
    }

> > +       if (ret) {
> 
> > +               dev_err(dev, "Failed to register mmc_free_host action\n");
> > +               return ret;
> 
> return dev_err_probe(...);

OK.
 
> > +       }
> 
> ...
> 
> > +       clk = devm_clk_get(dev, NULL);
> > +       if (IS_ERR(clk)) {
> 
> > +               ret = dev_err_probe(dev, PTR_ERR(clk), "can't get clock\n");
> > +               return ret;
> 
>     return dev_err_probe(...);

OK.

> > +       }
> 
> ...
> 
> > +       ret = mmc_add_host(mmc);
> > +
> > +       return ret;
> 
> It's now
> 
>     return mmc_add_host(...);

OK.

I'll wait till sometime tomorrow for additional feedback on clamp()
casting and voltage range hard-coding vs. regulators, before I send
out v10 so we can continue from there.

Thanks, as always,
--Gabriel
