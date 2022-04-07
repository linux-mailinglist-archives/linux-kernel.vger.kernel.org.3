Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11D44F7CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiDGKaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbiDGKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:30:09 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590FFF61E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:27:51 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e1so3897137ile.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=c2ljWgP/eqU8wqD1f5AHEa0qe4TYK8IE+KrCBtQimaw=;
        b=Q5bTA0cMq9l1MJH4lvA30XWtjW4rp1D1xxBM68GjL9Eg6GiVQscdiz8oPB1ThhETxa
         zzdFXpohU8Df3ffYBI5waUNKURStEMeygvo9FmURemR5Y/xoGXp70cRthruzuQggwA5R
         11fR/y9ofkWPqVHZhazgTmizhs5s7VyHBpyoM39pbulkhHJubgOVrdnoOQ6jMMZGGyj5
         ZQz9tpD9VgryNz4OZdk2Fsmf8OEIiRD9liKaNJgmr7jXBpaAcWvwt9WKpNt9EM1bW5gB
         zVANTT7qv3w6ysD4c0WoT7DfGFqFyTs5SkTqGeIDLdcLZGLXmq6uNyWepX+7q42IGYsp
         L8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=c2ljWgP/eqU8wqD1f5AHEa0qe4TYK8IE+KrCBtQimaw=;
        b=y6BCuJOFhiZLFu0frXuaGEAzroJW3tIPQgTv7PJXG8I6qrfab8eoaKR+qshLiAfQGI
         8bwbKFPYMsSPYHwvzLVaN4RBpre3GVHItRart3hPF8VKT76ykV+qH3iZbX9QxoBK/ESg
         /3NGScVGqR/+POtyD8CQJIaHdirrsyO6sEdTMl99r74j9xjEX/pn1uU3IzlP1uYBTanM
         ZvVo1iyxnQZl3Yp25MSJOqyaBIR6aqtRX1lFGLWR15ZT+xZta3cWUZovkf9fhYxWwUsI
         yDW1wIAwhoK4tugChbkchR9fEoRFnVMKKMKSFe35jcypNeb9roPjxI9JNS1NNnfq5+MX
         D/Qw==
X-Gm-Message-State: AOAM532Xvudo9o2HqolzkEgdgMxbyvt+6ovGr9HoM0Qmu3cO9WVWmpy9
        0rWb7cSJ+GJZjvHm8HbA6+mcebWd65jMj255eF4=
X-Google-Smtp-Source: ABdhPJwT1j9mXF/I3a+r9E4Ck7BsgljiuDzaCPag16p1AWFT3ePZm6zkDTEmTom89lWnm9DFYETXJu/T3hPVzmWRjLM=
X-Received: by 2002:a05:6e02:1c07:b0:2c9:bdfa:caa5 with SMTP id
 l7-20020a056e021c0700b002c9bdfacaa5mr6121375ilh.100.1649327270581; Thu, 07
 Apr 2022 03:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <YktYX2OnLtyobRYD@kernel.org> <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
