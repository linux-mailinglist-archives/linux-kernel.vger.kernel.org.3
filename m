Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B04F2294
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiDEF3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiDEF3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:29:13 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A238DB9;
        Mon,  4 Apr 2022 22:27:15 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2355Qr35032029;
        Tue, 5 Apr 2022 14:26:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2355Qr35032029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649136413;
        bh=9Mjbanc1uTbEmK1mnz01B4FzZRbSAyqrQAUwcuIQyrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q7N13ho2VG5rLtdaeG8wrsIrzV2MyavvOTH5wV/PEuj70ICAWET40QbPV5Na0UYu5
         gr/o8vs8tVjR6GQXuQ9pGjJuCSsB9CzJ2IjWe3oA6QIA4mzE2pV2XLfQ+sY71zNdg5
         +iXM5AHZ0/PSYam2Pvbwg0ygnLWKI99gDwZbqZ6l6jEvFoxRIgcSTZsJZbtWfdX1ko
         q/D2JRyuouAYUJ+pRvroBlVKdbxCZUzX+wMceUb19jZomC+ZPHgUqWcEuOWkTLT2Xy
         DA/frOTo7xheZI0XTJxKvUAe02Mc7lnsfKDA5FuAY/KivXHRHb6f3WUEri5r/8nkyS
         sSidnkjfA2G7w==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso1428381pjb.0;
        Mon, 04 Apr 2022 22:26:53 -0700 (PDT)
X-Gm-Message-State: AOAM533Gsaw0t7ysT9t08Dx25gL4JrvYA0iNwczQKwEOmNJxqZ7t6fqv
        7W0arHWQRgYjs7mdlp+d+FSE8arqqF+6cBjztwo=
X-Google-Smtp-Source: ABdhPJwkdPkqgeF6q282Mp9Vwdv0ZWc0PT6lrZqUk8B5WAzSE3LH6/hQ1oXDCHHPqxwcsVJRZWFxeeXmOrr8mqbYLlk=
X-Received: by 2002:a17:90b:4d01:b0:1c9:ec79:1b35 with SMTP id
 mw1-20020a17090b4d0100b001c9ec791b35mr2005151pjb.77.1649136412823; Mon, 04
 Apr 2022 22:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021520.308997-1-masahiroy@kernel.org> <CAKwvOdkP12zrGu4iJStSJ5-pAKFBar=Cxf=CYO5gE9L636q8-w@mail.gmail.com>
 <CAK7LNASisGfD4vrk2Duswg_tj+LQutd+zdyq9qyFiTptCM7NWA@mail.gmail.com>
In-Reply-To: <CAK7LNASisGfD4vrk2Duswg_tj+LQutd+zdyq9qyFiTptCM7NWA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 5 Apr 2022 14:26:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReCMMkOvs13jNyDoEnTgRJ36MC=KrUwCWv0x0TXbQ+fg@mail.gmail.com>
Message-ID: <CAK7LNAReCMMkOvs13jNyDoEnTgRJ36MC=KrUwCWv0x0TXbQ+fg@mail.gmail.com>
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

On Tue, Apr 5, 2022 at 10:55 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Mar 30, 2022 at 3:18 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Mar 28, 2022 at 7:15 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > The genksyms command part in cmd_gensymtypes_{c,S} is duplicated.
> > > Factor it out into the 'genksyms' macro.
> > >
> > > For the readability, I slightly refactor the arguments to genksyms.
> >
> > Looks nicer, thanks for the patch!
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > >
>
> Applied to linux-kbuild.

No, this patch is wrong.
I will send v2 later.

>
>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/Makefile.build | 19 ++++++++-----------
> > >  1 file changed, 8 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > index 9717e6f6fb31..3f2985df4d60 100644
> > > --- a/scripts/Makefile.build
> > > +++ b/scripts/Makefile.build
> > > @@ -125,13 +125,14 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
> > >  $(obj)/%.i: $(src)/%.c FORCE
> > >         $(call if_changed_dep,cpp_i_c)
> > >
> > > +genksyms = scripts/genksyms/genksyms           \
> > > +       $(if $(1), -T $(2))                     \
> > > +       $(if $(CONFIG_MODULE_REL_CRCS), -R)     \
> > > +       $(if $(KBUILD_PRESERVE), -p)            \
> > > +       -r $(or $(wildcard $(2:.symtypes=.symref), /dev/null))

The position of the closing parenthesis was wrong.

    -r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)







-- 
Best Regards
Masahiro Yamada
