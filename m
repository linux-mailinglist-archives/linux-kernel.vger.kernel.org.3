Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F384F8C10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiDHCkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiDHCkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:40:45 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9010428D;
        Thu,  7 Apr 2022 19:38:43 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2382cNSR030218;
        Fri, 8 Apr 2022 11:38:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2382cNSR030218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649385503;
        bh=k+X8BU90L87wqwuBges12O8eXkSA1qgxyJVoI11kDT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S+YuyhjGMpP4/Ievn4zIry/9tr5HeyKZLtClkKDxXNLQa92Uov9Hie0tqq6hgKnKA
         2x0NvYMu+guk/bKOiRmaweoakRuFMkeLSIU1Y1nq2QmDD5q282nyT5BGD5cciEIRkz
         mdmXkbBiCygZAQnKKdeazQR2vyNIfYkpc0ppBkSyNJsb50DqWYHz638F8utrWgXY22
         1lX/4aj9CNf1YhU21G4G2lVAQrX22vj+YH3d3/EZKk/zyJ7MzRwA31hc3ypJbKH3xM
         yggUOGC5OYJwML9FNnOX6JFBzn8qsP+hwhLqwq4kPqboAZ9GWItQahCdEMV6EtYljR
         6Y3/YQ3HIs/Qg==
X-Nifty-SrcIP: [209.85.210.182]
Received: by mail-pf1-f182.google.com with SMTP id a42so676587pfx.7;
        Thu, 07 Apr 2022 19:38:23 -0700 (PDT)
X-Gm-Message-State: AOAM533r/VpFKkh4o9QaXXEz1q8WQMmdqmmgpJNCm4m1p3PDKX0BVkyJ
        ndrFA5vmQqmPFO1GVif8/IgihMIGmxUTomb8vbs=
X-Google-Smtp-Source: ABdhPJyXwwwejEV82RROrL/bzaqhrV767EkI27pBBBGDTCSllAv8VuvxumVanMN0lR9SxfDvPPfJmj+u3/cc/6wdHe0=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr13509050pgb.616.1649385502334; Thu, 07
 Apr 2022 19:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-7-masahiroy@kernel.org>
 <CAKwvOdm7NBPj43sRw-_dtjzgpHeOHnQ9uB3rSg3rYhUu0_PN7A@mail.gmail.com>
 <eedd7486cd484c359be90e6138b0b2be@AcuMS.aculab.com> <CAK7LNASJKMqfaifGA9r_cYqgkVgL6OPCfjFZCGN4mZwxW_rZvw@mail.gmail.com>
In-Reply-To: <CAK7LNASJKMqfaifGA9r_cYqgkVgL6OPCfjFZCGN4mZwxW_rZvw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 8 Apr 2022 11:37:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR68JsGK4uqwJEKi8g9-rfjFLt3RX-0PjqcCTTuwCR8ZQ@mail.gmail.com>
Message-ID: <CAK7LNAR68JsGK4uqwJEKi8g9-rfjFLt3RX-0PjqcCTTuwCR8ZQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] kbuild: make *.mod not depend on *.o
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 9:37 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Apr 8, 2022 at 6:39 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Nick Desaulniers
> > > Sent: 07 April 2022 18:59
> > >
> > > On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > The dependency
> > > >
> > > >     $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o
> > > >
> > > > ... exists because *.mod files previously contained undefined symbols,
> > > > which are computed from *.o files when CONFIG_TRIM_UNUSED_KSYMS=y.
> > > >
> > > > Now that the undefined symbols are put into separate *.usyms files,
> > > > there is no reason to make *.mod depend on *.o files.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  Makefile               | 3 ++-
> > > >  scripts/Makefile.build | 5 ++---
> > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 82ee893909e9..e915aacd02b0 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1792,7 +1792,8 @@ ifdef single-build
> > > >
> > > >  # .ko is special because modpost is needed
> > > >  single-ko := $(sort $(filter %.ko, $(MAKECMDGOALS)))
> > > > -single-no-ko := $(sort $(patsubst %.ko,%.mod, $(MAKECMDGOALS)))
> > > > +single-no-ko := $(filter-out $(single-ko), $(MAKECMDGOALS)) \
> > > > +               $(foreach x, o mod, $(patsubst %.ko, %.$x, $(single-ko)))
> > >
> > > I'm on board with this patch, and the overall goal with the series. My
> > > brain is having a hard time parsing `o mod` though. Can you walk me
> > > through that? Are those targets for .o and .mod files, respectively?
>
>
> Yes.
>
> Kbuild can build a module individually.
>
>     make  foo/bar/baz.ko
>
> (but modpost check does not work well)
>
> To do this, Kbuild needs to descend to
> the directory and generate
> foo/bar/baz.o  and  foo/bar/baz.mod.
>
> Previously, foo/bar/baz.o was generated as a
> prerequisite of foo/bar/baz.mod, but now we
> need to request Kbuild to generate both of them.
>


BTW, this feature is broken for CONFIG_LTO_CLANG=y
because the ELF object is not foo/bar/baz.o
but foo/bar/baz.prelink.o
(which was renamed from foo/bar/baz.lto.o).

I will not fix it, though.




-- 
Best Regards
Masahiro Yamada
