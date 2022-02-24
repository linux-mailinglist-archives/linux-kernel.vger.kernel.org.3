Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198314C3434
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiBXR5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiBXR5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:57:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9237736E1E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:56:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so279095wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eQeP3GzjSxs3bFEsWrl0jof0V3c/zOR378LhVu6aVM=;
        b=eb+djR6grT5DoJHqSaYa43YmTmUXIY1zzrWUkx3lm8dwxaudIuXSEpFreKjqauj0nZ
         rq8S6FDFEMmkBWqAtIWnb5OvW2qU+eA1vhVR0Cao8KakyZvplVi5P8SPgsN5MSG5xZEy
         bD2DoMr4NXO1WqW6vWNEq0O2y6BdMU0FcLHQwg4+5xzxjxIkoHrN0Q7rAP4ehLcbfLh9
         WuJwhQrf4mF9OiTa4Oic677/toW3IEbTDPTlZKrtV9ydwGfz3bGBW7qA3CYoKLnYxxmY
         1UtIQYyoHhb9hXqGveElUe0IhklJ7bSMf1m1kTXBrBfZj+VF5/yEetss9ZTjOdhJ8TPE
         dSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eQeP3GzjSxs3bFEsWrl0jof0V3c/zOR378LhVu6aVM=;
        b=Go0Ef0sbOi8RuGcBTWE9Y8J4O2KbWNzTkdkY9iBUTDy4193G+o0skOZOA146U97Sks
         2vVGxOFfP3QUe+PGDaBzxYkLhc6Y4LfmNA812Zue+ALg7nMo6jyWY0ZpnbSQU35RNzDO
         8XG+kJB625TyimpsAuItLXrheITW5mZG/lXRdutzJLYI88/o+m3z+LioNWA7RzgOfxk7
         qfRHwpt2yxtzS8DMLD3ecVbXL4SBBki0upfqHn7SyD7Ntz3fleuEigLVOCW1gmZQfuo5
         C1F/oZCEtOo2lLznISy+f2rhRP+O/ruekrMSOS9TCVo3mz+741kE+/nMz1Cmbzk03sfX
         1Vmg==
X-Gm-Message-State: AOAM533YKlBGz+rNq2ABF/6cvDJFZT4zLq5Y3BBzCWW0dIiQyNcsnK/M
        oXrRcb9F6d4/apxvi3pxXDO1CU+FhyiGiUCxhpRmyw==
X-Google-Smtp-Source: ABdhPJzYW+HNNpZCuNrYQ+PqbU6fJhTMCkFS76nSOqdlNgbBezGKlNVWKEYvrhVOCHiGYxSgEJIQGaqr9FHR5gjgLks=
X-Received: by 2002:a05:600c:218d:b0:37f:a920:9705 with SMTP id
 e13-20020a05600c218d00b0037fa9209705mr3264121wme.86.1645725401178; Thu, 24
 Feb 2022 09:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
 <20220224051439.640768-7-kaleshsingh@google.com> <CA+EHjTwhpjDDnKRU3QrJysgMhYH7eTi2_LrWpxCArLoP-1-BrQ@mail.gmail.com>
In-Reply-To: <CA+EHjTwhpjDDnKRU3QrJysgMhYH7eTi2_LrWpxCArLoP-1-BrQ@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 24 Feb 2022 09:56:30 -0800
Message-ID: <CAC_TJve3wW91UMtCNHeDSZ8hspySmuYO2WgEYEH3Dk=Uj+GkJw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] KVM: arm64: Add hypervisor overflow stack
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
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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

On Thu, Feb 24, 2022 at 4:27 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Kalesh,
>
> On Thu, Feb 24, 2022 at 5:21 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Allocate and switch to 16-byte aligned secondary stack on overflow. This
> > provides us stack space to better handle overflows; and is used in
> > a subsequent patch to dump the hypervisor stacktrace. The overflow stack
> > is only allocated if CONFIG_NVHE_EL2_DEBUG is enabled, as hypervisor
> > stacktraces is a debug feature dependent on CONFIG_NVHE_EL2_DEBUG.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/host.S   | 5 +++++
> >  arch/arm64/kvm/hyp/nvhe/switch.c | 5 +++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> > index 749961bfa5ba..367a01e8abed 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/host.S
> > +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> > @@ -179,6 +179,10 @@ SYM_FUNC_END(__host_hvc)
> >         b       hyp_panic
> >
> >  .L__hyp_sp_overflow\@:
> > +#ifdef CONFIG_NVHE_EL2_DEBUG
> > +       /* Switch to the overflow stack */
> > +       adr_this_cpu sp, hyp_overflow_stack + PAGE_SIZE, x0
> > +#else
> >         /*
> >          * Reset SP to the top of the stack, to allow handling the hyp_panic.
> >          * This corrupts the stack but is ok, since we won't be attempting
> > @@ -186,6 +190,7 @@ SYM_FUNC_END(__host_hvc)
> >          */
>
> Nit: Maybe you should update this comment as well, since whether it
> corrupts the stack or not depends on what happens above with
> CONFIG_NVHE_EL2_DEBUG.

Ack, will update it in the next version.

Thanks,
Kalesh
>
> Thanks,
> /fuad
>
> >         ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> >         mov     sp, x0
> > +#endif
> >
> >         bl      hyp_panic_bad_stack
> >         ASM_BUG()
> > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> > index 703a5d3f611b..efc20273a352 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > @@ -34,6 +34,11 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
> >  DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
> >  DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
> >
> > +#ifdef CONFIG_NVHE_EL2_DEBUG
> > +DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
> > +       __aligned(16);
> > +#endif
> > +
> >  static void __activate_traps(struct kvm_vcpu *vcpu)
> >  {
> >         u64 val;
> > --
> > 2.35.1.473.g83b2b277ed-goog
> >
