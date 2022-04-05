Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDBC4F21A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiDECtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiDECto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:49:44 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054E3409A5;
        Mon,  4 Apr 2022 18:56:12 -0700 (PDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2351tvOj030196;
        Tue, 5 Apr 2022 10:55:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2351tvOj030196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649123758;
        bh=PdP6YCUvmaSUiCxbB3ILanT4Hgdihlr9OSG1Kl9PsW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gW+l5oDUfiuOIwuFg2HGWp1UIZcR14E7rKQKOpraAnYpVZhf/y7HwV/P0r8mQMIF3
         EUouHELoF6t0f4acQGN+Mqck7GqDvjTPLyqMFgpKzUVFlrlmlNsZ424U+PDxIvFHcv
         WVcsW/IzDsQdTwf3CUIRxzEZnDazZNcLmi8kpCJJn9PUMxWxZoy1ucSq2QRk8Rc2MH
         QcRgDEmHBKkolrH27J6kWxLOgLML0XEPbbq5tZYI9InDr8QsxTotRrppjw5/lBOExL
         cOegUba4J+TtyYcPtZaLWq9VSH7hEubDDpbhIye0wOmdfr4ZSsgKxqt9jdD9/UeI1F
         Pm1aCP1brpPnQ==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id 7so3697386pfu.13;
        Mon, 04 Apr 2022 18:55:57 -0700 (PDT)
X-Gm-Message-State: AOAM530Wrl2FODZGw5gurPfGx1uk8kzrLHzYH0CYsYBRdAmo+Hr+hvMj
        KpeY+IwOJxSEzm2DhIcRZH7IAZo6hWsUrLW+tv8=
X-Google-Smtp-Source: ABdhPJxyowF3gUy7iO6+drJUCMa56w9yL809C9UvY6zKbVygHAEE/enomAV6RR4k3ReR7tqnWg4fmw1pB+HCgQvEizE=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr1286578pfj.32.1649123756928; Mon, 04
 Apr 2022 18:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021520.308997-1-masahiroy@kernel.org> <CAKwvOdkP12zrGu4iJStSJ5-pAKFBar=Cxf=CYO5gE9L636q8-w@mail.gmail.com>
In-Reply-To: <CAKwvOdkP12zrGu4iJStSJ5-pAKFBar=Cxf=CYO5gE9L636q8-w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 5 Apr 2022 10:55:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNASisGfD4vrk2Duswg_tj+LQutd+zdyq9qyFiTptCM7NWA@mail.gmail.com>
Message-ID: <CAK7LNASisGfD4vrk2Duswg_tj+LQutd+zdyq9qyFiTptCM7NWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: factor out genksyms command from cmd_gensymtypes_{c,S}
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Wed, Mar 30, 2022 at 3:18 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Mar 28, 2022 at 7:15 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The genksyms command part in cmd_gensymtypes_{c,S} is duplicated.
> > Factor it out into the 'genksyms' macro.
> >
> > For the readability, I slightly refactor the arguments to genksyms.
>
> Looks nicer, thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >

Applied to linux-kbuild.


> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.build | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 9717e6f6fb31..3f2985df4d60 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -125,13 +125,14 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
> >  $(obj)/%.i: $(src)/%.c FORCE
> >         $(call if_changed_dep,cpp_i_c)
> >
> > +genksyms = scripts/genksyms/genksyms           \
> > +       $(if $(1), -T $(2))                     \
> > +       $(if $(CONFIG_MODULE_REL_CRCS), -R)     \
> > +       $(if $(KBUILD_PRESERVE), -p)            \
> > +       -r $(or $(wildcard $(2:.symtypes=.symref), /dev/null))
> > +
> >  # These mirror gensymtypes_S and co below, keep them in synch.
> > -cmd_gensymtypes_c =                                                         \
> > -    $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
> > -    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
> > -     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
> > -     $(if $(KBUILD_PRESERVE),-p)                                            \
> > -     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
> > +cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
> >
> >  quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
> >  cmd_cc_symtypes_c =                                                         \
> > @@ -344,11 +345,7 @@ cmd_gensymtypes_S =                                                         \
> >      $(CPP) $(a_flags) $< |                                                  \
> >       grep "\<___EXPORT_SYMBOL\>" |                                          \
> >       sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
> > -    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
> > -    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
> > -     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
> > -     $(if $(KBUILD_PRESERVE),-p)                                            \
> > -     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
> > +    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
> >
> >  quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
> >  cmd_cc_symtypes_S =                                                         \
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
