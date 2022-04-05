Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28EF4F5244
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443889AbiDFClH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455464AbiDEXPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A86122227
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C734F61716
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ACCC385A0;
        Tue,  5 Apr 2022 21:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649195091;
        bh=p55gKByVf36Fu6d3sq+5dkZHroHj7CU9RZTvi/gZVdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQp/vbUFgZEzrFA73Sj7fGCYz30EtikshefT6AJ1A1C4u+ovlvCB4R9Gf35pg/kp4
         g7k0c27L/1OPxiusmkBp0W1+0aFDvNGhsi/tDgEdLLEu8MaA+0QrF3bmh8JLp4pcHQ
         dzwOK89Ba3N54++S2qbvtE94/SDKwGJi27lEfU85//2wRePB2Vl8CbxAWm9yQ2ZYyn
         wYrLAQpC31uJ3Cn5fGFGmI214hAvFA5fnFvYCWnh2IUHl0vxMGY3uHHJWM6oTO2M9H
         3Ir+jtYJTvcYq7mrdj9KONhccwkvHFhcwPwrW1GJAR67rqaSOrDTf9QN/6zRv2iXlh
         XnZIWfBtl45EA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A23040407; Tue,  5 Apr 2022 18:44:46 -0300 (-03)
Date:   Tue, 5 Apr 2022 18:44:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <Yky4TjOLiVvOcLYN@kernel.org>
References: <YktYX2OnLtyobRYD@kernel.org>
 <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <YkxWcYzph5pC1EK8@kernel.org>
 <CA+icZUVMtrqRA-a3k8N0fVcszm=Sn2Jb9nMfF8mXqvSTu2HUhw@mail.gmail.com>
 <Ykyfzn6Z8Wkf1Ccl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykyfzn6Z8Wkf1Ccl@kernel.org>
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

Em Tue, Apr 05, 2022 at 05:00:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 05, 2022 at 05:46:00PM +0200, Sedat Dilek escreveu:
> > So, we should include scripts/Makefile.clang or enhance
> > tools/scripts/Makefile.include where LLVM/Clang stuff is defined (and
> > can be overridden).
> 
> > Jiri pointed out he needed two options (when I recall correctly):
> > 
> > [1] -Wno-unused-command-line-argument

I didn't see this one so far, but this one, and for the python case,
appears on clang 13 on:

  22    45.02 archlinux:base                : FAIL clang version 13.0.1

  CC      /tmp/build/perf/arch/x86/util/pmu.o
clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
error: command '/usr/sbin/clang' failed with exit code 1
  MKDIR   /tmp/build/perf/ui/stdio/
cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
  CC      /tmp/build/perf/arch/x86/util/kvm-stat.o
