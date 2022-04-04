Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B574F1F34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiDDWma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbiDDWkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DAABFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5800A61253
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0309EC2BBE4;
        Mon,  4 Apr 2022 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649109206;
        bh=tdcZIeLkkc2cdYoh4y6wbTwTbo0xrYHCAQRon9I9GiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zr5/W+/g/RhcpUNq/uOXaLPoIlxlPeMyuFkzLyt1vuwtBGIDAe3mMMK9uCEkylN9R
         3+tXi433/98x/4udRMekGIYl3vgQqOmARyA2L94VY7xsfXq1HZE1h67Mgm+cs7DGlT
         XI6bWqszQeae/BjZhsd8HIiE1ubpdaI/WkPZAny4WwX+WzOsXr8ZLrput35++Fzhrl
         xWyA385O2LZZUMsbHPoF0EuJf4le/Zxr4SJ6XZGM/WJqE88qSepKjKtLZwN9NK3f3t
         K/sHCA6cJf8YUtdUuduncoR3Mh1yNwpT0066IzfVefmwmOPdVf9U+5AX9pimqsuFUG
         +F3AEs37iDJpQ==
Date:   Mon, 4 Apr 2022 14:53:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
References: <YktYX2OnLtyobRYD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YktYX2OnLtyobRYD@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Apr 04, 2022 at 05:43:11PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Trying to apply Sedat's patch something changed in my system,
> and that patch wasn't enough, so I had to first apply this one:
> 
> commit 173b552663419f40bcd3cf9df4f68285cac72727
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Apr 4 17:28:48 2022 -0300
> 
>     tools build: Use $(shell ) instead of `` to get embedded libperl's ccopts
>     
>     Just like its done for ldopts and for both in tools/perf/Makefile.config.
>     
>     Using `` to initialize PERL_EMBED_CCOPTS somehow precludes using:
>     
>       $(filter-out SOMETHING_TO_FILTER,$(PERL_EMBED_CCOPTS))
>     
>     And we need to do it to allow for building with versions of clang where
>     some gcc options selected by distros are not available.
>     
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Fangrui Song <maskray@google.com>
>     Cc: Florian Fainelli <f.fainelli@gmail.com>
>     Cc: Ian Rogers <irogers@google.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: John Keeping <john@metanate.com>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Michael Petlan <mpetlan@redhat.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Nathan Chancellor <nathan@kernel.org>
>     Cc: Nick Desaulniers <ndesaulniers@google.com>
>     Cc: Sedat Dilek <sedat.dilek@gmail.com>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 1480910c792e2cb3..90774b60d31b2b8e 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -217,7 +217,7 @@ strip-libs = $(filter-out -l%,$(1))
>  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
>  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> +PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
>  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
>  
>  $(OUTPUT)test-libperl.bin:
> 
> ----------------------------------------------------- 8< -------------------
> 
> After this I go on filtering out some of the gcc options that clang
> doesn't grok:
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 90774b60d31b2b8e..bbc5e263e02385ed 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -215,9 +215,12 @@ grep-libs  = $(filter -l%,$(1))
>  strip-libs = $(filter-out -l%,$(1))
>  
>  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> +PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> +PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
>  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
>  
>  $(OUTPUT)test-libperl.bin:
> 
> ----------------------------------------------------- 8< -------------------
> 
> And then get to the problems at the end of this message, which seem
> similar to the problem described here:
>     
> From	Nathan Chancellor <>
> Subject	[PATCH] mwifiex: Remove unnecessary braces from HostCmd_SET_SEQ_NO_BSS_INFO
> 
> https://lkml.org/lkml/2020/9/1/135
> 
> So perhaps in this case its better to disable that
> -Werror,-Wcompound-token-split-by-macro when building with clang?

