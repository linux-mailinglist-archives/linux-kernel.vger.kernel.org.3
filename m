Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55E44EEF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiDAOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiDAOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:22:35 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9A53587B;
        Fri,  1 Apr 2022 07:20:44 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 231EK99B011221;
        Fri, 1 Apr 2022 23:20:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 231EK99B011221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648822810;
        bh=7MllFZr0n9QEjWrWcZh3FlGDBTv9TwP0Hjh1AS6NRUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lcFGTuubeqcOxM9MWWJnG+hheq6v268TOYf1ATG6O5nXHZtx2heGj6VVZPpF1vd6g
         KNqo17SZjMkt8Q8oKQWu6THgSJ8ihheKclgJHFPg7+fivIxdpoJqYEIik3EVEts1/u
         ZWxvqFZmjD+Fw43BBO8yJSozTLUJO/NOVyfYdRKSFngbb04WrGSgT7sOM3nCtrPjr6
         Q4sLpNdc5KoxoeHmuMzS9cAxAUhpWNpezvbHLhyjNas666vrKfkYwkBaduYCUBh011
         gxDaV8EAnkz1Tmzaxye/UTNedvoWAT6KCbwuZJdJdsfll46dvE742CAp/ozmv7Vt/H
         MOFjQXX+IH1fg==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id jx9so2532159pjb.5;
        Fri, 01 Apr 2022 07:20:09 -0700 (PDT)
X-Gm-Message-State: AOAM530tagDbX/QTTQNDYO+5PVjotqbnt3gqudWL65YomvXODyVl28lR
        cPsSTLd6J2Eu/CacS+k5WvfXj2Aqmn09nmgsZgs=
X-Google-Smtp-Source: ABdhPJzhLFu3ZnWjtpJYuEthVtugcH4YYafyhXH2Vw/9i9Kg5bi/FoM8nC7Cwt1Be2WC5kV15ORKMz0zW9KF6tpakyM=
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id
 j5-20020a17090a840500b001bcd521b2c9mr12155436pjn.119.1648822809130; Fri, 01
 Apr 2022 07:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220330182329.52310-1-s23265@iisve.it> <CAK7LNARvEsh3+dix+EdcXnm2L0rh8hndQD5N2vyc0q_c0Vf7gQ@mail.gmail.com>
In-Reply-To: <CAK7LNARvEsh3+dix+EdcXnm2L0rh8hndQD5N2vyc0q_c0Vf7gQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Apr 2022 23:19:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3cj2M0+k2H0O30wdOwONGE3OVrFJfTHicpqaKPRgG3Q@mail.gmail.com>
Message-ID: <CAK7LNAQ3cj2M0+k2H0O30wdOwONGE3OVrFJfTHicpqaKPRgG3Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use hostname -s along uname to obtain LINUX_COMPILE_HOST
To:     FraSharp <f.duca00@gmail.com>
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

On Fri, Apr 1, 2022 at 11:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 3:23 AM FraSharp <f.duca00@gmail.com> wrote:
> >
> > From: Francesco Duca <s23265@iisve.it>
> >
> > * On some systems (e.g. macOS), using commands like 'uname -n' or
> >   'hostname' will print something similar to "hostname.domain"
>
>
> Not only macOS, but also on Linux systems such as Fedora, Debian.
>
> 'uname -s' or 'hostname' prints "hostname.domain"

I mean,

    'uname -n' or 'hostname' prints "hostname.domain"



>
>
>
> >   ("Francescos-Air.fritz.box" for example), which is very annoying.
>
> I do not think so.
>
>
> >   What works instead is 'hostname -s', which will only write hostname
> >   without the domain ("Francescos-Air" for example),
> >   but also keep 'uname -n', as some systems as Arch Linux does not have
> >   'hostname' as command.
>
> If so, on Arch Linux, will this patch spit
>   hostname: command not found
> error message because   "2>/dev/null" is missing ?
>
>
> And, the intention of this patch is,
> print  Francescos-Air if the 'hostname -s' command is available,
> but Francescos-Air.fritz.box  otherwise, correct  ?
>
>
>
>
>
>
> >
> > * This commit is complementary to
> >   1e66d50ad3a1dbf0169b14d502be59a4b1213149
> >   ("kbuild: Use uname for LINUX_COMPILE_HOST detection")
> >
> > Signed-off-by: Francesco Duca <s23265@iisve.it>
> > ---
> >  scripts/mkcompile_h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> > index ca40a5258..6054e3eee 100755
> > --- a/scripts/mkcompile_h
> > +++ b/scripts/mkcompile_h
> > @@ -34,7 +34,7 @@ else
> >         LINUX_COMPILE_BY=$KBUILD_BUILD_USER
> >  fi
> >  if test -z "$KBUILD_BUILD_HOST"; then
> > -       LINUX_COMPILE_HOST=`uname -n`
> > +       LINUX_COMPILE_HOST=$(hostname -s || uname -n)
> >  else
> >         LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
> >  fi
> > --
> > 2.32.0 (Apple Git-132)
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
