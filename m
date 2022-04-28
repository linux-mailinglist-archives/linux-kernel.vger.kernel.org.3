Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD69A512C23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiD1HEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbiD1HD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:03:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C0674CF;
        Thu, 28 Apr 2022 00:00:34 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.32]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mbzdn-1oHvEf0zZX-00dX7D; Thu, 28 Apr 2022 08:59:50 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 9BB183C09F;
        Thu, 28 Apr 2022 08:59:48 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id C234F66B; Thu, 28 Apr 2022 08:59:45 +0200 (CEST)
Date:   Thu, 28 Apr 2022 08:59:45 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH 27/27] kbuild: do not create *.prelink.o for Clang LTO or
 IBT
Message-ID: <Ymo7YfSynpexX0cV@bergen.fjasle.eu>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-28-masahiroy@kernel.org>
 <YmoKYjwvX49KLNwT@bergen.fjasle.eu>
 <CAK7LNATJHfGDKfp0q_VH30xKXdsFmveRZ6CNqZpHdjM3UbYG+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAK7LNATJHfGDKfp0q_VH30xKXdsFmveRZ6CNqZpHdjM3UbYG+Q@mail.gmail.com>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:CWLNrX8xs6OHxyyoHxhJnyCEMmxZqi/vR0bJ46WktHgu4Cr/bKz
 H/L9+edqiM6BEOs0aDumrHESjSMXFyrNGJV4xSUpcYLYibqmsXfygi7Mihp1TE3EjZjazTh
 ZfOo7/P9s1sBN5n8N9+MKCiA+h9xLIvUEPy1fzFa16SH5ingsKyKxaj4N8lXuqIcsYYiTiv
 vvZLenYD54hXU685a3Gqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NO9kZTODQ9A=:AXqrbwC9aH2snoXnSKI68s
 EbLwzhIVBqJ6gtYqmjjhermZUO2Pz5L0BfEfQburmXlbjlFbrnFp5YnwZ4YWqfmr1qiboff8g
 BcM69lJ5XId1NYruqQOpWl6/vq7TD8J2LwbVOjgswImbHZ6mOXmxL1/pALpejU+w4hMpSYov+
 50nE5HLTfFOutAaWn3cRTCTJshsefOa8rky+BVaU9N2cb8yfrrUPZogRt21GWWtVV5UXNL+Kg
 D/Kc7P7KwWRrHlyOSjR6HmkIOq77Qkq36vGBrWert1oHUSt+NZgvDAf9y7YOZC1RByCsSMr1d
 Y2fazxBaBuAlX9OFH3gttSrohnGFiro46BrmDdFokLiARYysfM79XLrZ9mO0aGa8PnBODJjW9
 dwZaROoygbjxlyP8YFw5mMcR9yTN2FD1Z8OHtSuOpa0yhTflxkRYzHePce+iWb8C7Mng1Wnif
 SabJbfgnrIUxl+ywESKjR63tawM6NhU/C1NlTG0vhNCI+6ZSE8L9bVlbJ3hnc+C8oMO/j/k31
 0zR5RDuK58g0ag2hmWICuxCy+CYdBXss5Ldak9apePIWc19EWJQ6mIE8E2hthoNRaMKnOkc7O
 QvAU6F2LvRwNxqox/Rul977SYkesxwUGNpC1Z7l20hrl4U4EleKVKaUzBvnfrsSGHd6Fj1kqZ
 fRYwCymUymGC75AJSvI8/ZMiTqikzGO2m1UDAwH02Z/1rfkehM/LyUUWwr0mDum3C4C4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 Apr 2022 13:38:39 GMT Masahiro Yamada wrote:
