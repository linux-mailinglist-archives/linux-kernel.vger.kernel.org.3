Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F3591E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiHNFbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHNFbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:31:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23E29818
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:31:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r22so4091537pgm.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=63vCrw4vDFOETB8ml7DPtAOLojQ7OMkXCWMliW0/M10=;
        b=epCNDU7JVDC6owE/qkLf4QELmOvwM0FnLboTc6k3qOq39MPCmmnSw9nXJgAbHZF3rm
         uPrREfahHoCrjLOs6CrKqZHhKCkw9nsVEewTF2y5OM8x64IGcGDx/LoJs4l9l+35qD2a
         OCbcZkzw01o6AFDJEtd4rrVEP0fpTPph7PcMq0qmND9BEtTijkXfLhDjfqIhiu6yX4r4
         XiD9VW9sTj8S3ezeFlbnBLjlIoQpAMvCh1muBZLOqAfbxjeo25lQ1Nd60ymFm3N2CUwV
         L2ABnoKCOYI2tVZgeFVR/yAEtnnIhN1yfkTnWEMh1WeJM/I8W2WFV321MM9ysRQhylHE
         ldIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=63vCrw4vDFOETB8ml7DPtAOLojQ7OMkXCWMliW0/M10=;
        b=6un2TVIpUs61fHDtTQgj5HOZKsMgfHk90OvOEywixWXCuL6RisTRI92LXFga2Yi8ki
         xDgVx4ife/AdssBYnbyaT6TRUSg8/WKL8c3uJPNhKz1ccn7PV2sJygW0+NPjU1tzHMOH
         IEdFOuGsRRkdb/q8HRt+E0SPzCMa63nVebyTJkV+ZTOtTHEtAJvmVyyV5ELme5LIPBgj
         /s3kBZKEMe2hjQKjJ4NTR2ynZVQ5lBS6UPZnUYEFut4VGSep3GU06LztZXyLB8KJHQcG
         E5ZX4qY72QIUeuYLnZiWfQOeS0rea9Rs9DM574XUE/6Rw6FECVoZ4vPXFRoRbWC70E26
         L1Ag==
X-Gm-Message-State: ACgBeo3gNdvYpKmGcIwEuShO2qOWpyOPoyK5Xk9J8uF0SXGnvGFk4/Kr
        qfcY2N6fFybCIg1Mak6SGIqBeg==
X-Google-Smtp-Source: AA6agR5ctJtGhGZpPyUT3TAX3uIN/QIgFC52P1vup48lHmX/omCLLx+FHXwFk8urI9bKJC7ECV7XOQ==
X-Received: by 2002:a63:e011:0:b0:41c:506f:cf04 with SMTP id e17-20020a63e011000000b0041c506fcf04mr8955474pgh.120.1660455090710;
        Sat, 13 Aug 2022 22:31:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8a53:8642:81d6:a0ef])
        by smtp.gmail.com with ESMTPSA id fs1-20020a17090af28100b001f246f2a423sm2542205pjb.17.2022.08.13.22.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:31:30 -0700 (PDT)
Date:   Sat, 13 Aug 2022 22:31:24 -0700
From:   Fangrui Song <maskray@google.com>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v2] kbuild: add configurable debug info level
Message-ID: <20220814053124.fsj3bqamrqyfoiey@google.com>
References: <20220814002021.16990-1-dmitrii.bundin.a@gmail.com>
 <CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-14, Masahiro Yamada wrote:
>+CC: Fangrui Song <maskray@google.com>
>
>
>
>
>On Sun, Aug 14, 2022 at 9:25 AM Dmitrii Bundin
><dmitrii.bundin.a@gmail.com> wrote:
>>
>> Provides a way to configure debug info level (-glevel).
>> Debug level 3 includes extra information such as macro definitions. With
>> level 3 enabled it's possible to expand macros right from the debugging
>> session in gdb simplifying debugging when complicated macros involved.
>> The default level is set to 2 to not change the default build behavior.

GCC -g3 generates macro information (in the .debug_macro section).

In Clang, -g = -g2 = -g3. To generate macro information,
specify -fdebug-macro.
The different choice is known in the initial implementation https://reviews.llvm.org/D16135 .

