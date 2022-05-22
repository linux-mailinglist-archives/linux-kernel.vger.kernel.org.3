Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82885530461
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347547AbiEVQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiEVQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:10:56 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05EE313;
        Sun, 22 May 2022 09:10:53 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24MGAUYi016368;
        Mon, 23 May 2022 01:10:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24MGAUYi016368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653235831;
        bh=DEp5fBCqcC+u4Tiia8L97bV7x6IbnuPyZilUMmH5ipc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z03QEWvNuPhA6Gude4TH8T2FMkpAN2BYSuJACXRd5Tg8xdNUw1+vNWgeFy9H9ZupE
         6nGG2bISvxlHkDhbkrB//TN06xVPvN7kvxHs+Jegmkrd+kBnpdfhcxy+2p36xOypx5
         fNb5oAVvPxfdHaAkeWemllSbnqfT9EC2AogChntF9wecVJ/3vAP+tFo/L9w9t10Te8
         5rdNhw3AXjyfTwxOn1zQVZjZhu4O2W6vZsbRVD8lC06+ESSUqn+fLduYBXzsDnNYr1
         5/QSoG/15dKJJhj2Db/GvTKC1I8JsyFQMDeu03D2HLfuN08KevhCRb2oTjzC8plBqQ
         eAh2KdXLXI/EQ==
X-Nifty-SrcIP: [209.85.210.181]
Received: by mail-pf1-f181.google.com with SMTP id x143so11685436pfc.11;
        Sun, 22 May 2022 09:10:31 -0700 (PDT)
X-Gm-Message-State: AOAM530bb3VmVb0YckZZp3XQiQVY/xecqpZhzrAXniFAnA58xUVJPFDz
        PtmMx0cu3oeVOxVIzGWrIyM1kNS4yeVZu5fsFfg=
X-Google-Smtp-Source: ABdhPJyL484cEbf9xdiYoTqXVAC6TVupXkdrNLtgZyNBC4T6SsOQ10FGXBLVsElMxcuaSv87Z2P669yaDqF4iCWfgj0=
X-Received: by 2002:a63:9043:0:b0:3f9:6c36:3de3 with SMTP id
 a64-20020a639043000000b003f96c363de3mr9611252pge.616.1653235830234; Sun, 22
 May 2022 09:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <CA+icZUUWww3fXvjQcefgFuq=tPO6+FYDbHE2E5PmL-BSJg4+cw@mail.gmail.com>
 <CAK7LNATx1QcM6BdqBSascV8J8rD6etRgRZj9PjBno5Qrb=p3Yg@mail.gmail.com>
 <CA+icZUV=PwX_e3U3mZwLOVvsA02pgNNAPsGJSMCPitu9ndWbqg@mail.gmail.com> <CA+icZUWttwjhDNPO1VuVyiMoReH5e83nsYDd0rEoY8-Uwv6pHw@mail.gmail.com>
