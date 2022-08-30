Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34E5A5A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiH3Dmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiH3Dmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB90AA35E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E9960DD3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843BFC433D7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661830944;
        bh=mBW5FtoKnnnaL+K6o3RnHXaTm9HKtehsxRM2sJuCIXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZqS3Ah07Kv8aM6yyWGj494sccRN0PZybGPTGYDLNHosY7VAIZ+zNnSz8Birj4r79d
         jedoZwLYQfo8K37PfZFpDCLXmKo/NUziKM0PQow5kdzccJ5yKmxogGODX4LFbLZYr+
         PdhYwHEOP4jc7TneJcWeWIv1mHXPHANA8citv3OWrvOKCHijZyptOHSxQiFya1+lNI
         8czJkFT/Y473YLA/jJzLx869O/DmokpAaXAN3Xn4xgzwfV1xDdnqCF3i3Zc8+xn87j
         Ym7LE0h4dK8igL9ANDaGCZkhp0TX+ZetwUpynepDUmFJaXuXeHYNeaUC0/jgltEShP
         i/ADQsasoChtw==
Received: by mail-vs1-f50.google.com with SMTP id 190so10280300vsz.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:42:24 -0700 (PDT)
X-Gm-Message-State: ACgBeo3tcU+KzEOL51t+qqsBrxpzRAsUIPfuITSJPIeuPdUb1UUn7qK6
        QCxDR8j+LX8eKDJ+IErOV3ieYUTZ4XcDd3cu+Qs=
X-Google-Smtp-Source: AA6agR6WB3+wRRR16uzGAkhlFRc+kYYxKUrMhk9MLnWaDbf6lzjCzbsAMomOPRjalOsk2hGMrkXoDa065QgUWl6haf4=
X-Received: by 2002:a67:d49e:0:b0:390:dccf:23c8 with SMTP id
 g30-20020a67d49e000000b00390dccf23c8mr2536761vsj.59.1661830943424; Mon, 29
 Aug 2022 20:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <1661747823-23745-1-git-send-email-tangyouling@loongson.cn>
 <1661747823-23745-2-git-send-email-tangyouling@loongson.cn>
 <e981e841-c43c-bbc5-a0f9-1077be9811cb@loongson.cn> <19b78960-8c5e-fc5f-c102-12db7aedb548@loongson.cn>
