Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBD4BF03F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiBVDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:45:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiBVDpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:45:38 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DAF240BE;
        Mon, 21 Feb 2022 19:45:13 -0800 (PST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 21M3j0i4032480;
        Tue, 22 Feb 2022 12:45:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 21M3j0i4032480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645501501;
        bh=R2Wl9mO/uTrVsBj3vIXpY3Af06YT9dbiQUgtaSK3yWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q17fLXl+la77Rw/OrgU35Cu2+M6dQpaFFxeQIShi5qMbxwrLLQ4XwsNXda/1wLsFK
         L9leRNYy8wSJsm1+4okwZe9UeIfSG/yg8qHKbv6IvHlGLuycKI+8YlxT+nqRgV44xN
         jrDffJukNGP8CoZc3uku9HGWj4i3UufkoGbIw+USqbipeP/L4heBzmsTKNUwmQvFcR
         lFx5Ouvwjs1ykv0LRtXzvkRGhVc7gebaKVO76/xx7ZmS/lZDCMRjW49u19NCLnRJTv
         AQOIdXgGfADY+mVtKk9COKRaUIAuOk80B8GrY1+UZs9kZMO5+LfkbS4uIhTfrsLIr+
         z/7/r7AwdHybw==
X-Nifty-SrcIP: [209.85.210.181]
Received: by mail-pf1-f181.google.com with SMTP id i21so10635792pfd.13;
        Mon, 21 Feb 2022 19:45:00 -0800 (PST)
X-Gm-Message-State: AOAM530ubKckJqYXKNUpdbd99N07fyGOEC21zhcg7JnhCTZIn7+rU1rE
        r60mrSFlx5bOimWPY4JATIuq9IuF4V4ff5EhXf8=
X-Google-Smtp-Source: ABdhPJwkFaH664Eu2+lSbukb04IdKTOs/E9jWk6zh/0pu8hwLH3fAWQ9gngSTM58BpK+Q6LI9wE3BorVRbBBVnwdQlM=
X-Received: by 2002:a05:6a00:24c7:b0:4e1:cb76:32d1 with SMTP id
 d7-20020a056a0024c700b004e1cb7632d1mr21840603pfv.36.1645501499642; Mon, 21
 Feb 2022 19:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20220221164316.113489-1-masahiroy@kernel.org> <04d06889d8ea41589628995a6cb53874@AcuMS.aculab.com>
In-Reply-To: <04d06889d8ea41589628995a6cb53874@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Feb 2022 12:44:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgucSQQLauRoaFza6YHGMBrSr+-ag1m=bmWXas5WEb0A@mail.gmail.com>
Message-ID: <CAK7LNAQgucSQQLauRoaFza6YHGMBrSr+-ag1m=bmWXas5WEb0A@mail.gmail.com>
Subject: Re: [PATCH] fixdep: use fflush() and ferror() to ensure successful
 write to files
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 7:33 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Masahiro Yamada
> > Sent: 21 February 2022 16:43
> > To: linux-kbuild@vger.kernel.org
> >
> > Checking the return value of (v)printf does not ensure the successful
> > write to the .cmd file.
> >
> > Call fflush() and ferror() to make sure that everything has been
> > written to the file.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: David Laight <dvid.laight@aculab.com>
>
> I'll note that you've lost the perror("fixdep").
> But I suspect that isn't very meaningful.
> If the disk is full it'd probably get lost anyway.


perror() will go to stderr, i.e. tty here.
So, that is not the issue.

ferror() itself does not set errno here; "man ferror" says,
"These  functions  should  not  fail  and  do  not set the external
variable errno"

So, I dropped perror() because I am not sure if any related error
message is printed here.

Perhaps, errno was set by some of preceding printf() calls,
but I am not quite sure if it is carried all the way to the end
of this program.








>
> > ---
> >
> >  scripts/basic/fixdep.c | 44 ++++++++++++++++--------------------------
> >  1 file changed, 17 insertions(+), 27 deletions(-)
> >
> > diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
> > index 44e887cff49b..fad6f29373a9 100644
> > --- a/scripts/basic/fixdep.c
> > +++ b/scripts/basic/fixdep.c
> > @@ -105,25 +105,6 @@ static void usage(void)
> >       exit(1);
> >  }
> >
> > -/*
> > - * In the intended usage of this program, the stdout is redirected to .*.cmd
> > - * files. The return value of printf() must be checked to catch any error,
> > - * e.g. "No space left on device".
> > - */
> > -static void xprintf(const char *format, ...)
> > -{
> > -     va_list ap;
> > -     int ret;
> > -
> > -     va_start(ap, format);
> > -     ret = vprintf(format, ap);
> > -     if (ret < 0) {
> > -             perror("fixdep");
> > -             exit(1);
> > -     }
> > -     va_end(ap);
> > -}
> > -
> >  struct item {
> >       struct item     *next;
> >       unsigned int    len;
> > @@ -189,7 +170,7 @@ static void use_config(const char *m, int slen)
> >
> >       define_config(m, slen, hash);
> >       /* Print out a dependency path from a symbol name. */
> > -     xprintf("    $(wildcard include/config/%.*s) \\\n", slen, m);
> > +     printf("    $(wildcard include/config/%.*s) \\\n", slen, m);
> >  }
> >
> >  /* test if s ends in sub */
> > @@ -318,13 +299,13 @@ static void parse_dep_file(char *m, const char *target)
> >                                */
> >                               if (!saw_any_target) {
> >                                       saw_any_target = 1;
> > -                                     xprintf("source_%s := %s\n\n",
> > -                                             target, m);
> > -                                     xprintf("deps_%s := \\\n", target);
> > +                                     printf("source_%s := %s\n\n",
> > +                                            target, m);
> > +                                     printf("deps_%s := \\\n", target);
> >                               }
> >                               is_first_dep = 0;
> >                       } else {
> > -                             xprintf("  %s \\\n", m);
> > +                             printf("  %s \\\n", m);
> >                       }
> >
> >                       buf = read_file(m);
> > @@ -347,8 +328,8 @@ static void parse_dep_file(char *m, const char *target)
> >               exit(1);
> >       }
> >
> > -     xprintf("\n%s: $(deps_%s)\n\n", target, target);
> > -     xprintf("$(deps_%s):\n", target);
> > +     printf("\n%s: $(deps_%s)\n\n", target, target);
> > +     printf("$(deps_%s):\n", target);
> >  }
> >
> >  int main(int argc, char *argv[])
> > @@ -363,11 +344,20 @@ int main(int argc, char *argv[])
> >       target = argv[2];
> >       cmdline = argv[3];
> >
> > -     xprintf("cmd_%s := %s\n\n", target, cmdline);
> > +     printf("cmd_%s := %s\n\n", target, cmdline);
> >
> >       buf = read_file(depfile);
> >       parse_dep_file(buf, target);
> >       free(buf);
> >
> > +     fflush(stdout);
> > +
> > +     /*
> > +      * In the intended usage, the stdout is redirected to .*.cmd files.
> > +      * Call ferror() to catch errors such as "No space left on device".
> > +      */
> > +     if (ferror(stdout))
> > +             exit(1);
> > +
> >       return 0;
> >  }
> > --
> > 2.32.0
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


--
Best Regards
Masahiro Yamada
