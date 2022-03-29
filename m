Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169224EA9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiC2IxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiC2IxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:53:07 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1C55BDD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:24 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-de48295467so18023321fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sd/uPbCy+ySZT+qPihwZYiLaTHG+pfVJ3nw0jfPbprI=;
        b=NFpGKRrAos0oJUYWKsapTWH2MnHxaeIss6UYZhqmckncq81qDbcJndUBTT2QOeMvUc
         DKA25vx5N/s80BDkUO9s69+EJc3zpV0rOj/SjkZSFDX+81xs2xmQp/Jh3KcdotLEBp7R
         GRAYR2mCnkSWVa8BKWdApIJYvzwksRaeIA1oqDi7jhIxs3d5m0h3PzQxm9MwieCFR96G
         h/MgyGuW/RhXnhhIVeeUPgJkPYiyRmH6JRXi9NtVu8SqwWoxlD+tf507yJqqKcnPSg1B
         EJ3b8dVmRDWMh8PaW0fWDt4/TizHuKhfia0WhpCwpgw6CtU28lI8Vu7tmQwaQhiaMG3c
         AI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sd/uPbCy+ySZT+qPihwZYiLaTHG+pfVJ3nw0jfPbprI=;
        b=c3qrGbdWiRTLqq+0n6Q98VGI2itKIJcqA4qwp/Hf/c42sN/GTVuefkyaoX5nfRDg1E
         FLf2LCKmL3upZjR1v00O7loL+JInf2B02leV7SwiigCYTjqftAM8bsMxe+F8BubDYG+P
         m5CJ9H2sX9JyTUzjqvdl3Apu3g3F2ffA8l3qvk4UjZALKOwxlWUeo7GJJhISs/k4xZAO
         GpWLEDWumGmmb9uuxPF/Ph2rudDdlGQDpE9esLberl7dVlB5UuTyZJOdbSkeYM0s/3n/
         JIdEyeokKddy+HUHy/hrRA4hWXwjoQjyMV+fjrUGkX641hr+suM00/w2ecl+RsTI8ioK
         jcXw==
X-Gm-Message-State: AOAM530lessDLG8Q35y+5DA48XcIU6roLyG2blhl4avFEhuyp/t6v/oZ
        vLbe7lwOA8PJMrheW9htzXalKWrB5xAso/nyJUS7hQ==
X-Google-Smtp-Source: ABdhPJzvEhD1ChOqnTr7YHf9ZKDvTxDrDGlXzyFwe0eVAAXipoLOC+EstvVHjMcZN1Ky/ep+sjdiKXzamyP2trQdNVQ=
X-Received: by 2002:a05:6870:700f:b0:dd:9f77:9a97 with SMTP id
 u15-20020a056870700f00b000dd9f779a97mr1638894oae.146.1648543883596; Tue, 29
 Mar 2022 01:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com> <20220314200148.2695206-3-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-3-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 29 Mar 2022 09:50:47 +0100
Message-ID: <CA+EHjTysueEjwwNREbtvy2wh89n89wFVpM2xM34kGeTx+e7QFQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] KVM: arm64: Introduce pkvm_alloc_private_va_range()
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

On Mon, Mar 14, 2022 at 8:03 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> pkvm_hyp_alloc_private_va_range() can be used to reserve private VA ranges
> in the pKVM nVHE hypervisor. Allocations are aligned based on the order of
> the requested size.
>
> This will be used to implement stack guard pages for pKVM nVHE hypervisor
> (in a subsequent patch in the series).
>
> Credits to Quentin Perret <qperret@google.com> for the idea of moving
> private VA allocation out of __pkvm_create_private_mapping()
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


