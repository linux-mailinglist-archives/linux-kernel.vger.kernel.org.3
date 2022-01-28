Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8F4A03E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiA1Wpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiA1Wpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:45:33 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71596C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:45:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c3so7496000pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1lj832tGmFyIqua9wa/r0vYUcYhofrxoYg4e6wRcfOA=;
        b=MQ686LpLEFIuxqD9Kv770e+zbsPS8ZMDWslLNwEMRN7gbeDfZRmiy9ue5guEvbSUbV
         q3GoFjjxx3QeRVS2nExeuA9ILxg7Cyrs3idFPIQAXmmm9ii0HVp3zfRlh88FTYuoXbjr
         SEVAcD1awV+SK2H79UrGepZljae/kBRAzhnmRKsOruA03jc7CdqCX9YuC1RdsbyDmfNw
         d5BL/XmtS9W8XEe3sG/3VcruI/j7TjYQU6pLaWdISB9J/DyP3avifN/hJ4FAbqFNSl5u
         YNFMtKFxLvwoiWWVYHcD2fjCXREtTok7N0kt72WMEfxToFXwDNWy27aBzsfJUzjUhkGi
         pj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lj832tGmFyIqua9wa/r0vYUcYhofrxoYg4e6wRcfOA=;
        b=cRNgHIrQQq9+YCh3mgJyXNSU0t5Z2DEBQCy1Ze9lHNlgdnZepUJhOxJz8s/R5oSuI3
         2MXc3jHU6CjU18LB9mMeQyzcSLTy8FjXbruR3dbLOq1ehwJ1NLKJRRiZpp9oWOU45/ve
         h0NzOQCx1LMMP34P5lnug/p6yrEGZoYoj2yXAaEduGqOz6+ZmoaKDvJvTc0wkxxrMvCw
         gbsEIvrwIJFvCvxtyaK8jRZaFKWy+1jsQY7AikQDwsssG/aDq1YD3KHiHTtMmSfunf2P
         vNG2EkyJijHuEFniakUoTELA1A3uqgte93zgw8ZH6QdCCvInO+apCIQ/iAnO5L99vN8W
         l7uQ==
X-Gm-Message-State: AOAM5327fM/KrPlpkrLzMZB9qQ6b0NhHhJpP+f6T992r/ZbEPKdZXGpa
        9r1VovZ/jxHGnBN67/dpwWLFhA==
X-Google-Smtp-Source: ABdhPJx89XALahPbJIO0ez6i3GHoqWvrHrmi0ISshkawVR+Jop9IQB/IbUt1h+uoIWibMBwpYZxFZw==
X-Received: by 2002:a17:90b:3106:: with SMTP id gc6mr21923698pjb.77.1643409932787;
        Fri, 28 Jan 2022 14:45:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c71a:75b3:3f56:8bc8])
        by smtp.gmail.com with ESMTPSA id 38sm22668074pgm.37.2022.01.28.14.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 14:45:32 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:45:28 -0800
From:   Fangrui Song <maskray@google.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] kbuild: Add environment variables for userprogs flags
Message-ID: <20220128224528.f7ejzw55t6kfefmm@google.com>
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <20220128220841.3222637-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220128220841.3222637-1-quic_eberman@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28, Elliot Berman wrote:
>Allow additional arguments be passed to userprogs compilation.
>Reproducible clang builds need to provide a sysroot and gcc path to
>ensure same toolchain is used across hosts. KCFLAGS is not currently
>used for any user programs compilation, so add new USERCFLAGS and
>USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>
>Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
>an environment where a user sysroot is not specifically available.
>Currently, Clang might automatically detect GCC installation on hosts
>which have it installed to a default location in /. With addition of
>these environment variables, you can specify flags such as:
>
>$ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
>
>to force sysroot detection to fail.

-Wl,--sysroot=/dev/null => --sysroot

As I mentioned in
https://lore.kernel.org/all/20220128031549.w5a4bilxbkppagfu@google.com/
-Wl,--sysroot=/dev/null does not suppress search paths like -L/lib .


>Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>
>Changes since v1: Addressed minor nits from Nick
>---
> Documentation/kbuild/kbuild.rst    | 9 +++++++++
> Documentation/kbuild/makefiles.rst | 2 ++
> Makefile                           | 9 ++++++---
> init/Kconfig                       | 8 ++++----
> usr/include/Makefile               | 3 +++
> 5 files changed, 24 insertions(+), 7 deletions(-)
>
>diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
>index 2d1fc03d346e..3e7467b19c8f 100644
>--- a/Documentation/kbuild/kbuild.rst
>+++ b/Documentation/kbuild/kbuild.rst
>@@ -77,6 +77,15 @@ HOSTLDLIBS
> ----------
> Additional libraries to link against when building host programs.
>
>+USERCFLAGS
>+----------
>+Additional options used for $(CC) when compiling userprogs.
>+
>+USERLDFLAGS
>+----------
>+Additional options used for $(LD) when linking userprogs. userprogs are linked
>+with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
>+
> KBUILD_KCONFIG
> --------------
> Set the top-level Kconfig file to the value of this environment
>diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
>index b008b90b92c9..39fb70f59429 100644
>--- a/Documentation/kbuild/makefiles.rst
>+++ b/Documentation/kbuild/makefiles.rst
>@@ -982,6 +982,8 @@ The syntax is quite similar. The difference is to use "userprogs" instead of
>
> 	When linking bpfilter_umh, it will be passed the extra option -static.
>
>+	From command line, USERCFLAGS and USERLDFLAGS will also be used (See kbuild.rst)
>+
> 5.4 When userspace programs are actually built
> ----------------------------------------------
>
>diff --git a/Makefile b/Makefile
>index 45278d508d81..8a2324e6bda8 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -431,15 +431,17 @@ HOSTCC	= gcc
> HOSTCXX	= g++
> endif
>
>-export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>-			      -O2 -fomit-frame-pointer -std=gnu89
>-export KBUILD_USERLDFLAGS :=
>+KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>+		     -O2 -fomit-frame-pointer -std=gnu89
>+KBUILD_USERLDFLAGS := $(USERLDFLAGS)
>
> KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>
>+KBUILD_USERCFLAGS   += $(USERCFLAGS)
>+
> # Make variables (CC, etc...)
> CPP		= $(CC) -E
> ifneq ($(LLVM),)
>@@ -530,6 +532,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
> export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
>+export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
>
> export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
> export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
>diff --git a/init/Kconfig b/init/Kconfig
>index f2ae41e6717f..164706c38e8b 100644
>--- a/init/Kconfig
>+++ b/init/Kconfig
>@@ -62,13 +62,13 @@ config LLD_VERSION
>
> config CC_CAN_LINK
> 	bool
>-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
>-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag))
>+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
>+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
>
> config CC_CAN_LINK_STATIC
> 	bool
>-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
>-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
>+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
>+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
>
> config CC_HAS_ASM_GOTO
> 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>diff --git a/usr/include/Makefile b/usr/include/Makefile
>index 1c2ae1368079..6a8c7dd9ccaf 100644
>--- a/usr/include/Makefile
>+++ b/usr/include/Makefile
>@@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
> # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
> UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>
>+# USERCFLAGS might contain sysroot location for CC
>+UAPI_CFLAGS += $(USERCFLAGS)
>+
> override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
>
> # The following are excluded for now because they fail to build.
>-- 
>2.25.1
>
>
