Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0053249D1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbiAZSV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiAZSVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:21:55 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB9C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:21:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x23so695667lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOOemRyWwE9D0y3xTHRIeOznu19i9x/1/A0thcitFs4=;
        b=HNfRlKC1weHHVajmNNJN2wj8u66lT49ixUC8INgVxvKeo2Bp5FwrasBr988y4tBUU7
         AvNyB1QlRbq7oKEkjAb/P2w304qOx2oZkgkJJmrHqU7QJZG0flBNxgpgEumqWDwTun37
         jx1zdSHMg6iVmzoTx0DEGVV3qASbt2R3buFy5+gN/CuqbknibQ+7tBNd45Hh5t4iCN4l
         xgdIX98GS8mz9g+4IHmXDNvQSZNrEDQHN9DIkWi9S8dyVw7EqS6duYVms71G0Fc0boNv
         idaK/Z7U4YETvwWnWh0OfochL/AI+GDjZ0L+0H05HNVe7tYSTYgJDDe6U06erJSzb7C7
         SrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOOemRyWwE9D0y3xTHRIeOznu19i9x/1/A0thcitFs4=;
        b=et+J6VSc3pWWkyD8E5aNc4gPy9NrBGJzmcb7mJaa6Y/12Rtx3RlJk6+BmW/hJui6/Z
         2SdKSmC16G6qi+a+dR23PDlR0DBMFFK6HikLedqhubfl/nlgVX8JfVkt4jpoNOud96fw
         KchsNaF87PMwvFS+HMmTU5YUQKZa+ZtVU1JKbNnpw/lebLhGilwZhZ3f++CeecfcgZKO
         VWIsgB9TbsMGEYD7txRKZmz3uNZE0XH/R2Fd6rKCBDTXOEyvN5emcfhYKH4YnWq4F2/s
         k8wiqVi0XHcxIXQ6ameaKaZFnYcNevjNertrIAVaCAE3nnspq/ncHAEwfwW37ulBvjcx
         lxkw==
X-Gm-Message-State: AOAM533mnaqe/Ai5eBMba+tx0q43PEYpRWPeKo4sODZMUjHVfbSIx39n
        tlE3v79/HCiHeZuiD25PFe5Z/vetMofUv0F3UKJajQ==
X-Google-Smtp-Source: ABdhPJzcbvHPjLT7JnFqtxn6UaoM/biHGm4slpTfDRdZTME9a2GRNBJzBmv5dqWQbeKAJEN6kjawRa6nYITmea4wqcs=
X-Received: by 2002:a05:6512:3c96:: with SMTP id h22mr34628lfv.489.1643221312650;
 Wed, 26 Jan 2022 10:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
In-Reply-To: <20220112224342.958358-1-quic_eberman@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jan 2022 10:21:40 -0800
Message-ID: <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add environment variables for userprogs flags
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 2:44 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Allow additional arguments be passed to userprogs compilation.
> Reproducible clang builds need to provide a sysroot and gcc path to
> ensure same toolchain is used across hosts. KCFLAGS is not currently
> used for any user programs compilation, so add new USERCFLAGS and
> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>
> Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
> an environment where a user sysroot is not specifically available.
> Currently, Clang might automatically detect GCC installation on hosts
> which have it installed to a default location in /. With addition of
> these environment variables, our build environment can do like
> "--sysroot=/dev/null" to force sysroot detection to fail.

Hi Elliot,
Thanks for the patch! Sorry for the delay in reviewing; I didn't quite
get around to it then went on vacation for a week.  Things get buried
in my inbox quickly; feel free to ping me if a week goes by with no
response on whichever channel works best for you.

I'm happy with the intent of this patch; GNU binutils has been removed
from Android, so supporting CC_CAN_LINK for Android kernel builds has
been a question I've been thinking about (though, not with higher
priority with some of our other issues), since we'll need to either
incorporate musl or bionic libc into our kernel build.  I was thinking
of adding a SYSROOT command line variable for that, but I see your
approach is more flexible.

One minor nit below, a typo, a few questions, and in the commit
message, but this generally LGTM.

For the commit message, I think it would be good to expand `can do
like "--sysroot=/dev/null"` fully into
```
can specify
$ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
```

>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/kbuild/kbuild.rst | 8 ++++++++
>  Makefile                        | 9 ++++++---
>  init/Kconfig                    | 8 ++++----
>  usr/include/Makefile            | 3 +++
>  4 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 2d1fc03d346e..16e90a3ae01b 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -77,6 +77,14 @@ HOSTLDLIBS
>  ----------
>  Additional libraries to link against when building host programs.
>
> +USERCFLAGS
> +----------
> +Additional options used for $(CC) when compiling userprogs.
> +
> +USERLDFLAGS
> +----------
> +Additional options used for $(LD) when linking userprogs.

Probably should note the necessity of `-Wl,` prefixes here.

Is `userprogs` cannonical? Yeah, I guess (reading
Documentation/kbuild/makefiles.rst). I wonder if we should mention
these in Documentation/kbuild/makefiles.rst as well? Under `5.3
Controlling compiler options for userspace programs`.

> +
>  KBUILD_KCONFIG
>  --------------
>  Set the top-level Kconfig file to the value of this environment
> diff --git a/Makefile b/Makefile
> index 45278d508d81..4a55537c8ca0 100644
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
> +KBUILD_USERLDFLAGS := $(USERLDFLAGGS)

^ I think there's an extra G in USERLDFLAGS above.

>
>  KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
>  KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>
> +KBUILD_USERCFLAGS   += $(USERCFLAGS)

Since you added USERLDFLAGS to KBUILD_USERLDFLAGS above where it's
defined, why not do so for USERCFLAGS/KBUILD_USERCFLAGS as well?

> +
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

since USERLDFLAGS get passed to $(CC), they will need `-Wl`, prefixes,
hence the request for expanding the example usage in the commit
message.

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
> +UAPI_CFLAGS += $(USERCFLAGS)
> +

Do we need to worry about USERLDFLAGS here, too? (or usr/Makefile?)

>  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
>
>  # The following are excluded for now because they fail to build.
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
