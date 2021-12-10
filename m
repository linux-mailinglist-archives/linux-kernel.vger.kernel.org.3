Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0F4708D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbhLJSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:36:16 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34439 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLJSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:36:14 -0500
Received: by mail-ot1-f49.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso10512528otj.1;
        Fri, 10 Dec 2021 10:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYFeMefDtygzQHG6cGasFJft83PyhMCvIHgML7JQ1W8=;
        b=BT8rQ4Lwys6f0lHis7r+7jzL1KmTsfZlI2M6WpJdgfDrW3ZbR5zdfZwpIlyp3Hp6RS
         pk3HfiMPTZPvnPYMsNynL64Vew06v83zWSayDb2GcA2Kv3BmS9uxJuRCg9iBWb9mMErO
         tNlccmuVurJkG5/Ykst8sU6MiwvbV6Md0TZp5DcCcSlEFyeA51i9kzNaeyEjQBwakkNc
         Hhldlrgl/1v3LWbWLFmC7fKf6hnNdAECtE7mNXhCwU0p/SIgT2QGrEQswtJ+GrFP3auU
         oCFP/ayzlf+HGIsoP/YBFB/MWEoZoczZUBvb5HjKLP7kS8lkOVhqPGve8FS96GEK2rws
         m/Yg==
X-Gm-Message-State: AOAM532QPLjoi1gQbvHvSzI9O8ifmbE8jvJ0y7c+iB2plRn4xo272OkU
        TnDYvx/sJYHs/OI68cqHvO7dlLh2t5NpN6wVLp8=
X-Google-Smtp-Source: ABdhPJy/ApH2I9ley83OfAtDiEoSWuJBoE9Gqun3QKF0IviB+39TRacgd3bR+5yVv4MXsqS5F4aemy99lcaDR84MB0I=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr12642134otu.254.1639161158278;
 Fri, 10 Dec 2021 10:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20211126180101.27818-1-digetx@gmail.com> <20211126180101.27818-7-digetx@gmail.com>
In-Reply-To: <20211126180101.27818-7-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 19:32:27 +0100
Message-ID: <CAJZ5v0ii7tGRDbxw+5GqdyONXvRPznXUqBZd03+pdoAd+pH=JQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/25] reboot: Warn if unregister_restart_handler() fails
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

On Fri, Nov 26, 2021 at 7:02 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Emit warning if unregister_restart_handler() fails since it never should
> fail. This will ease further API development by catching mistakes early.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  kernel/reboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e6659ae329f1..f0e7b9c13f6b 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -210,7 +210,7 @@ EXPORT_SYMBOL(register_restart_handler);
>   */
>  int unregister_restart_handler(struct notifier_block *nb)
>  {
> -       return atomic_notifier_chain_unregister(&restart_handler_list, nb);
> +       return WARN_ON(atomic_notifier_chain_unregister(&restart_handler_list, nb));

The only reason why it can fail is if the object pointed to by nb is
not in the chain.  Why WARN() about this?  And what about systems with
panic_on_warn set?

>  }
>  EXPORT_SYMBOL(unregister_restart_handler);
>
> --
> 2.33.1
>