> ---
>
> Changes in v6:
>   - Update kernel-doc for pkvm_alloc_private_va_range() and add
>     return description, per Stephen
>   - Update pkvm_alloc_private_va_range() to return an int error code,
>     per Stephen
>   - Update __pkvm_create_private_mapping to return an in error code,
>     per Quentin
>   - Update callers of __pkvm_create_private_mapping() to handle new
>     return value and params.
>
> Changes in v5:
>   - Align private allocations based on the order of their size, per Marc
>
> Changes in v4:
>   - Handle null ptr in pkvm_alloc_private_va_range() and replace
>     IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
>   - Fix kernel-doc comments format, per Fuad
>   - Format __pkvm_create_private_mapping() prototype args (< 80 col), per Fuad
>
> Changes in v3:
>   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
>
> Changes in v2:
>   - Allow specifying an alignment for the private VA allocations, per Marc
>
>
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |  6 ++-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 18 ++++++-
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 78 ++++++++++++++++++----------
>  3 files changed, 72 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index 2d08510c6cc1..42d8eb9bfe72 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -19,8 +19,10 @@ int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
>  int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
>  int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
>  int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
> -unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> -                                           enum kvm_pgtable_prot prot);
> +int __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> +                                 enum kvm_pgtable_prot prot,
> +                                 unsigned long *haddr);
> +int pkvm_alloc_private_va_range(size_t size, unsigned long *haddr);
>
>  static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
>                                      unsigned long *start, unsigned long *end)
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 5e2197db0d32..3cea4b6ac23e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -160,7 +160,23 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
>         DECLARE_REG(size_t, size, host_ctxt, 2);
>         DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
>
> -       cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
> +       /*
> +        * __pkvm_create_private_mapping() populates a pointer with the
> +        * hypervisor start address of the allocation.
> +        *
> +        * However, handle___pkvm_create_private_mapping() hypercall crosses the
> +        * EL1/EL2 boundary so the pointer would not be valid in this context.
> +        *
> +        * Instead pass the allocation address as the return value (or return
> +        * ERR_PTR() on failure).
> +        */
> +       unsigned long haddr;
> +       int err = __pkvm_create_private_mapping(phys, size, prot, &haddr);
> +
> +       if (err)
> +               haddr = (unsigned long)ERR_PTR(err);
> +
> +       cpu_reg(host_ctxt, 1) = haddr;
>  }
>
>  static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index cdbe8e246418..670f11349070 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -37,36 +37,60 @@ static int __pkvm_create_mappings(unsigned long start, unsigned long size,
>         return err;
>  }
>
> -unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> -                                           enum kvm_pgtable_prot prot)
> +/**
> + * pkvm_alloc_private_va_range - Allocates a private VA range.
> + * @size:      The size of the VA range to reserve.
> + * @haddr:     The hypervisor virtual start address of the allocation.
> + *
> + * The private virtual address (VA) range is allocated above __io_map_base
> + * and aligned based on the order of @size.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int pkvm_alloc_private_va_range(size_t size, unsigned long *haddr)
>  {
> -       unsigned long addr;
> -       int err;
> +       unsigned long base, addr;
> +       int ret = 0;
>
>         hyp_spin_lock(&pkvm_pgd_lock);
>
> -       size = PAGE_ALIGN(size + offset_in_page(phys));
> -       addr = __io_map_base;
> -       __io_map_base += size;
> +       /* Align the allocation based on the order of its size */
> +       addr = ALIGN(__io_map_base, PAGE_SIZE << get_order(size));
>
> -       /* Are we overflowing on the vmemmap ? */
> -       if (__io_map_base > __hyp_vmemmap) {
> -               __io_map_base -= size;
> -               addr = (unsigned long)ERR_PTR(-ENOMEM);
> -               goto out;
> -       }
> +       /* The allocated size is always a multiple of PAGE_SIZE */
> +       base = addr + PAGE_ALIGN(size);
>
> -       err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
> -       if (err) {
> -               addr = (unsigned long)ERR_PTR(err);
> -               goto out;
> +       /* Are we overflowing on the vmemmap ? */
> +       if (!addr || base > __hyp_vmemmap)
> +               ret = -ENOMEM;
> +       else {
> +               __io_map_base = base;
> +               *haddr = addr;
>         }
>
> -       addr = addr + offset_in_page(phys);
> -out:
>         hyp_spin_unlock(&pkvm_pgd_lock);
>
> -       return addr;
> +       return ret;
> +}
> +
> +int __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> +                                 enum kvm_pgtable_prot prot,
> +                                 unsigned long *haddr)
> +{
> +       unsigned long addr;
> +       int err;
> +
> +       size += offset_in_page(phys);
> +       err = pkvm_alloc_private_va_range(size, &addr);
> +       if (err)
> +               return err;
> +
> +       err = __pkvm_create_mappings(addr, size, phys, prot);
> +       if (err)
> +               return err;
> +
> +       *haddr = addr + offset_in_page(phys);
> +       return err;
>  }
>
>  int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
> @@ -146,7 +170,8 @@ int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot)
>  int hyp_map_vectors(void)
>  {
>         phys_addr_t phys;
> -       void *bp_base;
> +       unsigned long bp_base;
> +       int ret;
>
>         if (!kvm_system_needs_idmapped_vectors()) {
>                 __hyp_bp_vect_base = __bp_harden_hyp_vecs;
> @@ -154,13 +179,12 @@ int hyp_map_vectors(void)
>         }
>
>         phys = __hyp_pa(__bp_harden_hyp_vecs);
> -       bp_base = (void *)__pkvm_create_private_mapping(phys,
> -                                                       __BP_HARDEN_HYP_VECS_SZ,
> -                                                       PAGE_HYP_EXEC);
> -       if (IS_ERR_OR_NULL(bp_base))
> -               return PTR_ERR(bp_base);
> +       ret = __pkvm_create_private_mapping(phys, __BP_HARDEN_HYP_VECS_SZ,
> +                                           PAGE_HYP_EXEC, &bp_base);
> +       if (ret)
> +               return ret;
>
> -       __hyp_bp_vect_base = bp_base;
> +       __hyp_bp_vect_base = (void *)bp_base;
>
>         return 0;
>  }
> --
> 2.35.1.723.g4982287a31-goog
>
