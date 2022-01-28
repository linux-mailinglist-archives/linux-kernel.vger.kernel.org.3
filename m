Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3437149F1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbiA1DPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbiA1DPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:15:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55482C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:15:54 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i186so2398357pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZcF1ys+J7GpUFASVAGN6Rdu8oCjA7Z3iypwWHCPy8A=;
        b=gqxpQ0nasANrfgltMjn/UOliGsx/M5Umfd72JjWUW0y8yKFeSco7vy+1wCHMAW8xnj
         Dcc2akETfd1yWkgWkbHsmV4FRnqHHC6nH2MVji2noPC3VA6GbnL3SKJkJFmt6fM7P1h9
         SgywbWj6wiGSforGMZ4BA2Ag8qiZh7AWGguN1PI4J+7OVcxbRMohccvA4b9B7h2rJF80
         n6oz9z2dgmg81U1o2W7CUFLc2Lt4TR4+pPta3CODTyEpseDhGifE1unpNCShesZFbkwp
         4iwc8gaO/cwNpI85QYa0I5hySL7VCDHegj1wOE8dwq6cClnRcUG52qBBpNvho3B2dOJG
         Su2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZcF1ys+J7GpUFASVAGN6Rdu8oCjA7Z3iypwWHCPy8A=;
        b=JE1CQkDbIEnyhkpA0CQeOwyd5M8uZfDC1JYZP/snxsDj7AE/8YrPpALN6UK78SAlQN
         4fcO69/l30Fc6MuIw2pyfTRYmaNN7sKanBMF5MxSJNjxuSPmiq3ayn6HZiZ03nzAMMY5
         Ash1COYKiU4WaxVsNRRuRGSHgIFJv3nCPFVaneaBpLffcXGX+8x8DpuD6kItJWRN6lgV
         gdbEtQKqtYytp8LhAqa7Ggir3jwM0d6ogiXYQ6KVkh9U0MdtQwh3ruGW8vftCSBS4uKr
         pSgODOogU3F9V4Ie+w7ft5B9SxLGrHA9hj7EOyT3HBZfK2gBOhI6b0cl/jYEL8muf0pc
         j0Yw==
X-Gm-Message-State: AOAM5305apbe8cazRN7vwTjvR0g3QiqLXFfwR0Yx3Xkn8WH4kIvGzffI
        i6SzQUsFQQLEAZZ7/po5FcOx/Q==
X-Google-Smtp-Source: ABdhPJyyOfTrUzr+qvId4zhmjXJ6JWJJMgPDTtPVeTnXiqVP6kUN+6+UkWJsa3wtypi+dlPGwh7JYQ==
X-Received: by 2002:a63:3d0a:: with SMTP id k10mr5055355pga.179.1643339753623;
        Thu, 27 Jan 2022 19:15:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:e361:f314:a42:f5f8])
        by smtp.gmail.com with ESMTPSA id j18sm7353848pfj.13.2022.01.27.19.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 19:15:53 -0800 (PST)
Date:   Thu, 27 Jan 2022 19:15:49 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: Add environment variables for userprogs flags
Message-ID: <20220128031549.w5a4bilxbkppagfu@google.com>
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26, Nick Desaulniers wrote:
>On Wed, Jan 12, 2022 at 2:44 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
>>
>> Allow additional arguments be passed to userprogs compilation.
>> Reproducible clang builds need to provide a sysroot and gcc path to
>> ensure same toolchain is used across hosts. KCFLAGS is not currently
>> used for any user programs compilation, so add new USERCFLAGS and
>> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>>
>> Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
>> an environment where a user sysroot is not specifically available.
>> Currently, Clang might automatically detect GCC installation on hosts
>> which have it installed to a default location in /. With addition of
>> these environment variables, our build environment can do like
>> "--sysroot=/dev/null" to force sysroot detection to fail.
>
>Hi Elliot,
>Thanks for the patch! Sorry for the delay in reviewing; I didn't quite
>get around to it then went on vacation for a week.  Things get buried
>in my inbox quickly; feel free to ping me if a week goes by with no
>response on whichever channel works best for you.
>
>I'm happy with the intent of this patch; GNU binutils has been removed
>from Android, so supporting CC_CAN_LINK for Android kernel builds has
>been a question I've been thinking about (though, not with higher
>priority with some of our other issues), since we'll need to either
>incorporate musl or bionic libc into our kernel build.  I was thinking
>of adding a SYSROOT command line variable for that, but I see your
>approach is more flexible.
>
>One minor nit below, a typo, a few questions, and in the commit
>message, but this generally LGTM.
>
>For the commit message, I think it would be good to expand `can do
>like "--sysroot=/dev/null"` fully into
>```
>can specify
>$ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
>```

