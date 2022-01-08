Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C51488339
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiAHL0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiAHL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:26:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB6C061574;
        Sat,  8 Jan 2022 03:26:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o6so32421440edc.4;
        Sat, 08 Jan 2022 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXquf5iCQ3HfT9tetwh0V2H/2+RHdN9zm4rLiz9yZQs=;
        b=Vv4NKOJk4I8e2fVNkeQJBxV6qrrehtv3BIMwwxQ+o+NzVMBPGIwxsZ91/uYmHvnZ4z
         eTMp1GnA69iZ8KbZVWvbhn43gG/mEPJUP6nT6+ZaRUAJvyG8AUevZIsqTuaIvTRvEKd+
         1atjZhVsVLLy4hxi4geVoJgSnIWltht2dh5ioQ5eFSDwVlpPA+JZriU78G6qzOTFMtwu
         YaTTOBvyxmKtf5qeUk9E7cTAVkPJjTgKPAkfodRQgZ+7cdEZxDRXo12VwSl5taBdw4nv
         JYLmHsNxG017I+iEn5O4CrWkbiF4Ucz/qXsmRSspk6ANwz0cIggwHTNgEXw53vPfp6u6
         89Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXquf5iCQ3HfT9tetwh0V2H/2+RHdN9zm4rLiz9yZQs=;
        b=XRxqrVZjXt2zl9RlCvJknnIUUnVO6Mrbo7d9lMp4bvaKRXrs5gRelh0weLcTj1HJtc
         A2ufglkscwqLbQWcUq9T1XrpZhxvahkH+rHK6nBC6YGPnY/XZQpe+ApMyM2hw2LBZ/Sx
         1nCAlmcs+2TvPqS5qVTsrvWuafC+31iOtvLglnvmqxeU0gTGihl9TUIrUm7PsMZaRgbX
         Oqym6AaeX5eQ2+hqdmVrxP3i78QRJ6LxsYnU1N0Db3HsmiUjDzec4kKb6iQ9L+MIfRsl
         Tc04t00P5mc+qrcCRWN6ejxqpI5XoNH2Ixu6ieF3t+Asah5wo2Z0gefDWsXdxJBzSouq
         otWQ==
X-Gm-Message-State: AOAM5300etiaB6X4JgnCZLFxH2yhQMZEsV+P2GrNTqlWm5MZ+wMIaT4Y
        22lPigtlSeFOM9cQFMF661KE2auMGLO300dMMjg=
X-Google-Smtp-Source: ABdhPJzEw5gxe+iuhgv5rv64kYXHaNIZwCVkWUo6anKDuxi/AG4Z6TPYnm4chMYLrYf4aMQvokgG0bjbxFxtSzgnhzo=
X-Received: by 2002:a17:906:e0d9:: with SMTP id gl25mr1905883ejb.44.1641641205215;
 Sat, 08 Jan 2022 03:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20220107233458.2326512-1-gsomlo@gmail.com> <20220107233458.2326512-4-gsomlo@gmail.com>
 <CAHp75VcHnHpX1=ojmFnujqkf55aS1ePiVW4kKydTJQe=dXbwbQ@mail.gmail.com> <YdjvlA7rqQoZe44F@errol.ini.cmu.edu>
In-Reply-To: <YdjvlA7rqQoZe44F@errol.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Jan 2022 13:26:08 +0200
Message-ID: <CAHp75Vf7o1g0FTAd+Zo6TMzDN3C2nGLhbDo0OJ9Cmwcxm=Kc8Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kgugala@antmicro.com" <kgugala@antmicro.com>,
        "mholenko@antmicro.com" <mholenko@antmicro.com>,
        "krakoczy@antmicro.com" <krakoczy@antmicro.com>,
        "mdudek@internships.antmicro.com" <mdudek@internships.antmicro.com>,
        "paulus@ozlabs.org" <paulus@ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "david.abdurachmanov@sifive.com" <david.abdurachmanov@sifive.com>,
        "florent@enjoy-digital.fr" <florent@enjoy-digital.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 3:57 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Sat, Jan 08, 2022 at 01:54:07AM +0200, Andy Shevchenko wrote:
> > On Saturday, January 8, 2022, Gabriel Somlo <gsomlo@gmail.com> wrote:

...

> > Almost
>
> That's encouraging! Thanks for your ongoing time and attention! :)

It's true from my perspective, but I'm not a maintainer here :-)

...

> >     +#include <linux/of.h>
> >
> > Is it used anywhere? Or you meant mod_devicetable.h?
>
> Not used since I dropped `of_match_ptr()`, so I'm removing the
> include in v9 as well -- thanks for catching that!

Don't forget to use mod_devicetable.h, though.

...

> >     +       u32 div;
> >     +
> >     +       div = freq ? host->ref_clk / freq : 256U;
> >
> >     +       div = roundup_pow_of_two(div);
> >     +       div = clamp(div, 2U, 256U);
> >
> > Logically seems to me that you may join these two together, because clamped
> > range is power-of-2 one.
>
> `div` needs to be a power-of-2 when written to the LITEX_PHY_CLOCKERDIV
> register (below). And clamp() will just enforce a min/max range, so if
> (div = ref_clk / freq) ends up e.g., 5, I need both roundup_pow_of_two()
> to bump it to 8, and clamp() to enforce that it's between 2 and 256.
>
> Unless you mean I should simply write it like:
>
>         div = clamp(roundup_pow_of_two(div), 2U, 256U);
>
> ... as a single line?

Yes, that's what I meant.

...

> >     +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
> >
> >
> > Should be devm or you may not use devm at all. See hint in one of the previous
> > messages in v7 discussion.
>
> And here I think I'm in trouble... :)
>
> None of the examples retrieved via
>
> `git log --no-merges --grep devm_add_action_or_reset`
>
> are from "drivers/mmc/host/*", and *all* of the mmc drivers there,
> including the ones that make extensive use of devm_*, use
> mmc_alloc_host(), and there doesn't appear to be a devm-ified version
> of mmc_alloc_host() available! How do they all get away with it?
>
> I'm really confused now -- any additional clue(s) much appreciated!

There are basically three options:
- switch to non-devm
- switch to devm: a) if there is an API, b) using
devm_add_action_or_reset() helper
- shuffle code around to make sure all devm followed by all non-devm.

-- 
With Best Regards,
Andy Shevchenko
