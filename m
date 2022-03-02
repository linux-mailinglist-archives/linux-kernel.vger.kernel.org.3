Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE214CAC05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiCBRcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbiCBRcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:32:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921E5DA47
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:31:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1702787wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8D9Glo/IqaUHdT1IqNZ/4L9jANqiQOBO7H8ZnJ11bo=;
        b=kprMM0PaxhQaUOtqFTUXwwSlh4FWOta0HNFj3k7wlkS3kkvEmZ+wqPXkOH8B7y9/oC
         bm2gpBOVubXzle2zPcw8J4V7zljJPHIGhK4LrcPmyX92uvl7bC9wBUgtv6SjxBBFh2dY
         hcYB13Xv3owOAW+CWyYokl0ROfZlLpNgD4VTywg6B1V5WHMB04iufGZ/UiYQmN4WA4Nr
         gaiSEvvwL/JrKDnH1wb7+LFr4UY8vX1Fl/UqusDD2AYSrYEW5Zk/uEXCJYGrCSk/ufW4
         Hn7qtBMFNHJAEYKi1pg6r+9QpgVjIiYbQPjAYT+hhjhFeyakxl5yLxHCKGsJOlUmknxn
         +W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8D9Glo/IqaUHdT1IqNZ/4L9jANqiQOBO7H8ZnJ11bo=;
        b=HWpYdKymjrrnSJ6u0MHdaflnUZpMkMk5bh1G8zIMvMWaObxYL/ftbXmVOxwb+vE9RY
         pLiFURnmaejtZc4Qb9Whqea34UWw3NJaNHCb8P+ayvC9WusybSj/XPpdDdkYzVvmvLyj
         yzhknMALujmaQ8gJ7ugi6mC9lsq3kV8km3MptW+8HdrWMnxrd82UCpp0/2XYISmqB6jT
         6gH61Mx+j8zI34vP1VOqEvHSYRlktwqKK/35FVBFu3Ku/TIzbl+nGpHdQVG5mXcsYqc2
         WyWtf7ga6vAMF/4tf8lHkM2GEJm8P/H2/5Z6N+9+y9CNE4kOrNZEppvjABYVT1GwR+bR
         yb9g==
X-Gm-Message-State: AOAM5337292ogPCC1FNwDpkUHAvpaNt4kWvM4vEa5yOkPdaLiZiqAU6c
        uZQvCjwyhgOfJO8U2XsUybN9ndrhYu4COe9efhIw5A==
X-Google-Smtp-Source: ABdhPJyq4u8HQIq9pMffamDskyFj4okMEA25x2hK2hxWrrZpj8MvyhBFFR4we+1tTnFgbJ0bfNScYb4wg6LgfMWVPhU=
X-Received: by 2002:a05:600c:2284:b0:386:90d8:73ca with SMTP id
 4-20020a05600c228400b0038690d873camr714048wmf.66.1646242274759; Wed, 02 Mar
 2022 09:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20220225033548.1912117-1-kaleshsingh@google.com>
 <20220225033548.1912117-4-kaleshsingh@google.com> <87tucg6b97.wl-maz@kernel.org>
In-Reply-To: <87tucg6b97.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 2 Mar 2022 09:31:03 -0800
Message-ID: <CAC_TJvcjq5R_+UzhhqjZnusa5g+RT0HbLHBob-pTqofKgMSp9g@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] KVM: arm64: Add guard pages for KVM nVHE
 hypervisor stack
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:53 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 25 Feb 2022 03:34:48 +0000,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Maps the stack pages in the flexible private VA range and allocates
> > guard pages below the stack as unbacked VA space. The stack is aligned
> > to twice its size to aid overflow detection (implemented in a subsequent
> > patch in the series).
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v4:
> >   - Replace IS_ERR_OR_NULL check with IS_ERR check now that
> >     hyp_alloc_private_va_range() returns an error for null
> >     pointer, per Fuad
> >   - Format comments to < 80 cols, per Fuad
> >
> > Changes in v3:
> >   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
> >
> >  arch/arm64/include/asm/kvm_asm.h |  1 +
> >  arch/arm64/kvm/arm.c             | 32 +++++++++++++++++++++++++++++---
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index d5b0386ef765..2e277f2ed671 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -169,6 +169,7 @@ struct kvm_nvhe_init_params {
> >       unsigned long tcr_el2;
> >       unsigned long tpidr_el2;
> >       unsigned long stack_hyp_va;
> > +     unsigned long stack_pa;
> >       phys_addr_t pgd_pa;
> >       unsigned long hcr_el2;
> >       unsigned long vttbr;
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index ecc5958e27fe..0a83c0e7f838 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -1541,7 +1541,6 @@ static void cpu_prepare_hyp_mode(int cpu)
> >       tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
> >       params->tcr_el2 = tcr;
> >
> > -     params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
> >       params->pgd_pa = kvm_mmu_get_httbr();
> >       if (is_protected_kvm_enabled())
> >               params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
> > @@ -1990,14 +1989,41 @@ static int init_hyp_mode(void)
> >        * Map the Hyp stack pages
> >        */
> >       for_each_possible_cpu(cpu) {
> > +             struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
> >               char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
> > -             err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
> > -                                       PAGE_HYP);
> > +             unsigned long stack_hyp_va, guard_hyp_va;
> >
> > +             /*
> > +              * Private mappings are allocated downwards from io_map_base
> > +              * so allocate the stack first then the guard page.
> > +              *
> > +              * The stack is aligned to twice its size to facilitate overflow
> > +              * detection.
> > +              */
> > +             err = __create_hyp_private_mapping(__pa(stack_page), PAGE_SIZE,
> > +                                             PAGE_SIZE * 2, &stack_hyp_va, PAGE_HYP);
>
> Right, I guess that's where my earlier ask breaks, as you want an
> alignment that is *larger* than the allocation.
>
> >               if (err) {
> >                       kvm_err("Cannot map hyp stack\n");
> >                       goto out_err;
> >               }
> > +
> > +             /* Allocate unbacked private VA range for stack guard page */
> > +             guard_hyp_va = hyp_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
>
> Huh. You are implicitly relying on the VA allocator handing you an
> address contiguous with the previous mapping. That's... brave. I'd
> rather you allocate the VA space upfront with the correct alignment
> and then map the single page where it should be in the VA region.
>
> That'd be a lot less fragile.

Agreed. I'll fix it in the next version.

Thanks,
Kalesh
>
> > +             if (IS_ERR((void *)guard_hyp_va)) {
> > +                     err = PTR_ERR((void *)guard_hyp_va);
> > +                     kvm_err("Cannot allocate hyp stack guard page\n");
> > +                     goto out_err;
> > +             }
> > +
> > +             /*
> > +              * Save the stack PA in nvhe_init_params. This will be needed
> > +              * to recreate the stack mapping in protected nVHE mode.
> > +              * __hyp_pa() won't do the right thing there, since the stack
> > +              * has been mapped in the flexible private VA space.
> > +              */
> > +             params->stack_pa = __pa(stack_page) + PAGE_SIZE;
> > +
> > +             params->stack_hyp_va = stack_hyp_va + PAGE_SIZE;
> >       }
> >
> >       for_each_possible_cpu(cpu) {
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
