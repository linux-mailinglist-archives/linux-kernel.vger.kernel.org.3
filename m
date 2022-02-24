Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81B4C2BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiBXM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiBXM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:26:34 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B516043E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:26:04 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so3175977ooi.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lc3HFTZarq6daWw31OcV65xl4GPbmuct7sRQj1Wv4Lw=;
        b=R20WLZoEWQOvYkbyXO43WYHBqtCJkK3v8VrQUpbRybIiP8ylmNjUYepaYGcfv7YBd1
         PTLkHMOqPfDY/nEZvrxYWS3vd4jmzFUSVtGOZ/2Yw3Ro+PdKuTogJkquBXqftjyoIrXl
         esFGiX2qXzP+yup03ToozzoZ67tvdjQsmE2Xy9Hf99mU+pNZ8SqVnEwzxnSxq1xefHLr
         JitctAydr0tSzP6aaGY6yp1sdwjDO2GuoXjsal3ihPdkR7S6Zk48vHBg6hZih2GRdORf
         pSUY5ShUhy6c+76J8aN1UPpRp6p4CsML/vfq5lFNTlZjV1oo1pxB1YvRHWd6E2Ie7aZZ
         BatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lc3HFTZarq6daWw31OcV65xl4GPbmuct7sRQj1Wv4Lw=;
        b=EMekDrFkHxBrZ+CbVcSqJSpLAl5KTaluyBT7/VfLcqNo2Ln4pD2Reqq8+3DbIDkHuV
         TsiBZGdBYZhN/zr+MrEK/EAHwOi9UJgTocOoxRyBOzhQQ9an6/0caCyh2c3oFPCyWOrf
         5wDCu947wlIliNQrFlukSLsVZe1tEUhSpDeFVsxLW4YJ0DW6lknZTmKNABgi4wIo1iX6
         UsUZjVvJ75OYL6cqRTbyGBbWfAQkjTJgGWYX0YOEUuZQEC7PIUpAAWIkuAw7LCpgawKf
         WzrnHyLieIBuNOhcAnc6ZCKkof0Nxlza0wVYscbmBZWpNBN+HRFHvrAX/NFNsO6KYoHq
         1oqg==
X-Gm-Message-State: AOAM531rfM9njzdC+0g6G6oTEi5qP6WXqANTEa5HURaIloTEoqnsNEaZ
        YAJcM2Q/LiusLtkcXyAKjM2i3OTslbp9xMXtgpVJOg==
X-Google-Smtp-Source: ABdhPJz1ZeY5u7AfHlEfSbknVC1YsRIIRcbuOkSjp7aZEzR2gkqnpZdJXX/5SLllAasu0z17OiVXhtUCt0lEjOKPePo=
X-Received: by 2002:a4a:9749:0:b0:2da:d983:8641 with SMTP id
 v9-20020a4a9749000000b002dad9838641mr732109ooi.0.1645705563509; Thu, 24 Feb
 2022 04:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com> <20220224051439.640768-3-kaleshsingh@google.com>
In-Reply-To: <20220224051439.640768-3-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 24 Feb 2022 12:25:27 +0000
Message-ID: <CA+EHjTw=6AUCWtpNFBtw+AxRskF3cg6284rGdes9W9S8Be_xww@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] KVM: arm64: Introduce pkvm_alloc_private_va_range()
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

I really like how this makes the code cleaner in general. A couple of
small nits below.

On Thu, Feb 24, 2022 at 5:17 AM 'Kalesh Singh' via kernel-team
<kernel-team@android.com> wrote:
>
> pkvm_hyp_alloc_private_va_range() can be used to reserve private VA ranges
> in the pKVM nVHE hypervisor (). Also update __pkvm_create_private_mapping()
> to allow specifying an alignment for the private VA mapping.
>
> These will be used to implement stack guard pages for pKVM nVHE hypervisor
> (in a subsequent patch in the series).
>
> Credits to Quentin Perret <qperret@google.com> for the idea of moving
> private VA allocation out of __pkvm_create_private_mapping()
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>
> Changes in v3:
>   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
>
> Changes in v2:
>   - Allow specifying an alignment for the private VA allocations, per Marc
>
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |  3 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  5 +--
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 51 ++++++++++++++++++----------
>  arch/arm64/kvm/mmu.c                 |  2 +-
>  4 files changed, 40 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index 2d08510c6cc1..05d06ad00347 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -20,7 +20,8 @@ int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
>  int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
>  int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
>  unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> -                                           enum kvm_pgtable_prot prot);
> +                                       size_t align, enum kvm_pgtable_prot prot);

