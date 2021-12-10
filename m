Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8687C4709DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbhLJTMK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 14:12:10 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42606 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242205AbhLJTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:12:08 -0500
Received: by mail-ot1-f54.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so10545520otv.9;
        Fri, 10 Dec 2021 11:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eV+MT/c+cWty36yyN1k88RcKH0yc2be+fuKXycnWnqs=;
        b=exKaGehlY8xaMtP30PH4cG0S1J8NmRM0ykI8oMJnCMSSr0LXZo71fVwZtu55xr6urS
         zZ+Io6U/8jGRFD8i2oewh+VF0rexVXTi3r63CYMyuuECT5fjl8Xgm5RUWdGbOgQynRZO
         cmGWGHNxrgKNF2esHMj0ZOGx+Gol1yIyBpiFc5Jk50K+6TRKluOIINIOkG/7Rk77PGE/
         s6TdWs6Cg3VM72SmlTjNfL9EcR9a/BZb7R04pypw4rK0SSjek+7rG1cjhi+05Gok8tcA
         LPeJb1qTTtmVewjjTQKvOy7AGeyLZHypZ0lQttZwvnSrmWn2KpWGaykMXyK7QHFCuL/N
         2SZQ==
X-Gm-Message-State: AOAM532/aBdX7TOhwoqrQ3S79yZ7K63IKo7NZLLK3swMkdbQqA3014oJ
        /SHGKRp3jkYvRRKxHlWFN3XkSf3XxH12MiwlNHE=
X-Google-Smtp-Source: ABdhPJz3WnXJDp9MR1neaOhkZU7y1rSVa1ldfWi3aUs9lzZU+HiO7VfKdE35iqJJyDqw6NIr5Fwr8foXDpr2Xp5/alg=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr12553404otj.16.1639163312676;
 Fri, 10 Dec 2021 11:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-7-digetx@gmail.com>
 <CAJZ5v0ii7tGRDbxw+5GqdyONXvRPznXUqBZd03+pdoAd+pH=JQ@mail.gmail.com> <c518ce36-09d2-16a3-cec2-6bab8260e3cf@gmail.com>
In-Reply-To: <c518ce36-09d2-16a3-cec2-6bab8260e3cf@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 20:08:21 +0100
Message-ID: <CAJZ5v0iP_VnNW3ChmdvRFg1gvwvkDGmqtGnf1oVwQxXY303RkQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] reboot: Warn if unregister_restart_handler() fails
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

On Fri, Dec 10, 2021 at 7:54 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 10.12.2021 21:32, Rafael J. Wysocki пишет:
> > On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> Emit warning if unregister_restart_handler() fails since it never should
> >> fail. This will ease further API development by catching mistakes early.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  kernel/reboot.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/reboot.c b/kernel/reboot.c
> >> index e6659ae329f1..f0e7b9c13f6b 100644
> >> --- a/kernel/reboot.c
> >> +++ b/kernel/reboot.c
> >> @@ -210,7 +210,7 @@ EXPORT_SYMBOL(register_restart_handler);
> >>   */
> >>  int unregister_restart_handler(struct notifier_block *nb)
> >>  {
> >> -       return atomic_notifier_chain_unregister(&restart_handler_list, nb);
> >> +       return WARN_ON(atomic_notifier_chain_unregister(&restart_handler_list, nb));
> >
> > The only reason why it can fail is if the object pointed to by nb is
> > not in the chain.
>
> I had exactly this case where object wasn't in the chain due to a bug
> and this warning was very helpful.

During the development.  In production it would be rather annoying.

> >  Why WARN() about this?  And what about systems with
> > panic_on_warn set?
>
> That warning condition will never happen normally, only when something
> is seriously wrong.
>
> Those systems with panic_on_warn will get what was they asked for.

They may not be asking for panicking on bugs in the reboot notifier
code, though.  That's what your change is making them panic on.