> 
> On Thu, Apr 28, 2022 at 12:31 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Mon 25 Apr 2022 04:08:11 GMT Masahiro Yamada wrote:
> > > When CONFIG_LTO_CLANG=y, additional intermediate *.prelink.o is
> > > created
> > > for each module. Also, objtool is postponed until LLVM bitcode is
> > > converted to ELF.
> > >
> > > CONFIG_X86_KERNEL_IBT works in a similar way to postpone objtool until
> > > objects are merged together.
> > >
> > > This commit stops generating *.prelink.o, so the build flow will look
> > > the same with/without LTO.
> > >
> > > The following figures show how the LTO build currently works, and
> > > how this commit is changing it.
> > >
> > > Current build flow
> > > ==================
> > >
> > >  [1] single-object module
> > >
> > >                                     [+objtool]
> > >            $(CC)                      $(LD)                $(LD)
> > >     foo.c --------------------> foo.o -----> foo.prelink.o -----> foo.ko
> > >                            (LLVM bitcode)        (ELF)       |
> > >                                                              |
> > >                                                  foo.mod.o --/
> > >
> > >  [2] multi-object module
> > >                                     [+objtool]
> > >            $(CC)         $(AR)        $(LD)                $(LD)
> > >     foo1.c -----> foo1.o -----> foo.o -----> foo.prelink.o -----> foo.ko
> > >                            |  (archive)          (ELF)       |
> > >     foo2.c -----> foo2.o --/                                 |
> > >                 (LLVM bitcode)                   foo.mod.o --/
> > >
> > >   One confusion is foo.o in multi-object module is an archive despite of
> > >   its suffix.
> > >
> > > New build flow
> > > ==============
> > >
> > >  [1] single-object module
> > >
> > >   Since there is only one object, we do not need to have the LLVM
> > >   bitcode stage. Use $(CC)+$(LD) to generate an ELF object in one
> > >   build rule. Of course, only $(CC) is used when LTO is disabled.
> > >
> > >            $(CC)+$(LD)[+objtool]           $(LD)
> > >     foo.c ------------------------> foo.o -------> foo.ko
> > >                                     (ELF)    |
> > >                                              |
> > >                                  foo.mod.o --/
> > >
> > >  [2] multi-object module
> > >
> > >   Previously, $(AR) was used to combine LLVM bitcode into an archive,
> > >   but there was not a technical reason to do so.
> > >   This commit just uses $(LD) to combine and convert them into a single
> > >   ELF object.
> > >
> > >                           [+objtool]
> > >             $(CC)           $(LD)          $(LD)
> > >     foo1.c -------> foo1.o -------> foo.o -------> foo.ko
> > >                               |     (ELF)    |
> > >     foo2.c -------> foo2.o ---/              |
> > >                 (LLVM bitcode)   foo.mod.o --/
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/Kbuild.include    |  4 +++
> > >  scripts/Makefile.build    | 58 ++++++++++++---------------------------
> > >  scripts/Makefile.lib      |  7 -----
> > >  scripts/Makefile.modfinal |  5 ++--
> > >  scripts/Makefile.modpost  |  9 ++----
> > >  scripts/mod/modpost.c     |  7 -----
> > >  6 files changed, 25 insertions(+), 65 deletions(-)
> > >
> > > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > > index 3514c2149e9d..455a0a6ce12d 100644
> > > --- a/scripts/Kbuild.include
> > > +++ b/scripts/Kbuild.include
> > > @@ -15,6 +15,10 @@ pound := \#
> > >  # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
> > >  dot-target = $(dir $@).$(notdir $@)
> > >
> > > +###
> > > +# Name of target with a '.tmp_' as filename prefix. foo/bar.o => foo/.tmp_bar.o
> > > +tmp-target = $(dir $@).tmp_$(notdir $@)
> >
> > This matches the dot-target definition above, otherwise $(@D).tmp_$(@F)
> > would be an alternative.
> 
> Yes, I intentionally made dot-target and tmp-target look similar.
> 
> The difference is $(dir ...) leaves the trailing slash, but $(@D) does not.
> 
> The alternative would be
> $(@D)/.tmp_$(@F)

ah, yes, thanks.

> >
> > > +
> > >  ###
> > >  # The temporary file to save gcc -MMD generated dependencies must not
> > >  # contain a comma
> > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > index 7f199b0a5170..fe4d3a908dd0 100644
> > > --- a/scripts/Makefile.build
> > > +++ b/scripts/Makefile.build
> > > @@ -88,10 +88,6 @@ endif
> > >  targets-for-modules := $(foreach x, o mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
> > >                               $(patsubst %.o, %.$x, $(filter %.o, $(obj-m))))
> > >
> > > -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> > > -targets-for-modules += $(patsubst %.o, %.prelink.o, $(filter %.o, $(obj-m)))
> > > -endif
> > > -
> > >  ifdef need-modorder
> > >  targets-for-modules += $(obj)/modules.order
> > >  endif
> > > @@ -153,8 +149,16 @@ $(obj)/%.ll: $(src)/%.c FORCE
> > >  # The C file is compiled and updated dependency information is generated.
> > >  # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
> > >
> > > +is-single-obj-m = $(if $(part-of-module),$(if $(filter $@, $(obj-m)),y))
> >
> > Perhaps using $(and ..,..,y) instead if $(if ..,$(if ..,y))?
> 
> 
> Good idea!
> I did not notice this.  I will do it in v2.
> 
> 
> 
> > >
> > > -endif
> > > +delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
> > > +
> > > +$(obj)/%.o: objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
> >
> > same here?  $(and) versus $(if ..,$(if ..,y))
> 
> I am not sure about this case.
> The second if-func is  $(if  cond, A, B) form.

Oh, I didn't see it.  Then it might be the best to keep it the way it 
is.
