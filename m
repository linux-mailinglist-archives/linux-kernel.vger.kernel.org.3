Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE51506211
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbiDSC2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiDSC2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:28:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265282C128
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:26:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so20520645wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTq4Y6MG952cbTvHOp9S8QrMczzWgHAuOZaPcb2lyOA=;
        b=EE29iXYuMVb/GLtdNuB3Ye8GMB7xgcyCRPY7fLBQyIzdUPoANUNve0iXc2zy4OIY4w
         sqlHmycM+WcT12q2QZ0joUMdkAaZwEYIsfEi6Xob+InHwkkQztaP46mx10bjQEbNDgOV
         rQ/Cztvrnw5o22jB1RbJYxUK8a99jKnqP2RsLyx70bd5XfrhEQvTdLOWC12xctMwupfK
         u/x9Rkt1sh2KKpmIBMSb32Y3ixhpe0nn/9puHUiTQa11UXmFw+cTTMi7K7mVjT9ncxMJ
         6R5K2NBkCgD/0Eny6ATML4nWAjPH9ODoBn9EPOAaqfIUK71S0vkkrmiRa6TsUOTgoFo2
         4qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTq4Y6MG952cbTvHOp9S8QrMczzWgHAuOZaPcb2lyOA=;
        b=6G0B2nXlBdDGjKEkR/7s/P0VSlecSuzkO2fujZB59iIkzlkRyoiQXZ0jptPWLukdSU
         jKgW99vuOnVI5gjP/dmUK0Kcd67TyqBX2RMdDkFTXZ8afXSc2ywMvVLfw+VhR+h/j/NF
         tuTpSjo0QW7hW/F0/EKDoitWGMISRx/C6InF9iRWlLsHXRjZfdigPE+sWv3covjiFkyJ
         6+oNh/8WnKqSXWXxFA2CpWRWHKsk4btlwW7SznxIT0vO96paZBoCgjRJ9psOuyLfObpB
         RivGrrEXSo9UREZAcYJAhwBH6tFfQNldhu8AjLW6BeS1sliPqCEnRxJAt35DA26ZOK6R
         U0rA==
X-Gm-Message-State: AOAM5304mGltaEVORHMeAtQ7/QhH9X86ZE4A8lJM9+znZZbQXTuHfMOi
        hqYW8xOdyxeVWk6WjOhnE9TLXriE1nS0SFMvfOX1VQ==
X-Google-Smtp-Source: ABdhPJyxCGSlBiOKFfGmT8l9+r/CXUB9ViouaEaAAckadAPOZhmFEmo7/f9noRPmK8DbOVuocEbFln61pb9OOJRTcVw=
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id
 t6-20020adfeb86000000b001e68c92af6bmr9930705wrn.116.1650335169435; Mon, 18
 Apr 2022 19:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
 <20220408200349.1529080-4-kaleshsingh@google.com> <87wnfmaexc.wl-maz@kernel.org>
In-Reply-To: <87wnfmaexc.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Apr 2022 19:25:58 -0700
Message-ID: <CAC_TJvfK3zJ_dN-0E3xJOWjdDybU12UfocoMf6-ji_swExas_Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] KVM: arm64: Add guard pages for KVM nVHE
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
        Andrew Jones <drjones@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Apr 18, 2022 at 3:01 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 08 Apr 2022 21:03:26 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Map the stack pages in the flexible private VA range and allocate
