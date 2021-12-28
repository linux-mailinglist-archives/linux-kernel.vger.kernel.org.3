Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF394808B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhL1LHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:07:18 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:35641 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhL1LHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:07:17 -0500
Received: by mail-ua1-f44.google.com with SMTP id v14so13801232uau.2;
        Tue, 28 Dec 2021 03:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPCR2ft8j5aC+VOu9AeUvKP6RjQibEMWbh71a3UGL/s=;
        b=iC4zDeLV5spHKpXdhI4M1Xij5XMqNd5h0CFz7XnSTk0iv7MjhAKBAX+nf0hhzs0dp9
         Q5mrDSl/rhunWHY55aV4oTH+4vMJj3i7Fqp5JBKAWdMrzCPusD6ZUwuB55JtTNsUXUfU
         RNRMb6D/1g1fzh4dFeiFJwEpGz+dz2h+jJ70fFQE9LHycuhGv91N27ZCuib/lzO8MWI2
         Y8Kz1LPYKXQyi0d1JkHB4G4QvKfbD/byfj/cCTNJaN3pfwG/1dsRbeqNFLKaSSVYg3Dv
         IOdWFADlgxRVr/VPCnzY5x/mEsQCLsFldW9L97zSiiU2eFCE02HNdl0XEMDhTlHYcN+R
         p87g==
X-Gm-Message-State: AOAM533UbeFrjR21i8F6AjBKl5nudUJZZW08tpcBl4+yFVsEzflxUDMp
        Am8WwWhAw5SfCNNWg8xIHuXJKoYF8vV7zw==
X-Google-Smtp-Source: ABdhPJxFQWWBoo5Cva/8gaB8n6YQATMh3AJiqaVglPWgR1IvhPy8hRdwnR/0sStyp2lDgRXMyKYg4A==
X-Received: by 2002:a05:6102:124a:: with SMTP id p10mr5844756vsg.3.1640689636238;
        Tue, 28 Dec 2021 03:07:16 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id s204sm3537586vkb.3.2021.12.28.03.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 03:07:15 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id m200so10101532vka.6;
        Tue, 28 Dec 2021 03:07:14 -0800 (PST)
X-Received: by 2002:a1f:4641:: with SMTP id t62mr6445588vka.0.1640689634331;
 Tue, 28 Dec 2021 03:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20211208201124.310740-1-robh@kernel.org> <20211208201124.310740-4-robh@kernel.org>
In-Reply-To: <20211208201124.310740-4-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 12:07:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcDxR9sGzc5pcnORiotonERBgc6dsXZXMd6wTvLGA9iw@mail.gmail.com>
Message-ID: <CAMuHMdVcDxR9sGzc5pcnORiotonERBgc6dsXZXMd6wTvLGA9iw@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] arm64: perf: Add userspace counter access disable switch
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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

Hi Rob,

On Wed, Dec 8, 2021 at 9:19 PM Rob Herring <robh@kernel.org> wrote:
> Like x86, some users may want to disable userspace PMU counter
> altogether. Add a sysctl 'perf_user_access' file to control userspace
> counter access. The default is '0' which is disabled. Writing '1'
> enables access.
>
> Note that x86 supports globally enabling user access by writing '2' to
> /sys/bus/event_source/devices/cpu/rdpmc. As there's not existing
> userspace support to worry about, this shouldn't be necessary for Arm.
> It could be added later if the need arises.

Thanks for your patch, which is now commit e2012600810c9ded ("arm64:
perf: Add userspace counter access disable switch") in arm64/for-next/core.

This is causing two issues on Renesas Salvator-XS with R-Car H3.
One during kernel boot:

     hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7
counters available
    +sysctl duplicate entry: /kernel//perf_user_access
    +CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.16.0-rc3-arm64-renesas-00003-ge2012600810c #1420
    +Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
    +Call trace:
    + dump_backtrace+0x0/0x190
    + show_stack+0x14/0x20
    + dump_stack_lvl+0x88/0xb0
    + dump_stack+0x14/0x2c
    + __register_sysctl_table+0x384/0x818
    + register_sysctl+0x20/0x28
    + armv8_pmu_init.constprop.0+0x118/0x150
    + armv8_a57_pmu_init+0x1c/0x28
    + arm_pmu_device_probe+0x1b4/0x558
    + armv8_pmu_device_probe+0x18/0x20
    + platform_probe+0x64/0xd0
    + really_probe+0xb4/0x2f8
    + __driver_probe_device+0x74/0xd8
    + driver_probe_device+0x3c/0xe0
    + __driver_attach+0x80/0x110
    + bus_for_each_dev+0x6c/0xc0
    + driver_attach+0x20/0x28
    + bus_add_driver+0x138/0x1e0
    + driver_register+0x60/0x110
    + __platform_driver_register+0x24/0x30
    + armv8_pmu_driver_init+0x18/0x20
    + do_one_initcall+0x15c/0x31c
    + kernel_init_freeable+0x2f0/0x354
    + kernel_init+0x20/0x120
    + ret_from_fork+0x10/0x20
     hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7
counters available

Presumably the same entry is added twice, once for the A53 PMU,
and a second time for the A57 PMU?

A second during systemd startup:

    systemd-journald[326]: Failed to open runtime journal: No such
file or directory
    systemd-journald[345]: File
/run/log/journal/09223238c0464b38ad4fc1d505d98e17/system.journal
corrupted or uncleanly shut down, renaming and replacing.

followed by lots of

    systemd[<n>]: <foo>.service: Failed to connect stdout to the
journal socket, ignoring: Connection refused

failures.

> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -286,6 +286,8 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
>  PMU_FORMAT_ATTR(event, "config:0-15");
>  PMU_FORMAT_ATTR(long, "config1:0");
>
> +static int sysctl_perf_user_access __read_mostly;
> +
>  static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>  {
>         return event->attr.config1 & 0x1;
> @@ -1104,6 +1106,19 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>         return probe.present ? 0 : -ENODEV;
>  }
>
> +static struct ctl_table armv8_pmu_sysctl_table[] = {
> +       {
> +               .procname       = "perf_user_access",
> +               .data           = &sysctl_perf_user_access,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec_minmax,
> +               .extra1         = SYSCTL_ZERO,
> +               .extra2         = SYSCTL_ONE,
> +       },
> +       { }
> +};
> +
>  static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>                           int (*map_event)(struct perf_event *event),
>                           const struct attribute_group *events,
> @@ -1136,6 +1151,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>         cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_CAPS] = caps ?
>                         caps : &armv8_pmuv3_caps_attr_group;
>
> +       register_sysctl("kernel", armv8_pmu_sysctl_table);
> +
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
