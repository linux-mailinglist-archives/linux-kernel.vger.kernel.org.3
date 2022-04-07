Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33D4F85AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbiDGRQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiDGRQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:16:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD8131961
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8FA4B8254E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F31C385A4;
        Thu,  7 Apr 2022 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649351673;
        bh=VtyFx1mE/jimFv03f6Qz18sNrWKaGRHtMcWgdHvNHrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilcES6Mxll3vhWBEQtYAqnQ7CFAGgtXF8Nj1+KT+hKWXB77102gFcxaJ0pYZuxg6H
         9XjwNNxT97n12yN+bybdlbZJMlXbqxnWk2d0jrMaEY/OoLd7cR0yaebdx8zNywPlzp
         i3qHkM3+bdmMGFMtOPWmpceBambyZsrqdA+D7FNYWb+MxupbNUJjZejIZj+wEES7FC
         yxQPVofhcyBb1+C4oOksJrSYrmO5kFZvnDt5mresNurC+y+GSz69/e4AnV4vJ5/EOd
         uzpCuW/u4zW/kiDwJkaO8m2pXzM8YKL3nBshACr5cdHojMN7hQpy4cbQ80DZomKCB0
         mCcPMbV0CQTyA==
Date:   Thu, 7 Apr 2022 10:14:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
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
Subject: Re: Build perf with clang, failure with libperf
Message-ID: <Yk8b9xF9OrKj4pH7@dev-arch.thelio-3990X>
References: <YktYX2OnLtyobRYD@kernel.org>
 <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <CA+icZUVKgLLJvNF6ZU1e7Hjr_FsJO7x0gsGL6Jje1nv2ukhueA@mail.gmail.com>
 <Yk79WQQjvMyCddiO@dev-arch.thelio-3990X>
 <CA+icZUXwF+qs0KxSeD8AF7ufrT6PodQa0iVi1w=qvdT0WWhkrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXwF+qs0KxSeD8AF7ufrT6PodQa0iVi1w=qvdT0WWhkrA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 06:25:29PM +0200, Sedat Dilek wrote:
