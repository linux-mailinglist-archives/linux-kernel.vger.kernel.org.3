Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C644A03E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiA1WsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiA1WsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:48:23 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B222C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:48:22 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p27so14685547lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDxlUuw0YGzk2V0HdWKSL5+/ksUHciajNalLhG+gxqM=;
        b=hAqEtJYUVk6sP7MC5XHXE1eltOu+5jVGyy9Ca89H0exL4Nju28Htb/AC/hkbrEppVl
         aFYFL00AhsWeOM1m1YvKviHNDIRYlKJ2hL/OPL9/nwDkNvqZcOEXECfCMOU3/qB+Q7Nk
         mTkcXsL6MSmSTftYusupHruT3O237SWhRtDkVAhNQl2zAtgqWSkRjOW0u0qi3ciI1uzv
         8rGLmHg3IfiDRQh4D0r8N5Ne//LpBb2DToVXNZCWO83HRHpssZE9KnWBroAoOinJmASI
         2OeTs857YKqWhrFAuIRDzUmmj0O7MLm5SY72EUmoV8Q0KbJ7ViQAWFppfsEt7rS/WwXz
         6k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDxlUuw0YGzk2V0HdWKSL5+/ksUHciajNalLhG+gxqM=;
        b=n61xFjwQzWNNSiykSISFUD21o3VuQHZmTts9e709GjhaJUMYCHWSgEEEFgJJGvnykz
         9ZU5lbX13sraW0JFWnayI2sno6I/ope+tLN6BZCMTt43ltmKa5a5mGDKtiYTtEhRjdOS
         hloF0Ki+NaRAmkMvjc23CsrWIVQugCf5ywJwiOBHwssGs/NN3MgHlSDr9gSHhSymzH7+
         tQnveLuQpgxH5BcTdHIjyC5pKUTC6wqS1r6/OoldUwJbEShzNSdZ4IL5f5U2rv89wmt3
         X+9Q7VY6CZi0cnhUrpgVqAqCp/dzgP8whCUM5Zx0OAMnM1EWChC7YcFbOP6kk6q359yC
         KvLQ==
X-Gm-Message-State: AOAM532DXNIexhmeS92Keo0ZsKYO1NmYpgxHRAFjf8hXnjeG3t0ZKUqw
        nwOaSklSaI0wkVc4u7IWHU9BfPiK93XddmrbLQHHTg==
X-Google-Smtp-Source: ABdhPJyuU2ZVA5jocmhkvZJpxKezk07FKat+/cuELt0gZKLjlmgPLn8/BiL1nifgCC0ouIG9gPTHHwA1Dpja1HmsMa8=
X-Received: by 2002:ac2:4c4c:: with SMTP id o12mr7491943lfk.523.1643410100327;
 Fri, 28 Jan 2022 14:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com> <20220128220841.3222637-1-quic_eberman@quicinc.com>
In-Reply-To: <20220128220841.3222637-1-quic_eberman@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 28 Jan 2022 14:48:08 -0800
Message-ID: <CAKwvOdmkw30s-sjL0PVfJ2E9Th5cgDSbWMMPZS0cfi4jLyAe4A@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Add environment variables for userprogs flags
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

On Fri, Jan 28, 2022 at 2:09 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Allow additional arguments be passed to userprogs compilation.
> Reproducible clang builds need to provide a sysroot and gcc path to
> ensure same toolchain is used across hosts. KCFLAGS is not currently

"ensure the same"

> used for any user programs compilation, so add new USERCFLAGS and
> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>
> Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
> an environment where a user sysroot is not specifically available.

^ I think we can be more precise with the description of the problem;
technically, CC_CAN_LINK _does_ fail consistently when there's no
sysroot found.

It's more that the sysroot may or may not be available depending on
what's been installed on the host.

One might argue that "you should install all kernel dependencies
consistently on your build machines."  Therefor, it might be better to
describe a different problem this solves: we may want the compiler
used for userprogs to use an explicit sysroot that may differ from the
implicit default which may or may not be installed on the host in a
location the toolchain will search by default.

