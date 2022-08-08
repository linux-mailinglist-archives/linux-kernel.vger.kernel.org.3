Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A810858C317
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiHHFzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiHHFzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:55:02 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F97C2DC9;
        Sun,  7 Aug 2022 22:55:00 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2785sh62023443;
        Mon, 8 Aug 2022 14:54:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2785sh62023443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659938085;
        bh=qejQ7qBbGWyXlXw+9ltBzYOdnZJ6o0o+M0Ple7B/+Yc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xf4BG++C4DsMw1wETGD16aAQgXcOyMOxYC2YWW7ygBM7SEqeSyBBPTemr6qeyddWl
         wav4+MXO1jLQ+yWnY+H7OJyLkbVwIyGP3QDCPV5Osc8pVfc1+AHHn0lecHbJFdW+MY
         uXc2o+8qOrZadUUEvaYJbb8MAWGqgmpVAlC3ZehWTRzSQfuSLhG635F7bwHbgONzoP
         7Tszn2Vgn8lwVuqsBRpwQAXvlAeuiO+TPY3m1nC31wuRIniQ/z1MIHpCL7Q2pT6xQb
         5XlMHSaEdws5tdcC3fWZiWARshGt7cNzkTOH5vcd1dnmFqhees5B/3AY7xYULe0xnn
         mctvHC4lcUI1w==
X-Nifty-SrcIP: [209.85.128.49]
Received: by mail-wm1-f49.google.com with SMTP id 17-20020a05600c241100b003a536b6d536so1766738wmp.2;
        Sun, 07 Aug 2022 22:54:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo339nN0gBO86FflYa03XFF1XRtpFBfykPGY0jREJg+P3q16ZOig
        +WLjLJGdeyZRiuqRqbbTRBiwalyTZRKyPMOi6c0=
X-Google-Smtp-Source: AA6agR67yrrIq8MxybypgJHhJrFW1rEbYpjlPy4b/RNP2FAT2d6tNuWjP4sOb5OhWgDNVEW9M61wQ1NMknMtRkFldGA=
X-Received: by 2002:a05:600c:35ce:b0:3a3:1b7f:bbd8 with SMTP id
 r14-20020a05600c35ce00b003a31b7fbbd8mr11090211wmq.22.1659938083218; Sun, 07
 Aug 2022 22:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <2c496d24174e63b27ec047f383df6700@matoro.tk>
In-Reply-To: <2c496d24174e63b27ec047f383df6700@matoro.tk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 8 Aug 2022 14:54:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWKhj0tZK6jA1PsYje+idTjzdbYa9avyGeakVScj843A@mail.gmail.com>
Message-ID: <CAK7LNASWKhj0tZK6jA1PsYje+idTjzdbYa9avyGeakVScj843A@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matoro,

Thanks for the report.


I have qemu-system-sparc installed on my Ubuntu machine,
so I think I will be able to test it on sparc, at least.

How did you test these 4 architectures (sparc, alpha, riscv, ia64)?
QEMU?

Thanks




On Sat, Aug 6, 2022 at 8:39 AM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
>
> Hi Masahiro, I'm sorry to raise this after release but this seems to be
> broken on SOME architectures.  So far I have tested:
>
> Affected - sparc, alpha
> Unaffected - riscv, ia64
>
> The affected systems are unable to load modules, similar to the
> previously reported issue.  All module loading fails with "disagrees
> about version of symbol module_layout".
>
> Bisect blames 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b, but this does
> not revert cleanly.  Presumably CONFIG_MODVERSIONS=n would fix, but this
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


-- 
Best Regards
Masahiro Yamada
