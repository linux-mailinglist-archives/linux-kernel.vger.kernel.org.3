Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073CE4C865D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiCAIWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiCAIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:22:51 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0D6C935;
        Tue,  1 Mar 2022 00:22:10 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2218Lt14020571;
        Tue, 1 Mar 2022 17:21:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2218Lt14020571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646122915;
        bh=h6XYBnCgNsp1dMoMUfTg3MLYf/0POolcYazLaGN/rG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pqatdUy1vzvaMAWA30AewrdIHhHJnZIKEM8UacuT2Fyx1y7aw+YdCAK8DA9bLGgiR
         nohee9OgpfENeKlz32R6HHv87GrSZSPQBnwh01JH7dbIztb68qrm2RNRduq4B5xc8f
         wlmHJWEI79GGq+oVZmZvM26EkGl90pLv8gEWjW7oYCahOzi1T8SwP4+4F6NVAhEC+8
         JBZSlFtcgbzXwKJ9Egov+jEJMIvlGmdYX4rkHljxhdTWhmMELB3Pqo+q5bZ59RR6S0
         JF2LhsiKQvARCQ2puwYOInE44zZnfsxk9tmK0bJLty86ua60UfpvHnjOT91FFfE3AX
         QJwWf7Aypo1Qw==
X-Nifty-SrcIP: [209.85.215.177]
Received: by mail-pg1-f177.google.com with SMTP id o26so13157221pgb.8;
        Tue, 01 Mar 2022 00:21:55 -0800 (PST)
X-Gm-Message-State: AOAM532OPs1n9Ka979K6SUMG7h7/l1GcoxHzDEOBy7HUvJxoVBcOpP7I
        O8PAr0cBK9OQx1TwunhZT1L9J2VeGtF6Brnr3Rg=
X-Google-Smtp-Source: ABdhPJyoGquDMHIw6PHP8BM5AV/0OwxVcxaQ/6dKLXUPv7TUz7w2+TQGi7fiRWb0aehP4iwYcg71jbhFuU6kIAqUfwU=
X-Received: by 2002:a63:e758:0:b0:378:8511:cfe7 with SMTP id
 j24-20020a63e758000000b003788511cfe7mr9814678pgk.126.1646122914464; Tue, 01
 Mar 2022 00:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20220225144245.182659-1-masahiroy@kernel.org> <CAKwvOd=WjnHSHKLVRJifHxV2tyDsLTkek80NWU=do=FSHhNLug@mail.gmail.com>
 <67b75a36cf874dfea0871649ccd268d3@AcuMS.aculab.com>
In-Reply-To: <67b75a36cf874dfea0871649ccd268d3@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 1 Mar 2022 17:21:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASatB_W3WmE3BOqFNwJcFQeqh_haEDMjZnfi127gcY0QQ@mail.gmail.com>
Message-ID: <CAK7LNASatB_W3WmE3BOqFNwJcFQeqh_haEDMjZnfi127gcY0QQ@mail.gmail.com>
Subject: Re: [PATCH v2] fixdep: use fflush() and ferror() to ensure successful
 write to files
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
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

David answered most of the questions from Nick.


Let me answer this question:
"Why call ferror as opposed to checking the return code of fflush?
Reading the man page closer:"


When fprintf() happens to need to write data to the end device,
the internal buffer is cleared anyway (even if the writing to the
end device fails).
(We do not notice the failure of this because this patch is
removing xprintf().)


If the buffer has been cleared by the previous fprintf() call,
fflush() succeeds because there is no data in the internal buffer.

So, checking the return value of fflush() is not enough.

That's my understanding.
(I ran a small piece of test code under "ulimit -f")


So, we have two options:

[1] Check the return values in *all* the call-sites
    of fprintf() and fflush().


[2] Call fprintf() and fflush() or whatever without checking
     their return values.
    And, check ferror() at the last moment.




If you are really sure that all the return values are checked,
you can go with [1], then you do not need to call ferror(),
but it is generally less fragile than [2].






