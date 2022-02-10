Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF64B0FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiBJOKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:10:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiBJOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:09:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE4C1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:10:00 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s185so5985124oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k16MeYOe3tvEW9UdX+HTX9NGIo7L7H8oO9b068swmwc=;
        b=BuMgD+nEItVdQQtwBKjNuTgKIUyyvj1REr90F8mIZ7N3DxOnWby9YkSq8It6vvO/Pt
         nucxsA+00C+M8FDTzzamJK/iYexnj5rhOw/kq6nzPjRp2hPU4bNEM6/CyAxdsn/piMZW
         +RCCL57Se3G35WtnS3FJK0VxinxDe9M+zDDIG4lvEX04dlTtew97pCK+QsuZpmmlJ5YW
         7I7vpqKEq3UlPMuEhkvd7n6Z3SNKeTpYwQkBz4lF/FGXnFir6MBaAaGDNkRpX0n8yB9V
         kW1PLl/uv1xnYjNMzGiZ+u9DyJxKNGmD/2jnnAE9+6REBwyn3KGsYu/nWJJ/62MgzGKD
         xGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k16MeYOe3tvEW9UdX+HTX9NGIo7L7H8oO9b068swmwc=;
        b=2FefjPe7uvGRlVkzTDCHXPDjbrdo3wJBRV1hF5sW3QLp6Y16/h0ix5LJBn0/1gpbPI
         I91pKPob6rxjB1l1gAU529MUK/KrGSPjZDXcUAxH2Ce/DapmsapaPnPljVZJs/HHufSA
         EGN0gEbfC1AdYZhJSCzw7d6vrNBZ14oawsMrM2FSkxsmtYDvD71lOlJnB1Rh8zsPQIk8
         UmubBqnEsOkI4YGexUAXIVJbgZu7FQTBEI6w97ArgWIlgL8+XTjXwbOILbfq6R5g/1sG
         3byqQlSRn+9seej3fikSQVwt70XaZRGKsk8haX/qJc+SO90F/lzKHV8AxS+2ZqyxuKYQ
         FpQQ==
X-Gm-Message-State: AOAM5302xikgUAHlKD3X4zL3F6vfLi5H5bDa0kJO+jpXZRPmL14AR46w
        CP8aN2P3wJQjmRAwCM42HmLfQ3ep2WkxVb9HU4XXWA==
X-Google-Smtp-Source: ABdhPJzyWIEs29hVEejnCCg8oj2jR2hhA7+qWp+ZTy+9kCraF7eYGaQlvfhDfVtN32jAAH0+LPfx9Dca+EI+aQwEXTA=
X-Received: by 2002:a05:6808:1292:: with SMTP id a18mr1034942oiw.314.1644502199441;
 Thu, 10 Feb 2022 06:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20220210102603.42764-1-likexu@tencent.com>
