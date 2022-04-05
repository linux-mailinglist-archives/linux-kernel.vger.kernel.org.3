Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E064F4A57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455506AbiDEWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451578AbiDEPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:53:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4231C8A84
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0BBEB81D6B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09424C385A1;
        Tue,  5 Apr 2022 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649170037;
        bh=3QjZsra/sKKyF/B/dmQRx/G6cza4sXiGZMxpImAEmgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAEapBaB0keXxkMXxgRrRmBoQmXLT/6X9lJ8OkQTimi+NHBi8inmsQjMtIegqf9z+
         pY/x21mz8i2GSvqSRovtsHNTv7qpbuUsan9XNpcBxkRfvGwWM21rhhXOCxdZDn9HnK
         f783QlOPxd/lDvo+BOtEs+JY3yQtKTR6Qu1UJbDrgWP4ygGbEaAWlDFHyg7017Apkn
         VlPpWfDPZA6Nu6dwajFcyFv/MdMA097Ahk9e1dEj9Q5QwgguJU67LqSovSkc6O/Lgq
         bQHkRw8K8EUY+Lgr1L6iGQN7tlxfBF5GM3dJj02v6j/Rsp/xe92gkjf2o1CKUA2oR+
         /Q4TjtF3QZUtA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9AD0B40407; Tue,  5 Apr 2022 11:47:13 -0300 (-03)
Date:   Tue, 5 Apr 2022 11:47:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
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
Message-ID: <YkxWcYzph5pC1EK8@kernel.org>
References: <YktYX2OnLtyobRYD@kernel.org>
 <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 04, 2022 at 02:53:24PM -0700, Nathan Chancellor escreveu:
> On Mon, Apr 04, 2022 at 05:43:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > 	Trying to apply Sedat's patch something changed in my system,
> > and that patch wasn't enough, so I had to first apply this one:

<SNIP>

> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1480910c792e2cb3..90774b60d31b2b8e 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -217,7 +217,7 @@ strip-libs = $(filter-out -l%,$(1))
> >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> >  
> >  $(OUTPUT)test-libperl.bin:
> > 
> > ----------------------------------------------------- 8< -------------------

<SNIP>

> > So perhaps in this case its better to disable that
> > -Werror,-Wcompound-token-split-by-macro when building with clang?
 
> Yes, I think that is probably the best solution. As far as I can tell,
> at least in this file and context, the warning appears harmless, as the
> "create a GNU C statement expression from two different macros" is very
> much intentional, based on the presence of PERL_USE_GCC_BRACE_GROUPS.
> The warning is fixed in upstream Perl by just avoiding creating GNU C
> statement expressions using STMT_START and STMT_END:
 
> https://github.com/Perl/perl5/issues/18780
> https://github.com/Perl/perl5/pull/18984
> 
> If I am reading the source code correctly, an alternative to disabling
> the warning would be specifying -DPERL_GCC_BRACE_GROUPS_FORBIDDEN but it
> seems like that might end up impacting more than just this site,
> according to the issue discussion above.

Ok, so I ended up with the patch below.

On the 5.19 window I'll make the tools/perf/Makefile.config filters only
apply when clang is used and unify these settings so that we have it
setup just in one place, shared by the main build and the feature build.

- Arnaldo

commit 5b5da660aa70e2a01748f602e9bbcd18b162a176
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Apr 5 10:33:21 2022 -0300

    tools build: Filter out options and warnings not supported by clang
    
    These make the feature check fail when using clang, so remove them just
    like is done in tools/perf/Makefile.config to build perf itself.
    
    Adding -Wno-compound-token-split-by-macro to tools/perf/Makefile.config
    when building with clang is also necessary to avoid these warnings
    turned into errors (-Werror):
    
        CC      /tmp/build/perf/util/scripting-engines/trace-event-perl.o
      In file included from util/scripting-engines/trace-event-perl.c:35:
      In file included from /usr/lib64/perl5/CORE/perl.h:4085:
      In file included from /usr/lib64/perl5/CORE/hv.h:659:
      In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
      In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
      /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
          ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
      #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
                                           ^~~~~~~~~~
      /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
      #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
                                    ^
      /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: '{' token is here
          ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
      #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
                                                      ^
      /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
          ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
          v ^= (v>>23);                       \
                                              ^
      /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: ')' token is here
          ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
      } STMT_END
        ^~~~~~~~
      /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
      #   define STMT_END     )
                              ^
    
    Based-on-a-patch-by: Sedat Dilek <sedat.dilek@gmail.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Fangrui Song <maskray@google.com>
    Cc: Florian Fainelli <f.fainelli@gmail.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: John Keeping <john@metanate.com>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Michael Petlan <mpetlan@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Nathan Chancellor <nathan@kernel.org>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Link: http://lore.kernel.org/lkml/YktYX2OnLtyobRYD@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 90774b60d31b2b8e..de66e1cc073481c5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -220,6 +220,13 @@ PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
 FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
+ifeq ($(CC_NO_CLANG), 0)
+  PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
+  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
+  PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
+  FLAGS_PERL_EMBED += -Wno-compound-token-split-by-macro
+endif
+
 $(OUTPUT)test-libperl.bin:
 	$(BUILD) $(FLAGS_PERL_EMBED)
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 96ad944ca6a885cd..5b5ba475a5c00c0f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -790,6 +790,9 @@ else
     LDFLAGS += $(PERL_EMBED_LDFLAGS)
     EXTLIBS += $(PERL_EMBED_LIBADD)
     CFLAGS += -DHAVE_LIBPERL_SUPPORT
+    ifeq ($(CC_NO_CLANG), 0)
+      CFLAGS += -Wno-compound-token-split-by-macro
+    endif
     $(call detected,CONFIG_LIBPERL)
   endif
 endif
