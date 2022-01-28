Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777DC4A0105
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348029AbiA1TkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:40:18 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:41188 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232304AbiA1TkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643398817; x=1674934817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jmkX/cBNWxTPHGquKZyoZj4TQB/+pvNng7boVZKqfFU=;
  b=iMoGl6HYqTA6kZ1DV4Ay67QvKcI9LAQkNZCfshevqV3lRjLBQtHt/QZk
   /0Up5WGMiWkeoQCaD9sozOGoeIIjKRDaikaHaaLIki6dcjrLsP3JUKXyt
   tH7Ta9Jqa+N6X6LJ4/Emna0uy4zdU8HH7owVZA4VBUwT32uQ4UqlGHdrW
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jan 2022 11:40:16 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:40:16 -0800
Received: from [10.110.30.198] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 28 Jan
 2022 11:40:15 -0800
Message-ID: <ae25ccb2-40f3-5d40-b2ee-2c0021fbbde4@quicinc.com>
Date:   Fri, 28 Jan 2022 11:40:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] kbuild: Add environment variables for userprogs flags
Content-Language: en-US
To:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Matthias Maennich" <maennich@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
 <20220128031549.w5a4bilxbkppagfu@google.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20220128031549.w5a4bilxbkppagfu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangrui,

On 1/27/2022 7:15 PM, Fangrui Song wrote:
> On 2022-01-26, Nick Desaulniers wrote:
>> On Wed, Jan 12, 2022 at 2:44 PM Elliot Berman 
>> <quic_eberman@quicinc.com> wrote:
>>>
>>> Allow additional arguments be passed to userprogs compilation.
>>> Reproducible clang builds need to provide a sysroot and gcc path to
>>> ensure same toolchain is used across hosts. KCFLAGS is not currently
>>> used for any user programs compilation, so add new USERCFLAGS and
>>> USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
>>>
>>> Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
>>> an environment where a user sysroot is not specifically available.
>>> Currently, Clang might automatically detect GCC installation on hosts
>>> which have it installed to a default location in /. With addition of
>>> these environment variables, our build environment can do like
>>> "--sysroot=/dev/null" to force sysroot detection to fail.
>>
>> Hi Elliot,
>> Thanks for the patch! Sorry for the delay in reviewing; I didn't quite
>> get around to it then went on vacation for a week.  Things get buried
>> in my inbox quickly; feel free to ping me if a week goes by with no
>> response on whichever channel works best for you.
>>
>> I'm happy with the intent of this patch; GNU binutils has been removed
>> from Android, so supporting CC_CAN_LINK for Android kernel builds has
>> been a question I've been thinking about (though, not with higher
>> priority with some of our other issues), since we'll need to either
>> incorporate musl or bionic libc into our kernel build.  I was thinking
>> of adding a SYSROOT command line variable for that, but I see your
>> approach is more flexible.
>>
>> One minor nit below, a typo, a few questions, and in the commit
>> message, but this generally LGTM.
>>
>> For the commit message, I think it would be good to expand `can do
>> like "--sysroot=/dev/null"` fully into
>> ```
>> can specify
>> $ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
>> ```
> 
> Is -Wl,--sysroot=/dev/null to override a -Wl,--sysroot specified
> previously on the command line?
> 

--sysroot isn't specified previously on the commandline for Android 
kernel builds. Clang is falling back to sysroot detection based on 
common installation paths, and we want to effectively disable that for 
reproducible builds.

I believe this was introduced in Clang 13 [1], but it might also be a 
change in AOSP Clang's prebuilt. I wasn't able to get clear picture of 
what changed in Clang. Android12-5.10 builds which use Clang 12 are 
unaffected.

[1]: 
https://releases.llvm.org/13.0.0/tools/clang/docs/ReleaseNotes.html#modified-compiler-flags

