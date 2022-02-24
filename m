Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401E24C3375
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiBXRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiBXRVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:21:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427F186202
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:20:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so227485wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utvkfVXnWSLnKdSa+6GF8/PEjrYoBqu8Fn7jPDqt4C8=;
        b=szYIf+QYV3bkFqska1K1C7UKOpPo41TzN2e6+y2rvl1hoZ9nWrJLNybL6rXfgMa+Oy
         jYdPkUB7BHGYklKB6fxLUc3o/7OEeG3fUNVf//99pRNztv57dfPpkYQvSop97SBXHOuC
         rMEo+RCm4Mfxj0YHxHJpkETG7GqP0nbNwSgC6MRjdIYo1CIFADFwVE1jkaPROu8f5lkG
         gQd/pTij053kUAh299u3QTXvthJzAlOeRlG8eoKBnRVQDs6Jh81P0hCaP/PD9iZVCM5Y
         vi+tuuypxe+UCJk1KkQQdGul6BVp9pwgH2S+qo+9+iOM/aX1gCUkK8eWIRjMdoKIWaEl
         HxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utvkfVXnWSLnKdSa+6GF8/PEjrYoBqu8Fn7jPDqt4C8=;
        b=hxA/1Rfdh1uVRgWyMcEtTvHP5avjbf2Q7nAZleuHTdyqJRvEbS5y+7KANRKns6aEpe
         /v4d50550fV9qbMPzfxjV9ZwTLPpzc30J6a8yhqnJjjeCvN96dSmZjUR59uvkfK7BPoO
         gROCl6Vz0Ltci6EsxeATSPInzJaFlvn8FIvaQO+OsxflVWAwKcPbIw4Fny0Tuw+crvs+
         k47zmKcu5AQJVPLwZcFQOF58rEuQDGfdBrhNWDE2ORlVS4eg7nbHrHfPukeI+BjsiiLV
         8Yi5Enh86uJ/6A44eSn+GOZQwE0imC5zUd9FCZrVnoynZhL52urAEmFjunYOTeMgNpAk
         6spA==
X-Gm-Message-State: AOAM5333T+LSydVnjPLNd3Wf10Rit1C32jaeUUdl6czaU7rBhijVvo5v
        M9p4M2+StEx6ZjYFgL/dfLgfaQkIQe/QAGaV4MgytA==
X-Google-Smtp-Source: ABdhPJyYTMT7ZHiCXg3C7vYinlc/deu0CArrWe4sGJ5a7HqhVEUUgHUB6YfQBKFlcXs+aoYupAJ+EG7p0iyKX3/K2QI=
X-Received: by 2002:a05:600c:4fc4:b0:37c:9116:ef3d with SMTP id
 o4-20020a05600c4fc400b0037c9116ef3dmr3102577wmq.167.1645723244554; Thu, 24
 Feb 2022 09:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
 <20220224051439.640768-2-kaleshsingh@google.com> <CA+EHjTzkmPuqtpRQRRfRnC2n-ah_jnPiqfa2kg55YESGSjN6OA@mail.gmail.com>
In-Reply-To: <CA+EHjTzkmPuqtpRQRRfRnC2n-ah_jnPiqfa2kg55YESGSjN6OA@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 24 Feb 2022 09:20:33 -0800
Message-ID: <CAC_TJvdTqiK87iT86JngJbtB-JfRDbuJREcLXvuEg3pqTEzcCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
To:     Fuad Tabba <tabba@google.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>
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

On Thu, Feb 24, 2022 at 4:25 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Kalesh,
>
> On Thu, Feb 24, 2022 at 5:16 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > hyp_alloc_private_va_range() can be used to reserve private VA ranges
> > in the nVHE hypervisor. Also update  __create_hyp_private_mapping()
> > to allow specifying an alignment for the private VA mapping.
> >
> > These will be used to implement stack guard pages for KVM nVHE hypervisor
> > (nVHE Hyp mode / not pKVM), in a subsequent patch in the series.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v3:
> >   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
> >
> >  arch/arm64/include/asm/kvm_mmu.h |  4 +++
> >  arch/arm64/kvm/mmu.c             | 62 ++++++++++++++++++++------------
> >  2 files changed, 43 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index 81839e9a8a24..0b0c71302b92 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -153,6 +153,10 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
> >  int kvm_share_hyp(void *from, void *to);
> >  void kvm_unshare_hyp(void *from, void *to);
> >  int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> > +unsigned long hyp_alloc_private_va_range(size_t size, size_t align);
> > +int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> > +                               size_t align, unsigned long *haddr,
> > +                               enum kvm_pgtable_prot prot);
> >  int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
> >                            void __iomem **kaddr,
> >                            void __iomem **haddr);
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index bc2aba953299..fc09536c8197 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -457,22 +457,16 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> >         return 0;
> >  }
> >
> > -static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> > -                                       unsigned long *haddr,
> > -                                       enum kvm_pgtable_prot prot)
> > +
> > +/*
> > + * Allocates a private VA range below io_map_base.
> > + *
> > + * @size:      The size of the VA range to reserve.
> > + * @align:     The required alignment for the allocation.
> > + */
>
> Many of the functions in this file use the kernel-doc format, and your
> added comments are close, but not quite conforment. If you want to use
> the kernel-doc for these you can refer to:
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

