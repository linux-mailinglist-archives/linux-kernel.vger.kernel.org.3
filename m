Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106104F0852
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355454AbiDCHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiDCHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:49:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827E326DE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 00:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A2C3B80CC8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385FFC340F3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648972079;
        bh=gv488O7AdKCxaTjXuETp7e6E7ScOgsUjyOHozGyfsvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p3nzTIuPj77POs4/oZkeh9aijPWSA+KbC7C7E3cdQwOZFEJkPQ+Ul2MVY29MGwrO0
         SZfHz+zdlIPHpNMhvqa+aozOug3yQF7PYl3a48av9sP9xwmC9kTgLNYZTQbSaXn8Eq
         9jTIkEqrhWrgeP2Xqyywof/gaMp0Grs5nDu6YLuKAmeDerGGqEYcAQSCSqgYztZcjV
         Rqu9yQxvpvSRIdYNDOlD/QE15m6X2Fv2vqABSQosAfJ8XJ31+m5m5lcj0LJFnuPDks
         xlbK5bYzyMTGZ/GjxLUgyuZfeB0D6N6sp/rTVdDSwFA8jwyfE4YjvtZZZBfkXWcraq
         /aJxO0m0XjHYQ==
Received: by mail-oi1-f172.google.com with SMTP id q189so7048450oia.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 00:47:59 -0700 (PDT)
X-Gm-Message-State: AOAM533zSr4SKZbzaUQ6axkHTeUk78PWCr80t4ySACLSmtT5ME3d9lbk
        IszKqnWmUHPY7a0tBn9xv5RrjtjdkUrT/Kf5+yE=
X-Google-Smtp-Source: ABdhPJyecZ3ijnvGiqUCHQjydomXLCsvma78HXMGdjlkTjD3k6+gHbI8dMCqtBZHRy/1SdcaopVSu5rl0D5goCx77ug=
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id
 t22-20020a056808159600b002f75d89eec7mr8022807oiw.228.1648972078416; Sun, 03
 Apr 2022 00:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220401164406.61583-1-jeremy.linton@arm.com> <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
 <CA+=Sn1k23tzMKbMWKW7c3EBoXidJCT-k_k_oF_sKTsGLJTKTnw@mail.gmail.com> <CAMj1kXHMK8PNpXGayfO6qxkA1VdkXmkJdLh29fwSJyOG0ZnSGA@mail.gmail.com>
In-Reply-To: <CAMj1kXHMK8PNpXGayfO6qxkA1VdkXmkJdLh29fwSJyOG0ZnSGA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 3 Apr 2022 09:47:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGpWNJSQ6My5EM1ctHgH3WDjTqLwVocxjmiNzK7hBYhBQ@mail.gmail.com>
Message-ID: <CAMj1kXGpWNJSQ6My5EM1ctHgH3WDjTqLwVocxjmiNzK7hBYhBQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/io: Remind compiler that there is a memory side effect
To:     Andrew Pinski <pinskia@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        GCC Mailing List <gcc@gcc.gnu.org>, f.fainelli@gmail.com,
        maz@kernel.org, marcan@marcan.st,
        LKML <linux-kernel@vger.kernel.org>, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2022 at 09:47, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 3 Apr 2022 at 09:38, Andrew Pinski <pinskia@gmail.com> wrote:
> >
> > On Fri, Apr 1, 2022 at 10:24 AM Mark Rutland via Gcc <gcc@gcc.gnu.org> wrote:
> > >
> > > Hi Jeremy,
> > >
> > > Thanks for raising this.
> > >
> > > On Fri, Apr 01, 2022 at 11:44:06AM -0500, Jeremy Linton wrote:
> > > > The relaxed variants of read/write macros are only declared
> > > > as `asm volatile()` which forces the compiler to generate the
> > > > instruction in the code path as intended. The only problem
> > > > is that it doesn't also tell the compiler that there may
> > > > be memory side effects. Meaning that if a function is comprised
> > > > entirely of relaxed io operations, the compiler may think that
> > > > it only has register side effects and doesn't need to be called.
> > >
> > > As I mentioned on a private mail, I don't think that reasoning above is
> > > correct, and I think this is a miscompilation (i.e. a compiler bug).
> > >
> > > The important thing is that any `asm volatile` may have a side effects
> > > generally outside of memory or GPRs, and whether the assembly contains a memory
> > > load/store is immaterial. We should not need to add a memory clobber in order
> > > to retain the volatile semantic.
> > >
> > > See:
> > >
> > >   https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
> > >
> > > ... and consider the x86 example that reads rdtsc, or an arm64 sequence like:
> > >
> > > | void do_sysreg_thing(void)
> > > | {
> > > |       unsigned long tmp;
> > > |
> > > |       tmp = read_sysreg(some_reg);
> > > |       tmp |= SOME_BIT;
> > > |       write_sysreg(some_reg);
> > > | }
> > >
> > > ... where there's no memory that we should need to hazard against.
> > >
> > > This patch might workaround the issue, but I don't believe it is a correct fix.
> >
> > It might not be the most restricted fix but it is a fix.
> > The best fix is to tell that you are writing to that location of memory.
> > volatile asm does not do what you think it does.
> > You didn't read further down about memory clobbers:
> > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers
> > Specifically this part:
> > The "memory" clobber tells the compiler that the assembly code
> > performs memory reads or writes to items other than those listed in
> > the input and output operands
> >
>
> So should we be using "m"(*addr) instead of "r"(addr) here?
>
> (along with the appropriately sized casts)

I mean "=m" not "m"
