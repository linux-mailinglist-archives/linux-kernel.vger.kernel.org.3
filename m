Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAD57C862
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiGUJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiGUJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:59:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6906820DB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so2253741ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICWtRl11EBLkBuC8EKMztaMYVbdXxjQF2E9VxjALgEA=;
        b=WE9n3XArdq7o+kzZ13s0vVvM7r42mMYB85W4rZvYcjhnt9r9XI5WbIKrjfW1LQ1pZo
         4fVZ1r/gPV499EesnIUsH8/MWOY20iAEm2+xGjR9KwHQBrsI9oS9+8qrC3JcYcoGSuDz
         S9eIWpz9x8RfGmZjQ+JZaXzfj6NvJ9/sYg+VD2tIoCHNXHeaNnyeoQpI5bLB+0ivhEqV
         a9gxnXEBoATbkdyY+gfySkgoHPGutTbCt/BPyng0x12sMOIdkXPGgI22eLE3kU7m/gQ9
         RydAP1+0G3mYntwQK5R9Vvpu482j61AuTxmLn/cJolqCYiX3YLHELJit8Zhx687II1lL
         eKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICWtRl11EBLkBuC8EKMztaMYVbdXxjQF2E9VxjALgEA=;
        b=J20RfTBqrbYIWaVXG/zsHzHqu7HKJJtjtC0Sp4KjHtGrtshzvArpP0GK+cD5iFQz62
         z5yxNwOMSYiSCC+I039UjQIvBQWOzdIfBJ4DKof+Y1ZZFo5eO1iaaJq1qQTOJs/11Ers
         RXJbarwxVK35xA/JXRL5JqCED3yxwMF7Xhok5SfEL2Jec3VnfSQ70z9TW4555hVPx7PC
         NWARv//uW3OI6+XcCr78PGs4XihXxuebIQ/4Zf5gB+TqpWH3DxgZ+CSg0j59xDFM4QSd
         PHUu3urjZ1xtLJN+36XPe8o5TakoyKTlaWbIfjNZd4Iq6tmWvjmMe871aQ1ViwdOW1Dv
         qSBQ==
X-Gm-Message-State: AJIora9XSzrOyetI97ECWB51LEy43W9d6SAEB2ulEIEde7nq6+zbSfTk
        XGHJEAB9iWA4V8Jvf/V1AishjJePuzs6DjcHCHJ85g==
X-Google-Smtp-Source: AGRyM1sjg+ZFLlpWNaGHG3a6g5PxuklNxTpGOLm/IgklW+n1Stkn0tqCWIQ3ZsPM3p/lMtRZYk/TmwDVwdphzfzbS60=
X-Received: by 2002:a17:907:7ea7:b0:72b:6e6b:4895 with SMTP id
 qb39-20020a1709077ea700b0072b6e6b4895mr39726176ejc.338.1658397549012; Thu, 21
 Jul 2022 02:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-14-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-14-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:58:32 +0100
Message-ID: <CA+EHjTxpHxojNdRm21hYgcWqFJCzPx3jch2bdVqZ4+2NQqNvDA@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] KVM: arm64: Prepare non-protected nVHE
 hypervisor stacktrace
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
> In non-protected nVHE mode (non-pKVM) the host can directly access
> hypervisor memory; and unwinding of the hypervisor stacktrace is
> done from EL1 to save on memory for shared buffers.
>
> To unwind the hypervisor stack from EL1 the host needs to know the
> starting point for the unwind and information that will allow it to
> translate hypervisor stack addresses to the corresponding kernel
> addresses. This patch sets up this book keeping. It is made use of
> later in the series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>
> Changes in v5:
>   - Use regular comments instead of doc comments, per Fuad
>
>  arch/arm64/include/asm/kvm_asm.h         | 16 ++++++++++++++++
>  arch/arm64/include/asm/stacktrace/nvhe.h |  4 ++++
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 24 ++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 2e277f2ed671..53035763e48e 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -176,6 +176,22 @@ struct kvm_nvhe_init_params {
>         unsigned long vtcr;
>  };
>
> +/*
> + * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
> + * hyp_panic() in non-protected mode.
> + *
> + * @stack_base:                 hyp VA of the hyp_stack base.
> + * @overflow_stack_base:        hyp VA of the hyp_overflow_stack base.
> + * @fp:                         hyp FP where the backtrace begins.
> + * @pc:                         hyp PC where the backtrace begins.
> + */
> +struct kvm_nvhe_stacktrace_info {
> +       unsigned long stack_base;
> +       unsigned long overflow_stack_base;
> +       unsigned long fp;
> +       unsigned long pc;
> +};
> +
>  /* Translate a kernel address @ptr into its equivalent linear mapping */
>  #define kvm_ksym_ref(ptr)                                              \
>         ({                                                              \
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> index 05d7e03e0a8c..8f02803a005f 100644
> --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -19,6 +19,7 @@
>  #ifndef __ASM_STACKTRACE_NVHE_H
>  #define __ASM_STACKTRACE_NVHE_H
>
> +#include <asm/kvm_asm.h>
>  #include <asm/stacktrace/common.h>
>
>  /*
> @@ -52,6 +53,9 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
>   * In protected mode, the unwinding is done by the hypervisor in EL2.
>   */
>
> +DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
> +DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
> +
>  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
>  static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
>                                      struct stack_info *info)
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> index 60461c033a04..cbd365f4f26a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -9,6 +9,28 @@
>  DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
>         __aligned(16);
>
> +DEFINE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
> +
> +/*
> + * hyp_prepare_backtrace - Prepare non-protected nVHE backtrace.
> + *
> + * @fp : frame pointer at which to start the unwinding.
> + * @pc : program counter at which to start the unwinding.
> + *
> + * Save the information needed by the host to unwind the non-protected
> + * nVHE hypervisor stack in EL1.
> + */
> +static void hyp_prepare_backtrace(unsigned long fp, unsigned long pc)
> +{
> +       struct kvm_nvhe_stacktrace_info *stacktrace_info = this_cpu_ptr(&kvm_stacktrace_info);
> +       struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
> +
> +       stacktrace_info->stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
> +       stacktrace_info->overflow_stack_base = (unsigned long)this_cpu_ptr(overflow_stack);
> +       stacktrace_info->fp = fp;
> +       stacktrace_info->pc = pc;
> +}
> +
>  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
>  DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
>
> @@ -89,4 +111,6 @@ void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
>  {
>         if (is_protected_kvm_enabled())
>                 pkvm_save_backtrace(fp, pc);
> +       else
> +               hyp_prepare_backtrace(fp, pc);
>  }
> --
> 2.37.0.170.g444d1eabd0-goog
>