In-Reply-To: <CA+icZUWttwjhDNPO1VuVyiMoReH5e83nsYDd0rEoY8-Uwv6pHw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 May 2022 01:09:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATr6gpR1TUBp+wxn_JfeQr+cfxwztwupVui1nrWO-8Osg@mail.gmail.com>
Message-ID: <CAK7LNATr6gpR1TUBp+wxn_JfeQr+cfxwztwupVui1nrWO-8Osg@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Sun, May 22, 2022 at 11:16 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, May 22, 2022 at 11:45 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sun, May 22, 2022 at 8:50 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sun, May 22, 2022 at 10:45 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Fri, May 13, 2022 at 4:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > On Fri, May 13, 2022 at 8:42 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > >
> > > > > >
> > > > > > This is the third batch of cleanups in this development cycle.
> > > > > >
> > > > >
> > > > >
> > > > > This series is available at
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> > > > >  lto-cleanup-v6
> > > > >
> > > >
> > > > Hi Masahiro,
> > > >
> > > > I cloned the repository on top of latest Linus Git.
> > > >
> > > > Not able to boot in Quemu - Not able to boot on bare metal.
> > > >
> > > > $ grep module_layout log_quemu-5.18.0-rc7-2-amd64-clang14-lto.txt
> > > > 366:[    2.173265] floppy: disagrees about version of symbol module_layout
> > > > 367:[    2.198746] scsi_common: disagrees about version of symbol module_layout
> > > > 368:[    2.205573] i2c_piix4: disagrees about version of symbol module_layout
> > > > 369:[    2.210610] psmouse: disagrees about version of symbol module_layout
> > > > 370:[    2.225138] scsi_common: disagrees about version of symbol module_layout
> > > > 371:[    2.235536] scsi_common: disagrees about version of symbol module_layout
> > > > 375:Begin: Running /scripts/local-premount ... [    2.298555]
> > > > crc32c_intel: disagrees about version of symbol module_layout
> > > > 376:[    2.303335] crc32c_generic: disagrees about version of symbol
> > > > module_layout
> > > > 377:[    2.306667] libcrc32c: disagrees about version of symbol module_layout
> > > >
> > > > Infos: LLVM-14 + CONFIG_LTO_CLANG_THIN=y
> > > >
> > > > My linux-config and qemu-log are attached.
> > > >
> > >
> > >
> > > Thanks for your testing.
> > >
> > > I was also able to reproduce this issue.
> > >
> > >
> > > The problematic parts are:
> > >
> > > [    2.298555] crc32c_intel: disagrees about version of symbol module_layout
> > > [    2.303335] crc32c_generic: disagrees about version of symbol module_layout
> > > [    2.306667] libcrc32c: disagrees about version of symbol module_layout
> > >
> > >
> > >
> > > When CONFIG_LTO_CLANG_THIN=y,
> > > I cannot see any __crc_* symbols in "nm  vmlinux".
> > >
> > > Perhaps, LTO might have discarded all the __crc_* symbols
> > > from vmlinux, but I am still checking the details...
> > >
> >
> > Thanks for taking care.
> >
> > Just for the records:
> >
> > $ grep CONFIG_MODVERSIONS /boot/config-5.18.0-rc7-2-amd64-clang14-lto
> > CONFIG_MODVERSIONS=y
> >
>
> Did not try CONFIG_MODVERSIONS=n.
>
> We have a new file:
>
> [ include/linux/export-internal.h ]
> /* SPDX-License-Identifier: GPL-2.0-only */
> /*
> * Please do not include this explicitly.
> * This is used by C files generated by modpost.
> */
>
> #ifndef __LINUX_EXPORT_INTERNAL_H__
> #define __LINUX_EXPORT_INTERNAL_H__
>
> #include <linux/compiler.h>
> #include <linux/types.h>
>
> #define SYMBOL_CRC(sym, crc, sec)   \
>        u32 __section("___kcrctab" sec "+" #sym) __crc_##sym = crc
>
> #endif /* __LINUX_EXPORT_INTERNAL_H__ */
>
> But we discard __kcrctab in scripts/module.lds.S file.


No.
scripts/module.lds.S keeps __kcrctab.


The discarded sections are specified a few lines above:

/DISCARD/ : {
         *(.discard)
         *(.discard.*)
         SANITIZER_DISCARDS
}









> Maybe we need:


No.

The problem is __crc_* symbols are dropped from vmlinux
when CONFIG_LTO_CLANG=y.


Please try this fixup:
https://lore.kernel.org/linux-kbuild/20220522160117.599023-1-masahiroy@kernel.org/T/#u






>
> $ git diff scripts/module.lds.S
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 1d0e1e4dc3d2..c04b596c364b 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -21,8 +21,6 @@ SECTIONS {
>
>        __ksymtab               0 : { *(SORT(___ksymtab+*)) }
>        __ksymtab_gpl           0 : { *(SORT(___ksymtab_gpl+*)) }
> -       __kcrctab               0 : { *(SORT(___kcrctab+*)) }
> -       __kcrctab_gpl           0 : { *(SORT(___kcrctab_gpl+*)) }
>
>        .ctors                  0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
>        .init_array             0 : ALIGN(8) { *(SORT(.init_array.*))
> *(.init_array) }
>
> Or even?
>
> $ git diff scripts/kallsyms.c
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8caabddf817c..fb3601fe8aa3 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -109,7 +109,6 @@ static bool is_ignored_symbol(const char *name, char type)
>        static const char * const ignored_prefixes[] = {
>                "$",                    /* local symbols for ARM, MIPS, etc. */
>                ".L",                   /* local labels,
> .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
> -               "__crc_",               /* modversions */
>                "__efistub_",           /* arm64 EFI stub namespace */
>                "__kvm_nvhe_",          /* arm64 non-VHE KVM namespace */
>                "__AArch64ADRPThunk_",  /* arm64 lld */
>
> - Sedat -



-- 
Best Regards
Masahiro Yamada
