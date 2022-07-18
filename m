Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0380F577F59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiGRKHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiGRKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:07:39 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BE1C117
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:07:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id k25-20020a056830169900b0061c6f68f451so8788893otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1B6LYic7bwDg6gUAL/jCgt+JOlqR4ifyS5aTqPKrh0=;
        b=UrRegEvgPG/jfL/dTEzLtOHbQnT4nLgaRrymQ49RRzhmYlHF+O/jiDozArIukNwL70
         aoL/5Ccyc5I9l9zZNmm3atZ7sP6lR87VCBAO4eU3XjMJ7S1BflZKm+aWOUbZeUzIvZnb
         oll4eQNo1XPtDZpsmMOUPvQT87touG3F/SnR/t9CzPoCgcWPWvlLn+SEK6uR2pK7FZI4
         tqXhIrFnpgJXlB8fXQE/sw2igM+pcNtQs6hCwE8fD4LwZD2AUPUPemiW9Mqdr+PQp2kB
         RZjSxduPY0l1QTOQPxxbIxLOIk5X1py6qkPCTcj+e+jpfru4faiCWHE/+ucGnSJ512lq
         t02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1B6LYic7bwDg6gUAL/jCgt+JOlqR4ifyS5aTqPKrh0=;
        b=i8PSobGMHEqZuxZEl0XOsLRsAY/lTm0d/tdFVbCGBYHtevZcRvx+Nu+/FNxt7Odf4N
         ethxGap5BnL/MU+UN0vfVPqH/wGK1XaWf4tO/jGd9E09UJ7M8ynwj7pjIv0wx3T0I2sZ
         kjfPcaTFzBAbHMjdNpIJKCyOmdLMcTCXBhoWzqgxh4cirb9mOB7PPci4p2fDOKUxy5Do
         JzQeCKcHGvbAUd46n33hOstFyRDY4FwFmP6M81XfnwnqvvCGKmg9JCJcZ2nvCwAGuWPZ
         ymz+cbIKO2YhSfndI/3PFWf7GjniE9GWx0/BY1nj/44KkBmATOSex30AyIfu0xvr9wbJ
         hyWw==
X-Gm-Message-State: AJIora8AMDyFEkkt/bA/8HyOaezG315rX+Q10FTR34r1YqEM3oCu45Ou
        xxqKBpTMtDckZH+kiYlzliY4np9d5Y6oX6Jg+OC73g==
X-Google-Smtp-Source: AGRyM1ujoTWX6QWprhwkAQ746MHzUqCvowmZ3vcJ0lh4yknvlPC4dPBONKcRGGIrdbY+40/9rxyxa6G4CCS8RwlIeUk=
X-Received: by 2002:a05:6830:108a:b0:61c:9fb5:6784 with SMTP id
 y10-20020a056830108a00b0061c9fb56784mr1830589oto.299.1658138857268; Mon, 18
 Jul 2022 03:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-13-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-13-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 18 Jul 2022 11:07:00 +0100
Message-ID: <CA+EHjTw8VwFHYHzpyt+sqwo7CDhGm+F+h2+AX=5FtYcXPECGUA@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
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

On Fri, Jul 15, 2022 at 7:11 AM Kalesh Singh <kaleshsingh@google.com> wrote:
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
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/include/asm/stacktrace/nvhe.h | 18 ++++++
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 70 ++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> index 36cf7858ddd8..456a6ae08433 100644
> --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -21,6 +21,22 @@
>
>  #include <asm/stacktrace/common.h>
>
> +/**
> + * kvm_nvhe_unwind_init - Start an unwind from the given nVHE HYP fp and pc
> + *
> + * @fp : frame pointer at which to start the unwinding.
> + * @pc : program counter at which to start the unwinding.
> + */
> +static __always_inline void kvm_nvhe_unwind_init(struct unwind_state *state,
> +                                                unsigned long fp,
> +                                                unsigned long pc)
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
> @@ -33,6 +49,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
>   */
>  #ifdef __KVM_NVHE_HYPERVISOR__
>
> +extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
> +
>  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
>  static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
>                                      struct stack_info *info)
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> index 96c8b93320eb..832a536e440f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -11,4 +11,74 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
>
>  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
>  DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
> +
> +/**
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
> +       unsigned long **stacktrace_pos = (unsigned long **)arg;
> +       unsigned long stacktrace_start, stacktrace_end;
> +
> +       stacktrace_start = (unsigned long)this_cpu_ptr(pkvm_stacktrace);
> +       stacktrace_end = stacktrace_start + NVHE_STACKTRACE_SIZE - (2 * sizeof(long));

I guess this is related to my comment in patch 9, but why does the end
happen at 2 * instead of just 1 * before the actual end? I guess
because it's inclusive. That said, a comment would be helpful.

Thanks,
/fuad

> +
> +       if ((unsigned long) *stacktrace_pos > stacktrace_end)
> +               return false;
> +
> +       /* Save the entry to the current pos in stacktrace buffer */
> +       **stacktrace_pos = where;
> +
> +       /* A zero entry delimits the end of the stacktrace. */
> +       *(*stacktrace_pos + 1) = 0UL;
> +
> +       /* Increment the current pos */
> +       ++*stacktrace_pos;
> +
> +       return true;
> +}
> +
> +/**
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
> +       void *stacktrace_start = (void *)this_cpu_ptr(pkvm_stacktrace);
> +       struct unwind_state state;
> +
> +       kvm_nvhe_unwind_init(&state, fp, pc);
> +
> +       unwind(&state, pkvm_save_backtrace_entry, &stacktrace_start);
> +}
> +#else /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> +static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
> +{
> +}
>  #endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> +
> +/**
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
> --
> 2.37.0.170.g444d1eabd0-goog
>
