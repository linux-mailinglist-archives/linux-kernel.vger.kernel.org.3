Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FC858B8DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiHGBRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 21:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiHGBR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 21:17:29 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87295BF65;
        Sat,  6 Aug 2022 18:17:27 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2771HB5c018313;
        Sun, 7 Aug 2022 10:17:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2771HB5c018313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659835032;
        bh=o8MuPIw4DZiHc+jpv3V731xXZptYOw1RzvyxKMWlBTE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S/jQiVSIjaO2EmP4FvPiYgmgzt3D+czwx8JiYBVch4Ko/aqcUco+rgzzJGmNPZdYO
         OF9kCjrWUmGJt4LQDeycpeFRV+UQxGpal+HWzFNj5ZAlJ/uoA9YxMoypb2BAfxoUIl
         o7ah0C4y/wSiRcdJJyoviQu4laaeaEh/sXX1EohnE1RKKSmCMxwggnZoW5REGIhbkz
         8+DuZUt5m9940hITiuytuHaHTA+OwlAYJbnRlqzV7eKRoghVIOaz7ZgBwXpfCYcuLo
         7AQG39hP9WR0vID6VUBTfN6qCkGKIXqjj5QqileE+r2WP78Whqp8tJLONuH4LriTKd
         ptGMMH+tldvqw==
X-Nifty-SrcIP: [209.85.128.48]
Received: by mail-wm1-f48.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso2886823wmq.3;
        Sat, 06 Aug 2022 18:17:12 -0700 (PDT)
X-Gm-Message-State: ACgBeo26kc7pJlaVjj/4dt7mh17s47emsQn7m8ULioEPB4V/PYr69Eo2
        46iiLGJ1aPcWNhGnnJCqRoVCHUwBw4yBiMjauHU=
X-Google-Smtp-Source: AA6agR4hzpBjPmGeTxdFIyJSbWoulcTEDRJnwnW13dAL+5ISuWNMCJThH5M3InCwVtRpeiKYBGpKpQQybpxaY6L/MuQ=
X-Received: by 2002:a05:600c:a43:b0:3a4:d07e:1151 with SMTP id
 c3-20020a05600c0a4300b003a4d07e1151mr13599648wmq.169.1659835030718; Sat, 06
 Aug 2022 18:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220728031433.1077354-1-masahiroy@kernel.org> <YuvwAkqHRk2pbh4f@fjasle.eu>
In-Reply-To: <YuvwAkqHRk2pbh4f@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 7 Aug 2022 10:16:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8dnYD8rpqrqJ96zQ48uSXA-JNopyxqDw30OTxK6pFhQ@mail.gmail.com>
Message-ID: <CAK7LNAT8dnYD8rpqrqJ96zQ48uSXA-JNopyxqDw30OTxK6pFhQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: set EXIT trap before creating temporary directory
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Aug 5, 2022 at 1:13 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu, Jul 28, 2022 at 12:14:33PM +0900, Masahiro Yamada wrote:
> > Swap the order of 'mkdir' and 'trap' just in case the subshell is
> > interrupted between 'mkdir' and 'trap' although the effect might be
> > subtle.
> >
> > Please not this is not a perfect solution to avoid the left-over tmp
>
> not -> note?


Right.
It is a typo.



>
> > directory. There are more cases that miss to remove the tmp directory,
> > for example:
> >
> >  - When interrupted, dash does not invoke the EXIT trap (bash does)
> >
> >  - 'rm' command might be interrupted before removing the directory
> >
> > I am not addressing all the cases since the tmp directory is harmless
> > after all.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Kconfig.include   | 2 +-
> >  scripts/Makefile.compiler | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Do you want to add the same for filechk macro in scripts/Kbuild.include?



No, I do not think so.


In filechk

   mkdir -p $(dir $@);


this is a directory for the target.
So, the trap does not delete it.



Otherwise, all call-sites must create the directory manually.



$(timeconst-file): kernel/time/timeconst.bc FORCE
        @mkdir -p $(dir $@)
        $(call filechk,gentimeconst)







> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> Kind regards,
> Nicolas
>
> >
> > diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> > index c1f4222d223d..a0ccceb22cf8 100644
> > --- a/scripts/Kconfig.include
> > +++ b/scripts/Kconfig.include
> > @@ -25,7 +25,7 @@ failure =3D $(if-success,$(1),n,y)
> >
> >  # $(cc-option,<flag>)
> >  # Return y if the compiler supports <flag>, n otherwise
> > -cc-option =3D $(success,mkdir .tmp_$$; trap "rm -rf .tmp_$$" EXIT; $(C=
C) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
> > +cc-option =3D $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(C=
C) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
> >
> >  # $(ld-option,<flag>)
> >  # Return y if the linker supports <flag>, n otherwise
> > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > index 86ecd2ac874c..94d0d40cddb3 100644
> > --- a/scripts/Makefile.compiler
> > +++ b/scripts/Makefile.compiler
> > @@ -21,8 +21,8 @@ TMPOUT =3D $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD=
_EXTMOD))/).tmp_$$$$
> >  # automatically cleaned up.
> >  try-run =3D $(shell set -e;            \
> >       TMP=3D$(TMPOUT)/tmp;              \
> > -     mkdir -p $(TMPOUT);             \
> >       trap "rm -rf $(TMPOUT)" EXIT;   \
> > +     mkdir -p $(TMPOUT);             \
> >       if ($(1)) >/dev/null 2>&1;      \
> >       then echo "$(2)";               \
> >       else echo "$(3)";               \
> > --
> > 2.34.1
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --



--=20
Best Regards
Masahiro Yamada
