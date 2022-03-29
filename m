Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465C04EA9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiC2Ixf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiC2IxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:53:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637225A150
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z8so18360638oix.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1GTiO9dDgDxH/Vxt+2jG30+YBZIQXOPWArpR//sGFg=;
        b=UU8GyDTn5GPBTdghAF0xBMdcUitGZMvsVCNx4xVZYQW2TYDNWESNGbX0OcTWGLC67L
         9oEEvdnUPa9/eIrYM7RcTVvpEslVFA0X2bBB1yAlwLCiiv1j0pXF3NmH4Mpd55ORr/Ip
         It1inxQWbxrk0zt/HQS3JLef5fevrCHNjAplRQ/xFUTy0r4ImCtSX4V7QlDIxpDNsUaC
         raUG8jpy0JEFKvM6Z1THdhKbF6x2DRV2YzRFB/8j1Hqcq9mNMs5mv+nbg71f5DQsdcfL
         p2Al5iZlr1Uc+a+BtRuCB85OsVP/qpt1gbZv6tQLA949hOQBoZLREAZwH2Tw2x7cWF8D
         t5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1GTiO9dDgDxH/Vxt+2jG30+YBZIQXOPWArpR//sGFg=;
        b=qZjb/yvvibSyIQRA1xHYy/z/Kal6RtVlnHqpZekSSOwg6zJuY1J4adlOpA+ngnRsBj
         3GpQYJ7B5VkvobiqcaW++ZIiE0AvpDrlbf4WhXeCifff7f6YarhwC2iJNh56nviXvGCF
         63W2lhl2a+ALbRhkXwJNq1OZCq2FH5P2ta3vzSemozPlzkPaGrxACdWIdlL/KO25hcQv
         gOuFEcGVUWHzNo8iAHuLWQdkUxUjXe4QQD9iNOXl8gJWwG7EX6wyH+W645Y7E3azD3HP
         9QA9+ycOn5heBU9hpsJJyaqq/hM3ASb7pJYCJUgfFaXBUsjlWEEpwj+cULrCAwNWvkhw
         8YmQ==
X-Gm-Message-State: AOAM5327KpAtAEaCpuh4dWIJV8Nhm4AcQfXboUUj+Rpl5JlBAfMpFSv4
        2rsgNHaSi/ibRpWON3GdAchYbhEWjPyQIljy249ylw==
X-Google-Smtp-Source: ABdhPJz5vWH82Ul42JP7uuNEch+48rDza1ecNr8WyHT3CMBc2xib8vnK56UC2yUcipNLDMPf+BhhDUs45wMEDC4Q03c=
X-Received: by 2002:aca:180b:0:b0:2f7:23ae:8cd1 with SMTP id
 h11-20020aca180b000000b002f723ae8cd1mr1591903oih.146.1648543896531; Tue, 29
 Mar 2022 01:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com> <20220314200148.2695206-5-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-5-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 29 Mar 2022 09:51:00 +0100
Message-ID: <CA+EHjTys1a788HiLnBYu5yySOQ4BKPFxccXhO8P4dLnUCgBUQA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] KVM: arm64: Add guard pages for pKVM (protected
 nVHE) hypervisor stack
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

On Mon, Mar 14, 2022 at 8:04 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Map the stack pages in the flexible private VA range and allocate
> guard pages below the stack as unbacked VA space. The stack is aligned
> so that any valid stack address has PAGE_SHIFT bit as 1 - this is used
> for overflow detection (implemented in a subsequent patch in the series)
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
>
> Changes in v6:
>   - Update call to pkvm_alloc_private_va_range() (return val and params)
>
> Changes in v5:
>   - Use a single allocation for stack and guard pages to ensure they
>     are contiguous, per Marc
>
> Changes in v4:
>   - Replace IS_ERR_OR_NULL check with IS_ERR check now that
>     pkvm_alloc_private_va_range() returns an error for null
>     pointer, per Fuad
>
> Changes in v3:
>   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
>
>
>  arch/arm64/kvm/hyp/nvhe/setup.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index 27af337f9fea..e8d4ea2fcfa0 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -99,17 +99,42 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
>                 return ret;
>
>         for (i = 0; i < hyp_nr_cpus; i++) {
> +               struct kvm_nvhe_init_params *params = per_cpu_ptr(&kvm_init_params, i);
> +               unsigned long hyp_addr;
> +
>                 start = (void *)kern_hyp_va(per_cpu_base[i]);
>                 end = start + PAGE_ALIGN(hyp_percpu_size);
>                 ret = pkvm_create_mappings(start, end, PAGE_HYP);
>                 if (ret)
>                         return ret;
>
> -               end = (void *)per_cpu_ptr(&kvm_init_params, i)->stack_hyp_va;
> -               start = end - PAGE_SIZE;
> -               ret = pkvm_create_mappings(start, end, PAGE_HYP);
> +               /*
> +                * Allocate a contiguous HYP private VA range for the stack
> +                * and guard page. The allocation is also aligned based on
> +                * the order of its size.
> +                */
> +               ret = pkvm_alloc_private_va_range(PAGE_SIZE * 2, &hyp_addr);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * Since the stack grows downwards, map the stack to the page
> +                * at the higher address and leave the lower guard page
> +                * unbacked.
> +                *
> +                * Any valid stack address now has the PAGE_SHIFT bit as 1
> +                * and addresses corresponding to the guard page have the
> +                * PAGE_SHIFT bit as 0 - this is used for overflow detection.
> +                */
> +               hyp_spin_lock(&pkvm_pgd_lock);
> +               ret = kvm_pgtable_hyp_map(&pkvm_pgtable, hyp_addr + PAGE_SIZE,
> +                                       PAGE_SIZE, params->stack_pa, PAGE_HYP);
> +               hyp_spin_unlock(&pkvm_pgd_lock);
>                 if (ret)
>                         return ret;
> +
> +               /* Update stack_hyp_va to end of the stack's private VA range */
> +               params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
>         }
>
>         /*
> --
> 2.35.1.723.g4982287a31-goog
>
