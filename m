Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662C44C2BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiBXM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBXM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:12 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2202D25A323
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:28:42 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id x193so2334741oix.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqnZYNW9ADSY/YfVSxsO+0vIDcEZwOdxGA0neyWGAlw=;
        b=tGWtxjXJBuzYw/z72un4l6o/AlYVmzvPYKOkfbS5QFLUcoBhFOoNgglT8gMom/pVBI
         rteKw2r9PdWr2md0TcnS/C/ID7SGMB/ftC1Zc7tdFXqeQwZErsxlrz3f4XcTNOZYhESh
         9YjJbrmjL4RJRwmqYZU0ttidZrQeifzPueJwnSM5HqxJ3QJehX3idjQE6rFlTwejNzj9
         Kr9m56ISvtk7+6gguRwOqz7oCKwC/jDqvff8Yva2rqiWX75k+XndP9A80LpNofk0CTvE
         zcXFjuR13d74iJ9odAZhdxpWVZiAQwTBEqowxYUnEHTeDrd2xv0iwjEXTnOvSeBYssxp
         Qchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqnZYNW9ADSY/YfVSxsO+0vIDcEZwOdxGA0neyWGAlw=;
        b=EsSViGH4v6TPQav2Ze7WXkijQpU3bUgZFLoaL/qhVtrElPKXCzgnFciHv5CiKg0GA/
         QVUDant3o4sGan+0sciv0o60lyOc686yq/Ged0BhYaFvOgBUajCoz1d94HfNjmQrdmpQ
         4H+Fl0ur3exqayr1lprOZKFN1MX+BBHh7zX4NCSjPuj7ZJZdmh8Vo6XB6kz812bsMGe6
         BnkDZJ6jNMAMjRtPZpiGA55GX4Z9XiFLEF5rGIknY5U/rO64sGMrmRfbJdZRBrz9TxyA
         kRGODZW0yub7iE9N8BHJzF3tx1XePjh8AtgiMRgmF4hCD795SL0Y68BhFizS9IJtA/ms
         mFsQ==
X-Gm-Message-State: AOAM532WyNZ7IwEiUMNc4DSFooMRoo3TKTy4UlYbz87yMSdT4iMOL39Y
        erJe9YrugS9gtP2Kmsedg4Z0/6hPJW5sJaudKiJV5w==
X-Google-Smtp-Source: ABdhPJxvGFZpfwlvVvE0Naq2MWTGmpe6OduOJ6e6hBM9s5o9yN/8vaC1lg8BXNudAfPTB3+P3GGN4Dwv78IuCRoZ3UY=
X-Received: by 2002:a05:6808:ec1:b0:2d6:52f:6405 with SMTP id
 q1-20020a0568080ec100b002d6052f6405mr5744782oiv.124.1645705721184; Thu, 24
 Feb 2022 04:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com> <20220224051439.640768-8-kaleshsingh@google.com>
In-Reply-To: <20220224051439.640768-8-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 24 Feb 2022 12:28:03 +0000
Message-ID: <CA+EHjTwMvQzvyA2Nxq_TKNjM-0_XvTtoKPtBPVPjSn7cboBNUA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] KVM: arm64: Unwind and dump nVHE HYP stacktrace
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        surenb@google.com, kernel-team@android.com,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Thu, Feb 24, 2022 at 5:22 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Unwind the stack in EL1, when CONFIG_NVHE_EL2_DEBUG is enabled. This is
> possible because CONFIG_NVHE_EL2_DEBUG disables the host stage 2 protection
> which allows host to access the hypervisor stack pages in EL1.

For this comment to be clearer, and if my understanding is correct, I
think that it should say that CONFIG_NVHE_EL2_DEBUG allows host stage
2 protection to be disabled on a hyp_panic. Otherwise, on reading the
comment one might think that CONFIG_NVHE_EL2_DEBUG runs without host
stage 2 protection at all.

