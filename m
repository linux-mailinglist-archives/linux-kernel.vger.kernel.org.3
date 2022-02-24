Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975A64C3410
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiBXRzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiBXRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:54:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E5252937
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:54:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d17so842525wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GE+XGHonrH22zXrgiLwafrMHAo1pCMt8qc++bm61hZc=;
        b=mZLz9SlFVQ84zMxIhFdLQMmVgKUhNsTq7TIRpy5lode3I8PkSY+1/w19uOMblnnZ6Z
         4kZ9pOjtV/nAnm26mvr8v5z5LG7pNREFfElRV2jepUw1NHLVfHih/1BEty1AsHrgEyUI
         wH0Gr9d/pOXtAIFXjebgufroKudUgLNif6D2BMDjj33guNjjYh+C58j11mRcVkC6KrhA
         S+Pl3Qz8q4aw5v5ZGyfjRLH3zDgAjgDwhu944MLmr6gq5q0LTClONsHTHeXWb5AEq8HV
         aWnhF74XNPIe1e6msCIsV+Ndp7HqCZV7nnGErVd2wx+gVEjzGkBd1MHS5ucJrC3jDVbO
         AeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GE+XGHonrH22zXrgiLwafrMHAo1pCMt8qc++bm61hZc=;
        b=BKjF1NeDsGCVU5MX7AceUTF+OqADtPJDskytCGJo+cSzShVA5IK3/nvIcS65xUBuQc
         90IM85cluTRRIRnVwFOq/6H5qqTqEmLsnSKc6L2cnLSp1OaZYVo7kerYR++Gq8KaJDxY
         7KJRXMh3c+IhFcAZoMhcwtkeWTSulIe2+e8kbLC5to/V7AjOZtEvu9bMivzBVdlqoi/q
         VjmBVRnqsqWKtQmaUJ8A3jrY6/E0ciPjHliL5Fs+82aHazE3jLyqm98A03FUKXwzPwCY
         Zk5lhKKsgnOQOqw71Fyd8xWvU2sJAEyeerfb3CUonfBJQpjV7iYxh6G3SrtyFptn35Zh
         IEFA==
X-Gm-Message-State: AOAM531l9k7XDNBC86cr9ve425DpcXxRpUemD7aeOX+IhjsNihjLX41+
        ewqXyqeopTjqxRdM55fFNSumq0e1iIljEk400CIy+w==
X-Google-Smtp-Source: ABdhPJxHmUKpTMRNJ+ob8+yuIRIbACjTU5wiSB63z2iiN9d/8JNSMH+uWCSXvhJHtYIl9R7h2hcbj50TcC7mMZhOG/U=
X-Received: by 2002:adf:ca08:0:b0:1ed:c0bc:c212 with SMTP id
 o8-20020adfca08000000b001edc0bcc212mr3148175wrh.577.1645725266912; Thu, 24
 Feb 2022 09:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
 <20220224051439.640768-4-kaleshsingh@google.com> <CA+EHjTy6DJt8Pcfj4JnVhSG0sQ7O09zvOaMP--aRuAsM=8zKUw@mail.gmail.com>
In-Reply-To: <CA+EHjTy6DJt8Pcfj4JnVhSG0sQ7O09zvOaMP--aRuAsM=8zKUw@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 24 Feb 2022 09:54:16 -0800
Message-ID: <CAC_TJvcypLTxa=HaPvfNBgQpB1qG=d_sLnOLAn=gAznpD4_hqw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] KVM: arm64: Add guard pages for KVM nVHE
 hypervisor stack
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
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Feb 24, 2022 at 4:26 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Kalesh,
>
>
>
> On Thu, Feb 24, 2022 at 5:18 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Maps the stack pages in the flexible private VA range and allocates
> > guard pages below the stack as unbacked VA space. The stack is aligned
> > to twice its size to aid overflow detection (implemented in a subsequent
> > patch in the series).
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
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
> >         unsigned long tcr_el2;
> >         unsigned long tpidr_el2;
> >         unsigned long stack_hyp_va;
> > +       unsigned long stack_pa;
> >         phys_addr_t pgd_pa;
> >         unsigned long hcr_el2;
> >         unsigned long vttbr;
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index ecc5958e27fe..7a23630c4a7f 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -1541,7 +1541,6 @@ static void cpu_prepare_hyp_mode(int cpu)
> >         tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
> >         params->tcr_el2 = tcr;
> >
> > -       params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
> >         params->pgd_pa = kvm_mmu_get_httbr();
> >         if (is_protected_kvm_enabled())
> >                 params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
> > @@ -1990,14 +1989,41 @@ static int init_hyp_mode(void)
> >          * Map the Hyp stack pages
> >          */
> >         for_each_possible_cpu(cpu) {
> > +               struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
> >                 char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
> > -               err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
> > -                                         PAGE_HYP);
> > +               unsigned long stack_hyp_va, guard_hyp_va;
> >
> > +               /*
> > +                * Private mappings are allocated downwards from io_map_base
> > +                * so allocate the stack first then the guard page.
> > +                *
> > +                * The stack is aligned to twice its size to facilitate overflow
> > +                * detection.
> > +                */
> > +               err = __create_hyp_private_mapping(__pa(stack_page), PAGE_SIZE,
> > +                                               PAGE_SIZE * 2, &stack_hyp_va, PAGE_HYP);
> >                 if (err) {
> >                         kvm_err("Cannot map hyp stack\n");
> >                         goto out_err;
> >                 }
> > +
> > +               /* Allocate unbacked private VA range for stack guard page */
> > +               guard_hyp_va = hyp_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
> > +               if (IS_ERR_OR_NULL((void *)guard_hyp_va)) {
> > +                       err = guard_hyp_va ? PTR_ERR((void *)guard_hyp_va) : -ENOMEM;
>
> I am a bit confused by this check. hyp_alloc_private_va_range() always
> returns ERR_PTR(-ENOMEM) if there's an error. Mark's comment (if I
> understood it correctly) was about how you were handling it *in*
> hyp_alloc_private_va_range(), rather than calls *to*
> hyp_alloc_private_va_range().

Mark's comments were for the callers. I think the address can still be
null without returning -ENOMEM (judging from what the check was before
hyp_alloc_private_va_range). You make a good point - I think we can
handle any potential null in *_alloc_private_va_range() and drop the
use of PTR_ERR with IS_ERR_OR_NULL (which seems not a good idea in
general).

>
> > +                       kvm_err("Cannot allocate hyp stack guard page\n");
> > +                       goto out_err;
> > +               }
> > +
> > +               /*
> > +                * Save the stack PA in nvhe_init_params. This will be needed to recreate
> > +                * the stack mapping in protected nVHE mode. __hyp_pa() won't do the right
> > +                * thing there, since the stack has been mapped in the flexible private
> > +                * VA space.
> > +                */
>
> Nit: These comments go over 80 columns, unlike other comments that
> you've added in this file.

Ack. I'll update in the next version.

Thanks,
Kalesh

>
> Thanks,
> /fuad
>
> > +               params->stack_pa = __pa(stack_page) + PAGE_SIZE;
> > +
> > +               params->stack_hyp_va = stack_hyp_va + PAGE_SIZE;
> >         }
> >
> >         for_each_possible_cpu(cpu) {
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >
