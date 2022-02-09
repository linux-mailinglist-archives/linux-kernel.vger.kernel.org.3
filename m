Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD274AE938
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiBIFY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:24:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiBIFUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:20:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20676C043180
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:20:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso751103wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAsSnnD9JIeAeZJ9p3BQTgq96g2Q9LHlXoe8+WeEVfI=;
        b=1tKXU6TXAd28+p0tvCpH0D5QBomKCxkddDWl5LVsYFX8hIdbe6CzV6wuulBu+sQEps
         AeaTcuXTxF9e8cIPmKTyUX9QS/MLzuiJ3poPshrD3N/JwthsFwtR7IqmJ/qp78VdQzKC
         EXqidiNi/RX6zBYFOA0F0nOb+555/L5wYmFW+TC4IxgMpILOkbFejGn9NmToUD47VYv6
         VODXl9hVeDhlGEWLaNdgOkZgRtBATLz3GRtmkcoO1HawYxr03sK0DnYLDDdfYEJ4uErA
         Jtbl/MdVrVMc95sx7r0egcRaQ5U2Mm2BKbFsBg2cO/Jq5juetaFMNFhUAyh1A0Te5JOo
         C15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAsSnnD9JIeAeZJ9p3BQTgq96g2Q9LHlXoe8+WeEVfI=;
        b=0jY1KL2c/09jaSG4BhZmuQKibEDP6nLBNXfaAt+G00hZYpTfSyxLehv5dw0sbtFoJ1
         YuxyPH4uXh+gTtiJjGp1cBzjiqr6XSgBJYs5TVR/KDFpfaPMa3VhvcT5+17sPDIgQlkJ
         Mn7iaRAmoCuJvjw1kYOGqPCDxSnsHQ0p5hBB2uh02B1E2xLt2xZ+ptsmASjjvsx8/QCG
         U+7wKN5ahzsiSRbBmFMbSGbJPNdJTECJcQo6iu99b4ICWsFWt+aXXyGbM03Lm3vAsjxM
         zmSj0weZxbDghJ/Z7uIc1YxdEovG+6yyiOCyWm4hDNcmTR7HWBtu0jkQnMaeLpmnuY8y
         MRkQ==
X-Gm-Message-State: AOAM532cxScuvs1dOz6b0uWcfqA6tiTSCGYywSCL4G4tjajnCnoX7CKr
        AtiFa37wHkdwbC3IE+BG7HNVWHyhQy9AeYjEKv/LrQ==
X-Google-Smtp-Source: ABdhPJzHE/r6P/Etiunn5Sn/mWZbmE+jczRf1EpGH91d7ufK0qYetKSekneRBxf/FBI5rfOD4EPdrW88BHZPAe+N0xw=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr496193wmk.59.1644384039591;
 Tue, 08 Feb 2022 21:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com>
 <20220126114452.692512-2-apatel@ventanamicro.com> <CAJF2gTSwzx-yC=WvFixT96=q+M0KPzaZH5PpgGKVWg42M4GBNw@mail.gmail.com>
In-Reply-To: <CAJF2gTSwzx-yC=WvFixT96=q+M0KPzaZH5PpgGKVWg42M4GBNw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 9 Feb 2022 10:50:28 +0530
Message-ID: <CAAhSdy2onHRmnj6g6Swp86DL-nHJyv0r_KsUupatjHx11J11LA@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

We can't add "mb()" here because cpu_do_idle() is called
directly from linux/cpuidle.h and arch_cpu_idle() is only
called when CPU idle is disabled.

Regards,
Anup

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