Hi Fuad,

Thanks for the pointer. I will update the function comments to match
when I send the next version.

>
> > +unsigned long hyp_alloc_private_va_range(size_t size, size_t align)
> >  {
> >         unsigned long base;
> > -       int ret = 0;
> > -
> > -       if (!kvm_host_owns_hyp_mappings()) {
> > -               base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> > -                                        phys_addr, size, prot);
> > -               if (IS_ERR_OR_NULL((void *)base))
> > -                       return PTR_ERR((void *)base);
> > -               *haddr = base;
> > -
> > -               return 0;
> > -       }
> >
> >         mutex_lock(&kvm_hyp_pgd_mutex);
> >
> > @@ -484,8 +478,8 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> >          *
> >          * The allocated size is always a multiple of PAGE_SIZE.
> >          */
> > -       size = PAGE_ALIGN(size + offset_in_page(phys_addr));
> > -       base = io_map_base - size;
> > +       base = io_map_base - PAGE_ALIGN(size);
> > +       base = ALIGN_DOWN(base, align);
> >
> >         /*
> >          * Verify that BIT(VA_BITS - 1) hasn't been flipped by
> > @@ -493,20 +487,42 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> >          * overflowed the idmap/IO address range.
> >          */
> >         if ((base ^ io_map_base) & BIT(VA_BITS - 1))
> > -               ret = -ENOMEM;
> > +               base = (unsigned long)ERR_PTR(-ENOMEM);
> >         else
> >                 io_map_base = base;
> >
> >         mutex_unlock(&kvm_hyp_pgd_mutex);
> >
> > -       if (ret)
> > -               goto out;
> > +       return base;
> > +}
> > +
> > +int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> > +                               size_t align, unsigned long *haddr,
> > +                               enum kvm_pgtable_prot prot)
> > +{
> > +       unsigned long addr;
> > +       int ret = 0;
> > +
> > +       if (!kvm_host_owns_hyp_mappings()) {
> > +               addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> > +                                        phys_addr, size, prot);
> > +               if (IS_ERR_OR_NULL((void *)addr))
> > +                       return addr ? PTR_ERR((void *)addr) : -ENOMEM;
> > +               *haddr = addr;
> > +
> > +               return 0;
> > +       }
> > +
> > +       size += offset_in_page(phys_addr);
>
> You're not page-aligning the size, which was the behavior before this
> patch. However, looking at where it's being used it seems to be fine
> because the users of size would align it if necessary.

This is now done by hyp_alloc_private_va_range() when calculating the new base:
 ...
 * The allocated size is always a multiple of PAGE_SIZE.
 */
base = io_map_base - PAGE_ALIGN(size);
...

Thanks,
Kalesh

>
> Thanks,
> /fuad
>
>
>
> > +       addr = hyp_alloc_private_va_range(size, align);
> > +       if (IS_ERR_OR_NULL((void *)addr))
> > +               return addr ? PTR_ERR((void *)addr) : -ENOMEM;
> >
> > -       ret = __create_hyp_mappings(base, size, phys_addr, prot);
> > +       ret = __create_hyp_mappings(addr, size, phys_addr, prot);
> >         if (ret)
> >                 goto out;
> >
> > -       *haddr = base + offset_in_page(phys_addr);
> > +       *haddr = addr + offset_in_page(phys_addr);
> >  out:
> >         return ret;
> >  }
> > @@ -537,7 +553,7 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
> >                 return 0;
> >         }
> >
> > -       ret = __create_hyp_private_mapping(phys_addr, size,
> > +       ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
> >                                            &addr, PAGE_HYP_DEVICE);
> >         if (ret) {
> >                 iounmap(*kaddr);
> > @@ -564,7 +580,7 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
> >
> >         BUG_ON(is_kernel_in_hyp_mode());
> >
> > -       ret = __create_hyp_private_mapping(phys_addr, size,
> > +       ret = __create_hyp_private_mapping(phys_addr, size, PAGE_SIZE,
> >                                            &addr, PAGE_HYP_EXEC);
> >         if (ret) {
> >                 *haddr = NULL;
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >
