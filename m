Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A058B5AE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiHFNM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiHFNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 09:12:26 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF3D124;
        Sat,  6 Aug 2022 06:12:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=NgjIxfiLr9uAbAmk3wWQnrtGLQCUOPaOTT5Oe/ZeRt0=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220801; t=1659791521; v=1; x=1660223521;
 b=YegtRKSQr8okAdxA1AbGAlpGEYfnwiguq7kZDTIIslOWvPut/2nIAOedmBlvW7REWEONU9Wa
 4jzxRbKsKALwI+IKYslEpFnwx2N4FHzfyEszO3GM7H5rF+bdEz895lZ7VcziIdGyFhRAmwUKDAP
 iSQHTTBW4c0yU7Lcr+Ethr89BAryagv5lb5sGbqPqXQQzheKUKZqtHVGp+fXjId/2mjHAJ2GbuA
 U+sjU8auY+GuL9dOCG8r3gyVykYYPYYMbtV8TzGamNsQnb0gAjS4RvxAyeQyHrpLQ6vJ2H1YDV5
 j9uAgdKAmXkwlNX77atViCljK9JqmHGfnRYqa3xRN+2TiKj3jwsC4Rtw/1GLD7d0GcJLhAO4w4y
 6hJ75Xxn+h7YeulZEMYDgpZD7krL+zVv+yDDaIp5SE5G7WuuJ1YkJnNrBFgR7rdGcUjNjT7TjGt
 POTVflo6etSRCsq9znc86mHDwxE7zJemIC7U097DzzSj+ZSgTsRkSe4pQFIWQaq7xC9LcTcjupZ
 qrnLvre7YX2QjeeKnV80gnZqGoNagrseyxMsYdB+VEvod0Hfo7QqGaqwl9yGuaLCNRKVrF7xWRv
 1GThAViZZpCPniUwXYRQPIdPEaQX6p97JDQSqtmTDlevsqlYqFPN8VskQ4Nf9e4275Dj5ZkoVax
 pYHoZr0Jmv8=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 12a86f0d; Sat, 06 Aug
 2022 09:12:01 -0400
MIME-Version: 1.0
Date:   Sat, 06 Aug 2022 09:12:01 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     sedat.dilek@gmail.com
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
In-Reply-To: <CA+icZUWkDEZhJ+fVGPJ3LE5p9k0yWjg-XtAk7evES2crjbADUA@mail.gmail.com>
References: <20220513113930.10488-1-masahiroy@kernel.org>
 <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <2c496d24174e63b27ec047f383df6700@matoro.tk>
 <CA+icZUWkDEZhJ+fVGPJ3LE5p9k0yWjg-XtAk7evES2crjbADUA@mail.gmail.com>
Message-ID: <ad42a7c6886648982bc82c2f75c6707b@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sedat - I pulled these configs from the running systems, but I used 
"make olddefconfig" on these working 5.18 configs to generate the 
corresponding 5.19 configs that failed to boot.  I'll see if I can go 
back in and repeat this process to regen the 5.19 configs (I deleted it 
all after 5.19 failed to boot).

-------- Original Message --------
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups 
(modpost, LTO, MODULE_REL_CRCS, export.h)
Date: 2022-08-06 03:23
 From: Sedat Dilek <sedat.dilek@gmail.com>
To: matoro <matoro_mailinglist_kernel@matoro.tk>

On Sat, Aug 6, 2022 at 1:40 AM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
> 
> Hi Masahiro, I'm sorry to raise this after release but this seems to be
> broken on SOME architectures.  So far I have tested:
> 
> Affected - sparc, alpha
> Unaffected - riscv, ia64
> 

What do you mean by "release"?

Checking the kernel-version from your paste-URLs:

# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 5.18.16-gentoo Kernel Configuration

# Automatically generated file; DO NOT EDIT.
# Linux/alpha 5.18.15-gentoo Kernel Configuration

# Automatically generated file; DO NOT EDIT.
# Linux/riscv 5.19.0-gentoo Kernel Configuration

# Automatically generated file; DO NOT EDIT.
# Linux/ia64 5.19.0-gentoo Kernel Configuration

Maybe you should try "Affected - sparc, alpha" with Linux v5.19.0
instead of 5.18.x :-)?

-Sedat-

