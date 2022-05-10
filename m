Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB7521666
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiEJNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241407AbiEJNJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:09:02 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BA0285ECA;
        Tue, 10 May 2022 06:05:01 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24AD4gO3008126;
        Tue, 10 May 2022 22:04:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24AD4gO3008126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652187883;
        bh=qBEayftl5ZwYSJPRCuQSWMNdT3wNrCO/ZLylUnM9Pos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nLq/5ipHudJNOcGUJsWwdYUfl6xYm9Kx/LfCF2DY/yWhpE2Mctf32CiOyfNIQ2gBC
         bGdfW9kjNaCML706UPRh8nLD1Lny1Azy1bLZ2h1RpS3RhbdZZDMMkc5uqHLDsQXABC
         envI7kUNL04QM+8N4XW1CfSxf0scjWNceOPOA2a/dAh+pxD7eITqXbziVw5bIEp4xH
         2WKVeNfb8PcpdVWBZW4CJg29uml36zc9AIKtqgWMVaQO517fRQOnyxwr53ndEVRIVV
         5STEVG0h72KmyM63AeINzu91D9azv4AP8JWDJmYj1EIjvtwg4wchFlg47xQzbS9eVJ
         p5TsaotGJk1Pg==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id m12so2940658plb.4;
        Tue, 10 May 2022 06:04:43 -0700 (PDT)
X-Gm-Message-State: AOAM532vNZvbVnwj5oeJMduiGmW5AAaHyTaS5aTvrce5csVhe4i5+jOj
        opA8Ph3jVoX9Qjr2jfgrJmQK6Dv4V9QsGdJrXQ8=
X-Google-Smtp-Source: ABdhPJyavnWgf46gRQwW/3BEwUehZ9JzWKuqbx9T+L5WacD6flQsWB/O7++u6qzJBiUbBulyt3k71693TE6NXQEFYOk=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr20893636plh.99.1652187882421; Tue, 10
 May 2022 06:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org>
 <20220508190631.2386038-7-masahiroy@kernel.org> <CAKwvOdm_oSLHddWWSzF5UuYrLCsAwF8AwbUGotUnPvV+6JkSkg@mail.gmail.com>
In-Reply-To: <CAKwvOdm_oSLHddWWSzF5UuYrLCsAwF8AwbUGotUnPvV+6JkSkg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 10 May 2022 22:03:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASb40kWgvOM42WyS82p42HQ7Mqhwo3GDffg4yHcKgJk0w@mail.gmail.com>
Message-ID: <CAK7LNASb40kWgvOM42WyS82p42HQ7Mqhwo3GDffg4yHcKgJk0w@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 2:51 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
>  On Sun, May 8, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> > index 07a36a874dca..51ce72ce80fa 100644
> > --- a/include/asm-generic/export.h
> > +++ b/include/asm-generic/export.h
> > @@ -2,6 +2,14 @@
> >  #ifndef __ASM_GENERIC_EXPORT_H
> >  #define __ASM_GENERIC_EXPORT_H
> >
> > +/*
> > + * This comment block is used by fixdep. Please do not remove.
>
> I don't know much about fixdep. How does that work, if you could summarize?


You can find detailed explanation in scripts/basic/fixdep.c


In short, it works like this:

fixdep parses every source (including headers).
If it finds "CONFIG_MODVERSIONS", it adds a dependency
on $(wildcard include/config/MODVERSIONS)
to the .cmd files.

If CONFIG_MODVERSIONS is toggled in Kconfig,
it touches include/config/MODVERSIONS.    [1]

In the next run of Make, all the sources depending on
CONFIG_MODVERSIONS will be re-compiled because the
timestamp of include/config/MODVERSIONS is up-to-date.


[1]: https://github.com/torvalds/linux/blob/v5.17/scripts/kconfig/confdata.c#L141





> > + *
> > + * When CONFIG_MODVERSIONS is changed from n to y, all source files having
> > + * EXPORT_SYMBOL variants must be re-compiled because genksyms is run as a
> > + * side effect of the .o build rule.
> > + */
> > +
> >  #ifndef KSYM_FUNC
> >  #define KSYM_FUNC(x) x
> >  #endif
> > @@ -12,9 +20,6 @@
> >  #else
> >  #define KSYM_ALIGN 4
> >  #endif
> > -#ifndef KCRC_ALIGN
> > -#define KCRC_ALIGN 4
> > -#endif
>
> The #ifndef is there because arch/m68k/include/asm/export.h:1 defines
> KCRC_ALIGN. You should delete that, too.

Nice catch! I will clean it up too.




>
> > diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
> > index 4827c5abe5b7..6e6933ae7911 100644
> > --- a/scripts/genksyms/genksyms.c
> > +++ b/scripts/genksyms/genksyms.c
> > @@ -33,7 +33,7 @@ char *cur_filename;
> >  int in_source_file;
> >
> >  static int flag_debug, flag_dump_defs, flag_reference, flag_dump_types,
> > -          flag_preserve, flag_warnings, flag_rel_crcs;
> > +          flag_preserve, flag_warnings;
> >
> >  static int errors;
> >  static int nsyms;
> > @@ -681,10 +681,7 @@ void export_symbol(const char *name)
> >                         fputs(">\n", debugfile);
> >
> >                 /* Used as a linker script. */
>
> ^ Does this comment still apply?

No.  From this commit going forward,
the genksyms output will not be used as a linker script.

08/14 will delete this comment anyway, but
it is possible to remove it in this commit.








>
> > -               printf(!flag_rel_crcs ? "__crc_%s = 0x%08lx;\n" :
> > -                      "SECTIONS { .rodata : ALIGN(4) { "
> > -                      "__crc_%s = .; LONG(0x%08lx); } }\n",
> > -                      name, crc);
> > +               printf("__crc_%s = 0x%08lx;\n", name, crc);
> >         }
> >  }
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index eceb3ee7ec06..6aee2401f3ad 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -88,11 +88,6 @@ modpost_link()
> >                 gen_initcalls
> >                 lds="-T .tmp_initcalls.lds"
> >
> > -               if is_enabled CONFIG_MODVERSIONS; then
> > -                       gen_symversions
>
> ^ this is the only caller of gen_symversions, right? Then
> gen_symversions can be cleaned up, too?


We can keep it in this commit.

The follow-up cleaning is done in 07/14.

To avoid too big commit,
I separated the build flow change and
trivial cleanups.



>
> > -                       lds="${lds} -T .tmp_symversions.lds"
> > -               fi
> > -
> >                 # This might take a while, so indicate that we're doing
> >                 # an LTO link
> >                 info LTO ${1}
> > @@ -183,6 +178,10 @@ vmlinux_link()
> >                 libs="${KBUILD_VMLINUX_LIBS}"
> >         fi
> >
> > +       if is_enabled CONFIG_MODULES; then
> > +               objs="${objs} .vmlinux.export.o"
> > +       fi
> > +
> >         if [ "${SRCARCH}" = "um" ]; then
> >                 wl=-Wl,
> >                 ld="${CC}"
> > @@ -312,6 +311,7 @@ cleanup()
> >         rm -f vmlinux.o
> >         rm -f .vmlinux.d
> >         rm -f .vmlinux.objs
> > +       rm -f .vmlinux.export.c
>
> Probably can drop the `rm -f .tmp_symversions.lds` here, too?

It will be cleaned up by 07/14.







> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards
Masahiro Yamada
