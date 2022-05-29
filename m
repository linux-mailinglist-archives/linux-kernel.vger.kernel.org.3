Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F035371EE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiE2Rga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiE2RgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:36:19 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546D120A9;
        Sun, 29 May 2022 10:36:17 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 24THZkSf020994;
        Mon, 30 May 2022 02:35:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 24THZkSf020994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653845747;
        bh=6jtSUhM9gFvzm+M4ODWXtbbHHwBS+n0OxXQnbf3F4DU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pdflkjSchFx34tlC3pHNAlrT2DBoEfq22Uq5I0Z3pKXEyiFqd2R8IAOEtvFXur9U9
         pve1cdO+Ulk1QEgIlhXXN4Pt2vD3gjznQPowq2cWlNllWf9Av33S0CFVWsZfd4HEhW
         qV6fAwiQuTpaneOKp2teNh+M3KSgym/U41XIOHeJLo8m4jZp/+aNldE81KqqqjcoME
         oQWV36wMYp0WAVg768tSAHKd9lO9QSVFC6suMLY+aGYTwJndWLjCKG2xAtOkI+6KTS
         13CdaYuxyu1ePwZ/b2RoKaJ27i6gIAzLIS+DsUI4ACUcnblWyRDtFWt629VbBUs646
         a6V8ocBJV+3Pw==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so8634374pjq.2;
        Sun, 29 May 2022 10:35:46 -0700 (PDT)
X-Gm-Message-State: AOAM530MaUz9ALf61Rcy+hLFNVYr4S0uUKdCxqWJP8ZGN11UqixfJma2
        Gu6ql5SLQ/hWc/h+IVk3zTYmk8tKBPxiN2U9kKY=
X-Google-Smtp-Source: ABdhPJzE7BUsmkMsPwC7OB7jGXNPDK1TSjoFiiL4b153MIvt4tvaWlhMlTuaGEWZ8hsyyKmV0CQGDZhPmFYOGeQSqNQ=
X-Received: by 2002:a17:90b:1d83:b0:1e2:f63e:bc37 with SMTP id
 pf3-20020a17090b1d8300b001e2f63ebc37mr2094884pjb.119.1653845746174; Sun, 29
 May 2022 10:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220528154704.2576290-1-masahiroy@kernel.org>
 <20220528154704.2576290-4-masahiroy@kernel.org> <CA+icZUWkOrWYSY3ixxfF=vsuq1xw3mU+p3NMqBpY0OpM02916g@mail.gmail.com>
In-Reply-To: <CA+icZUWkOrWYSY3ixxfF=vsuq1xw3mU+p3NMqBpY0OpM02916g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 30 May 2022 02:34:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwgT-FQ99Ex6MOc+rYEe7tc8ffoF-5e12jfbeaEM1vhw@mail.gmail.com>
Message-ID: <CAK7LNATwgT-FQ99Ex6MOc+rYEe7tc8ffoF-5e12jfbeaEM1vhw@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: factor out the common objtool arguments
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 11:47 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, May 28, 2022 at 9:45 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > scripts/Makefile.build and scripts/link-vmlinux.sh have similar setups
> > for the objtool arguments.
> >
> > It is difficult to factor out them because the vmlinux build rule is
> > written in a shell script. It is somewhat tedious to touch the two
> > files every time a new objtool option is supported.
> >
> > To reduce the code duplication, implement everything about objtool in
> > Makefile.
> >
> > Move the objtool for vmlinux.o into scripts/Makefile.vmlinux_o.
> >
> > Move the common macros to Makefile.lib so they are shared by
> > Makefile.build and Makefile.vmlinux_o.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> With some comments (see below).
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)
>
> -Sedat-
>
> > ---
> >
> >  scripts/Makefile.build     | 26 --------------
> >  scripts/Makefile.lib       | 26 ++++++++++++++
> >  scripts/Makefile.vmlinux_o | 26 ++++++++++++++
> >  scripts/link-vmlinux.sh    | 71 --------------------------------------
> >  4 files changed, 52 insertions(+), 97 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 4cb7145071b9..1f01ac65c0cd 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -210,38 +210,12 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),
> >         $(sub_cmd_record_mcount))
> >  endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
> >
> > -ifdef CONFIG_OBJTOOL
> > -
> > -objtool := $(objtree)/tools/objtool/objtool
> > -
> > -objtool_args =                                                         \
> > -       $(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)        \
> > -       $(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)              \
> > -       $(if $(CONFIG_X86_KERNEL_IBT), --ibt)                           \
> > -       $(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)             \
> > -       $(if $(CONFIG_UNWINDER_ORC), --orc)                             \
> > -       $(if $(CONFIG_RETPOLINE), --retpoline)                          \
> > -       $(if $(CONFIG_SLS), --sls)                                      \
> > -       $(if $(CONFIG_STACK_VALIDATION), --stackval)                    \
> > -       $(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)          \
> > -       --uaccess                                                       \
> > -       $(if $(delay-objtool), --link)                                  \
> > -       $(if $(part-of-module), --module)                               \
> > -       $(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
> > -
> > -cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
> > -cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
> > -
> > -endif # CONFIG_OBJTOOL
> > -
> >  # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
> >  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
> >  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
> >
>
> ^^ What is with this block?
> If this belongs together with objtool - shall this be moved, too?

No.
These are unneeded for vmlinux.o



> > -       fi
> > -}
> > -
> >  # Link of vmlinux
> >  # ${1} - output file
> >  # ${2}, ${3}, ... - optional extra .o files
> > @@ -298,7 +228,6 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
> >
> >  #link vmlinux.o
>
> ^^ While you are at it, change the comment to "# Link of vmlinux.o".


In my plan, this code will be gone sooner or later.

It would be a noise.



-- 
Best Regards
Masahiro Yamada
