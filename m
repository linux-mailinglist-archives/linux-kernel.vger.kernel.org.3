Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1864709C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbhLJTJZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 14:09:25 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44617 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhLJTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:09:20 -0500
Received: by mail-oi1-f178.google.com with SMTP id be32so14445880oib.11;
        Fri, 10 Dec 2021 11:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c+Gg3IcBrVO+p3DERDiz2wIK2rZh3JBEUqlmxz2Wt9w=;
        b=KF02GmbhAy9o852cKAkWGRsQiFbgHC75Qjm16bI7ZSmAfyJfROZofbcH5jI8CJ/ve+
         eHhgitsnexLUIDGw5//Gk3z+Ok9evNj4B9kvpHUljhuupzNnGZFu5aFXSsX81N0DYWnQ
         IaBXbFwEerwNO3snRUpagshSzYMbeSIiztCbLnK54Zt/2TVaC3wOPO8BVEK8I1B434i9
         jEc6iUXt9xaEyYM6x5//wTvcOkDy/tLV52Sdv83wiI5s/7cNfq7VeKJ7PH5p5hyHH/1h
         /CbxkevGDaw6vPTu14r/Zn3poSjqgobQdPA5+G75/glByywxNMFAgRWya2D4H+Hw9B5o
         Jl1w==
X-Gm-Message-State: AOAM5333zryiN0f+sbmHmz1C8Wb+kAiv8RDMW2PlfbHCFvYf5HhFNokx
        4ByWa50hvEfayrUN+aS2O+/98uHRohqSF0ta+/8=
X-Google-Smtp-Source: ABdhPJyFnxvuCdo/SAuZsTrbeFY0ttrM6VIAZMHiyNGyFieUXOlcjM/63kmCFhhj1nwi5THbS12OxkRKZ5ROskKDe+g=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr14151206oih.51.1639163143930;
 Fri, 10 Dec 2021 11:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-4-digetx@gmail.com>
 <CAJZ5v0jTJ3f7oUUR690PGaPJsxA8yzua9XDa8MONBHMzHnDfOQ@mail.gmail.com> <e6ff1cea-a168-1cb0-25c5-fb16c681cf4a@gmail.com>
In-Reply-To: <e6ff1cea-a168-1cb0-25c5-fb16c681cf4a@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 20:05:32 +0100
Message-ID: <CAJZ5v0gwnY07vg71_NB8RDWyv84FtMsmx7UTDd8TkUd7vFzc6A@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] notifier: Add atomic/blocking_notifier_has_unique_priority()
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 7:52 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 10.12.2021 21:19, Rafael J. Wysocki пишет:
> ...
> >> +bool atomic_notifier_has_unique_priority(struct atomic_notifier_head *nh,
> >> +               struct notifier_block *n)
> >> +{
> >> +       unsigned long flags;
> >> +       bool ret;
> >> +
> >> +       spin_lock_irqsave(&nh->lock, flags);
> >> +       ret = notifier_has_unique_priority(&nh->head, n);
> >> +       spin_unlock_irqrestore(&nh->lock, flags);
> >
> > This only works if the caller can prevent new entries from being added
> > to the list at this point or if the caller knows that they cannot be
> > added for some reason, but the kerneldoc doesn't mention this
> > limitation.
>
> I'll update the comment.
>
> ..
> >> +bool blocking_notifier_has_unique_priority(struct blocking_notifier_head *nh,
> >> +               struct notifier_block *n)
> >> +{
> >> +       bool ret;
> >> +
> >> +       /*
> >> +        * This code gets used during boot-up, when task switching is
> >> +        * not yet working and interrupts must remain disabled. At such
> >> +        * times we must not call down_read().
> >> +        */
> >> +       if (system_state != SYSTEM_BOOTING)
> >
> > No, please don't do this, it makes the whole thing error-prone.
>
> What should I do then?

First of all, do you know of any users who may want to call this
during early initialization?  If so, then why may they want to do
that?

Depending on the above, I would consider adding a special mechanism for them.

> >> +               down_read(&nh->rwsem);
> >> +
> >> +       ret = notifier_has_unique_priority(&nh->head, n);
> >> +
> >> +       if (system_state != SYSTEM_BOOTING)
> >> +               up_read(&nh->rwsem);
> >
> > And still what if a new entry with a non-unique priority is added to
> > the chain at this point?
>
> If entry with a non-unique priority is added after the check, then
> obviously it won't be detected.

Why isn't this a problem?

> I don't understand the question. These
> down/up_read() are the locks that prevent the race, if that's the question.

Not really, they only prevent the race from occurring while
notifier_has_unique_priority() is running.

If anyone depends on this check for correctness, they need to lock the
rwsem, do the check, do the thing depending on the check while holding
the rwsem and then release the rwsem.  Otherwise it is racy.
