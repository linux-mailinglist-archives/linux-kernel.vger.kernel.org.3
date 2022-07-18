Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103F7578882
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiGRRdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGRRdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:33:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250962CE0D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:33:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id id17so474311wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GhSiJA8jNsER0UOznMgRktrQLMwzPG3Lkdw+33iL48=;
        b=DVpMJwQkF5I84C5a0bD/n0SGDKhI8JmAiylD9fmz59B8jFXrW5DzKsxyYiuwdhGLvm
         K4gULiPfi6uauHtwJd2OIRawraFt+4S6N4KPFQEXI0286+Iz5uri3jFYjtWo7UNzRDbq
         WO/sHs2EbpJKexJf2/tIF2biRfjE38wrxW6d0gZkNTo64HJbndH7E73QqrQQbQSXP8IW
         +2es2frz9Bo5NJ4Ed4m92YziZGBbbEVM0o9C24Sru2nHI1xnBwSVrqYMNffmWR61pa9D
         12jZHHKA2uzOcv8qjjqzDwaga2LDQK5UYlTyUy8DbMjzhxEGoWrK4gduH418liVMZ7We
         plfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GhSiJA8jNsER0UOznMgRktrQLMwzPG3Lkdw+33iL48=;
        b=6fEcRtFd25AaCkmEsu1e+cO0IwELKt0SuO4JIE+7aCORrgtoO1axjcoNWZZDqdFKtc
         ivMUfDpIajWIz2xH95anaAHiUMcDOH8+a5YWqRUxHsNGqJSUqAXto3pkx8pV8dmKtfd4
         IVnDgknizT3ReZLXLu/x1F9BZ9hgMd9BkJYPmFgvWEB4miVR5ylu6fCRDzAg+hNG4m14
         P6DUniZoqd0R1s8kB76VF7oBBHltMoID68U61oJGo/pWio3gqWURCtWoK1zwL/UmxrXb
         qyveA4tE7u6MkWtKomo6SLm7oFLUBTQJnmx+gVxWAPt4gz0PN2nbVhxbn8AIP46nPC7y
         aTOw==
X-Gm-Message-State: AJIora9Tb0rCbotJAaVF6lA1IvLck0nVI2RGiRXRyPAgNH9iLe+ql5EN
        e2q7kp387N/WwHymwUVYSF89SiVOemeizIlqtu1hyA==
X-Google-Smtp-Source: AGRyM1tdOOSVY9WqE1GNkbUPuJZIHQeZx/yxe+w4lvoTvSD+QSC1W6nuhwTjhl40mPLwy38Rmfsy+mkoP0zaF4gbspQ=
X-Received: by 2002:a1c:7213:0:b0:3a3:155a:dd5d with SMTP id
 n19-20020a1c7213000000b003a3155add5dmr9625060wmc.178.1658165583538; Mon, 18
 Jul 2022 10:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-13-kaleshsingh@google.com> <87tu7ezrso.wl-maz@kernel.org>
In-Reply-To: <87tu7ezrso.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 10:32:52 -0700
Message-ID: <CAC_TJvcc0VZhp+u+2YpXuQ-UcGC+YTKy1PEoPCmbm+_WXo6cVw@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
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
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
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

On Mon, Jul 18, 2022 at 2:36 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 15 Jul 2022 07:10:21 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > In protected nVHE mode, the host cannot access private owned hypervisor
> > memory. Also the hypervisor aims to remains simple to reduce the attack
> > surface and does not provide any printk support.
> >
> > For the above reasons, the approach taken to provide hypervisor stacktraces
> > in protected mode is:
> >    1) Unwind and save the hyp stack addresses in EL2 to a shared buffer
> >       with the host (done in this patch).
> >    2) Delegate the dumping and symbolization of the addresses to the
> >       host in EL1 (later patch in the series).
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/stacktrace/nvhe.h | 18 ++++++
> >  arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 70 ++++++++++++++++++++++++
> >  2 files changed, 88 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> > index 36cf7858ddd8..456a6ae08433 100644
> > --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> > +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> > @@ -21,6 +21,22 @@
> >
> >  #include <asm/stacktrace/common.h>
> >
> > +/**
> > + * kvm_nvhe_unwind_init - Start an unwind from the given nVHE HYP fp and pc
> > + *
> > + * @fp : frame pointer at which to start the unwinding.
> > + * @pc : program counter at which to start the unwinding.
> > + */
> > +static __always_inline void kvm_nvhe_unwind_init(struct unwind_state *state,
> > +                                              unsigned long fp,
> > +                                              unsigned long pc)
> > +{
> > +     unwind_init_common(state, NULL);
>
> Huh. Be careful here. This function is only 'inline', which means it
> may not be really inlined. We've had tons of similar issues like this
> in the past, and although this will not break at runtime anymore, it
> will definitely stop the kernel from linking.

Ahh, there are a few other always inline *unwind_init* functions that
use this. I'll update in the next version.

Thanks,
Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
