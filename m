Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF22657C86B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiGUKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiGUJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:59:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66378210D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ez10so2185392ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRuj5aWsShz9jBaLwek0rK4p5Pf7KkoKG3tMbRUcKb4=;
        b=TyTUbJW3Oel0yeLIXKJoooWk7FIEJOV+gb8QtrYbB6QDVzgwMOWkD8jOXUqSg/N+wX
         eH4htGxC73E0r5kp3JnF9TtfwAkp3/ts+GobF22K8d6PUCb8yM8en4tsAJ4n7Uvfl51K
         JvlT8QxY/tqO2n7HVJN018YB6s2YNMIh3FPYKuwr8XnRKlvsT924QkzuVJXbKyZbkEex
         rOi4wjEA8B6MDoyIbzlLg7l7cX5sQkQoTDpQGj8b3FBxtOzNQsV2ggQe+ek2ofTtPM4B
         AjXLyFluovVgNtzFfl+sItcQuGK08VZ93lEinKTw8iK8oe2j4JHFoqj9vHsI4CLbgB4F
         W9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRuj5aWsShz9jBaLwek0rK4p5Pf7KkoKG3tMbRUcKb4=;
        b=z62/ie6IKFkc40gNof1GWYhCbzFoiC3As/ovd88lF24r26WIV0BbNBkFyxXBGarB9j
         NSpsopZNAmjXhLeIX998aMcNl9DdZgKiFwrz8+A6CSHNgi6ZM8nohe9k4aDLoHMV/XI/
         6o16ij0zMn69aWwI1ezDxOFEMsvbmDMq1ISO07O/hnJGxrjcg8UquzfXSgOdFK1UvDb1
         8gTYYfbQpP6DSXiuA5k+o3uu+qQVV3eu41YbwowyWhggYNko1K/khQK4R3mdxosYxPPV
         ddjfXO44mhvZOAb3OLzu5EOiE4ApGgiuDe70YAWa/5mzj9qBGyNWiNAjL8PahwzV5n39
         dJXA==
X-Gm-Message-State: AJIora/Kk/OhE93WP7m6sOhbJwNnfs/4gGt+7otPk5EKlz7T53Fr6I+L
        4y6aYt3MoiEMe71H/L3JdnurtnZsY4vzYD8eBM3R2g==
X-Google-Smtp-Source: AGRyM1t/qVesbs7dKOtAbMkwDi3wAd1KAXVNo7EHGxe/fuV6MDJG76vZdRfMeEm/jZtDQwF+LhqMVK4rrBBVRzoNfRk=
X-Received: by 2002:a17:907:72c6:b0:72f:b01:2723 with SMTP id
 du6-20020a17090772c600b0072f0b012723mr26071762ejc.439.1658397593110; Thu, 21
 Jul 2022 02:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-18-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-18-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:59:16 +0100
Message-ID: <CA+EHjTza-fm0j5FU3n4huYTtiNTEDZ7qx10iYW7NSZ=eoUKYVQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] KVM: arm64: Introduce hyp_dump_backtrace()
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
> In non-protected nVHE mode, unwinds and dumps the hypervisor backtrace
> from EL1. This is possible beacuase the host can directly access the
> hypervisor stack pages in non-proteced mode.

because and non-protected

>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>
> Changes in v5:
>   - Move code out from nvhe.h header to handle_exit.c, per Marc
>   - Fix stacktrace symoblization when CONFIG_RAMDOMIZE_BASE is enabled,
>     per Fuad
>   - Use regular comments instead of doc comments, per Fuad
>
>  arch/arm64/kvm/handle_exit.c | 65 +++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index ad568da5c7d7..432b6b26f4ad 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -17,6 +17,7 @@
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/debug-monitors.h>
> +#include <asm/stacktrace/nvhe.h>
>  #include <asm/traps.h>
>
>  #include <kvm/arm_hypercalls.h>
> @@ -318,6 +319,56 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
>                 kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
>  }
>
> +/*
> + * kvm_nvhe_print_backtrace_entry - Symbolizes and prints the HYP stack address
> + */
> +static void kvm_nvhe_print_backtrace_entry(unsigned long addr,
> +                                                 unsigned long hyp_offset)
> +{
> +       unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
> +
> +       /* Mask tags and convert to kern addr */
> +       addr = (addr & va_mask) + hyp_offset;
> +       kvm_err(" [<%016lx>] %pB\n", addr, (void *)(addr + kaslr_offset()));
> +}
> +
> +/*
> + * hyp_dump_backtrace_entry - Dump an entry of the non-protected nVHE HYP stacktrace
> + *
> + * @arg    : the hypervisor offset, used for address translation
> + * @where  : the program counter corresponding to the stack frame
> + */
> +static bool hyp_dump_backtrace_entry(void *arg, unsigned long where)
> +{
> +       kvm_nvhe_print_backtrace_entry(where, (unsigned long)arg);
> +
> +       return true;
> +}
> +
> +/*
> + * hyp_dump_backtrace - Dump the non-proteced nVHE HYP backtrace.

non-protected

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> + *
> + * @hyp_offset: hypervisor offset, used for address translation.
> + *
> + * The host can directly access HYP stack pages in non-protected
> + * mode, so the unwinding is done directly from EL1. This removes
> + * the need for shared buffers between host and hypervisor for
> + * the stacktrace.
> + */
> +static void hyp_dump_backtrace(unsigned long hyp_offset)
> +{
> +       struct kvm_nvhe_stacktrace_info *stacktrace_info;
> +       struct unwind_state state;
> +
> +       stacktrace_info = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
> +
> +       kvm_nvhe_unwind_init(&state, stacktrace_info->fp, stacktrace_info->pc);
> +
> +       kvm_err("Non-protected nVHE HYP call trace:\n");
> +       unwind(&state, hyp_dump_backtrace_entry, (void *)hyp_offset);
> +       kvm_err("---- End of Non-protected nVHE HYP call trace ----\n");
> +}
> +
>  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
>  DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)],
>                          pkvm_stacktrace);
> @@ -336,18 +387,12 @@ static void pkvm_dump_backtrace(unsigned long hyp_offset)
>  {
>         unsigned long *stacktrace_entry
>                 = (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
> -       unsigned long va_mask, pc;
> -
> -       va_mask = GENMASK_ULL(vabits_actual - 1, 0);
>
>         kvm_err("Protected nVHE HYP call trace:\n");
>
> -       /* The stack trace is terminated by a null entry */
> -       for (; *stacktrace_entry; stacktrace_entry++) {
> -               /* Mask tags and convert to kern addr */
> -               pc = (*stacktrace_entry & va_mask) + hyp_offset;
> -               kvm_err(" [<%016lx>] %pB\n", pc, (void *)(pc + kaslr_offset()));
> -       }
> +       /* The saved stacktrace is terminated by a null entry */
> +       for (; *stacktrace_entry; stacktrace_entry++)
> +               kvm_nvhe_print_backtrace_entry(*stacktrace_entry, hyp_offset);
>
>         kvm_err("---- End of Protected nVHE HYP call trace ----\n");
>  }
> @@ -367,6 +412,8 @@ static void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
>  {
>         if (is_protected_kvm_enabled())
>                 pkvm_dump_backtrace(hyp_offset);
> +       else
> +               hyp_dump_backtrace(hyp_offset);
>  }
>
>  void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
> --
> 2.37.0.170.g444d1eabd0-goog
>
