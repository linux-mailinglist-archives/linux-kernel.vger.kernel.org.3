Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B704EF712
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355609AbiDAPxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354015AbiDAPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:50:50 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE918C0CD;
        Fri,  1 Apr 2022 08:24:12 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 231FNgBi014568;
        Sat, 2 Apr 2022 00:23:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 231FNgBi014568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648826623;
        bh=R0dE/GJxxZwKKY9OqrOmtXhqMl/LHgAoLbcP/Uz/hjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WoSpCIJnCHfCCtSALIo3MBs+VLdAaXG7pSvcA3nYQZY/0d+zuMQIikQxKc59RRkNz
         NH7hLIXuo7KPKsWEiR4NyvrEsT9dHaV80md8oLUshnzF82nGPFbqIjLvU9FK+fCeXr
         Wqtrt6cFpYO5iC5lhUN3cq/29ni8bBJXzHeN2wKa1dWvLvAgy/oNT3uLgbVs7KosDG
         QBAU7C9bbBhc/rxCymA7tY/ag1KqgiptIW0Xi47QfN0Dqm0jT2m1oqZWIEmqV+iHQL
         uNA5jbEFmv8JVwgKytIrKNzodOjxZJmdYJjgtHIhcX5RDz8wqdj+nhc7L0mn0ogLih
         e4WQw2GDPpMZg==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2895993pjm.0;
        Fri, 01 Apr 2022 08:23:42 -0700 (PDT)
X-Gm-Message-State: AOAM532I+11Dtg45lI1ACewNveDZDYLMf6TqQyYjMRxPKOo0RunUFxBH
        eQIIfBFM/wf37DFy5nzYLBTFnz6tYjwwDmOXgUA=
X-Google-Smtp-Source: ABdhPJzrKZuYUTascgmX1k8pTSoQQWg823Z67H1nqBuhjK+3DBk9nAv9dVZEodQzvFCRbmNsJAj54JN2Auf+I4Bx5H0=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr11069874plr.136.1648826621987; Fri, 01
 Apr 2022 08:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220330182329.52310-1-s23265@iisve.it> <CAK7LNARvEsh3+dix+EdcXnm2L0rh8hndQD5N2vyc0q_c0Vf7gQ@mail.gmail.com>
 <CAK7LNAQ3cj2M0+k2H0O30wdOwONGE3OVrFJfTHicpqaKPRgG3Q@mail.gmail.com> <YkcU4mpNX7AsJgbg@Francescos-Air.fritz.box>
In-Reply-To: <YkcU4mpNX7AsJgbg@Francescos-Air.fritz.box>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 2 Apr 2022 00:22:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvFnac4sSFkbtMT-+h6-jGNuCaJpNZOua0g5wg56vRjQ@mail.gmail.com>
Message-ID: <CAK7LNATvFnac4sSFkbtMT-+h6-jGNuCaJpNZOua0g5wg56vRjQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use hostname -s along uname to obtain LINUX_COMPILE_HOST
To:     Francesco Duca <f.duca00@gmail.com>
Cc:     Francesco Duca <s23265@iisve.it>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 12:06 AM Francesco Duca <f.duca00@gmail.com> wrote:
>
> >And, the intention of this patch is,
> >print  Francescos-Air if the 'hostname -s' command is available,
> >but Francescos-Air.fritz.box  otherwise, correct  ?
>
> Yes exactly, this is the intention of this patch
>
> >error message because   "2>/dev/null" is missing ?
>
> It is missing indeed, i forgot to add it.
>
> I will send a new v2 patch in a while
>
> On Fri, Apr 01, 2022 at 11:19:22PM +0900, Masahiro Yamada wrote:
> > On Fri, Apr 1, 2022 at 11:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Thu, Mar 31, 2022 at 3:23 AM FraSharp <f.duca00@gmail.com> wrote:
> > > >
> > > > From: Francesco Duca <s23265@iisve.it>
> > > >
> > > > * On some systems (e.g. macOS), using commands like 'uname -n' or
> > > >   'hostname' will print something similar to "hostname.domain"
> > >
> > >
> > > Not only macOS, but also on Linux systems such as Fedora, Debian.
> > >
> > > 'uname -s' or 'hostname' prints "hostname.domain"
> >
> > I mean,
> >
> >     'uname -n' or 'hostname' prints "hostname.domain"
> >
> >
> >
> > >
> > >
> > >
> > > >   ("Francescos-Air.fritz.box" for example), which is very annoying.
> > >
> > > I do not think so.
> > >
> > >
> > > >   What works instead is 'hostname -s', which will only write hostname
> > > >   without the domain ("Francescos-Air" for example),
> > > >   but also keep 'uname -n', as some systems as Arch Linux does not have
> > > >   'hostname' as command.
> > >
> > > If so, on Arch Linux, will this patch spit
> > >   hostname: command not found
> > > error message because   "2>/dev/null" is missing ?
> > >
> > >
> > > And, the intention of this patch is,
> > > print  Francescos-Air if the 'hostname -s' command is available,
> > > but Francescos-Air.fritz.box  otherwise, correct  ?

I do not see a good reason to output different strings on different
distributions.
( <hostname> on Debian vs <hostname>.<domainname> on Arch Linux)


<hostname>.<domainname> is just fine.
As I said, it is not annoying.

NACK.






> > >
> > >
> > >
> > >
> > >
> > >
> > > >
> > > > * This commit is complementary to
> > > >   1e66d50ad3a1dbf0169b14d502be59a4b1213149
> > > >   ("kbuild: Use uname for LINUX_COMPILE_HOST detection")
> > > >
> > > > Signed-off-by: Francesco Duca <s23265@iisve.it>
> > > > ---
> > > >  scripts/mkcompile_h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> > > > index ca40a5258..6054e3eee 100755
> > > > --- a/scripts/mkcompile_h
> > > > +++ b/scripts/mkcompile_h
> > > > @@ -34,7 +34,7 @@ else
> > > >         LINUX_COMPILE_BY=$KBUILD_BUILD_USER
> > > >  fi
> > > >  if test -z "$KBUILD_BUILD_HOST"; then
> > > > -       LINUX_COMPILE_HOST=`uname -n`
> > > > +       LINUX_COMPILE_HOST=$(hostname -s || uname -n)
> > > >  else
> > > >         LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
> > > >  fi
> > > > --
> > > > 2.32.0 (Apple Git-132)
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada



--
Best Regards
Masahiro Yamada
