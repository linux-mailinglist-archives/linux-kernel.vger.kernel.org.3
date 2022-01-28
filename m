Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CCA4A01B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiA1UKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiA1UKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:10:38 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE3AC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:10:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k17so7226149plk.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XxJx4ilYXvJ63/WoIh2EqX1+JroCGyEIsnqywa2cskg=;
        b=hpbsAU2rSxHTD7i6lWENYTAGX3g+l8xkZvRdVveCIca/EgLM54Xm4VL9X9aA+1ixBm
         usZAcWyF/X4x1rmyeCE0QtnJ96UxiucQAyR4B7hXbog3ay7ES36ivR6H0oAY59ogc76O
         wTVWv7oVZS7mJX7DZTMjq+yqFKSOEuX903pGQPL4YGWKI4s7qBOhUw7Mn83mmGnecsAZ
         RA/oHAmPbwTbceqcBrFwX25a1oinhsSNZIGiUbWRtzfzB8BNZBEAeV/38AB+Ga/oFzng
         xf3rMPVIZAuj5PtdnD3SUzBiBh4S+x0CWWedBcEOWwAx9lV92q1ZSPZaiYj/axUcOOOI
         xTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XxJx4ilYXvJ63/WoIh2EqX1+JroCGyEIsnqywa2cskg=;
        b=Io55Rf48RH1a7h2JxZtbvmwmlCka+VBqVLFZ6/Kq+G31lOrKBAhbwK+NbIDLGN0SLM
         7Nm5C5BJ9efOGktaCka3BpOnO5cSPXroqeIhhmzinUEasqXUdvvFeC1Mu4yj6F+I0fKN
         eD6P7R1q6bHavcPiajhNnhob8FqaxwH1xVZE8zZO5ihOSWgtrYx0B/rC7XfD7XBg8N1B
         lsf0EWw2b1eq4HF/oAHi8Zq+DOjict/7FrGrCYWN6TKDgZjKBIa/Vv/DbYkvhOm+uofN
         lZKNyzd+oUThnp7misvBI/hYIYsIPvHszQDonqiiKNJWZCmzgGCqB+p3U+/WV/mjAqLQ
         v06A==
X-Gm-Message-State: AOAM532nG4Do2kSTrKtxrVfwGl8pUB700Qc3yuDlpy6W2RC6NXqWjYlK
        9Yx5fV6rOxY1SVawCfxzXRYg/g==
X-Google-Smtp-Source: ABdhPJz3JcAFdg6j1ClwYmIxvDY7x0ww7bRQZAh3K3BwDcHeZehoWBiFIQPkPyyjqScyjkNffkBYIg==
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr21231274pjp.125.1643400637816;
        Fri, 28 Jan 2022 12:10:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c71a:75b3:3f56:8bc8])
        by smtp.gmail.com with ESMTPSA id na7sm3489313pjb.23.2022.01.28.12.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:10:37 -0800 (PST)
Date:   Fri, 28 Jan 2022 12:10:34 -0800
From:   Fangrui Song <maskray@google.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: Add environment variables for userprogs flags
Message-ID: <20220128201034.5qfnlm4mi4ioqzam@google.com>
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
 <20220128031549.w5a4bilxbkppagfu@google.com>
 <ae25ccb2-40f3-5d40-b2ee-2c0021fbbde4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae25ccb2-40f3-5d40-b2ee-2c0021fbbde4@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-28, Elliot Berman wrote:
