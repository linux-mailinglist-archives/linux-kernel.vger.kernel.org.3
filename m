Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12550EF98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbiDZEM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiDZEMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:12:54 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3464E17E3E;
        Mon, 25 Apr 2022 21:09:47 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 23Q49Mom019014;
        Tue, 26 Apr 2022 13:09:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 23Q49Mom019014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650946162;
        bh=vlQmv5riRzngKOKBqAqSk4kL8xP/v527bj+1qTzl/Rs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kDRO6n4gcrugtInPeEtD2mbsqkzimAnrWpgjATsadHhZu2Mi3sukqotidRdr0/5Oy
         VPhYHBPYXCEJpLzSb+5rq+K3nqW2cE42H6K8ONhywaLUGgve5ql7hcbrYM2WK1G9NA
         /OqC30MXIOxKCzvK/qT1sUWsmyNEt+Bhink6eUw41ePn92d7GYFHmuAmcilP6Itpw1
         YEnCme4mVk4EjUOscfA/yCqfleX9hHW7df0Ae/+g4qzBwDRX4t580HHYqZU/2aKVeA
         CUXWwbUFqAnFvk38Wmzmx1sPBjK2o9T4azPl59o/vr/+9LlI1vTX3aT0OyRykhnE2O
         pGNktduCLdJeA==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id u6-20020a17090a1f0600b001d86bd69427so1355364pja.5;
        Mon, 25 Apr 2022 21:09:22 -0700 (PDT)
X-Gm-Message-State: AOAM532dIkyNtxjdZDkVwfmGKsGTXoUHtDDGK/c41iUE7axQxNKv6AKg
        5lekvUnG9t65YM542UHSWPaLjQ73mIZx/pMAbxo=
X-Google-Smtp-Source: ABdhPJyeTNXk3eEgUbbGnI1xpxigeGRimHhJalVAMLzx3oMGsvYQPLReffx9PB/krO9KrZOWN3kQB06Mm5If++lLOVw=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr24345046pjy.77.1650946161687; Mon, 25
 Apr 2022 21:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-17-masahiroy@kernel.org> <CAKwvOdk1nt4b9am=_BP=U3igkSRBN14nx+5oS8iaaw9zhbH5JA@mail.gmail.com>
In-Reply-To: <CAKwvOdk1nt4b9am=_BP=U3igkSRBN14nx+5oS8iaaw9zhbH5JA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Apr 2022 13:08:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-u=EVzPL+iJHoBW62AK2ViD3nVnL79EdxNS03UxmkBA@mail.gmail.com>
Message-ID: <CAK7LNAR-u=EVzPL+iJHoBW62AK2ViD3nVnL79EdxNS03UxmkBA@mail.gmail.com>
Subject: Re: [PATCH 16/27] modpost: make multiple export error
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

On Tue, Apr 26, 2022 at 3:48 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > This is currently a warning, but I think modpost should stop building
> > in this case.
> >
> > If the same symbol is exported multiple times and we let it keep going,
> > the sanity check becomes difficult.
> >
> > Only the legitimate case is that an external module overrides the
> > corresponding in-tree module to provide a different implementation
> > with the same interface.
>
> Could the same module export a weak version of a symbol, and a strong one?

No.  There is no concept like   EXPORT_SYMBOL_WEAK.

I am talking about kmod things.
You can modprobe an external module instead of the in-kernel one.

>
> Can kernel modules override in-kernel strong symbols?

Yes, I think so.


>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 14044cd94aaa..73f0b98e3b5a 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -411,9 +411,9 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
> >                 list_add_tail(&s->list, &mod->exported_symbols);
> >         } else if (!external_module || s->module->is_vmlinux ||
> >                    s->module == mod) {
> > -               warn("%s: '%s' exported twice. Previous export was in %s%s\n",
> > -                    mod->name, name, s->module->name,
> > -                    s->module->is_vmlinux ? "" : ".ko");
> > +               error("%s: '%s' exported twice. Previous export was in %s%s\n",
> > +                     mod->name, name, s->module->name,
> > +                     s->module->is_vmlinux ? "" : ".ko");
> >                 return s;
> >         }
> >
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
