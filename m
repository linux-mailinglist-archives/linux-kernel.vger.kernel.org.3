Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDC4943AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiASXJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344362AbiASXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:09:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B172C06173F;
        Wed, 19 Jan 2022 15:08:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28381614A2;
        Wed, 19 Jan 2022 23:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA78C004E1;
        Wed, 19 Jan 2022 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642633735;
        bh=QTKHn4Wool6GWwOwKqjEm+TWC3X4GTauJMrreTZbgTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+05iH4oJGO/396eleoANsH+yhRmco0H4a00oigax0iHe4MHaU8ILSVtBrV5RWu1x
         lLtI6+pOFijSa580nfnuce9ov/AcZivjrkkCHxjAB8OCQwQvrvMBH/n/waYhlkc+qh
         MpuNmbGUcGWDKSkDEgnB9GBVsV6zsWowznf79y94rJR7ssBEmpLfrXBoY3Fc73Fx1Z
         oZShqamcZUMETYt4sTheCRlIOWGQ2ngYVDQFZ29MrvUiEI6LgxfTIYzDqZ6plZlSyD
         RarvVr4Q3PuFtoZHVjd23UBNzZnrzEHx0+giKjMnyU1DdAtBY1Tik8Rz7AY3WpEOQf
         DKfIMCS3EPLnA==
Date:   Wed, 19 Jan 2022 16:08:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] Makefile: Fix build with scan-build
Message-ID: <YeiaAgQ+gbZYTMwD@archlinux-ax161>
References: <20220119135147.1859982-1-amadeuszx.slawinski@linux.intel.com>
 <YeiAa/eCxVZC+QbS@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeiAa/eCxVZC+QbS@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:19:39PM -0700, Nathan Chancellor wrote:
> On Wed, Jan 19, 2022 at 02:51:47PM +0100, Amadeusz Sławiński wrote:
> > When building kernel with scan-build for analysis:
> > $ scan-build make defconfig
> > $ scan-build make menuconfig # disable RETPOLINE
> > $ scan-build make -j16 bindeb-pkg
> > since commit 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
> > it fails with:
> >   CC      scripts/mod/empty.o
> > could not find clang line
> > make[4]: *** [scripts/Makefile.build:287: scripts/mod/empty.o] Error 1
> > 
> > Seems like changes to how -fconserve-stack support was detected broke
> > build with scan-build. Revert part of mentioned commit which changed
> > that.
> > 
> > Fixes: 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
> > CC: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> > Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> > ---
> >  Makefile | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 765115c99655..1174ccd182f5 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -991,9 +991,7 @@ KBUILD_CFLAGS	+= -fno-strict-overflow
> >  KBUILD_CFLAGS  += -fno-stack-check
> >  
> >  # conserve stack if available
> > -ifdef CONFIG_CC_IS_GCC
> > -KBUILD_CFLAGS   += -fconserve-stack
> > -endif
> > +KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
> >  
> >  # Prohibit date/time macros, which would make the build non-deterministic
> >  KBUILD_CFLAGS   += -Werror=date-time
> > -- 
> > 2.25.1
> > 
> 
> Okay, I think I understand why this happens...
> 
> scan-build points CC to its CC wrapper [1], ccc-analyzer, which builds the
> code with a compiler [2] then runs clang for the static analyzer [3].
> The problem is that the default compiler for ccc-analyzer is GCC, which
> means that CONFIG_CC_IS_GCC gets set and flags that are supported by GCC
> but not clang will cause the clang analyzer part of ccc-analyzer to
> error because ccc-analyzer just passes all '-f' flags along [4].
> 
> Prior to 7d73c3e9c514, there was no error because cc-option would run
> the flag against ccc-analyzer, which would error out for the reason I
> just described, which would prevent the flag from getting added to
> KBUILD_CFLAGS.
> 
> Now, -fconserve-stack gets passed along to both gcc and clang but clang
> does not recognize it and errors out.
> 
> This should be fixed in clang, which already has the machinery to
> recognize but ignore GCC flags for compatibility reasons (which is
> probably how gcc and clang can use the same flags). I have pushed a
> patch to Phabricator for review:
> 
> https://reviews.llvm.org/D117717
> 
> You need to disable CONFIG_RETPOLINE for the same reason but I don't
> think working around that in clang is as simple.
> 
> Until that fix can proliferate through distributions and such, this is
> not an unreasonable workaround (unless Masahiro or Nick have a better
> idea) but I would really like a comment so that we can revert this once
> that fix is more widely available (it is unlikely that clang will
> actually support this option).
> 
> [1]: https://github.com/llvm/llvm-project/blob/3062a1469da0569e714aa4634b29345f6d8c874c/clang/tools/scan-build/bin/scan-build#L1080
> [2]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece721df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L457
> [3]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece721df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L783
> [4]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece721df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L661-L665

Thinking more about this after Fangrui commented on the clang patch
above, using scan-build with GCC as the compiler is going to be hard to
support, as we are basically trying to support using two different
compilers with a unified set of '-f' flags, which I see as problematic
for a few reasons.

1. It restricts our ability to do cc-option cleanups like Nick did.

We should be eliminating cc-option calls that we know are specific to
one compiler because checking the Kconfig variables (CONFIG_CC_IS_...)
is much cheaper than invoking the compiler.

2. Necessary GCC specific flags will get dropped.

Adding back the call to cc-option will allow the build to succeed but it
drops the flag from KBUILD_CFLAGS. If there were ever a time where an
'-f' flag was needed to get a working kernel with GCC, it would not get
added because clang would reject it.

We already have a static-analyzer target that requires using CC=clang so
I think there is some precedent here to say we require the kernel to be
built with clang to use the static analyzer. The fact that it did prior
to 7d73c3e9c514 can just be chalked up to luck.

$ make -j"$(nproc)" LLVM=1 defconfig bindeb-pkg static-analyzer

would be the equivalent command to the original patch.

You can still use scan-build with the '--use-cc=clang' flag, which will
use clang for the compilation and analysis, if you so prefer.

Masahiro and Nick may have further thoughts and I am open to other
opinions but my vote is to say this is an issue we won't fix or
workaround.

Cheers,
Nathan