>Hi Fangrui,
>
>On 1/27/2022 7:15 PM, Fangrui Song wrote:
>>On 2022-01-26, Nick Desaulniers wrote:
>>>On Wed, Jan 12, 2022 at 2:44 PM Elliot Berman 
>>><quic_eberman@quicinc.com> wrote:
>>>>
>>>>Allow additional arguments be passed to userprogs compilation.
>>>>Reproducible clang builds need to provide a sysroot and gcc path to
>>>>ensure same toolchain is used across hosts. KCFLAGS is not currently
>>>>used for any user programs compilation, so add new USERCFLAGS and
>>>>USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>>>>
>>>>Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
>>>>an environment where a user sysroot is not specifically available.
>>>>Currently, Clang might automatically detect GCC installation on hosts
>>>>which have it installed to a default location in /. With addition of
>>>>these environment variables, our build environment can do like
>>>>"--sysroot=/dev/null" to force sysroot detection to fail.
>>>
>>>Hi Elliot,
>>>Thanks for the patch! Sorry for the delay in reviewing; I didn't quite
>>>get around to it then went on vacation for a week.  Things get buried
>>>in my inbox quickly; feel free to ping me if a week goes by with no
>>>response on whichever channel works best for you.
>>>
>>>I'm happy with the intent of this patch; GNU binutils has been removed
>>>from Android, so supporting CC_CAN_LINK for Android kernel builds has
>>>been a question I've been thinking about (though, not with higher
>>>priority with some of our other issues), since we'll need to either
>>>incorporate musl or bionic libc into our kernel build.  I was thinking
>>>of adding a SYSROOT command line variable for that, but I see your
>>>approach is more flexible.
>>>
>>>One minor nit below, a typo, a few questions, and in the commit
>>>message, but this generally LGTM.
>>>
>>>For the commit message, I think it would be good to expand `can do
>>>like "--sysroot=/dev/null"` fully into
>>>```
>>>can specify
>>>$ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
>>>```
>>
>>Is -Wl,--sysroot=/dev/null to override a -Wl,--sysroot specified
>>previously on the command line?
>>
>
>--sysroot isn't specified previously on the commandline for Android 
>kernel builds. Clang is falling back to sysroot detection based on 
>common installation paths, and we want to effectively disable that for 
>reproducible builds.
>

OK, the default sysroot in Clang is empty (can be overridden if one configures
llvm-project with -DDEFAULT_SYSROOT=/some/path)

Clang detects GCC installations in this order

   (https://maskray.me/blog/2021-03-28-compiler-driver-and-cross-compilation#clang)
   if (OPT_gcc_toolchain)
     prefixes = {OPT_gcc_toolchain};
   else
     prefixes = {OPT_sysroot/usr, OPT_sysroot};
   for prefix in prefixes
     if "$prefix/lib/gcc" exists
       ...

If --gcc-toolchain is unspecified and --sysroot=/dev/null, there will be no selected GCC installation,
and we will not get -L search paths like -L/usr/lib/x86_64-linux-gnu, -L/lib, etc.
(-nostdlib does not suppress -L)

So perhaps the change is to update Nick's suggestion

$ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null

with

$ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=--sysroot=/dev/null

We can compare the differences of
clang --sysroot=/dev/null -xc /dev/null '-###' |& sed -E 's/ "?-[iIL]/\n&/g'
and 
clang -Wl,--sysroot=/dev/null -xc /dev/null '-###' |& sed -E 's/ "?-[iIL]/\n&/g'

>I believe this was introduced in Clang 13 [1], but it might also be a 
>change in AOSP Clang's prebuilt. I wasn't able to get clear picture of 
>what changed in Clang. Android12-5.10 builds which use Clang 12 are 
>unaffected.
>
>[1]: https://releases.llvm.org/13.0.0/tools/clang/docs/ReleaseNotes.html#modified-compiler-flags

Yeah, I added this note in https://reviews.llvm.org/D97993
Looks like the note isn't exactly clear/correct.
The exact semantics of -B (--prefix) are:

* Search $prefix$file for executables, libraries, and data files. If $prefix is a directory, search $prefix/$file .

These files include as (if -fno-integrated-as), ld, Scrt1.o, etc.

Clang used to search $prefix/$triple-$file as well but I removed the rule in 2020.

Hope that I did not deviate the topic too much. Just want to add some details which may be useful for your patch :)

