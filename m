Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8949C137
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiAZCVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiAZCVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:21:13 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB7C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:21:12 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id k17so11968786ybk.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiMmJYfduKMVo6UJYCl+F5kSzJbGeR2F2JNawBrLMDs=;
        b=eq1tWpRSpNQ5RK1yMKIQuSgWCEwNI9oaVf1dcEhdWUvPx/X/z7iXXECL4vu2Tao/21
         OAfD+L3wN4lgRdDcQ+bU7630Dpd1OhtcX/DKKwk1e5yvvRY4jNJkwa2k1JottL479PKu
         bi/7QZY4g3hmW9O0vYGs54KHFxc0ZNYpDTA5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiMmJYfduKMVo6UJYCl+F5kSzJbGeR2F2JNawBrLMDs=;
        b=z5EMhInqGe5XIQjG4db5y+7JNmbh+cYVuxuTq5eI3iyTxmniZ5Ry0o1TLTWu66u3nK
         Dfuylmyc171J3a1eHlo0dW7bQXpLLH3fM21ekeic5AmCZdW63I5HCC364s6EdK8e15sd
         XXnv0CPM/8pnv3o8OCShvuApg3zryrfnmC3v5oMfd4F6TVDXp1WfduN4nIwEFIEs+GjL
         iXNWOv6n0Vu6JxCiGkO3tWTED2KByGdN12k9d6IdBjWKQ4fLN1OGje/Z9XOO8cH7W3WF
         axbfLwqOuRNilhKeUfoHKx7yGBwwJgYSEsLlbGmJ8LXLDo7vZYrt84kRfiN8bX+KCPB4
         1+nQ==
X-Gm-Message-State: AOAM530Pw9aNiJfjd4kpAlUlzc+Ea5u+lXb3qCsu4+4e6uF+uDXedEn8
        Hl7U7zP3uCjDpwPPUTwmAV8x1VrX+VQKr6FC8WPT
X-Google-Smtp-Source: ABdhPJy3wwtP7+Ke9tIB+XiGd7S9hyAM9uWWW9TLKOomRHbTbwzUkFpK/mX2O5c96kgTM36LtkZ3JT+cz89vWVzqqgo=
X-Received: by 2002:a25:4b05:: with SMTP id y5mr7864671yba.472.1643163671601;
 Tue, 25 Jan 2022 18:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com>
