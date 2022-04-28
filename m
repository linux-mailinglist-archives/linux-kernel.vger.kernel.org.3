Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D3512AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbiD1Exr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiD1Exo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:53:44 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8C6E563;
        Wed, 27 Apr 2022 21:50:26 -0700 (PDT)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 23S4oAjS015140;
        Thu, 28 Apr 2022 13:50:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 23S4oAjS015140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651121411;
        bh=HvHeejvcDRHKzw1tJx0jd+vWYPp1piZipJIqVv1NRaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ACxt701z+cudaCdxpluTeRg398QsxIGBkLVgflo2kLOzvzn3naWRk0+KKpY1lCh1w
         fIKw1nDzyFdnZkqSCloCrDzBIxUwhTcxRgki18t1RmXd2x+uSMz52JMYGxXAsf+kTx
         Pe6nYhLEoRNUy7NXpaqR4IPHIuPJYrdAmmyPttX2/mYy9x0EdkNsG8qTp7pH5mimHj
         iPbkXfmUidGn53bRD2Gxu5i9NuXUTuiju8X57O3vWy4jtn3TZffCFSCZhgll/3DI9Q
         zb5rdmfV6h5b5gMPXQPQSWogvyBqWODXOFYfpNEovyzeWNu3iGTJuZDUS/+UN93dZN
         4Hu0PGdWNvm/w==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id y38so3283688pfa.6;
        Wed, 27 Apr 2022 21:50:11 -0700 (PDT)
X-Gm-Message-State: AOAM531Cm6IXB4KQurkwBFtP/FCBumVYS2WYMV31aZbxvY2M2urO16iL
        RT9U3gsuYBAR+iTvWSdxV2IP9grrAFVaOEznMzY=
X-Google-Smtp-Source: ABdhPJzc/3BIbWAickOh8ccpNu7skgYWcfn8JOQH/fR2Fq1J6lCqBPitBC1AXjz+Y5xjMnlBa7cQukvdfYT9B+GSFvQ=
X-Received: by 2002:a65:60c1:0:b0:39d:9c28:909a with SMTP id
 r1-20020a6560c1000000b0039d9c28909amr26630354pgv.352.1651121410336; Wed, 27
 Apr 2022 21:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-23-masahiroy@kernel.org> <YmmkDoPsE5pfSxbG@bergen.fjasle.eu>
In-Reply-To: <YmmkDoPsE5pfSxbG@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 28 Apr 2022 13:49:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQt6ZppmUzgQtFx86=iCYpDMp1HFbk6TpNDUg6+y2TyEw@mail.gmail.com>
Message-ID: <CAK7LNAQt6ZppmUzgQtFx86=iCYpDMp1HFbk6TpNDUg6+y2TyEw@mail.gmail.com>
Subject: Re: [PATCH 22/27] kbuild: generate a list of objects in vmlinux
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:56 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Mon 25 Apr 2022 04:08:06 GMT Masahiro Yamada wrote:
> > A *.mod file lists the member objects of a module, but vmlinux does
> > not have such a file to list out all the member objects.
> >
> > Generate this list to allow modpost to know all the member objects.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/link-vmlinux.sh | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 20f44504a644..d2c193f82004 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -310,7 +310,7 @@ cleanup()
> >       rm -f vmlinux
> >       rm -f vmlinux.map
> >       rm -f vmlinux.o
> > -     rm -f .vmlinux.d
> > +     rm -f .vmlinux*
>
> Wouldn't it be safer to keep the removal of .vmlinux.d for some time
> and just add .vmlinux.objs?  Somehow I do not like the wildcard here.

OK, will change in v2.


> >  }
> >
> >  # Use "make V=3D1" to debug this script
> > @@ -342,6 +342,19 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=
=3Dinit need-builtin=3D1
> >  modpost_link vmlinux.o
> >  objtool_link vmlinux.o
> >
> > +# Generate the list of objects in vmlinux
> > +rm -f .vmlinux.objs
> > +for f in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
> > +     case ${f} in
> > +     *.a)
> > +             ${AR} t ${f} >> .vmlinux.objs
> > +             ;;
> > +     *)
> > +             echo ${f} >> .vmlinux.objs
> > +             ;;
> > +     esac
> > +done
>
> just some bike shedding comment:  I would have left out the 'rm -f
> .vmlinux.objs' and moved the redirection to the end of the for loop:
>
> for f in ...
>     ...
>     ${AR}
>     echo
> done > .vmlinux.objs

OK, that would shorten the code a little.
Will do in v2.



>
> but it probably not worth.
>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> > +
> >  # modpost vmlinux.o to check for section mismatches
> >  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=3D1
> >
> > --
> > 2.32.0
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
