Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD73350EF71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiDZEC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiDZECx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:02:53 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DDB1CD;
        Mon, 25 Apr 2022 20:59:45 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 23Q3xTgm025076;
        Tue, 26 Apr 2022 12:59:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23Q3xTgm025076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650945570;
        bh=cYiWrPdBFDd0mrnYn09H4oEnjv6RyMZ7n64U8ua0gOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NPc1Z9EKm+Rim2o91JcqsiLludqXKEAFP0jMbD9oWluY0aTNEsRAS85T/sIQb5jD4
         cLI5+i0orrkt/lP/wYa8fJ34H8M3aTBh6f9brzF22m0HTh6Ctqhov49wwRHE3FDcVY
         tVuv6z6KUWejd3TYiM15bSgBsbp35zpkH4TjQ6pAfY27tl/T0oQjbUVy31gUQ/BpLD
         JJVEOiEdj/ILRuCF0PtA769j2pHvSRwHP4338w8lEe/n099W7vq306HdLdnnk5wD4p
         LhSHhEmRQkqbOshaztKCGiefx1uiD+x16KdFUWVfnFshwcwQ8iOzS+nWTeOWU/6rH1
         HB6jEZ6ontGVA==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so1350828pjm.1;
        Mon, 25 Apr 2022 20:59:29 -0700 (PDT)
X-Gm-Message-State: AOAM530jXRszM248JzQk8E7nBRRn3iFgUjpvF4sXdQHcdemJ7sikTmsM
        YPj2vLMqiA44VPZ6JiwXndAuIAcn6bwtLnhd0dQ=
X-Google-Smtp-Source: ABdhPJxqNW2U2AUQwKH629EZ5PUs/ObxZN3krYGMVvx8LRvzNllnHHp1ZqbXQstTuE9vvjtHKkJERoqF9RBgvrl1Sak=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr20907060plp.162.1650945568944; Mon, 25
 Apr 2022 20:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-10-masahiroy@kernel.org> <CAKwvOdkac4Bk+u=v2dwSD=X0kZo2y4UxRUNHJdYiTLTPSp7=kQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkac4Bk+u=v2dwSD=X0kZo2y4UxRUNHJdYiTLTPSp7=kQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Apr 2022 12:58:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR4N_OAUJJnCoZWA3OKWPFJHgOTLmsgY+DHaXRJFwGsGQ@mail.gmail.com>
Message-ID: <CAK7LNAR4N_OAUJJnCoZWA3OKWPFJHgOTLmsgY+DHaXRJFwGsGQ@mail.gmail.com>
Subject: Re: [PATCH 09/27] modpost: add sym_add_unresolved() helper
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:41 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Add a small helper, sym_add_unresolved() to ease the further
> > refactoring.
> >
> > Remove the 'weak' argument from alloc_symbol() because it is sensible
> > only for unresolved symbols.
>
> I did not yet read the rest of the series to see how else your newly
> added helper `sym_add_unresolved` is used.
> Perhaps the callers of `alloc_symbol` should just set the symbol's
> weak member to true if needed, and alloc_symbol can default to setting
> it false (as the memset currently does)?
>
> Then, you don't need the helper, and just `handle_symbol` needs the
> assignment when `ELF_ST_BIND(sym->st_info) == STB_WEAK`?


I will change this in the later commit:
https://patchwork.kernel.org/project/linux-kbuild/patch/20220424190811.1678416-11-masahiroy@kernel.org/

I think this is a good case for a new helper.

If you look at the entire series,
"allocate a new symbol and connect it to the proper linked list or hash_table"
is consistently done in a helper function.


Also, I chose the function name as they look symmetrical.

 sym_add_unresolved()
 sym_add_exported()
 sym_add_crc()




> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 86416e4af626..1c7d2831e89d 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -230,14 +230,12 @@ static inline unsigned int tdb_hash(const char *name)
> >   * Allocate a new symbols for use in the hash of exported symbols or
> >   * the list of unresolved symbols per module
> >   **/
> > -static struct symbol *alloc_symbol(const char *name, bool weak,
> > -                                  struct symbol *next)
> > +static struct symbol *alloc_symbol(const char *name, struct symbol *next)
> >  {
> >         struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
> >
> >         memset(s, 0, sizeof(*s));
> >         strcpy(s->name, name);
> > -       s->weak = weak;
> >         s->next = next;
> >         s->is_static = true;
> >         return s;
> > @@ -250,11 +248,17 @@ static struct symbol *new_symbol(const char *name, struct module *module,
> >         unsigned int hash;
> >
> >         hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
> > -       symbolhash[hash] = alloc_symbol(name, false, symbolhash[hash]);
> > +       symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
> >
> >         return symbolhash[hash];
> >  }
> >
> > +static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
> > +{
> > +       mod->unres = alloc_symbol(name, mod->unres);
> > +       mod->unres->weak = weak;
> > +}
> > +
> >  static struct symbol *find_symbol(const char *name)
> >  {
> >         struct symbol *s;
> > @@ -701,9 +705,8 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
> >                         }
> >                 }
> >
> > -               mod->unres = alloc_symbol(symname,
> > -                                         ELF_ST_BIND(sym->st_info) == STB_WEAK,
> > -                                         mod->unres);
> > +               sym_add_unresolved(symname, mod,
> > +                                  ELF_ST_BIND(sym->st_info) == STB_WEAK);
> >                 break;
> >         default:
> >                 /* All exported symbols */
> > @@ -2073,7 +2076,7 @@ static void read_symbols(const char *modname)
> >          * the automatic versioning doesn't pick it up, but it's really
> >          * important anyhow */
> >         if (modversions)
> > -               mod->unres = alloc_symbol("module_layout", false, mod->unres);
> > +               sym_add_unresolved("module_layout", mod, false);
> >  }
> >
> >  static void read_symbols_from_files(const char *filename)
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
