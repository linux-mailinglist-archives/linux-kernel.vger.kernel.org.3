Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6E487DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 21:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiAGUul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 15:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAGUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 15:50:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C3DC061574;
        Fri,  7 Jan 2022 12:50:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a18so25576543edj.7;
        Fri, 07 Jan 2022 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlBq++Mbxq9QxetanKS+JnWzv3W5HjcXAFEwjfaKnfo=;
        b=Ih3GtG9UDkfEEvAaL9hBdCmoQMYXrh5ibw/5LsAiZlVgSNc4M0sbXGZtxlCUr524x5
         fYQxjjFzRECqgiRu67+Tj9z+ngLkJfxb6E+cYyIhm2KmYo7HM6IPHMw5EHMvH5DdgSsn
         5y9Mmx7qAdU/7x0KaCUJ2v693lt0csU3eThZ5ambP/nNNUpvb0XZVl4gkPlkkpNONKzc
         NMzYnL2Qi0hStgtAU5D8aPZSAmA72U4G3pzxnsVMnY6rNutHtZwtZ2BublKOCxl3vIMz
         WLLdZZl5gU2ZopatP0j14b0/z7v8RtKtDletT2OYEPvRI+EqGfmKs5BkwevGELM9tGCO
         4ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlBq++Mbxq9QxetanKS+JnWzv3W5HjcXAFEwjfaKnfo=;
        b=XMKvvLxkRPrGzMZQDtwaHrpRoVhE/OWAHdswxTohqrofVXRl2+jNAYTsie/mqLJqUa
         slZqVdpi/zlMkRvZFwnUETBhVgMAeWBaozPvr+PqdohonI5OxJ4QluiXj9SQr3NBLizg
         BUkGWWLCEaAW8OVB2QpfQVRI2m2pUQS5bM0HrMn2RIex5w4swO+uJefvnYU5YpJgzlBN
         xFvhIc5bjBg/ZIbzZ+y+L2ltZNV29BaWWpXugt3khmLzNNdxuVB+1gde4rY9yVE5nt9F
         BSAvUz4SHrbjzp5rH5RX5ErgIfyU6sNnp4ATxTgZKpcb98g6MgHUiSms+j1mQ9q90eDG
         AZMw==
X-Gm-Message-State: AOAM532RIo0t1GvnkuwgQETHfmayKn+lQIBrBQIsduANlC8IhaiQqn6f
        BJpeJaL2E88d5cl8PMs2wLdr7K98SiLyqvmFPmw=
X-Google-Smtp-Source: ABdhPJzP8JS4gf86jUMd1xH1qoxBPJe7huD7LjKYtX4H/ns/3xUenOtiBecFkc8w5n6spSqm4LOzuyqLgf6UF5Xdm6M=
X-Received: by 2002:a17:906:c450:: with SMTP id ck16mr49490152ejb.579.1641588638965;
 Fri, 07 Jan 2022 12:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20220107170616.2041589-1-gsomlo@gmail.com> <20220107170616.2041589-4-gsomlo@gmail.com>
 <YdhzmE8eBsvkRCBn@errol.ini.cmu.edu>
In-Reply-To: <YdhzmE8eBsvkRCBn@errol.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Jan 2022 22:50:02 +0200
Message-ID: <CAHp75Ve5T-yNV-BJww_kN+6y8P9FyHodKfZ4nfi2POynp6BPVg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 7:08 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Fri, Jan 07, 2022 at 12:06:16PM -0500, Gabriel Somlo wrote:

...

> > Cc: Mateusz Holenko <mholenko@antmicro.com>
> > Cc: Karol Gugala <kgugala@antmicro.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: David Abdurachmanov <david.abdurachmanov@sifive.com>
> > Cc: Florent Kermarrec <florent@enjoy-digital.fr>

It would be nice if you can use `git send-email --cc ...` instead of
putting a long list into a commit message.

...

> It looked to me like you thought I should `#include <linux/bits.h>` here
> (even though I'm not getting any compiler warnings regarding it). If so,
> why? If not, apologies for the misunderstanding :)

The rule of thumb is to explicitly use the headers you are the direct
user of with the remark that some of them are guaranteed to be
included by others and some of them should be used (in most cases)
instead of their low-level parts (the example is types.h vs
compiler_attributes.h, so former is more standard than the letter and
it's almost 100% guarantee you want to have something from types.h
anyway in your code).

So, BIT() is defined in bits.h and in the below list none of the
header _guarantees_ its indirect inclusion.

> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/litex.h>
> > +#include <linux/module.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sd.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>

...

> Any more ordering or devm vs. non-devm mixing violations here? If so,
> can you please link me to an example or some docs where I ould figure
> out what it is I'm still doing wrong?

Device managed resources are attached to the instance of the device
object and removed in the order they have been attached to, but with
the caveat that they have no clue about non-managed calls in between.
Now you may figure out what happens. Ex.:

probe()
  A
  devm_B
  C
  devm_D

remove()
  un_C
  un_A

WRONG!

> > +static int litex_mmc_remove(struct platform_device *pdev)
> > +{
> > +     struct litex_mmc_host *host = dev_get_drvdata(&pdev->dev);
> > +     struct mmc_host *mmc = host->mmc;
> > +
> > +     mmc_remove_host(mmc);
> > +     if (host->irq > 0)
> > +             free_irq(host->irq, mmc);
> > +     mmc_free_host(mmc);
> > +
> > +     return 0;
> > +}
>
> Ditto here...

Ditto.

...

> > +             .of_match_table = of_match_ptr(litex_match),
>
> You said "Wrong usage of of_match_ptr()" here, and all I have to go by
> is a bunch of other `drivers/mmc/host/*.c` files that use it in a
> similar way, so can you please clarify and/or provide an example of how
> to do it properly?

First of all, you have a dependency to OF, try to remove it and
compile with OF=n and you will immediately see the issue. You may also
go for  `git log --no-merges --grep of_match_ptr` and analyze the
result.

-- 
With Best Regards,
Andy Shevchenko
