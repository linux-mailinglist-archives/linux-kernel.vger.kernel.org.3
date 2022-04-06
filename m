Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCCA4F5751
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiDFHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380733AbiDFHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 03:04:36 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58850B3699;
        Tue,  5 Apr 2022 22:30:10 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2365TY6C002095;
        Wed, 6 Apr 2022 14:29:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2365TY6C002095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649222975;
        bh=cgPdZWVCb6IRSSlmY7h4O7BE/w3T5icCyWQEI+QOK8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F2XmJxsfAciKRhWS0WPTJJhAWGPS2iSwCBwb73YwKSv5+V5Ca5MJkosnyHHLjCTL8
         QTQ2NIBxoE/b07Ga1omX2VQg+My/LXwooJo/6F+LaWDp+6yPYTmguLSIdFwesK50oy
         ci+7Nwx/5FsH8WDoGCNAqFJtk9r4j82k3IaoNgqpDIylE7psdpr6ar3LdDAzEVM1K4
         cjeBEDc84VbKbMQEURSDGvYl15VMARF3j6Nrgc9puyXyGVCM6JdiFPVqEhTa1KzUPe
         cxdqZic2y1hvlRGkLOyAssnRi9i+iLiBp0k3/qJgoSaRBYFJduXFdT9eusO6Tq21KP
         wc5l+uTu0HGJQ==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so1620804pjy.5;
        Tue, 05 Apr 2022 22:29:35 -0700 (PDT)
X-Gm-Message-State: AOAM5328mRnTr0/v1YIbieevrjCTyreFAf/wCJKDOAWKIWfKkrkiFcqx
        OcPQNxW/XjUZpMyPsl0C0T/ZU6mhjQlduSwp7Kg=
X-Google-Smtp-Source: ABdhPJzLsKiCp/v2xJ1WrG9HWnVaQC0FNsJIJb1jbJiI8YmlDUc3vB+W0TOUVJ+Vd9auxBAptPAaiHDEvPOWTG/3o+Q=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr7043436plr.136.1649222974223; Tue, 05
 Apr 2022 22:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220405113359.2880241-1-masahiroy@kernel.org>
 <20220405113359.2880241-8-masahiroy@kernel.org> <YkyjkAWb56wqL3iK@fjasle.eu>
In-Reply-To: <YkyjkAWb56wqL3iK@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 6 Apr 2022 14:28:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUZesT6JsyrQu-ryU+PahwSwX3UVdxnJhyYDetnR_s1A@mail.gmail.com>
Message-ID: <CAK7LNATUZesT6JsyrQu-ryU+PahwSwX3UVdxnJhyYDetnR_s1A@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] kbuild: get rid of duplication in the first line
 of *.mod files
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Apr 6, 2022 at 5:16 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Tue, Apr 05, 2022 at 08:33:55PM +0900 Masahiro Yamada wrote:
> > The first line of *.mod lists the member objects of the module.
> > This list may contain duplication if the same object is added multiple
> > times, like this:
> >
> >   obj-m :=3D foo.o
> >   foo-$(CONFIG_FOO1_X) +=3D foo1.o
> >   foo-$(CONFIG_FOO1_Y) +=3D foo1.o
> >   foo-$(CONFIG_FOO2_X) +=3D foo2.o
> >   foo-$(CONFIG_FOO2_Y) +=3D foo2.o
> >
> > This is probably not a big deal. As far as I know, the only small
> > problem is scripts/mod/sumversion.c parses the same file over again.
> > This can be avoided by adding $(sort ...). It has a side-effect that
> > sorts the objects alphabetically, but it is not a big deal, either.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - new
> >
> >  scripts/Makefile.build | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 3ef2373f0a57..63625877aeae 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -307,8 +307,10 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
> >       $(call if_changed,cc_prelink_modules)
> >  endif
> >
> > +multi-m-prereqs =3D $(sort $(addprefix $(obj)/, $($*-objs) $($*-y) $($=
*-m)))
> > +
> >  cmd_mod =3D { \
> > -     echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-obj=
s) $($*-y) $($*-m)), $(@:.mod=3D.o)); \
> > +     echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=3D.o))=
; \
>
> I'd rather expected to see $(or) here, too, as in commit 5c8166419acf ("k=
build:
> replace $(if A,A,B) with $(or A,B)").

Ah, good catch.

I fixed it up locally.

Thanks for the review.


>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> >       $(undefined_syms) echo; \
> >       } > $@
> >
> > --
> > 2.32.0
> >
> >
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
