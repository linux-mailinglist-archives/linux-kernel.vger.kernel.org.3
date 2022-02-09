Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A74AE9D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiBIGCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:02:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiBIGAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:00:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779BC0302E1;
        Tue,  8 Feb 2022 22:00:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F26F61672;
        Wed,  9 Feb 2022 06:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C951C340F6;
        Wed,  9 Feb 2022 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644386414;
        bh=H1Il4OnrZcVzTgnRCSfIq6w+2cA8lG5GY5uvlt5naWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qtkir0ujjb3mIuWq7ct9FTz1yRDsLAWnTNN3gaiC/I8cPPPCuezabteArA7REpv7F
         KycdMcfVAsPHB25wa3B8wIzZmErdwXbJWeojnfz2e/FN3kRCgPoWhpzuR53iXc1Zdl
         4LaiXrFP9RKO+1pHDtfwPVyR5EgwswdNl263d3zGaRsiRQQYm3uTpx8AWvJMgVYfWD
         jLdD6o94RMOEVu1kS8GE+FY8/7qmB8Xs6JTNx+i2x+XKN4rg4rsorPNtam+Jm4KAIN
         W9D1+yLFUCVwBkY4hbGXlTxiLS+NObLhQ6VbjFG4BBY5WhzpR6DPgcgztPfBK76Qvg
         /WWmFgfjXLRLA==
Received: by mail-vs1-f42.google.com with SMTP id g10so1471601vss.1;
        Tue, 08 Feb 2022 22:00:14 -0800 (PST)
X-Gm-Message-State: AOAM5306oBm91eBTViow08Erazb3V4WBpIY1UW8mRgtI0KRhnFdCdkNf
        hXE4M/myHq+QgSzPcuBhKc7WiQisHhB3XsYhsTU=
X-Google-Smtp-Source: ABdhPJx7IxmUfwBXIDyqbMr6LV1Uy4FTIuhRCLFMgyRqUGbgmGiKMiWYLu9DY913QWMQFaNwyWxJN7W1AENziNBBsuI=
X-Received: by 2002:a67:e0d9:: with SMTP id m25mr200489vsl.51.1644386413208;
 Tue, 08 Feb 2022 22:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com>
 <20220126114452.692512-2-apatel@ventanamicro.com> <CAJF2gTSwzx-yC=WvFixT96=q+M0KPzaZH5PpgGKVWg42M4GBNw@mail.gmail.com>
 <CAAhSdy0DcB2+vJSEBd5apQhzjFBz9haNTVqqTeX92+hYVyhB2A@mail.gmail.com>
