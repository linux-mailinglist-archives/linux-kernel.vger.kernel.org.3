Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9CF4A6723
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiBAViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiBAViU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:38:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74353C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:38:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p27so36644448lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5lH9MhEDI/fH4JO2AjNw4VWZe37YGfztlIPMSyNebw=;
        b=hi+suNUqO4leQ1HIfCbFWcnJcoxAWW/Q+zn3N1VjRKX8gYJgw/DUxBq2iz/Lip64Bt
         oMOezjHarT6TBjJ6URjYNtH9izgGAn3LG6kJ2J4Q5bvEJyITWpQmyuYBwS502rldmZPj
         jhPq3xQEPhTC7aiHs4UA3iYi1M6nnKFy4K4xiOvTrHnrUTv/5nez5+kV1QGgYwETAPvd
         PjeLUPNeufRy0jF6TTaDv45iULXgAxWnSSxNYR2mzfoRh2hRpiMpJ4vfJSy6UqZGk0EL
         hvjsdTAkJ+mG0HqLDp+Zj74IOZkAZ6PyO5u4sqtOdM4SLxchHjhftQnEZfwsxOjUVSTl
         x4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5lH9MhEDI/fH4JO2AjNw4VWZe37YGfztlIPMSyNebw=;
        b=F2qYTz6LIGOBHmkhI4uu0RH79D6YNoKVBkPvk4VdL92dHbv/y6w/cnw1TCHjsnFf1p
         +RqmP5SI1lX9eOw7oHgCATxL05ZOppyV4ShLPdndeiLq1ZiMbMsIIMAxEdQ7+tEUnC8t
         80Wxs89Wus5rPKBcp79P2Fihj1yN6eiaxs+PYfqeUgu01357fT3DcWDEvv44rljqzlhj
         1wHsMg1jY4qkRzHIZXrv2L/OEC6CUJSE3LKr67b7ZrxNiBtUGFLmI4iTJoJI6WW4+Un6
         dqbzrhSdA4tc/6hh46XUSKdq3Hym1QT/VOG4ZL1W3mCxXISMCVf9yfulmWAzitzgcHK/
         Z9zw==
X-Gm-Message-State: AOAM533X//bSU7+x47PPzsnjcghNZn2EbzicYO821SkWLoLFsx+BejAb
        XcSCVHLzzSraIUOYqfOIaqWb08pYtuJi7zg0wvREbnQqN48=
X-Google-Smtp-Source: ABdhPJwly2lJ/2zpKteE8pXdSU5bn85KC+cPZ7btIf6V2eq3JYZQc63MVP1KKxWGQdEtLyvGBNbdj2GmKir4kuNI52c=
X-Received: by 2002:a19:6449:: with SMTP id b9mr20775601lfj.82.1643751498528;
 Tue, 01 Feb 2022 13:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com> <20220201213542.2808035-1-quic_eberman@quicinc.com>
In-Reply-To: <20220201213542.2808035-1-quic_eberman@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Feb 2022 13:38:06 -0800
Message-ID: <CAKwvOdmZHmihbf_mLyi=Ncf7FZjjSxxTsHZeaqxk4LKhMHs_iA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add environment variables for userprogs flags
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 1:36 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Allow additional arguments be passed to userprogs compilation.
> Reproducible clang builds need to provide a sysroot and gcc path to
> ensure same toolchain is used across hosts. KCFLAGS is not currently

^ ensure the same (maybe Masahiro can fix that up locally when applying)

> used for any user programs compilation, so add new USERCFLAGS and
> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>
> Clang 13+ might detect GCC installation on hosts which have it installed
> to a default location in /. With addition of these environment
> variables, you can specify flags such as:
>
> $ make USERCFLAGS=--sysroot=/path/to/sysroot
>
> This can also be used to specify different sysroots such as musl or
> bionic which may be installed on the host in paths that the compiler
> may not search by default.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes since v2:
>  - Incorporated Nick's suggestions:
>    - Addressed docs and commit text comments
>    - Introduced KBUILD_USERHOSTCFLAGS as suggested
>
>  Documentation/kbuild/kbuild.rst    | 11 +++++++++++
>  Documentation/kbuild/makefiles.rst |  2 ++
>  Makefile                           | 10 ++++++----
>  init/Kconfig                       |  8 ++++----
>  usr/include/Makefile               |  3 +++
>  5 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 2d1fc03d346e..ef19b9c13523 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -77,6 +77,17 @@ HOSTLDLIBS
>  ----------
>  Additional libraries to link against when building host programs.
>
> +.. _userkbuildflags:
> +
> +USERCFLAGS
> +----------
> +Additional options used for $(CC) when compiling userprogs.
> +
> +USERLDFLAGS
> +-----------
> +Additional options used for $(LD) when linking userprogs. userprogs are linked
> +with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
> +
>  KBUILD_KCONFIG
>  --------------
>  Set the top-level Kconfig file to the value of this environment
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index b008b90b92c9..11a296e52d68 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -982,6 +982,8 @@ The syntax is quite similar. The difference is to use "userprogs" instead of
>
>         When linking bpfilter_umh, it will be passed the extra option -static.
>
> +       From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
> +
>  5.4 When userspace programs are actually built
>  ----------------------------------------------
>
> diff --git a/Makefile b/Makefile
> index 45278d508d81..1d0172449355 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -431,11 +431,12 @@ HOSTCC    = gcc
>  HOSTCXX        = g++
>  endif
>
> -export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> -                             -O2 -fomit-frame-pointer -std=gnu89
> -export KBUILD_USERLDFLAGS :=
> +KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> +                        -O2 -fomit-frame-pointer -std=gnu89
> +KBUILD_USERCFLAGS  := $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
> +KBUILD_USERLDFLAGS := $(USERLDFLAGS)
>
> -KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> +KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
>  KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
> @@ -530,6 +531,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
>
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> diff --git a/init/Kconfig b/init/Kconfig
> index f2ae41e6717f..164706c38e8b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -62,13 +62,13 @@ config LLD_VERSION
>
>  config CC_CAN_LINK
>         bool
> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag))
> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
>
>  config CC_CAN_LINK_STATIC
>         bool
> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
>
>  config CC_HAS_ASM_GOTO
>         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 1c2ae1368079..0322e567dc1e 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
>  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
>  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>
> +# USERCFLAGS might contain sysroot location for CC.
> +UAPI_CFLAGS += $(USERCFLAGS)
> +
>  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
>
>  # The following are excluded for now because they fail to build.
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
