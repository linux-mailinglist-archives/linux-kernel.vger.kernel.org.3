Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F85487569
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbiAGKXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:23:09 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:46788 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbiAGKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:23:05 -0500
Received: by mail-vk1-f180.google.com with SMTP id u198so3358685vkb.13;
        Fri, 07 Jan 2022 02:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2loKrwHVliQMs6xQhMn/Ju+9qiYS7pDhv6uhEt7pMzI=;
        b=UdUsDh83cEHx73kiTiDUzH6XwUtIV/SIDZPpmYlUv0mib9+6tCwPoJ0fnHyaF6kI7R
         x0AGQ5cwgV7ndo2U1PDhH3F3MgW9TcIU/WJXOcGiqUjjjEY2dYSENXawCjKzQVh1VNyC
         BG9X28WBHGPzh4FSwKyTIz7hGmDJC2jchZ4H7CcL0J9tAEwh6eKQOme2JEyf0u4Gc6dk
         +p08U9qY8ZnphFUi5rHSPNVN3wxmcqEYZqvE4iG2xWU8m0GCQRkE7PgsSUarE9vuF/E8
         I0Xit2o036MY4kzRjU1YYHrpRPhiROaugA6SscNrQ+CjhgdjMKIeJsD+MBRbZ0ABjWhU
         5EVg==
X-Gm-Message-State: AOAM533ixUZBp76c71FhQOHUqgIpYCDIFsj9aKY33xVNRBl7KPZadUjy
        W7Qk2UnjQHSnQFicqZO7PKYfOEYzUhJSJQ==
X-Google-Smtp-Source: ABdhPJzAdmvNgNF++G12pziwGz7t0YTRLIvFhr1DGoiLGurGa3osvRk+NwIAoPckZ1zkHm+ze67TVA==
X-Received: by 2002:a1f:f8c4:: with SMTP id w187mr23117316vkh.41.1641550984204;
        Fri, 07 Jan 2022 02:23:04 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id c14sm3194147vsl.22.2022.01.07.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 02:23:02 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id v12so9304295uar.7;
        Fri, 07 Jan 2022 02:23:02 -0800 (PST)
X-Received: by 2002:a67:2e09:: with SMTP id u9mr19039539vsu.77.1641550981835;
 Fri, 07 Jan 2022 02:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20211208201124.310740-1-robh@kernel.org> <20211208201124.310740-4-robh@kernel.org>
 <CAMuHMdVcDxR9sGzc5pcnORiotonERBgc6dsXZXMd6wTvLGA9iw@mail.gmail.com> <20220104135658.GC1827@willie-the-truck>
In-Reply-To: <20220104135658.GC1827@willie-the-truck>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jan 2022 11:22:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUq9rAZT5B3xUGWAhHnyg2ta_Vx8KNDWms6vbqGmrarRg@mail.gmail.com>
Message-ID: <CAMuHMdUq9rAZT5B3xUGWAhHnyg2ta_Vx8KNDWms6vbqGmrarRg@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] arm64: perf: Add userspace counter access disable switch
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, Jan 4, 2022 at 2:57 PM Will Deacon <will@kernel.org> wrote:
> On Tue, Dec 28, 2021 at 12:07:02PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 8, 2021 at 9:19 PM Rob Herring <robh@kernel.org> wrote:
> > > Like x86, some users may want to disable userspace PMU counter
> > > altogether. Add a sysctl 'perf_user_access' file to control userspace
> > > counter access. The default is '0' which is disabled. Writing '1'
> > > enables access.
> > >
> > > Note that x86 supports globally enabling user access by writing '2' to
> > > /sys/bus/event_source/devices/cpu/rdpmc. As there's not existing
> > > userspace support to worry about, this shouldn't be necessary for Arm.
> > > It could be added later if the need arises.
> >
> > Thanks for your patch, which is now commit e2012600810c9ded ("arm64:
> > perf: Add userspace counter access disable switch") in arm64/for-next/core.
> >
> > This is causing two issues on Renesas Salvator-XS with R-Car H3.
> > One during kernel boot:
> >
> >      hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7
> > counters available
> >     +sysctl duplicate entry: /kernel//perf_user_access
> >     +CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 5.16.0-rc3-arm64-renesas-00003-ge2012600810c #1420
> >     +Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> >     +Call trace:
> >     + dump_backtrace+0x0/0x190
> >     + show_stack+0x14/0x20
> >     + dump_stack_lvl+0x88/0xb0
> >     + dump_stack+0x14/0x2c
> >     + __register_sysctl_table+0x384/0x818
> >     + register_sysctl+0x20/0x28
> >     + armv8_pmu_init.constprop.0+0x118/0x150
> >     + armv8_a57_pmu_init+0x1c/0x28
> >     + arm_pmu_device_probe+0x1b4/0x558
> >     + armv8_pmu_device_probe+0x18/0x20
> >     + platform_probe+0x64/0xd0
> >     + really_probe+0xb4/0x2f8
> >     + __driver_probe_device+0x74/0xd8
> >     + driver_probe_device+0x3c/0xe0
> >     + __driver_attach+0x80/0x110
> >     + bus_for_each_dev+0x6c/0xc0
> >     + driver_attach+0x20/0x28
> >     + bus_add_driver+0x138/0x1e0
> >     + driver_register+0x60/0x110
> >     + __platform_driver_register+0x24/0x30
> >     + armv8_pmu_driver_init+0x18/0x20
> >     + do_one_initcall+0x15c/0x31c
> >     + kernel_init_freeable+0x2f0/0x354
> >     + kernel_init+0x20/0x120
> >     + ret_from_fork+0x10/0x20
> >      hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7
> > counters available
> >
> > Presumably the same entry is added twice, once for the A53 PMU,
> > and a second time for the A57 PMU?
>
> Looks like it, and perhaps that's also what is confusing systemd?
> Rob -- how come you didn't see this during your testing?
>
> Anywho, please can you try the untested diff below?

Thank you, this fixes the issue.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1214,6 +1214,14 @@ static struct ctl_table armv8_pmu_sysctl_table[] = {
>         { }
>  };
>
> +static void armv8_pmu_register_sysctl_table(void)
> +{
> +       static u32 tbl_registered = 0;
> +
> +       if (!cmpxchg_relaxed(&tbl_registered, 0, 1))
> +               register_sysctl("kernel", armv8_pmu_sysctl_table);
> +}
> +
>  static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>                           int (*map_event)(struct perf_event *event),
>                           const struct attribute_group *events,
> @@ -1248,8 +1256,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>         cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
>                         caps : &armv8_pmuv3_caps_attr_group;
>
> -       register_sysctl("kernel", armv8_pmu_sysctl_table);
> -
> +       armv8_pmu_register_sysctl_table();
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