In-Reply-To: <19b78960-8c5e-fc5f-c102-12db7aedb548@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 30 Aug 2022 11:42:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7ZoHrH2UbFbt4aDxDUfRjrJafiEHa5U0jcuQnvV4AyLw@mail.gmail.com>
Message-ID: <CAAhV-H7ZoHrH2UbFbt4aDxDUfRjrJafiEHa5U0jcuQnvV4AyLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] LoongArch: Add kexec support
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Jinyang He <hejinyang@loongson.cn>, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Aug 30, 2022 at 11:26 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
> Hi, Jinyang
>
> On 08/30/2022 09:53 AM, Jinyang He wrote:
> > Hi, Youling,
> >
> >
> > On 08/29/2022 12:37 PM, Youling Tang wrote:
> >> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to
> >> the
> >> LoongArch architecture that add support for the kexec re-boot mechanis
> >> (CONFIG_KEXEC) on LoongArch platforms.
> >>
> >> Supports loading vmlinux (vmlinux.elf) in ELF format and vmlinux.efi in
> >> PE format.
> >>
> >> I tested this on  LoongArch 3A5000 machine and works as expected,
> >>
> >>   $ sudo kexec -l /boot/vmlinux.efi --reuse-cmdline
> >>   $ sudo kexec -e
> >>
> >> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> >> ---
> >>   arch/loongarch/Kconfig                  |  11 ++
> >>   arch/loongarch/include/asm/kexec.h      |  58 ++++++++
> >>   arch/loongarch/kernel/Makefile          |   2 +
> >>   arch/loongarch/kernel/head.S            |   7 +-
> >>   arch/loongarch/kernel/machine_kexec.c   | 178 ++++++++++++++++++++++++
> >>   arch/loongarch/kernel/relocate_kernel.S | 125 +++++++++++++++++
> >>   6 files changed, 380 insertions(+), 1 deletion(-)
> >>   create mode 100644 arch/loongarch/include/asm/kexec.h
> >>   create mode 100644 arch/loongarch/kernel/machine_kexec.c
> >>   create mode 100644 arch/loongarch/kernel/relocate_kernel.S
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index 45364cffc793..903c82fa958d 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -409,6 +409,17 @@ config FORCE_MAX_ZONEORDER
> >>         The page size is not necessarily 4KB.  Keep this in mind
> >>         when choosing a value for this option.
> >>   +config KEXEC
> >> +    bool "Kexec system call"
> >> +    select KEXEC_CORE
> >> +    help
> >> +      kexec is a system call that implements the ability to shutdown
> >> your
> >> +      current kernel, and to start another kernel.  It is like a reboot
> >> +      but it is independent of the system firmware.   And like a reboot
> >> +      you can start any kernel with it, not just Linux.
> >> +
> >> +      The name comes from the similarity to the exec system call.
> >> +
> >>   config SECCOMP
> >>       bool "Enable seccomp to safely compute untrusted bytecode"
> >>       depends on PROC_FS
> >> diff --git a/arch/loongarch/include/asm/kexec.h
> >> b/arch/loongarch/include/asm/kexec.h
> >> new file mode 100644
> >> index 000000000000..5c9e7b5eccb8
> >> --- /dev/null
> >> +++ b/arch/loongarch/include/asm/kexec.h
> >> @@ -0,0 +1,58 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * kexec.h for kexec
> >> + *
> >> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> >> + */
> >> +
> >> +#ifndef _ASM_KEXEC_H
> >> +#define _ASM_KEXEC_H
> >> +
> >> +#include <asm/stacktrace.h>
> >> +#include <asm/page.h>
> >> +
> >> +/* Maximum physical address we can use pages from */
> >> +#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
> >> +/* Maximum address we can reach in physical address mode */
> >> +#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
> >> + /* Maximum address we can use for the control code buffer */
> >> +#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
> >> +
> >> +/* Reserve a page for the control code buffer */
> >> +#define KEXEC_CONTROL_PAGE_SIZE PAGE_SIZE
> >> +
> >> +/* The native architecture */
> >> +#define KEXEC_ARCH KEXEC_ARCH_LOONGARCH
> >> +
> >> +static inline void crash_setup_regs(struct pt_regs *newregs,
> >> +                    struct pt_regs *oldregs)
> >> +{
> >> +    if (oldregs)
> >> +        memcpy(newregs, oldregs, sizeof(*newregs));
> >> +    else
> >> +        prepare_frametrace(newregs);
> >> +}
> >> +
> >> +#define ARCH_HAS_KIMAGE_ARCH
> >> +
> >> +struct kimage_arch {
> >> +    unsigned long boot_flag;
> >> +    unsigned long fdt_addr;
> >> +};
> >> +
> >> +typedef void (*do_kexec_t)(unsigned long boot_flag,
> >> +               unsigned long fdt_addr,
> >> +               unsigned long first_ind_entry,
> >> +               unsigned long jump_addr);
> >> +
> >> +struct kimage;
> >> +extern const unsigned char relocate_new_kernel[];
> >> +extern const size_t relocate_new_kernel_size;
> >> +
> >> +#ifdef CONFIG_SMP
> >> +extern atomic_t kexec_ready_to_reboot;
> >> +extern const unsigned char kexec_smp_wait[];
> >> +extern void kexec_reboot(void);
> >> +#endif
> >> +
> >> +#endif /* !_ASM_KEXEC_H */
> >> diff --git a/arch/loongarch/kernel/Makefile
> >> b/arch/loongarch/kernel/Makefile
> >> index a213e994db68..20b64ac3f128 100644
> >> --- a/arch/loongarch/kernel/Makefile
> >> +++ b/arch/loongarch/kernel/Makefile
> >> @@ -17,6 +17,8 @@ obj-$(CONFIG_CPU_HAS_FPU)    += fpu.o
> >>   obj-$(CONFIG_MODULES)        += module.o module-sections.o
> >>   obj-$(CONFIG_STACKTRACE)    += stacktrace.o
> >>   +obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o
> >> +
> >>   obj-$(CONFIG_PROC_FS)        += proc.o
> >>     obj-$(CONFIG_SMP)        += smp.o
> >> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> >> index 01bac62a6442..22bdf4928325 100644
> >> --- a/arch/loongarch/kernel/head.S
> >> +++ b/arch/loongarch/kernel/head.S
> >> @@ -20,7 +20,12 @@
> >>     _head:
> >>       .word    MZ_MAGIC        /* "MZ", MS-DOS header */
> >> -    .org    0x3c            /* 0x04 ~ 0x3b reserved */
> >> +    .org    0x8
> >> +    .quad    0            /* Image load offset from start of RAM */
> >> +    .dword    _end - _text        /* Effective size of kernel image */
> >> +    .quad    0
> >> +    .dword    kernel_entry        /* Kernel entry point */
> >> +    .org    0x3c            /* 0x28 ~ 0x3b reserved */
> >>       .long    pe_header - _head    /* Offset to the PE header */
> >>     pe_header:
> >> diff --git a/arch/loongarch/kernel/machine_kexec.c
> >> b/arch/loongarch/kernel/machine_kexec.c
> >> new file mode 100644
> >> index 000000000000..4ffcd4cd9c8c
> >> --- /dev/null
> >> +++ b/arch/loongarch/kernel/machine_kexec.c
> >> @@ -0,0 +1,178 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * machine_kexec.c for kexec
> >> + *
> >> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> >> + */
> >> +#include <linux/compiler.h>
> >> +#include <linux/cpu.h>
> >> +#include <linux/kexec.h>
> >> +#include <linux/mm.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/libfdt.h>
> >> +#include <linux/of_fdt.h>
> >> +
> >> +#include <asm/bootinfo.h>
> >> +#include <asm/cacheflush.h>
> >> +#include <asm/page.h>
> >> +
> >> +/* 0x100000 ~ 0x200000 is safe */
> >> +#define KEXEC_CTRL_CODE    TO_CACHE(0x100000UL)
> >> +#define KEXEC_BLOB_ADDR    TO_CACHE(0x108000UL)
> >> +
> >> +static unsigned long reboot_code_buffer;
> >> +#ifdef CONFIG_SMP
> >> +void (*relocated_kexec_smp_wait)(void *);
> >> +atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
> >> +#endif
> >> +
> >> +static unsigned long jump_addr;
> >> +static unsigned long first_ind_entry;
> >> +static unsigned long boot_flag;
> >> +static unsigned long fdt_addr;
> >> +
> >> +static void kexec_image_info(const struct kimage *kimage)
> >> +{
> >> +    unsigned long i;
> >> +
> >> +    pr_debug("kexec kimage info:\n");
> >> +    pr_debug("\ttype:        %d\n", kimage->type);
> >> +    pr_debug("\tstart:       %lx\n", kimage->start);
> >> +    pr_debug("\thead:        %lx\n", kimage->head);
> >> +    pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
> >> +
> >> +    for (i = 0; i < kimage->nr_segments; i++) {
> >> +        pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
> >> +            kimage->segment[i].mem,
> >> +            kimage->segment[i].mem + kimage->segment[i].memsz);
> >> +        pr_debug("\t\t0x%lx bytes, %lu pages\n",
> >> +            (unsigned long)kimage->segment[i].memsz,
> >> +            (unsigned long)kimage->segment[i].memsz /  PAGE_SIZE);
> >> +    }
> >> +}
> >> +
> >> +int machine_kexec_prepare(struct kimage *kimage)
> >> +{
> >> +    int i;
> >> +    void *dtb = (void *)KEXEC_BLOB_ADDR;
> >> +
> >> +    kexec_image_info(kimage);
> >> +
> >> +    /* Find the Flattened Device Tree */
> >> +    for (i = 0; i < kimage->nr_segments; i++) {
> >> +        if (!fdt_check_header(kimage->segment[i].buf)) {
> >> +            memcpy(dtb, kimage->segment[i].buf, SZ_64K);
> >> +            kimage->arch.boot_flag = fw_arg0;
> >> +            kimage->arch.fdt_addr = (unsigned long) dtb;
> >> +            break;
> >> +        }
> >> +        continue;
> >> +    }
> >> +
> >> +    /* kexec need a safe page to save reboot_code_buffer */
> >> +    kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
> >> +
> >> +    reboot_code_buffer =
> >> +      (unsigned long)page_address(kimage->control_code_page);
> >> +    memcpy((void *)reboot_code_buffer, relocate_new_kernel,
> >> +           relocate_new_kernel_size);
> > It copys same content to KEXEC_CTRL_CODE each time, could we do this at
> > boot time?
> I think it's possible to have the copy action happen at boot-time or
> during the prepare phase. (RISCV in prepare, MIPS in boot-time)
>
> >
> > BTW, our system always keep the low-2MB no used, on mips-loongson or
> > LoongArch. Is that necessary on LoongArch? We cannot use parameter
> > 'mem=YYM' normally but 'mem=YYM@2M' is ok. And the low-2MB is not
> > in virtual memory management, although we can get it in kernel.
> For existing kernels, the low 2M has been reserved by
> memblock_reserve(PHYS_OFFSET, 0x200000), maybe it is acceptable to keep
> the low 2M behavior.
>
> Yes, we need to use "mem=YM@2M" if the low 2M is reserved.
>
> >
> > In kexec/kdump process, we can follows kimage_alloc_control_pages().
> > When the boot cpu copy complete the second-kernels, all cpus can jump
> > to a kernel-entry-trampoline which is in kernel image. Then we don't
> > worry about the code can be destroyed. The kernel-entry-trampoline
> > get its cpuid, keep non-boot cpus do as kexec_smp_wait and let boot
> > cpu go kernel-entry. In this way we can drop the low-2MB IMO.
>
> It is also feasible to dynamically allocate control pages, but it is
> easier to use a low 2M approach. What do you think, Huacai?
I prefer to use the low 2MB.

Huacai
>
> >
> >> +
> >> +    /* All secondary cpus now may jump to kexec_smp_wait cycle */
> >> +    relocated_kexec_smp_wait = reboot_code_buffer +
> >> +        (void *)(kexec_smp_wait - relocate_new_kernel);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +void machine_kexec_cleanup(struct kimage *kimage)
> >> +{
> >> +}
> >> +
> >> +#ifdef CONFIG_SMP
> >> +void kexec_reboot(void)
> >> +{
> >> +    do_kexec_t do_kexec = NULL;
> >> +
> >> +    /* All secondary cpus go to kexec_smp_wait */
> >> +    if (smp_processor_id() > 0) {
> >> +        relocated_kexec_smp_wait(NULL);
> >> +        unreachable();
> >> +    }
> >> +
> >> +    do_kexec = (void *)reboot_code_buffer;
> >> +    do_kexec(boot_flag, fdt_addr, first_ind_entry, jump_addr);
> >> +
> >> +    unreachable();
> >> +}
> >> +
> >> +static void kexec_shutdown_secondary(void *)
> >> +{
> >> +    local_irq_disable();
> >> +    while (!atomic_read(&kexec_ready_to_reboot))
> >> +        cpu_relax();
> >> +
> >> +    kexec_reboot();
> >> +}
> >> +
> >> +void machine_crash_shutdown(struct pt_regs *regs)
> >> +{
> >> +}
> >> +#endif
> >> +
> >> +void machine_shutdown(void)
> >> +{
> >> +    smp_call_function(kexec_shutdown_secondary, NULL, 0);
> >> +}
> >> +
> >> +void machine_kexec(struct kimage *image)
> >> +{
> >> +    unsigned long entry;
> >> +    unsigned long *ptr;
> >> +    struct kimage_arch *internal = &image->arch;
> >> +
> >> +    boot_flag = internal->boot_flag;
> >> +    fdt_addr = internal->fdt_addr;
> >> +
> >> +    jump_addr = (unsigned long)phys_to_virt(image->start);
> >> +
> >> +    first_ind_entry = (unsigned long)phys_to_virt(image->head &
> >> PAGE_MASK);
> >> +
> >> +    /*
> >> +     * The generic kexec code builds a page list with physical
> >> +     * addresses. they are directly accessible through XKPRANGE
> >> +     * hence the phys_to_virt() call.
> >> +     */
> >> +    for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE);
> >> +         ptr = (entry & IND_INDIRECTION) ?
> >> +           phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
> >> +        if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
> >> +            *ptr & IND_DESTINATION)
> >> +            *ptr = (unsigned long) phys_to_virt(*ptr);
> >> +    }
> >> +
> >> +    /* Mark offline before disabling local irq. */
> >> +    set_cpu_online(smp_processor_id(), false);
> >> +
> >> +    /* we do not want to be bothered. */
> >> +    local_irq_disable();
> >> +
> >> +    pr_notice("Will call new kernel at %lx\n", jump_addr);
> >> +    pr_notice("FDT image at %lx\n", fdt_addr);
> >> +    pr_notice("Bye ...\n");
> >> +
> >> +    /* Make reboot code buffer available to the boot CPU. */
> >> +    flush_cache_all();
> >> +
> >> +    atomic_set(&kexec_ready_to_reboot, 1);
> >> +
> >> +    /*
> >> +     * We know we were online, and there will be no incoming IPIs at
> >> +     * this point.
> >> +     */
> >> +    set_cpu_online(smp_processor_id(), true);
> >> +
> >> +    /* Ensure remote CPUs observe that we're online before rebooting. */
> >> +    smp_mb__after_atomic();
> >> +
> >> +    kexec_reboot();
> >> +}
> >> diff --git a/arch/loongarch/kernel/relocate_kernel.S
> >> b/arch/loongarch/kernel/relocate_kernel.S
> >> new file mode 100644
> >> index 000000000000..d1f242f74ea8
> >> --- /dev/null
> >> +++ b/arch/loongarch/kernel/relocate_kernel.S
> >> @@ -0,0 +1,125 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * relocate_kernel.S for kexec
> >> + *
> >> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> >> + */
> >> +
> >> +#include <linux/kexec.h>
> >> +
> >> +#include <asm/asm.h>
> >> +#include <asm/asmmacro.h>
> >> +#include <asm/regdef.h>
> >> +#include <asm/loongarch.h>
> >> +#include <asm/stackframe.h>
> >> +#include <asm/addrspace.h>
> >> +
> >> +#define IPI_REG_BASE 0x1fe01000
> >> +
> >> +SYM_CODE_START(relocate_new_kernel)
> >> +    /*
> >> +     * s0: Boot flag passed to the new kernel
> >> +     * s1: Virt address of the FDT image
> >> +     * s2: Pointer to the current entry
> >> +     * s3: Virt address to jump to after relocation
> >> +     */
> >> +    move        s0, a0
> >> +    move        s1, a1
> >> +    move        s2, a2
> >> +    move        s3, a3
> >> +
> >> +process_entry:
> >> +    PTR_L        s4, s2, 0
> >> +    PTR_ADDI    s2, s2, SZREG
> >> +
> >> +    /* destination page */
> >> +    andi        s5, s4, IND_DESTINATION
> >> +    beqz        s5, 1f
> >> +    li.w        t0, ~0x1
> >> +    and        s6, s4, t0    /* store destination addr in s6 */
> >> +    b        process_entry
> >> +
> >> +1:
> >> +    /* indirection page, update s2    */
> >> +    andi        s5, s4, IND_INDIRECTION
> >> +    beqz        s5, 1f
> >> +    li.w        t0, ~0x2
> >> +    and        s2, s4, t0
> >> +    b        process_entry
> >> +
> >> +1:
> >> +    /* done page */
> >> +    andi        s5, s4, IND_DONE
> >> +    beqz        s5, 1f
> >> +    b        done
> >> +1:
> >> +    /* source page */
> >> +    andi        s5, s4, IND_SOURCE
> >> +    beqz        s5, process_entry
> >> +    li.w        t0, ~0x8
> >> +    and        s4, s4, t0
> >> +    li.w        s8, (1 << _PAGE_SHIFT) / SZREG
> >> +
> >> +copy_word:
> >> +    /* copy page word by word */
> >> +    REG_L        s7, s4, 0
> >> +    REG_S        s7, s6, 0
> >> +    PTR_ADDI    s6, s6, SZREG
> >> +    PTR_ADDI    s4, s4, SZREG
> >> +    LONG_ADDI    s8, s8, -1
> >> +    beqz        s8, process_entry
> >> +    b        copy_word
> >> +    b        process_entry
> >> +
> >> +done:
> >> +    dbar        0
> > ibar, too?
>
> Will add ibar 0.
>
> >> +
> >> +    move        a0, s0
> >> +    move        a1, s1
> >> +    /* jump to the new kernel */
> >> +    jr        s3
> >> +SYM_CODE_END(relocate_new_kernel)
> >> +
> >> +#ifdef CONFIG_SMP
> >> +/*
> >> + * Other CPUs should wait until code is relocated and
> >> + * then start at entry (?) point.
> >> + */
> >> +SYM_CODE_START(kexec_smp_wait)
> >> +    li.d        t0, IPI_REG_BASE
> >> +    li.d        t1, UNCACHE_BASE
> >> +    or        t0, t0, t1
> >> +
> >> +    /*
> >> +     * s1:initfn
> >> +     * t0:base t1:cpuid t2:node t3:core t4:count
> >> +     */
> >> +    csrrd        t1, LOONGARCH_CSR_CPUID
> >> +    andi        t1, t1, CSR_CPUID_COREID
> >> +    andi        t3, t1, 0x3
> >> +    slli.w        t3, t3, 8              /* get core id */
> >> +    or        t0, t0, t3
> >> +    andi        t2, t1, 0x3c
> >> +    slli.d        t2, t2, 42             /* get node id */
> >> +    or        t0, t0, t2
> >> +
> >> +1:    li.w        t4, 0x100              /* wait for init loop */
> >> +2:    addi.w        t4, t4, -1             /* limit mailbox access */
> >> +    bnez        t4, 2b
> >> +    ld.w        s1, t0, 0x20           /* check PC as an indicator */
> > Can we do this with iocsr*?
>
> OK, I will consider the implementation in the iocsr way.
>
> Thanks,
> Youling
> >
> > Thanks,
> > Jinyang
> >> +    beqz        s1, 1b
> >> +    ld.d        s1, t0, 0x20           /* get PC via mailbox */
> >> +    ld.d        sp, t0, 0x28           /* get SP via mailbox */
> >> +    ld.d        tp, t0, 0x30           /* get TP via mailbox */
> >> +
> >> +    li.d        t0, CACHE_BASE
> >> +    or        s1, s1, t0
> >> +    jr        s1                     /* jump to initial PC */
> >> +SYM_CODE_END(kexec_smp_wait)
> >> +#endif
> >> +
> >> +relocate_new_kernel_end:
> >> +
> >> +SYM_DATA_START(relocate_new_kernel_size)
> >> +    PTR        relocate_new_kernel_end - relocate_new_kernel
> >> +SYM_DATA_END(relocate_new_kernel_size)
> >
>
