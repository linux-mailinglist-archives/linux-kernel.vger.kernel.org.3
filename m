Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12174AD16A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347057AbiBHGSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbiBHGSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:18:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E7C0401DC;
        Mon,  7 Feb 2022 22:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8AA87CE1387;
        Tue,  8 Feb 2022 06:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E939CC340FA;
        Tue,  8 Feb 2022 06:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644301087;
        bh=bcyM3RjewULR0uCg0140crXcx/yoe7zOyBhNGMjlITo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eXXLFr4C66lqh+Iz3Xfci8rLN0w0tF6JqHXed2bByTay1JpJ3Je4NVf+AZtlvW3p1
         5Kxyr04nL/FYkrBbDRCQpn2C1Rw4xsOR7laOUOzJbw1xwcuzScpKA+3KCCBoVNOVzX
         5qazvlCFHM8A7rIpsk90jIjWCWH3vquyhys+Y8NruVePD7V6AacwNOD5HTIIBYjM0K
         BMzlPNlRl3iV260v/CQRREANcTE0uT0/QOckbMTvkNAubBdIT5aP8Q7fdzXLqAKvJr
         OZiclQ8hZLcRpzNl2flabLlpCz66GG1Gz7BegJvv3vsEu+F2NVOWjRYBjG9D7UbC13
         8ShEeHJ38t99g==
Received: by mail-vs1-f49.google.com with SMTP id t184so2267888vst.13;
        Mon, 07 Feb 2022 22:18:06 -0800 (PST)
X-Gm-Message-State: AOAM533bPQNwHPrdB+ThyKW6QYaPfRMn19BB4iQod/WcbQ3AHU4DLLi/
        VHe9QuaeWvzrbOGd+vZTarqS/8olMe0yyAaPrFQ=
X-Google-Smtp-Source: ABdhPJz3w2d6s9VOlMRRjmQwmjiLlix5y/TTWSI1AS8OD8XI1kNHVBgVtQ0uJOBjmWapQqoV6yigRRZ/Yei5BFq0Cuo=
X-Received: by 2002:a67:f94e:: with SMTP id u14mr1097842vsq.2.1644301085680;
 Mon, 07 Feb 2022 22:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com> <20220126114452.692512-4-apatel@ventanamicro.com>