>
> Unwinding and dumping hyp call traces is gated on CONFIG_NVHE_EL2_DEBUG
> to avoid the potential leaking of information to the host.
>
> A simple stack overflow test produces the following output:
>
> [  580.376051][  T412] kvm: nVHE hyp panic at: ffffffc0116145c4!
> [  580.378034][  T412] kvm [412]: nVHE HYP call trace:
> [  580.378591][  T412] kvm [412]:  [<ffffffc011614934>]
> [  580.378993][  T412] kvm [412]:  [<ffffffc01160fa48>]
> [  580.379386][  T412] kvm [412]:  [<ffffffc0116145dc>]  // Non-terminating recursive call
> [  580.379772][  T412] kvm [412]:  [<ffffffc0116145dc>]
> [  580.380158][  T412] kvm [412]:  [<ffffffc0116145dc>]
> [  580.380544][  T412] kvm [412]:  [<ffffffc0116145dc>]
> [  580.380928][  T412] kvm [412]:  [<ffffffc0116145dc>]
> . . .
>
> Since nVHE hyp symbols are not included by kallsyms to avoid issues
> with aliasing, we fallback to the vmlinux addresses. Symbolizing the
> addresses is handled in the next patch in this series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>
> Changes in v3:
>   - The nvhe hyp stack unwinder now makes use of the core logic from the
>     regular kernel unwinder to avoid duplication, per Mark
>
> Changes in v2:
>   - Add cpu_prepare_nvhe_panic_info()
>   - Move updating the panic info to hyp_panic(), so that unwinding also
>     works for conventional nVHE Hyp-mode.
>
>  arch/arm64/include/asm/kvm_asm.h    |  19 +++
>  arch/arm64/include/asm/stacktrace.h |  12 ++
>  arch/arm64/kernel/stacktrace.c      | 210 +++++++++++++++++++++++++---
>  arch/arm64/kvm/Kconfig              |   5 +-
>  arch/arm64/kvm/arm.c                |   2 +-
>  arch/arm64/kvm/handle_exit.c        |   3 +
>  arch/arm64/kvm/hyp/nvhe/switch.c    |  18 +++
>  7 files changed, 243 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 2e277f2ed671..16efdf150a37 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -176,6 +176,25 @@ struct kvm_nvhe_init_params {
>         unsigned long vtcr;
>  };
>
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +/*
> + * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
> + * hyp_panic. This is possible because CONFIG_NVHE_EL2_DEBUG disables
> + * the host stage 2 protection. See: __hyp_do_panic()

Same as my comment above.

> + *
> + * @hyp_stack_base:             hyp VA of the hyp_stack base.
> + * @hyp_overflow_stack_base:    hyp VA of the hyp_overflow_stack base.
> + * @fp:                         hyp FP where the backtrace begins.
> + * @pc:                         hyp PC where the backtrace begins.
> + */
> +struct kvm_nvhe_panic_info {
> +       unsigned long hyp_stack_base;
> +       unsigned long hyp_overflow_stack_base;
> +       unsigned long fp;
> +       unsigned long pc;
> +};
> +#endif /* CONFIG_NVHE_EL2_DEBUG */
> +
>  /* Translate a kernel address @ptr into its equivalent linear mapping */
>  #define kvm_ksym_ref(ptr)                                              \
>         ({                                                              \
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index e77cdef9ca29..18611a51cf14 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -22,6 +22,10 @@ enum stack_type {
>         STACK_TYPE_OVERFLOW,
>         STACK_TYPE_SDEI_NORMAL,
>         STACK_TYPE_SDEI_CRITICAL,
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +       STACK_TYPE_KVM_NVHE_HYP,
> +       STACK_TYPE_KVM_NVHE_OVERFLOW,
> +#endif /* CONFIG_NVHE_EL2_DEBUG */
>         __NR_STACK_TYPES
>  };
>
> @@ -147,4 +151,12 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
>         return false;
>  }
>
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +void kvm_nvhe_dump_backtrace(unsigned long hyp_offset);
> +#else
> +static inline void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
> +{
> +}
> +#endif /* CONFIG_NVHE_EL2_DEBUG */
> +
>  #endif /* __ASM_STACKTRACE_H */
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index e4103e085681..6ec85cb69b1f 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -15,6 +15,8 @@
>
>  #include <asm/irq.h>
>  #include <asm/pointer_auth.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_hyp.h>
>  #include <asm/stack_pointer.h>
>  #include <asm/stacktrace.h>
>
> @@ -64,26 +66,15 @@ NOKPROBE_SYMBOL(start_backtrace);
>   * records (e.g. a cycle), determined based on the location and fp value of A
>   * and the location (but not the fp value) of B.
>   */
> -static int notrace unwind_frame(struct task_struct *tsk,
> -                               struct stackframe *frame)
> +static int notrace __unwind_frame(struct stackframe *frame, struct stack_info *info,
> +               unsigned long (*translate_fp)(unsigned long, enum stack_type))
>  {
>         unsigned long fp = frame->fp;
> -       struct stack_info info;
> -
> -       if (!tsk)
> -               tsk = current;
> -
> -       /* Final frame; nothing to unwind */
> -       if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
> -               return -ENOENT;
>
>         if (fp & 0x7)
>                 return -EINVAL;
>
> -       if (!on_accessible_stack(tsk, fp, 16, &info))
> -               return -EINVAL;
> -
> -       if (test_bit(info.type, frame->stacks_done))
> +       if (test_bit(info->type, frame->stacks_done))
>                 return -EINVAL;
>
>         /*
> @@ -94,28 +85,62 @@ static int notrace unwind_frame(struct task_struct *tsk,
>          *
>          * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
>          * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
> +        * KVM_NVHE_HYP -> KVM_NVHE_OVERFLOW
>          *
>          * ... but the nesting itself is strict. Once we transition from one
>          * stack to another, it's never valid to unwind back to that first
>          * stack.
>          */
> -       if (info.type == frame->prev_type) {
> +       if (info->type == frame->prev_type) {
>                 if (fp <= frame->prev_fp)
>                         return -EINVAL;
>         } else {
>                 set_bit(frame->prev_type, frame->stacks_done);
>         }
>
> +       /* Record fp as prev_fp before attempting to get the next fp */
> +       frame->prev_fp = fp;
> +
> +       /*
> +        * If fp is not from the current address space perform the
> +        * necessary translation before dereferencing it to get next fp.
> +        */
> +       if (translate_fp)
> +               fp = translate_fp(fp, info->type);
> +       if (!fp)
> +               return -EINVAL;
> +
>         /*
>          * Record this frame record's values and location. The prev_fp and
> -        * prev_type are only meaningful to the next unwind_frame() invocation.
> +        * prev_type are only meaningful to the next __unwind_frame() invocation.
>          */
>         frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
>         frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> -       frame->prev_fp = fp;
> -       frame->prev_type = info.type;
> -
>         frame->pc = ptrauth_strip_insn_pac(frame->pc);
> +       frame->prev_type = info->type;
> +
> +       return 0;
> +}
> +
> +static int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
> +{
> +       unsigned long fp = frame->fp;
> +       struct stack_info info;
> +       int err;
> +
> +       if (!tsk)
> +               tsk = current;
> +
> +       /* Final frame; nothing to unwind */
> +       if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
> +               return -ENOENT;
> +
> +       if (!on_accessible_stack(tsk, fp, 16, &info))
> +               return -EINVAL;
> +
> +       err = __unwind_frame(frame, &info, NULL);
> +       if (err)
> +               return err;
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>         if (tsk->ret_stack &&
> @@ -143,20 +168,27 @@ static int notrace unwind_frame(struct task_struct *tsk,
>  }
>  NOKPROBE_SYMBOL(unwind_frame);
>
> -static void notrace walk_stackframe(struct task_struct *tsk,
> -                                   struct stackframe *frame,
> -                                   bool (*fn)(void *, unsigned long), void *data)
> +static void notrace __walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
> +               bool (*fn)(void *, unsigned long), void *data,
> +               int (*unwind_frame_fn)(struct task_struct *tsk, struct stackframe *frame))
>  {
>         while (1) {
>                 int ret;
>
>                 if (!fn(data, frame->pc))
>                         break;
> -               ret = unwind_frame(tsk, frame);
> +               ret = unwind_frame_fn(tsk, frame);
>                 if (ret < 0)
>                         break;
>         }
>  }
> +
> +static void notrace walk_stackframe(struct task_struct *tsk,
> +                                   struct stackframe *frame,
> +                                   bool (*fn)(void *, unsigned long), void *data)
> +{
> +       __walk_stackframe(tsk, frame, fn, data, unwind_frame);
> +}
>  NOKPROBE_SYMBOL(walk_stackframe);
>
>  static bool dump_backtrace_entry(void *arg, unsigned long where)
> @@ -210,3 +242,135 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>
>         walk_stackframe(task, &frame, consume_entry, cookie);
>  }
> +
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> +DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack);
> +DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
> +
> +static inline bool kvm_nvhe_on_overflow_stack(unsigned long sp, unsigned long size,
> +                                struct stack_info *info)
> +{
> +       struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
> +       unsigned long low = (unsigned long)panic_info->hyp_overflow_stack_base;
> +       unsigned long high = low + PAGE_SIZE;
> +
> +       return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_OVERFLOW, info);
> +}
> +
> +static inline bool kvm_nvhe_on_hyp_stack(unsigned long sp, unsigned long size,
> +                                struct stack_info *info)
> +{
> +       struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
> +       unsigned long low = (unsigned long)panic_info->hyp_stack_base;
> +       unsigned long high = low + PAGE_SIZE;
> +
> +       return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_HYP, info);
> +}
> +
> +static inline bool kvm_nvhe_on_accessible_stack(unsigned long sp, unsigned long size,
> +                                      struct stack_info *info)
> +{
> +       if (info)
> +               info->type = STACK_TYPE_UNKNOWN;
> +
> +       if (kvm_nvhe_on_hyp_stack(sp, size, info))
> +               return true;
> +       if (kvm_nvhe_on_overflow_stack(sp, size, info))
> +               return true;
> +
> +       return false;
> +}
> +
> +static unsigned long kvm_nvhe_hyp_stack_kern_va(unsigned long addr)
> +{
> +       struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
> +       unsigned long hyp_base, kern_base, hyp_offset;
> +
> +       hyp_base = (unsigned long)panic_info->hyp_stack_base;
> +       hyp_offset = addr - hyp_base;
> +
> +       kern_base = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
> +
> +       return kern_base + hyp_offset;
> +}
> +
> +static unsigned long kvm_nvhe_overflow_stack_kern_va(unsigned long addr)
> +{
> +       struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
> +       unsigned long hyp_base, kern_base, hyp_offset;
> +
> +       hyp_base = (unsigned long)panic_info->hyp_overflow_stack_base;
> +       hyp_offset = addr - hyp_base;
> +
> +       kern_base = (unsigned long)this_cpu_ptr_nvhe_sym(hyp_overflow_stack);
> +
> +       return kern_base + hyp_offset;
> +}
> +
> +/*
> + * Convert KVM nVHE hypervisor stack VA to a kernel VA.
> + *
> + * The nVHE hypervisor stack is mapped in the flexible 'private' VA range, to allow
> + * for guard pages below the stack. Consequently, the fixed offset address
> + * translation macros won't work here.
> + *
> + * The kernel VA is calculated as an offset from the kernel VA of the hypervisor
> + * stack base. See: kvm_nvhe_hyp_stack_kern_va(),  kvm_nvhe_overflow_stack_kern_va()
> + */
> +static unsigned long kvm_nvhe_stack_kern_va(unsigned long addr,
> +                                       enum stack_type type)
> +{
> +       switch (type) {
> +       case STACK_TYPE_KVM_NVHE_HYP:
> +               return kvm_nvhe_hyp_stack_kern_va(addr);
> +       case STACK_TYPE_KVM_NVHE_OVERFLOW:
> +               return kvm_nvhe_overflow_stack_kern_va(addr);
> +       default:
> +               return 0UL;
> +       }
> +}
> +
> +static int notrace kvm_nvhe_unwind_frame(struct task_struct *tsk,
> +                                       struct stackframe *frame)
> +{
> +       struct stack_info info;
> +
> +       if (!kvm_nvhe_on_accessible_stack(frame->fp, 16, &info))
> +               return -EINVAL;
> +
> +       return  __unwind_frame(frame, &info, kvm_nvhe_stack_kern_va);
> +}
> +
> +static bool kvm_nvhe_dump_backtrace_entry(void *arg, unsigned long where)
> +{
> +       unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
> +       unsigned long hyp_offset = (unsigned long)arg;
> +
> +       where &= va_mask;       /* Mask tags */
> +       where += hyp_offset;    /* Convert to kern addr */
> +
> +       kvm_err("[<%016lx>] %pB\n", where, (void *)where);
> +
> +       return true;
> +}
> +
> +static void notrace kvm_nvhe_walk_stackframe(struct task_struct *tsk,
> +                                   struct stackframe *frame,
> +                                   bool (*fn)(void *, unsigned long), void *data)
> +{
> +       __walk_stackframe(tsk, frame, fn, data, kvm_nvhe_unwind_frame);
> +}
> +
> +void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
> +{
> +       struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
> +       struct stackframe frame;
> +
> +       start_backtrace(&frame, panic_info->fp, panic_info->pc);
> +       pr_err("nVHE HYP call trace:\n");
> +       kvm_nvhe_walk_stackframe(NULL, &frame, kvm_nvhe_dump_backtrace_entry,
> +                                       (void *)hyp_offset);
> +       pr_err("---- end of nVHE HYP call trace ----\n");
> +}
> +#endif /* CONFIG_NVHE_EL2_DEBUG */
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 8a5fbbf084df..75f2c8255ff0 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -51,8 +51,9 @@ config NVHE_EL2_DEBUG
>         depends on KVM
>         help
>           Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
> -         Failure reports will BUG() in the hypervisor. This is intended for
> -         local EL2 hypervisor development.
> +         Failure reports will BUG() in the hypervisor; and panics will print
> +         the hypervisor call stack. This is intended for local EL2 hypervisor
> +         development.