make[2]: *** [Makefile.perf:639: /tmp/build/perf/python/perf.so] Error 1
make[2]: *** Waiting for unfinished jobs....

 
> > Example:
> > tools/testing/selftests/bpf/Makefile-# Silence some warnings when
> > compiled with clang
> > tools/testing/selftests/bpf/Makefile-ifneq ($(LLVM),)
> > tools/testing/selftests/bpf/Makefile:CFLAGS += -Wno-unused-command-line-argument
> > tools/testing/selftests/bpf/Makefile-endif
> > 
> > ^^ Here you see it is checked for LLVM.
> > Again, put that stuff in one single place - tools/scripts/Makefile.include
> > 
> > [2] -Wno-ignored-optimization-argument
> > 
> > Both [1] and [2] were not needed in my case.
> > 
> > [1] is always good to have - not only for perf.
> > 
> > AFAICS, you wanted to consolidate PERL_EMBED_XXX and FLAGS_PERL_EMBED
> > at a single place.
> > 1. tools/build/feature/Makefile
> > 2. tools/perf/Makefile.config
> 
> Yeah, at some point I'll do it, probably in the 5.19 window.
>  
> > Can not say where we all need perl check/requirement - maybe put that
> > stuff to the place where we define/check for toolchain/compiler (see
> > above)?
> > 
> > Again, all these issues happen because of -Werror is strictly set.
> > 
> > I put my patches around that area (see 2nd patch) - without checking
> > if the LLVM/Clang toolchain is used or not.
> > Both patches are attached.
> 
> I saw those patches, even added a:
> 
> Based-on-a-patch-by: Sedat Dilek <sedat.dilek@gmail.com>
>  
> > $ git show -1 for-5.17/tools-feature_detect_libperl-clang-dileks-v3
> > commit 72ba634c9b39547197900d8b64ff36134af3ed08
> > (for-5.17/tools-feature_detect_libperl-clang-dileks-v3)
> > Author: Sedat Dilek <sedat.dilek@gmail.com>
> > Date:   Sun Mar 13 12:37:06 2022 +0100
> > 
> >    tools: feature-detect: libperl: Sync PERL_EMBED_CCOPTS with perf
> > 
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1480910c792e..fa6be127f483 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -217,7 +217,8 @@ strip-libs = $(filter-out -l%,$(1))
> > PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS = $(perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > 
> > $(OUTPUT)test-libperl.bin:
> > 
> > $ git show -1 for-5.17/perf-libperl_support-clang-dileks
> > commit 316a1917ec05772ab0f99dad534fabdd74547865
> > (for-5.17/perf-libperl_support-clang-dileks)
> > Author: Sedat Dilek <sedat.dilek@gmail.com>
> > Date:   Sun Mar 6 11:29:50 2022 +0100
> > 
> >    perf: Fix libperl support with clang and perl v5.34
> > 
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1480910c792e..ef9b37c5c652 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -81,7 +81,7 @@ PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> > 
> > all: $(FILES)
> > 
> > -__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst
> > %.bin,%.c,$(@F)) $(LDFLAGS)
> > +__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror
> > -Wno-compound-token-split-by-macro -o $@ $(patsubst %.bin,%.c,$(@F))
> > $(LDFLAGS)
> >   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
> > 
> > __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst
> > %.bin,%.cpp,$(@F)) $(LDFLAGS)
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 96ad944ca6a8..acc987daf56e 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -213,7 +213,7 @@ endif
> > 
> > # Treat warnings as errors unless directed not to
> > ifneq ($(WERROR),0)
> > -  CORE_CFLAGS += -Werror
> > +  CORE_CFLAGS += -Werror -Wno-compound-token-split-by-macro
> 
> Ok, you added it right after -Werror, which is equivalent, in the
> feature test case, to what I did.
> 
> I'll take that into account when working on having all this in a single
> place, next merge window.
> 
> >   CXXFLAGS += -Werror
> >   HOSTCFLAGS += -Werror
> > endif
> > 
> > With both patches I am able to build perf-5.17 with LLVM/Clang v14 and
> > -std=gnu11 and perl v5.34.
> > 
> > It's good when Jiri tests on his system.
> 
> Right, I'll test on these containers, with many gcc and clang versions:
> 
>    1 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
>    2 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
>    3 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
>    4 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
>    5 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    6 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    7 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    8 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>    9 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>   10 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>   11 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
>   12 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
>   13 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
>   14 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
>   15 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
>   16 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
>   17 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
>   18 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
>   19 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
>   20 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
>   21 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
>   22 archlinux:base                : FAIL clang version 13.0.1
>   23 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
>   24 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
>   25 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20220322 releases/gcc-11.2.0-884-gf45603f39b , clang version 13.0.0
>   26 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
>   27 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
>   28 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
>   29 debian:experimental           : Ok   gcc (Debian 11.2.0-19) 11.2.0 , Debian clang version 13.0.1-3+b2
>   30 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
>   31 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
>   32 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
>   33 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0 
>   34 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
>   35 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
>   36 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
>   37 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
>   38 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
>   39 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
>   40 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
>   41 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
>   42 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
>   43 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
>   44 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
>   45 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>   46 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
>   47 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
>   48 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
>   49 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
>   50 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
>   51 fedora:36                     : FAIL gcc version 12.0.1 20220308 (Red Hat 12.0.1-0) (GCC) 
>   52 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220308 (Red Hat 12.0.1-0) , clang version 13.0.1 (Fedora 13.0.1-1.fc37)
>   53 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
>   54 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
>   55 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
>   56 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
>   57 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
>   58 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
>   59 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
>   60 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
>   61 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
>   62 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
>   63 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
>   64 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.0
>   65 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
>   66 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
>   67 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
>   68 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
>   69 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
>   70 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
>   71 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
>   72 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
>   73 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
>   74 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>   75 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
>   76 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
>   77 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   78 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   79 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   80 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   81 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   82 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   83 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   84 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>   85 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
>   86 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
>   87 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
>   88 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
>   89 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
>   90 ubuntu:22.04                  : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-18ubuntu1) 
>  
> > I can test your patch with my next kernel-build, but can not promise.
> > Do you have it somewhere in a Git repo/branch or a (LORE) link for
> > easy application?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/urgent
> 
> > Did not check if b4 tool is able to extract it as patch out of your
> > original email.
> > 
> > - Sedat -
> 
> > From 72ba634c9b39547197900d8b64ff36134af3ed08 Mon Sep 17 00:00:00 2001
> > From: Sedat Dilek <sedat.dilek@gmail.com>
> > Date: Sun, 13 Mar 2022 12:37:06 +0100
> > Subject: [PATCH] tools: feature-detect: libperl: Sync PERL_EMBED_CCOPTS with
> >  perf
> > 
> > ---
> >  tools/build/feature/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1480910c792e..fa6be127f483 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -217,7 +217,8 @@ strip-libs = $(filter-out -l%,$(1))
> >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS = $(perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> >  
> >  $(OUTPUT)test-libperl.bin:
> > -- 
> > 2.35.1
> > 
> 
> > From 316a1917ec05772ab0f99dad534fabdd74547865 Mon Sep 17 00:00:00 2001
> > From: Sedat Dilek <sedat.dilek@gmail.com>
> > Date: Sun, 6 Mar 2022 11:29:50 +0100
> > Subject: [PATCH] perf: Fix libperl support with clang and perl v5.34
> > 
> > ---
> >  tools/build/feature/Makefile | 2 +-
> >  tools/perf/Makefile.config   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1480910c792e..ef9b37c5c652 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -81,7 +81,7 @@ PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> >  
> >  all: $(FILES)
> >  
> > -__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
> > +__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -Wno-compound-token-split-by-macro -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
> >    BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
> >  
> >  __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 96ad944ca6a8..acc987daf56e 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -213,7 +213,7 @@ endif
> >  
> >  # Treat warnings as errors unless directed not to
> >  ifneq ($(WERROR),0)
> > -  CORE_CFLAGS += -Werror
> > +  CORE_CFLAGS += -Werror -Wno-compound-token-split-by-macro
> >    CXXFLAGS += -Werror
> >    HOSTCFLAGS += -Werror
> >  endif
> > -- 
> > 2.35.1
> > 
> 
> 
> - Arnaldo

-- 

- Arnaldo