In-Reply-To: <20220126114452.692512-4-apatel@ventanamicro.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Feb 2022 14:17:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSe=JPL4DV8M2uCj_nxUO7nVc-a=vn=JwHqbHuPO_LFvA@mail.gmail.com>
Message-ID: <CAJF2gTSe=JPL4DV8M2uCj_nxUO7nVc-a=vn=JwHqbHuPO_LFvA@mail.gmail.com>
Subject: Re: [PATCH v10 3/8] RISC-V: Add arch functions for non-retentive
 suspend entry/exit
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
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

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Jan 26, 2022 at 7:47 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> The hart registers and CSRs are not preserved in non-retentative
> suspend state so we provide arch specific helper functions which
> will save/restore hart context upon entry/exit to non-retentive
> suspend state. These helper functions can be used by cpuidle
> drivers for non-retentive suspend entry/exit.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/asm.h      |  27 +++++++
>  arch/riscv/include/asm/suspend.h  |  36 +++++++++
>  arch/riscv/kernel/Makefile        |   2 +
>  arch/riscv/kernel/asm-offsets.c   |   3 +
>  arch/riscv/kernel/head.S          |  21 -----
>  arch/riscv/kernel/suspend.c       |  87 +++++++++++++++++++++
>  arch/riscv/kernel/suspend_entry.S | 124 ++++++++++++++++++++++++++++++
>  7 files changed, 279 insertions(+), 21 deletions(-)
>  create mode 100644 arch/riscv/include/asm/suspend.h
>  create mode 100644 arch/riscv/kernel/suspend.c
>  create mode 100644 arch/riscv/kernel/suspend_entry.S
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 618d7c5af1a2..48b4baa4d706 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -67,4 +67,31 @@
>  #error "Unexpected __SIZEOF_SHORT__"
>  #endif
>
> +#ifdef __ASSEMBLY__
> +
> +/* Common assembly source macros */
> +
> +#ifdef CONFIG_XIP_KERNEL
> +.macro XIP_FIXUP_OFFSET reg
> +       REG_L t0, _xip_fixup
> +       add \reg, \reg, t0
> +.endm
> +.macro XIP_FIXUP_FLASH_OFFSET reg
> +       la t1, __data_loc
> +       li t0, XIP_OFFSET_MASK
> +       and t1, t1, t0
> +       li t1, XIP_OFFSET
> +       sub t0, t0, t1
> +       sub \reg, \reg, t0
> +.endm
> +_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> +#else
> +.macro XIP_FIXUP_OFFSET reg
> +.endm
> +.macro XIP_FIXUP_FLASH_OFFSET reg
> +.endm
> +#endif /* CONFIG_XIP_KERNEL */
> +
> +#endif /* __ASSEMBLY__ */
> +
>  #endif /* _ASM_RISCV_ASM_H */
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> new file mode 100644
> index 000000000000..8be391c2aecb
> --- /dev/null
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (c) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#ifndef _ASM_RISCV_SUSPEND_H
> +#define _ASM_RISCV_SUSPEND_H
> +
> +#include <asm/ptrace.h>
> +
> +struct suspend_context {
> +       /* Saved and restored by low-level functions */
> +       struct pt_regs regs;
> +       /* Saved and restored by high-level functions */
> +       unsigned long scratch;
> +       unsigned long tvec;
> +       unsigned long ie;
> +#ifdef CONFIG_MMU
> +       unsigned long satp;
> +#endif
> +};
> +
> +/* Low-level CPU suspend entry function */
> +int __cpu_suspend_enter(struct suspend_context *context);
> +
> +/* High-level CPU suspend which will save context and call finish() */
> +int cpu_suspend(unsigned long arg,
> +               int (*finish)(unsigned long arg,
> +                             unsigned long entry,
> +                             unsigned long context));
> +
> +/* Low-level CPU resume entry function */
> +int __cpu_resume_enter(unsigned long hartid, unsigned long context);
> +
> +#endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 612556faa527..13fa5733f5e7 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -48,6 +48,8 @@ obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
>  obj-$(CONFIG_MODULES)          += module.o
>  obj-$(CONFIG_MODULE_SECTIONS)  += module-sections.o
>
> +obj-$(CONFIG_CPU_PM)           += suspend_entry.o suspend.o
> +
>  obj-$(CONFIG_FUNCTION_TRACER)  += mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)   += mcount-dyn.o
>
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index df0519a64eaf..df9444397908 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -13,6 +13,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ptrace.h>
>  #include <asm/cpu_ops_sbi.h>
> +#include <asm/suspend.h>
>
>  void asm_offsets(void);
>
> @@ -113,6 +114,8 @@ void asm_offsets(void)
>         OFFSET(PT_BADADDR, pt_regs, badaddr);
>         OFFSET(PT_CAUSE, pt_regs, cause);
>
> +       OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
> +
>         OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
>         OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
>         OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 5f4c6b6c4974..893b8bb69391 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -16,27 +16,6 @@
>  #include <asm/image.h>
>  #include "efi-header.S"
>
> -#ifdef CONFIG_XIP_KERNEL
> -.macro XIP_FIXUP_OFFSET reg
> -       REG_L t0, _xip_fixup
> -       add \reg, \reg, t0
> -.endm
> -.macro XIP_FIXUP_FLASH_OFFSET reg
> -       la t1, __data_loc
> -       li t0, XIP_OFFSET_MASK
> -       and t1, t1, t0
> -       li t1, XIP_OFFSET
> -       sub t0, t0, t1
> -       sub \reg, \reg, t0
> -.endm
> -_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> -#else
> -.macro XIP_FIXUP_OFFSET reg
> -.endm
> -.macro XIP_FIXUP_FLASH_OFFSET reg
> -.endm
> -#endif /* CONFIG_XIP_KERNEL */
> -
>  __HEAD
>  ENTRY(_start)
>         /*
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> new file mode 100644
> index 000000000000..9ba24fb8cc93
> --- /dev/null
> +++ b/arch/riscv/kernel/suspend.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (c) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/ftrace.h>
> +#include <asm/csr.h>
> +#include <asm/suspend.h>
> +
> +static void suspend_save_csrs(struct suspend_context *context)
> +{
> +       context->scratch = csr_read(CSR_SCRATCH);
> +       context->tvec = csr_read(CSR_TVEC);
> +       context->ie = csr_read(CSR_IE);
> +
> +       /*
> +        * No need to save/restore IP CSR (i.e. MIP or SIP) because:
> +        *
> +        * 1. For no-MMU (M-mode) kernel, the bits in MIP are set by
> +        *    external devices (such as interrupt controller, timer, etc).
> +        * 2. For MMU (S-mode) kernel, the bits in SIP are set by
> +        *    M-mode firmware and external devices (such as interrupt
> +        *    controller, etc).
> +        */
> +
> +#ifdef CONFIG_MMU
> +       context->satp = csr_read(CSR_SATP);
> +#endif
> +}
> +
> +static void suspend_restore_csrs(struct suspend_context *context)
> +{
> +       csr_write(CSR_SCRATCH, context->scratch);
> +       csr_write(CSR_TVEC, context->tvec);
> +       csr_write(CSR_IE, context->ie);
> +
> +#ifdef CONFIG_MMU
> +       csr_write(CSR_SATP, context->satp);
> +#endif
> +}
> +
> +int cpu_suspend(unsigned long arg,
> +               int (*finish)(unsigned long arg,
> +                             unsigned long entry,
> +                             unsigned long context))
> +{
> +       int rc = 0;
> +       struct suspend_context context = { 0 };
> +
> +       /* Finisher should be non-NULL */
> +       if (!finish)
> +               return -EINVAL;
> +
> +       /* Save additional CSRs*/
> +       suspend_save_csrs(&context);
> +
> +       /*
> +        * Function graph tracer state gets incosistent when the kernel
> +        * calls functions that never return (aka finishers) hence disable
> +        * graph tracing during their execution.
> +        */
> +       pause_graph_tracing();
> +
> +       /* Save context on stack */
> +       if (__cpu_suspend_enter(&context)) {
> +               /* Call the finisher */
> +               rc = finish(arg, __pa_symbol(__cpu_resume_enter),
> +                           (ulong)&context);
> +
> +               /*
> +                * Should never reach here, unless the suspend finisher
> +                * fails. Successful cpu_suspend() should return from
> +                * __cpu_resume_entry()
> +                */
> +               if (!rc)
> +                       rc = -EOPNOTSUPP;
> +       }
> +
> +       /* Enable function graph tracer */
> +       unpause_graph_tracing();
> +
> +       /* Restore additional CSRs */
> +       suspend_restore_csrs(&context);
> +
> +       return rc;
> +}
> diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
> new file mode 100644
> index 000000000000..4b07b809a2b8
> --- /dev/null
> +++ b/arch/riscv/kernel/suspend_entry.S
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (c) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/csr.h>
> +
> +       .text
> +       .altmacro
> +       .option norelax
> +
> +ENTRY(__cpu_suspend_enter)
> +       /* Save registers (except A0 and T0-T6) */
> +       REG_S   ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> +       REG_S   sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> +       REG_S   gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> +       REG_S   tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> +       REG_S   s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> +       REG_S   s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> +       REG_S   a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> +       REG_S   a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> +       REG_S   a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> +       REG_S   a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> +       REG_S   a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> +       REG_S   a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> +       REG_S   a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> +       REG_S   s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> +       REG_S   s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> +       REG_S   s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> +       REG_S   s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> +       REG_S   s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> +       REG_S   s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> +       REG_S   s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> +       REG_S   s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> +       REG_S   s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> +       REG_S   s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +
> +       /* Save CSRs */
> +       csrr    t0, CSR_EPC
> +       REG_S   t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> +       csrr    t0, CSR_STATUS
> +       REG_S   t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> +       csrr    t0, CSR_TVAL
> +       REG_S   t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> +       csrr    t0, CSR_CAUSE
> +       REG_S   t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> +
> +       /* Return non-zero value */
> +       li      a0, 1
> +
> +       /* Return to C code */
> +       ret
> +END(__cpu_suspend_enter)
> +
> +ENTRY(__cpu_resume_enter)
> +       /* Load the global pointer */
> +       .option push
> +       .option norelax
> +               la gp, __global_pointer$
> +       .option pop
> +
> +#ifdef CONFIG_MMU
> +       /* Save A0 and A1 */
> +       add     t0, a0, zero
> +       add     t1, a1, zero
> +
> +       /* Enable MMU */
> +       la      a0, swapper_pg_dir
> +       XIP_FIXUP_OFFSET a0
> +       call    relocate_enable_mmu
> +
> +       /* Restore A0 and A1 */
> +       add     a0, t0, zero
> +       add     a1, t1, zero
> +#endif
> +
> +       /* Make A0 point to suspend context */
> +       add     a0, a1, zero
> +
> +       /* Restore CSRs */
> +       REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> +       csrw    CSR_EPC, t0
> +       REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> +       csrw    CSR_STATUS, t0
> +       REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> +       csrw    CSR_TVAL, t0
> +       REG_L   t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> +       csrw    CSR_CAUSE, t0
> +
> +       /* Restore registers (except A0 and T0-T6) */
> +       REG_L   ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> +       REG_L   sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> +       REG_L   gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> +       REG_L   tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> +       REG_L   s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> +       REG_L   s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> +       REG_L   a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> +       REG_L   a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> +       REG_L   a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> +       REG_L   a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> +       REG_L   a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> +       REG_L   a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> +       REG_L   a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> +       REG_L   s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> +       REG_L   s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> +       REG_L   s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> +       REG_L   s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> +       REG_L   s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> +       REG_L   s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> +       REG_L   s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> +       REG_L   s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> +       REG_L   s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> +       REG_L   s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +
> +       /* Return zero value */
> +       add     a0, zero, zero
> +
> +       /* Return to C code */
> +       ret
> +END(__cpu_resume_enter)
> --
> 2.25.1
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
