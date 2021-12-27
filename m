Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEA347FBC3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhL0KKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhL0KKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:10:37 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1466CC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:10:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y22so59953862edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktFif8klmz0WXN7Cg5BPFfDeM8gXq7B7ioPzAylKYiQ=;
        b=cV0S0b2sm5SG0VBdarXf1evLS83j04h05d0JAHOuJM3JHgu6j393Ur9ywHO5h/FN6o
         o4r7VGgPj/02DJztxKpfIPmpCuW9/S0IHn8fc3E40WEs7it5sunHvu6Uf6MQfe1LOxS7
         notxFRdL7U7m2qxYJ+39ZuUU4EMF4M6kQIExZG74DgcXZSTD8gmQJKjTMsSdJLL/8q8z
         5s87RLt1nMvyjM73iOzqIfaO73Tg5VwQpuPv3FZWw/vFcjm6CNCekMzYakrITEE3ctHg
         Hn6fGKmma4n06rq2mBB/q2lMdVgPKlrlkmIAXAz/zfPDFBnV9Ecfw6AZyRT+lQ3vk8Dk
         aZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktFif8klmz0WXN7Cg5BPFfDeM8gXq7B7ioPzAylKYiQ=;
        b=wBM1QMoMFc9kHbptiBoFOObUcZ5G1uQoeGyYTFigxrWKi6ddwLQo9bNYWNUTR5tXp9
         OTGJYvSPQ70s7E1f73JCgFBq4/laUxUkNf4jN0NvpKRyFO4LA9p3v3IvbYZq3K73b09N
         FvqGG7AvTvZ3iNr2u2c2+wk24JCfKvjiyjg11O77ZHomy5o4U/RZAWVpoQiHNdePPxCA
         K3T/CtBsMOgpn2nXs5ONm8dWRKMa1qyHFPP7k8RajKxtiRD2JF7D6a7b6FiK2lt8M1tv
         eYm/ANWgQ5DRTVyAl+1v+I+HHshNWOyxN88aYza2+Vphw4kzJhwQSU1SakHYkGWFdOoR
         Zfvw==
X-Gm-Message-State: AOAM532v1eyxMC6gALHG36dpdPJhGoTc7HOuu8NMaAKwjAHZIGjJttqS
        oAjwXYNVAIGm/eeHfC15h/sfkbL+Vz/0P8h9WO4=
X-Google-Smtp-Source: ABdhPJyJ/rEj0OyV+Kz1goTSYTJklG8LUHdIn5wpgRvpBFvHKCN8vmYT3NtiKbRWTRX3D7NxwPKLg6OqHS+MQRT4wJQ=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr13067089ejj.636.1640599835458;
 Mon, 27 Dec 2021 02:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com>
 <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
 <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
 <CAHp75Vc2puj45n_wMY50OnDemNmFFu-yepCC9_L+DWp1HAzxPw@mail.gmail.com> <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com>
In-Reply-To: <CAMuHMdUDts8LWYrftYp0VSxDX8kaP1a9N5YGZDNCAuAsr84EAw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Dec 2021 12:09:59 +0200
Message-ID: <CAHp75VeitNg_fU22UkNGSYpAhtQaba1Scd3CPO0QmRpjkqmSMA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 12:02 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Andy,
>
> On Mon, Dec 27, 2021 at 10:57 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Dec 27, 2021 at 11:45 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> > > > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > > > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > >
> > > > > > > > ret = platform_get_irq_optional(...);
> > > > > > > > if (ret < 0 && ret != -ENXIO)
> > > > > > > >   return ret;
> > > > > > > > if (ret > 0)
> > > > > > > >   ...we got it...
> > > > > > > >
> > > > > > > > It will allow the future API fix of platform_get_irq_optional() to be
> > > > > > > > really optional.
> > > > > > > >
> > > > > > > Later patch [0] (merged into -next) does check for -ENXIO first.
> > > > > > >
> > > > > > > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
> > > > > >
> > > > > > The problem is that it doesn't consider 0 as no IRQ.
> > > > > >
> > > > > Can you please point me to the discussion/patch where this API change
> > > > > is considered/discussed. Just to clarify now the new API for
> > > > > platform_get_irq_optional() will return "0" in case there is no
> > > > > interrupt and not not -ENXIO anymore?
> > > >
> > > > The longest one happened here:
> > > > https://lore.kernel.org/linux-ide/20211209145937.77719-1-andriy.shevchenko@linux.intel.com/T/#u
> > > >
> > > > It has links to some other discussions on the topic.
> > > >
> > > > > When will this patch be merged for the new api, so that I can base my
> > > > > patches on top of it to avoid more changes?
> > > >
> > > > You can simply imply that, I dunno when it gets merged (from my point
> > > > of view the users should be fixed first, and since you are adding
> > > > users, the burden is increasing).
> > >
> > > Not only users (drivers), but also providers (architecture-specific code).
> > > IRQ zero is still valid on some architectures, e.g. on SH[1].
> >
> > Are we talking about vIRQ?
> > And users are fine with a big warning?
>
> The warning is only seen when a driver uses platorm_get_irq{,_optional}().
> There are several other ways to obtain interrupts, avoiding the
> big warning.

Forgot to comment on this, then why is it a problem to allow
platfiorm_get_irq_optional() use 0 for no IRQ?
So, it seems you gave me a good justification for my way :-)

-- 
With Best Regards,
Andy Shevchenko
