Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59954543AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiFHRxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiFHRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:53:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D74DE9E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:53:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a10so8756445wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YI9Mc2y8PFJNJ6+277vO+Lm0SzBPppWh2ZCOqdRyG6U=;
        b=T6/f1qoAHYT15Hdc059V8LrdJ4GLuSvSfJhPDPXC+CHKqgTSOEQjMe4N5wpirC9FtU
         RM1ZClrDDtGGUlsCUAvtRIHYu9T+qgfZPKRBdo1OkSLN/NVYr5H+xiWvptYKDx6wqeny
         98WMYiqOFUzT7s9uim5WWfH7PaQ5W60nWnLtQu1OSsqgNpTO7ud2I//C7+LUHkz58v62
         rsQ/j9znMPtuROLFr+FjZXc0UwWxNvrenPI2c7c0cAxxB5dJ7AiY12fFjqgLSjIZ0nPl
         3nYmv2UftqPeTJRZ2lCEraPv7280jJJyl1DnnOuSEjLXO4M22RgXjayoWXjoMjFvWeBv
         rQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YI9Mc2y8PFJNJ6+277vO+Lm0SzBPppWh2ZCOqdRyG6U=;
        b=LYS1stGN9SyVBSXgwoJUq0U3s+NblnjNkulFcLm2PL25qHLtHoOGgnaVBo8ETu4xZp
         0XirIEoEOsQRNWS6Yx4xWDCYL9pjcnJ/ZtG7SA+byLBDK9mAr7YOihZm9JaEHy79o21t
         nhXIIF0LKlMlKJal1wwqU8IiZ86MDIfxbwHIDaTs/hkSHqMekxkJk3xeQ7CUnv4vXGJy
         ae8FaZrMtSHTVdhHNeXhiu6aZha8BaIqw61psq7+TVP7NUyGhSl1u8BqdLyNx/+wOfBV
         1Pu5jt/+9uUmm+1kgH7uakCtYDLU7tB3/76eSZ21rfRIZqy/oZQneXx3cg+lACZQwNcS
         Vxsw==
X-Gm-Message-State: AOAM531rR+M5ILgnlPXw5B/jNXAlAZjhSzcoKXaQzBtRF/AycF9ldETJ
        /R5Gy8ODPNi+Kqgv4md6DHc+SLQ5OZp7UTlPuGP25A==
X-Google-Smtp-Source: ABdhPJxtB5s3HTyhMQ+95dATyPUIRZjpYXUhC4AvkAPE7C5j7bf9s29ofjL8I/77hpbnAS2cfihV8ammb75j3F8npfU=
X-Received: by 2002:a1c:7901:0:b0:39c:4252:d7f1 with SMTP id
 l1-20020a1c7901000000b0039c4252d7f1mr380895wme.178.1654710784341; Wed, 08 Jun
 2022 10:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220607165105.639716-1-kaleshsingh@google.com>
 <20220607165105.639716-4-kaleshsingh@google.com> <87k09rzk0o.wl-maz@kernel.org>
In-Reply-To: <87k09rzk0o.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 8 Jun 2022 10:52:53 -0700
Message-ID: <CAC_TJvdCuGNEJC4M+bV6o48CSJRs_4GEUb3iiP_4ro79q=KesA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] KVM: arm64: Add hypervisor overflow stack
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
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
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

On Wed, Jun 8, 2022 at 12:34 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 07 Jun 2022 17:50:45 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Allocate and switch to 16-byte aligned secondary stack on overflow. This
> > provides us stack space to better handle overflows; and is used in
> > a subsequent patch to dump the hypervisor stacktrace.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/kernel/stacktrace.c | 3 +++
> >  arch/arm64/kvm/hyp/nvhe/host.S | 9 ++-------
> >  2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index a84e38d41d38..f346b4c66f1c 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -242,4 +242,7 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
> >
> >       unwind(task, &state, consume_entry, cookie);
> >  }
> > +#else /* __KVM_NVHE_HYPERVISOR__ */
> > +DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack)
> > +     __aligned(16);
>
> Does this need to be a whole page? With 64kB pages, this is
> potentially a lot of memory for something that will hardly ever be
> used. The rest of the kernel limits this to 4kB, which seems more
> reasonable. There is no guard page anyway, so PAGE_SIZE doesn't
> provide any extra protection.

My oversight on the !4kB page sizes. I think this could be as small as:

    (STACK_SIZE - 1) / 2 + sizeof(long)

         '/ 2'                        : Min frame size (x29, x30)
         '+ sizeof(long)'      : To round up

since we only save the one address (PC) for each frame. WDYT?

Thanks,
Kalesh

>
> >  #endif /* !__KVM_NVHE_HYPERVISOR__ */
> > diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> > index ea6a397b64a6..4e3032a244e1 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/host.S
> > +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> > @@ -177,13 +177,8 @@ SYM_FUNC_END(__host_hvc)
> >       b       hyp_panic
> >
> >  .L__hyp_sp_overflow\@:
> > -     /*
> > -      * Reset SP to the top of the stack, to allow handling the hyp_panic.
> > -      * This corrupts the stack but is ok, since we won't be attempting
> > -      * any unwinding here.
> > -      */
> > -     ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> > -     mov     sp, x0
> > +     /* Switch to the overflow stack */
> > +     adr_this_cpu sp, overflow_stack + PAGE_SIZE, x0
> >
> >       b       hyp_panic_bad_stack
> >       ASM_BUG()
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
> >
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
