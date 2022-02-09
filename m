Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89284AE93E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiBIFYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:24:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiBIFPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:15:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B247C03BFD8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:15:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r131so700150wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R83kg3J8lh5wnpwznu/c6c1j21tsi5+UW4ZNVbTpfkQ=;
        b=cQLt8iTabwlg2Ev6+vNAfrfaVsetuJTsCIXfsbWxN2KJQ58d0KT0yZirQMTcbt0NXE
         LOfXB+yowzcYh6fsRbs+oRvGDrIyudB2kSF8OJDHN3A6K3ERrtV52t9beearu5kOexbl
         R/AilxUl1TEcYp7coPdkyR+2dFjXdBhU/4jKHmOAsBkBREdBpjS7BJ5H1/TM7y8VY1k+
         geFLbW0Sot0MDg/GGIDq4Uc5Phh2KwSsIUry0D33+azOc/I+Dh+yY82X10zhxY91RO0J
         QSagJNSO2WAfgnvRxfYUQ3nOofM6gq8dOXjEYfRV99IN5qHnqkdG+8+9UZC7Qp+gs90d
         G67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R83kg3J8lh5wnpwznu/c6c1j21tsi5+UW4ZNVbTpfkQ=;
        b=JZ5R/tVQ4aBqqxJT143XdZsbpx97fkGP+fYCnyAlAtOI1s8AmzdVpuKqWw+x3uutyA
         Hj/c+0BIZtirbXFg0fjS63fTwPysPTM30+13akfc1HzvPXjWexkU91/2tvYhmR0trEFs
         I/X4ob9JGuOqWQ1aVsNEMRkrc8DiiuSfgR2Es0pB9EqbV7gKIbNE+/4L9IHfZ9TN9q2t
         hLzR6eW8gbr5PnpxCGpL/kPa3gKTv6u8/978Zv7FaboPCdE5iYTdBJog9NOM+xaVo61y
         CUTxXrc2BzhLkPdHeRDbxb29rb1552uP5r1uYe+FdDGKuLEgxzh/Xpus73Y6W3WPfhmw
         /tgg==
X-Gm-Message-State: AOAM531sTAGqEtW1XFE7r9JXXG01mZkJB8vityzDsEK+lSh4Aa4yygce
        D5E+hxUZdr9oSknSbpNv4BgC8KO8pnwETVDjc1UOWQ==
X-Google-Smtp-Source: ABdhPJxxJAmtus+XKgjkisjrqjjLqRFgSAIDZ/p0j1uNWEJQORypvJKDSShWADJ4LEAWxrxvnzgCy6iYR0zK2J9eq8E=
X-Received: by 2002:a05:600c:4185:: with SMTP id p5mr467679wmh.61.1644383716505;
 Tue, 08 Feb 2022 21:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com>
 <20220126114452.692512-2-apatel@ventanamicro.com> <CAJF2gTSwzx-yC=WvFixT96=q+M0KPzaZH5PpgGKVWg42M4GBNw@mail.gmail.com>
In-Reply-To: <CAJF2gTSwzx-yC=WvFixT96=q+M0KPzaZH5PpgGKVWg42M4GBNw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 9 Feb 2022 10:45:05 +0530
Message-ID: <CAAhSdy0DcB2+vJSEBd5apQhzjFBz9haNTVqqTeX92+hYVyhB2A@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] RISC-V: Enable CPU_IDLE drivers
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 11:46 AM Guo Ren <guoren@kernel.org> wrote:
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
> small questions:
>
> On Wed, Jan 26, 2022 at 7:46 PM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > We force select CPU_PM and provide asm/cpuidle.h so that we can
> > use CPU IDLE drivers for Linux RISC-V kernel.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Anup Patel <apatel@vetanamicro.com>
> > ---
> >  arch/riscv/Kconfig                |  7 +++++++
> >  arch/riscv/configs/defconfig      |  1 +
> >  arch/riscv/configs/rv32_defconfig |  1 +
> >  arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
> >  arch/riscv/kernel/process.c       |  3 ++-
> >  5 files changed, 35 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/include/asm/cpuidle.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 5adcbd9b5e88..76976d12b463 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -46,6 +46,7 @@ config RISCV
> >         select CLONE_BACKWARDS
> >         select CLINT_TIMER if !MMU
> >         select COMMON_CLK
> > +       select CPU_PM if CPU_IDLE
> >         select EDAC_SUPPORT
> >         select GENERIC_ARCH_TOPOLOGY if SMP
> >         select GENERIC_ATOMIC64 if !64BIT
> > @@ -547,4 +548,10 @@ source "kernel/power/Kconfig"
> >
> >  endmenu
> >
> > +menu "CPU Power Management"
> > +
> > +source "drivers/cpuidle/Kconfig"
> > +
> > +endmenu
> > +
> >  source "arch/riscv/kvm/Kconfig"
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index f120fcc43d0a..a5e0482a4969 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_VIRT=y
> >  CONFIG_SMP=y
> >  CONFIG_HOTPLUG_CPU=y
> > +CONFIG_CPU_IDLE=y
> >  CONFIG_VIRTUALIZATION=y
> >  CONFIG_KVM=m
> >  CONFIG_JUMP_LABEL=y
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> > index 8b56a7f1eb06..d1b87db54d68 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
> >  CONFIG_ARCH_RV32I=y
> >  CONFIG_SMP=y
> >  CONFIG_HOTPLUG_CPU=y
> > +CONFIG_CPU_IDLE=y
> >  CONFIG_VIRTUALIZATION=y
> >  CONFIG_KVM=m
> >  CONFIG_JUMP_LABEL=y
> > diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
> > new file mode 100644
> > index 000000000000..71fdc607d4bc
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/cpuidle.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2021 Allwinner Ltd
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#ifndef _ASM_RISCV_CPUIDLE_H
> > +#define _ASM_RISCV_CPUIDLE_H
> > +
> > +#include <asm/barrier.h>
> > +#include <asm/processor.h>
> > +
> > +static inline void cpu_do_idle(void)
> > +{
> > +       /*
> > +        * Add mb() here to ensure that all
> > +        * IO/MEM accesses are completed prior
> > +        * to entering WFI.
> > +        */
> > +       mb();
> I think it's a separate fixup.

This one is tricky to move as separate fixup because there
is no cpu_do_idle() until this patch adds it.

If we deliberately have a separate patch for "mb()" then it
will be only fixing cpu_do_idle() function added by previous
patch in the same series.

Regards,
Anup

>
> > +       wait_for_interrupt();
> > +}
> > +
> > +#endif
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 03ac3aa611f5..504b496787aa 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/string.h>
> >  #include <asm/switch_to.h>
> >  #include <asm/thread_info.h>
> > +#include <asm/cpuidle.h>
> >
> >  register unsigned long gp_in_global __asm__("gp");
> >
> > @@ -37,7 +38,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
> >
> >  void arch_cpu_idle(void)
> >  {
> maybe below is enough.
> + mb();
>    wait_for_interrupt();
>
> > -       wait_for_interrupt();
> > +       cpu_do_idle();
>
>
> >         raw_local_irq_enable();
> >  }
> >
> > --
> > 2.25.1
> >
> >
> > --
> > kvm-riscv mailing list
> > kvm-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kvm-riscv
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
