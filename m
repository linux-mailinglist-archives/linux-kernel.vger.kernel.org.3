Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD449426F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 22:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357380AbiASVTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 16:19:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45112 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357364AbiASVTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 16:19:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4E78B81911;
        Wed, 19 Jan 2022 21:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3949C004E1;
        Wed, 19 Jan 2022 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642627184;
        bh=rDBAnFk6DtskFzUgU67bbBE23M0Z4VZbBDCK8RsVWHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbX9wnTelCF2Npo6lzljQ9/WleD2L6+9VdFH2ul05p9mj69dYgKddHvG1wjdVFrrr
         xvlv7hYQrM0ZbIDxZaTqcWHgnSY7BOl47u6ZDnwTdu7pm+CRE37IokCNJeMaecZTRe
         J8lbxgnvG/Ga5hzhsSJAeUyq8sFVgrIVDTwT3hQST5DV5LubwSrTCR2cE/Cd1vRzih
         I1q+4VjuQbAr9x27NzcN17ekUnIH9VhSUMpOxZ2xCcelyy124XFlr2A2l4r6wz7bzB
         Jj3bTrnuJ4i0WdPiB+1SQmQPH8YM68nYCn9I0Xd6ZLon4XGIxnFYh4pdWtKRJx/UQE
         VKIzWE13rBsmw==
Date:   Wed, 19 Jan 2022 14:19:39 -0700
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
Message-ID: <YeiAa/eCxVZC+QbS@archlinux-ax161>
References: <20220119135147.1859982-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119135147.1859982-1-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:51:47PM +0100, Amadeusz Sławiński wrote:
> When building kernel with scan-build for analysis:
> $ scan-build make defconfig
> $ scan-build make menuconfig # disable RETPOLINE
> $ scan-build make -j16 bindeb-pkg
> since commit 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
> it fails with:
>   CC      scripts/mod/empty.o
> could not find clang line
> make[4]: *** [scripts/Makefile.build:287: scripts/mod/empty.o] Error 1
> 
> Seems like changes to how -fconserve-stack support was detected broke
> build with scan-build. Revert part of mentioned commit which changed
> that.
> 
> Fixes: 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
> CC: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 765115c99655..1174ccd182f5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -991,9 +991,7 @@ KBUILD_CFLAGS	+= -fno-strict-overflow
>  KBUILD_CFLAGS  += -fno-stack-check
>  
>  # conserve stack if available
> -ifdef CONFIG_CC_IS_GCC
> -KBUILD_CFLAGS   += -fconserve-stack
> -endif
> +KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
>  
>  # Prohibit date/time macros, which would make the build non-deterministic
>  KBUILD_CFLAGS   += -Werror=date-time
> -- 
> 2.25.1
> 

Okay, I think I understand why this happens...

scan-build points CC to its CC wrapper [1], ccc-analyzer, which builds the
code with a compiler [2] then runs clang for the static analyzer [3].
The problem is that the default compiler for ccc-analyzer is GCC, which
means that CONFIG_CC_IS_GCC gets set and flags that are supported by GCC
but not clang will cause the clang analyzer part of ccc-analyzer to
error because ccc-analyzer just passes all '-f' flags along [4].

Prior to 7d73c3e9c514, there was no error because cc-option would run
the flag against ccc-analyzer, which would error out for the reason I
just described, which would prevent the flag from getting added to
KBUILD_CFLAGS.

Now, -fconserve-stack gets passed along to both gcc and clang but clang
does not recognize it and errors out.

This should be fixed in clang, which already has the machinery to
recognize but ignore GCC flags for compatibility reasons (which is
probably how gcc and clang can use the same flags). I have pushed a
patch to Phabricator for review:

https://reviews.llvm.org/D117717

You need to disable CONFIG_RETPOLINE for the same reason but I don't
think working around that in clang is as simple.

Until that fix can proliferate through distributions and such, this is
not an unreasonable workaround (unless Masahiro or Nick have a better
idea) but I would really like a comment so that we can revert this once
that fix is more widely available (it is unlikely that clang will
actually support this option).

[1]: https://github.com/llvm/llvm-project/blob/3062a1469da0569e714aa4634b29345f6d8c874c/clang/tools/scan-build/bin/scan-build#L1080
[2]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece721df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L457
[3]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece721df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L783
[4]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece721df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L661-L665

Cheers,
Nathan
