Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABECF4F8AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiDHAlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiDHAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:40:57 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C0A173366;
        Thu,  7 Apr 2022 17:38:55 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2380cT7T020101;
        Fri, 8 Apr 2022 09:38:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2380cT7T020101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649378309;
        bh=cNjeDzN9weH69RQ1VnbqR1X2JYg4D1jJ+YXitrVGUX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cg42i28bG+Ep5ujIFOo+HQxtafDM12rF0Hl0eDCFDbaadSlcSUvjDdGlRsDXtecGP
         zPieKsxZdn2ZWOs7k8cbK1tW9SubohjUJIkOHpdgZegAs4XEAl2Ww2ArW8/mgcyIVw
         3r3E8x2kNx8sxMvqMgRjcD8woYLReg86i+IAOn0akOzIOIqWg8t49iUFRVbDf37cuZ
         BrL5rAd/l48P4VIFh1ts0rZGyi3ySwNO5UqOxP409gizRxtzeB7MfslhYubIeayrD6
         dCmQUicolzwXlgXX+0987LGxquV1uU28Ng8uctqBO6nut8hI2DMY5/uht7NjzIIsqq
         JqPu4iFsqqOxQ==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so8097598pjk.4;
        Thu, 07 Apr 2022 17:38:29 -0700 (PDT)
X-Gm-Message-State: AOAM530G33byvCygNBqTmoVw18TpJYKZ2y2puqkp90MQnG0iWvra3Pr3
        +BC9WRFlS3ejud7NlHn4dJW/14Wqz6gMkvcEMkw=
X-Google-Smtp-Source: ABdhPJw6lsS62tcWGGnhg03UEj21K0wbz57Z3DNmjww+2jiFGcHutlaNy92LYhxGd5kYikUskHoUuCIkgyBAGn3lzxM=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr16718530plr.136.1649378308545; Thu, 07
 Apr 2022 17:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-7-masahiroy@kernel.org>
 <CAKwvOdm7NBPj43sRw-_dtjzgpHeOHnQ9uB3rSg3rYhUu0_PN7A@mail.gmail.com> <eedd7486cd484c359be90e6138b0b2be@AcuMS.aculab.com>
In-Reply-To: <eedd7486cd484c359be90e6138b0b2be@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 8 Apr 2022 09:37:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASJKMqfaifGA9r_cYqgkVgL6OPCfjFZCGN4mZwxW_rZvw@mail.gmail.com>
Message-ID: <CAK7LNASJKMqfaifGA9r_cYqgkVgL6OPCfjFZCGN4mZwxW_rZvw@mail.gmail.com>
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

On Fri, Apr 8, 2022 at 6:39 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Nick Desaulniers
> > Sent: 07 April 2022 18:59
> >
> > On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > The dependency
> > >
> > >     $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o
> > >
> > > ... exists because *.mod files previously contained undefined symbols,
> > > which are computed from *.o files when CONFIG_TRIM_UNUSED_KSYMS=y.
> > >
> > > Now that the undefined symbols are put into separate *.usyms files,
> > > there is no reason to make *.mod depend on *.o files.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  Makefile               | 3 ++-
> > >  scripts/Makefile.build | 5 ++---
> > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 82ee893909e9..e915aacd02b0 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1792,7 +1792,8 @@ ifdef single-build
> > >
> > >  # .ko is special because modpost is needed
> > >  single-ko := $(sort $(filter %.ko, $(MAKECMDGOALS)))
> > > -single-no-ko := $(sort $(patsubst %.ko,%.mod, $(MAKECMDGOALS)))
> > > +single-no-ko := $(filter-out $(single-ko), $(MAKECMDGOALS)) \
> > > +               $(foreach x, o mod, $(patsubst %.ko, %.$x, $(single-ko)))
> >
> > I'm on board with this patch, and the overall goal with the series. My
> > brain is having a hard time parsing `o mod` though. Can you walk me
> > through that? Are those targets for .o and .mod files, respectively?


Yes.

Kbuild can build a module individually.

    make  foo/bar/baz.ko

(but modpost check does not work well)

To do this, Kbuild needs to descend to
the directory and generate
foo/bar/baz.o  and  foo/bar/baz.mod.

Previously, foo/bar/baz.o was generated as a
prerequisite of foo/bar/baz.mod, but now we
need to request Kbuild to generate both of them.





> I think I'd do:
> single-no-ko := $(filter-out $(single-ko), $(MAKECMDGOALS))
> single-no-ko += $(patsubst %.ko, %.o, $(single-ko))
> single-no-ko += $(patsubst %.ko, %.mod, $(single-ko))
>
> Although you can use the simpler SYSV make suffix substitution syntax:
> single-no-ko += $(single-ko:.ko=.o) $(single-ko:.ko=.mod)


Right.   I tend to use $(patsubst ), but
in some places, shorter SYSV syntax is used.
I admit inconsistency.





>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Best Regards
Masahiro Yamada
