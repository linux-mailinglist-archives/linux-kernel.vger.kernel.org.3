Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2294D2271
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350171AbiCHUWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbiCHUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:22:39 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0853B6D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:21:41 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so437972ooi.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=BVV59R1x/3zhBVnVWK6j4y0iat0LkIDDXlTtlhGa9CY=;
        b=lczPPxNy5R21bIe/J5VnIJ82n/HdZ51itN67PDK3dFFcZNEcl/9RrkIuEYhsC36C3g
         qQk2NsFOqKIGWMY1eCMWE6sJZpxOWyJCWCvi/k7rbaHNsf9EE9MzW4opqLPCCDtyexdd
         fwr+NlWKn7wteWokK2Sh7UnE4ODwU+UJmsiNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=BVV59R1x/3zhBVnVWK6j4y0iat0LkIDDXlTtlhGa9CY=;
        b=WnpjDq4JVSnkixgsjWHkiXmABEjlN8imEf9Mf8LFNbCl/uZ5djBDWoREf+VbKPcJXj
         fldK3VjECSIMxrhW+Zab/Ro8+acKuVv6PTjzhWUtoH98dLnuqiL4U0rVbJV131gnHKWJ
         /vVqWY6B1BCzmSq6302H88h0YTXgjORqqnZ4BZlCO6jfNy8guNxg06PmOansxtl+Injn
         gl864Y+s2ay8k+QAVj5aoce7zl4hQ2MSvLMv02T9lzknotDWJUn8C6dld9uRv+sPSAis
         5rfxijACyYgiPbXxWw6g/VIdzKhRq/wswV014DIjO4fUKwkCO4fyKAu8nEgjTlJ9WC4m
         tHPQ==
X-Gm-Message-State: AOAM530jpxPHnOyu2K7i0AEtKYleseZZu2dqefTHpyikUhpn7AXpb0hE
        jfhOlg6suyCdRDdnVqwf+PAoWPZNT0vZRqXr3vCZwQ==
X-Google-Smtp-Source: ABdhPJxYmuzkDSk5/9wnEE3vKsXmU2qpGFnLanLvP0kVx44q4gaJgGHUxdsVe+bSUC49eFC3IKpOiY0Mkly8Ik45/Ss=
X-Received: by 2002:a05:6870:d250:b0:da:b3f:3211 with SMTP id
 h16-20020a056870d25000b000da0b3f3211mr3461463oac.193.1646770901112; Tue, 08
 Mar 2022 12:21:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Mar 2022 12:21:40 -0800
MIME-Version: 1.0
In-Reply-To: <20220307184935.1704614-2-kaleshsingh@google.com>
References: <20220307184935.1704614-1-kaleshsingh@google.com> <20220307184935.1704614-2-kaleshsingh@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 8 Mar 2022 12:21:40 -0800
Message-ID: <CAE-0n52LmVRkrSNN=eJf+TYYnmesVjFv99nnetYvRWshm82rOg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
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
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kalesh Singh (2022-03-07 10:48:59)
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index bc2aba953299..ccb2847ee2f4 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -457,22 +457,17 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>         return 0;
>  }
>
> -static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> -                                       unsigned long *haddr,
> -                                       enum kvm_pgtable_prot prot)
> +
> +/**
> + * hyp_alloc_private_va_range - Allocates a private VA range.
> + * @size:      The size of the VA range to reserve.
> + *
> + * The private VA range is allocated below io_map_base and
> + * aligned based on the order of @size.

Add what it returns?

Return: Start address of allocated VA range or some error value... (I don't
understand this part).

It may also be a good idea to write out what VA is in the description:

The private virtual address (VA) range is allocated below io_map_base

> + */
> +unsigned long hyp_alloc_private_va_range(size_t size)
>  {
>         unsigned long base;
> -       int ret = 0;
> -
> -       if (!kvm_host_owns_hyp_mappings()) {
> -               base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> -                                        phys_addr, size, prot);
> -               if (IS_ERR_OR_NULL((void *)base))
> -                       return PTR_ERR((void *)base);
> -               *haddr = base;
> -
> -               return 0;
> -       }
>
>         mutex_lock(&kvm_hyp_pgd_mutex);
>
> @@ -484,29 +479,53 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
>          *
>          * The allocated size is always a multiple of PAGE_SIZE.
>          */
> -       size = PAGE_ALIGN(size + offset_in_page(phys_addr));
> -       base = io_map_base - size;
> +       base = io_map_base - PAGE_ALIGN(size);
> +
> +       /* Align the allocation based on the order of its size */
> +       base = ALIGN_DOWN(base, PAGE_SIZE << get_order(size));
>
>         /*
>          * Verify that BIT(VA_BITS - 1) hasn't been flipped by
>          * allocating the new area, as it would indicate we've
>          * overflowed the idmap/IO address range.
>          */
> -       if ((base ^ io_map_base) & BIT(VA_BITS - 1))
> -               ret = -ENOMEM;
> +       if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
> +               base = (unsigned long)ERR_PTR(-ENOMEM);

It looks odd to use an error pointer casted to unsigned long to return
from an address allocation function. Why not pass a pointer for base
like the function was written before and return an int from this
function with 0 for success and negative error value? Otherwise some
sort of define should made like DMA_MAPPING_ERROR and that can be used
to indicate to the caller that the allocation failed, or a simple zero
may work?

>         else
>                 io_map_base = base;
>
>         mutex_unlock(&kvm_hyp_pgd_mutex);
>
> -       if (ret)
> -               goto out;
> +       return base;
> +}
> +
> +static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> +                                       unsigned long *haddr,
> +                                       enum kvm_pgtable_prot prot)
> +{
> +       unsigned long addr;
> +       int ret = 0;
> +
> +       if (!kvm_host_owns_hyp_mappings()) {
> +               addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> +                                        phys_addr, size, prot);
> +               if (IS_ERR((void *)addr))

IS_ERR_VALUE()?

> +                       return PTR_ERR((void *)addr);
> +               *haddr = addr;
> +
> +               return 0;
> +       }
> +
> +       size += offset_in_page(phys_addr);
> +       addr = hyp_alloc_private_va_range(size);
> +       if (IS_ERR((void *)addr))

IS_ERR_VALUE()?

> +               return PTR_ERR((void *)addr);
>
> -       ret = __create_hyp_mappings(base, size, phys_addr, prot);
> +       ret = __create_hyp_mappings(addr, size, phys_addr, prot);
>         if (ret)
>                 goto out;
>
> -       *haddr = base + offset_in_page(phys_addr);
> +       *haddr = addr + offset_in_page(phys_addr);
>  out:
>         return ret;

Would be simpler to remove the goto, or return early.

	if (!ret)
		*haddr = addr + offset_in_page(phys_addr);

	return ret;

>  }
