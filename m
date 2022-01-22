Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2928B496C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 12:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiAVLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 06:54:08 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20047 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiAVLyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 06:54:06 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 20MBrdPx008940;
        Sat, 22 Jan 2022 20:53:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 20MBrdPx008940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642852419;
        bh=CUnEBb5uHVBsw3PFgX2PuJMtG4QUheWKXFelon3w38k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rBfmFGfkRK5nMh9BNIHkUT1yEqM4JQhB1TVNJxoLPyV7wyi64QH6g8hUZr5u7dPrV
         2/PifEaUUVDBBycbIKgaZHM1RK7JOaokAxnqtbkAjIzRaWbUEw6LLg31d92j8rn+Og
         WBqenvgBMyGy08NbMQ6UC53LrCL+whbObg7z1BffVDVOvv/WVGOaQ/6W2wHuCeEPai
         TOTRjLhiUObJAL77/jN+WzV/Yld8UyATjkQcN4wpeHWswmo7yJ620ih5E9Ip9shryw
         9S7Hk9bpHhhE/bcyec7PYqu1YASaYzrFwi7jl6yLrYwD7g8oB+BkSneeYaNGqCsjFl
         qC7Q47Splls7g==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id c9so11093295plg.11;
        Sat, 22 Jan 2022 03:53:39 -0800 (PST)
X-Gm-Message-State: AOAM53386iyuZZrV3Vh0srUrjkFZqzUsjPecsg89hpgnZtAhiIFTg+Bc
        0kQMj/mGMvgPlLiLxn04NI2ZYu6c5mGUmYZIpfA=
X-Google-Smtp-Source: ABdhPJyy5IGKiO9y9TFMAs/0upOELuHM6qYERDKj6Rs5COSeWdhrLfQOcgxXy908nE0OIUGyHgWYZXQTvJmH+0XyvvE=
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr2625927pjb.119.1642852418334;
 Sat, 22 Jan 2022 03:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20220119135147.1859982-1-amadeuszx.slawinski@linux.intel.com>
 <YeiAa/eCxVZC+QbS@archlinux-ax161> <YeiaAgQ+gbZYTMwD@archlinux-ax161>
 <5f5bd99e-4bd3-bc88-b6c5-e414a6608a96@linux.intel.com> <YerjqBrxXwjMzCRZ@archlinux-ax161>
