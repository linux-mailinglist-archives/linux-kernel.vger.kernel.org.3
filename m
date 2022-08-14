Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1036592613
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiHNS7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiHNS7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:59:20 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9C12AB5;
        Sun, 14 Aug 2022 11:59:18 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27EIwu5n007756;
        Mon, 15 Aug 2022 03:58:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27EIwu5n007756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660503537;
        bh=BbpQ1LHYl4BgPwrCHAz8cDe0TOb/vzaY12xTvn0Be58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V5TOKZlOhkBlLzqoPumlZ5iintieD/DWKIjNwcI1exDDsLZDcBpELs3cSqK+kHNKY
         6RKteCgYFp3lVMpe8zEQlDMI4FIKc6enlFgKwnyG7c30XkdfP2ZtkLj0SEqebFWpxp
         dzFmTrrxXB9EdRu/ylQEsqW8d6jM288stjrYap2Jw1834JnwO/6GfHlIHrQwIQQ1jB
         oFckm6cjdtjfhvLogjk/PTgHnjKMT+2M09VU/ZVlFa4rd9iuEEUmuT1K7aVNAbofh2
         t2gVBCo90Odiukmrg7AF0A6QPWOxi2Zeg4X96m9OXewWLTtXM6Ob8aakkxuLMVHD/Z
         c97C/EOSSAtxA==
X-Nifty-SrcIP: [209.85.128.46]
Received: by mail-wm1-f46.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so3002774wmb.0;
        Sun, 14 Aug 2022 11:58:57 -0700 (PDT)
X-Gm-Message-State: ACgBeo2FTRwLo8gpwBQykpy7NlCVaCD4LqiBzVBgkC+bsuT0hjt6EgsT
        LR8hBMUPGLGTl+GbbXKlGsVkWliPbBQoqFDcss4=
X-Google-Smtp-Source: AA6agR48/zHM6VkJgwpKBL+e2YZ9PYs6bf0NTYsXEDnZ9B5fqVTCmogSzuUGYwNSEqdpgKHNXBZSxGTP+FzrkH9es+o=
X-Received: by 2002:a7b:c391:0:b0:3a5:de98:f559 with SMTP id
 s17-20020a7bc391000000b003a5de98f559mr4502084wmj.157.1660503535347; Sun, 14
 Aug 2022 11:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220814002021.16990-1-dmitrii.bundin.a@gmail.com>
 <CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com> <20220814053124.fsj3bqamrqyfoiey@google.com>
