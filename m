Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856F4512AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbiD1Enc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiD1En2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:43:28 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A195FF37;
        Wed, 27 Apr 2022 21:40:09 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 23S4dh1C001032;
        Thu, 28 Apr 2022 13:39:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23S4dh1C001032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651120783;
        bh=iBbx4Um+YnFgBw9+6W5xvHjA6yLfdqlZz4cqEJPhD8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1WRIMiGSKmIg9XQwPj++zo4qllaXuXZDmIJYLFdu4BgyOxlVuywgU7Vp/1S534IJj
         MzMcpVc7fePsMiz0E5vBpBa3nlkJXrXSywAK+2OzQx0oBj5kORUWFr0tf1KtocmtlK
         iY6cXT5TQcse0AxeRivssctYrkgiM3TCgqppiavZ46Jw3fP7SW7t6Jl3mNci4d72g3
         hwaf7V06lJZZqlVjTMiisOgU6CdMXWjKFVP0501FdiBXX4f2L3zKt1vrp67g8xQQ2v
         HEpotsQWNPuIdKszSHBSojT2hQjpvQUFXozy2BKfu00c+b/FMM6zVOELphA1VNVedS
         oOkYeIKUJogqQ==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id e24so3252305pjt.2;
        Wed, 27 Apr 2022 21:39:43 -0700 (PDT)
X-Gm-Message-State: AOAM532rGLGvmN1ZltjvK8VRtSSaJm9A/eLq4Qsg9oRHP6B+T8uGyJ3b
        r2dWgN2kVuOkUz+nDGQHB+hwdlkfQKtfPgABxqs=
X-Google-Smtp-Source: ABdhPJyZut0COx0/akB+Az14gk+5DsF9HH/uKj/hWC5PO6CN6TzA2wK5ynNKB2HNbQseIzREsbBNHNHPxWVVUQiDXMA=
X-Received: by 2002:a17:902:bf07:b0:158:d334:852f with SMTP id
 bi7-20020a170902bf0700b00158d334852fmr31840136plb.136.1651120782642; Wed, 27
 Apr 2022 21:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-28-masahiroy@kernel.org> <YmoKYjwvX49KLNwT@bergen.fjasle.eu>
