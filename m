Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2C520E37
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiEJHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiEJHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:00:47 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532787485B;
        Mon,  9 May 2022 23:56:48 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24A6uWPt006909;
        Tue, 10 May 2022 15:56:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24A6uWPt006909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652165793;
        bh=fEURvXR77OoRUwAby4ssOCC2y+9cYzZS2BTBBdHY5s4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wCwaSRXELTeXaq2guIuReTuZg7U66E7IGNEBvRfkfezGlyZXsSMCiDdUr9QEJxarS
         XrfMKl2ilUNX5U21uZSXL6zLwnIp0vZsPMbwwzeaW+huMjJN0lDJ6x9fPRe4b3ioLX
         d1CWYofvXhCGeTNOH4b2zCthanuoTTMVhHVGhU/G+RblgSvtBBoQY1q8W0F5FwtyK8
         pFbA+pcE2bpadKfX8PQAdO+AHk9AEs+Qvcqfz+EpBxXnZR+DExiobCnjj/rrTS0tnx
         CZPaFmdEMVXzwdp/7Jw3Kyv3btpFQ7MhJ18jWwmea1L+fCMHlCb2QwIfpTWtpSAEz9
         0NOjUjI1wdR0w==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id iq10so15115325pjb.0;
        Mon, 09 May 2022 23:56:33 -0700 (PDT)
X-Gm-Message-State: AOAM530Yx4NqOCrZWxlmZ6whAaURMPWAefNzWF9V/GNdyNORuj3wUXlF
        /LFU6ldwJ4z2CmT+9xRoarpYmzRcrA+ynNgI9jQ=
X-Google-Smtp-Source: ABdhPJyEgi0eqH+b8oqMunpHr855g62eqCOt9y9rnuZ3PqXxdNPec+4B1Ab1EtAdW8GXjXd92AJ/4rFTNMbUFO627GA=
X-Received: by 2002:a17:90a:e7cd:b0:1dc:74eb:7526 with SMTP id
 kb13-20020a17090ae7cd00b001dc74eb7526mr21753943pjb.144.1652165792292; Mon, 09
 May 2022 23:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org>
 <CAK7LNAQtedww_RiemfTV7Ls=M01iKJhY14G3TiuAg=C3bvJjww@mail.gmail.com> <YnmSCNDBlMMJCbjj@dev-arch.thelio-3990X>
In-Reply-To: <YnmSCNDBlMMJCbjj@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 10 May 2022 15:55:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkm+GzqNLgpbh4F+M=U8LU48p2NH9MyqeO6uA_KYJFaQ@mail.gmail.com>
Message-ID: <CAK7LNATkm+GzqNLgpbh4F+M=U8LU48p2NH9MyqeO6uA_KYJFaQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
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

On Tue, May 10, 2022 at 7:13 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, May 09, 2022 at 01:24:33PM +0900, Masahiro Yamada wrote:
> > On Mon, May 9, 2022 at 4:09 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > This is the third batch of cleanups in this development cycle.
> > >
> > > Major changes in v4:
> > >  - Move static EXPORT_SYMBOL check to a script
> > >  - Some refactoring
> > >
> > > Major changes in v3:
> > >
> > >  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
> > >
> > > Major changes in v2:
> > >
> > >  - V1 did not work with CONFIG_MODULE_REL_CRCS.
> > >    I fixed this for v2.
> > >
> > >  - Reflect some review comments in v1
> > >
> > >  - Refactor the code more
> > >
> > >  - Avoid too long argument error
> >
> > This series is available at
> > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> > lto-cleanup-v4
>
> Hi Masahiro,
>
> I checked this out and went to run it through my QEMU tests but I see
> two new errors.
>
> Failure #1:
>
> In file included from scripts/mod/section-check.c:3:
> scripts/mod/modpost.h:15:10: fatal error: 'elfconfig.h' file not found
> #include "elfconfig.h"
>          ^~~~~~~~~~~~~
> 1 error generated.
>
> I was able to get past that with
>
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index ca739c6c68a1..c33b83bfbcad 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -16,7 +16,7 @@ targets += $(devicetable-offsets-file) devicetable-offsets.s
>
>  # dependencies on generated files need to be listed explicitly
>
> -$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
> +$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o $(obj)/section-check.o: $(obj)/elfconfig.h
>  $(obj)/file2alias.o: $(obj)/$(devicetable-offsets-file)
>

Thanks for testing.


I will slightly refactor the code as follows.




@@ -16,7 +16,7 @@ targets += $(devicetable-offsets-file) devicetable-offsets.s

 # dependencies on generated files need to be listed explicitly

-$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
+$(addprefix $(obj)/, $(modpost-objs)): $(obj)/elfconfig.h

 $(obj)/file2alias.o: $(obj)/$(devicetable-offsets-file)

 quiet_cmd_elfconfig = MKELF   $@








>  quiet_cmd_elfconfig = MKELF   $@
>
> Failure #2:
>
>   GEN     .version
>   CHK     include/generated/compile.h
>   GEN     .tmp_initcalls.lds
>   LTO     vmlinux.o
>   OBJTOOL vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.btf
> ld.lld: error: cannot open .vmlinux.export.o: No such file or directory
>   BTF     .btf.vmlinux.bin.o
> pahole: .tmp_vmlinux.btf: No such file or directory
>   CC      .vmlinux.export.c
>   LD      .tmp_vmlinux.kallsyms1
> ld.lld: error: .btf.vmlinux.bin.o: unknown file type
> make[1]: *** [Makefile:1159: vmlinux] Error 1
>
> I was not really able to see what is going wrong here. Attached is the
> configuration that I ran into this with. If you need any other
> information, please let me know!

Ah, OK.
This is because .vmlinux.export.o is compiled after gen_btf.

I will swap the order in v5.





> Cheers,
> Nathan



--
Best Regards
Masahiro Yamada
