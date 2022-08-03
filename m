Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E430A588D03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiHCNeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiHCNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:34:02 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7413D1E;
        Wed,  3 Aug 2022 06:34:00 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 273DXdhx030375;
        Wed, 3 Aug 2022 22:33:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 273DXdhx030375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659533620;
        bh=DIXMc0FXqrgiG2JzOv9Go39bhHmpNkDm1vaQNDagOGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XgKt6R2jGOuKaMiN4J43BemiU0OQrlBsw+qZ0+bHdFYNFJuAJ0eRyvb3OEm/BaNE9
         +3KqzxoYbNmftSwC30LDoxwylJaZf+2CVDUPRYK4rP70IlMBtKnofPr5uTTyKZXQle
         EYEfScUNyw1vxDX3viUWzyNHpxyLTVDz3i5j/XiOYm06DU5RNzBxpoGk+jY9L7WFss
         VQ48tmMtLy8YSp1iC9aLNtCKNYOANAq5FGaSI4pX/NBoTrjJFlyx/wDRb7Q4jQU7r/
         sJ32SNuV++B+AfAnI+W6qgw1XYq8O0LsDXJG2atJp2XEz6Gzh8YNeP36XK8YNEkbwF
         NnI9lef8jUVzg==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id p10so17396249wru.8;
        Wed, 03 Aug 2022 06:33:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo3x5Yi+xwJuU5IJTZJG5fpJwla/MYoGT+aFWG2kLvz1q82XTnnH
        VJzTAJGl2sDQ+PgtNrPAQSjLoZUDQPNiv1Y6eac=
X-Google-Smtp-Source: AA6agR6mFoTZfb7x+cAg1MCrgczY8yp+H0Q2cXbW6ZOKfCxABTQf3Mvzjn3+2UTjxa1Rwl+9OZxtlTSb5bR9Ho4KZ2s=
X-Received: by 2002:a05:6000:1f9a:b0:21e:d4a7:a4c0 with SMTP id
 bw26-20020a0560001f9a00b0021ed4a7a4c0mr15711120wrb.409.1659533618665; Wed, 03
 Aug 2022 06:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220726180748.4101236-1-masahiroy@kernel.org> <CAKwvOdkMzzG_a3BHociq23JeyyOAawgPTUm3UAzx2BzZOh2z-g@mail.gmail.com>
In-Reply-To: <CAKwvOdkMzzG_a3BHociq23JeyyOAawgPTUm3UAzx2BzZOh2z-g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Aug 2022 22:32:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAys9iJSfhvkcrka9FkvcuLJp5XA0BCrVqmXR+YrbXyg@mail.gmail.com>
Message-ID: <CAK7LNASAys9iJSfhvkcrka9FkvcuLJp5XA0BCrVqmXR+YrbXyg@mail.gmail.com>
Subject: Re: [PATCH] modpost: refactor get_secindex()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 2:50 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Jul 26, 2022 at 11:08 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > SPECIAL() is only used in get_secindex(). Squash it.
> >
> > Make the code more readable with more comments.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.h | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> > index bd874f906781..33b376d9ba71 100644
> > --- a/scripts/mod/modpost.h
> > +++ b/scripts/mod/modpost.h
> > @@ -156,22 +156,28 @@ static inline int is_shndx_special(unsigned int i)
> >         return i != SHN_XINDEX && i >= SHN_LORESERVE && i <= SHN_HIRESERVE;
> >  }
> >
> > -/*
> > - * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
> > - * the way to -256..-1, to avoid conflicting with real section
> > - * indices.
> > - */
> > -#define SPECIAL(i) ((i) - (SHN_HIRESERVE + 1))
> > -
> >  /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
> >  static inline unsigned int get_secindex(const struct elf_info *info,
> >                                         const Elf_Sym *sym)
> >  {
> > -       if (is_shndx_special(sym->st_shndx))
> > -               return SPECIAL(sym->st_shndx);
> > -       if (sym->st_shndx != SHN_XINDEX)
> > -               return sym->st_shndx;
> > -       return info->symtab_shndx_start[sym - info->symtab_start];
> > +       unsigned int index = sym->st_shndx;
>
> I think `Elf_Section` would be preferable to `unsigned int` for the
> type of `index`?

But, rather I believe 'unsigned int' is easier to understand
so that you do not need to check the real type of Elf_Section.

Also, it took me a while to convince myself the following still works
as expected.

      return index - SHN_HIRESERVE - 1;

('index' will be extended from 'unsigned short' to 'int' before
the substracton, so it will work)



> > +
> > +       /*
> > +        * Elf{32,64}_Sym::st_shndx is 2 byte. Big section numbers are available
>
> Then I'd update the comment, too, to mention `Elf_Section` rather than
> `Elf{32,64}_Sym::st_shndx`.
>
> > +        * in the .symtab_shndx section.
> > +        */
> > +       if (index == SHN_XINDEX)
> > +               return info->symtab_shndx_start[sym - info->symtab_start];
> > +
> > +       /*
> > +        * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
> > +        * the way to UINT_MAX-255..UINT_MAX, to avoid conflicting with real
> > +        * section indices.
> > +        */
> > +       if (index >= SHN_LORESERVE)
>
> ^ should this also check that `index <= SHN_HIRESERVE`?

Probably, yes.
I will fix it in v2.


>  Perhaps just
> call is_shndx_special() like the code did before?

According to my refactoring plan,
all the call-sites of is_shnx_special() will be gone in the future,
and is_shndx_special() will be removed as well.

So, I am not using it here.





>
> Or SHN_HIRESERVE is #defined in include/uapi/linux/elf.h to 0xffff and
> SHN_XINDEX is ... not defined in kernel sources (what?! perhaps
> <elf.h>?)...but should have the same value of 0xffff according to
> https://docs.oracle.com/cd/E19683-01/817-3677/chapter6-94076/index.html
>
> I guess this is fine then, but I would prefer not open coding types
> when dealing with ELF. (i.e. my first suggestion in this thread).
>
> > +               return index - SHN_HIRESERVE - 1;
> > +
> > +       return index;
> >  }
> >
> >  /* file2alias.c */
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
