Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF64522788
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiEJXYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiEJXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:24:50 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F32802F5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:24:46 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id m128so745283ybm.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GokfEYQ6AnMfT1CyMpbI+Gftvn5q5QVicSRCEy9ThmQ=;
        b=Q9tCJA2T6C9b2tpdFN8wDgedg4W5ApdcgtHSoUkVHqXmIxIhFDHQr7rR6qnnKLCYFg
         ALB9bfpLMwtPK4Zyt48VzPrZw3HY5RAAsrIfEQn4znYcnZ5fgvms92PPfBHY1dLR+hF9
         VRN5kEn7i7hDhI0aLEbmDX/X4RWBk3m2mYQ2vu6cJCC8/EBTWz9/hfX6d69Kk46yFqko
         musukmqMHvhWXboWGxCYqess250Thvln/40tKfdzRHScJf/qx5NymTvSc8ggx1vtFtzt
         NnetJL3P3zkThmMBKVuBcWCq1HsC5QqHUaonc3VBtOKp9rIypfAeLnVemfVQJ1t1tOBW
         3yCA==
X-Gm-Message-State: AOAM530MADjnfmZIRAqjlSFgOWg5a6h8LU4Tkm4nkoFqWhI0imcmxr/N
        litEHmEKhT+vIPC8auKT4HCsfzvMwuWhXmnC/Rw=
X-Google-Smtp-Source: ABdhPJwE8F5hcuKqkn4TMhkA3oM9+LLKYIdOYQg8ptuz+R9ZAxiIkoj9TzqpxOc5KyK8ccrijzGmHwh61Ye2VR+W/pc=
X-Received: by 2002:a25:76c6:0:b0:648:5616:ca50 with SMTP id
 r189-20020a2576c6000000b006485616ca50mr22374768ybc.423.1652225085812; Tue, 10
 May 2022 16:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220510142550.1686866-1-mailhol.vincent@wanadoo.fr> <CAKwvOdnShyGvW9cuDuqQS+uvY7DHSmh8-55R1Bx_dxej8YQRHg@mail.gmail.com>
In-Reply-To: <CAKwvOdnShyGvW9cuDuqQS+uvY7DHSmh8-55R1Bx_dxej8YQRHg@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 11 May 2022 08:24:34 +0900
Message-ID: <CAMZ6RqKD9O8OHVUGCOYK1BXm7SCOkWbxCsSb=6jjfzgKn61JEw@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 11 May 2022 at 07:14, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Tue, May 10, 2022 at 7:26 AM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > The compilers provides some builtin expression equivalent to the
> > ffs(), __ffs() and ffz() function of the kernel. The kernel uses
> > optimized assembly which produces better code than the builtin
> > functions. However, such assembly code can not be optimized when used
> > on constant expression.
> >
> > This series relies on __builtin_constant_p to select the optimal solution:
> >
> >   * use kernel assembly for non constant expressions
> >
> >   * use compiler's __builtin function for constant expressions.
> >
> > I also think that the fls() and fls64() can be optimized in a similar
> > way, using __builtin_ctz() and __builtin_ctzll() but it is a bit less
> > trivial so I want to focus on this series first. If it get accepted, I
> > will then work on those two additionnal function.
> >
> >
> > ** Statistics **
> >
> > On a allyesconfig, before applying this series, I get:
> >
> > | $ objdump -d vmlinux.o | grep bsf | wc -l
> > | 1081
> >
> > After applying this series:
> >
> > | $ objdump -d vmlinux.o | grep bsf | wc -l
> > | 792
> >
> > So, roughly 26.7% of the call to either ffs() or __ffs() were using
> > constant expression and can be optimized (I did not produce the
> > figures for ffz()).
>
> These stats are interesting; consider putting them on patch 1/2 commit
> message though (in addition to the cover letter). (Sending thoughts on
> 1/2 next).

The fact is that patch 1/2 changes ffs() and patch 2/2 changes
__ffs(). For v2, I will run the stats on each patch separately in
order not to mix the results.

> >
> > (tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)
>
> Here's the same measure of x86_64 allyesconfig (./scripts/config -d
> CONFIG_HINIC) at 9be9ed2612b5aedb52a2c240edb1630b6b743cb6 with ToT
> LLVM (~clang-15):
>
> Before:
> $ objdump -d vmlinux.o | grep bsf | wc -l
> 1454
>
> After:
> $ objdump -d vmlinux.o | grep bsf | wc -l
> 1070
>
> -26.4% :)

Roughly same ratio. I am just surprise that the absolute number
are different:

  * GCC before: 1081, after 792
  * clang before 1454, after 1070

I wonder why clang produces more bsf instructions than GCC?

Also, on a side note, I am not the first one to realize that
__builtin_ffs() is able to optimize the constant variable. Some
people already used it to locally:

| $ git grep __builtin_ffs | wc -l
| 80

> >
> >
> > Vincent Mailhol (2):
> >   x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant
> >     expressions
> >   x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant
> >     expressions
> >
> >  arch/x86/include/asm/bitops.h | 65 +++++++++++++++++++++--------------
> >  1 file changed, 40 insertions(+), 25 deletions(-)
> >
> > --
> > 2.35.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
