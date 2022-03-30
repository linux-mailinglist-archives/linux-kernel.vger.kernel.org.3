Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965934EB84A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiC3Cah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiC3Cag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:30:36 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCB4707B;
        Tue, 29 Mar 2022 19:28:51 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 22U2SY9l012583;
        Wed, 30 Mar 2022 11:28:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 22U2SY9l012583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648607314;
        bh=DIW0nIffIPFPic3tK/p4VL1FHqcJBciXVix5FyElOyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NbDiuji5913GLjhudxdicewhLeotMmptmoRzKH0KMLZJXODYCoJhIVuaXiOucERTN
         2+ANOTQkPEgLsGEspthoZTbWzqHNYfbMzSbrGXXNYaZeHEMwzSDTzUwtUErIWAeS9H
         GwK3s2XRFQkuYTBhgmA2dl9jKlvca7xV/c3gzzjXo2xNDwTblgyQEKBL6RG8QLHgyA
         9MKNlROwSpLT0jXXG7ntLtxxeQbJPFsAM/25jIxHjizGlOvpGcEKLMT61b3ay+xbLS
         DZcmezStPE0+5FMnkv31cH+nlLhDt6tfMCUrxQWH4Ghj2B7pr/5RY1G/SBtleWLVuO
         HjGd/4T16y7Lg==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id bx5so19264039pjb.3;
        Tue, 29 Mar 2022 19:28:34 -0700 (PDT)
X-Gm-Message-State: AOAM533tS3u3iNPtqPTxDGBB/MvbuF0dBf8Tr356yjBVgDwfaq/BfJFD
        s+JuY7KRFZRQxQZYpHleoYEvGqe8YVyBuneX1Xg=
X-Google-Smtp-Source: ABdhPJyKlPeDJO2j4TcBLQ61J3xSdq+dKpklZCUa6rDbRxwt6cK6R+pJ2ZEEtSrXKRUBbaZ8mxhMlRHLtCi5UJdgfIY=
X-Received: by 2002:a17:90a:840a:b0:1c9:5c4f:5e83 with SMTP id
 j10-20020a17090a840a00b001c95c4f5e83mr2373993pjn.144.1648607313716; Tue, 29
 Mar 2022 19:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021520.308997-1-masahiroy@kernel.org> <20220329021520.308997-2-masahiroy@kernel.org>
 <CAKwvOdnbEVj=Y-AVSWnOT1g3jUEJdAESHjhny=5d8iXcKWgb9A@mail.gmail.com>
In-Reply-To: <CAKwvOdnbEVj=Y-AVSWnOT1g3jUEJdAESHjhny=5d8iXcKWgb9A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 30 Mar 2022 11:27:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUj8tsC-m95-UbQdaQcYTBQWN=7OFQuS81+B9RdLo4KQ@mail.gmail.com>
Message-ID: <CAK7LNARUj8tsC-m95-UbQdaQcYTBQWN=7OFQuS81+B9RdLo4KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: do not remove empty *.symtypes explicitly
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

On Wed, Mar 30, 2022 at 3:28 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Mar 28, 2022 at 7:15 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Presumably, 'test -s $@ || rm -f $@' intends to remove the output when
> > the genksyms command fails.
> >
> > It is unneeded because .DELETE_ON_ERROR automatically removes the output
> > on failure.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.build | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 3f2985df4d60..974bb6435826 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -135,9 +135,7 @@ genksyms = scripts/genksyms/genksyms                \
> >  cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
> >
> >  quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
> > -cmd_cc_symtypes_c =                                                         \
> > -    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
> > -    test -s $@ || rm -f $@
> > +      cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@)
>
> Was it an accident that you removed the redirection of stdout to
> /dev/null here, but not also below?

It was an accident. I will fix it. Thanks.



> If quiet_modtag silences the output, perhaps the redirection should be
> dropped below as well?
>
> >
> >  $(obj)/%.symtypes : $(src)/%.c FORCE
> >         $(call cmd,cc_symtypes_c)
> > @@ -348,9 +346,7 @@ cmd_gensymtypes_S =                                                         \
> >      $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
> >
> >  quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
> > -cmd_cc_symtypes_S =                                                         \
> > -    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
> > -    test -s $@ || rm -f $@
> > +      cmd_cc_symtypes_S = $(call cmd_gensymtypes_S,true,$@) >/dev/null
> >
> >  $(obj)/%.symtypes : $(src)/%.S FORCE
> >         $(call cmd,cc_symtypes_S)
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