In-Reply-To: <YerjqBrxXwjMzCRZ@archlinux-ax161>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 22 Jan 2022 20:53:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPWBz4-pF4Doom=_3WqDyghSGH+rUUVtWwmj48qsp1=w@mail.gmail.com>
Message-ID: <CAK7LNATPWBz4-pF4Doom=_3WqDyghSGH+rUUVtWwmj48qsp1=w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix build with scan-build
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 1:47 AM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> On Fri, Jan 21, 2022 at 12:20:39PM +0100, Amadeusz S=C5=82awi=C5=84ski wr=
ote:
> > On 1/20/2022 12:08 AM, Nathan Chancellor wrote:
> > > On Wed, Jan 19, 2022 at 02:19:39PM -0700, Nathan Chancellor wrote:
> > > > On Wed, Jan 19, 2022 at 02:51:47PM +0100, Amadeusz S=C5=82awi=C5=84=
ski wrote:
> > > > > When building kernel with scan-build for analysis:
> > > > > $ scan-build make defconfig
> > > > > $ scan-build make menuconfig # disable RETPOLINE
> > > > > $ scan-build make -j16 bindeb-pkg
> > > > > since commit 7d73c3e9c514 ("Makefile: remove stale cc-option chec=
ks")
> > > > > it fails with:
> > > > >    CC      scripts/mod/empty.o
> > > > > could not find clang line
> > > > > make[4]: *** [scripts/Makefile.build:287: scripts/mod/empty.o] Er=
ror 1
> > > > >
> > > > > Seems like changes to how -fconserve-stack support was detected b=
roke
> > > > > build with scan-build. Revert part of mentioned commit which chan=
ged
> > > > > that.
> > > > >
> > > > > Fixes: 7d73c3e9c514 ("Makefile: remove stale cc-option checks")
> > > > > CC: Nick Desaulniers <ndesaulniers@google.com>
> > > > > Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@=
linux.intel.com>
> > > > > Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> > > > > ---
> > > > >   Makefile | 4 +---
> > > > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 765115c99655..1174ccd182f5 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -991,9 +991,7 @@ KBUILD_CFLAGS       +=3D -fno-strict-overflow
> > > > >   KBUILD_CFLAGS  +=3D -fno-stack-check
> > > > >   # conserve stack if available
> > > > > -ifdef CONFIG_CC_IS_GCC
> > > > > -KBUILD_CFLAGS   +=3D -fconserve-stack
> > > > > -endif
> > > > > +KBUILD_CFLAGS   +=3D $(call cc-option,-fconserve-stack)
> > > > >   # Prohibit date/time macros, which would make the build non-det=
erministic
> > > > >   KBUILD_CFLAGS   +=3D -Werror=3Ddate-time
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > Okay, I think I understand why this happens...
> > > >
> > > > scan-build points CC to its CC wrapper [1], ccc-analyzer, which bui=
lds the
> > > > code with a compiler [2] then runs clang for the static analyzer [3=
].
> > > > The problem is that the default compiler for ccc-analyzer is GCC, w=
hich
> > > > means that CONFIG_CC_IS_GCC gets set and flags that are supported b=
y GCC
> > > > but not clang will cause the clang analyzer part of ccc-analyzer to
> > > > error because ccc-analyzer just passes all '-f' flags along [4].
> > > >
> > > > Prior to 7d73c3e9c514, there was no error because cc-option would r=
un
> > > > the flag against ccc-analyzer, which would error out for the reason=
 I
> > > > just described, which would prevent the flag from getting added to
> > > > KBUILD_CFLAGS.
> > > >
> > > > Now, -fconserve-stack gets passed along to both gcc and clang but c=
lang
> > > > does not recognize it and errors out.
> > > >
> > > > This should be fixed in clang, which already has the machinery to
> > > > recognize but ignore GCC flags for compatibility reasons (which is
> > > > probably how gcc and clang can use the same flags). I have pushed a
> > > > patch to Phabricator for review:
> > > >
> > > > https://reviews.llvm.org/D117717
> > > >
> > > > You need to disable CONFIG_RETPOLINE for the same reason but I don'=
t
> > > > think working around that in clang is as simple.
> > > >
> > > > Until that fix can proliferate through distributions and such, this=
 is
> > > > not an unreasonable workaround (unless Masahiro or Nick have a bett=
er
> > > > idea) but I would really like a comment so that we can revert this =
once
> > > > that fix is more widely available (it is unlikely that clang will
> > > > actually support this option).
> > > >
> > > > [1]: https://github.com/llvm/llvm-project/blob/3062a1469da0569e714a=
a4634b29345f6d8c874c/clang/tools/scan-build/bin/scan-build#L1080
> > > > [2]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece7=
21df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L457
> > > > [3]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece7=
21df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L783
> > > > [4]: https://github.com/llvm/llvm-project/blob/fd0782a37bbf7dd4ece7=
21df92c703a381595661/clang/tools/scan-build/libexec/ccc-analyzer#L661-L665
> > >
> > > Thinking more about this after Fangrui commented on the clang patch
> > > above, using scan-build with GCC as the compiler is going to be hard =
to
> > > support, as we are basically trying to support using two different
> > > compilers with a unified set of '-f' flags, which I see as problemati=
c
> > > for a few reasons.
> > >
> > > 1. It restricts our ability to do cc-option cleanups like Nick did.
> > >
> > > We should be eliminating cc-option calls that we know are specific to
> > > one compiler because checking the Kconfig variables (CONFIG_CC_IS_...=
)
> > > is much cheaper than invoking the compiler.
> > >
> > > 2. Necessary GCC specific flags will get dropped.
> > >
> > > Adding back the call to cc-option will allow the build to succeed but=
 it
> > > drops the flag from KBUILD_CFLAGS. If there were ever a time where an
> > > '-f' flag was needed to get a working kernel with GCC, it would not g=
et
> > > added because clang would reject it.
> > >
> > > We already have a static-analyzer target that requires using CC=3Dcla=
ng so
> > > I think there is some precedent here to say we require the kernel to =
be
> > > built with clang to use the static analyzer. The fact that it did pri=
or
> > > to 7d73c3e9c514 can just be chalked up to luck.
> > >
> > > $ make -j"$(nproc)" LLVM=3D1 defconfig bindeb-pkg static-analyzer
> > >
> > > would be the equivalent command to the original patch.
> > >
> > > You can still use scan-build with the '--use-cc=3Dclang' flag, which =
will
> > > use clang for the compilation and analysis, if you so prefer.
> > >
> > > Masahiro and Nick may have further thoughts and I am open to other
> > > opinions but my vote is to say this is an issue we won't fix or
> > > workaround.
> > >
> > > Cheers,
> > > Nathan
> >
> >
> > Thank you for detailed explanation. Well I guess question then is: how =
much
> > scan-build is supported? And if it should even support mixing clang and=
 gcc?
> > Alternatively maybe use clang as default if CC environment variable is =
not
> > set?
>
> It probably shouldn't, as least not in the way that it currently does.
> Someone on the LLVM review I created suggested it should add a filter
> for flags that clang does not support from GCC. I think changing the
> default would be another good fix but doesn't fix the issue if someone
> does actually wants to use GCC for building.
>
> > What I like about scan-build is that it generates html report file.
>
> Ah, that is a good point.
>
> > '--use-cc=3Dclang' worked fine for me.
> >
> > I've also tried
> > > $ make -j"$(nproc)" LLVM=3D1 defconfig bindeb-pkg static-analyzer
> > although there seems to be no static-analyzer target, I guess you meant
> > clang-analyzer instead, but although it seems to generate a lot of text=
 on
> > terminal, it doesn't seem that useful to me. Not sure if this is expect=
ed?
>
> Yes, my apologies, it should have been clang-analyzer.
>
> > Quoting a piece of log:
> > ./include/linux/xarray.h:54:2: error: expected '(' after 'asm'
> > [clang-diagnostic-error]
> >         WARN_ON((long)v < 0);
> >         ^
> > ./include/asm-generic/bug.h:123:3: note: expanded from macro 'WARN_ON'
> >                 __WARN();                                              =
 \
> >                 ^
> > ./include/asm-generic/bug.h:96:19: note: expanded from macro '__WARN'
> > #define __WARN()                __WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
> >                                 ^
> > ./arch/x86/include/asm/bug.h:79:2: note: expanded from macro '__WARN_FL=
AGS'
> >         _BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));           \
> >         ^
> > ./arch/x86/include/asm/bug.h:27:2: note: expanded from macro '_BUG_FLAG=
S'
> >         asm_inline volatile("1:\t" ins "\n"                            =
 \
> >         ^
> > ./include/linux/compiler_types.h:281:24: note: expanded from macro
> > 'asm_inline'
> > #define asm_inline asm __inline
> >                        ^
> > ./include/linux/xarray.h:1616:2: error: expected '(' after 'asm'
> > [clang-diagnostic-error]
> >         BUG_ON(order > 0);
> >         ^
> > ./include/asm-generic/bug.h:65:57: note: expanded from macro 'BUG_ON'
> > #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while =
(0)
> >                                                         ^
> > ./arch/x86/include/asm/bug.h:66:2: note: expanded from macro 'BUG'
> >         _BUG_FLAGS(ASM_UD2, 0);                                 \
> >         ^
> > ./arch/x86/include/asm/bug.h:27:2: note: expanded from macro '_BUG_FLAG=
S'
> >         asm_inline volatile("1:\t" ins "\n"                            =
 \
> >         ^
> > ./include/linux/compiler_types.h:281:24: note: expanded from macro
> > 'asm_inline'
> > #define asm_inline asm __inline
> >                        ^
> > Found compiler error(s).
> > 21 errors generated.
> > Error while processing /home/xxxxxxxx/linux/drivers/hid/hid-ezkey.c.
> > error: too many errors emitted, stopping now [clang-diagnostic-error]
> > error: unknown argument: '-fno-stack-clash-protection'
> > [clang-diagnostic-error]
> > error: unknown warning option '-Wno-frame-address'; did you mean
> > '-Wno-address'? [clang-diagnostic-unknown-warning-option]
> > error: unknown warning option '-Wno-pointer-to-enum-cast'; did you mean
> > '-Wno-pointer-compare'? [clang-diagnostic-unknown-warning-option]
> >
> >
> > Unless I did something wrong, this doesn't seem that useful to me compa=
red
> > to what I get from scan-build?
>
> I do not see that error but I have little experience with running the
> clang-analyzer target. It might be due to a difference between
> scan-build and clang-tidy? Regardless, it seems like you prefer reading
> the HTML report, so sticking with scan-build with the '--use-cc=3Dclang'
> flag will be the way to go.
>
> Cheers,
> Nathan



As far as I understood, the conclusion is

[1] There is nothing to fix on the Kbuild side.
     (So, this patch was rejected)


[2] If you want to use scan-build for kbuild,
        "scan-build --use-cc=3Dclang" should work properly.

   The "disable RETPOLINE' workaround is also unneeded.

  $ scan-build --use-cc=3Dclang make -j16 defconfig bindeb-pkg

   should be enough


[3]  If scan-build supports mixed-compilers, it is up to LLVM community.
      If they are happy, they will carry the pain of maintaining ignored fl=
ags.



The detection of retpoline flags is not working somehow.

$ /usr/share/clang/scan-build-13/bin/../libexec/ccc-analyzer
-mindirect-branch=3Dthunk-extern  -c -x c /dev/null -o /dev/null
could not find clang line
$ /usr/share/clang/scan-build-13/bin/../libexec/ccc-analyzer
-mretpoline-external-thunk  -c -x c /dev/null -o /dev/null
gcc: error: unrecognized command-line option =E2=80=98-mretpoline-external-=
thunk=E2=80=99

I think this should be fixed.


--=20
Best Regards
Masahiro Yamada
