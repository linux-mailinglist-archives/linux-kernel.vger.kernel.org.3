Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BB5500BB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383686AbiFQX0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383500AbiFQX0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:26:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427C663F4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:26:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i29so9011514lfp.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXgpKpIVzT6qnZVCgCn3/+ZdUQI+LHK0/bEVe7Lb4mY=;
        b=hldD5704PosVIx7pUYS/I5Fkd39xNzHxffHQ4mZN1Dqeeuu2C4pwCxAQJNgtGLYwk9
         w7FJIcrUIRSS7x7h7nxefPG9ErzMKZMCYjFXnwB6jDP9vW9l7w3v44r21dvY+UO/roaH
         DuoO8nTSDMIPRijv/rUkB+5O/ifpxQW5EsEk/kcxRq9igUh8BEY3NEIxapGHRXPEivrV
         mEubtXEvlefXACss71A3Yow9/ml9N4sTH4bxhcrDrh4VpAU+l17QlhYYZuNW98vzP9tg
         nWdM5nclxBc/2bwkBpTMkpG+KU30Q0CgYJD/wbMLZRWwW2OIMr9AzbNDc9dxSlEJaxPO
         Zx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXgpKpIVzT6qnZVCgCn3/+ZdUQI+LHK0/bEVe7Lb4mY=;
        b=UaDvSB5kCCV49FSs6LZLz8cDlG4cpYTKFFr8G1zVRlMRjTb4Il5Bcl/HDpWXlE7miu
         +MV6Eca/9lG3pTmA6lDqrLuhPvlzhtVZWQGNJOql3We0b/DRztAOhWSBR88kPt87w6Rm
         tR3ZFGXOw5F6pXEnFFjz983m8bsIR1zXQydMYJCCYZvvWgyHq+S6hT4jdbBmjUoJp9nE
         Xgn/0I8h+LYNocZxtY4/czT4WQHfkYC2c0xZSfoGwFNh9Cgn0Q+dBqeldoboVRJmBtve
         M6zR2YMOdSGhHKm4ozQXIaBZV50Vj6xM0G4z9njRDuQxCnxpFOaAvaFmQ3OiJbgz8lR5
         kiog==
X-Gm-Message-State: AJIora8hnM/k562TKiGtdYwkuX1rygsc5Vp9UmVHSM+E1+GEGUebTgGd
        gu1EnKPhuwvWMK91TLNdOCGAxDrGVjHkfHrgB/H5vA==
X-Google-Smtp-Source: AGRyM1vuSCrUYcJ+fn+AGYw7Otfa1ERbN93s/Se2G5Qnqe8WDMwXm36GodOORpoZgx9wT9vyGeqywndfeQfffGCwypI=
X-Received: by 2002:a05:6512:3f9f:b0:47d:c87e:f8f3 with SMTP id
 x31-20020a0565123f9f00b0047dc87ef8f3mr7012832lfa.401.1655508374233; Fri, 17
 Jun 2022 16:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220617203948.3714905-1-ndesaulniers@google.com> <Yq0MV2Z/hqSuSYbt@dev-arch.thelio-3990X>
In-Reply-To: <Yq0MV2Z/hqSuSYbt@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Jun 2022 16:26:02 -0700
Message-ID: <CAKwvOdmUMhEe=nqyF-L08c7FL-NWus63JEe=G1MkboB47xjfsA@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.clang: set --target for host based on
 make -v
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 4:21 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Jun 17, 2022 at 01:39:48PM -0700, Nick Desaulniers wrote:
> > We're working on providing statically linked images of clang to host on
> > kernel.org. We're building them in Alpine Linux based Docker containers,
> > which are MUSL based systems.
> >
> > In order to keep bootstrapping simpler, I'd like for them to have an
> > implicit default --target of x86_64-alpine-linux-musl (set via LLVM's
> > cmake variable LLVM_DEFAULT_TARGET_TRIPLE).
> >
> > Similarly, if one were to use a different build of clang meant for a
> > glibc or bionic based system on a MUSL based host, we'd prefer to use
> > the correct MUSL based triple for target hosts.
> >
> > Borrowed from the Zen of Python: Explicit is better than implicit. Let's
> > be explicit about the target triple for HOSTCC when building with
> > HOSTCC=clang or LLVM=1.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I have tested this with a few different distributions on both aarch64
> and x86_64:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>
> One small comment below.
>
> > ---
> >  Makefile               |  3 +--
> >  scripts/Makefile.clang | 10 ++++++++++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 1a6678d817bd..87712d9b043c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -600,10 +600,9 @@ endif
> >  # CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
> >  # and from include/config/auto.conf.cmd to detect the compiler upgrade.
> >  CC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(CC) --version 2>/dev/null | head -n 1))
> > +HOSTCC_VERSION_TEXT = $(subst $(pound),,$(shell LC_ALL=C $(HOSTCC) --version 2>/dev/null | head -n 1))
> >
> > -ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
> >  include $(srctree)/scripts/Makefile.clang
> > -endif
> >
> >  # Include this also for config targets because some architectures need
> >  # cc-cross-prefix to determine CROSS_COMPILE.
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 87285b76adb2..a4505cd62d7b 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -1,3 +1,4 @@
> > +ifneq ($(findstring clang,$(CC_VERSION_TEXT)),)
> >  # Individual arch/{arch}/Makefiles should use -EL/-EB to set intended
> >  # endianness and -m32/-m64 to set word size based on Kconfigs instead of
> >  # relying on the target triple.
> > @@ -39,3 +40,12 @@ CLANG_FLAGS        += -Werror=ignored-optimization-argument
> >  KBUILD_CFLAGS        += $(CLANG_FLAGS)
> >  KBUILD_AFLAGS        += $(CLANG_FLAGS)
> >  export CLANG_FLAGS
> > +endif
> > +
> > +# If HOSTCC is clang, set the host target triple explicitly; do not rely on
> > +# implicit defaults.
> > +ifneq ($(findstring clang,$(HOSTCC_VERSION_TEXT)),)
> > +HOST_TRIPLE          := --target=$(shell make --version | head -n2 | tail -n1 | cut -d ' ' -f 3)
>
> Should we use $(MAKE) instead of make here? I guess the only case where

oh! yeah, good call. I think so.  Will wait until next Tuesday
(Juneteenth holiday in the US on Monday) to send a v2. Thanks for
taking a look!

> it would matter is if someone was calling make via an explicit path and
> did not have it available in their PATH so maybe it is not worth
> worrying about.
>
> > +KBUILD_HOSTCFLAGS    += $(HOST_TRIPLE)
> > +KBUILD_HOSTLDFLAGS   += $(HOST_TRIPLE)
> > +endif
> >
> > base-commit: 79fe0f863f920c5fcf9dea61676742f813f0b7a6
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
> >



-- 
Thanks,
~Nick Desaulniers