In-Reply-To: <20220210102603.42764-1-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 10 Feb 2022 06:09:48 -0800
Message-ID: <CALMp9eQBzWUk2UBz3EP-YJizEypOnpL0whrmb1ttnFA8TNuspA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Distinguish EVENTSEL bitmasks for uniform
 event creation and filtering
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Feb 10, 2022 at 2:26 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> The current usage of EVENTSEL_* macro is a mess in the KVM context. Partly
> because we have a conceptual ambiguity when choosing to create a RAW or
> HARDWARE event: when bits other than HARDWARE_EVENT_MASK are set,
> the pmc_reprogram_counter() will use the RAW type.
>
> By introducing the new macro AMD64_EXTRA_EVENTSEL_EVENT to simplify,
> the following three issues can be addressed in one go:
>
> - the 12 selection bits are used as comparison keys for allow or deny;
> - NON_HARDWARE_EVENT_MASK is only used to determine if a HARDWARE
>   event is programmed or not, a 12-bit selected event will be a RAW event;
>   (jmattson helped report this issue)
> - by reusing AMD64_RAW_EVENT_MASK, the extra 4 selection bits (if set) are
>   passed to the perf correctly and not filtered out by X86_RAW_EVENT_MASK;.
>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/include/asm/perf_event.h |  3 ++-
>  arch/x86/kvm/pmu.c                | 11 ++++-------
>  arch/x86/kvm/pmu.h                |  6 ++++++
>  3 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 8fc1b5003713..bd068fd19043 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -43,8 +43,9 @@
>  #define AMD64_EVENTSEL_INT_CORE_SEL_MASK               \
>         (0xFULL << AMD64_EVENTSEL_INT_CORE_SEL_SHIFT)
>
> +#define AMD64_EXTRA_EVENTSEL_EVENT                             (0x0FULL << 32)
>  #define AMD64_EVENTSEL_EVENT   \
> -       (ARCH_PERFMON_EVENTSEL_EVENT | (0x0FULL << 32))
> +       (ARCH_PERFMON_EVENTSEL_EVENT | AMD64_EXTRA_EVENTSEL_EVENT)
>  #define INTEL_ARCH_EVENT_MASK  \
>         (ARCH_PERFMON_EVENTSEL_UMASK | ARCH_PERFMON_EVENTSEL_EVENT)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 2c98f3ee8df4..99426a8d7f18 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -198,7 +198,8 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
>
>         filter = srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu);
>         if (filter) {
> -               __u64 key = eventsel & AMD64_RAW_EVENT_MASK_NB;
> +               __u64 key = eventsel & (INTEL_ARCH_EVENT_MASK |
> +                                       AMD64_EXTRA_EVENTSEL_EVENT);
>
>                 if (bsearch(&key, filter->events, filter->nevents,
>                             sizeof(__u64), cmp_u64))
> @@ -209,18 +210,14 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
>         if (!allow_event)
>                 return;
>
> -       if (!(eventsel & (ARCH_PERFMON_EVENTSEL_EDGE |
> -                         ARCH_PERFMON_EVENTSEL_INV |
> -                         ARCH_PERFMON_EVENTSEL_CMASK |
> -                         HSW_IN_TX |
> -                         HSW_IN_TX_CHECKPOINTED))) {
> +       if (!(eventsel & NON_HARDWARE_EVENT_MASK)) {

I still don't understand why we even bother doing this lookup in the
first place. What's wrong with simply requesting PERF_TYPE_RAW every
time?

>                 config = kvm_x86_ops.pmu_ops->pmc_perf_hw_id(pmc);
>                 if (config != PERF_COUNT_HW_MAX)
>                         type = PERF_TYPE_HARDWARE;
>         }
>
>         if (type == PERF_TYPE_RAW)
> -               config = eventsel & X86_RAW_EVENT_MASK;
> +               config = eventsel & AMD64_RAW_EVENT_MASK;

This chunk looks a lot like
https://lore.kernel.org/kvm/20220203014813.2130559-2-jmattson@google.com/.
Note that if you don't increase the width of config (as in the first
change of that series), this mask change is ineffective.

>         if (pmc->current_config == eventsel && pmc_resume_counter(pmc))
>                 return;
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 7a7b8d5b775e..48d867e250bc 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -17,6 +17,12 @@
>
>  #define MAX_FIXED_COUNTERS     3
>
> +#define KVM_ARCH_PERFMON_EVENTSEL_IGNORE \
> +       (ARCH_PERFMON_EVENTSEL_ANY | ARCH_PERFMON_EVENTSEL_PIN_CONTROL)
> +
> +#define NON_HARDWARE_EVENT_MASK        (AMD64_EXTRA_EVENTSEL_EVENT | \
> +        (X86_ALL_EVENT_FLAGS & ~KVM_ARCH_PERFMON_EVENTSEL_IGNORE))
> +
>  struct kvm_event_hw_type_mapping {
>         u8 eventsel;
>         u8 unit_mask;
> --
> 2.35.0
>
