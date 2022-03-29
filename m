Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A04EA9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiC2Ixm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiC2IxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:53:25 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECFD5AA50
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:42 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-df0940c4eeso4549048fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJe5O/dIYvnfHgc69g0ehLPKljcP5RKzYK2S6ZDVOnE=;
        b=Uba6bE+82Py38fI3DPMkzE6lkUD0b/uApAHybu4BE6FTGoLWsQpNaC2VhN6RdAAIbL
         F8/DEKspBDMmWd8Jw+7HQgx+ynr9i6mN1aiqNpxajiOoBV2yDzvroGFL3siW+MkNqrnX
         jcxJTBRWxa7Wf9mhwUfWT/6utLuJFzzHV3iIwtdA4NK5NRAaWPwyqGMe82wv8awpU44N
         q+3oKwp/reccSUIQBFI9jC6ZG+CRkojREJH+JZXJe9VgEkrc4rUugOPsB9VVEDoJ3mXk
         T+aNBI33U7vN9UoMvZxpDF6ROVXQsH+yI522YkW0qsNdVZsvcmC+NeWkBK1EBMlY1B6n
         vRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJe5O/dIYvnfHgc69g0ehLPKljcP5RKzYK2S6ZDVOnE=;
        b=PDkIBaa5RreL/kM2fVIZjSk5bXMAco/5Tt/wdPgcBoPPx58l+VNsLaV/x4ZuH8/ifH
         FfsvKMLN0S+Ho6Hc6526eOL6zffmxMbblz5lSd4/vTp6T3bUjMb4/XdjKiWzbV67GWjn
         FC+XuZaS/iCoXGcFx0mg/z8PEYBlruwv0YdIS8PfMpJhacV49BUUdsBL4zSPFsfYFAo0
         xAZm32Y5qcYO2hgGHCHXu1R8hyvxbFQGzy/pRD0sJEZPVv0Daw2kyRqh1LJQaeXJGJbq
         GWq2CTUhZpdiPq5rp3/jUR7Vwt1gft5s5hUcj1f82ciO2B+fFau08y+NnzIYzbRT9IHY
         kXew==
X-Gm-Message-State: AOAM530fvW+uXCYX2baVB0HyRB2bTxhTasJXl+uYJqYWat0FPrXNc72n
        vx8zup+GC0wz/8k2XlWXHueQCVZNgiHnTPUNG2xDdb5EMzM=
X-Google-Smtp-Source: ABdhPJzQnNB1enU6Vkw99LKFBHjurfLKTPpi/C2YL5+IsoNf/fgBuvf7UOzi/nLVp7bF67JAE1XzNk8Susa0c79YPd0=
X-Received: by 2002:a05:6870:700f:b0:dd:9f77:9a97 with SMTP id
 u15-20020a056870700f00b000dd9f779a97mr1639234oae.146.1648543901566; Tue, 29
 Mar 2022 01:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com> <20220314200148.2695206-6-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-6-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 29 Mar 2022 09:51:05 +0100
Message-ID: <CA+EHjTxkug-92zR5sr7icry8KWuksAt6PBt95QTjtkYonF7-Ng@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] KVM: arm64: Detect and handle hypervisor stack overflows
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
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


On Mon, Mar 14, 2022 at 8:05 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> The hypervisor stacks (for both nVHE Hyp mode and nVHE protected mode)
> are aligned such  that any valid stack address has PAGE_SHIFT bit as 1.
> This allows us to conveniently check for overflow in the exception entry
> without corrupting any GPRs. We won't recover from a stack overflow so
> panic the hypervisor.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
>
> Changes in v5:
>   - Valid stack addresses now have PAGE_SHIFT bit as 1 instead of 0
>
> Changes in v3:
>   - Remove test_sp_overflow macro, per Mark
>   - Add asmlinkage attribute for hyp_panic, hyp_panic_bad_stack, per Ard
>
>
>  arch/arm64/kvm/hyp/nvhe/host.S   | 24 ++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c |  7 ++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index 3d613e721a75..be6d844279b1 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -153,6 +153,18 @@ SYM_FUNC_END(__host_hvc)
>
>  .macro invalid_host_el2_vect
>         .align 7
> +
> +       /*
> +        * Test whether the SP has overflowed, without corrupting a GPR.
> +        * nVHE hypervisor stacks are aligned so that the PAGE_SHIFT bit
> +        * of SP should always be 1.
> +        */
> +       add     sp, sp, x0                      // sp' = sp + x0
> +       sub     x0, sp, x0                      // x0' = sp' - x0 = (sp + x0) - x0 = sp
> +       tbz     x0, #PAGE_SHIFT, .L__hyp_sp_overflow\@
> +       sub     x0, sp, x0                      // x0'' = sp' - x0' = (sp + x0) - sp = x0
> +       sub     sp, sp, x0                      // sp'' = sp' - x0 = (sp + x0) - x0 = sp
> +
>         /* If a guest is loaded, panic out of it. */
>         stp     x0, x1, [sp, #-16]!
>         get_loaded_vcpu x0, x1
> @@ -165,6 +177,18 @@ SYM_FUNC_END(__host_hvc)
>          * been partially clobbered by __host_enter.
>          */
>         b       hyp_panic
> +
> +.L__hyp_sp_overflow\@:
> +       /*
> +        * Reset SP to the top of the stack, to allow handling the hyp_panic.
> +        * This corrupts the stack but is ok, since we won't be attempting
> +        * any unwinding here.
> +        */
> +       ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> +       mov     sp, x0
> +
> +       bl      hyp_panic_bad_stack
> +       ASM_BUG()
>  .endm
>
>  .macro invalid_host_el1_vect
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 6410d21d8695..703a5d3f611b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -347,7 +347,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
>         return exit_code;
>  }
>
> -void __noreturn hyp_panic(void)
> +asmlinkage void __noreturn hyp_panic(void)
>  {
>         u64 spsr = read_sysreg_el2(SYS_SPSR);
>         u64 elr = read_sysreg_el2(SYS_ELR);
> @@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
>         unreachable();
>  }
>
> +asmlinkage void __noreturn hyp_panic_bad_stack(void)
> +{
> +       hyp_panic();
> +}
> +
>  asmlinkage void kvm_unexpected_el2_exception(void)
>  {
>         return __kvm_unexpected_el2_exception();
> --
> 2.35.1.723.g4982287a31-goog
>