In-Reply-To: <YmoKYjwvX49KLNwT@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 28 Apr 2022 13:38:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJHfGDKfp0q_VH30xKXdsFmveRZ6CNqZpHdjM3UbYG+Q@mail.gmail.com>
Message-ID: <CAK7LNATJHfGDKfp0q_VH30xKXdsFmveRZ6CNqZpHdjM3UbYG+Q@mail.gmail.com>
Subject: Re: [PATCH 27/27] kbuild: do not create *.prelink.o for Clang LTO or IBT
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:31 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Mon 25 Apr 2022 04:08:11 GMT Masahiro Yamada wrote:
> > When CONFIG_LTO_CLANG=y, additional intermediate *.prelink.o is
> > created
> > for each module. Also, objtool is postponed until LLVM bitcode is
> > converted to ELF.
> >
> > CONFIG_X86_KERNEL_IBT works in a similar way to postpone objtool until
> > objects are merged together.
> >
> > This commit stops generating *.prelink.o, so the build flow will look
> > the same with/without LTO.
> >
> > The following figures show how the LTO build currently works, and
> > how this commit is changing it.
> >
> > Current build flow
> > ==================
> >
> >  [1] single-object module
> >
> >                                     [+objtool]
> >            $(CC)                      $(LD)                $(LD)
> >     foo.c --------------------> foo.o -----> foo.prelink.o -----> foo.ko
> >                            (LLVM bitcode)        (ELF)       |
> >                                                              |
> >                                                  foo.mod.o --/
> >
> >  [2] multi-object module
> >                                     [+objtool]
> >            $(CC)         $(AR)        $(LD)                $(LD)
> >     foo1.c -----> foo1.o -----> foo.o -----> foo.prelink.o -----> foo.ko
> >                            |  (archive)          (ELF)       |
> >     foo2.c -----> foo2.o --/                                 |
> >                 (LLVM bitcode)                   foo.mod.o --/
> >
> >   One confusion is foo.o in multi-object module is an archive despite of
> >   its suffix.
> >
> > New build flow
> > ==============
> >
> >  [1] single-object module
> >
> >   Since there is only one object, we do not need to have the LLVM
> >   bitcode stage. Use $(CC)+$(LD) to generate an ELF object in one
> >   build rule. Of course, only $(CC) is used when LTO is disabled.
> >
> >            $(CC)+$(LD)[+objtool]           $(LD)
> >     foo.c ------------------------> foo.o -------> foo.ko
> >                                     (ELF)    |
> >                                              |
> >                                  foo.mod.o --/
> >
> >  [2] multi-object module
> >
> >   Previously, $(AR) was used to combine LLVM bitcode into an archive,
> >   but there was not a technical reason to do so.
> >   This commit just uses $(LD) to combine and convert them into a single
> >   ELF object.
> >
> >                           [+objtool]
> >             $(CC)           $(LD)          $(LD)
> >     foo1.c -------> foo1.o -------> foo.o -------> foo.ko
> >                               |     (ELF)    |
> >     foo2.c -------> foo2.o ---/              |
> >                 (LLVM bitcode)   foo.mod.o --/
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Kbuild.include    |  4 +++
> >  scripts/Makefile.build    | 58 ++++++++++++---------------------------
> >  scripts/Makefile.lib      |  7 -----
> >  scripts/Makefile.modfinal |  5 ++--
> >  scripts/Makefile.modpost  |  9 ++----
> >  scripts/mod/modpost.c     |  7 -----
> >  6 files changed, 25 insertions(+), 65 deletions(-)
> >
> > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > index 3514c2149e9d..455a0a6ce12d 100644
> > --- a/scripts/Kbuild.include
> > +++ b/scripts/Kbuild.include
> > @@ -15,6 +15,10 @@ pound := \#
> >  # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
> >  dot-target = $(dir $@).$(notdir $@)
> >
> > +###
> > +# Name of target with a '.tmp_' as filename prefix. foo/bar.o => foo/.tmp_bar.o
> > +tmp-target = $(dir $@).tmp_$(notdir $@)
>
> This matches the dot-target definition above, otherwise $(@D).tmp_$(@F)
> would be an alternative.

Yes, I intentionally made dot-target and tmp-target look similar.

The difference is $(dir ...) leaves the trailing slash, but $(@D) does not.

The alternative would be
$(@D)/.tmp_$(@F)





>
> > +
> >  ###
> >  # The temporary file to save gcc -MMD generated dependencies must not
> >  # contain a comma
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 7f199b0a5170..fe4d3a908dd0 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -88,10 +88,6 @@ endif
> >  targets-for-modules := $(foreach x, o mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
> >                               $(patsubst %.o, %.$x, $(filter %.o, $(obj-m))))
> >
> > -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> > -targets-for-modules += $(patsubst %.o, %.prelink.o, $(filter %.o, $(obj-m)))
> > -endif
> > -
> >  ifdef need-modorder
> >  targets-for-modules += $(obj)/modules.order
> >  endif
> > @@ -153,8 +149,16 @@ $(obj)/%.ll: $(src)/%.c FORCE
> >  # The C file is compiled and updated dependency information is generated.
> >  # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
> >
> > +is-single-obj-m = $(if $(part-of-module),$(if $(filter $@, $(obj-m)),y))
>
> Perhaps using $(and ..,..,y) instead if $(if ..,$(if ..,y))?


Good idea!
I did not notice this.  I will do it in v2.



> >
> > -endif
> > +delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
> > +
> > +$(obj)/%.o: objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
>
> same here?  $(and) versus $(if ..,$(if ..,y))

I am not sure about this case.
The second if-func is  $(if  cond, A, B) form.



-- 
Best Regards
Masahiro Yamada