Not generating macro information for -g3 (i.e. diverging from GCC
behavior) makes some sense to me: -fstandalone-debug will probably be
more suitable as -g3 (it retains some type debug info for C++ (the code
after https://github.com/llvm/llvm-project/blob/b2f31cac28c8a03ceb908b544f5790f4f9f2d9ab/clang/lib/CodeGen/CGDebugInfo.cpp#L2497-L2499).

>> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
>> ---
>>
>> Changes in v2: https://lore.kernel.org/all/20220804223504.4739-1-dmitrii.bundin.a@gmail.com/
>>   - Replace hardcoded -g3 with a configurable debug info level
>>
>>  lib/Kconfig.debug      | 11 +++++++++++
>>  scripts/Makefile.debug |  2 +-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 2e24db4bff19..a17c12c20290 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -304,6 +304,17 @@ config DEBUG_INFO_REDUCED
>>           DEBUG_INFO build and compile times are reduced too.
>>           Only works with newer gcc versions.
>>
>> +config DEBUG_INFO_LEVEL
>> +       int "Debug info level"
>> +       range 0 3
>> +       default "2"
>> +       help
>> +         Sets the level of how much debug information to generate (-glevel).
>> +         Level 1 produces minimal debug information without including information
>> +         about local variables. Level 3 includes extra information like macro
>> +         definitions. Setting up level 3 will require significantly more disk
>> +         space and increase built time. Level 0 produces no debug information.
>> +
>
>
>
>We already have CONFIG_DEBUG_INFO_NONE to
>disable the debug info.
>
>
>The combination of CONFIG_DEBUG_INFO=y and
>CONFIG_DEBUG_INFO_LEVEL=0  (-g0)
>would emulate CONFIG_DEBUG_INFO_NONE ?
>
>
>
>Using 'int' does not look sensible to me.
>
>
>
>
>
>>  config DEBUG_INFO_COMPRESSED
>>         bool "Compressed debugging information"
>>         depends on $(cc-option,-gz=zlib)
>> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
>> index 9f39b0130551..28beffc42e71 100644
>> --- a/scripts/Makefile.debug
>> +++ b/scripts/Makefile.debug
>> @@ -3,7 +3,7 @@ DEBUG_CFLAGS    :=
>>  ifdef CONFIG_DEBUG_INFO_SPLIT
>>  DEBUG_CFLAGS   += -gsplit-dwarf
>>  else
>> -DEBUG_CFLAGS   += -g
>> +DEBUG_CFLAGS   += -g$(CONFIG_DEBUG_INFO_LEVEL)
>>  endif
>>
>>  ifndef CONFIG_AS_IS_LLVM
>> --
>> 2.17.1
>>
>
>
>I want to consult Fangrui Song for this part.
>
>
>With this Makefile code, CONFIG_DEBUG_INFO_SPLIT
>takes the presidency over CONFIG_DEBUG_INFO_LEVEL.
>
>
>When CONFIG_DEBUG_INFO_SPLIT is enabled (-gsplit-dwarf),
>it always uses the default -g2 level.
>CONFIG_DEBUG_INFO_LEVEL is just ignored silently.
>
>
>
>It might be sensible in older GCC/Clang behavior because
>-gsplit-dwarf implied -g2.
>
>
>But, with this commit:
>https://reviews.llvm.org/D80391
>
>-gsplit-dwarf and -g<level> are orthogonal
>for GCC 11+/Clang 12+, correct?

Correct.

>I think "splitting debug files" and "debug level"
>should be controlled independently.
>(but it depends on the compiler version, if I understood correctly)

Before GCC 11 and Clang 12, -gsplit-dwarf implied -g2 (older
-gsplit-dwarf is like today's `-gsplit-dwarf -g2`).

GCC 11 and Clang 12 (https://reviews.llvm.org/D80391) have changed
-gsplit-dwarf to not imply -g2.

For a group of -g0 -g1 -g2, the last option wins.  Therefore,

-g0 -gsplit-dwarf => debug info in GCC<11 and Clang<12
-g0 -gsplit-dwarf => no debug info in GCC>=11 and Clang>=12
