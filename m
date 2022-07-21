Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31457C860
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiGUJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGUJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:59:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33529820C5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so2253110ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZvUKHJNTfmBnKV8kgAnzPvrEetHhpiiwn0CmD7YnH8=;
        b=gCb97B26rLG9bG6wWGSo2AzrAVTY7CYKpx+TdQI13hc+pfM6pvmLXVFX8n8MkbI+rT
         /TZcpud5Pwcv8YJm1cFZiz6E6C1/FmLuR7ARLCN2X6yQV65eoNokK3JxnCv0eq0Pnvo9
         fnBJ2Dm6zYJh+FktFH/xMiqctQwQUtO6/SyBIIa+9LjOkBUUN1gcSyo8stmauamoAixp
         qPdPaOg49j6rqBvrMyK0RLBbfOL8Fexvb33IjNca2bT8VUotOcadcKpBh5IAWDYgFJqt
         /m21CqY9/cFF8LUXvF7KOehl/NDK4XeChBOJmKYU9d4FGzrVFbGAyDk4FJ6OqLpFMfo3
         pyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZvUKHJNTfmBnKV8kgAnzPvrEetHhpiiwn0CmD7YnH8=;
        b=VZ+cP7g9g7DdjFnN/CLZVy/eBuBPLUjbAWvTGURK294dnsmn7yeJuPii1sHT8R2lkm
         nYgroPyZkl3nmF7bYLrAB6gLiC3F6LFrjWH7icZiIdU/GzYXK7ObeQIL6MdFd+3X83Sl
         OyL9hX3opMnFDKEj0WUeqs5lBqq3ilxZT+rZyX0izfI9TSxN2PoMXclnJ/Fmq0G21/lU
         jpikrKUvglGYXH84aDXh+05r/p8oFjCifF+ur9JX+R7nr3pjM0YcYFoCX5E8Me8TvEBM
         ychBVG3vQVsKwfr68r1kniQYQ/cfKybjXr9T2f9rZLEE2r0wHWhVuJW3NgbN9I6SJql6
         qg6w==
X-Gm-Message-State: AJIora+VSyWpDj9AxyYZgThifi6FF6zqdaxq5u+5WNK4lJxa2zMwI/3l
        Vm++8OK8u/YCm7JejxhE9rJFwDlAvRsNq9vNcvKc1w==
X-Google-Smtp-Source: AGRyM1tcz6e/l4Oph01eihlks0EVOmphItgj8l47cRLt7S4wfGEFGfhtupc4cemx3y5ufynf45Jpj7Lr4NpZRkNlJCE=
X-Received: by 2002:a17:906:84e8:b0:72b:6d91:a0d1 with SMTP id
 zp8-20020a17090684e800b0072b6d91a0d1mr39865923ejb.60.1658397540482; Thu, 21
 Jul 2022 02:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-13-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-13-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:58:23 +0100
