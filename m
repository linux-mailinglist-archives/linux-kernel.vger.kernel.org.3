Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928B57D78D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiGVAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiGVABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:01:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7666F8F530
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:01:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by8so3648107ljb.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfUx8CmhONPumASQ3Ohn0ZPBwIqk0yRSMBdm0KN2cgU=;
        b=rOHN3ZGGd0VZ8vpBhxUS3HRRKOp92PUaDlqmaWVQgqErtb6Xo8/DY7Q5ALgGDkl1G8
         qQ7FlqyStGgGVHuhOQy8qypFsKQl0an3DzVR1DnoI8XA+tnSI9bgkFO0XC0hMI2lE/QL
         wrMQyRmh4idG2r0aPrIKyi9Ui4tb8TLAnFuCOHGHkKg7V5iR9yCd4zWR1hs2+4bvChdy
         x40yWVd9k2XjY9Czw6f7QBnQThHo7oCtU7sh2xOK23lJiJx7iwopE2D/670kdQaj0UZG
         RDlQoapXQoEoN9uzBnp0raGVgaQwy6wESzIK0Be3BQGnm+GFq/VbVNMUye51vkNgxkgT
         Df8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfUx8CmhONPumASQ3Ohn0ZPBwIqk0yRSMBdm0KN2cgU=;
        b=oQIwnHBn5OSsHL+yxHfLbJWKqX3QqG6fP7rEq9IXPucxId3NslvZIX3dd1jbIx+xOs
         Y7ONUncYXxWskcnKV1KLw96rElJu+Unp7weDPuoGdHjLLokEIa2rpqgRFRLx4XhwQrKw
         Hr2ALxhIQFN9egy5Xn/nVWY34wlQM4C7hKauFAGFdwP58WpDdpyYpXzq9dTT1Vl2G6T8
         5lXoYHRTysR7mckRcoqyMXqmCCy7EBMqYS4JYGqTQMBwgs+ZMC6whaa9blxyT9bODOHT
         9ps92+bEIDUXDtA0/pReO9zNgZMAIF2vFT5glMOIp1CUvQPEXtAmAUzudickiPbuH8Xs
         DbGg==
X-Gm-Message-State: AJIora+RcnR9LBatvoWlBmCZkRst3Jk0wkJQJRvYIK8ePi4238Rv1pbP
        OTysaexknQa+F7yoOcPyOZnW5nhet4coDvn5nDOuHw==
X-Google-Smtp-Source: AGRyM1s+4jZ2x/29KrEyF0s+DwzE6XpjQADLpLzRnJDAnzkLjFNuegifnNgpwxjZcEU4vwvE6S7KFwmjrYf0PPjgeak=
X-Received: by 2002:a2e:9d02:0:b0:25d:d6b9:b753 with SMTP id
 t2-20020a2e9d02000000b0025dd6b9b753mr262234lji.344.1658448078269; Thu, 21 Jul
 2022 17:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
 <20220721055728.718573-18-kaleshsingh@google.com> <Ytm4ji93wyjRI7Jw@google.com>
In-Reply-To: <Ytm4ji93wyjRI7Jw@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 21 Jul 2022 17:01:07 -0700
Message-ID: <CAC_TJveRKqRkfiJr=0JHxRYSqTh3CMANqNkkRNRvj=xwWd6jDg@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] KVM: arm64: Introduce hyp_dump_backtrace()
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 1:35 PM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> Hi Kalesh,
>
> Nifty series! Had the chance to take it for a spin :) Few comments
> below:

Hi Oliver. Thanks for giving it a try :)

>
> On Wed, Jul 20, 2022 at 10:57:28PM -0700, Kalesh Singh wrote:
> > In non-protected nVHE mode, unwinds and dumps the hypervisor backtrace
> > from EL1. This is possible beacuase the host can directly access the
> > hypervisor stack pages in non-proteced mode.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v5:
> >   - Move code out from nvhe.h header to handle_exit.c, per Marc
> >   - Fix stacktrace symoblization when CONFIG_RAMDOMIZE_BASE is enabled,
> >     per Fuad
> >   - Use regular comments instead of doc comments, per Fuad
> >
> >  arch/arm64/kvm/handle_exit.c | 65 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 56 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index ad568da5c7d7..432b6b26f4ad 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
>
> [...]
>
> > @@ -318,6 +319,56 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
> >               kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
> >  }
> >
> > +/*
> > + * kvm_nvhe_print_backtrace_entry - Symbolizes and prints the HYP stack address
> > + */
> > +static void kvm_nvhe_print_backtrace_entry(unsigned long addr,
> > +                                               unsigned long hyp_offset)
> > +{
> > +     unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
> > +
> > +     /* Mask tags and convert to kern addr */
> > +     addr = (addr & va_mask) + hyp_offset;
> > +     kvm_err(" [<%016lx>] %pB\n", addr, (void *)(addr + kaslr_offset()));
> > +}
>
> It is a bit odd to see this get churned from the last patch. Is it
> possible to introduce the helper earlier on? In fact, the non-protected
> patch should come first to layer the series better.

Agreed. pKVM is the one with the extra layer. I'll reorder this in the
next version.

>
> Also, it seems to me that there isn't much need for the indirection if
> the pKVM unwinder is made to work around the below function signature:

Ok, I'll fold it into the below function.

>
> <snip>
>
> > +/*
> > + * hyp_dump_backtrace_entry - Dump an entry of the non-protected nVHE HYP stacktrace
> > + *
> > + * @arg    : the hypervisor offset, used for address translation
> > + * @where  : the program counter corresponding to the stack frame
> > + */
> > +static bool hyp_dump_backtrace_entry(void *arg, unsigned long where)
> > +{
> > +     kvm_nvhe_print_backtrace_entry(where, (unsigned long)arg);
> > +
> > +     return true;
> > +}
>
> </snip>
>
> > +/*
> > + * hyp_dump_backtrace - Dump the non-proteced nVHE HYP backtrace.
> > + *
> > + * @hyp_offset: hypervisor offset, used for address translation.
> > + *
> > + * The host can directly access HYP stack pages in non-protected
> > + * mode, so the unwinding is done directly from EL1. This removes
> > + * the need for shared buffers between host and hypervisor for
> > + * the stacktrace.
> > + */
> > +static void hyp_dump_backtrace(unsigned long hyp_offset)
> > +{
> > +     struct kvm_nvhe_stacktrace_info *stacktrace_info;
> > +     struct unwind_state state;
> > +
> > +     stacktrace_info = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
> > +
> > +     kvm_nvhe_unwind_init(&state, stacktrace_info->fp, stacktrace_info->pc);
> > +
> > +     kvm_err("Non-protected nVHE HYP call trace:\n");
>
> I don't see the value in discerning non-protected vs. protected in the
> preamble, as panic() will dump the kernel commandline which presumably
> would have a `kvm-arm.mode=protected` in the case of pKVM.

Ok, I'll remove the distinction.

>
> <nit>
>
> Not entirely your problem, but we should really use a consistent name
> for that thing we have living at EL2. Hyp or nVHE (but not both) would
> be appropriate.
>

Right, I think just "nVHE" is probably sufficient. (Open to other suggestions)

> </nit>
>
> > +     unwind(&state, hyp_dump_backtrace_entry, (void *)hyp_offset);
> > +     kvm_err("---- End of Non-protected nVHE HYP call trace ----\n");
>
> Maybe:
>
> kvm_err("---[ end ${NAME_FOR_EL2} trace ]---");
>
> (more closely matches the pattern of the arm64 stacktrace)

Agreed.

Thanks,
Kalesh

>
> --
> Thanks,
> Oliver