> Currently, Clang might automatically detect GCC installation on hosts
> which have it installed to a default location in /. With addition of
> these environment variables, you can specify flags such as:
>
> $ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
>
> to force sysroot detection to fail.

"to force no sysroot to be autodetected on the host. This can also be
used to specify different sysroots such as musl or bionic, which may
not be installed on the host in paths that the compiler may search by
default."

>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>
> Changes since v1: Addressed minor nits from Nick
> ---

^ these descriptions of changes should go below the `---` so that
they're not retained when applied.

>  Documentation/kbuild/kbuild.rst    | 9 +++++++++
>  Documentation/kbuild/makefiles.rst | 2 ++
>  Makefile                           | 9 ++++++---
>  init/Kconfig                       | 8 ++++----
>  usr/include/Makefile               | 3 +++
>  5 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 2d1fc03d346e..3e7467b19c8f 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -77,6 +77,15 @@ HOSTLDLIBS
>  ----------
>  Additional libraries to link against when building host programs.
>
> +USERCFLAGS
> +----------
> +Additional options used for $(CC) when compiling userprogs.
> +
> +USERLDFLAGS
> +----------
> +Additional options used for $(LD) when linking userprogs. userprogs are linked
> +with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
> +
>  KBUILD_KCONFIG
>  --------------
>  Set the top-level Kconfig file to the value of this environment
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index b008b90b92c9..39fb70f59429 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -982,6 +982,8 @@ The syntax is quite similar. The difference is to use "userprogs" instead of
>
>         When linking bpfilter_umh, it will be passed the extra option -static.
>
> +       From command line, USERCFLAGS and USERLDFLAGS will also be used (See kbuild.rst)
> +

^ can we use the (awful) RST syntax to include a hyperlink to kbuild.rst?

>  5.4 When userspace programs are actually built
>  ----------------------------------------------
>
> diff --git a/Makefile b/Makefile
> index 45278d508d81..8a2324e6bda8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -431,15 +431,17 @@ HOSTCC    = gcc
>  HOSTCXX        = g++
>  endif
>
> -export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> -                             -O2 -fomit-frame-pointer -std=gnu89
> -export KBUILD_USERLDFLAGS :=
> +KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> +                    -O2 -fomit-frame-pointer -std=gnu89
> +KBUILD_USERLDFLAGS := $(USERLDFLAGS)
>
>  KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
>  KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>
> +KBUILD_USERCFLAGS   += $(USERCFLAGS)
> +

Earlier you pointed out that the initial assignment of
KBUILD_USERCFLAGS was reused for KBUILD_HOSTCFLAGS.  I think it would
be clearer that we were reusing a common base for two different
purposes if we renamed some of these variables as such:

KBUILD_BASECFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
  -O2 -fomit-frame-pointer -std=gnu89
KBUILD_USERCFLAGS := $(KBUILD_BASECFLAGS) $(USERCFLAGS)
KBUILD_USERLDFLAGS := $(USERLDFLAGS)
KBUILD_HOSTCFLAGS   := $(KBUILD_BASEFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
...

or maybe KBUILD_USERHOSTCFLAGS would be a better identifier than
KBUILD_BASECFLAGS? I don't feel strongly either way. As long as the
common base isn't explicitly exported so that folks may mistakenly use
it when they probably meant to use one of the two (KBUILD_USERCFLAGS
or KBUILD_HOSTCFLAGS) derived from it.

>  # Make variables (CC, etc...)
>  CPP            = $(CC) -E
>  ifneq ($(LLVM),)
> @@ -530,6 +532,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
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
> index 1c2ae1368079..6a8c7dd9ccaf 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
>  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
>  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>
> +# USERCFLAGS might contain sysroot location for CC

^ This file is pretty consistent in its use of punctuation to end
comments. Let's stay consistent for newly added comments by adding a
period at the end of this comment.

> +UAPI_CFLAGS += $(USERCFLAGS)
> +
>  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
>
>  # The following are excluded for now because they fail to build.
> --
> 2.25.1
>
>


-- 
Thanks,
~Nick Desaulniers
