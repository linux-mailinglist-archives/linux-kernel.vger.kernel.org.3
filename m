Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0514246AE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377175AbhLFXtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:49:25 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58582 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhLFXtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:49:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 222AFCE18BD;
        Mon,  6 Dec 2021 23:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D65C004DD;
        Mon,  6 Dec 2021 23:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638834351;
        bh=TySh5B/Cii1z2FNxDY7Wd9x489sbcuXSqQQkwyfCvHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMZTvAW2n/rYcXQhEDQ/MjI3fsHc2VJgSHepZvrCLDoQq5nmWdb1ufDMMFxydTV4/
         QSIYCtlZ+O2c/7/kbgV2Bi+ZoLrPmQtOXt4HxF37KWS6h0lAgTcC4cNu0NHKyEmjsS
         tayMdC1b14T/WJHi+qJi9s47Ocy4doJFXuLdCf4ShBxkXXVB9+RWZtH/EIFAuvhEnF
         KGa96DNC8TpWGtT9RKfY8ablmmRnZu0qaBmCIwaHwLbOJYbrcKfh2I7u0msB/vSYqj
         7BXXnKoABxPBkWAW1D36rpdTOmF7X77KS2++XPXGcsymcu4AH0G1XEjhccCWSMX4GM
         jNETobf0KpFYg==
Date:   Mon, 6 Dec 2021 17:51:19 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Makefile: CC_IMPLICIT_FALLTHROUGH passed quoted as argument to
 gcc
Message-ID: <20211206235119.GA69673@embeddedor>
References: <YatpectAYsWnmPy2@eldamar.lan>
 <CAHk-=whTTWUyL5j5_-UeRT6k9VcJM_VOfjiKuU2NBJkxhbnXpw@mail.gmail.com>
 <CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com>
 <202112061128.6B670358@keescook>
 <Ya6IXWBGkN1iZI1b@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya6IXWBGkN1iZI1b@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:02:05PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Dec 06, 2021 at 11:53:41AM -0800, Kees Cook wrote:
> > On Sun, Dec 05, 2021 at 02:54:05AM +0900, Masahiro Yamada wrote:
> > > On Sun, Dec 5, 2021 at 1:53 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Sat, Dec 4, 2021 at 5:13 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
> > > > >
> > > > > Andreas suggested to replace the
> > > > >
> > > > > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> > > > >
> > > > > with
> > > > >
> > > > > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst "%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))
> > > >
> > > > Ugh. I think the external build environment is a bit broken, but
> > > > whatever. The above is ugly but I guess it works.
> > > >
> > > > Another alternative would be to make the Kconfig strings simply not
> > > > have '"' as part of them.
> > > >
> > > > When you do
> > > >
> > > >     a = "hello"
> > > >     print $a
> > > >
> > > > in any normal language, you generally wouldn't expect it to print the
> > > > quotes, it should just print the bare word.
> > > >
> > > > But that's what the Kconfig string language basically does in this
> > > > case. And I guess several users expect and take advantage of that ;(
> > > >
> > > > Masahiro? Comments?
> > > 
> > > Yes, you get to the point.
> > > 
> > > In fact, this is in my TODO list for a while
> > > (and this is the reason I was doing prerequisite Kconfig refactoring
> > > in the previous development cycle).
> > > I will try to find some spare time to complete this work.
> > > 
> > > 
> > > 
> > > Kconfig generates two similar files,
> > > 
> > >  -   .config
> > >  -   include/config/auto.conf
> > > 
> > > Changing the format of the .config is presumably problematic
> > > since it is the saved user configuration as well.
> > > 
> > > It is possible (and more reasonable) to change include/config/auto.conf
> > > so strings are not quoted.
> > > 
> > > In Makefiles, quotations are just normal characters; they have no
> > > special functionality.
> > > 
> > > So, in Makefile context, it is more handy to do
> > > 
> > >      CONFIG_X=foo bar
> > > 
> > > instead of
> > > 
> > >     CONFIG_X="foo bar"
> > > 
> > > 
> > > 
> > > One problem is include/config/auto.conf is included not only by Makefiles
> > > but also by shell scripts.
> > > 
> > > 
> > > In shell context, the right hand side must be quoted
> > > in case the value contains spaces.
> > > 
> > >    CONFIG_X="foo bar"
> > > 
> > > 
> > > 
> > > My plan is to fix
> > >   scripts/link-vmlinux.sh
> > >   scripts/gen_autoksyms.sh
> > > etc. to not directly include the auto.conf.
> > > Later, change Kconfig to generate the auto.conf without "".
> > > 
> > > 
> > > 
> > > In the meantime,
> > > 
> > > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(patsubst
> > > "%",%,$(CONFIG_CC_IMPLICIT_FALLTHROUGH))
> > > 
> > >  or if you prefer slightly shorter form,
> > > 
> > > KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
> > > 
> > > will be a workaround.
> > 
> > It'll be nice to get this fixed. There are a few places where there is
> > a test for a compiler flag in Kconfig, and then the option is repeated
> > in the Makefile, due to the above quoting issues. For example:
> > 
> > arch/arm64/Kconfig:
> > 	config CC_HAS_BRANCH_PROT_PAC_RET
> > 	     # GCC 9 or later, clang 8 or later
> > 	     def_bool $(cc-option,-mbranch-protection=pac-ret+leaf)
> > 
> > arch/arm64/Makefile:
> > 	branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
> > 
> > 
> > I like the $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%) solution: it's short.
> 
> Does the following look correct, as well from formal style/commit
> description? I have not yet done many contributions directly.
> 
> Regards,
> Salvatore
> 
> From c2d01ea3ee1c7cc539468bba5b25522245d513de Mon Sep 17 00:00:00 2001
> From: Salvatore Bonaccorso <carnil@debian.org>
> Date: Mon, 6 Dec 2021 21:42:01 +0100
> Subject: [PATCH] Makefile: Do not quote value for
>  CONFIG_CC_IMPLICIT_FALLTHROUGH
> 
> Andreas reported that a specific build environment for an external
> module, being a bit broken, does pass CC_IMPLICIT_FALLTHROUGH quoted as
> argument to gcc, causing an error
> 
> 	gcc-11: error: "-Wimplicit-fallthrough=5": linker input file not found: No such file or directory
> 
> Until this is more generally fixed as outlined in [1], by fixing
> scripts/link-vmlinux.sh, scripts/gen_autoksyms.sh, etc to not directly
> include the include/config/auto.conf, and in a second step, change
> Kconfig to generate the auto.conf without "", workaround the issue by
> explicitly unquoting CC_IMPLICIT_FALLTHROUGH.
> 
>  [1] https://lore.kernel.org/linux-kbuild/CAK7LNAR-VXwHFEJqCcrFDZj+_4+Xd6oynbj_0eS8N504_ydmyw@mail.gmail.com/
> 
> Reported-by: Andreas Beckmann <anbe@debian.org>
> Link: https://bugs.debian.org/1001083
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 8e35d7804fef..ef967a26bcd3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -789,7 +789,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  KBUILD_CFLAGS += $(stackp-flags-y)
>  
>  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
>  
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS += -Qunused-arguments
> -- 
> 2.34.1
> 
