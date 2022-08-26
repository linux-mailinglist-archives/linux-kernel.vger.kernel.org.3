Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287CF5A3037
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbiHZTwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiHZTwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:52:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44599E68ED
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:52:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id l1so3277969lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mvyJ+Tn0W7GOVforLC2vhB6VbcqK7WY1nq8zsz0n0LY=;
        b=acyPP/v/CPMGXSHhKa6MmW/eKD8bHJzOuWacVrMhTJmj4IkKzCwNRO9R8tMvzL6J1o
         pcUi0HEh2C0dSBDXnN3ZkbaoXawDbZsSpZeUmqDQj9TDjEFH51zrMiDSY743SUfMOnkC
         EIEScB5exyDkMVx63RdbRWnZ1yRDk7+Q6NobjScH9upNrPCDNmUQMQobtxLsJmZ2fZAV
         GHNfqsAPcUcoUC6mnjno57aB33NnlvPllmG8loT9D/ejrXI8hIUSoqfpaMd74Joz85x8
         VRUKXpLFgX0Tki+RZm66Qwbd23TQH/+WWD+eCir4By3Puj/syOCumQmpJKcnPH3WkjVs
         c0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mvyJ+Tn0W7GOVforLC2vhB6VbcqK7WY1nq8zsz0n0LY=;
        b=zFSeejmBpUIXKFltmSovY1zw2aD5KHtCN4WDbcJE/NkbFs3oQlFhUw6hbENqU21p0n
         ypVgHToXimkXQQ8ZJ83lDtoeb/4JvGEiMHHI3R/HZ0RtoHKbSutmy3JdXZg8bZT32DRe
         18PdZ4e0qG8KOtrbLNYkWdkFkoNkP8ufZZLfVqb8lDhRnvBakfoauef+GUwnL4VEnHs6
         hr1/hN9TrGCkW33quMAvfZyM0eDlKQjp/mXM2wjYwlSi0x5AHwWzeezl7qZ89AoN7Al5
         4r1N4QRDnEz3CzAPHLPfW7rRySxyz7/9uS6oy2ujXZKzeEnYGsgm9jKMxlTWRuJhB/bA
         rhpQ==
X-Gm-Message-State: ACgBeo3xcINGd0wome/e64nK6EiXPlfCbLceTdUYyRRvfJNkK6TOhuWF
        GQS6YPZ474wm+UoDe2XNhR70415ewXV01jf0GQibyQ==
X-Google-Smtp-Source: AA6agR7J5J9WO3vFUXX3Xvuw9h7ybz8Uve3m5bhR9VCxiCybF8zHic6IcjhVGvCazKPZQqOXidsCQ5VZ1DIygR3J95c=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr3308421lfr.647.1661543535378; Fri, 26
 Aug 2022 12:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220826181035.859042-1-ndesaulniers@google.com>
 <20220826181035.859042-3-ndesaulniers@google.com> <CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com>
