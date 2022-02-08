Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0564AE504
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiBHWxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBHWx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:27 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9BDC0611DA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:53:23 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z19so724047lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGQ2IPV6y93QmCKVWOgR+8jhDK+XNZqO4ZZYPRVX6K0=;
        b=o0GsLaF8rSoqlEwVtFn5CHwH4SkjeN92qFP9V++vx3eCW33PyI0OQZ8qhqUY1gkOeU
         lPpQmG81Z/mZmykA9OSllst7yeuTcCbqqaoa9sqntHVbpQV2FwggqsFWKD5QY9H+xfjj
         tpghwlyu3ewKYXlFG4R0DlZvJIgT1wk9IRr8+WLSoFo0Bq9tYbmHsiLewGsvV4urSvNn
         xwtJcAwwZQuLrbxP01+lAIVMUd8GVN04Vgs46iD7cK5Rj06Z5JCfgh1xPC2W3G4Qg6wQ
         wr3ern0EUntvvTynJoLlK+uC5HE/ym9f/FxqsTgSczt93xSQ+mBoQz6yd3XoDP15s0E3
         mtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGQ2IPV6y93QmCKVWOgR+8jhDK+XNZqO4ZZYPRVX6K0=;
        b=oRq5KGvA9/5lHr0wRffkPn2jOiZkDaqh3cHGD2d7v5x4ZbcS+NfCPrlw9WfeHbuAoM
         FAvzru2KBILq65XWXkm/iVjiF1rF7YkNeHKL6Fp4Hod3NzRKeDmna/V38k3Eb0JteXON
         iPDx643VxqngQUKZonlnK22VXDL/2NgTF0tghAs3I0PxMfeR8IHRk+jkh5Ub5T/puwA4
         c+JKCWB7TGumEMGOhdgTNrqUy7xYj7IodV+xuj30CDLCZwUsy3iLxMDyvhPqH2iQBxW3
         iXg2qT1xnVSvM2X3x7nDyTQXzSi+yB1UWe2/c4p0eklp0FsHMf7IX79K/fuVlm2MN0Om
         nheg==
X-Gm-Message-State: AOAM531uGp51l3fjp217kPl5RwvgFuN/g82Zo1jEO9omT+RFKKzLnIan
        wSic6LyX/n7yFj4kyIi2Y4pi/CmKvxEcK9yVsvocBA==
X-Google-Smtp-Source: ABdhPJyoy30+AdO8nclZ+JUPkL/E0gMcFKmU7OKM9AsJzTWIEQtVr08DBWi6Zziy8sPprYX5PFr61Gg7dIOw78F40vU=
X-Received: by 2002:ac2:5627:: with SMTP id b7mr4520644lff.489.1644360801254;
 Tue, 08 Feb 2022 14:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <20220201213542.2808035-1-quic_eberman@quicinc.com> <CAKwvOdmZHmihbf_mLyi=Ncf7FZjjSxxTsHZeaqxk4LKhMHs_iA@mail.gmail.com>
In-Reply-To: <CAKwvOdmZHmihbf_mLyi=Ncf7FZjjSxxTsHZeaqxk4LKhMHs_iA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Feb 2022 14:53:08 -0800
Message-ID: <CAKwvOdn0oi+3yEECXLaSzoAdW19SCvpn_8t6yB2wpJE+Fpoy5w@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add environment variables for userprogs flags
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Elliot Berman <quic_eberman@quicinc.com>
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

On Tue, Feb 1, 2022 at 1:38 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Feb 1, 2022 at 1:36 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> >
> > Allow additional arguments be passed to userprogs compilation.
> > Reproducible clang builds need to provide a sysroot and gcc path to
> > ensure same toolchain is used across hosts. KCFLAGS is not currently
>
> ^ ensure the same (maybe Masahiro can fix that up locally when applying)

Masahiro,
What are your thoughts on this patch?  I think this would help Android
define a musl or bionic sysroot for CC_CAN_LINK and ultimately
UAPI_HEADER_TEST support.

