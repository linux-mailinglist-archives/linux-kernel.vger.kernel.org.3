Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A34A532B08
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiEXNPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiEXNPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:15:19 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758092D3C;
        Tue, 24 May 2022 06:15:16 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id i25so3509450vkr.8;
        Tue, 24 May 2022 06:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/pNo5ypsj8sjqbjG1l1gWrym6AVA3NFtAtotZSuvpI=;
        b=Nlnp3Tt7ggn57HIpiVd8CvV+0ugogeUYN+jELykDDIxebKZC9XGaCn5KFR486E2X0k
         qTx3JF5rJfvLifnrCOLM80QF0/ZUXpj5nColqtphIzI++D/sVniQAqq5vQ+lPX47gGkA
         KBx1AgXROK6AfhviJCRB3xoaB4DF7ozHk+wv4BVfGJqH8XobD3FiaCb4UKX9nrOUzTXu
         i11tyLLgMm2rzWkr87NZCzemjsM24C4BE5tcLfHA0VpF2C3RHWIXr3h5xxSvYHSrcYbO
         02uaWF3TKJSebcR1dNamHmOMRypwr41nJ2MOU+VFXixo2Hs3A9/C/H/yO/zDAFISzX/K
         8GVw==
X-Gm-Message-State: AOAM531yx760ja3yIFmW5n/5PG/ykmXFSNo0ablQ3Idb7/7i8Ujvq8Jr
        qylPGpq5obQlUylrePr1dcu1etL99R+xwmBf4bQ=
X-Google-Smtp-Source: ABdhPJyQMjkU2pFncm97tvshlgqAgIyKOlZpUu863vwvqA6s/pj0DzpChnIjsM4xuD6o3+RIk2euBw==
X-Received: by 2002:a1f:2f8b:0:b0:357:8887:811 with SMTP id v133-20020a1f2f8b000000b0035788870811mr4393420vkv.0.1653398115473;
        Tue, 24 May 2022 06:15:15 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id x184-20020a1fe0c1000000b00352a7e95666sm1479777vkg.29.2022.05.24.06.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 06:15:15 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id n24so6240512uap.13;
        Tue, 24 May 2022 06:15:14 -0700 (PDT)
X-Received: by 2002:a25:e7ce:0:b0:64d:6028:96b9 with SMTP id
 e197-20020a25e7ce000000b0064d602896b9mr25151338ybh.365.1653398104009; Tue, 24
 May 2022 06:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220509233235.995021-1-dmitry.osipenko@collabora.com> <20220509233235.995021-8-dmitry.osipenko@collabora.com>
In-Reply-To: <20220509233235.995021-8-dmitry.osipenko@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 May 2022 15:14:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVGjeFe=Z_1Kr9ZaNZ7HUVH1usvubEB31WUQf0fg8E1kA@mail.gmail.com>
Message-ID: <CAMuHMdVGjeFe=Z_1Kr9ZaNZ7HUVH1usvubEB31WUQf0fg8E1kA@mail.gmail.com>
Subject: Re: [PATCH v8 07/27] kernel/reboot: Add kernel_can_power_off()
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, May 10, 2022 at 1:33 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> Add kernel_can_power_off() helper that replaces open-coded checks of
> the global pm_power_off variable. This is a necessary step towards
> supporting chained power-off handlers.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks for your patch, which is now commit 0e2110d2e910e44c
("kernel/reboot: Add kernel_can_power_off()") in pm/linux-next.

This causes the "poweroff" command (Debian nfsroot) to no longer
cleanly halt the system on arm32 systems, but fail with a panic
instead:

-reboot: System halted
+reboot: Power down
+Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
+CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted
5.18.0-rc7-shmobile-00007-g0e2110d2e910 #1274
+Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
+ unwind_backtrace from show_stack+0x10/0x14
+ show_stack from dump_stack_lvl+0x40/0x4c
+ dump_stack_lvl from panic+0xf4/0x330
+ panic from do_exit+0x1c8/0x8e4
+ do_exit from __do_sys_reboot+0x174/0x1fc
+ __do_sys_reboot from ret_fast_syscall+0x0/0x54
+Exception stack(0xf0815fa8 to 0xf0815ff0)
+5fa0:                   004e6954 00000000 fee1dead 28121969 4321fedc f0d94600
+5fc0: 004e6954 00000000 00000000 00000058 befa0c78 00000000 befa0c10 004e56f8
+5fe0: 00000058 befa0b6c b6ec8d45 b6e4a746
+---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000000 ]---

On arm64, "poweroff" causes a clean "reboot: Power down" before/after.

On both arm32 and arm64, the same handlers are registered:
  - SYS_OFF_MODE_POWER_OFF_PREPARE: legacy_pm_power_off_prepare
  - SYS_OFF_MODE_POWER_OFF: legacy_pm_power_off

On both arm32 and arm64, legacy_pm_power_off_prepare() is called.
On both arm32 and arm64, legacy_pm_power_off() does not seem to
be called.

On arm32, both pm_power_off_prepare and pm_power_off are NULL.
On arm64, pm_power_off_prepare is NULL, and
pm_power_off is psci_sys_poweroff.

Do you have a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
