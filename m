Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA7506236
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiDSCny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiDSCnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:43:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC8D1D0FE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:41:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q20so9776413wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5qlpkxDkxkpAXcTdddiMdjLGBJEO/iRcDx+bQyggJo=;
        b=cwhlxpNpfyge5Tw3YhltCaJxvbzPH1qOqSuU1HdM28IFDklyXhoCyTgmNTvtsUwBTc
         MhEqSUzCPgZ17ydLw1yh2DLaycVeFyterA9iWEJvEFBp1Zfn2kpKRNOiDd0OjShHWmZ7
         GrNYrbmMIVdkv/X50S6qQIhJfio/TUA8O5TS0Qbk+6x+UF5GDahmhnv60F+tSSKeH8di
         xSBcbyKYuMji6h4/F4aZwnCImZnwejPfQhqfCiOIZlEy/ZaVGcF3aIUIByMPW2rV8Ijt
         88bEdCmrKVv3hiBlQmDvp0k8MquAJ93qj9cTAlTt3Nr10QHjjAUlSAwx3iAFHHmVMEO4
         hjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5qlpkxDkxkpAXcTdddiMdjLGBJEO/iRcDx+bQyggJo=;
        b=yGsIwtw/AiuhxC2R7CRrPRZI6rm8lXCHGP+v2Ow/DWHrZVxoFaC+9z4/rh+wE4frJ9
         gkrS5ZUpz28JUmTeuQvd70w9kxvAahIAR3WS9wIbGe2YLMIk1j4vAF8k8w7iTmF5L+z2
         PH+mjk8ODltH4rOabDDcvLtHk7bK1qETsMrTnSFK4NO+7dirpXr0YwO98AubcYJpXPRy
         PGLRaFWg8DyodI5BkShhF3w/QBHQJb5rU0Ea2MIh3DUlh9SvAvP2LrGHoxc4PrtO/iGe
         LrMFqF24k1lpnxJaaugUbHzfadFZ8QY80+25lE9VCtL1IJYuTU5EYbsq5GtNMlJaTEdc
         Je5A==
X-Gm-Message-State: AOAM531B5boSv21vNeNMjNMW+2677yBf6w+vALOGu4NI3Z5TsVJc3xBX
        FPd+kI2zdKkVSWqsPj3p1UhJnLdO5eGbXj23u2dgXw==
X-Google-Smtp-Source: ABdhPJx9nM4O6ke6iJlgie/f9XIfjCIkbp1CTn5gtentYY+mSfxNNqEVrNPON9mnvgc4j9VZHLB3AKkkPxGxoaXUYng=
X-Received: by 2002:a7b:c057:0:b0:37b:ebad:c9c8 with SMTP id
 u23-20020a7bc057000000b0037bebadc9c8mr17443313wmc.61.1650336071166; Mon, 18
 Apr 2022 19:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
 <20220408200349.1529080-6-kaleshsingh@google.com> <87v8v6aek0.wl-maz@kernel.org>
In-Reply-To: <87v8v6aek0.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Apr 2022 19:41:00 -0700
Message-ID: <CAC_TJvd=ubTMM+BRdELFokbxiKqaePAprG-pq3fR1vjKV9L6aA@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] KVM: arm64: Detect and handle hypervisor stack overflows
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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

On Mon, Apr 18, 2022 at 3:09 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 08 Apr 2022 21:03:28 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > The hypervisor stacks (for both nVHE Hyp mode and nVHE protected mode)
> > are aligned such  that any valid stack address has PAGE_SHIFT bit as 1.
> > This allows us to conveniently check for overflow in the exception entry
> > without corrupting any GPRs. We won't recover from a stack overflow so
> > panic the hypervisor.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Tested-by: Fuad Tabba <tabba@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > ---
> >
> > Changes in v7:
> >   - Add Fuad's Reviewed-by and Tested-by tags.
> >
> > Changes in v5:
> >   - Valid stack addresses now have PAGE_SHIFT bit as 1 instead of 0
> >
> > Changes in v3:
> >   - Remove test_sp_overflow macro, per Mark
> >   - Add asmlinkage attribute for hyp_panic, hyp_panic_bad_stack, per Ard
> >
> >
> >  arch/arm64/kvm/hyp/nvhe/host.S   | 24 ++++++++++++++++++++++++
> >  arch/arm64/kvm/hyp/nvhe/switch.c |  7 ++++++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> > index 3d613e721a75..be6d844279b1 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/host.S
> > +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> > @@ -153,6 +153,18 @@ SYM_FUNC_END(__host_hvc)
> >
> >  .macro invalid_host_el2_vect
> >       .align 7
> > +
> > +     /*
> > +      * Test whether the SP has overflowed, without corrupting a GPR.
> > +      * nVHE hypervisor stacks are aligned so that the PAGE_SHIFT bit
> > +      * of SP should always be 1.
> > +      */
> > +     add     sp, sp, x0                      // sp' = sp + x0
> > +     sub     x0, sp, x0                      // x0' = sp' - x0 = (sp + x0) - x0 = sp
> > +     tbz     x0, #PAGE_SHIFT, .L__hyp_sp_overflow\@
> > +     sub     x0, sp, x0                      // x0'' = sp' - x0' = (sp + x0) - sp = x0
> > +     sub     sp, sp, x0                      // sp'' = sp' - x0 = (sp + x0) - x0 = sp
> > +
> >       /* If a guest is loaded, panic out of it. */
> >       stp     x0, x1, [sp, #-16]!
> >       get_loaded_vcpu x0, x1
> > @@ -165,6 +177,18 @@ SYM_FUNC_END(__host_hvc)
> >        * been partially clobbered by __host_enter.
> >        */
> >       b       hyp_panic
> > +
> > +.L__hyp_sp_overflow\@:
> > +     /*
> > +      * Reset SP to the top of the stack, to allow handling the hyp_panic.
> > +      * This corrupts the stack but is ok, since we won't be attempting
> > +      * any unwinding here.
> > +      */
> > +     ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> > +     mov     sp, x0
> > +
> > +     bl      hyp_panic_bad_stack
>
> Why bl? You clearly don't expect to return here, given that you have
> an ASM_BUG() right below, and that you are calling a __no_return
> function. I think we should be consistent with the rest of the code
> and just do a simple branch.

The idea was to use bl  to give the hyp_panic_bad_stack() frame in the
stack trace, which makes it easy to identify overflows. I can add a
comment and drop the redundant ASM_BUG()

Thanks,
Kalesh

>
> It also gives us a chance to preserve an extra register from the
> context.
>
> > +     ASM_BUG()
> >  .endm
> >
> >  .macro invalid_host_el1_vect
> > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> > index 6410d21d8695..703a5d3f611b 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > @@ -347,7 +347,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
> >       return exit_code;
> >  }
> >
> > -void __noreturn hyp_panic(void)
> > +asmlinkage void __noreturn hyp_panic(void)
> >  {
> >       u64 spsr = read_sysreg_el2(SYS_SPSR);
> >       u64 elr = read_sysreg_el2(SYS_ELR);
> > @@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
> >       unreachable();
> >  }
> >
> > +asmlinkage void __noreturn hyp_panic_bad_stack(void)
> > +{
> > +     hyp_panic();
> > +}
> > +
> >  asmlinkage void kvm_unexpected_el2_exception(void)
> >  {
> >       return __kvm_unexpected_el2_exception();
> > --
> > 2.35.1.1178.g4f1659d476-goog
> >
> >
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
