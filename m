Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAA346ADCA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376648AbhLFW6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376864AbhLFW5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:57:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992BC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:54:18 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f125so11940841pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pNo4IfZlV3J4pS3tbYIeKamcl57Bc4Ek2OWv5IwnAaY=;
        b=PBC7aJPAt7hOkjKH6srXe0pQKBcbGLudTwJCoTmKf05RQPtYp2fp6keA9kjd3znXGe
         RW1IBU8smdbZ+dxuxoIngI+SJs9rkPEN/RQPX9bdlR7soU83g4OTDSj8/O5QzP0nl0WF
         2i562tsDog2ui5nBp8A7mLvtAEfZafGKhHxL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNo4IfZlV3J4pS3tbYIeKamcl57Bc4Ek2OWv5IwnAaY=;
        b=ttRrSYJ6J+PrAOsA3c8lXfei+pU0XB/attmcZxFUpD4H9MHXFWBqUz8KuE5vwCZ7xJ
         XwdOp3y3PwHJe3rYrir/7e+AaPwtza68MhFgKEHHnoQnjB748ZTnwSzPAZbD+wYJjV5J
         rsGUvRcKNh26qFByAidW78yHBfizUENAzC9ty6LMuO2XkthmsFGvqK7Q0/dGp05oz2j5
         BAV18AR4HRPjFxyBaKPvc1sCEkuF8dz8gEMtwjSS27DoSXcnqK4qR/RYIxsZjuM4dDtH
         n2VEkPyLSwbCZjaSS5s9rFmQEXiudjTcStp4C4MFVc/YVCbpGjN28rD+QSISPl6VQViU
         ykTg==
X-Gm-Message-State: AOAM533Mk0Hje/WrTrn/eILSjVdXwuP6GFxtxfWiVIv1Qn4RCi5Pu2Tx
        g+X0T7C18KKcdfG1IAQ9bDcSDQ==
X-Google-Smtp-Source: ABdhPJwRN5DiaXl8zfMv29z1JHsbcy56J3T2wC8JlWPgGqnoVni85BBce+QQmsjuL6CCytwgZWEiqg==
X-Received: by 2002:a05:6a00:189d:b0:4ae:da96:e13e with SMTP id x29-20020a056a00189d00b004aeda96e13emr6239589pfh.77.1638831258185;
        Mon, 06 Dec 2021 14:54:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id rm10sm400633pjb.29.2021.12.06.14.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:54:17 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:54:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Makefile: CC_IMPLICIT_FALLTHROUGH passed quoted as argument to
 gcc
Message-ID: <202112061453.CF34EC9@keescook>
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

Looks good to me; thanks!

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

Reviewed-by: Kees Cook <keescook@chromium.org>

Does anyone have a preference as to who should take this? Gustavo,
Marahiro, me, or Linus directly?

-- 
Kees Cook