In-Reply-To: <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 7 Apr 2022 12:27:14 +0200
Message-ID: <CA+icZUVKgLLJvNF6ZU1e7Hjr_FsJO7x0gsGL6Jje1nv2ukhueA@mail.gmail.com>
Subject: Re: Build perf with clang, failure with libperf
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 11:53 PM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> Hi Arnaldo,
>
> On Mon, Apr 04, 2022 at 05:43:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
> >
> >       Trying to apply Sedat's patch something changed in my system,
> > and that patch wasn't enough, so I had to first apply this one:
> >
> > commit 173b552663419f40bcd3cf9df4f68285cac72727
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Mon Apr 4 17:28:48 2022 -0300
> >
> >     tools build: Use $(shell ) instead of `` to get embedded libperl's =
ccopts
> >
> >     Just like its done for ldopts and for both in tools/perf/Makefile.c=
onfig.
> >
> >     Using `` to initialize PERL_EMBED_CCOPTS somehow precludes using:
> >
> >       $(filter-out SOMETHING_TO_FILTER,$(PERL_EMBED_CCOPTS))
> >
> >     And we need to do it to allow for building with versions of clang w=
here
> >     some gcc options selected by distros are not available.
> >
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Fangrui Song <maskray@google.com>
> >     Cc: Florian Fainelli <f.fainelli@gmail.com>
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: John Keeping <john@metanate.com>
> >     Cc: Leo Yan <leo.yan@linaro.org>
> >     Cc: Michael Petlan <mpetlan@redhat.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Nathan Chancellor <nathan@kernel.org>
> >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> >     Cc: Sedat Dilek <sedat.dilek@gmail.com>
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 1480910c792e2cb3..90774b60d31b2b8e 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -217,7 +217,7 @@ strip-libs =3D $(filter-out -l%,$(1))
> >  PERL_EMBED_LDOPTS =3D $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/=
null)
> >  PERL_EMBED_LDFLAGS =3D $(call strip-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > -PERL_EMBED_CCOPTS =3D `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS =3D $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/=
null)
> >  FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> >
> >  $(OUTPUT)test-libperl.bin:
> >
> > ----------------------------------------------------- 8< --------------=
-----
> >
> > After this I go on filtering out some of the gcc options that clang
> > doesn't grok:
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 90774b60d31b2b8e..bbc5e263e02385ed 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -215,9 +215,12 @@ grep-libs  =3D $(filter -l%,$(1))
> >  strip-libs =3D $(filter-out -l%,$(1))
> >
> >  PERL_EMBED_LDOPTS =3D $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/=
null)
> > +PERL_EMBED_LDOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LDFLAGS =3D $(call strip-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_CCOPTS =3D $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/=
null)
> > +PERL_EMBED_CCOPTS :=3D $(filter-out -ffat-lto-objects, $(PERL_EMBED_CC=
OPTS))
> > +PERL_EMBED_CCOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_CCOPTS))
> >  FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> >
> >  $(OUTPUT)test-libperl.bin:
> >
> > ----------------------------------------------------- 8< --------------=
-----
> >
> > And then get to the problems at the end of this message, which seem
> > similar to the problem described here:
> >
> > From  Nathan Chancellor <>
> > Subject       [PATCH] mwifiex: Remove unnecessary braces from HostCmd_S=
ET_SEQ_NO_BSS_INFO
> >
> > https://lkml.org/lkml/2020/9/1/135
> >
> > So perhaps in this case its better to disable that
> > -Werror,-Wcompound-token-split-by-macro when building with clang?
>
> Yes, I think that is probably the best solution. As far as I can tell,
> at least in this file and context, the warning appears harmless, as the
> "create a GNU C statement expression from two different macros" is very
> much intentional, based on the presence of PERL_USE_GCC_BRACE_GROUPS.
> The warning is fixed in upstream Perl by just avoiding creating GNU C
> statement expressions using STMT_START and STMT_END:
>
> https://github.com/Perl/perl5/issues/18780
> https://github.com/Perl/perl5/pull/18984
>
> If I am reading the source code correctly, an alternative to disabling
> the warning would be specifying -DPERL_GCC_BRACE_GROUPS_FORBIDDEN but it
> seems like that might end up impacting more than just this site,
> according to the issue discussion above.
>

Thanks for the pointer Nathan.

As said I hit the problem with Debian's perl v5.34.

Checking perl5 Git reveals:

"skip using gcc brace groups for STMT_START/END"
https://github.com/Perl/perl5/commit/7169efc77525df70484a824bff4ceebd1fafc7=
60

"Partially Revert "skip using gcc brace groups for STMT_START/END""
https://github.com/Perl/perl5/commit/e08ee3cb66f362c4901846a46014cfdfcd6032=
6c

Perl v5.34.x seems not to have these changes:
https://github.com/Perl/perl5/compare/v5.34.0...v5.34.1

Unsure if there exists a real fix for perl5.

- Sedat -

> Cheers,
> Nathan
>
> > ----------------------------------------------------- 8< --------------=
-----
> >
> > =E2=AC=A2[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-libperl.=
make.output
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                      ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: '{' token is here
> >     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                                 ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> >     v ^=3D (v>>23);                       \
> >                                         ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: ')' token is here
> >     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro '=
ZAPHOD32_SCRAMBLE32'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                      ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: note: '{' token is here
> >     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                                 ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> >     v ^=3D (v>>23);                       \
> >                                         ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: note: ')' token is here
> >     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro '=
ZAPHOD32_SCRAMBLE32'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                      ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: note: '{' token is here
> >     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                                 ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> >     v ^=3D (v>>23);                       \
> >                                         ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: note: ')' token is here
> >     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro '=
ZAPHOD32_SCRAMBLE32'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                     ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: note: '{' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro=
 'ZAPHOD32_MIX'
> >     v2 =3D ROTR32(v2, 7) ^ v0;   \
> >                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: note: ')' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro =
'ZAPHOD32_MIX'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                     ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: note: '{' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro=
 'ZAPHOD32_MIX'
> >     v2 =3D ROTR32(v2, 7) ^ v0;   \
> >                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: note: ')' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro =
'ZAPHOD32_MIX'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                     ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: note: '{' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro=
 'ZAPHOD32_MIX'
> >     v2 =3D ROTR32(v2, 7) ^ v0;   \
> >                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: note: ')' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro =
'ZAPHOD32_MIX'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                     ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: note: '{' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro=
 'ZAPHOD32_MIX'
> > #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                       =
       \
> >                                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro=
 'ZAPHOD32_MIX'
> >     v2 =3D ROTR32(v2, 7) ^ v0;   \
> >                                ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: note: ')' token is here
> >     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4"=
);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro =
'ZAPHOD32_MIX'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                      ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: note: '{' token is here
> >     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                                 ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> >     v ^=3D (v>>23);                       \
> >                                         ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: note: ')' token is here
> >     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro '=
ZAPHOD32_SCRAMBLE32'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                      ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: note: '{' token is here
> >     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                                 ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: error: '}' and ')' tokens =
terminating statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> >     v ^=3D (v>>23);                       \
> >                                         ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: note: ')' token is here
> >     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro '=
ZAPHOD32_SCRAMBLE32'
> > } STMT_END
> >   ^~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_EN=
D'
> > #   define STMT_END     )
> >                         ^
> > In file included from test-libperl.c:3:
> > In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> > In file included from /usr/lib64/perl5/CORE/hv.h:659:
> > In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> > In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:164:5: error: '(' and '{' tokens =
introducing statement expression appear in different macro expansion contex=
ts [-Werror,-Wcompound-token-split-by-macro]
> >     ZAPHOD32_SCRAMBLE32(state[2],0x9c5cc4e9);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                      ^~~~~~~~~~
> > /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_ST=
ART'
> > #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
> >                               ^
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:164:5: note: '{' token is here
> >     ZAPHOD32_SCRAMBLE32(state[2],0x9c5cc4e9);
> >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro =
'ZAPHOD32_SCRAMBLE32'
> > #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
> >                                                 ^
> > fatal error: too many errors emitted, stopping now [-ferror-limit=3D]
> > 20 errors generated.
> > =E2=AC=A2[acme@toolbox perf]$
