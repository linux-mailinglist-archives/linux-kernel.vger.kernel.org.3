Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D653068F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 00:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiEVWfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 18:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiEVWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 18:35:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BEE369C0;
        Sun, 22 May 2022 15:35:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t13so1877845ilm.9;
        Sun, 22 May 2022 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2E7OE1cam9DtyiuG6iuZuYzKDSzejDf2vjxv7Odi/Sk=;
        b=oqMNGYd47nfrDiDSIzYpcdQ4Cya1qiPvQyxWXTzoexUfoTbZYP2ONrxer27Ff1kglf
         rh6bubHsMW2JBReMn8bauYwpxzu3VArJhjyoH+wodFEQuLlQGDKlpV9OUospAZp2cbix
         0oCyjcYyZDDPdewWUXI61UpzqcWOM9Hn3BPjE2gL+52yB6KuTNg0oNTTXFhhZX58Z7JT
         52tYfaYx43FdjYwMVWRuC7FmB+2f7KO1L8Fqnegb+jy3rTcEDucd9LAp1CkCIjBK4mye
         wgKBLql7hzY3ZlOu3gNOwienBdTq+UvVqR4cYTUIYDfFt/Kxi/7bJ70mOwyNOriaCRPX
         Igvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2E7OE1cam9DtyiuG6iuZuYzKDSzejDf2vjxv7Odi/Sk=;
        b=ve28bzYzBS4lYFnBoejIoaC3xrx57bO5Nrp9DUpoKcuTHscwIC8weoEQV+lwPlQSlF
         yPs2ASiUhzWdyPPYxxi5G9aQEbJ/qc3FgGm3r0NWXxrBV3v840sDALOKHzc3ufzB6a5a
         DktZl+KNizb1b0ULEYyB6Nh1hJyfoct8RwGehdIVHx9LvliIB2EI14kKWifycIZ/Zy8O
         8iVq5bHaNoj3WbB7tLtVCUHSTTghXWkFjo8koglgnMx4p37Ij+lscWfaO7cntayp1tkh
         OqqJJc60uoGKfLYFD23g4TV0IaVITSvotksbbRyPLFhbA+PY0YbdFtPRY4VT6YAlF8r9
         4//w==
X-Gm-Message-State: AOAM5321TmSeIAUAMOPSbMm6OzjvCDc2Q/4/HioytWEgmnYYPoKp1zwY
        5fqTc+oSN3+ts22nUgxe6B7vsyODyLEGuzV7w/HKiBwIYLTsuw==
X-Google-Smtp-Source: ABdhPJySklQVLvFbAp1hkug5aSL80QEN+5u0W6ifGPaPLk/2fsDEAFFujE9DDiD4hRG9gCxYPn0dBsPLpEHdqh9VFoE=
X-Received: by 2002:a92:d149:0:b0:2d1:5bd:1ec2 with SMTP id
 t9-20020a92d149000000b002d105bd1ec2mr10042266ilg.100.1653258927993; Sun, 22
 May 2022 15:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <CA+icZUUWww3fXvjQcefgFuq=tPO6+FYDbHE2E5PmL-BSJg4+cw@mail.gmail.com>
 <CAK7LNATx1QcM6BdqBSascV8J8rD6etRgRZj9PjBno5Qrb=p3Yg@mail.gmail.com>
 <CA+icZUV=PwX_e3U3mZwLOVvsA02pgNNAPsGJSMCPitu9ndWbqg@mail.gmail.com>
 <CA+icZUWttwjhDNPO1VuVyiMoReH5e83nsYDd0rEoY8-Uwv6pHw@mail.gmail.com>
 <CAK7LNATr6gpR1TUBp+wxn_JfeQr+cfxwztwupVui1nrWO-8Osg@mail.gmail.com> <CA+icZUXMWVr-zXm09zV2=pbLMFFOt=phHVT3B0CXVLBG=k8HWQ@mail.gmail.com>
