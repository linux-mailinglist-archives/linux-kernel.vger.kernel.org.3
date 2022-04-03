Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850B04F084F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiDCHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiDCHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F731938
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 00:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F70D60FBB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D521BC3410F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648972035;
        bh=2fdVKbobMSqU82IHflWVOl6H1mfzVoXAs6NIjaw3se4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dp6M5RlWJnVw5/1m4JEXy8W6x49/D+Z/2/ANpgG6S+vy9MeW6Uq1sd2zQSdt7MY2r
         EXqMqjVVY3+XNptd/x8H29PxAWaQD7nbqEAK0wG0ggFqxdLzhCMQmaE6Dho9i6J/cl
         Wz2/QFd7vPFMK1lXNfa3d6ZtwYe7guQHxa5puoO/cHp4mUcSX2JWjzo/u0ER4EzoKZ
         3Ig0yvQsWSkJhrm1TaZ/gk1Xqik4xk2I+bbXMEK+yVdwhRSnBuh4fkr2kcFVcofpnY
         g1GBy9VJo1wtn6ULGifleL8sCsXNvA2ntuDvVj7C/qXm3Q7uXKf3UVLAjRrZOuDezW
         kf9pmW5qa/vWA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-df0940c4eeso7240551fac.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 00:47:15 -0700 (PDT)
X-Gm-Message-State: AOAM533ngJLdk27CjWd43lFUrIatCoEPWRUjOHRly30wO+rMS+/891ys
        38mgox4RlEoBB6/7RLcrsbRegw0dO92p2K5k7bE=
X-Google-Smtp-Source: ABdhPJz7YxxXlTyDsE1PVhBYzWIbF9TeApCzjxSnaig71jypi/7/4srfRBoxCi/4QokhsBqR8nLstc99K2bj24mifG8=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr8447930oae.126.1648972034904; Sun, 03
 Apr 2022 00:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220401164406.61583-1-jeremy.linton@arm.com> <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
 <CA+=Sn1k23tzMKbMWKW7c3EBoXidJCT-k_k_oF_sKTsGLJTKTnw@mail.gmail.com>
In-Reply-To: <CA+=Sn1k23tzMKbMWKW7c3EBoXidJCT-k_k_oF_sKTsGLJTKTnw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 3 Apr 2022 09:47:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHMK8PNpXGayfO6qxkA1VdkXmkJdLh29fwSJyOG0ZnSGA@mail.gmail.com>
Message-ID: <CAMj1kXHMK8PNpXGayfO6qxkA1VdkXmkJdLh29fwSJyOG0ZnSGA@mail.gmail.com>
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

On Sun, 3 Apr 2022 at 09:38, Andrew Pinski <pinskia@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 10:24 AM Mark Rutland via Gcc <gcc@gcc.gnu.org> wrote:
> >
> > Hi Jeremy,
> >
> > Thanks for raising this.
> >
> > On Fri, Apr 01, 2022 at 11:44:06AM -0500, Jeremy Linton wrote:
> > > The relaxed variants of read/write macros are only declared
> > > as `asm volatile()` which forces the compiler to generate the
> > > instruction in the code path as intended. The only problem
> > > is that it doesn't also tell the compiler that there may
> > > be memory side effects. Meaning that if a function is comprised
> > > entirely of relaxed io operations, the compiler may think that
> > > it only has register side effects and doesn't need to be called.
> >
> > As I mentioned on a private mail, I don't think that reasoning above is
> > correct, and I think this is a miscompilation (i.e. a compiler bug).
> >
> > The important thing is that any `asm volatile` may have a side effects
> > generally outside of memory or GPRs, and whether the assembly contains a memory
> > load/store is immaterial. We should not need to add a memory clobber in order
> > to retain the volatile semantic.
> >
> > See:
> >
> >   https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
> >
> > ... and consider the x86 example that reads rdtsc, or an arm64 sequence like:
> >
> > | void do_sysreg_thing(void)
> > | {
> > |       unsigned long tmp;
> > |
> > |       tmp = read_sysreg(some_reg);
> > |       tmp |= SOME_BIT;
> > |       write_sysreg(some_reg);
> > | }
> >
> > ... where there's no memory that we should need to hazard against.
> >
> > This patch might workaround the issue, but I don't believe it is a correct fix.
>
> It might not be the most restricted fix but it is a fix.
> The best fix is to tell that you are writing to that location of memory.
> volatile asm does not do what you think it does.
> You didn't read further down about memory clobbers:
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers
> Specifically this part:
> The "memory" clobber tells the compiler that the assembly code
> performs memory reads or writes to items other than those listed in
> the input and output operands
>

So should we be using "m"(*addr) instead of "r"(addr) here?

(along with the appropriately sized casts)