In-Reply-To: <CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Aug 2022 12:52:04 -0700
Message-ID: <CAKwvOdnPjYNFy3r01TBohrZbRGFafGuWaPa8u6b2JdgH=0tKKg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile.debug: re-enable debug info for .S files
To:     Bill Wendling <morbo@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 11:41 AM Bill Wendling <morbo@google.com> wrote:
>
> On Fri, Aug 26, 2022 at 11:10 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Alexey reported that the fraction of unknown filename instances in
> > kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
> > to assembler defined symbols, which regressed as a result of:
> >
> > commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
> >
> > In that commit, I allude to restoring debug info for assembler defined
> > symbols in a follow up patch, but it seems I forgot to do so in
> >
> > commit a66049e2cf0e ("Kbuild: make DWARF version a choice")
> >
> > This patch does a few things:
> > 1. Add -g to KBUILD_AFLAGS. This will instruct the compiler to instruct
> >    the assembler to emit debug info. But this can cause an issue for
> >    folks using a newer compiler but older assembler, because the
> >    implicit default DWARF version changed from v4 to v5 in gcc-11 and
> >    clang-14.
> > 2. If the user is using CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, use a
> >    version check to explicitly set -Wa,-gdwarf-<version> for the
> >    assembler. There's another problem with this; GAS only gained support
> >    for explicit DWARF versions 3-5 in the 2.36 GNU binutils release.
> > 3. Wrap -Wa,-gdwarf-<version> in as-option call to test whether the
> >    assembler supports that explicit DWARF version.
> >
> > Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> > Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
> > Reported-by: Alexey Alexandrov <aalexand@google.com>
> > Reported-by: Bill Wendling <morbo@google.com>
> > Reported-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  scripts/Makefile.debug | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> > index 9f39b0130551..a7a6da7f6e7d 100644
> > --- a/scripts/Makefile.debug
> > +++ b/scripts/Makefile.debug
> > @@ -4,18 +4,32 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
> >  DEBUG_CFLAGS   += -gsplit-dwarf
> >  else
> >  DEBUG_CFLAGS   += -g
> > +KBUILD_AFLAGS  += -g
> >  endif
> >
> > -ifndef CONFIG_AS_IS_LLVM
> > -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> > +ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > +# gcc-11+, clang-14+
> > +ifeq ($(shell [ $(CONFIG_GCC_VERSION) -ge 110000 -o $(CONFIG_CLANG_VERSION) -ge 140000 ] && echo y),y)
>
> Do you think this would be better as a macro? Maybe something like:
>
> if $(call cc-min-version,110000,140000)
>
> where the first argument is GCC's min version and second Clang's min
> version. It would be more readable and reusable.

Yeah!

I was looking at cc-ifversion, which has a bug in that it specifically
uses CONFIG_GCC_VERSION.  I think I sent a series maybe a year or two
ago trying to remove all users of that macro; I think most landed but
not all and I never pursued it to completion.  Also, I think there's
one user remaining in the AMDGPU drivers; looks like they're been
reducing their dependency on that SIMD hack I wrote for them years ago
after propagating it to parts of their tree, but one user remains.
Perhaps I can just open code it there, or replace it with something
new like you suggest.

Such a macro would need to consider whether CC_IS_GCC vs CC_IS_CLANG;
I could imagine we might need a version check for both, or just one of
the two compilers.

Ugh, logical OR in GNU make is supported by use of the filter macro...yuck.

ifneq ($(filter y, $(call gcc-min-version, 110000), $(call
clang-min-version, 140000),)
# add gcc-11+, clang-14+ flag
endif

or maybe as you suggest:

ifneq ($(call cc-min-version,110000,140000),)
# add gcc-11+, clang-14+ flag
endif

where the newly minted cc-min-version is implemented in terms of the
newly minted gcc-min-version and clang-min-version.  Then I can use
cc-min-version in this series, and replace cc-ifversion in AMDGPU with
gcc-min-version.  That way, we create composable wrappers that are
readable and reusable.

>
> -bw
>
> > +dwarf-version-y := 5
> > +else
> > +dwarf-version-y := 4
> >  endif
> > -
> > -ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > +else # !CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> >  dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
> >  DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> >  endif
> >
> > +# Binutils 2.35+ (or clang) required for -gdwarf-{4|5}.
> > +# https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
> > +ifneq ($(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y)),)
> > +KBUILD_AFLAGS  += -Wa,-gdwarf-$(dwarf-version-y)
> > +else
> > +ifndef CONFIG_AS_IS_LLVM
> > +KBUILD_AFLAGS  += -Wa,-gdwarf-2
> > +endif
> > +endif
> > +
> >  ifdef CONFIG_DEBUG_INFO_REDUCED
> >  DEBUG_CFLAGS   += -fno-var-tracking
> >  ifdef CONFIG_CC_IS_GCC
> > --
> > 2.37.2.672.g94769d06f0-goog
> >



-- 
Thanks,
~Nick Desaulniers