> > guard pages below the stack as unbacked VA space. The stack is aligned
> > so that any valid stack address has PAGE_SHIFT bit as 1 - this is used
> > for overflow detection (implemented in a subsequent patch in the series).
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Tested-by: Fuad Tabba <tabba@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > ---
> >
> > Changes in v7:
> >   - Add Fuad's Reviewed-by and Tested-by tags.
> >
> > Changes in v6:
> >   - Update call to hyp_alloc_private_va_range() (return val and params)
> >
> > Changes in v5:
> >   - Use a single allocation for stack and guard pages to ensure they
> >     are contiguous, per Marc
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
> >
> >  arch/arm64/include/asm/kvm_asm.h |  1 +
> >  arch/arm64/include/asm/kvm_mmu.h |  3 +++
> >  arch/arm64/kvm/arm.c             | 39 +++++++++++++++++++++++++++++---
> >  arch/arm64/kvm/mmu.c             |  4 ++--
> >  4 files changed, 42 insertions(+), 5 deletions(-)
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
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index a50cbb5ba402..b805316c4866 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -117,6 +117,9 @@ alternative_cb_end
> >  #include <asm/mmu_context.h>
> >  #include <asm/kvm_host.h>
> >
> > +extern struct kvm_pgtable *hyp_pgtable;
> > +extern struct mutex kvm_hyp_pgd_mutex;
>
> I'd rather you don't expose this at all.
>
> > +
> >  void kvm_update_va_mask(struct alt_instr *alt,
> >                       __le32 *origptr, __le32 *updptr, int nr_inst);
> >  void kvm_compute_layout(void);
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 523bc934fe2f..5687c0175151 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -1483,7 +1483,6 @@ static void cpu_prepare_hyp_mode(int cpu)
> >       tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
> >       params->tcr_el2 = tcr;
> >
> > -     params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
> >       params->pgd_pa = kvm_mmu_get_httbr();
> >       if (is_protected_kvm_enabled())
> >               params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
> > @@ -1933,14 +1932,48 @@ static int init_hyp_mode(void)
> >        * Map the Hyp stack pages
> >        */
> >       for_each_possible_cpu(cpu) {
> > +             struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
> >               char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
> > -             err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
> > -                                       PAGE_HYP);
> > +             unsigned long hyp_addr;
> >
> > +             /*
> > +              * Allocate a contiguous HYP private VA range for the stack
> > +              * and guard page. The allocation is also aligned based on
> > +              * the order of its size.
> > +              */
> > +             err = hyp_alloc_private_va_range(PAGE_SIZE * 2, &hyp_addr);
> > +             if (err) {
> > +                     kvm_err("Cannot allocate hyp stack guard page\n");
> > +                     goto out_err;
> > +             }
> > +
> > +             /*
> > +              * Since the stack grows downwards, map the stack to the page
> > +              * at the higher address and leave the lower guard page
> > +              * unbacked.
> > +              *
> > +              * Any valid stack address now has the PAGE_SHIFT bit as 1
> > +              * and addresses corresponding to the guard page have the
> > +              * PAGE_SHIFT bit as 0 - this is used for overflow detection.
> > +              */
> > +             mutex_lock(&kvm_hyp_pgd_mutex);
> > +             err = kvm_pgtable_hyp_map(hyp_pgtable, hyp_addr + PAGE_SIZE,
> > +                                     PAGE_SIZE, __pa(stack_page), PAGE_HYP);
> > +             mutex_unlock(&kvm_hyp_pgd_mutex);
>
> The mutex (and the HYP page table structure) really should stay
> private to the MMU code. Just add a new helper that will take the lock
> and use hyp_pgtable.

Agreed. I think we can expose __create_hyp_mappings() instead here.

Thanks,
Kalesh

>
> >               if (err) {
> >                       kvm_err("Cannot map hyp stack\n");
> >                       goto out_err;
> >               }
> > +
> > +             /*
> > +              * Save the stack PA in nvhe_init_params. This will be needed
> > +              * to recreate the stack mapping in protected nVHE mode.
> > +              * __hyp_pa() won't do the right thing there, since the stack
> > +              * has been mapped in the flexible private VA space.
> > +              */
> > +             params->stack_pa = __pa(stack_page);
> > +
> > +             params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
> >       }
> >
> >       for_each_possible_cpu(cpu) {
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 3d3efea4e991..a54f00bd06cc 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -22,8 +22,8 @@
> >
> >  #include "trace.h"
> >
> > -static struct kvm_pgtable *hyp_pgtable;
> > -static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
> > +struct kvm_pgtable *hyp_pgtable;
> > +DEFINE_MUTEX(kvm_hyp_pgd_mutex);
> >
> >  static unsigned long hyp_idmap_start;
> >  static unsigned long hyp_idmap_end;
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