Yes, I think that is probably the best solution. As far as I can tell,
at least in this file and context, the warning appears harmless, as the
"create a GNU C statement expression from two different macros" is very
much intentional, based on the presence of PERL_USE_GCC_BRACE_GROUPS.
The warning is fixed in upstream Perl by just avoiding creating GNU C
statement expressions using STMT_START and STMT_END:

https://github.com/Perl/perl5/issues/18780
https://github.com/Perl/perl5/pull/18984

If I am reading the source code correctly, an alternative to disabling
the warning would be specifying -DPERL_GCC_BRACE_GROUPS_FORBIDDEN but it
seems like that might end up impacting more than just this site,
according to the issue discussion above.

Cheers,
Nathan

> ----------------------------------------------------- 8< -------------------
> 
> ⬢[acme@toolbox perf]$ cat /tmp/build/perf/feature/test-libperl.make.output
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                      ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: '{' token is here
>     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                                 ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>     v ^= (v>>23);                       \
>                                         ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: ')' token is here
>     ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                      ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: note: '{' token is here
>     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                                 ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>     v ^= (v>>23);                       \
>                                         ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:151:5: note: ')' token is here
>     ZAPHOD32_SCRAMBLE32(state[1],0xaa6f908d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                      ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: note: '{' token is here
>     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                                 ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>     v ^= (v>>23);                       \
>                                         ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:152:5: note: ')' token is here
>     ZAPHOD32_SCRAMBLE32(state[2],0xcdf6b72d);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                     ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: note: '{' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro 'ZAPHOD32_MIX'
>     v2 = ROTR32(v2, 7) ^ v0;   \
>                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:156:5: note: ')' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 1/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro 'ZAPHOD32_MIX'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                     ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: note: '{' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro 'ZAPHOD32_MIX'
>     v2 = ROTR32(v2, 7) ^ v0;   \
>                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:157:5: note: ')' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 2/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro 'ZAPHOD32_MIX'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                     ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: note: '{' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro 'ZAPHOD32_MIX'
>     v2 = ROTR32(v2, 7) ^ v0;   \
>                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:158:5: note: ')' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 3/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro 'ZAPHOD32_MIX'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:37: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                     ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: note: '{' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:116:48: note: expanded from macro 'ZAPHOD32_MIX'
> #define ZAPHOD32_MIX(v0,v1,v2,text) STMT_START {                              \
>                                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:124:32: note: expanded from macro 'ZAPHOD32_MIX'
>     v2 = ROTR32(v2, 7) ^ v0;   \
>                                ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:159:5: note: ')' token is here
>     ZAPHOD32_MIX(state[0],state[1],state[2],"ZAPHOD32 SEED-STATE A 4/4");
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:125:3: note: expanded from macro 'ZAPHOD32_MIX'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                      ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: note: '{' token is here
>     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                                 ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>     v ^= (v>>23);                       \
>                                         ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:162:5: note: ')' token is here
>     ZAPHOD32_SCRAMBLE32(state[0],0xc95d22a9);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                      ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: note: '{' token is here
>     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                                 ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>     v ^= (v>>23);                       \
>                                         ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:163:5: note: ')' token is here
>     ZAPHOD32_SCRAMBLE32(state[1],0x8497242b);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> } STMT_END
>   ^~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
> #   define STMT_END     )
>                         ^
> In file included from test-libperl.c:3:
> In file included from /usr/lib64/perl5/CORE/perl.h:4085:
> In file included from /usr/lib64/perl5/CORE/hv.h:659:
> In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
> In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
> /usr/lib64/perl5/CORE/zaphod32_hash.h:164:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>     ZAPHOD32_SCRAMBLE32(state[2],0x9c5cc4e9);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                      ^~~~~~~~~~
> /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
> #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                               ^
> /usr/lib64/perl5/CORE/zaphod32_hash.h:164:5: note: '{' token is here
>     ZAPHOD32_SCRAMBLE32(state[2],0x9c5cc4e9);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
> #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                                 ^
> fatal error: too many errors emitted, stopping now [-ferror-limit=]
> 20 errors generated.
> ⬢[acme@toolbox perf]$
