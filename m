Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2074D6114
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348412AbiCKL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348424AbiCKL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:57:21 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B25B1C3D1F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:56:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b24so10583290edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6KOGVQhF6Egz+9fEXxCfdvhyFjVJMc2MkMjncsNH6FY=;
        b=ZjR0WX7iatYsrjjBNG3xudpmqpCa87TT88mnirCe2wJwBR7bTEZGS/DMl6ngBgG5md
         9ETRrW5uw21nHQqsaAIT8fOOpYE2rg1AIwGkKnGInLRtnfdjBJ+wCLWqxnDylxEPCCK9
         3Kd9r18mjoTW015rjw445mY5xCyZBOH2lCHnyO6OK7OtMfwgax/SSWJm+cdLuomPVycd
         aH63yCC9GJiYeBaQl1kIvPa0yHjz2Y+K0WTnV8o6joikseReV81eigOsceorEnc6nzep
         3212R3MMZ3YkQIoLmU0xqNt2zFmUGO7fkR+g7Ee5E7PfYlmbz6K6XMejV8Jm041QLCBZ
         aGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6KOGVQhF6Egz+9fEXxCfdvhyFjVJMc2MkMjncsNH6FY=;
        b=ZWAybB6UgsI0QxUD6ZG9GLRPbkOrFQcDK5LGdhSM+LY8/Gud6rFGJPZ1F7OqOtrvEb
         R3mNgD3ZeNmWSpRKCLMi+CQZ3/4wmsvhY/Utp7eTvSmRhNKd/T/EmPWr9VaNS/J2iirB
         1iwtHlzepStcS0gsaVAuGcLvAK0s6Yv3sNGG9K/z9+UunOBxKzNxHFJ5+lEYHx0loOtw
         sVM3XmX00Jn8gQoX25aW5khMMQc5dVwIoGNJ/rioAPV61Nf3z7eyhjBYWviHM+jgUAu3
         j0C01NBlFyeAZ9jhnv7W1OXZX/w4/Qj5dGeJIonL2vj1wWDyp05XU10xvzD7H0UQZul0
         kzxA==
X-Gm-Message-State: AOAM533Z9tjw3uT3wwag0mD3HBgPm75fDJqLp6mz/+IlMSxifH90DkQa
        UiEe0EBhzka7V/wiE4k/Krk=
X-Google-Smtp-Source: ABdhPJyhKwKHXdrgcx+VP6v6R/hLiE3rrgLkmwTvpB5t09YXQIcSL8iR1eb1Ba0dij/oJWd4Dd2Fdg==
X-Received: by 2002:aa7:c687:0:b0:415:eb43:8ff5 with SMTP id n7-20020aa7c687000000b00415eb438ff5mr8551105edq.74.1646999770590;
        Fri, 11 Mar 2022 03:56:10 -0800 (PST)
Received: from krava ([83.240.61.119])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm2860274ejt.108.2022.03.11.03.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 03:56:10 -0800 (PST)
Date:   Fri, 11 Mar 2022 12:56:07 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, John Keeping <john@metanate.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] tools: feature/test-libperl.c: Sync PERL_EMBED_CCOPTS
 with perf
Message-ID: <Yis41ykyJq1fHYSx@krava>
References: <20220310061909.20166-1-sedat.dilek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310061909.20166-1-sedat.dilek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:19:09AM +0100, Sedat Dilek wrote:
> When trying to build perf with a LLVM/Clang toolchain people see errors
> when testing for libperl feature.
> 
> Jiri reports:
> 
> > I'm getting some other lto related error:
> >
> >         $ cat test-libperl.make.output
> >         clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> >
> 
> The reason is PERL_EMBED_CCOPTS is defined in two places:
> 
> tools/build/feature/Makefile
> tools/perf/Makefile.config
> 
> As an result FLAGS_PERL_EMBED is set differently.
> 
> For building perf '-ffat-lto-objects' is filtered-out:
> 
> $ git grep ffat-lto-objects tools/perf/
> tools/perf/Makefile.config:  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> 
> Sync PERL_EMBED_CCOPTS in tools/build/feature/Makefile to fix this.
> 
> For a minimal fix for Linux v5.17 this here was preferred by Arnaldo.
> 
> Link: https://marc.info/?t=164646683300002&r=1&w=2
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Tested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  tools/build/feature/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 1480910c792e..869073cf8449 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -218,6 +218,7 @@ PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
>  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))

it looks like this is not enough, at least on fedora 35

I had to add changes below on top of your patch, it fixed the perl
feature detection and perf build itself, but I'm still getting error
with perf/python.so:

	$ CC=clang make JOBS=1 
	...
	  GEN     python/perf.so
	python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: file not recognized: file format not recognized
	clang-13: error: linker command failed with exit code 1 (use -v to see invocation)
	error: command 'clang' failed with exit status 1
	cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory

with:

	$ file python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o
	python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: LLVM IR bitcode

do you get clean compile with python lang enabled?

jirka


---
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 869073cf8449..86df0fe11ee5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -217,9 +217,9 @@ strip-libs = $(filter-out -l%,$(1))
 PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
 PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
-PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
+PERL_EMBED_CCOPTS := $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
 PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
-FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
+FLAGS_PERL_EMBED  := $(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
 
 $(OUTPUT)test-libperl.bin:
 	$(BUILD) $(FLAGS_PERL_EMBED)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 96ad944ca6a8..38b0b0e7a168 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -778,7 +778,7 @@ else
   PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
   PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
   PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
-  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
+  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS)) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
   PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
   FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 483f05004e68..cfbb03babf63 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -43,7 +43,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-Wno-ignored-optimization-argument', '-DPYTHON_PERF' ]
 if not cc_is_clang:
     cflags += ['-Wno-cast-function-type' ]
 
