Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FAD51F26D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiEIBcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiEHXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 19:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7BAE4C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4107660F10
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35C9C385A4;
        Sun,  8 May 2022 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652053894;
        bh=JxIt81fSqlUqVYbyW1jrVBaOtkLCBHv625E414LbXt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDLgSUrLYZD1UGkGluaOyvl+lDnASzFx1zpwANIkYSR3VbgaAR9+4+V1lLklDxpWY
         seL1wBh4N/t8BGTLexCx8ykiDZsxKrmwlhiE0EupkEgy2yObbM+V08FoFxxWhMj3fm
         mTciTAWrn32A8vLbSrsPD9cuA8yb8wuMH4MQ1qTR/RMlTjpGxBgkbgP4vWxTPSmrgK
         4N+kqvYVgEIztYD/umyondYo1oB66CTKZajvOM6EHN9FAzME1nYjoBev6LpHgYH2pa
         +dV8BECUVFuH5ilGApbVdaxImoFGDskSxsJCt2O67tJgmiPFjK25/oNAuyIgz9fEWO
         lZj3FNAfB2CKg==
Date:   Sun, 8 May 2022 16:51:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [RESEND PATCH v1] x86/build: add -fno-builtin flag to prevent
 shadowing
Message-ID: <YnhXgzhghfi17vMX@dev-arch.thelio-3990X>
References: <20220306171009.1973074-1-mailhol.vincent@wanadoo.fr>
 <20220508100907.61231-1-mailhol.vincent@wanadoo.fr>
 <CAK8P3a3Fw2T0WSkxv4DiTG2wGkKcs24StPx-BG_vi=ffa9OLVA@mail.gmail.com>
 <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqK9d0hFwYebaArKjod4LJVGQgfDygpbGdBu-4BCDUR_SA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 09:37:14PM +0900, Vincent MAILHOL wrote:
> Hi Arnd,
> 
> +CC: Kees Cook
> 
> On Sun. 8 May 2022 at 19:27, Arnd Bergmann <arnd@kernel.org> wrote:
> > On Sun, May 8, 2022 at 12:09 PM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > > Aside of the __builtin_foo() ones, x86 does not directly rely on any
> > > builtin functions.
> > >
> > > However, such builtin functions are not explicitly deactivated,
> > > creating some collisions, concrete example being ffs() from bitops.h,
> > > c.f.:
> > >
> > > | ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
> > > |   283 | static __always_inline int ffs(int x)
> > >
> > > This patch adds -fno-builtin to KBUILD_CFLAGS for the x86
> > > architectures in order to prevent shadowing of builtin functions.
> > >
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > ---
> > > FYI, I tested this patch on a "make allyesconfig" for both x86_32 and
> > > x86_64.
> > >
> > > This is a resend. Only difference is that I dropped the RFC flag and
> > > added Arnd in CC because he did a similar patch to fix ffs shadow
> > > warnings in the past:
> > >
> > > https://lore.kernel.org/all/20201026160006.3704027-1-arnd@kernel.org/
> >
> > I think this is a correct change, but unfortunately it exposes a clang bug
> >  with -mregparm=3. Nick should be able to provide more details, I think
> > he has a plan.
> 
> Interesting. I admittedly did not do extensive tests on clang
> but I would have expected the Linux kernel bot to have warned me
> on my previous patch.
> 
> I did research on mregparm and clang. I found this thread:
> https://lore.kernel.org/r/20220208225350.1331628-9-keescook@chromium.org
> 
> and the associated LLVM issue:
> https://github.com/llvm/llvm-project/issues/53645
> 
> Those threads mention that some clang builtins become unusable
> when combining -mregparm=3 and -m32. But I could not find a
> bug reference about -mregparm=3 and -fno-builtin combination.
> 
> Could you just double confirm that you indeed saw the issue with
> -fno-builtin? If that the case, I am really curious to get the
> details :)

-ffreestanding implies -fno-builtin; removing -ffreestanding from
arch/x86/Makefile for 32-bit x86 caused the problem so I don't think
that your patch would cause any issue but I could be missing something.

However, doesn't -fno-builtin remove the ability for GCC and clang to
perform certain libcall optimizations? I seem to recall this coming up
in previous threads but I am having a hard time finding the exact
language that I was looking for. This thread seems to be the most recent
one that I can remember:

https://lore.kernel.org/CAHk-=whn91ar+EbcBXQb9UXad00Q5WjU-TCB6UBzVba682a4ew@mail.gmail.com/

Cheers,
Nathan