Nit: maybe for clarity you could rephrase as "calls to hyp_panic()
will result in printing the hypervisor call stack".

Thanks,
/fuad


>
>           If unsure, say N.
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 7a23630c4a7f..66c07c04eb52 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
>
>  DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
>
> -static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> +DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>  unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
>  DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
>
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index e3140abd2e2e..ff69dff33700 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -17,6 +17,7 @@
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/debug-monitors.h>
> +#include <asm/stacktrace.h>
>  #include <asm/traps.h>
>
>  #include <kvm/arm_hypercalls.h>
> @@ -326,6 +327,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>                 kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
>         }
>
> +       kvm_nvhe_dump_backtrace(hyp_offset);
> +
>         /*
>          * Hyp has panicked and we're going to handle that by panicking the
>          * kernel. The kernel offset will be revealed in the panic so we're
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index efc20273a352..b8ecffc47424 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -37,6 +37,22 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
>  #ifdef CONFIG_NVHE_EL2_DEBUG
>  DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
>         __aligned(16);
> +DEFINE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
> +
> +static inline void cpu_prepare_nvhe_panic_info(void)
> +{
> +       struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr(&kvm_panic_info);
> +       struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
> +
> +       panic_info->hyp_stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
> +       panic_info->hyp_overflow_stack_base = (unsigned long)this_cpu_ptr(hyp_overflow_stack);
> +       panic_info->fp = (unsigned long)__builtin_frame_address(0);
> +       panic_info->pc = _THIS_IP_;
> +}
> + #else
> +static inline void cpu_prepare_nvhe_panic_info(void)
> +{
> +}
>  #endif
>
>  static void __activate_traps(struct kvm_vcpu *vcpu)
> @@ -360,6 +376,8 @@ asmlinkage void __noreturn hyp_panic(void)
>         struct kvm_cpu_context *host_ctxt;
>         struct kvm_vcpu *vcpu;
>
> +       cpu_prepare_nvhe_panic_info();
> +
>         host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
>         vcpu = host_ctxt->__hyp_running_vcpu;
>
> --
> 2.35.1.473.g83b2b277ed-goog
>
