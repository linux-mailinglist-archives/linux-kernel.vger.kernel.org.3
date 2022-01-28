Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4694A0166
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351091AbiA1UGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:06:43 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12970 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351060AbiA1UGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643400402; x=1674936402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4YFSaVkGknEE1BL8T4nI34l2UDt7GaDRm6fUyYZ387U=;
  b=foJDfha7WQPDNCal4i9gR1NeQR4jeNcFWYCIByMpbY4rohteCGldNHVK
   Lg3pVstbah8FZ+01Cx1Snkm26aPkyrHu3hKBKY/7uuAZTErOfPfBO2XH/
   JzIXJhFoU0PGyt4TAO7FQTEfyAfl4ViB6/wDKzYCNYY9PtuKj5krmv7tX
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jan 2022 12:06:41 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:06:41 -0800
Received: from [10.110.30.198] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 28 Jan
 2022 12:06:40 -0800
Message-ID: <a2687b42-79e2-5609-baf4-356da054b214@quicinc.com>
Date:   Fri, 28 Jan 2022 12:06:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] kbuild: Add environment variables for userprogs flags
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Fangrui Song" <maskray@google.com>,
        Matthias Maennich <maennich@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <CAKwvOdk73a6FT3o7Pn7_dRM3U=dbrXy+iqmLC6n5msSNMzOTGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2022 10:21 AM, Nick Desaulniers wrote:
> On Wed, Jan 12, 2022 at 2:44 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
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
> Hi Elliot,
> Thanks for the patch! Sorry for the delay in reviewing; I didn't quite
> get around to it then went on vacation for a week.  Things get buried
> in my inbox quickly; feel free to ping me if a week goes by with no
> response on whichever channel works best for you.

No worries :) Thanks for the review.

> 
> I'm happy with the intent of this patch; GNU binutils has been removed
> from Android, so supporting CC_CAN_LINK for Android kernel builds has
> been a question I've been thinking about (though, not with higher
> priority with some of our other issues), since we'll need to either
> incorporate musl or bionic libc into our kernel build.  I was thinking
> of adding a SYSROOT command line variable for that, but I see your
> approach is more flexible.
> 
> One minor nit below, a typo, a few questions, and in the commit
> message, but this generally LGTM.
> 
> For the commit message, I think it would be good to expand `can do
> like "--sysroot=/dev/null"` fully into
> ```
> can specify
> $ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null
> ```
> 

Will do.

>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   Documentation/kbuild/kbuild.rst | 8 ++++++++
>>   Makefile                        | 9 ++++++---
>>   init/Kconfig                    | 8 ++++----
>>   usr/include/Makefile            | 3 +++
>>   4 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
>> index 2d1fc03d346e..16e90a3ae01b 100644
>> --- a/Documentation/kbuild/kbuild.rst
>> +++ b/Documentation/kbuild/kbuild.rst
>> @@ -77,6 +77,14 @@ HOSTLDLIBS
>>   ----------
>>   Additional libraries to link against when building host programs.
>>
>> +USERCFLAGS
>> +----------
>> +Additional options used for $(CC) when compiling userprogs.
>> +
>> +USERLDFLAGS
>> +----------
>> +Additional options used for $(LD) when linking userprogs.
> 
> Probably should note the necessity of `-Wl,` prefixes here.
> 
> Is `userprogs` cannonical? Yeah, I guess (reading
> Documentation/kbuild/makefiles.rst). I wonder if we should mention
> these in Documentation/kbuild/makefiles.rst as well? Under `5.3
> Controlling compiler options for userspace programs`.
> 

Will do.

>> +
>>   KBUILD_KCONFIG
>>   --------------
>>   Set the top-level Kconfig file to the value of this environment
>> diff --git a/Makefile b/Makefile
>> index 45278d508d81..4a55537c8ca0 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -431,15 +431,17 @@ HOSTCC    = gcc
>>   HOSTCXX        = g++
>>   endif
>>
>> -export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>> -                             -O2 -fomit-frame-pointer -std=gnu89
>> -export KBUILD_USERLDFLAGS :=
>> +KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>> +                    -O2 -fomit-frame-pointer -std=gnu89
>> +KBUILD_USERLDFLAGS := $(USERLDFLAGGS)
> 
> ^ I think there's an extra G in USERLDFLAGS above.
> 

Oops, thanks!

>>
>>   KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
>>   KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
>>   KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>>   KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>>
>> +KBUILD_USERCFLAGS   += $(USERCFLAGS)
> 
> Since you added USERLDFLAGS to KBUILD_USERLDFLAGS above where it's
> defined, why not do so for USERCFLAGS/KBUILD_USERCFLAGS as well?
> 

The initial KBUILD_USERCFLAGS above is also used in KBUILD_HOSTCFLAGS. I 
didn't think it would be wise to have USERCFLAGS from command line 
affect HOSTCFLAGS as well, since a use case might be to add 
cross-compilation flags in USERCFLAGS but not in HOSTCFLAGS. When 
Android kernel builds do get arm64 musl/bionic libc available, we will 
want it only for userprogs and not hostprogs.

>> +
>>   # Make variables (CC, etc...)
>>   CPP            = $(CC) -E
>>   ifneq ($(LLVM),)
>> @@ -530,6 +532,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
>>   export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>>   export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
>>   export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
>> +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
>>
>>   export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
>>   export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
>> diff --git a/init/Kconfig b/init/Kconfig
>> index f2ae41e6717f..164706c38e8b 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -62,13 +62,13 @@ config LLD_VERSION
>>
>>   config CC_CAN_LINK
>>          bool
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag))
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
>>
>>   config CC_CAN_LINK_STATIC
>>          bool
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
>> -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
>> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
> 
> since USERLDFLAGS get passed to $(CC), they will need `-Wl`, prefixes,
> hence the request for expanding the example usage in the commit
> message.
> 
>>
>>   config CC_HAS_ASM_GOTO
>>          def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>> diff --git a/usr/include/Makefile b/usr/include/Makefile
>> index 1c2ae1368079..6a8c7dd9ccaf 100644
>> --- a/usr/include/Makefile
>> +++ b/usr/include/Makefile
>> @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
>>   # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
>>   UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
>>
>> +# USERCFLAGS might contain sysroot location for CC
>> +UAPI_CFLAGS += $(USERCFLAGS)
>> +
> 
> Do we need to worry about USERLDFLAGS here, too? (or usr/Makefile?)
> 
>>   override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
>>
>>   # The following are excluded for now because they fail to build.
>> --
>> 2.25.1
>>
> 
> 
