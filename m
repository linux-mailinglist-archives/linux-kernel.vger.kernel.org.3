Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41175543A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiFHR0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiFHRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:25:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB65615836
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:22:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m26so17803433wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+RipUWYNMLeY/oYRMhKJcIyF3eyXnDrThQxLnJtJ/4=;
        b=VbuiN8M4rPEtCsxfAOKq6djZLBP8Z09jLiB5E+50UbeLe1DyRPL04iCxdpUXPFmf4O
         tO2C+3zK3zva4OByvkV7cFUQpVlJNHtXs6cFLVxxp0eQpK5jOg3g1ErYQfw3d/kn1siM
         JqzuOE8Y2Fe0PpMZmKNjqwBN/78WtJ3TzqUBvUvenOup0z3ZN/9kF4Y9ufmY+m+3iLHz
         4XaGXS6i/2APuVBwkkbgPZH/FaP7oFy0L5wyFaZ20qMPI8O6W5L8wfckA/Cqv9hzlUZv
         3HRPKHWX7UIAR4D3mQ3fbcyMPfrrg9lPA2e6WWpxYkTGkOXcuRlGBpCS8hlyhhNdXY7b
         +W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+RipUWYNMLeY/oYRMhKJcIyF3eyXnDrThQxLnJtJ/4=;
        b=8RPvdEdxvwlmcsSpTHyORDgd6zE7GIDPYs3+aqzV5H2so49rvJa8MEeLrl1G7P2ehR
         50CrZoT5e5aDnJfaHVM4xHIVHFV2IrjUiX1WXZiIU0QfMeiVsqcODhTJ9eTrE+o8HrbS
         l3FUauDGx7tQ+DgGYC9Lm3Cqc2VSS2ZcBMbhcGV1sCMNdRfLCE+0xScNEsH/jc4sx8FD
         h4v3FChgINc916/oMdNXeYJEwEzQjBQb+K83/klimXaasG0c3/fr9qRDrgu9m+mpRwzp
         h2zYKK1p3HLsilXETqBF8naJICLqMNKe9jUHNaiNEBTiQ5W0aw5VgNUOCJz4vKZGxyMf
         TzhQ==
X-Gm-Message-State: AOAM533GVvyj7chYEQExN4cTLdvkv40bgZefVPx21ZFEi8J+FxqOgk61
        q5g33zYrCH5AXKVR1xVKnmY1BmPNQ2WHIfrM4btRxQ==
X-Google-Smtp-Source: ABdhPJzj7HbZLSivmEF68CKctXVCcbUidRcUXxew7OVgd/Q1ovBW9vLIR0DdV0vVzQluBSNqGW6kjayJZlmVfOiV0cY=
X-Received: by 2002:a05:6000:18a9:b0:218:7791:a9ad with SMTP id
 b9-20020a05600018a900b002187791a9admr3373050wri.116.1654708948112; Wed, 08
 Jun 2022 10:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220607165105.639716-1-kaleshsingh@google.com>
 <20220607165105.639716-3-kaleshsingh@google.com> <87leu7zk11.wl-maz@kernel.org>
In-Reply-To: <87leu7zk11.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 8 Jun 2022 10:22:16 -0700
Message-ID: <CAC_TJvetC5ZEee_x1nUf0ZJRk-eTAzJj4A4o+MOzZLS0tDGVCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] KVM: arm64: Compile stacktrace.nvhe.o
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
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

On Wed, Jun 8, 2022 at 12:33 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 07 Jun 2022 17:50:44 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Recompile stack unwinding code for use with the nVHE hypervisor. This is
> > a preparatory patch that will allow reusing most of the kernel unwinding
> > logic in the nVHE hypervisor.
> >
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > ---
> >
> > Changes in v3:
> >   - Add Mark's Reviewed-by tag
> >
> > Changes in v2:
> >   - Split out refactoring of common unwinding logic into a separate patch,
> >     per Mark Brown
> >
> >  arch/arm64/include/asm/stacktrace.h | 18 +++++++++-----
> >  arch/arm64/kernel/stacktrace.c      | 37 ++++++++++++++++-------------
> >  arch/arm64/kvm/hyp/nvhe/Makefile    |  3 ++-
> >  3 files changed, 35 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> > index aec9315bf156..f5af9a94c5a6 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -16,12 +16,14 @@
> >  #include <asm/sdei.h>
> >
> >  enum stack_type {
> > -     STACK_TYPE_UNKNOWN,
> > +#ifndef __KVM_NVHE_HYPERVISOR__
> >       STACK_TYPE_TASK,
> >       STACK_TYPE_IRQ,
> >       STACK_TYPE_OVERFLOW,
> >       STACK_TYPE_SDEI_NORMAL,
> >       STACK_TYPE_SDEI_CRITICAL,
> > +#endif /* !__KVM_NVHE_HYPERVISOR__ */
> > +     STACK_TYPE_UNKNOWN,
>
> What is the reason for this reordering? I have the sinking feeling
> that this could play badly with the logic that assumes that it is
> legal to switch from a lesser stack type to a higher one, and could
> allow switching to a duff stack.

HI Marc. Thanks for reviewing.

I only reordered the enum to group the common types. But I don't have
a strong opinion on it. The unwinding doesn't depend on the ordering
in this enum. When we transition form stack 'A'-->'B', we set the
stack_done bit for stack A so that we never transition back to 'A', as
it's not valid to transition back to a previous stack. But the order
of the sequence itself is not something enforced.

>
> I would at least like to see a justification of why this isn't less
> safe than the current code.
>
> [...]
>
> > index f9fe4dc21b1f..c0ff0d6fc403 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -14,7 +14,8 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
> >
> >  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
> >        hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
> > -      cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o
> > +      cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o \
> > +      ../../../kernel/stacktrace.o
>
> This, I positively hate. It is only a marginally better than the
> cross-arch references we used to have with arch/arm/kvm. I'd be much
> more happy with an include file containing the shared code. It would
> also allow the removal of some of the #ifdeferry. Note that this is
> the approach that we ended up adopting for the VHE/nVHE split.
>

Also thought about moving stuff to some header file, but I thought
this might be less intrusive. Let me prototype to see how they
compare.

Thanks,
Kalesh

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