In-Reply-To: <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 25 Jan 2022 18:21:00 -0800
Message-ID: <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
To:     Jessica Clarke <jrtc27@jrtc27.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 2:26 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
> >
> > Currently, SBI APIs accept a hartmask that is generated from struct
> > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> > is not the correct data structure for hartids as it can be higher
> > than NR_CPUs for platforms with sparse or discontguous hartids.
> >
> > Remove all association between hartid mask and struct cpumask.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
> > Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> > arch/riscv/include/asm/sbi.h      |  19 +--
> > arch/riscv/include/asm/smp.h      |   2 -
> > arch/riscv/kernel/sbi.c           | 189 +++++++++++++++++-------------
> > arch/riscv/kernel/setup.c         |  10 --
> > arch/riscv/kernel/smpboot.c       |   2 +-
> > arch/riscv/kvm/mmu.c              |   4 +-
> > arch/riscv/kvm/vcpu_sbi_replace.c |  11 +-
> > arch/riscv/kvm/vcpu_sbi_v01.c     |  11 +-
> > arch/riscv/kvm/vmid.c             |   4 +-
> > arch/riscv/mm/cacheflush.c        |   5 +-
> > arch/riscv/mm/tlbflush.c          |   9 +-
> > 11 files changed, 130 insertions(+), 136 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 26ba6f2d7a40..d1c37479d828 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -8,6 +8,7 @@
> > #define _ASM_RISCV_SBI_H
> >
> > #include <linux/types.h>
> > +#include <linux/cpumask.h>
> >
> > #ifdef CONFIG_RISCV_SBI
> > enum sbi_ext_id {
> > @@ -128,27 +129,27 @@ long sbi_get_mimpid(void);
> > void sbi_set_timer(uint64_t stime_value);
> > void sbi_shutdown(void);
> > void sbi_clear_ipi(void);
> > -int sbi_send_ipi(const unsigned long *hart_mask);
> > -int sbi_remote_fence_i(const unsigned long *hart_mask);
> > -int sbi_remote_sfence_vma(const unsigned long *hart_mask,
> > +int sbi_send_ipi(const struct cpumask *cpu_mask);
> > +int sbi_remote_fence_i(const struct cpumask *cpu_mask);
> > +int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
> >                          unsigned long start,
> >                          unsigned long size);
> >
> > -int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> > +int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
> >                               unsigned long start,
> >                               unsigned long size,
> >                               unsigned long asid);
> > -int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_gvma(const struct cpumask *cpu_mask,
> >                          unsigned long start,
> >                          unsigned long size);
> > -int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_gvma_vmid(const struct cpumask *cpu_mask,
> >                               unsigned long start,
> >                               unsigned long size,
> >                               unsigned long vmid);
> > -int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_vvma(const struct cpumask *cpu_mask,
> >                          unsigned long start,
> >                          unsigned long size);
> > -int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
> >                               unsigned long start,
> >                               unsigned long size,
> >                               unsigned long asid);
> > @@ -183,7 +184,7 @@ static inline unsigned long sbi_mk_version(unsigned long major,
> >
> > int sbi_err_map_linux_errno(int err);
> > #else /* CONFIG_RISCV_SBI */
> > -static inline int sbi_remote_fence_i(const unsigned long *hart_mask) { return -1; }
> > +static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1; }
> > static inline void sbi_init(void) {}
> > #endif /* CONFIG_RISCV_SBI */
> > #endif /* _ASM_RISCV_SBI_H */
> > diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> > index 6ad749f42807..23170c933d73 100644
> > --- a/arch/riscv/include/asm/smp.h
> > +++ b/arch/riscv/include/asm/smp.h
> > @@ -92,8 +92,6 @@ static inline void riscv_clear_ipi(void)
> >
> > #endif /* CONFIG_SMP */
> >
> > -void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
> > -
> > #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> > bool cpu_has_hotplug(unsigned int cpu);
> > #else
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 9a84f0cb5175..f72527fcb347 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -16,8 +16,8 @@ unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
> > EXPORT_SYMBOL(sbi_spec_version);
> >
> > static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
> > -static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
> > -static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
> > +static int (*__sbi_send_ipi)(const struct cpumask *cpu_mask) __ro_after_init;
> > +static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
> >                          unsigned long start, unsigned long size,
> >                          unsigned long arg4, unsigned long arg5) __ro_after_init;
> >
> > @@ -67,6 +67,30 @@ int sbi_err_map_linux_errno(int err)
> > EXPORT_SYMBOL(sbi_err_map_linux_errno);
> >
> > #ifdef CONFIG_RISCV_SBI_V01
> > +static unsigned long __sbi_v01_cpumask_to_hartmask(const struct cpumask *cpu_mask)
> > +{
> > +     unsigned long cpuid, hartid;
> > +     unsigned long hmask = 0;
> > +
> > +     /*
> > +      * There is no maximum hartid concept in RISC-V and NR_CPUS must not be
> > +      * associated with hartid. As SBI v0.1 is only kept for backward compatibility
> > +      * and will be removed in the future, there is no point in supporting hartid
> > +      * greater than BITS_PER_LONG (32 for RV32 and 64 for RV64). Ideally, SBI v0.2
> > +      * should be used for platforms with hartid greater than BITS_PER_LONG.
> > +      */
> > +     for_each_cpu(cpuid, cpu_mask) {
> > +             hartid = cpuid_to_hartid_map(cpuid);
> > +             if (hartid >= BITS_PER_LONG) {
> > +                     pr_warn("Unable to send any request to hartid > BITS_PER_LONG for SBI v0.1\n");
> > +                     break;
> > +             }
> > +             hmask |= 1 << hartid;
>
> This should be 1UL otherwise hartid 31 and up cause UB.
>

Yeah. Thanks for catching it.

> > +     }
> > +
> > +     return hmask;
> > +}
> > +
> > /**
> >  * sbi_console_putchar() - Writes given character to the console device.
> >  * @ch: The data to be written to the console.
> > @@ -132,33 +156,44 @@ static void __sbi_set_timer_v01(uint64_t stime_value)
> > #endif
> > }
> >
> > -static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> > +static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
> > {
> > -     sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> > +     unsigned long hart_mask;
> > +
> > +     if (!cpu_mask)
> > +             cpu_mask = cpu_online_mask;
> > +     hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
> > +
> > +     sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)(&hart_mask),
> >                 0, 0, 0, 0, 0);
> >       return 0;
> > }
> >
> > -static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
> > +static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
> >                           unsigned long start, unsigned long size,
> >                           unsigned long arg4, unsigned long arg5)
> > {
> >       int result = 0;
> > +     unsigned long hart_mask;
> > +
> > +     if (!cpu_mask)
> > +             cpu_mask = cpu_online_mask;
> > +     hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
> >
> >       /* v0.2 function IDs are equivalent to v0.1 extension IDs */
> >       switch (fid) {
> >       case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> >               sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
> > -                       (unsigned long)hart_mask, 0, 0, 0, 0, 0);
> > +                       (unsigned long)&hart_mask, 0, 0, 0, 0, 0);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> >               sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> > -                       (unsigned long)hart_mask, start, size,
> > +                       (unsigned long)&hart_mask, start, size,
> >                         0, 0, 0);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> >               sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> > -                       (unsigned long)hart_mask, start, size,
> > +                       (unsigned long)&hart_mask, start, size,
> >                         arg4, 0, 0);
> >               break;
> >       default:
> > @@ -180,7 +215,7 @@ static void __sbi_set_timer_v01(uint64_t stime_value)
> >               sbi_major_version(), sbi_minor_version());
> > }
> >
> > -static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> > +static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
> > {
> >       pr_warn("IPI extension is not available in SBI v%lu.%lu\n",
> >               sbi_major_version(), sbi_minor_version());
> > @@ -188,7 +223,7 @@ static int __sbi_send_ipi_v01(const unsigned long *hart_mask)
> >       return 0;
> > }
> >
> > -static int __sbi_rfence_v01(int fid, const unsigned long *hart_mask,
> > +static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
> >                           unsigned long start, unsigned long size,
> >                           unsigned long arg4, unsigned long arg5)
> > {
> > @@ -212,37 +247,33 @@ static void __sbi_set_timer_v02(uint64_t stime_value)
> > #endif
> > }
> >
> > -static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
> > +static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
> > {
> > -     unsigned long hartid, hmask_val, hbase;
> > -     struct cpumask tmask;
> > +     unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> >       struct sbiret ret = {0};
> >       int result;
> >
> > -     if (!hart_mask || !(*hart_mask)) {
> > -             riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
> > -             hart_mask = cpumask_bits(&tmask);
> > -     }
> > +     if (!cpu_mask)
> > +             cpu_mask = cpu_online_mask;
>
> This is a change in behaviour. Are you sure nothing passes an empty mask?
>

The change in behavior is not intentional.

I am yet to reproduce it on my end.
@Geert Uytterhoeven: can you please try the below diff on your end.

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index f72527fcb347..ca1c617407b4 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -85,7 +85,7 @@ static unsigned long
__sbi_v01_cpumask_to_hartmask(const struct cpumask *cpu_mas
                        pr_warn("Unable to send any request to hartid
> BITS_PER_LONG for SBI v0.1\n");
                        break;
                }
-               hmask |= 1 << hartid;
+               hmask |= 1UL << hartid;
        }

        return hmask;
@@ -160,7 +160,7 @@ static int __sbi_send_ipi_v01(const struct cpumask
*cpu_mask)
 {
        unsigned long hart_mask;

-       if (!cpu_mask)
+       if (!cpu_mask || cpumask_empty(cpu_mask))
                cpu_mask = cpu_online_mask;
        hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);

@@ -176,7 +176,7 @@ static int __sbi_rfence_v01(int fid, const struct
cpumask *cpu_mask,
        int result = 0;
        unsigned long hart_mask;

-       if (!cpu_mask)
+       if (!cpu_mask || cpumask_empty(cpu_mask))
                cpu_mask = cpu_online_mask;
        hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);

@@ -253,7 +253,7 @@ static int __sbi_send_ipi_v02(const struct cpumask
*cpu_mask)
        struct sbiret ret = {0};
        int result;

-       if (!cpu_mask)
+       if (!cpu_mask || cpumask_empty(cpu_mask))
                cpu_mask = cpu_online_mask;

        for_each_cpu(cpuid, cpu_mask) {
@@ -347,7 +347,7 @@ static int __sbi_rfence_v02(int fid, const struct
cpumask *cpu_mask,
        unsigned long hartid, cpuid, hmask = 0, hbase = 0;
        int result;

-       if (!cpu_mask)
+       if (!cpu_mask || cpumask_empty(cpu_mask))
                cpu_mask = cpu_online_mask;


> > -     hmask_val = 0;
> > -     hbase = 0;
> > -     for_each_set_bit(hartid, hart_mask, NR_CPUS) {
> > -             if (hmask_val && ((hbase + BITS_PER_LONG) <= hartid)) {
> > +     for_each_cpu(cpuid, cpu_mask) {
> > +             hartid = cpuid_to_hartid_map(cpuid);
> > +             if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
> >                       ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
> > -                                     hmask_val, hbase, 0, 0, 0, 0);
> > +                                     hmask, hbase, 0, 0, 0, 0);
> >                       if (ret.error)
> >                               goto ecall_failed;
> > -                     hmask_val = 0;
> > +                     hmask = 0;
> >                       hbase = 0;
> >               }
> > -             if (!hmask_val)
> > +             if (!hmask)
> >                       hbase = hartid;
> > -             hmask_val |= 1UL << (hartid - hbase);
> > +             hmask |= 1UL << (hartid - hbase);
> >       }
> >
> > -     if (hmask_val) {
> > +     if (hmask) {
> >               ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
> > -                             hmask_val, hbase, 0, 0, 0, 0);
> > +                             hmask, hbase, 0, 0, 0, 0);
> >               if (ret.error)
> >                       goto ecall_failed;
> >       }
> > @@ -252,11 +283,11 @@ static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
> > ecall_failed:
> >       result = sbi_err_map_linux_errno(ret.error);
> >       pr_err("%s: hbase = [%lu] hmask = [0x%lx] failed (error [%d])\n",
> > -            __func__, hbase, hmask_val, result);
> > +            __func__, hbase, hmask, result);
> >       return result;
> > }
> >
> > -static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask_val,
> > +static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask,
> >                                unsigned long hbase, unsigned long start,
> >                                unsigned long size, unsigned long arg4,
> >                                unsigned long arg5)
> > @@ -267,31 +298,31 @@ static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask_val,
> >
> >       switch (fid) {
> >       case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> > -             ret = sbi_ecall(ext, fid, hmask_val, hbase, 0, 0, 0, 0);
> > +             ret = sbi_ecall(ext, fid, hmask, hbase, 0, 0, 0, 0);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> > -             ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
> > +             ret = sbi_ecall(ext, fid, hmask, hbase, start,
> >                               size, 0, 0);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> > -             ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
> > +             ret = sbi_ecall(ext, fid, hmask, hbase, start,
> >                               size, arg4, 0);
> >               break;
> >
> >       case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
> > -             ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
> > +             ret = sbi_ecall(ext, fid, hmask, hbase, start,
> >                               size, 0, 0);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID:
> > -             ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
> > +             ret = sbi_ecall(ext, fid, hmask, hbase, start,
> >                               size, arg4, 0);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA:
> > -             ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
> > +             ret = sbi_ecall(ext, fid, hmask, hbase, start,
> >                               size, 0, 0);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
> > -             ret = sbi_ecall(ext, fid, hmask_val, hbase, start,
> > +             ret = sbi_ecall(ext, fid, hmask, hbase, start,
> >                               size, arg4, 0);
> >               break;
> >       default:
> > @@ -303,43 +334,39 @@ static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask_val,
> >       if (ret.error) {
> >               result = sbi_err_map_linux_errno(ret.error);
> >               pr_err("%s: hbase = [%lu] hmask = [0x%lx] failed (error [%d])\n",
> > -                    __func__, hbase, hmask_val, result);
> > +                    __func__, hbase, hmask, result);
> >       }
> >
> >       return result;
> > }
> >
> > -static int __sbi_rfence_v02(int fid, const unsigned long *hart_mask,
> > +static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
> >                           unsigned long start, unsigned long size,
> >                           unsigned long arg4, unsigned long arg5)
> > {
> > -     unsigned long hmask_val, hartid, hbase;
> > -     struct cpumask tmask;
> > +     unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> >       int result;
> >
> > -     if (!hart_mask || !(*hart_mask)) {
> > -             riscv_cpuid_to_hartid_mask(cpu_online_mask, &tmask);
> > -             hart_mask = cpumask_bits(&tmask);
> > -     }
> > +     if (!cpu_mask)
> > +             cpu_mask = cpu_online_mask;
>
> As with __sbi_send_ipi_v02.
>
> Jess
>
> > -     hmask_val = 0;
> > -     hbase = 0;
> > -     for_each_set_bit(hartid, hart_mask, NR_CPUS) {
> > -             if (hmask_val && ((hbase + BITS_PER_LONG) <= hartid)) {
> > -                     result = __sbi_rfence_v02_call(fid, hmask_val, hbase,
> > +     for_each_cpu(cpuid, cpu_mask) {
> > +             hartid = cpuid_to_hartid_map(cpuid);
> > +             if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
> > +                     result = __sbi_rfence_v02_call(fid, hmask, hbase,
> >                                                      start, size, arg4, arg5);
> >                       if (result)
> >                               return result;
> > -                     hmask_val = 0;
> > +                     hmask = 0;
> >                       hbase = 0;
> >               }
> > -             if (!hmask_val)
> > +             if (!hmask)
> >                       hbase = hartid;
> > -             hmask_val |= 1UL << (hartid - hbase);
> > +             hmask |= 1UL << (hartid - hbase);
> >       }
> >
> > -     if (hmask_val) {
> > -             result = __sbi_rfence_v02_call(fid, hmask_val, hbase,
> > +     if (hmask) {
> > +             result = __sbi_rfence_v02_call(fid, hmask, hbase,
> >                                              start, size, arg4, arg5);
> >               if (result)
> >                       return result;
> > @@ -361,44 +388,44 @@ void sbi_set_timer(uint64_t stime_value)
> >
> > /**
> >  * sbi_send_ipi() - Send an IPI to any hart.
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  *
> >  * Return: 0 on success, appropriate linux error code otherwise.
> >  */
> > -int sbi_send_ipi(const unsigned long *hart_mask)
> > +int sbi_send_ipi(const struct cpumask *cpu_mask)
> > {
> > -     return __sbi_send_ipi(hart_mask);
> > +     return __sbi_send_ipi(cpu_mask);
> > }
> > EXPORT_SYMBOL(sbi_send_ipi);
> >
> > /**
> >  * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  *
> >  * Return: 0 on success, appropriate linux error code otherwise.
> >  */
> > -int sbi_remote_fence_i(const unsigned long *hart_mask)
> > +int sbi_remote_fence_i(const struct cpumask *cpu_mask)
> > {
> >       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
> > -                         hart_mask, 0, 0, 0, 0);
> > +                         cpu_mask, 0, 0, 0, 0);
> > }
> > EXPORT_SYMBOL(sbi_remote_fence_i);
> >
> > /**
> >  * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given remote
> >  *                         harts for the specified virtual address range.
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  * @start: Start of the virtual address
> >  * @size: Total size of the virtual address range.
> >  *
> >  * Return: 0 on success, appropriate linux error code otherwise.
> >  */
> > -int sbi_remote_sfence_vma(const unsigned long *hart_mask,
> > +int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
> >                          unsigned long start,
> >                          unsigned long size)
> > {
> >       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> > -                         hart_mask, start, size, 0, 0);
> > +                         cpu_mask, start, size, 0, 0);
> > }
> > EXPORT_SYMBOL(sbi_remote_sfence_vma);
> >
> > @@ -406,38 +433,38 @@ EXPORT_SYMBOL(sbi_remote_sfence_vma);
> >  * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on given
> >  * remote harts for a virtual address range belonging to a specific ASID.
> >  *
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  * @start: Start of the virtual address
> >  * @size: Total size of the virtual address range.
> >  * @asid: The value of address space identifier (ASID).
> >  *
> >  * Return: 0 on success, appropriate linux error code otherwise.
> >  */
> > -int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> > +int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
> >                               unsigned long start,
> >                               unsigned long size,
> >                               unsigned long asid)
> > {
> >       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> > -                         hart_mask, start, size, asid, 0);
> > +                         cpu_mask, start, size, asid, 0);
> > }
> > EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
> >
> > /**
> >  * sbi_remote_hfence_gvma() - Execute HFENCE.GVMA instructions on given remote
> >  *                       harts for the specified guest physical address range.
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  * @start: Start of the guest physical address
> >  * @size: Total size of the guest physical address range.
> >  *
> >  * Return: None
> >  */
> > -int sbi_remote_hfence_gvma(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_gvma(const struct cpumask *cpu_mask,
> >                          unsigned long start,
> >                          unsigned long size)
> > {
> >       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> > -                         hart_mask, start, size, 0, 0);
> > +                         cpu_mask, start, size, 0, 0);
> > }
> > EXPORT_SYMBOL_GPL(sbi_remote_hfence_gvma);
> >
> > @@ -445,38 +472,38 @@ EXPORT_SYMBOL_GPL(sbi_remote_hfence_gvma);
> >  * sbi_remote_hfence_gvma_vmid() - Execute HFENCE.GVMA instructions on given
> >  * remote harts for a guest physical address range belonging to a specific VMID.
> >  *
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  * @start: Start of the guest physical address
> >  * @size: Total size of the guest physical address range.
> >  * @vmid: The value of guest ID (VMID).
> >  *
> >  * Return: 0 if success, Error otherwise.
> >  */
> > -int sbi_remote_hfence_gvma_vmid(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_gvma_vmid(const struct cpumask *cpu_mask,
> >                               unsigned long start,
> >                               unsigned long size,
> >                               unsigned long vmid)
> > {
> >       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> > -                         hart_mask, start, size, vmid, 0);
> > +                         cpu_mask, start, size, vmid, 0);
> > }
> > EXPORT_SYMBOL(sbi_remote_hfence_gvma_vmid);
> >
> > /**
> >  * sbi_remote_hfence_vvma() - Execute HFENCE.VVMA instructions on given remote
> >  *                         harts for the current guest virtual address range.
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  * @start: Start of the current guest virtual address
> >  * @size: Total size of the current guest virtual address range.
> >  *
> >  * Return: None
> >  */
> > -int sbi_remote_hfence_vvma(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_vvma(const struct cpumask *cpu_mask,
> >                          unsigned long start,
> >                          unsigned long size)
> > {
> >       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> > -                         hart_mask, start, size, 0, 0);
> > +                         cpu_mask, start, size, 0, 0);
> > }
> > EXPORT_SYMBOL(sbi_remote_hfence_vvma);
> >
> > @@ -485,20 +512,20 @@ EXPORT_SYMBOL(sbi_remote_hfence_vvma);
> >  * remote harts for current guest virtual address range belonging to a specific
> >  * ASID.
> >  *
> > - * @hart_mask: A cpu mask containing all the target harts.
> > + * @cpu_mask: A cpu mask containing all the target harts.
> >  * @start: Start of the current guest virtual address
> >  * @size: Total size of the current guest virtual address range.
> >  * @asid: The value of address space identifier (ASID).
> >  *
> >  * Return: None
> >  */
> > -int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> > +int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
> >                               unsigned long start,
> >                               unsigned long size,
> >                               unsigned long asid)
> > {
> >       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> > -                         hart_mask, start, size, asid, 0);
> > +                         cpu_mask, start, size, asid, 0);
> > }
> > EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
> >
> > @@ -591,11 +618,7 @@ long sbi_get_mimpid(void)
> >
> > static void sbi_send_cpumask_ipi(const struct cpumask *target)
> > {
> > -     struct cpumask hartid_mask;
> > -
> > -     riscv_cpuid_to_hartid_mask(target, &hartid_mask);
> > -
> > -     sbi_send_ipi(cpumask_bits(&hartid_mask));
> > +     sbi_send_ipi(target);
> > }
> >
> > static const struct riscv_ipi_ops sbi_ipi_ops = {
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 63241abe84eb..b42bfdc67482 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -59,16 +59,6 @@ atomic_t hart_lottery __section(".sdata")
> > unsigned long boot_cpu_hartid;
> > static DEFINE_PER_CPU(struct cpu, cpu_devices);
> >
> > -void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
> > -{
> > -     int cpu;
> > -
> > -     cpumask_clear(out);
> > -     for_each_cpu(cpu, in)
> > -             cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
> > -}
> > -EXPORT_SYMBOL_GPL(riscv_cpuid_to_hartid_mask);
> > -
> > /*
> >  * Place kernel memory regions on the resource tree so that
> >  * kexec-tools can retrieve them from /proc/iomem. While there
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index bd82375db51a..622f226454d5 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -96,7 +96,7 @@ void __init setup_smp(void)
> >               if (cpuid >= NR_CPUS) {
> >                       pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
> >                               cpuid, hart);
> > -                     break;
> > +                     continue;
> >               }
> >
> >               cpuid_to_hartid_map(cpuid) = hart;
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index 9af67dbdc66a..f80a34fbf102 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -114,7 +114,6 @@ static bool stage2_get_leaf_entry(struct kvm *kvm, gpa_t addr,
> >
> > static void stage2_remote_tlb_flush(struct kvm *kvm, u32 level, gpa_t addr)
> > {
> > -     struct cpumask hmask;
> >       unsigned long size = PAGE_SIZE;
> >       struct kvm_vmid *vmid = &kvm->arch.vmid;
> >
> > @@ -127,8 +126,7 @@ static void stage2_remote_tlb_flush(struct kvm *kvm, u32 level, gpa_t addr)
> >        * where the Guest/VM is running.
> >        */
> >       preempt_disable();
> > -     riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> > -     sbi_remote_hfence_gvma_vmid(cpumask_bits(&hmask), addr, size,
> > +     sbi_remote_hfence_gvma_vmid(cpu_online_mask, addr, size,
> >                                   READ_ONCE(vmid->vmid));
> >       preempt_enable();
> > }
> > diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
> > index 00036b7f83b9..1bc0608a5bfd 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> > @@ -82,7 +82,7 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
> > {
> >       int ret = 0;
> >       unsigned long i;
> > -     struct cpumask cm, hm;
> > +     struct cpumask cm;
> >       struct kvm_vcpu *tmp;
> >       struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> >       unsigned long hmask = cp->a0;
> > @@ -90,7 +90,6 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
> >       unsigned long funcid = cp->a6;
> >
> >       cpumask_clear(&cm);
> > -     cpumask_clear(&hm);
> >       kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> >               if (hbase != -1UL) {
> >                       if (tmp->vcpu_id < hbase)
> > @@ -103,17 +102,15 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
> >               cpumask_set_cpu(tmp->cpu, &cm);
> >       }
> >
> > -     riscv_cpuid_to_hartid_mask(&cm, &hm);
> > -
> >       switch (funcid) {
> >       case SBI_EXT_RFENCE_REMOTE_FENCE_I:
> > -             ret = sbi_remote_fence_i(cpumask_bits(&hm));
> > +             ret = sbi_remote_fence_i(&cm);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> > -             ret = sbi_remote_hfence_vvma(cpumask_bits(&hm), cp->a2, cp->a3);
> > +             ret = sbi_remote_hfence_vvma(&cm, cp->a2, cp->a3);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> > -             ret = sbi_remote_hfence_vvma_asid(cpumask_bits(&hm), cp->a2,
> > +             ret = sbi_remote_hfence_vvma_asid(&cm, cp->a2,
> >                                                 cp->a3, cp->a4);
> >               break;
> >       case SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA:
> > diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
> > index 4c7e13ec9ccc..07e2de14433a 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> > @@ -38,7 +38,7 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >       int i, ret = 0;
> >       u64 next_cycle;
> >       struct kvm_vcpu *rvcpu;
> > -     struct cpumask cm, hm;
> > +     struct cpumask cm;
> >       struct kvm *kvm = vcpu->kvm;
> >       struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> >
> > @@ -101,15 +101,12 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >                               continue;
> >                       cpumask_set_cpu(rvcpu->cpu, &cm);
> >               }
> > -             riscv_cpuid_to_hartid_mask(&cm, &hm);
> >               if (cp->a7 == SBI_EXT_0_1_REMOTE_FENCE_I)
> > -                     ret = sbi_remote_fence_i(cpumask_bits(&hm));
> > +                     ret = sbi_remote_fence_i(&cm);
> >               else if (cp->a7 == SBI_EXT_0_1_REMOTE_SFENCE_VMA)
> > -                     ret = sbi_remote_hfence_vvma(cpumask_bits(&hm),
> > -                                             cp->a1, cp->a2);
> > +                     ret = sbi_remote_hfence_vvma(&cm, cp->a1, cp->a2);
> >               else
> > -                     ret = sbi_remote_hfence_vvma_asid(cpumask_bits(&hm),
> > -                                             cp->a1, cp->a2, cp->a3);
> > +                     ret = sbi_remote_hfence_vvma_asid(&cm, cp->a1, cp->a2, cp->a3);
> >               break;
> >       default:
> >               ret = -EINVAL;
> > diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> > index 807228f8f409..2fa4f7b1813d 100644
> > --- a/arch/riscv/kvm/vmid.c
> > +++ b/arch/riscv/kvm/vmid.c
> > @@ -67,7 +67,6 @@ void kvm_riscv_stage2_vmid_update(struct kvm_vcpu *vcpu)
> > {
> >       unsigned long i;
> >       struct kvm_vcpu *v;
> > -     struct cpumask hmask;
> >       struct kvm_vmid *vmid = &vcpu->kvm->arch.vmid;
> >
> >       if (!kvm_riscv_stage2_vmid_ver_changed(vmid))
> > @@ -102,8 +101,7 @@ void kvm_riscv_stage2_vmid_update(struct kvm_vcpu *vcpu)
> >                * running, we force VM exits on all host CPUs using IPI and
> >                * flush all Guest TLBs.
> >                */
> > -             riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> > -             sbi_remote_hfence_gvma(cpumask_bits(&hmask), 0, 0);
> > +             sbi_remote_hfence_gvma(cpu_online_mask, 0, 0);
> >       }
> >
> >       vmid->vmid = vmid_next;
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 89f81067e09e..6cb7d96ad9c7 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -67,10 +67,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
> >                */
> >               smp_mb();
> >       } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> > -             cpumask_t hartid_mask;
> > -
> > -             riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
> > -             sbi_remote_fence_i(cpumask_bits(&hartid_mask));
> > +             sbi_remote_fence_i(&others);
> >       } else {
> >               on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> >       }
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 64f8201237c2..37ed760d007c 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -32,7 +32,6 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> >                                 unsigned long size, unsigned long stride)
> > {
> >       struct cpumask *cmask = mm_cpumask(mm);
> > -     struct cpumask hmask;
> >       unsigned int cpuid;
> >       bool broadcast;
> >
> > @@ -46,9 +45,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> >               unsigned long asid = atomic_long_read(&mm->context.id);
> >
> >               if (broadcast) {
> > -                     riscv_cpuid_to_hartid_mask(cmask, &hmask);
> > -                     sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
> > -                                                start, size, asid);
> > +                     sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> >               } else if (size <= stride) {
> >                       local_flush_tlb_page_asid(start, asid);
> >               } else {
> > @@ -56,9 +53,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> >               }
> >       } else {
> >               if (broadcast) {
> > -                     riscv_cpuid_to_hartid_mask(cmask, &hmask);
> > -                     sbi_remote_sfence_vma(cpumask_bits(&hmask),
> > -                                           start, size);
> > +                     sbi_remote_sfence_vma(cmask, start, size);
> >               } else if (size <= stride) {
> >                       local_flush_tlb_page(start);
> >               } else {
> > --
> > 2.30.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>


-- 
Regards,
Atish