In-Reply-To: <CAAhSdy0DcB2+vJSEBd5apQhzjFBz9haNTVqqTeX92+hYVyhB2A@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Feb 2022 14:00:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRy_VNBAW94KoeAcBWH52ac+PE0H8Km17kKuyUy1NsfDQ@mail.gmail.com>
Message-ID: <CAJF2gTRy_VNBAW94KoeAcBWH52ac+PE0H8Km17kKuyUy1NsfDQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] RISC-V: Enable CPU_IDLE drivers
To:     Anup Patel <anup@brainfault.org>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 1:15 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Feb 8, 2022 at 11:46 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> >
> > small questions:
> >
> > On Wed, Jan 26, 2022 at 7:46 PM Anup Patel <apatel@ventanamicro.com> wrote:
> > >
> > > From: Anup Patel <anup.patel@wdc.com>
> > >
> > > We force select CPU_PM and provide asm/cpuidle.h so that we can
> > > use CPU IDLE drivers for Linux RISC-V kernel.
> > >
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > > Signed-off-by: Anup Patel <apatel@vetanamicro.com>
> > > ---
> > >  arch/riscv/Kconfig                |  7 +++++++
> > >  arch/riscv/configs/defconfig      |  1 +
> > >  arch/riscv/configs/rv32_defconfig |  1 +
> > >  arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
> > >  arch/riscv/kernel/process.c       |  3 ++-
> > >  5 files changed, 35 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/riscv/include/asm/cpuidle.h
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 5adcbd9b5e88..76976d12b463 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -46,6 +46,7 @@ config RISCV
> > >         select CLONE_BACKWARDS
> > >         select CLINT_TIMER if !MMU
> > >         select COMMON_CLK
> > > +       select CPU_PM if CPU_IDLE
> > >         select EDAC_SUPPORT
> > >         select GENERIC_ARCH_TOPOLOGY if SMP
> > >         select GENERIC_ATOMIC64 if !64BIT
> > > @@ -547,4 +548,10 @@ source "kernel/power/Kconfig"
> > >
> > >  endmenu
> > >
> > > +menu "CPU Power Management"
> > > +
> > > +source "drivers/cpuidle/Kconfig"
> > > +
> > > +endmenu
> > > +
> > >  source "arch/riscv/kvm/Kconfig"
> > > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > > index f120fcc43d0a..a5e0482a4969 100644
> > > --- a/arch/riscv/configs/defconfig
> > > +++ b/arch/riscv/configs/defconfig
> > > @@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
> > >  CONFIG_SOC_VIRT=y
> > >  CONFIG_SMP=y
> > >  CONFIG_HOTPLUG_CPU=y
> > > +CONFIG_CPU_IDLE=y
> > >  CONFIG_VIRTUALIZATION=y
> > >  CONFIG_KVM=m
> > >  CONFIG_JUMP_LABEL=y
> > > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> > > index 8b56a7f1eb06..d1b87db54d68 100644
> > > --- a/arch/riscv/configs/rv32_defconfig
> > > +++ b/arch/riscv/configs/rv32_defconfig
> > > @@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
> > >  CONFIG_ARCH_RV32I=y
> > >  CONFIG_SMP=y
> > >  CONFIG_HOTPLUG_CPU=y
> > > +CONFIG_CPU_IDLE=y
> > >  CONFIG_VIRTUALIZATION=y
> > >  CONFIG_KVM=m
> > >  CONFIG_JUMP_LABEL=y
> > > diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
> > > new file mode 100644
> > > index 000000000000..71fdc607d4bc
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/cpuidle.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2021 Allwinner Ltd
> > > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > > + */
> > > +
> > > +#ifndef _ASM_RISCV_CPUIDLE_H
> > > +#define _ASM_RISCV_CPUIDLE_H
> > > +
> > > +#include <asm/barrier.h>
> > > +#include <asm/processor.h>
> > > +
> > > +static inline void cpu_do_idle(void)
> > > +{
> > > +       /*
> > > +        * Add mb() here to ensure that all
> > > +        * IO/MEM accesses are completed prior
> > > +        * to entering WFI.
> > > +        */
> > > +       mb();
> > I think it's a separate fixup.
>
> This one is tricky to move as separate fixup because there
> is no cpu_do_idle() until this patch adds it.
>
> If we deliberately have a separate patch for "mb()" then it
> will be only fixing cpu_do_idle() function added by previous
> patch in the same series.
You are right, I misunderstood the usage of asm/cpuidle.h.

>
> Regards,
> Anup
>
> >
> > > +       wait_for_interrupt();
> > > +}
> > > +
> > > +#endif
> > > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > > index 03ac3aa611f5..504b496787aa 100644
> > > --- a/arch/riscv/kernel/process.c
> > > +++ b/arch/riscv/kernel/process.c
> > > @@ -23,6 +23,7 @@
> > >  #include <asm/string.h>
> > >  #include <asm/switch_to.h>
> > >  #include <asm/thread_info.h>
> > > +#include <asm/cpuidle.h>
> > >
> > >  register unsigned long gp_in_global __asm__("gp");
> > >
> > > @@ -37,7 +38,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
> > >
> > >  void arch_cpu_idle(void)
> > >  {
> > maybe below is enough.
> > + mb();
> >    wait_for_interrupt();
> >
> > > -       wait_for_interrupt();
> > > +       cpu_do_idle();
> >
> >
> > >         raw_local_irq_enable();
> > >  }
> > >
> > > --
> > > 2.25.1
> > >
> > >
> > > --
> > > kvm-riscv mailing list
> > > kvm-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kvm-riscv
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