On Tue, Mar 1, 2022 at 11:28 AM David Laight <David.Laight@aculab.com> wrot=
e:
>
> Someone send HTML mail =E2=80=93 outlook is broken =E2=80=93 only lets yo=
u top post :-(
>
>
>
> The return value from fprintf() is normally the number of bytes written t=
o
>
> the internal buffer (8k in glibc?)
>
> Only if the buffer is full and an actual write() is done do you get any i=
ndication of an error.
>
> So you can use the error return from fprintf() to terminate a loop =E2=80=
=93 but it usually
>
> just isn=E2=80=99t worth the effort.
>
> The error status returned by ferror() is =E2=80=98sticky=E2=80=99, so you=
 need only check once.
>
> But you need to check before fclose().
>
> Since fclose() has to write out the buffer =E2=80=93 that write can also =
fail.
>
> I=E2=80=99m not sure whether fclose() returns and error in that case, but=
 adding fflush()
>
> makes the coding easier.
>
>
>
> So if you have lots of fprintf() adding data to a file (which is often th=
e case)
>
> almost all of them always succeed =E2=80=93 even if the disk is full.
>
> Adding the error paths that can never really happen just makes the
>
> code harder to read and clutters things up.
>
>
>
>                 David
>
>
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: 28 February 2022 23:01
> To: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>; David Laigh=
t <David.Laight@ACULAB.COM>; LKML <linux-kernel@vger.kernel.org>; Michal Ma=
rek <michal.lkml@markovi.net>
> Subject: Re: [PATCH v2] fixdep: use fflush() and ferror() to ensure succe=
ssful write to files
>
>
>
> On Fri, Feb 25, 2022 at 6:43 AM Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> >
> > Checking the return value of (v)printf does not ensure the successful
> > write to the .cmd file.
>
> Masahiro,
> Apologies for my delay reviewing; I was on vacation last week.
>
> Do you have more context for why this change is necessary? Perhaps you mi=
ght describe further in the commit message the use case you're trying to su=
pport?
>
> Reading the man pages for vprintf(3), fflush(3), and ferror(3), I'm curio=
us why checking the return value of ferror(3) after not doing so for `vprin=
tf` and `fflush` is preferred?
>
> Why not simply unconditionally add a call to fflush while leaving the exi=
sting return code checking on vprintf?
>
> >
> > Call fflush() and ferror() to make sure that everything has been
> > written to the file.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - add error message
> >
> >  scripts/basic/fixdep.c | 46 +++++++++++++++++-------------------------
> >  1 file changed, 19 insertions(+), 27 deletions(-)
> >
> > diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
> > index 44e887cff49b..2328f9a641da 100644
> > --- a/scripts/basic/fixdep.c
> > +++ b/scripts/basic/fixdep.c
> > @@ -105,25 +105,6 @@ static void usage(void)
> >         exit(1);
> >  }
> >
> > -/*
> > - * In the intended usage of this program, the stdout is redirected to =
.*.cmd
> > - * files. The return value of printf() must be checked to catch any er=
ror,
> > - * e.g. "No space left on device".
> > - */
> > -static void xprintf(const char *format, ...)
> > -{
> > -       va_list ap;
> > -       int ret;
> > -
> > -       va_start(ap, format);
> > -       ret =3D vprintf(format, ap);
> > -       if (ret < 0) {
> > -               perror("fixdep");
> > -               exit(1);
>
> Wouldn't the existing approach abort sooner if there was an error encount=
ered?
>
> > -       }
> > -       va_end(ap);
> > -}
> > -
> >  struct item {
> >         struct item     *next;
> >         unsigned int    len;
> > @@ -189,7 +170,7 @@ static void use_config(const char *m, int slen)
> >
> >         define_config(m, slen, hash);
> >         /* Print out a dependency path from a symbol name. */
> > -       xprintf("    $(wildcard include/config/%.*s) \\\n", slen, m);
> > +       printf("    $(wildcard include/config/%.*s) \\\n", slen, m);
> >  }
> >
> >  /* test if s ends in sub */
> > @@ -318,13 +299,13 @@ static void parse_dep_file(char *m, const char *t=
arget)
> >                                  */
> >                                 if (!saw_any_target) {
> >                                         saw_any_target =3D 1;
> > -                                       xprintf("source_%s :=3D %s\n\n"=
,
> > -                                               target, m);
> > -                                       xprintf("deps_%s :=3D \\\n", ta=
rget);
> > +                                       printf("source_%s :=3D %s\n\n",
> > +                                              target, m);
> > +                                       printf("deps_%s :=3D \\\n", tar=
get);
> >                                 }
> >                                 is_first_dep =3D 0;
> >                         } else {
> > -                               xprintf("  %s \\\n", m);
> > +                               printf("  %s \\\n", m);
> >                         }
> >
> >                         buf =3D read_file(m);
> > @@ -347,8 +328,8 @@ static void parse_dep_file(char *m, const char *tar=
get)
> >                 exit(1);
> >         }
> >
> > -       xprintf("\n%s: $(deps_%s)\n\n", target, target);
> > -       xprintf("$(deps_%s):\n", target);
> > +       printf("\n%s: $(deps_%s)\n\n", target, target);
> > +       printf("$(deps_%s):\n", target);
> >  }
> >
> >  int main(int argc, char *argv[])
> > @@ -363,11 +344,22 @@ int main(int argc, char *argv[])
> >         target =3D argv[2];
> >         cmdline =3D argv[3];
> >
> > -       xprintf("cmd_%s :=3D %s\n\n", target, cmdline);
> > +       printf("cmd_%s :=3D %s\n\n", target, cmdline);
> >
> >         buf =3D read_file(depfile);
> >         parse_dep_file(buf, target);
> >         free(buf);
> >
> > +       fflush(stdout);
> > +
> > +       /*
> > +        * In the intended usage, the stdout is redirected to .*.cmd fi=
les.
> > +        * Call ferror() to catch errors such as "No space left on devi=
ce".
> > +        */
> > +       if (ferror(stdout)) {
>
> Why call ferror as opposed to checking the return code of fflush?  Readin=
g the man page closer:
>
>        The  function feof() tests the end-of-file indicator for the strea=
m pointed to by stream, returning nonzero if it is set.  The end-of-file in=
dicator can be cleared only by the function
>        clearerr().
>
>        The function ferror() tests the error indicator for the stream poi=
nted to by stream, returning nonzero if it is set.  The error indicator can=
 be reset only by the clearerr() function.
>
> Does that imply that "the end-of-file indicator" is distinct from "the er=
ror indicator?"
>
> > +               fprintf(stderr, "fixdep: not all data was written to th=
e output\n");
> > +               exit(1);
> > +       }
> > +
> >         return 0;
> >  }
> > --
> > 2.32.0
> >
>
>
>
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>
> P Please consider the environment and don't print this e-mail unless you =
really need to



--=20
Best Regards
Masahiro Yamada