> The driver option --sysroot does two things:
> 
> * Decide include/library search paths (e.g. $sysroot/usr/include, 
> $sysroot/lib64).
> * Pass --sysroot to ld.
> 
> In ld, it means: if a linker script is in the sysroot directory, when ld 
> opens an
> absolute path file (via INPUT or GROUP), add sysroot before the absolute 
> path.
> In ld, --sysroot=/dev/null is not different --sysroot= (empty value).
> >>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>>  Documentation/kbuild/kbuild.rst | 8 ++++++++
>>>  Makefile                        | 9 ++++++---
>>>  init/Kconfig                    | 8 ++++----
>>>  usr/include/Makefile            | 3 +++
>>>  4 files changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/kbuild/kbuild.rst 
>>> b/Documentation/kbuild/kbuild.rst
>>> index 2d1fc03d346e..16e90a3ae01b 100644
>>> --- a/Documentation/kbuild/kbuild.rst
>>> +++ b/Documentation/kbuild/kbuild.rst
>>> @@ -77,6 +77,14 @@ HOSTLDLIBS
>>>  ----------
>>>  Additional libraries to link against when building host programs.
>>>
>>> +USERCFLAGS
>>> +----------
>>> +Additional options used for $(CC) when compiling userprogs.
>>> +
>>> +USERLDFLAGS
>>> +----------
>>> +Additional options used for $(LD) when linking userprogs.
>>
>> Probably should note the necessity of `-Wl,` prefixes here.
>>
>> Is `userprogs` cannonical? Yeah, I guess (reading
>> Documentation/kbuild/makefiles.rst). I wonder if we should mention
>> these in Documentation/kbuild/makefiles.rst as well? Under `5.3
>> Controlling compiler options for userspace programs`.
>>
>>> +
>>>  KBUILD_KCONFIG
>>>  --------------
>>>  Set the top-level Kconfig file to the value of this environment
>>> diff --git a/Makefile b/Makefile
>>> index 45278d508d81..4a55537c8ca0 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -431,15 +431,17 @@ HOSTCC    = gcc
>>>  HOSTCXX        = g++
>>>  endif
>>>
>>> -export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes 
>>> -Wstrict-prototypes \
>>> -                             -O2 -fomit-frame-pointer -std=gnu89
>>> -export KBUILD_USERLDFLAGS :=
>>> +KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>>> +                    -O2 -fomit-frame-pointer -std=gnu89
>>> +KBUILD_USERLDFLAGS := $(USERLDFLAGGS)
>>
>> ^ I think there's an extra G in USERLDFLAGS above.
>>
>>>
>>>  KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) 
>>> $(HOSTCFLAGS)
>>>  KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>>>  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>>>  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>>>
>>> +KBUILD_USERCFLAGS   += $(USERCFLAGS)
>>
>> Since you added USERLDFLAGS to KBUILD_USERLDFLAGS above where it's
>> defined, why not do so for USERCFLAGS/KBUILD_USERCFLAGS as well?
>>
>>> +
>>>  # Make variables (CC, etc...)
>>>  CPP            = $(CC) -E
>>>  ifneq ($(LLVM),)
>>> @@ -530,6 +532,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF 
>>> PAHOLE RESOLVE_BTFIDS LEX YACC AW
>>>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>>>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>>>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS 
>>> LDFLAGS_MODULE
>>> +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
>>>
>>>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS 
>>> KBUILD_LDFLAGS
>>>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index f2ae41e6717f..164706c38e8b 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -62,13 +62,13 @@ config LLD_VERSION
>>>
>>>  config CC_CAN_LINK
>>>         bool
>>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(m64-flag)) if 64BIT
>>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(m32-flag))
>>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
>>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
>>>
>>>  config CC_CAN_LINK_STATIC
>>>         bool
>>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
>>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(m32-flag) -static)
>>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 
>>> 64BIT
>>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) 
>>> $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
>>
>> since USERLDFLAGS get passed to $(CC), they will need `-Wl`, prefixes,
>> hence the request for expanding the example usage in the commit
>> message.
>>
>>>
>>>  config CC_HAS_ASM_GOTO
>>>         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>>> diff --git a/usr/include/Makefile b/usr/include/Makefile
>>> index 1c2ae1368079..6a8c7dd9ccaf 100644
>>> --- a/usr/include/Makefile
>>> +++ b/usr/include/Makefile
>>> @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall 
>>> -Werror=implicit-function-declaration
>>>  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or 
>>> -m64.
>>>  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>>>
>>> +# USERCFLAGS might contain sysroot location for CC
>>> +UAPI_CFLAGS += $(USERCFLAGS)
>>> +
>>
>> Do we need to worry about USERLDFLAGS here, too? (or usr/Makefile?)
>>
>>>  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) 
>>> -I$(objtree)/usr/include
>>>
>>>  # The following are excluded for now because they fail to build.
>>> -- 
>>> 2.25.1
>>>
>>
>>
>> -- 
>> Thanks,
>> ~Nick Desaulniers
