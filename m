Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F200547F6ED
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhLZNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:13:59 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884DC06173E;
        Sun, 26 Dec 2021 05:13:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o20so51452012eds.10;
        Sun, 26 Dec 2021 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDBYRX8g8nQ9YtQhwbhsiKuyfE1xZPraZ8s81788DlU=;
        b=Nqxh3bluCvaVqd2Sftmj9CR8mohV1DLx600uew29Go1IkVtzCr2uz2RCfsFMqlpLA5
         M9XcXww0gbyixZBjsprSrgMkvUnFVVS/Pbe7RpjSSU3XXzMaVZi/PIJwlcnzhO1PZvX8
         hjI7DgQSVaXFU0pBI3lpFSupQzBgiDvFDKtA+JQle4u9qe1S3Em3lZMleQIn8/NMxAak
         gM70pWEjJCtvGekXmds+33DpuCZUu1oGmQ5otbZqwS4NfRfo9gBm7CsSbwA/bfwkqQkj
         unK7jSZH+rq5PLBL9YOkA8SJ7+PTKHHR0qJpMyhflALULISps9K7NT2BI6HboIy4qLx9
         /J8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDBYRX8g8nQ9YtQhwbhsiKuyfE1xZPraZ8s81788DlU=;
        b=zmlyKZHmc1eSlBo51Ys9gTP3AAZjg5rKxPjZJIlrLI6oklzeMbpzR5QHmG5iu2gAYs
         nEAbinLzJdrSIYgat/gv1fDySwr9xLuCKfxf65OBRnT4OXjeQw/Dji2gGjlFPNvn/caP
         W4tNf0eV0sz3SywvWFhBypzI4pK+3Xf5TyFZRkKwvXnq31zDmiJkX9RGKOszxhSXmjuV
         zSZ1t/SlqvzSP5GqCNZW17c2x4v4tDNU8gcBAywUWsXuRnAc+qAAt8abzAh9tpMz0fDf
         ufpzXWioqKrHSmU8KyfXNo/fZwGBam4i+/JHA6pDg+CdBt3Z1h0uXbkOZyJkeuGsZVJt
         F+sA==
X-Gm-Message-State: AOAM532ED15cAHHoUPxzfWgzy24nD3nWU9WMvsUogmLkrc2w9KQtC6Ef
        unGsn4eVQHw18i7MgGQZRSUcJ7V3sECGwHc44j0=
X-Google-Smtp-Source: ABdhPJwdclhV0uJ9bOWfzw9G8vxMt66jjsyOz4WmgzJm7ahTME73iMMp36yvWiJPys8TfX9hFn1eRvpojzAfExQdurg=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr10543089ejj.636.1640524437308;
 Sun, 26 Dec 2021 05:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20211215130711.111186-1-gsomlo@gmail.com> <20211215130711.111186-4-gsomlo@gmail.com>
 <CAHp75Vf7ktdoBoOHVE72LO19vxZiQ82eBg9_xP2ywB6c4yqXWQ@mail.gmail.com> <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu>
In-Reply-To: <YchV5UvIq7xgkbF6@glsvmlin.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Dec 2021 15:13:21 +0200
Message-ID: <CAHp75VfDq+QM30tmCy2Wg+fj+mqervh2=1LVD5BwyVmbm1PYgQ@mail.gmail.com>
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
> On Sat, Dec 25, 2021 at 06:43:22PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 15, 2021 at 10:00 PM Gabriel Somlo <gsomlo@gmail.com> wrote:

...

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

This doesn't define what you should do when you get 0.
I suggest to take my variant with below modification

if (ret > 0)
  ...we have IRQ...
else
  goto USE POLLING;

It will take care of the case.

...

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

I don't understand why you are supposed to ignore errors and why you
expect to get such.

> Do you think that would be cleaner?

-- 
With Best Regards,
Andy Shevchenko