> The affected systems are unable to load modules, similar to the
> previously reported issue.  All module loading fails with "disagrees
> about version of symbol module_layout".
> 
> Bisect blames 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b, but this does
> not revert cleanly.  Presumably CONFIG_MODVERSIONS=n would fix, but 
> this
> is a pretty core feature.
> 
> Unlike the issue Sedat reported, this is on a GNU toolchain, no clang
> involved.
> 
> Here are the configs I am using (with make olddefconfig on upgrade to
> 5.19):
> 
> Broken - sparc - https://dpaste.com/5A8F2JD6U
> Broken - alpha - https://dpaste.com/FYKK23L9X
> Working - riscv - https://dpaste.com/HV6Y4V6NT
> Working - ia64 - https://dpaste.com/HDLDNEAK4
> 
> Please let me know if there's anything I can do to help track down this
> regression.
> 
> 
> -------- Original Message --------
> Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups
> (modpost, LTO, MODULE_REL_CRCS, export.h)
> Date: 2022-05-13 08:20
>  From: Masahiro Yamada <masahiroy@kernel.org>
> To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
> 
> On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org>
> wrote:
> >
> >
> > This is the third batch of cleanups in this development cycle.
> >
> 
> 
> This series is available at
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>   lto-cleanup-v6
> 
> 
> >
> > Changes in v6:
> >   - Fix false-positive warnings when CONFIG_TRIM_UNUSED_KSYMS=y
> >
> > Changes in v5:
> >   - Fix the build error when CONFIG_DEBUG_INFO_BTF=y (reported by
> > Nathan)
> >   - Clean up arch/m68k/include/asm/export.h (Nick)
> >   - Keep gen_symversions (and will be removed by a later patch)
> >   - Add more comments in the script
> >
> > Changes in v4:
> >   - Rename .vmlinux-symver.c to .vmlinux.export.c
> >     because I notice this approach is useful for further cleanups,
> >     not only for modversioning but also for overall EXPORT_SYMBOL.
> >   - New patch
> >   - New.
> >     Resent of my previous submission.
> >
> > https://lore.kernel.org/all/20210831074004.3195284-10-masahiroy@kernel.org/
> >   - New
> >     Resent of my previous submission
> >
> > https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/
> >
> > Changes in v3:
> >   - New patch
> >
> > Changes in v2:
> >   - Simplify the implementation (parse .cmd files after ELF)
> >   - New patch
> >  - replace the chain of $(if ...) with $(and )
> >   - New patch
> >   - New patch
> >
> > Masahiro Yamada (10):
> >   modpost: extract symbol versions from *.cmd files
> >   kbuild: link symbol CRCs at final link, removing
> >     CONFIG_MODULE_REL_CRCS
> >   kbuild: stop merging *.symversions
> >   genksyms: adjust the output format to modpost
> >   kbuild: do not create *.prelink.o for Clang LTO or IBT
> >   kbuild: check static EXPORT_SYMBOL* by script instead of modpost
> >   kbuild: make built-in.a rule robust against too long argument error
> >   kbuild: make *.mod rule robust against too long argument error
> >   kbuild: add cmd_and_savecmd macro
> >   kbuild: rebuild multi-object modules when objtool is updated
> >
> >  arch/m68k/include/asm/Kbuild    |   1 +
> >  arch/m68k/include/asm/export.h  |   2 -
> >  arch/powerpc/Kconfig            |   1 -
> >  arch/s390/Kconfig               |   1 -
> >  arch/um/Kconfig                 |   1 -
> >  include/asm-generic/export.h    |  22 ++-
> >  include/linux/export-internal.h |  16 +++
> >  include/linux/export.h          |  30 ++--
> >  init/Kconfig                    |   4 -
> >  kernel/module.c                 |  10 +-
> >  scripts/Kbuild.include          |  10 +-
> >  scripts/Makefile.build          | 134 ++++++------------
> >  scripts/Makefile.lib            |   7 -
> >  scripts/Makefile.modfinal       |   5 +-
> >  scripts/Makefile.modpost        |   9 +-
> >  scripts/check-local-export      |  64 +++++++++
> >  scripts/genksyms/genksyms.c     |  18 +--
> >  scripts/link-vmlinux.sh         |  33 ++---
> >  scripts/mod/modpost.c           | 236 +++++++++++++++++++++-----------
> >  19 files changed, 320 insertions(+), 284 deletions(-)
> >  delete mode 100644 arch/m68k/include/asm/export.h
> >  create mode 100644 include/linux/export-internal.h
> >  create mode 100755 scripts/check-local-export
> >
> > --
> > 2.32.0
> >
> 
