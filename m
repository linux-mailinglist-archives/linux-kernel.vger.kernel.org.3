Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48614C2BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiBXM1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiBXM1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:27:21 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E05BD26
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:26:51 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id j24so2224986oii.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYTU/xUKnqUv9iv9u+6g24yzpR+pFvcXOd7BnbJwM7w=;
        b=JR1017e8qWfgaETBmi93Id8ZpoF/iFAwjXtyZL81dMEwoRABQDNCRDEwYJyOYNHJA7
         3JT4S8HMKzT5aFATiKFCdFdBs0gNgZ3cKYkVoATCsqDNJZkVdpGStrMZ4EIdLurcWQcT
         axPXDvwkZwCsExi02fUqzjQahgCz2tcXQlclkRQfGlUuX5CfbQ3pp0VoYRMl8dvwB5yo
         wzS/qZZNloI2WvCFDVltZEkpsitX/EWbewf6DJQXtD+tNxQFb/fb+BXJ3UzO9knbkCWf
         yOkKJZWXoXPDMAcT7Q7vNS3Wp/XjhTz/cgm42/7uad1Pk4RNPkWC6+5wNQTOVXNmWQdt
         rKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYTU/xUKnqUv9iv9u+6g24yzpR+pFvcXOd7BnbJwM7w=;
        b=RH207x04mknf4+qz7XnWVzJQiJ8N/C84y+l+8/fyAPKzb5j6MJA4AoYMJgpJH9TDmr
         iGoUgzWOJzB8FdUWR8L+/xDBFxH+00GuLuFS6hO0KKKdxhBVjefnqZNsKFe/V7JyzXD1
         xN98PbqLws/vKuiXs0Rnez8trk61QIdImEd4v+gWQfc6fMLFxT4QFGAOmRkmLLa+dPjK
         h6YonIrr0loHWBKRdBFdbicT1b1Q3wgRPmC5scZ0Y2SzrQ7Y+yLvGkSqig92Cy2A7wuM
         8m1wG5EKAoUa/y5qE68jRuM/7XgPSwdgNzwuolrUyfxxpf/AxJEcKuocdPOUz1yELzKu
         L8iw==
X-Gm-Message-State: AOAM531H8B7XCe3iFB3eGI07nuspL1iYEi8L5R6AvT8FrUyJ4+ZQjl0i
        a3QlzjBe6p5VzNCGI/wggOd8g3g2u89lWaYwT6cN3g==
X-Google-Smtp-Source: ABdhPJzmSzfVqT9jRRqKWQ7Vbi8o4Aj8CdhVv14Hh6K4GF7CeVmxqmI6yIP2jfyFBJ29+WT16YhgLURlwHMt4sHdxhs=
X-Received: by 2002:a54:4e86:0:b0:2cf:c254:f77c with SMTP id
 c6-20020a544e86000000b002cfc254f77cmr1069155oiy.171.1645705610293; Thu, 24
 Feb 2022 04:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com> <20220224051439.640768-4-kaleshsingh@google.com>
In-Reply-To: <20220224051439.640768-4-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 24 Feb 2022 12:26:14 +0000
Message-ID: <CA+EHjTy6DJt8Pcfj4JnVhSG0sQ7O09zvOaMP--aRuAsM=8zKUw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] KVM: arm64: Add guard pages for KVM nVHE
 hypervisor stack
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
        Paolo Bonzini <pbonzini@redhat.com>,
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



On Thu, Feb 24, 2022 at 5:18 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Maps the stack pages in the flexible private VA range and allocates
> guard pages below the stack as unbacked VA space. The stack is aligned
> to twice its size to aid overflow detection (implemented in a subsequent
> patch in the series).
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>
> Changes in v3:
>   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
>
>  arch/arm64/include/asm/kvm_asm.h |  1 +
>  arch/arm64/kvm/arm.c             | 32 +++++++++++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index d5b0386ef765..2e277f2ed671 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -169,6 +169,7 @@ struct kvm_nvhe_init_params {
>         unsigned long tcr_el2;
>         unsigned long tpidr_el2;
>         unsigned long stack_hyp_va;
> +       unsigned long stack_pa;
>         phys_addr_t pgd_pa;
>         unsigned long hcr_el2;
>         unsigned long vttbr;
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index ecc5958e27fe..7a23630c4a7f 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1541,7 +1541,6 @@ static void cpu_prepare_hyp_mode(int cpu)
>         tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
>         params->tcr_el2 = tcr;
>
> -       params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
>         params->pgd_pa = kvm_mmu_get_httbr();
>         if (is_protected_kvm_enabled())
>                 params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
> @@ -1990,14 +1989,41 @@ static int init_hyp_mode(void)
>          * Map the Hyp stack pages
>          */
>         for_each_possible_cpu(cpu) {
> +               struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
>                 char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
> -               err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
> -                                         PAGE_HYP);
> +               unsigned long stack_hyp_va, guard_hyp_va;
>
> +               /*
> +                * Private mappings are allocated downwards from io_map_base
> +                * so allocate the stack first then the guard page.
> +                *
> +                * The stack is aligned to twice its size to facilitate overflow
> +                * detection.
> +                */
> +               err = __create_hyp_private_mapping(__pa(stack_page), PAGE_SIZE,
> +                                               PAGE_SIZE * 2, &stack_hyp_va, PAGE_HYP);
>                 if (err) {
>                         kvm_err("Cannot map hyp stack\n");
>                         goto out_err;
>                 }
> +
> +               /* Allocate unbacked private VA range for stack guard page */
> +               guard_hyp_va = hyp_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
> +               if (IS_ERR_OR_NULL((void *)guard_hyp_va)) {
> +                       err = guard_hyp_va ? PTR_ERR((void *)guard_hyp_va) : -ENOMEM;

I am a bit confused by this check. hyp_alloc_private_va_range() always
returns ERR_PTR(-ENOMEM) if there's an error. Mark's comment (if I
understood it correctly) was about how you were handling it *in*
hyp_alloc_private_va_range(), rather than calls *to*
hyp_alloc_private_va_range().

> +                       kvm_err("Cannot allocate hyp stack guard page\n");
> +                       goto out_err;
> +               }
> +
> +               /*
> +                * Save the stack PA in nvhe_init_params. This will be needed to recreate
> +                * the stack mapping in protected nVHE mode. __hyp_pa() won't do the right
> +                * thing there, since the stack has been mapped in the flexible private
> +                * VA space.
> +                */

Nit: These comments go over 80 columns, unlike other comments that
you've added in this file.

Thanks,
/fuad

> +               params->stack_pa = __pa(stack_page) + PAGE_SIZE;
> +
> +               params->stack_hyp_va = stack_hyp_va + PAGE_SIZE;
>         }
>
>         for_each_possible_cpu(cpu) {
> --
> 2.35.1.473.g83b2b277ed-goog
>