> On Thu, Apr 7, 2022 at 5:03 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Apr 07, 2022 at 12:27:14PM +0200, Sedat Dilek wrote:
> > > On Mon, Apr 4, 2022 at 11:53 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > Hi Arnaldo,
> > > >
> > > > On Mon, Apr 04, 2022 at 05:43:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Hi,
> > > > >
> > > > >       Trying to apply Sedat's patch something changed in my system,
> > > > > and that patch wasn't enough, so I had to first apply this one:
> > > > >
> > > > > commit 173b552663419f40bcd3cf9df4f68285cac72727
> > > > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date:   Mon Apr 4 17:28:48 2022 -0300
> > > > >
> > > > >     tools build: Use $(shell ) instead of `` to get embedded libperl's ccopts
> > > > >
> > > > >     Just like its done for ldopts and for both in tools/perf/Makefile.config.
> > > > >
> > > > >     Using `` to initialize PERL_EMBED_CCOPTS somehow precludes using:
> > > > >
> > > > >       $(filter-out SOMETHING_TO_FILTER,$(PERL_EMBED_CCOPTS))
> > > > >
> > > > >     And we need to do it to allow for building with versions of clang where
> > > > >     some gcc options selected by distros are not available.
> > > > >
> > > > >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > >     Cc: Fangrui Song <maskray@google.com>
> > > > >     Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > > >     Cc: Ian Rogers <irogers@google.com>
> > > > >     Cc: Jiri Olsa <jolsa@kernel.org>
> > > > >     Cc: John Keeping <john@metanate.com>
> > > > >     Cc: Leo Yan <leo.yan@linaro.org>
> > > > >     Cc: Michael Petlan <mpetlan@redhat.com>
> > > > >     Cc: Namhyung Kim <namhyung@kernel.org>
> > > > >     Cc: Nathan Chancellor <nathan@kernel.org>
> > > > >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > >     Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > > > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > >
> > > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > > > index 1480910c792e2cb3..90774b60d31b2b8e 100644
> > > > > --- a/tools/build/feature/Makefile
> > > > > +++ b/tools/build/feature/Makefile
> > > > > @@ -217,7 +217,7 @@ strip-libs = $(filter-out -l%,$(1))
> > > > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > > > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > > > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > > > > +PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > > > >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > > > >
> > > > >  $(OUTPUT)test-libperl.bin:
> > > > >
> > > > > ----------------------------------------------------- 8< -------------------
> > > > >
> > > > > After this I go on filtering out some of the gcc options that clang
> > > > > doesn't grok:
> > > > >
> > > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > > > index 90774b60d31b2b8e..bbc5e263e02385ed 100644
> > > > > --- a/tools/build/feature/Makefile
> > > > > +++ b/tools/build/feature/Makefile
> > > > > @@ -215,9 +215,12 @@ grep-libs  = $(filter -l%,$(1))
> > > > >  strip-libs = $(filter-out -l%,$(1))
> > > > >
> > > > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > > > > +PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > > > > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > > > > +PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> > > > >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > > > >
> > > > >  $(OUTPUT)test-libperl.bin:
> > > > >
> > > > > ----------------------------------------------------- 8< -------------------
> > > > >
> > > > > And then get to the problems at the end of this message, which seem
> > > > > similar to the problem described here:
> > > > >
> > > > > From  Nathan Chancellor <>
> > > > > Subject       [PATCH] mwifiex: Remove unnecessary braces from HostCmd_SET_SEQ_NO_BSS_INFO
> > > > >
> > > > > https://lkml.org/lkml/2020/9/1/135
> > > > >
> > > > > So perhaps in this case its better to disable that
> > > > > -Werror,-Wcompound-token-split-by-macro when building with clang?
> > > >
> > > > Yes, I think that is probably the best solution. As far as I can tell,
> > > > at least in this file and context, the warning appears harmless, as the
> > > > "create a GNU C statement expression from two different macros" is very
> > > > much intentional, based on the presence of PERL_USE_GCC_BRACE_GROUPS.
> > > > The warning is fixed in upstream Perl by just avoiding creating GNU C
> > > > statement expressions using STMT_START and STMT_END:
> > > >
> > > > https://github.com/Perl/perl5/issues/18780
> > > > https://github.com/Perl/perl5/pull/18984
> > > >
> > > > If I am reading the source code correctly, an alternative to disabling
> > > > the warning would be specifying -DPERL_GCC_BRACE_GROUPS_FORBIDDEN but it
> > > > seems like that might end up impacting more than just this site,
> > > > according to the issue discussion above.
> > > >
> > >
> > > Thanks for the pointer Nathan.
> > >
> > > As said I hit the problem with Debian's perl v5.34.
> > >
> > > Checking perl5 Git reveals:
> > >
> > > "skip using gcc brace groups for STMT_START/END"
> > > https://github.com/Perl/perl5/commit/7169efc77525df70484a824bff4ceebd1fafc760
> >
> > GitHub says this is in 5.35.2, so it would make sense that 5.34 still
> > shows the issue.
> >
> > > "Partially Revert "skip using gcc brace groups for STMT_START/END""
> > > https://github.com/Perl/perl5/commit/e08ee3cb66f362c4901846a46014cfdfcd60326c
> > >
> > > Perl v5.34.x seems not to have these changes:
> > > https://github.com/Perl/perl5/compare/v5.34.0...v5.34.1
> > >
> > > Unsure if there exists a real fix for perl5.
> >
> > Perhaps those two changes could be cherry-picked into Debian's 5.34. I
> > have no idea if that is possible though.
> >
> 
> What perl5 version has Arch Linux?

$ pacman -Q perl
perl 5.34.1-1

It appears that 5.35 is the development version, which I suppose means
we won't see this fix widely available for some time:

https://www.nntp.perl.org/group/perl.perl5.porters/2022/03/msg263388.html

> Do you see the issue and need -Wno-compound-token-split-by-macro?

I don't build perf but given the above information, I suspect I would
need that flag as well.

Cheers,
Nathan