Minor nit: the alignment of this does not match how it was before,
i.e., it's not in line with the other function parameters. Yet it
still goes over 80 characters.

> +unsigned long pkvm_alloc_private_va_range(size_t size, size_t align);
>
>  static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
>                                      unsigned long *start, unsigned long *end)
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 5e2197db0d32..96b2312a0f1d 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -158,9 +158,10 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
>  {
>         DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
>         DECLARE_REG(size_t, size, host_ctxt, 2);
> -       DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
> +       DECLARE_REG(size_t, align, host_ctxt, 3);
> +       DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 4);
>
> -       cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
> +       cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, align, prot);
>  }
>
>  static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index 526a7d6fa86f..f35468ec639d 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -37,26 +37,46 @@ static int __pkvm_create_mappings(unsigned long start, unsigned long size,
>         return err;
>  }
>
> -unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> -                                           enum kvm_pgtable_prot prot)
> +/*
> + * Allocates a private VA range above __io_map_base.
> + *
> + * @size:      The size of the VA range to reserve.
> + * @align:     The required alignment for the allocation.
> + */
> +unsigned long pkvm_alloc_private_va_range(size_t size, size_t align)
>  {
> -       unsigned long addr;
> -       int err;
> +       unsigned long base, addr;
>
>         hyp_spin_lock(&pkvm_pgd_lock);
>
> -       size = PAGE_ALIGN(size + offset_in_page(phys));
> -       addr = __io_map_base;
> -       __io_map_base += size;
> +       addr = ALIGN(__io_map_base, align);
> +
> +       /* The allocated size is always a multiple of PAGE_SIZE */
> +       base = addr + PAGE_ALIGN(size);
>
>         /* Are we overflowing on the vmemmap ? */
> -       if (__io_map_base > __hyp_vmemmap) {
> -               __io_map_base -= size;
> +       if (base > __hyp_vmemmap)
>                 addr = (unsigned long)ERR_PTR(-ENOMEM);
> +       else
> +               __io_map_base = base;
> +
> +       hyp_spin_unlock(&pkvm_pgd_lock);
> +
> +       return addr;
> +}
> +
> +unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> +                                       size_t align, enum kvm_pgtable_prot prot)
> +{
> +       unsigned long addr;
> +       int err;
> +
> +       size += offset_in_page(phys);

Same as in the patch before, the previous code would align the size
but not this change. However, looking at the callers and callees this
seems to be fine, since it's aligned when needed.

Thanks,
/fuad

> +       addr = pkvm_alloc_private_va_range(size, align);
> +       if (IS_ERR((void *)addr))
>                 goto out;
> -       }
>
> -       err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
> +       err = __pkvm_create_mappings(addr, size, phys, prot);
>         if (err) {
>                 addr = (unsigned long)ERR_PTR(err);
>                 goto out;
> @@ -64,8 +84,6 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
>
>         addr = addr + offset_in_page(phys);
>  out:
> -       hyp_spin_unlock(&pkvm_pgd_lock);
> -
>         return addr;
>  }
>
> @@ -152,11 +170,10 @@ int hyp_map_vectors(void)
>                 return 0;
>
>         phys = __hyp_pa(__bp_harden_hyp_vecs);
> -       bp_base = (void *)__pkvm_create_private_mapping(phys,
> -                                                       __BP_HARDEN_HYP_VECS_SZ,
> -                                                       PAGE_HYP_EXEC);
> +       bp_base = (void *)__pkvm_create_private_mapping(phys, __BP_HARDEN_HYP_VECS_SZ,
> +                                                       PAGE_SIZE, PAGE_HYP_EXEC);
>         if (IS_ERR_OR_NULL(bp_base))
> -               return PTR_ERR(bp_base);
> +               return bp_base ? PTR_ERR(bp_base) : -ENOMEM;
>
>         __hyp_bp_vect_base = bp_base;
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index fc09536c8197..298e6d8439ef 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -505,7 +505,7 @@ int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
>
>         if (!kvm_host_owns_hyp_mappings()) {
>                 addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> -                                        phys_addr, size, prot);
> +                                        phys_addr, size, align, prot);
>                 if (IS_ERR_OR_NULL((void *)addr))
>                         return addr ? PTR_ERR((void *)addr) : -ENOMEM;
>                 *haddr = addr;
> --
> 2.35.1.473.g83b2b277ed-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