>
> > used for any user programs compilation, so add new USERCFLAGS and
> > USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
> >
> > Clang 13+ might detect GCC installation on hosts which have it installed
> > to a default location in /. With addition of these environment
> > variables, you can specify flags such as:
> >
> > $ make USERCFLAGS=--sysroot=/path/to/sysroot
> >
> > This can also be used to specify different sysroots such as musl or
> > bionic which may be installed on the host in paths that the compiler
> > may not search by default.
> >
> > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >
> > Changes since v2:
> >  - Incorporated Nick's suggestions:
> >    - Addressed docs and commit text comments
> >    - Introduced KBUILD_USERHOSTCFLAGS as suggested
> >
> >  Documentation/kbuild/kbuild.rst    | 11 +++++++++++
> >  Documentation/kbuild/makefiles.rst |  2 ++
> >  Makefile                           | 10 ++++++----
> >  init/Kconfig                       |  8 ++++----
> >  usr/include/Makefile               |  3 +++
> >  5 files changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> > index 2d1fc03d346e..ef19b9c13523 100644
> > --- a/Documentation/kbuild/kbuild.rst
> > +++ b/Documentation/kbuild/kbuild.rst
> > @@ -77,6 +77,17 @@ HOSTLDLIBS
> >  ----------
> >  Additional libraries to link against when building host programs.
> >
> > +.. _userkbuildflags:
> > +
> > +USERCFLAGS
> > +----------
> > +Additional options used for $(CC) when compiling userprogs.
> > +
> > +USERLDFLAGS
> > +-----------
> > +Additional options used for $(LD) when linking userprogs. userprogs are linked
> > +with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
> > +
> >  KBUILD_KCONFIG
> >  --------------
> >  Set the top-level Kconfig file to the value of this environment
> > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> > index b008b90b92c9..11a296e52d68 100644
> > --- a/Documentation/kbuild/makefiles.rst
> > +++ b/Documentation/kbuild/makefiles.rst
> > @@ -982,6 +982,8 @@ The syntax is quite similar. The difference is to use "userprogs" instead of
> >
> >         When linking bpfilter_umh, it will be passed the extra option -static.
> >
> > +       From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
> > +
> >  5.4 When userspace programs are actually built
> >  ----------------------------------------------
> >
> > diff --git a/Makefile b/Makefile
> > index 45278d508d81..1d0172449355 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -431,11 +431,12 @@ HOSTCC    = gcc
> >  HOSTCXX        = g++
> >  endif
> >
> > -export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> > -                             -O2 -fomit-frame-pointer -std=gnu89
> > -export KBUILD_USERLDFLAGS :=
> > +KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> > +                        -O2 -fomit-frame-pointer -std=gnu89
> > +KBUILD_USERCFLAGS  := $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
> > +KBUILD_USERLDFLAGS := $(USERLDFLAGS)
> >
> > -KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> > +KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> >  KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> >  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> >  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
> > @@ -530,6 +531,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
> >  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> > +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
> >
> >  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
> >  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> > diff --git a/init/Kconfig b/init/Kconfig
> > index f2ae41e6717f..164706c38e8b 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -62,13 +62,13 @@ config LLD_VERSION
> >
> >  config CC_CAN_LINK
> >         bool
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag))
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
> >
> >  config CC_CAN_LINK_STATIC
> >         bool
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
> > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
> > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
> >
> >  config CC_HAS_ASM_GOTO
> >         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> > diff --git a/usr/include/Makefile b/usr/include/Makefile
> > index 1c2ae1368079..0322e567dc1e 100644
> > --- a/usr/include/Makefile
> > +++ b/usr/include/Makefile
> > @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
> >  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
> >  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
> >
> > +# USERCFLAGS might contain sysroot location for CC.
> > +UAPI_CFLAGS += $(USERCFLAGS)
> > +
> >  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
> >
> >  # The following are excluded for now because they fail to build.
> > --
> > 2.25.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
