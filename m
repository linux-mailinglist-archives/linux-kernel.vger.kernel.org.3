Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74E5787D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiGRQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:51:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31F2B19C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:51:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b26so17958123wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAbDl1PRM5nJcEKcI6Ytvs7hiGOzTQVF+JIk15dOA88=;
        b=n5udodEAa/PhqseWRA+ZivosTL+aHxlWiMaVXsWsHZeKg72WFl+q1bjcvEIKJGsXbs
         RPtworRU8Nh1Cwv3GXk0n/mYI4XiC1YfEuJnfhNedphfctJ327KC83r8YiDGb/sBkL+E
         XmUeJXLrY9YW/3OUjWA9vNqnCvnqNxrPg15pTeOicsw3EyemCxVJP4y1v7l++F+xEAOJ
         2su/h+SGAbOfp1TCEcaP+E8bUk2BQFUxLbYPsl3W8zNRYhyNQdQkm6aF1qWD1BxKDxb4
         KvaUN4IuTL+e3uuThg2ACcxOutr+PidsEjVo0kigDgA+GaX5R1S87jJUM6Wdlx4D2tfT
         DnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAbDl1PRM5nJcEKcI6Ytvs7hiGOzTQVF+JIk15dOA88=;
        b=bLU5B3IkKj/S/Kg3plMQFWLYIYB0ktNU++AHIZ9cDt9+SJXH8or183xzcrPfYvOZqC
         AIodbdQNUfcr8ouf5yfRWCFoUW19t+8HZZuBefmoQABkxj+UOB3QmeO3qpBaMylYgV5H
         /aGl56EFx21HSwxHvKtNDf0XcTRMAKTLSsUlEFKWZPPQOfnSHYiVReeRt90rds+pd2sJ
         abiApEkJEOfJpjLBoo7R4myz6umSfLGMmpU1CmUgd9u6WSbX+Vw8UGYemvbVAg4j8CgF
         mZGuYAEg1osLxKrlndebmBZme16UPE9xi5l3nu1h2x8GXCS30tZaePFDay3bdirQeegj
         jk5Q==
X-Gm-Message-State: AJIora94SG3yXinFRKSZHRSXewFTcGGqFL21yxj3b7D0OOhjKk5wx52U
        QjrYiQY1d+9ssCZdslySeFNGPrFmfXjkTiONm3In8Q==
X-Google-Smtp-Source: AGRyM1uiGKWRYqdXWTkzEYeZ3M32/orW5NzHDsHKznhO1+2vVhPaYRL6sJmL5DodgqnLocvJeqHO6XvZNDEU4APTl4g=
X-Received: by 2002:a5d:6c65:0:b0:21d:b7c0:9930 with SMTP id
 r5-20020a5d6c65000000b0021db7c09930mr23007398wrz.500.1658163110612; Mon, 18
 Jul 2022 09:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-12-kaleshsingh@google.com> <877d4a513o.wl-maz@kernel.org>
In-Reply-To: <877d4a513o.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 09:51:39 -0700
Message-ID: <CAC_TJvewAfGACxwZ57W+fDsXOYBNnjxaKUt3Es9Ou0vDO3H_0w@mail.gmail.com>
Subject: Re: [PATCH v4 11/18] KVM: arm64: Stub implementation of non-protected
 nVHE HYP stack unwinder
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

On Mon, Jul 18, 2022 at 12:31 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 15 Jul 2022 07:10:20 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Add stub implementations of non-protected nVHE stack unwinder, for
> > building. These are implemented later in this series.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/stacktrace/nvhe.h | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> > index 1eac4e57f2ae..36cf7858ddd8 100644
> > --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> > +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> > @@ -8,6 +8,12 @@
> >   *      the HYP memory. The stack is unwinded in EL2 and dumped to a shared
> >   *      buffer where the host can read and print the stacktrace.
> >   *
> > + *   2) Non-protected nVHE mode - the host can directly access the
> > + *      HYP stack pages and unwind the HYP stack in EL1. This saves having
> > + *      to allocate shared buffers for the host to read the unwinded
> > + *      stacktrace.
> > + *
> > + *
> >   * Copyright (C) 2022 Google LLC
> >   */
> >  #ifndef __ASM_STACKTRACE_NVHE_H
> > @@ -53,5 +59,21 @@ static int notrace unwind_next(struct unwind_state *state)
> >  NOKPROBE_SYMBOL(unwind_next);
> >  #endif       /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> >
> > +/*
> > + * Non-protected nVHE HYP stack unwinder
> > + */
> > +#else        /* !__KVM_NVHE_HYPERVISOR__ */
>
> I don't get this path. This either represents the VHE hypervisor or
> the kernel proper. Which one is it?

Hi Marc. This is run from kernel proper context. And it's the
unwinding for conventional nVHE (non-protected). The unwinding is done
from the host kernel in EL1.

>
> > +static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
> > +                                  struct stack_info *info)
> > +{
> > +     return false;
> > +}
> > +
> > +static int notrace unwind_next(struct unwind_state *state)
> > +{
> > +     return 0;
> > +}
> > +NOKPROBE_SYMBOL(unwind_next);
> > +
> >  #endif       /* __KVM_NVHE_HYPERVISOR__ */
> >  #endif       /* __ASM_STACKTRACE_NVHE_H */
>
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
