Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782184708B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbhLJSbn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 13:31:43 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34439 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244333AbhLJSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:31:43 -0500
Received: by mail-ot1-f46.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso10500284otj.1;
        Fri, 10 Dec 2021 10:28:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O1tFpICrUp02/Rz91q5M3zJOsfP+AsepTWSxKHsDYko=;
        b=e4l+vmem4SND0L+G+5Ie3RFxLLrXrvGMyPAJZbzg67/hkNdsI0J8GGtWdoybu64vTO
         NOD0lUXp6bg1pULIqlbPxcn15HhDegqmP7nO/DzORFIdQJ+6xazYPxXStdfEyP5bP+IY
         0tw1Y20fymF3QMLTailjTekPbTaVnfXXXCgYUJ8DVO0RTV6XMMlpXfZDGYO8go57Mh1p
         IhMV2zteDX1s7wGWnAwx1ljAC/0CkvaDXIALZkFDPWH3QnrbJXn6EJFnv+jgFEAWB5Iz
         ++xp6ICQ0w4BDfUWNwwQY2nD0zwTXE8EaCgecUywvaFwvsf8p9jrPRFBBHE+sjqEyv6+
         uJtQ==
X-Gm-Message-State: AOAM531hx3uTngXqUJICMRO2ubqpJ3P0ao+xuVAay/4KZQE+9meZIJPk
        O9Z+hufVcSObAxbo0/igSBFnTIfDc6Fvi8tY2sM=
X-Google-Smtp-Source: ABdhPJyYCS/8s4tkJCG4AWTeWKT+d6o4I/cnaoDS1n1/MlonZY2Ew73o7SGhiWkpQrPntkE0d8ozu+9C4WKQVKYTs8M=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr12535470otf.198.1639160886984;
 Fri, 10 Dec 2021 10:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-6-digetx@gmail.com>
 <YaLNOJTM+lVq+YNS@qmqm.qmqm.pl> <033ddf2a-6223-1a82-ec64-30f17c891f67@gmail.com>
 <YaQeQgbW+CjEdsqG@qmqm.qmqm.pl> <091321ea-4919-0579-88a8-23d05871575d@gmail.com>
In-Reply-To: <091321ea-4919-0579-88a8-23d05871575d@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 19:27:55 +0100
Message-ID: <CAJZ5v0jMvdhfBqjY+V9h_Z6EH1ohuJH+KjuGiOw_Jor1Tnp7vg@mail.gmail.com>
Subject: Re: [PATCH v4 05/25] reboot: Warn if restart handler has duplicated priority
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Mon, Nov 29, 2021 at 12:34 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 29.11.2021 03:26, Michał Mirosław пишет:
> > On Mon, Nov 29, 2021 at 12:06:19AM +0300, Dmitry Osipenko wrote:
> >> 28.11.2021 03:28, Michał Mirosław пишет:
> >>> On Fri, Nov 26, 2021 at 09:00:41PM +0300, Dmitry Osipenko wrote:
> >>>> Add sanity check which ensures that there are no two restart handlers
> >>>> registered with the same priority. Normally it's a direct sign of a
> >>>> problem if two handlers use the same priority.
> >>>
> >>> The patch doesn't ensure the property that there are no duplicated-priority
> >>> entries on the chain.
> >>
> >> It's not the exact point of this patch.
> >>
> >>> I'd rather see a atomic_notifier_chain_register_unique() that returns
> >>> -EBUSY or something istead of adding an entry with duplicate priority.
> >>> That way it would need only one list traversal unless you want to
> >>> register the duplicate anyway (then you would call the older
> >>> atomic_notifier_chain_register() after reporting the error).
> >>
> >> The point of this patch is to warn developers about the problem that
> >> needs to be fixed. We already have such troubling drivers in mainline.
> >>
> >> It's not critical to register different handlers with a duplicated
> >> priorities, but such cases really need to be corrected. We shouldn't
> >> break users' machines during transition to the new API, meanwhile
> >> developers should take action of fixing theirs drivers.
> >>
> >>> (Or you could return > 0 when a duplicate is registered in
> >>> atomic_notifier_chain_register() if the callers are prepared
> >>> for that. I don't really like this way, though.)
> >>
> >> I had a similar thought at some point before and decided that I'm not in
> >> favor of this approach. It's nicer to have a dedicated function that
> >> verifies the uniqueness, IMO.
> >
> > I don't like the part that it traverses the list second time to check
> > the uniqueness. But actually you could avoid that if
> > notifier_chain_register() would always add equal-priority entries in
> > reverse order:
> >
> >  static int notifier_chain_register(struct notifier_block **nl,
> >               struct notifier_block *n)
> >  {
> >       while ((*nl) != NULL) {
> >               if (unlikely((*nl) == n)) {
> >                       WARN(1, "double register detected");
> >                       return 0;
> >               }
> > -             if (n->priority > (*nl)->priority)
> > +             if (n->priority >= (*nl)->priority)
> >                       break;
> >               nl = &((*nl)->next);
> >       }
> >       n->next = *nl;
> >       rcu_assign_pointer(*nl, n);
> >       return 0;
> >  }
> >
> > Then the check for uniqueness after adding would be:
> >
> >  WARN(nb->next && nb->priority == nb->next->priority);
>
> We can't just change the registration order because invocation order of
> the call chain depends on the registration order

It doesn't if unique priorities are required and isn't that what you want?

> and some of current
> users may rely on that order. I'm pretty sure that changing the order
> will have unfortunate consequences.

Well, the WARN() doesn't help much then.

Either you can make all of the users register with unique priorities,
and then you can make the registration reject non-unique ones, or you
cannot assume them to be unique.