>>The driver option --sysroot does two things:
>>
>>* Decide include/library search paths (e.g. $sysroot/usr/include, 
>>$sysroot/lib64).
>>* Pass --sysroot to ld.
>>
>>In ld, it means: if a linker script is in the sysroot directory, 
>>when ld opens an
>>absolute path file (via INPUT or GROUP), add sysroot before the 
>>absolute path.
>>In ld, --sysroot=/dev/null is not different --sysroot= (empty value).
>>>>>
>>>>Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>>---
>>>> Documentation/kbuild/kbuild.rst | 8 ++++++++
>>>> Makefile                        | 9 ++++++---
>>>> init/Kconfig                    | 8 ++++----
>>>> usr/include/Makefile            | 3 +++
>>>> 4 files changed, 21 insertions(+), 7 deletions(-)
>>>>
>>>>diff --git a/Documentation/kbuild/kbuild.rst 
>>>>b/Documentation/kbuild/kbuild.rst
>>>>index 2d1fc03d346e..16e90a3ae01b 100644
>>>>--- a/Documentation/kbuild/kbuild.rst
>>>>+++ b/Documentation/kbuild/kbuild.rst
>>>>@@ -77,6 +77,14 @@ HOSTLDLIBS
>>>> ----------
>>>> Additional libraries to link against when building host programs.
>>>>
>>>>+USERCFLAGS
>>>>+----------
>>>>+Additional options used for $(CC) when compiling userprogs.
>>>>+
>>>>+USERLDFLAGS
>>>>+----------
>>>>+Additional options used for $(LD) when linking userprogs.
>>>
>>>Probably should note the necessity of `-Wl,` prefixes here.
>>>
>>>Is `userprogs` cannonical? Yeah, I guess (reading
>>>Documentation/kbuild/makefiles.rst). I wonder if we should mention
>>>these in Documentation/kbuild/makefiles.rst as well? Under `5.3
>>>Controlling compiler options for userspace programs`.
>>>
>>>>+
>>>> KBUILD_KCONFIG
>>>> --------------
>>>> Set the top-level Kconfig file to the value of this environment
>>>>diff --git a/Makefile b/Makefile
>>>>index 45278d508d81..4a55537c8ca0 100644
>>>>--- a/Makefile
>>>>+++ b/Makefile
>>>>@@ -431,15 +431,17 @@ HOSTCC    = gcc
>>>> HOSTCXX        = g++
>>>> endif
>>>>
>>>>-export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes 
>>>>-Wstrict-prototypes \
>>>>-                             -O2 -fomit-frame-pointer -std=gnu89
>>>>-export KBUILD_USERLDFLAGS :=
>>>>+KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>>>>+                    -O2 -fomit-frame-pointer -std=gnu89
>>>>+KBUILD_USERLDFLAGS := $(USERLDFLAGGS)
>>>
>>>^ I think there's an extra G in USERLDFLAGS above.
>>>
>>>>
>>>> KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) 
>>>>$(HOSTCFLAGS)
>>>> KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>>>> KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>>>> KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>>>>
>>>>+KBUILD_USERCFLAGS   += $(USERCFLAGS)
>>>
>>>Since you added USERLDFLAGS to KBUILD_USERLDFLAGS above where it's
>>>defined, why not do so for USERCFLAGS/KBUILD_USERCFLAGS as well?
>>>
>>>>+
>>>> # Make variables (CC, etc...)
>>>> CPP            = $(CC) -E
>>>> ifneq ($(LLVM),)
>>>>@@ -530,6 +532,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP 
>>>>READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
>>>> export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>>>> export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>>>> export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS 
>>>>LDFLAGS_MODULE
>>>>+export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
>>>>
>>>> export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS 
>>>>KBUILD_LDFLAGS
>>>> export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
>>>>diff --git a/init/Kconfig b/init/Kconfig
>>>>index f2ae41e6717f..164706c38e8b 100644
>>>>--- a/init/Kconfig
>>>>+++ b/init/Kconfig
>>>>@@ -62,13 +62,13 @@ config LLD_VERSION
>>>>
>>>> config CC_CAN_LINK
>>>>        bool
>>>>-       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
>>>>-       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(m32-flag))
>>>>+       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) 
>>>>if 64BIT
>>>>+       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
>>>>
>>>> config CC_CAN_LINK_STATIC
>>>>        bool
>>>>-       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
>>>>-       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(m32-flag) -static)
>>>>+       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) 
>>>>-static) if 64BIT
>>>>+       default $(success,$(srctree)/scripts/cc-can-link.sh 
>>>>$(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) 
>>>>-static)
>>>
>>>since USERLDFLAGS get passed to $(CC), they will need `-Wl`, prefixes,
>>>hence the request for expanding the example usage in the commit
>>>message.
>>>
>>>>
>>>> config CC_HAS_ASM_GOTO
>>>>        def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>>>>diff --git a/usr/include/Makefile b/usr/include/Makefile
>>>>index 1c2ae1368079..6a8c7dd9ccaf 100644
>>>>--- a/usr/include/Makefile
>>>>+++ b/usr/include/Makefile
>>>>@@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall 
>>>>-Werror=implicit-function-declaration
>>>> # It is here just because CONFIG_CC_CAN_LINK is tested with 
>>>>-m32 or -m64.
>>>> UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>>>>
>>>>+# USERCFLAGS might contain sysroot location for CC
>>>>+UAPI_CFLAGS += $(USERCFLAGS)
>>>>+
>>>
>>>Do we need to worry about USERLDFLAGS here, too? (or usr/Makefile?)
>>>
>>>> override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) 
>>>>-I$(objtree)/usr/include
>>>>
>>>> # The following are excluded for now because they fail to build.
>>>>-- 
>>>>2.25.1
>>>>
>>>
>>>
>>>-- 
>>>Thanks,
>>>~Nick Desaulniers
