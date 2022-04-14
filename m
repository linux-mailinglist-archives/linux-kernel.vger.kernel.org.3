Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111DA5017BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiDNPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344633AbiDNPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:39:20 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBA0433B2;
        Thu, 14 Apr 2022 08:16:51 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 23EFGbYq018720;
        Fri, 15 Apr 2022 00:16:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23EFGbYq018720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649949398;
        bh=pZAJtygSVmbKTNXuD7l5zcPaOSLqBFoMTTpuCRaKmGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=immBGPKVEDIH9IfeoELrfMaGJ3K2KY9zHUDGtuJs406kRjHFl0yLRrEQALD4u1vAg
         rahtDxTVGxwcn9rU7/3d/Fv9vSCMx3C4iYz2Hhx0hMcc6Xydc7bsoHcKw3KG6ggH4S
         HDUJ62jqUwq0gIFISRWTxIRzRqgT/SxkQLTAammL+5+w4Tjdsf8oCnosTMI5nfEtjN
         EuZmz9+u9cbq+ltHoqY/NskG+uRKCXMOlA1gcnAwv6lWUHrYnogFwz6eMFYdD9Agx5
         uig6mtJ5/5r3Xqo/7nrYmEY5BXF26dDqRHuMR8ylKSYLtSsgG5fR55GRuDwCJS8SWe
         MejJ3DVPaSTpg==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id ll10so5408404pjb.5;
        Thu, 14 Apr 2022 08:16:37 -0700 (PDT)
X-Gm-Message-State: AOAM531Hf6iTmruMkHe3sLeF0FuZejsTeagOz+mDSr+334hfRukJomzb
        RKsc4YLeq13C/GmTrR0LxA4kLZJ/5wL3X8HDM2k=
X-Google-Smtp-Source: ABdhPJwuMbF3kddDumdFdhCpEaX4B4g32YDZWW1V2vN9meXzaTcb8eNHOvNDjHrqamfqkeA9z9BV3ZENmi456uYXtxM=
X-Received: by 2002:a17:902:7083:b0:158:41f2:3a83 with SMTP id
 z3-20020a170902708300b0015841f23a83mr25282827plk.99.1649949396808; Thu, 14
 Apr 2022 08:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
 <20220408084607.106468-1-ydroneaud@opteya.com> <CAK7LNAQZLt_OecOogOQiSu5snW+sffsMoFgVcjPTx_idj_=_tQ@mail.gmail.com>
 <CAKwvOd=yNnKsHJo0QWvoTuFF9p-y=cTftTD+7FY-wJ_f23zFTQ@mail.gmail.com>
 <81585705-6ed8-12e5-1355-332a6a5d2b17@infradead.org> <CAK7LNAS6ap9dR=kzRgQgt+d7FBBbVrwEqGU9g_pFD+nzMUt+gQ@mail.gmail.com>
 <YlgdF9qmJyYGHKXZ@bergen.fjasle.eu>
In-Reply-To: <YlgdF9qmJyYGHKXZ@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 Apr 2022 00:15:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVKL4vCRHz5=_sW_oBpkpqhDu5Hp1hfG+Hnwqg-61HVA@mail.gmail.com>
Message-ID: <CAK7LNARVKL4vCRHz5=_sW_oBpkpqhDu5Hp1hfG+Hnwqg-61HVA@mail.gmail.com>
Subject: Re: [PATCHv1] kbuild: support W=e to make build abort in case of warning
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:19 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> P=C3=A5 l=C3=B8. 09. april 2022 kl. 10.47 +0000 skrev Masahiro Yamada:
> > On Sat, Apr 9, 2022 at 5:36 AM Randy Dunlap <rdunlap@infradead.org> Wro=
te:
> > >
> > >
> > >
> > > On 4/8/22 13:29, Nick Desaulniers wrote:
> > > > On Fri, Apr 8, 2022 at 4:06 AM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
> > > >>
> > > >> On Fri, Apr 8, 2022 at 5:46 PM Yann Droneaud <ydroneaud@opteya.com=
> wrote:
> > > >>>
> > > >>> When developing new code/feature, CONFIG_WERROR is most
> > > >>> often turned off, especially for people using make W=3D12 to
> > > >>> get more warnings.
> > > >>>
> > > >>> In such case, turning on -Werror temporarily would require
> > > >>> switching on CONFIG_WERROR in the configuration, building,
> > > >>> then switching off CONFIG_WERROR.
> > > >>>
> > > >>> For this use case, this patch introduces a new 'e' modifier
> > > >>> to W=3D as a short hand for KCFLAGS+=3D-Werror" so that -Werror
> > > >>> got added to the kernel (built-in) and modules' CFLAGS.
> > > >>>
> > > >>> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > > >>> ---
> > > >>>  Makefile                   |  1 +
> > > >>>  scripts/Makefile.extrawarn | 13 +++++++++++--
> > > >>>  2 files changed, 12 insertions(+), 2 deletions(-)
> > > >>>
> > > >>> Changes since v0[0]:
> > > >>>
> > > >>>  - rebase on top of commit 64a91907c896 ("kbuild: refactor script=
s/Makefile.extrawarn")
> > > >>>  - document use case after commit 3fe617ccafd6 ("Enable '-Werror'=
 by default for all kernel builds")
> > > >>>
> > > >>> [0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email=
-ydroneaud@opteya.com/
> > > >>
> > > >>
> > > >> I remembered the previous submission, I liked it, but I had lost i=
t.
> > > >>
> > > >> It seems already 7 years ago, (before I became the Kbuild maintain=
er).
> > > >> Thanks for coming back to this.
> > > >>
> > > >>
> > > >> I like this, but I will wait some time for review comments.
> > > >
> > > > Dunno, this seems pretty simple:
> > > >
> > > > $ ./scripts/config -e WERROR
> > > > $ make ... W=3D12
> > >
> > > Yeah, that's about what I was thinking too..
> >
> >
> >
> > But, you cannot change the .config
> > when you build external modules.
> >
> > "make W=3De" might be useful for people who strive to
> > keep their downstream modules warning-free.
> >
> >
> > W=3De is the same pattern.
> > I do not see much downside.
>
> If I set CONFIG_WERROR=3Dy on the make command line, I could have the
> same result, don't I?
>
>   make CONFIG_WERROR=3D1 ...
>
> no matter if in-tree or for external kernel modules.

Yes.

If you can change the kernel configuration,
you can enable CONFIG_WERROR.

To build external modules against the read-only
/lib/modules/$(uname -r)/build/,
it is not so feasible to change the .config file, though.


>
> Kind regards,
> Nicolas



--=20
Best Regards
Masahiro Yamada