In-Reply-To: <20220814053124.fsj3bqamrqyfoiey@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 15 Aug 2022 03:58:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5k3Paj=nEYFR+eYWaebPkfATcYFHuoczst4B68V3_nQ@mail.gmail.com>
Message-ID: <CAK7LNAT5k3Paj=nEYFR+eYWaebPkfATcYFHuoczst4B68V3_nQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add configurable debug info level
To:     Fangrui Song <maskray@google.com>
Cc:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 2:31 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2022-08-14, Masahiro Yamada wrote:
> >+CC: Fangrui Song <maskray@google.com>
> >
> >
> >
> >
> >On Sun, Aug 14, 2022 at 9:25 AM Dmitrii Bundin
> ><dmitrii.bundin.a@gmail.com> wrote:
> >>
> >> Provides a way to configure debug info level (-glevel).
> >> Debug level 3 includes extra information such as macro definitions. With
> >> level 3 enabled it's possible to expand macros right from the debugging
> >> session in gdb simplifying debugging when complicated macros involved.
> >> The default level is set to 2 to not change the default build behavior.
>
> GCC -g3 generates macro information (in the .debug_macro section).
>
> In Clang, -g = -g2 = -g3. To generate macro information,
> specify -fdebug-macro.
> The different choice is known in the initial implementation https://reviews.llvm.org/D16135 .
>
> Not generating macro information for -g3 (i.e. diverging from GCC
> behavior) makes some sense to me: -fstandalone-debug will probably be
> more suitable as -g3 (it retains some type debug info for C++ (the code
> after https://github.com/llvm/llvm-project/blob/b2f31cac28c8a03ceb908b544f5790f4f9f2d9ab/clang/lib/CodeGen/CGDebugInfo.cpp#L2497-L2499).
>
> >> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> >> ---
> >>
> >> Changes in v2: https://lore.kernel.org/all/20220804223504.4739-1-dmitrii.bundin.a@gmail.com/
> >>   - Replace hardcoded -g3 with a configurable debug info level
> >>
> >>  lib/Kconfig.debug      | 11 +++++++++++
> >>  scripts/Makefile.debug |  2 +-
> >>  2 files changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index 2e24db4bff19..a17c12c20290 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -304,6 +304,17 @@ config DEBUG_INFO_REDUCED
> >>           DEBUG_INFO build and compile times are reduced too.
> >>           Only works with newer gcc versions.
> >>
> >> +config DEBUG_INFO_LEVEL
> >> +       int "Debug info level"
> >> +       range 0 3
> >> +       default "2"
> >> +       help
> >> +         Sets the level of how much debug information to generate (-glevel).
> >> +         Level 1 produces minimal debug information without including information
> >> +         about local variables. Level 3 includes extra information like macro
> >> +         definitions. Setting up level 3 will require significantly more disk
> >> +         space and increase built time. Level 0 produces no debug information.
> >> +
> >
> >
> >
> >We already have CONFIG_DEBUG_INFO_NONE to
> >disable the debug info.
> >
> >
> >The combination of CONFIG_DEBUG_INFO=y and
> >CONFIG_DEBUG_INFO_LEVEL=0  (-g0)
> >would emulate CONFIG_DEBUG_INFO_NONE ?
> >
> >
> >
> >Using 'int' does not look sensible to me.
> >
> >
> >
> >
> >
> >>  config DEBUG_INFO_COMPRESSED
> >>         bool "Compressed debugging information"
> >>         depends on $(cc-option,-gz=zlib)
> >> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> >> index 9f39b0130551..28beffc42e71 100644
> >> --- a/scripts/Makefile.debug
> >> +++ b/scripts/Makefile.debug
> >> @@ -3,7 +3,7 @@ DEBUG_CFLAGS    :=
> >>  ifdef CONFIG_DEBUG_INFO_SPLIT
> >>  DEBUG_CFLAGS   += -gsplit-dwarf
> >>  else
> >> -DEBUG_CFLAGS   += -g
> >> +DEBUG_CFLAGS   += -g$(CONFIG_DEBUG_INFO_LEVEL)
> >>  endif
> >>
> >>  ifndef CONFIG_AS_IS_LLVM
> >> --
> >> 2.17.1
> >>
> >
> >
> >I want to consult Fangrui Song for this part.
> >
> >
> >With this Makefile code, CONFIG_DEBUG_INFO_SPLIT
> >takes the presidency over CONFIG_DEBUG_INFO_LEVEL.
> >
> >
> >When CONFIG_DEBUG_INFO_SPLIT is enabled (-gsplit-dwarf),
> >it always uses the default -g2 level.
> >CONFIG_DEBUG_INFO_LEVEL is just ignored silently.
> >
> >
> >
> >It might be sensible in older GCC/Clang behavior because
> >-gsplit-dwarf implied -g2.
> >
> >
> >But, with this commit:
> >https://reviews.llvm.org/D80391
> >
> >-gsplit-dwarf and -g<level> are orthogonal
> >for GCC 11+/Clang 12+, correct?
>
> Correct.
>
> >I think "splitting debug files" and "debug level"
> >should be controlled independently.
> >(but it depends on the compiler version, if I understood correctly)
>
> Before GCC 11 and Clang 12, -gsplit-dwarf implied -g2 (older
> -gsplit-dwarf is like today's `-gsplit-dwarf -g2`).
>
> GCC 11 and Clang 12 (https://reviews.llvm.org/D80391) have changed
> -gsplit-dwarf to not imply -g2.
>
> For a group of -g0 -g1 -g2, the last option wins.  Therefore,
>
> -g0 -gsplit-dwarf => debug info in GCC<11 and Clang<12
> -g0 -gsplit-dwarf => no debug info in GCC>=11 and Clang>=12



Thanks.
I tested GCC 9 on Ubuntu 22.04.
"-g3 -gsplit-dwarf" produces .debug_macro

In old behavior, -gsplit-dwarf upgrades the level, but
does not downgrade it, correct?





 [Old behavior]
     -g0 -gsplit-dwarf  --> level 2      (gsplit-dwarf upgrade 0 to 2)
     -gsplit-dwarf -g0  --> level 0      (the last -g0 wins)
     -g3 -gsplit-dwarf  --> level 3      (gsplit-dwarf does not downgrade)
     -g2 -g3            --> level 3      (the last -g3 wins)
     -g3 -g2            --> level 2      (the last -g2 wins)

 [New behavior]
     -g0 -gsplit-dwarf  --> level 0      (the options are orthogonal)
     -gsplit-dwarf -g0  --> level 0      (the options are orthogonal)
     -g3 -gsplit-dwarf  --> level 3      (the options are orthogonal)
     -g2 -g3            --> level 3      (the last -g3 wins)
     -g3 -g2            --> level 2      (the last -g2 wins)








masahiro@grover:/tmp/foo$ gcc-9 --version
gcc-9 (Ubuntu 9.4.0-5ubuntu1) 9.4.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

masahiro@grover:/tmp/foo$ rm -f *.dwo
masahiro@grover:/tmp/foo$ gcc-9    -gsplit-dwarf  -o foo  foo.c
masahiro@grover:/tmp/foo$ readelf  -S foo.dwo
There are 9 section headers, starting at offset 0x840:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .debug_info.dwo   PROGBITS         0000000000000000  00000040
       0000000000000217  0000000000000000   E       0     0     1
  [ 2] .debug_abbrev.dwo PROGBITS         0000000000000000  00000257
       00000000000000cb  0000000000000000   E       0     0     1
  [ 3] .debug_line.dwo   PROGBITS         0000000000000000  00000322
       00000000000000e5  0000000000000000   E       0     0     1
  [ 4] .debug_str_o[...] PROGBITS         0000000000000000  00000407
       00000000000000d4  0000000000000000   E       0     0     1
  [ 5] .debug_str.dwo    PROGBITS         0000000000000000  000004db
       00000000000002bd  0000000000000000   E       0     0     1
  [ 6] .symtab           SYMTAB           0000000000000000  00000798
       0000000000000030  0000000000000018           7     2     8
  [ 7] .strtab           STRTAB           0000000000000000  000007c8
       0000000000000001  0000000000000000           0     0     1
  [ 8] .shstrtab         STRTAB           0000000000000000  000007c9
       0000000000000073  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), l (large), p (processor specific)
masahiro@grover:/tmp/foo$ rm -f *.dwo
masahiro@grover:/tmp/foo$ gcc-9  -g3  -gsplit-dwarf  -o foo  foo.c
masahiro@grover:/tmp/foo$ readelf  -S foo.dwo
There are 32 section headers, starting at offset 0x77f8:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .debug_info.dwo   PROGBITS         0000000000000000  00000040
       0000000000000245  0000000000000000   E       0     0     1
  [ 2] .debug_abbrev.dwo PROGBITS         0000000000000000  00000285
       00000000000000ce  0000000000000000   E       0     0     1
  [ 3] .debug_macro.dwo  PROGBITS         0000000000000000  00000353
       000000000000014a  0000000000000000   E       0     0     1
  [ 4] .debug_macro.dwo  PROGBITS         0000000000000000  0000049d
       0000000000000528  0000000000000000           0     0     1
  [ 5] .debug_macro.dwo  PROGBITS         0000000000000000  000009c5
       000000000000001c  0000000000000000           0     0     1
  [ 6] .debug_macro.dwo  PROGBITS         0000000000000000  000009e1
       000000000000000c  0000000000000000           0     0     1
  [ 7] .debug_macro.dwo  PROGBITS         0000000000000000  000009ed
       000000000000010b  0000000000000000           0     0     1
  [ 8] .debug_macro.dwo  PROGBITS         0000000000000000  00000af8
       0000000000000010  0000000000000000           0     0     1
  [ 9] .debug_macro.dwo  PROGBITS         0000000000000000  00000b08
       0000000000000033  0000000000000000           0     0     1
  [10] .debug_macro.dwo  PROGBITS         0000000000000000  00000b3b
       0000000000000143  0000000000000000           0     0     1
  [11] .debug_macro.dwo  PROGBITS         0000000000000000  00000c7e
       0000000000000056  0000000000000000           0     0     1
  [12] .debug_macro.dwo  PROGBITS         0000000000000000  00000cd4
       0000000000000021  0000000000000000           0     0     1
  [13] .debug_macro.dwo  PROGBITS         0000000000000000  00000cf5
       0000000000000037  0000000000000000           0     0     1
  [14] .debug_macro.dwo  PROGBITS         0000000000000000  00000d2c
       000000000000000b  0000000000000000           0     0     1
  [15] .debug_macro.dwo  PROGBITS         0000000000000000  00000d37
       0000000000000068  0000000000000000           0     0     1
  [16] .debug_macro.dwo  PROGBITS         0000000000000000  00000d9f
       000000000000000c  0000000000000000           0     0     1
  [17] .debug_macro.dwo  PROGBITS         0000000000000000  00000dab
       0000000000000048  0000000000000000           0     0     1
  [18] .debug_macro.dwo  PROGBITS         0000000000000000  00000df3
       00000000000000a8  0000000000000000           0     0     1
  [19] .debug_macro.dwo  PROGBITS         0000000000000000  00000e9b
       000000000000000b  0000000000000000           0     0     1
  [20] .debug_macro.dwo  PROGBITS         0000000000000000  00000ea6
       0000000000000023  0000000000000000           0     0     1
  [21] .debug_macro.dwo  PROGBITS         0000000000000000  00000ec9
       0000000000000030  0000000000000000           0     0     1
  [22] .debug_macro.dwo  PROGBITS         0000000000000000  00000ef9
       0000000000000020  0000000000000000           0     0     1
  [23] .debug_macro.dwo  PROGBITS         0000000000000000  00000f19
       000000000000001d  0000000000000000           0     0     1
  [24] .debug_macro.dwo  PROGBITS         0000000000000000  00000f36
       0000000000000020  0000000000000000           0     0     1
  [25] .debug_macro.dwo  PROGBITS         0000000000000000  00000f56
       0000000000000059  0000000000000000           0     0     1
  [26] .debug_line.dwo   PROGBITS         0000000000000000  00000faf
       0000000000000255  0000000000000000   E       0     0     1
  [27] .debug_str_o[...] PROGBITS         0000000000000000  00001204
       0000000000000bd4  0000000000000000   E       0     0     1
  [28] .debug_str.dwo    PROGBITS         0000000000000000  00001dd8
       0000000000005721  0000000000000000   E       0     0     1
  [29] .symtab           SYMTAB           0000000000000000  00007500
       0000000000000270  0000000000000018          30    26     8
  [30] .strtab           STRTAB           0000000000000000  00007770
       0000000000000001  0000000000000000           0     0     1
  [31] .shstrtab         STRTAB           0000000000000000  00007771
       0000000000000084  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), l (large), p (processor specific)














-- 
Best Regards
Masahiro Yamada
