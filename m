Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7603F57C864
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiGUJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiGUJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:59:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5067C820DF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so2255078ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zPB+ZV4Xrrq+Kcn0bkCJJPjeU/vNo5EqrxJwRUCS1A=;
        b=rlYVsHDLITER6xoaQ69OnVwTUoomKByTN+gPGK9K2t0crSEBimtTWlWYFftRFscoHr
         emiG/AZK7JszLPfoeYpWgLLMG8Ty1+pX1XnbHdVznHb5XX87JKiX0a5+B24fyD/hUktK
         GVkvK2tkeMFap6N+Slrs2dOf2ouBqwEQ8m8mTO7IX63NNV9F7ZgOX19D7yrG49GroD91
         D8+oWOBLOrzJq0W/3/W2amNHKLT14yHoI56PQI9FOeo1rfg2OhNt368MKiCyjPYtCb0l
         9IRvbmyM9rSQNpI8UDNh/n07qsIT9EmRss+sKwvzNjf2znoig533h6wSpTHvJK1d1XiL
         A0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zPB+ZV4Xrrq+Kcn0bkCJJPjeU/vNo5EqrxJwRUCS1A=;
        b=F/Pp6H35BYZbNxqZ7TPKRLD/BvDj59L1tomS/I0dCCrylB4vBbo9BV4eK5JhTMp03i
         cJwGBhBdtYtqbh4WMPcJzMqDjMihxPpQ1fApzBVim8+NrFxf+D8qUT20TGIPD4zFDEXY
         85Jhm8AbbQyPMK1+xWHRryOyXuqTIN8dMaVBHgfr+62nFCdHUD53POoWtL0gN8xVtmZC
         BM6CEJeAT1ngpIJNOyS9OS71qvcXzC/QpY3QP6CQoGbn/fM8G21C9cxlyXbqEiz9xeSC
         Y+LRU12NEVcYe0UYjgW1Lr5BKqMdJRvCR+Zgkt/mCJk5L3Dh6VVHWG/xlcT58/UPLndh
         a6fg==
X-Gm-Message-State: AJIora+GsiEqZyw5IHjwct8nLYYDJ/gW4d1lPnxzhaahkaHZ/j5Ozx9S
        Q2OyFBsQlRp54MZ91zXQrIrAUxX0dMm5H7C6tg0lsA==
X-Google-Smtp-Source: AGRyM1tC1QMisFjGwD5R0J3SfMsabxPDnO9sTLmyjaTXAlyMYIr2z+UyVExzMJqvTZbfS7ikgd404pZy5ZSTPNhV/rU=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr38027129ejc.242.1658397567669; Thu, 21
 Jul 2022 02:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-16-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-16-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:58:50 +0100
Message-ID: <CA+EHjTy4ozkDCs0FECRnJFfN-_G0ye4uJ3OVhMRvzUQux-QL=A@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] KVM: arm64: Implement non-protected nVHE hyp
 stack unwinder
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
> Implements the common framework necessary for unwind() to work
> for non-protected nVHE mode:
>     - on_accessible_stack()
>     - on_overflow_stack()
>     - unwind_next()
>
> Non-protected nVHE unwind() is used to unwind and dump the hypervisor
> stacktrace by the host in EL1
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
>  arch/arm64/include/asm/stacktrace/nvhe.h | 67 +++++++++++++++++++++++-
>  arch/arm64/kvm/arm.c                     |  2 +-
>  2 files changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> index c3688e717136..7a6e761aa443 100644
> --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -120,15 +120,78 @@ NOKPROBE_SYMBOL(unwind_next);
>   * (by the host in EL1).
>   */
>
> +DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack);
> +DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
> +DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> +
> +/*
> + * kvm_nvhe_stack_kern_va - Convert KVM nVHE HYP stack addresses to a kernel VAs
> + *
> + * The nVHE hypervisor stack is mapped in the flexible 'private' VA range, to
> + * allow for guard pages below the stack. Consequently, the fixed offset address
> + * translation macros won't work here.
> + *
> + * The kernel VA is calculated as an offset from the kernel VA of the hypervisor
> + * stack base.
> + *
> + * Returns true on success and updates @addr to its corresponding kernel VA;
> + * otherwise returns false.
> + */
> +static inline bool kvm_nvhe_stack_kern_va(unsigned long *addr,
> +                                         enum stack_type type)
> +{
> +       struct kvm_nvhe_stacktrace_info *stacktrace_info;
> +       unsigned long hyp_base, kern_base, hyp_offset;
> +
> +       stacktrace_info = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
> +
> +       switch (type) {
> +       case STACK_TYPE_HYP:
> +               kern_base = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
> +               hyp_base = (unsigned long)stacktrace_info->stack_base;
> +               break;
> +       case STACK_TYPE_OVERFLOW:
> +               kern_base = (unsigned long)this_cpu_ptr_nvhe_sym(overflow_stack);
> +               hyp_base = (unsigned long)stacktrace_info->overflow_stack_base;
> +               break;
> +       default:
> +               return false;
> +       }
> +
> +       hyp_offset = *addr - hyp_base;
> +
> +       *addr = kern_base + hyp_offset;
> +
> +       return true;
> +}
> +
>  static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
>                                      struct stack_info *info)
>  {
> -       return false;
> +       struct kvm_nvhe_stacktrace_info *stacktrace_info
> +                               = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
> +       unsigned long low = (unsigned long)stacktrace_info->overflow_stack_base;
> +       unsigned long high = low + OVERFLOW_STACK_SIZE;
> +
> +       return on_stack(sp, size, low, high, STACK_TYPE_OVERFLOW, info);
> +}
> +
> +static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
> +                               struct stack_info *info)
> +{
> +       struct kvm_nvhe_stacktrace_info *stacktrace_info
> +                               = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
> +       unsigned long low = (unsigned long)stacktrace_info->stack_base;
> +       unsigned long high = low + PAGE_SIZE;
> +
> +       return on_stack(sp, size, low, high, STACK_TYPE_HYP, info);
>  }
>
>  static inline int notrace unwind_next(struct unwind_state *state)
>  {
> -       return 0;
> +       struct stack_info info;
> +
> +       return unwind_next_common(state, &info, kvm_nvhe_stack_kern_va);
>  }
>  NOKPROBE_SYMBOL(unwind_next);
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index a0188144a122..6a64293108c5 100644
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
> --
> 2.37.0.170.g444d1eabd0-goog
>
