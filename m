Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CB515EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiD3P3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiD3P3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:29:17 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6E387BF;
        Sat, 30 Apr 2022 08:25:53 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 23UFPYxD026046;
        Sun, 1 May 2022 00:25:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 23UFPYxD026046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651332335;
        bh=qhhE2v9ehDlaXGiQ1iFQc2/L5u3COQpMbfOhP1Y5XWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A31oDKzGmscJlSCB2xe0MWrCkblf+0WN8LVkr+3ykpjahpSVCD4n2X3nmqlTylAHp
         9HANFdKS6bOzPn3htQcRuJr3l28U4FJbg95zfx7nV20U5WljChL8eyYbWd8yJwIPiE
         7EDIDooZaAgra+QK5TihjLehPSsTqQ5rJqhadHYBzA2RSTgct8eWTNR/MKFffg+1wM
         3ZQ/bkxrDBbxd8CydI2JrUXYj1Wjd3HFmiJSBBGvXcy2rT5QjxX+WFLO/fUVa13Au8
         DeePzUZN9OIVVPYLzfwBIR4C8iRL9pwqEkB+10FBdsLukGY7uCHx2vf6n1D2diHgAH
         QQJnf2dlWFj4Q==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id r9so9412964pjo.5;
        Sat, 30 Apr 2022 08:25:35 -0700 (PDT)
X-Gm-Message-State: AOAM532Vny0pGjeypDinpqbFBbXEwnUiMzjlk5ZeDMg8WncctwX3CsvV
        iu4mYio8GJErfYEFKTn3TW7Oq7fkIZUH6zF1BI8=
X-Google-Smtp-Source: ABdhPJxCFSlgxSpP256JFZ8BRxf3FkZ67A+pI4rWjsP+DhM60HUSh0hmvHd0Oj0mCIaM6G7YARvVUNwBJUka3U4tdHk=
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id
 j5-20020a17090a840500b001bcd521b2c9mr9524424pjn.119.1651332334154; Sat, 30
 Apr 2022 08:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-11-masahiroy@kernel.org> <CAKwvOdnysRX_qp1KYSd331G7K863iH-Xiw3UOwKRSQm65u9i-Q@mail.gmail.com>
In-Reply-To: <CAKwvOdnysRX_qp1KYSd331G7K863iH-Xiw3UOwKRSQm65u9i-Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 May 2022 00:24:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmg6TipRSi8gnohPKjRgt9OB_sgR-o1LYy3beobf5WSg@mail.gmail.com>
Message-ID: <CAK7LNARmg6TipRSi8gnohPKjRgt9OB_sgR-o1LYy3beobf5WSg@mail.gmail.com>
Subject: Re: [PATCH 10/27] modpost: traverse unresolved symbols in order
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

On Wed, Apr 27, 2022 at 2:08 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Currently, modpost manages unresolved in a singly liked list; it adds
>
> s/liked/linked/
>
> > a new node to the head, and traverses the list from new to old.
> >
> > Use a doubly linked list to keep the order in the symbol table in the
> > ELF file.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 20 ++++++++++++++------
> >  scripts/mod/modpost.h |  2 +-
> >  2 files changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 1c7d2831e89d..e1eb188d6282 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -185,6 +185,8 @@ static struct module *new_module(const char *modname)
> >         mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
> >         memset(mod, 0, sizeof(*mod));
> >
> > +       INIT_LIST_HEAD(&mod->unresolved_symbols);
> > +
> >         strcpy(mod->name, modname);
> >         mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
> >         mod->gpl_compatible = true;
> > @@ -201,6 +203,7 @@ static struct module *new_module(const char *modname)
> >
> >  struct symbol {
> >         struct symbol *next;
> > +       struct list_head list;
>
> Isn't `list` meant to replace `next`?


No.  'next' is still used for the hash table.

modpost used it in various ways.
You need to read the code closely if you are interested in
how modpost works.

>
> >         struct module *module;
> >         unsigned int crc;
> >         bool crc_valid;
> > @@ -255,8 +258,12 @@ static struct symbol *new_symbol(const char *name, struct module *module,
> >
> >  static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
> >  {
> > -       mod->unres = alloc_symbol(name, mod->unres);
> > -       mod->unres->weak = weak;
> > +       struct symbol *sym;
> > +
> > +       sym = alloc_symbol(name, NULL);
> > +       sym->weak = weak;
> > +
> > +       list_add_tail(&sym->list, &mod->unresolved_symbols);
>
> Because I was curious here why NULL was passed, rather than remove the
> assignment to struct symbol's next member in alloc_symbol.
> I get why you replace the `unres` member of struct module. I guess I'm
> curious then why yet another list is added to struct symbol, rather
> than replace the next member.


'next' is used for ad-hoc hash table implementation.
I will be cleaned up by a later commit.

See this patch:
https://patchwork.kernel.org/project/linux-kbuild/patch/20220424190811.1678416-20-masahiroy@kernel.org/



>
> Also, does adding a struct list_head member really not specify the
> _type_ of the next element?  I guess when I look at the definition of
> struct module, at the member unresolved symbols, I don't know whether
> it's a list of struct module* or a list of struct symbol*.


This is how include/linux/list.h works.
struct list_head is really generic, does not specify a specific type definition.



>
> <snip>
>
> > diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> > index c3b5d2f0e2bb..6a90bfc08458 100644
> > --- a/scripts/mod/modpost.h
> > +++ b/scripts/mod/modpost.h
> > @@ -117,7 +117,7 @@ struct namespace_list {
> >  struct module {
> >         struct list_head list;
> >         int gpl_compatible;
> > -       struct symbol *unres;
> > +       struct list_head unresolved_symbols;
> >         bool from_dump;         /* true if module was loaded from *.symvers */
> >         bool is_vmlinux;
> >         bool seen;
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
