Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9989578852
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiGRR1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbiGRR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:27:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C452B1AC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:27:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so18093801wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NarkEMjRQJGNapnFE354uoBB/FLZcCCiwC99PqFL5qY=;
        b=S68ky+N9MIZZqrGTw9WcCJuhoDR9m6g+zzdzjK+mpiGOlOMkgUPViUE0yazvxbTVav
         Yrq5OCexwM9wOYoRIMSmHKvc1e1P1m2lzlsgZsk2EINVKLs8FbE86MSoh6jbX/64wkKa
         TmI3gVVD5vqZl8NwUinYueWQFaCGVMMcBymaWzUannVPb7zYVB2aes/zUjEB7Gqvz8oP
         ckNfx0wCYQeIKHff5noIKIPvpUTw9XiQOQs7/yQitKejqOP2jE8lybHPfHJRsnt3DgcJ
         F4v8L+of8kaCZh2iyCodYJ8P9j81QmB/E5GcG0DzpcCt6yBrW7SIvBDgrvYpLW7gCO2l
         PB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NarkEMjRQJGNapnFE354uoBB/FLZcCCiwC99PqFL5qY=;
        b=g8AClmlI5N1CoYv49EPmSxT6tYQqoBZ80O1DcV+FNmywN3ZOoILn+Zcrlb0tHBwywh
         SrqS4LY5BIi8lk47Ys9dFBuf9hfaI0mOrNrTMrcwEBhqP1lX60aonVy6jOxtxdgV+RhL
         9yqI0mk0fMzF3STclexQaLfr6KV8p7avfhFuxCAh+qCVRI00Wg26mpESPGBihvUfCCZa
         FQRnZ9PPZuW6TpMSapmYggtIKJRGi/z/GCPImWxuCURztaHndw9jjNLJDEqVOUYXzkm/
         n1wc4Y0lfKBq1eJbfyKYGUPqlavBfjmGLQJNfvGeLU3nni3jmPoXK3fdK6JYwoDXDmHf
         6VzQ==
X-Gm-Message-State: AJIora+5lQcPRGot+cllDiLYkzkKNr5r6cV62/HpFlaHHZUtBPTLuqCG
        S3Q3W9XAPfck/Y5MvNqeRD7v0ie1hJjpVPypSIVbBg==
X-Google-Smtp-Source: AGRyM1uwq/757n/imP51CRNLieGFzZptqlZ7Lr0+jvfWuU7btodZ8udc9faDQUfo4/sXOUPE8dWEAhnfKnXpHMNeznk=
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id
 bj4-20020a0560001e0400b0021d7ec3fe5amr23991658wrb.116.1658165238673; Mon, 18
 Jul 2022 10:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-10-kaleshsingh@google.com> <87bktm51xf.wl-maz@kernel.org>
In-Reply-To: <87bktm51xf.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 10:27:07 -0700
Message-ID: <CAC_TJvdP4joAFP0bgfKGbqsXDANGAzUiwijmhvqJsGGEqkwRdA@mail.gmail.com>
Subject: Re: [PATCH v4 09/18] KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Jul 18, 2022 at 12:13 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 15 Jul 2022 07:10:18 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > In protected nVHE mode the host cannot directly access
> > hypervisor memory, so we will dump the hypervisor stacktrace
> > to a shared buffer with the host.
> >
> > The minimum size do the buffer required, assuming the min frame
>
> s/do/for/ ?
Ack

>
> > size of [x29, x30] (2 * sizeof(long)), is half the combined size of
> > the hypervisor and overflow stacks plus an additional entry to
> > delimit the end of the stacktrace.
>
> Let me see if I understand this: the maximum stack size is the
> combination of the HYP and overflow stacks, and the smallest possible
> stack frame is 128bit (only FP+LR). The buffer thus needs to provide
> one 64bit entry per stack frame that fits in the combined stack, plus
> one entry as an end marker.
>
> So the resulting size is half of the combined stack size, plus a
> single 64bit word. Is this correct?

That understanding is correct. So for the 64 KB pages is slightly more
than half a page (overflow stack is 4KB).

>
> >
> > The stacktrace buffers are used later in the seried to dump the
> > nVHE hypervisor stacktrace when using protected-mode.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/memory.h      | 7 +++++++
> >  arch/arm64/kvm/hyp/nvhe/stacktrace.c | 4 ++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index 0af70d9abede..28a4893d4b84 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -113,6 +113,13 @@
> >
> >  #define OVERFLOW_STACK_SIZE  SZ_4K
> >
> > +/*
> > + * With the minimum frame size of [x29, x30], exactly half the combined
> > + * sizes of the hyp and overflow stacks is needed to save the unwinded
> > + * stacktrace; plus an additional entry to delimit the end.
> > + */
> > +#define NVHE_STACKTRACE_SIZE ((OVERFLOW_STACK_SIZE + PAGE_SIZE) / 2 + sizeof(long))
> > +
> >  /*
> >   * Alignment of kernel segments (e.g. .text, .data).
> >   *
> > diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> > index a3d5b34e1249..69e65b457f1c 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> > @@ -9,3 +9,7 @@
> >
> >  DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
> >       __aligned(16);
> > +
> > +#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
> > +DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
> > +#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
>
> OK, so the allocation exists even if KVM is not running in protected
> mode. I guess this is OK for now, but definitely reinforces my request
> that this is only there when compiled for debug mode.
>

Yes, but in the case you aren't running protected mode you can avoid
it by setting PROTECTED_NVHE_STACKTRACE=n.

Thanks,
Kalesh

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
