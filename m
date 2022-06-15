Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB354C53F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbiFOJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346430AbiFOJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9A2F000;
        Wed, 15 Jun 2022 02:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3124F61AEF;
        Wed, 15 Jun 2022 09:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E2CC341C4;
        Wed, 15 Jun 2022 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655287105;
        bh=olVZaX+Ei3ossRIrggwze0jxjL/US0T//Qz67+mOFlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jZJIPayWVQ5/uvWzTsXk2GXO2sVyZp2zdsdRMUBOukqLc1IJvMVxC0GaQ2CfhpOKX
         WjeadKesJaONRVFX79itG71aU0200AjMOnpXI7N8c68bZEbPsLzoxwX4iOM9M3J84n
         CfQ184wQ1twtbwyD1VuQgJULVP0q57ZSusCdvKHZu3VwQFB2jH9JzLVdk+ZlrCO0Bj
         7XazbzKbPITavSC3EUcGTRFEAzcAzF+c5m7wWhl2k6Io1g5rC+XDUhciy5htDzhO14
         rvpgWxFqRWz8p+mrURM0JD9B99S1qYSGcm15e+ThED14KICLunCWnZEZhBbjPpjz5b
         eHjauPt3FPg0A==
Received: by mail-oo1-f52.google.com with SMTP id g9-20020a4adc89000000b0041bef879199so1988856oou.10;
        Wed, 15 Jun 2022 02:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM532hEaS0giRS28MX2VnZ/qa9ZKC6UWP0ghiQZrK5U/pca7uwgU/7
        ZVAFRvStQw0jPUn7g3vzO0aeELYGQbNfhoOQgAQ=
X-Google-Smtp-Source: ABdhPJyVO70wdflNgGcNG4INXdvO9+iuiEhFxA1Fe2GqIaFaK/RQV7rXvy1v8tHKMlmWeDPRzw8DIAQ4EeSOeRiVcRc=
X-Received: by 2002:a4a:c983:0:b0:41b:9e6f:44ab with SMTP id
 u3-20020a4ac983000000b0041b9e6f44abmr3689475ooq.98.1655287104725; Wed, 15 Jun
 2022 02:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220608104512.1176209-1-ardb@kernel.org> <20220608104512.1176209-4-ardb@kernel.org>
 <Yqmr6fvu4OYkarCm@FVFF77S0Q05N>
In-Reply-To: <Yqmr6fvu4OYkarCm@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jun 2022 11:58:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGP0fyGp+iHR-xB0833-Mieo8UJb1V78ohG84kEpG+g=w@mail.gmail.com>
Message-ID: <CAMj1kXGP0fyGp+iHR-xB0833-Mieo8UJb1V78ohG84kEpG+g=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] jump_label: make initial NOP patching the special case
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 at 11:52, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jun 08, 2022 at 12:45:12PM +0200, Ard Biesheuvel wrote:
> > Instead of defaulting to patching NOP opcodes at init time, and leaving
> > it to the architectures to override this if this is not needed, switch
> > to a model where doing nothing is the default. This is the common case
> > by far, as only MIPS requires NOP patching at init time. On all other
> > architectures, the correct encodings are emitted by the compiler and so
> > no initial patching is needed.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  Documentation/staging/static-keys.rst |  3 ---
> >  arch/arc/kernel/jump_label.c          | 13 -------------
> >  arch/arm/kernel/jump_label.c          |  6 ------
> >  arch/arm64/kernel/jump_label.c        | 11 -----------
> >  arch/mips/include/asm/jump_label.h    |  2 ++
> >  arch/parisc/kernel/jump_label.c       | 11 -----------
> >  arch/riscv/kernel/jump_label.c        | 12 ------------
> >  arch/s390/kernel/jump_label.c         |  5 -----
> >  arch/x86/kernel/jump_label.c          | 13 -------------
> >  kernel/jump_label.c                   | 14 +++-----------
> >  10 files changed, 5 insertions(+), 85 deletions(-)
>
> I have one minor comment below, but either way this is a nice cleanup (and I'm
> always happy to see __weak functions disappear), so FWIW:
>
>   Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> [...]
>
> > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > index b1ac2948be79..ff8576c00893 100644
> > --- a/kernel/jump_label.c
> > +++ b/kernel/jump_label.c
> > @@ -332,17 +332,9 @@ static int __jump_label_text_reserved(struct jump_entry *iter_start,
> >       return 0;
> >  }
> >
> > -/*
> > - * Update code which is definitely not currently executing.
> > - * Architectures which need heavyweight synchronization to modify
> > - * running code can override this to make the non-live update case
> > - * cheaper.
> > - */
> > -void __weak __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
> > -                                         enum jump_label_type type)
> > -{
> > -     arch_jump_label_transform(entry, type);
> > -}
> > +#ifndef arch_jump_label_transform_static
> > +#define arch_jump_label_transform_static(entry, type)
> > +#endif
>
> It might be slightly better to make this a static inline stub so that we always
> get the compiler to type-check it, e.g.
>
> | #ifndef arch_jump_label_transform_static
> | static inline void arch_jump_label_transform_static(struct jump_entry *entry,
> |                                                   enum jump_label_type type)
> | {
> |       /* nothing to do on most architectures */
> | }
> | #define arch_jump_label_transform_static arch_jump_label_transform_static
> | #endif
>

Yeah, good point. Note that the current patch is broken because of
this, as the empty string is not a statement, and so the if binds to
the following line (I got a couple of bot warnings about this)
