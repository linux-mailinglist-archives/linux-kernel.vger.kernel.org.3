Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01534EA9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiC2IxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiC2Iw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:52:57 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86225419F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:14 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-de3eda6b5dso18046713fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/eRk2ImRzThvCuDLwHzf4xR9PAnPCdQO7PLIDrEyk0=;
        b=nnyN0eihHxUrf+TwB7MLpcpSf2tlQiGtoqCXDg7me/90+B5CbLAw5kc3Bi+PsvIN08
         G/8PYgbLWcDtMgLWGyssOW3y5RdhVrfh4XcLmCEEtCPfd18v+MUQRD5U8f3uChLsoBTU
         0xzbkVUbS8C+VVZk3Ug5I7bK/oK7wYc1FbF0vlj4egoDQdFVPOrIymd7LKW6fye9Rm+r
         ucXN1UdGW7STFAWgSHaE9lZ0OH0Un4+/C+b1NrE/lDou7KCXORuAhRPGPlQEv1hCgMia
         E4YNeclPGTx8FxuxSLv2kOdtOiNPxd/YwlTD6QgLVtPoNvf+1rR2rNKgToxFg624S4Lh
         3Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/eRk2ImRzThvCuDLwHzf4xR9PAnPCdQO7PLIDrEyk0=;
        b=xrYzhX0aFyrDBHa6ILe3WZVLwEYkZd6KGVuGVt2oRTzV7PZtXsBAp0/ahAAqrINjjM
         dvlxgXIA3gsaoAi3BWruZlKVqxfhOto+lYti6hGa28m9YDETw7vD4/97M4ZZS4kiFGlw
         fllqpqERPPkXENury5ZcCkoopCUNwgTDvNz4LE7DlpcOyED0lLGdiotkbhwwq2vUcccH
         7f04Kooi3WUeFH7z4xsSm9RkDTGUENkNKmoyTobLSXJcWdhm16DwGTAkRF1yG+aUkmCz
         vvzO4WhyHkEbfV4I4WfuBVj4gQxhKYiyYmGXSwFjWZzfgXvdcJt1LnFYO27US+LDzXYl
         OGGg==
X-Gm-Message-State: AOAM532dVFO53/Noy8GTmh/yKq9TnFRWlYj8qAFUp4hk4Va/RwBy9/Il
        VcZjUIpH6hjMdaWpHPZEIdth9aBDlH/Nvx/MxXVrzw==
X-Google-Smtp-Source: ABdhPJwBs4l3xPrJ86QqdOmfqcuVD/NvIViycAprqNRRQDkwaU6W1i5RBinZQBRbLLzO2uklz/Epgwa7l41lkeLUKZ4=
X-Received: by 2002:a05:6870:8196:b0:dd:e471:8bb5 with SMTP id
 k22-20020a056870819600b000dde4718bb5mr814608oae.294.1648543874076; Tue, 29
 Mar 2022 01:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com> <20220314200148.2695206-2-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-2-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 29 Mar 2022 09:50:38 +0100
Message-ID: <CA+EHjTxx7RoLods=9xz4RZF3FSFZdH+7kwcHCurpUqAD+mtgzA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
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
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Scull <ascull@google.com>,
        Andrew Jones <drjones@redhat.com>,
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


On Mon, Mar 14, 2022 at 8:02 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> hyp_alloc_private_va_range() can be used to reserve private VA ranges
> in the nVHE hypervisor. Allocations are aligned based on the order of
> the requested size.
>
> This will be used to implement stack guard pages for KVM nVHE hypervisor
> (nVHE Hyp mode / not pKVM), in a subsequent patch in the series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

This looks good to me. I have also tested this entire series, and your
enhancements will make debugging easier.

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad



> ---
>
> Changes in v6:
>   - Update kernel-doc for hyp_alloc_private_va_range()
>     and add return description, per Stephen
>   - Update hyp_alloc_private_va_range() to return an int error code,
>     per Stephen
>   - Replace IS_ERR() checks with IS_ERR_VALUE() check, per Stephen
>   - Clean up goto, per Stephen
>
> Changes in v5:
>   - Align private allocations based on the order of their size, per Marc
>
> Changes in v4:
>   - Handle null ptr in hyp_alloc_private_va_range() and replace
>     IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
>   - Fix kernel-doc comments format, per Fuad
>
> Changes in v3:
>   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
>
>
>  arch/arm64/include/asm/kvm_mmu.h |  1 +
>  arch/arm64/kvm/mmu.c             | 66 +++++++++++++++++++++-----------
>  2 files changed, 45 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 81839e9a8a24..3cc9aa25f510 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -153,6 +153,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
>  int kvm_share_hyp(void *from, void *to);
>  void kvm_unshare_hyp(void *from, void *to);
>  int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> +int hyp_alloc_private_va_range(size_t size, unsigned long *haddr);
>  int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
>                            void __iomem **kaddr,
>                            void __iomem **haddr);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index bc2aba953299..7326d683c500 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -457,23 +457,22 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
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
> + * @haddr:     The hypervisor virtual start address of the allocation.
> + *
> + * The private virtual address (VA) range is allocated below io_map_base
> + * and aligned based on the order of @size.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int hyp_alloc_private_va_range(size_t size, unsigned long *haddr)
>  {
>         unsigned long base;
>         int ret = 0;
>
> -       if (!kvm_host_owns_hyp_mappings()) {
> -               base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> -                                        phys_addr, size, prot);
> -               if (IS_ERR_OR_NULL((void *)base))
> -                       return PTR_ERR((void *)base);
> -               *haddr = base;
> -
> -               return 0;
> -       }
> -
>         mutex_lock(&kvm_hyp_pgd_mutex);
>
>         /*
> @@ -484,30 +483,53 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
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
> +       if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
>                 ret = -ENOMEM;
>         else
> -               io_map_base = base;
> +               *haddr = io_map_base = base;
>
>         mutex_unlock(&kvm_hyp_pgd_mutex);
>
> +       return ret;
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
> +               if (IS_ERR_VALUE(addr))
> +                       return addr;
> +               *haddr = addr;
> +
> +               return 0;
> +       }
> +
> +       size += offset_in_page(phys_addr);
> +       ret = hyp_alloc_private_va_range(size, &addr);
>         if (ret)
> -               goto out;
> +               return ret;
>
> -       ret = __create_hyp_mappings(base, size, phys_addr, prot);
> +       ret = __create_hyp_mappings(addr, size, phys_addr, prot);
>         if (ret)
> -               goto out;
> +               return ret;
>
> -       *haddr = base + offset_in_page(phys_addr);
> -out:
> +       *haddr = addr + offset_in_page(phys_addr);
>         return ret;
>  }
>
> --
> 2.35.1.723.g4982287a31-goog
>