Message-ID: <CA+EHjTxpgn2-Bi_-JoAnb_2iGJGxE+qHnZu7EvSE5ksS8KPciQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/17] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Thu, Jul 21, 2022 at 6:58 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> In protected nVHE mode, the host cannot access private owned hypervisor
> memory. Also the hypervisor aims to remains simple to reduce the attack
> surface and does not provide any printk support.
>
> For the above reasons, the approach taken to provide hypervisor stacktraces
> in protected mode is:
>    1) Unwind and save the hyp stack addresses in EL2 to a shared buffer
>       with the host (done in this patch).
>    2) Delegate the dumping and symbolization of the addresses to the
>       host in EL1 (later patch in the series).
>
> On hyp_panic(), the hypervisor prepares the stacktrace before returning to
> the host.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>
> Changes in v5:
>   - Comment/clarify pkvm_save_backtrace_entry(), per Fuad
>   - kvm_nvhe_unwind_init(), doesn't need to be always inline, make it
>     inline instead to avoid linking issues, per Marc
>   - Use regular comments instead of doc comments, per Fuad
>
>  arch/arm64/include/asm/stacktrace/nvhe.h | 17 ++++++
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 78 ++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c         |  6 ++
>  3 files changed, 101 insertions(+)
>
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> index 3078501f8e22..05d7e03e0a8c 100644
> --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -21,6 +21,23 @@
>
>  #include <asm/stacktrace/common.h>
>
> +/*
> + * kvm_nvhe_unwind_init - Start an unwind from the given nVHE HYP fp and pc
> + *
> + * @state : unwind_state to initialize
> + * @fp    : frame pointer at which to start the unwinding.
> + * @pc    : program counter at which to start the unwinding.
> + */
> +static inline void kvm_nvhe_unwind_init(struct unwind_state *state,
> +                                       unsigned long fp,
> +                                       unsigned long pc)
> +{
> +       unwind_init_common(state, NULL);
> +
> +       state->fp = fp;
> +       state->pc = pc;
> +}
> +
>  static inline bool on_accessible_stack(const struct task_struct *tsk,
>                                        unsigned long sp, unsigned long size,
>                                        struct stack_info *info)
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> index 96c8b93320eb..60461c033a04 100644
> --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -11,4 +11,82 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
>
>  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
>  DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
> +
> +/*
> + * pkvm_save_backtrace_entry - Saves a protected nVHE HYP stacktrace entry
> + *
> + * @arg    : the position of the entry in the stacktrace buffer
> + * @where  : the program counter corresponding to the stack frame
> + *
> + * Save the return address of a stack frame to the shared stacktrace buffer.
> + * The host can access this shared buffer from EL1 to dump the backtrace.
> + */
> +static bool pkvm_save_backtrace_entry(void *arg, unsigned long where)
> +{
> +       unsigned long **stacktrace_entry = (unsigned long **)arg;
> +       int nr_entries = NVHE_STACKTRACE_SIZE / sizeof(long);
> +       unsigned long *stacktrace_start, *stacktrace_end;
> +
> +       stacktrace_start = (unsigned long *)this_cpu_ptr(pkvm_stacktrace);
> +       stacktrace_end = stacktrace_start + nr_entries;
> +
> +       /*
> +        * Need 2 free slots: 1 for current entry and 1 for the
> +        * trailing zero entry delimiter.
> +        */
> +       if (*stacktrace_entry > stacktrace_end - 2)
> +               return false;
> +
> +       /* Save the current entry */
> +       **stacktrace_entry = where;
> +
> +       /* Add trailing zero entry delimiter */
> +       *(*stacktrace_entry + 1) = 0UL;
> +
> +       /*
> +        * Increment the current entry position. The zero entry
> +        * will be overwritten by the next backtrace entry (if any)
> +        */
> +       ++*stacktrace_entry;
> +
> +       return true;
> +}
> +
> +/*
> + * pkvm_save_backtrace - Saves the protected nVHE HYP stacktrace
> + *
> + * @fp : frame pointer at which to start the unwinding.
> + * @pc : program counter at which to start the unwinding.
> + *
> + * Save the unwinded stack addresses to the shared stacktrace buffer.
> + * The host can access this shared buffer from EL1 to dump the backtrace.
> + */
> +static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
> +{
> +       void *stacktrace_entry = (void *)this_cpu_ptr(pkvm_stacktrace);
> +       struct unwind_state state;
> +
> +       kvm_nvhe_unwind_init(&state, fp, pc);
> +
> +       unwind(&state, pkvm_save_backtrace_entry, &stacktrace_entry);
> +}
> +#else /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> +static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
> +{
> +}
>  #endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> +
> +/*
> + * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
> + *
> + * @fp : frame pointer at which to start the unwinding.
> + * @pc : program counter at which to start the unwinding.
> + *
> + * Saves the information needed by the host to dump the nVHE hypervisor
> + * backtrace.
> + */
> +void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
> +{
> +       if (is_protected_kvm_enabled())
> +               pkvm_save_backtrace(fp, pc);
> +}
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 6db801db8f27..64e13445d0d9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -34,6 +34,8 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
>  DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
>  DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
>
> +extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
> +
>  static void __activate_traps(struct kvm_vcpu *vcpu)
>  {
>         u64 val;
> @@ -375,6 +377,10 @@ asmlinkage void __noreturn hyp_panic(void)
>                 __sysreg_restore_state_nvhe(host_ctxt);
>         }
>
> +       /* Prepare to dump kvm nvhe hyp stacktrace */
> +       kvm_nvhe_prepare_backtrace((unsigned long)__builtin_frame_address(0),
> +                                  _THIS_IP_);
> +
>         __hyp_do_panic(host_ctxt, spsr, elr, par);
>         unreachable();
>  }
> --
> 2.37.0.170.g444d1eabd0-goog
>
