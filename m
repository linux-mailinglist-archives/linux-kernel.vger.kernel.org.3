Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F37470840
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245294AbhLJSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:17:53 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41580 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245272AbhLJSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:17:49 -0500
Received: by mail-ot1-f50.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so10431064otl.8;
        Fri, 10 Dec 2021 10:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaOuCzlDrEGoU3kCCyjiPh5ZIczFbf2cAVp5IUpr62Q=;
        b=aYs7LMndxGQpF02d4DZkmc86npx27c98t9FUhb00GPqmlpfzrDoHJSQAdPtHMLb4ZT
         sBgEFGPVqlxMhz9CL8d6NEjNXDJ00/Dn+GVsVJQWoB6F3WnWtzX04Oc1yVZTCPjqFaDn
         pg7aBS6C5RgxjWnO3mqThntNTG0GPO/p6/NL9Gc+VpFmnYOCxJu+Kup89a7HZaI2mZPi
         pY3YahmWNV1qPpsWlk4sUc1PiBEAk3/QXfVxMNfiYxlFHiZyqqjebHVL+t4YaI2tG2+8
         LZ/8XdpAAqs6XlO/Okhl+gqgoHLaz5SH2vBprAB4/uQhVPdD0zLNey6keZpW+EXJRU6x
         smpg==
X-Gm-Message-State: AOAM532adB4yICiE7ElTW/1QWw2JxmvASw1hXzicLGSu5KzReFzRJSn1
        +uwiJ1itRFIqsnUsofHij1+XUFlMjNykQavrK8w=
X-Google-Smtp-Source: ABdhPJx5VEl25dlL8StyZ7/vR+sIp4uhzbZQ+4jxftcUhgC3Wucypp0Twl9yCOfT1qw70j5+PgOSc5gj4QOVrzsPiE4=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr12483219otf.198.1639160053505;
 Fri, 10 Dec 2021 10:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-3-digetx@gmail.com>
In-Reply-To: <20211126180101.27818-3-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 19:14:02 +0100
Message-ID: <CAJZ5v0gy5M5yYT7k5CY0JtW4MvsgKq4psBEw81UKz=pjGo0xPw@mail.gmail.com>
Subject: Re: [PATCH v4 02/25] notifier: Add blocking_notifier_call_chain_is_empty()
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 7:01 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Add blocking_notifier_call_chain_is_empty() that returns true if call
> chain is empty.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/linux/notifier.h |  2 ++
>  kernel/notifier.c        | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index 4b80a815b666..924c9d7c8e73 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -173,6 +173,8 @@ int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
>  int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
>                 unsigned long val_up, unsigned long val_down, void *v);
>
> +bool blocking_notifier_call_chain_is_empty(struct blocking_notifier_head *nh);
> +
>  #define NOTIFY_DONE            0x0000          /* Don't care */
>  #define NOTIFY_OK              0x0001          /* Suits me */
>  #define NOTIFY_STOP_MASK       0x8000          /* Don't call further */
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index b8251dc0bc0f..b20cb7b9b1f0 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -322,6 +322,20 @@ int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
>  }
>  EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
>
> +/**
> + *     blocking_notifier_call_chain_is_empty - Check whether notifier chain is empty
> + *     @nh: Pointer to head of the blocking notifier chain
> + *
> + *     Checks whether notifier chain is empty.
> + *
> + *     Returns true is notifier chain is empty, false otherwise.
> + */
> +bool blocking_notifier_call_chain_is_empty(struct blocking_notifier_head *nh)
> +{
> +       return !rcu_access_pointer(nh->head);
> +}
> +EXPORT_SYMBOL_GPL(blocking_notifier_call_chain_is_empty);

The check is not reliable (racy) without locking, so I wouldn't export
anything like this to modules.

At least IMO it should be added along with a user.