In-Reply-To: <CA+icZUXMWVr-zXm09zV2=pbLMFFOt=phHVT3B0CXVLBG=k8HWQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 23 May 2022 00:34:51 +0200
Message-ID: <CA+icZUU8EAKpuXB996B+BNUcnRzsm5DvrtX-MtXcRm5aX2X8Lg@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     Masahiro Yamada <masahiroy@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 6:18 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, May 22, 2022 at 6:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sun, May 22, 2022 at 11:16 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Sun, May 22, 2022 at 11:45 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Sun, May 22, 2022 at 8:50 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > On Sun, May 22, 2022 at 10:45 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, May 13, 2022 at 4:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > This is the third batch of cleanups in this development cycle.
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > This series is available at
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> > > > > > >  lto-cleanup-v6
> > > > > > >
> > > > > >
> > > > > > Hi Masahiro,
> > > > > >
> > > > > > I cloned the repository on top of latest Linus Git.
> > > > > >
> > > > > > Not able to boot in Quemu - Not able to boot on bare metal.
> > > > > >
> > > > > > $ grep module_layout log_quemu-5.18.0-rc7-2-amd64-clang14-lto.txt
> > > > > > 366:[    2.173265] floppy: disagrees about version of symbol module_layout
> > > > > > 367:[    2.198746] scsi_common: disagrees about version of symbol module_layout
> > > > > > 368:[    2.205573] i2c_piix4: disagrees about version of symbol module_layout
> > > > > > 369:[    2.210610] psmouse: disagrees about version of symbol module_layout
> > > > > > 370:[    2.225138] scsi_common: disagrees about version of symbol module_layout
> > > > > > 371:[    2.235536] scsi_common: disagrees about version of symbol module_layout
> > > > > > 375:Begin: Running /scripts/local-premount ... [    2.298555]
> > > > > > crc32c_intel: disagrees about version of symbol module_layout
> > > > > > 376:[    2.303335] crc32c_generic: disagrees about version of symbol
> > > > > > module_layout
> > > > > > 377:[    2.306667] libcrc32c: disagrees about version of symbol module_layout
> > > > > >
> > > > > > Infos: LLVM-14 + CONFIG_LTO_CLANG_THIN=y
> > > > > >
> > > > > > My linux-config and qemu-log are attached.
> > > > > >
> > > > >
> > > > >
> > > > > Thanks for your testing.
> > > > >
> > > > > I was also able to reproduce this issue.
> > > > >
> > > > >
> > > > > The problematic parts are:
> > > > >
> > > > > [    2.298555] crc32c_intel: disagrees about version of symbol module_layout
> > > > > [    2.303335] crc32c_generic: disagrees about version of symbol module_layout
> > > > > [    2.306667] libcrc32c: disagrees about version of symbol module_layout
> > > > >
> > > > >
> > > > >
> > > > > When CONFIG_LTO_CLANG_THIN=y,
> > > > > I cannot see any __crc_* symbols in "nm  vmlinux".
> > > > >
> > > > > Perhaps, LTO might have discarded all the __crc_* symbols
> > > > > from vmlinux, but I am still checking the details...
> > > > >
> > > >
> > > > Thanks for taking care.
> > > >
> > > > Just for the records:
> > > >
> > > > $ grep CONFIG_MODVERSIONS /boot/config-5.18.0-rc7-2-amd64-clang14-lto
> > > > CONFIG_MODVERSIONS=y
> > > >
> > >
> > > Did not try CONFIG_MODVERSIONS=n.
> > >
> > > We have a new file:
> > >
> > > [ include/linux/export-internal.h ]
> > > /* SPDX-License-Identifier: GPL-2.0-only */
> > > /*
> > > * Please do not include this explicitly.
> > > * This is used by C files generated by modpost.
> > > */
> > >
> > > #ifndef __LINUX_EXPORT_INTERNAL_H__
> > > #define __LINUX_EXPORT_INTERNAL_H__
> > >
> > > #include <linux/compiler.h>
> > > #include <linux/types.h>
> > >
> > > #define SYMBOL_CRC(sym, crc, sec)   \
> > >        u32 __section("___kcrctab" sec "+" #sym) __crc_##sym = crc
> > >
> > > #endif /* __LINUX_EXPORT_INTERNAL_H__ */
> > >
> > > But we discard __kcrctab in scripts/module.lds.S file.
> >
> >
> > No.
> > scripts/module.lds.S keeps __kcrctab.
> >
> >
> > The discarded sections are specified a few lines above:
> >
> > /DISCARD/ : {
> >          *(.discard)
> >          *(.discard.*)
> >          SANITIZER_DISCARDS
> > }
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > > Maybe we need:
> >
> >
> > No.
> >
> > The problem is __crc_* symbols are dropped from vmlinux
> > when CONFIG_LTO_CLANG=y.
> >
> >
> > Please try this fixup:
> > https://lore.kernel.org/linux-kbuild/20220522160117.599023-1-masahiroy@kernel.org/T/#u
> >
>
> Thanks!
>
> Will give it a try - will report in a few hours.
>
> -Sedat-

I was able to build and boot on bare metal.

Feel free to add my...

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

-Sedat-

>
> >
> >
> >
> >
> >
> > >
> > > $ git diff scripts/module.lds.S
> > > diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> > > index 1d0e1e4dc3d2..c04b596c364b 100644
> > > --- a/scripts/module.lds.S
> > > +++ b/scripts/module.lds.S
> > > @@ -21,8 +21,6 @@ SECTIONS {
> > >
> > >        __ksymtab               0 : { *(SORT(___ksymtab+*)) }
> > >        __ksymtab_gpl           0 : { *(SORT(___ksymtab_gpl+*)) }
> > > -       __kcrctab               0 : { *(SORT(___kcrctab+*)) }
> > > -       __kcrctab_gpl           0 : { *(SORT(___kcrctab_gpl+*)) }
> > >
> > >        .ctors                  0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
> > >        .init_array             0 : ALIGN(8) { *(SORT(.init_array.*))
> > > *(.init_array) }
> > >
> > > Or even?
> > >
> > > $ git diff scripts/kallsyms.c
> > > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > > index 8caabddf817c..fb3601fe8aa3 100644
> > > --- a/scripts/kallsyms.c
> > > +++ b/scripts/kallsyms.c
> > > @@ -109,7 +109,6 @@ static bool is_ignored_symbol(const char *name, char type)
> > >        static const char * const ignored_prefixes[] = {
> > >                "$",                    /* local symbols for ARM, MIPS, etc. */
> > >                ".L",                   /* local labels,
> > > .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
> > > -               "__crc_",               /* modversions */
> > >                "__efistub_",           /* arm64 EFI stub namespace */
> > >                "__kvm_nvhe_",          /* arm64 non-VHE KVM namespace */
> > >                "__AArch64ADRPThunk_",  /* arm64 lld */
> > >
> > > - Sedat -
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