Is -Wl,--sysroot=/dev/null to override a -Wl,--sysroot specified
previously on the command line?

The driver option --sysroot does two things:

* Decide include/library search paths (e.g. $sysroot/usr/include, $sysroot/lib64).
* Pass --sysroot to ld.

In ld, it means: if a linker script is in the sysroot directory, when ld opens an
absolute path file (via INPUT or GROUP), add sysroot before the absolute path.
In ld, --sysroot=/dev/null is not different --sysroot= (empty value).

>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>  Documentation/kbuild/kbuild.rst | 8 ++++++++
>>  Makefile                        | 9 ++++++---
>>  init/Kconfig                    | 8 ++++----
>>  usr/include/Makefile            | 3 +++
>>  4 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
>> index 2d1fc03d346e..16e90a3ae01b 100644
>> --- a/Documentation/kbuild/kbuild.rst
>> +++ b/Documentation/kbuild/kbuild.rst
>> @@ -77,6 +77,14 @@ HOSTLDLIBS
>>  ----------
>>  Additional libraries to link against when building host programs.
>>
>> +USERCFLAGS
>> +----------
>> +Additional options used for $(CC) when compiling userprogs.
>> +
>> +USERLDFLAGS
>> +----------
>> +Additional options used for $(LD) when linking userprogs.
>
>Probably should note the necessity of `-Wl,` prefixes here.
>
>Is `userprogs` cannonical? Yeah, I guess (reading
>Documentation/kbuild/makefiles.rst). I wonder if we should mention
>these in Documentation/kbuild/makefiles.rst as well? Under `5.3
>Controlling compiler options for userspace programs`.
>
>> +
>>  KBUILD_KCONFIG
>>  --------------
>>  Set the top-level Kconfig file to the value of this environment
>> diff --git a/Makefile b/Makefile
>> index 45278d508d81..4a55537c8ca0 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -431,15 +431,17 @@ HOSTCC    = gcc
>>  HOSTCXX        = g++
>>  endif
>>
>> -export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>> -                             -O2 -fomit-frame-pointer -std=gnu89
>> -export KBUILD_USERLDFLAGS :=
>> +KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>> +                    -O2 -fomit-frame-pointer -std=gnu89
>> +KBUILD_USERLDFLAGS := $(USERLDFLAGGS)
>
>^ I think there's an extra G in USERLDFLAGS above.
>
>>
>>  KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
>>  KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>>  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>>  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>>
>> +KBUILD_USERCFLAGS   += $(USERCFLAGS)
>
>Since you added USERLDFLAGS to KBUILD_USERLDFLAGS above where it's
>defined, why not do so for USERCFLAGS/KBUILD_USERCFLAGS as well?
>
>> +
>>  # Make variables (CC, etc...)
>>  CPP            = $(CC) -E
>>  ifneq ($(LLVM),)
>> @@ -530,6 +532,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
>>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
>> +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
>>
>>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
>>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
>> diff --git a/init/Kconfig b/init/Kconfig
>> index f2ae41e6717f..164706c38e8b 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -62,13 +62,13 @@ config LLD_VERSION
>>
>>  config CC_CAN_LINK
>>         bool
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag))
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
>>
>>  config CC_CAN_LINK_STATIC
>>         bool
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
>
>since USERLDFLAGS get passed to $(CC), they will need `-Wl`, prefixes,
>hence the request for expanding the example usage in the commit
>message.
>
>>
>>  config CC_HAS_ASM_GOTO
>>         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>> diff --git a/usr/include/Makefile b/usr/include/Makefile
>> index 1c2ae1368079..6a8c7dd9ccaf 100644
>> --- a/usr/include/Makefile
>> +++ b/usr/include/Makefile
>> @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
>>  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
>>  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>>
>> +# USERCFLAGS might contain sysroot location for CC
>> +UAPI_CFLAGS += $(USERCFLAGS)
>> +
>
>Do we need to worry about USERLDFLAGS here, too? (or usr/Makefile?)
>
>>  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
>>
>>  # The following are excluded for now because they fail to build.
>> --
>> 2.25.1
>>
>
>
>-- 
>Thanks,
>~Nick Desaulniers
