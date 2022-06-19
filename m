Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F455097C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiFSJUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiFSJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:20:48 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9CCE39;
        Sun, 19 Jun 2022 02:20:46 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25J9KTZ7020525;
        Sun, 19 Jun 2022 18:20:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25J9KTZ7020525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655630430;
        bh=GzBeaOrv96WSl2HDC/koas/hAO2oAWJZ/5dV2u+o/r0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RmY0YDOPdNuheaj3OPET7lzMsgbRvrKH1xfeKyHVZVNdt2xJB2TuEz5mTaVQGvPXU
         HTumwsMXi28sKqgdSrwyw1ftJlaqncWUb4Te6BTQcd0icQ55RBp5Z24OdyO0ZH5ten
         VL9XZQylMU9A/aA3ZrtcvhUagUpwMbZSUsgrMfuAdRFuUhD0pcS1PIdwcBUHMs+TNJ
         oSCb6/sfzy9XqOH4GmQTeLjEFbdkxasbG9EZFzChb1Xlb/iAQOYcZLSAQPewxWz/l4
         tV3x5gmbL9TIabzUms+Fxih12gD/kUfuIWpskTEo7/h67qbBsA5jIjq1rRCYQAhWRc
         Tp4DxpELFNiMg==
X-Nifty-SrcIP: [209.85.128.51]
Received: by mail-wm1-f51.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso6358816wms.2;
        Sun, 19 Jun 2022 02:20:29 -0700 (PDT)
X-Gm-Message-State: AOAM532D6RrNTAU8lDr6cdvrOztzX4vu7L6xZz0wbauRrm/ji7bg7pT/
        Iba3LYaBzJQh6+ZclVQRs3+RUBsM2ywoUZupmAM=
X-Google-Smtp-Source: ABdhPJxn9y4W+QhCDeCZ/WYBNmRhqZFk+HIILMW5kaOE99XhNaA5pQ8dqiRBa/13TD+ldeHdPYND5r62z1AAprpnnWA=
X-Received: by 2002:a05:600c:a42:b0:39c:9086:8a34 with SMTP id
 c2-20020a05600c0a4200b0039c90868a34mr29027144wmq.169.1655630428366; Sun, 19
 Jun 2022 02:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220617203948.3714905-1-ndesaulniers@google.com>
 <Yq0MV2Z/hqSuSYbt@dev-arch.thelio-3990X> <CAKwvOdmUMhEe=nqyF-L08c7FL-NWus63JEe=G1MkboB47xjfsA@mail.gmail.com>
In-Reply-To: <CAKwvOdmUMhEe=nqyF-L08c7FL-NWus63JEe=G1MkboB47xjfsA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Jun 2022 18:19:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLXO44AKiJJ=XJDpESPpGyE_4YJqAiav926H2veWiWBw@mail.gmail.com>
Message-ID: <CAK7LNATLXO44AKiJJ=XJDpESPpGyE_4YJqAiav926H2veWiWBw@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.clang: set --target for host based on
 make -v
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 8:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jun 17, 2022 at 4:21 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Fri, Jun 17, 2022 at 01:39:48PM -0700, Nick Desaulniers wrote:
> > > We're working on providing statically linked images of clang to host on
> > > kernel.org. We're building them in Alpine Linux based Docker containers,
> > > which are MUSL based systems.
> > >
> > > In order to keep bootstrapping simpler, I'd like for them to have an
> > > implicit default --target of x86_64-alpine-linux-musl (set via LLVM's
> > > cmake variable LLVM_DEFAULT_TARGET_TRIPLE).
> > >
> > > Similarly, if one were to use a different build of clang meant for a
> > > glibc or bionic based system on a MUSL based host, we'd prefer to use
> > > the correct MUSL based triple for target hosts.
> > >
> > > Borrowed from the Zen of Python: Explicit is better than implicit. Let's
> > > be explicit about the target triple for HOSTCC when building with
> > > HOSTCC=clang or LLVM=1.


If people try to use the clang packaged by you,
I think the same thing will occur on any project.

I do not understand why you are trying to patch the kernel build?


If this is a problem, it is specific to your clang package,
not to the linux kernel.

You need to find a solution in your package.





> > >
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I have tested this with a few different distributions on both aarch64
> > and x86_64:
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> >
> > One small comment below.
> >
> > > ---
> > >  Makefile               |  3 +--
> > >  scripts/Makefile.clang | 10 ++++++++++
> > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 1a6678d817bd..87712d9b043c 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -600,10 +600,9 @@ endif
> > >  # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
> > >  # and from include/config/auto.conf.cmd to detect the compiler upgrade.
> > >  CC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(CC) --version 2>/dev/null | head -n 1))
> > > +HOSTCC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(HOSTCC) --version 2>/dev/null | head -n 1))
> > >
> > > -ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
> > >  include $(srctree)/scripts/Makefile.clang
> > > -endif
> > >
> > >  # Include this also for config targets because some architectures need
> > >  # cc-cross-prefix to determine CROSS_COMPILE.
> > > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > > index 87285b76adb2..a4505cd62d7b 100644
> > > --- a/scripts/Makefile.clang
> > > +++ b/scripts/Makefile.clang
> > > @@ -1,3 +1,4 @@
> > > +ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
> > >  # Individual arch/{arch}/Makefiles should use -EL/-EB to set intended
> > >  # endianness and -m32/-m64 to set word size based on Kconfigs instead of
> > >  # relying on the target triple.
> > > @@ -39,3 +40,12 @@ CLANG_FLAGS        += -Werror=ignored-optimization-argument
> > >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> > >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> > >  export CLANG_FLAGS
> > > +endif
> > > +
> > > +# If HOSTCC is clang, set the host target triple explicitly; do not rely on
> > > +# implicit defaults.
> > > +ifneq ($(findstring clang,$(HOSTCC_VERSION_TEXT)),)
> > > +HOST_TRIPLE          := --target=$(shell make --version | head -n2 | tail -n1 | cut -d ' ' -f 3)
> >
> > Should we use $(MAKE) instead of make here? I guess the only case where
>
> oh! yeah, good call. I think so.  Will wait until next Tuesday
> (Juneteenth holiday in the US on Monday) to send a v2. Thanks for
> taking a look!
>
> > it would matter is if someone was calling make via an explicit path and
> > did not have it available in their PATH so maybe it is not worth
> > worrying about.
> >
> > > +KBUILD_HOSTCFLAGS    += $(HOST_TRIPLE)
> > > +KBUILD_HOSTLDFLAGS   += $(HOST_TRIPLE)
> > > +endif
> > >
> > > base-commit: 79fe0f863f920c5fcf9dea61676742f813f0b7a6
> > > --
> > > 2.36.1.476.g0c4daa206d-goog
> > >
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards
Masahiro Yamada
