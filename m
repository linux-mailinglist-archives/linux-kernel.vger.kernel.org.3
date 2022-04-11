Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A194FBB76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbiDKMAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiDKMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:00:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4582343AF5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA500B815A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1389C385A5;
        Mon, 11 Apr 2022 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649678299;
        bh=dytsJ9CUhEwq6r5ig686VgkfvaffKLNo3MLZUAczYg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9FI7oRtH5JHuh4WJ5NGc2aQrhaKfP/8SaxP2snuv6145PEUiog0johbP0BGQaRzy
         UoR7LlzdKBlbFbtouTjrTujcm84PMYuszRFnZeRxeYUs/yn4/jMGsYuqLIOb6Cnw+Z
         SAHb6vFxBd5+MRyv0uWYdFrPOOBxQo3c6WhQBgc0=
Date:   Mon, 11 Apr 2022 13:58:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
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
Message-ID: <YlQX2FNfAXv/fqU3@kroah.com>
References: <YktYX2OnLtyobRYD@kernel.org>
 <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <YkxWcYzph5pC1EK8@kernel.org>
 <CA+icZUVMtrqRA-a3k8N0fVcszm=Sn2Jb9nMfF8mXqvSTu2HUhw@mail.gmail.com>
 <Ykyfzn6Z8Wkf1Ccl@kernel.org>
 <Yky4TjOLiVvOcLYN@kernel.org>
 <YlBLh6Y0WWEVuN1F@kernel.org>
 <CA+icZUUnj-CjG3AsypSdJ3szx93mx49uD7MaBCeSbHqa50QYuw@mail.gmail.com>
 <CA+icZUUix_Hv+nx5MCQo7YeDftWO=gURxCQnK0Me-ED-te4ODA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUix_Hv+nx5MCQo7YeDftWO=gURxCQnK0Me-ED-te4ODA@mail.gmail.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 08:38:37AM +0200, Sedat Dilek wrote:
> On Fri, Apr 8, 2022 at 5:30 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Apr 8, 2022 at 4:49 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Tue, Apr 05, 2022 at 06:44:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Apr 05, 2022 at 05:00:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Tue, Apr 05, 2022 at 05:46:00PM +0200, Sedat Dilek escreveu:
> > > > > > So, we should include scripts/Makefile.clang or enhance
> > > > > > tools/scripts/Makefile.include where LLVM/Clang stuff is defined (and
> > > > > > can be overridden).
> > > > >
> > > > > > Jiri pointed out he needed two options (when I recall correctly):
> > > > > >
> > > > > > [1] -Wno-unused-command-line-argument
> > > >
> > > > I didn't see this one so far, but this one, and for the python case,
> > > > appears on clang 13 on:
> > > >
> > > >   22    45.02 archlinux:base                : FAIL clang version 13.0.1
> > > >
> > > >   CC      /tmp/build/perf/arch/x86/util/pmu.o
> > > > clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> > > > error: command '/usr/sbin/clang' failed with exit code 1
> > > >   MKDIR   /tmp/build/perf/ui/stdio/
> > > > cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
> > > >   CC      /tmp/build/perf/arch/x86/util/kvm-stat.o
> > > > make[2]: *** [Makefile.perf:639: /tmp/build/perf/python/perf.so] Error 1
> > > > make[2]: *** Waiting for unfinished jobs....
> > >
> > > So this one is more involved, see the two patches below, the first fixes
> > > the clang command option probing mechanism used and the second filters
> > > out -ffat-lto-objects.
> > >
> > > Its all in my tmp.perf/urgent branch at
> > > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git.
> > >
> > > The full test suite is still running, but so far the failures are
> > > unrelated to the problems in this thread:
> > >
> > > [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.18.0-rc1.tar.xz
> > > [perfbuilder@five ~]$ time dm
> > >    1   115.87 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
> > >    2    74.26 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
> > >    3    67.82 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
> > >    4    71.32 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
> > >    5    77.05 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
> > >    6    76.76 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
> > >    7    79.36 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
> > >    8   111.26 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
> > >    9   118.37 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
> > >   10   124.39 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
> > >   11   135.45 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
> > >   12   129.24 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
> > >   13   124.49 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
> > >   14   115.27 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
> > >   15    62.59 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
> > >   16    90.90 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
> > >   17    89.19 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
> > >   18    90.50 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
> > >   19    64.00 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
> > >   20   100.13 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
> > >   21   116.67 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
> > >   22   105.61 archlinux:base                : Ok   gcc (GCC) 11.2.0 , clang version 13.0.1
> > >   23    98.90 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
> > >   24   112.45 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
> > >   25    51.53 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20220330 releases/gcc-11.2.0-949-g511e8b6122 , clang version 13.0.0
> > >   26    79.15 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
> > >   27    84.48 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
> > >   28    98.81 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
> > >   29   115.79 debian:experimental           : Ok   gcc (Debian 11.2.0-19) 11.2.0 , Debian clang version 13.0.1-3+b2
> > >   30    24.66 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
> > >   31    20.25 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
> > >   32    22.06 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
> > >   33    22.76 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0
> > >   34    22.55 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
> > >   35    68.41 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
> > >   36    80.65 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
> > >   37    18.13 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
> > >   38    81.54 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
> > >   39    95.09 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
> > >   40    97.18 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
> > >   41   109.33 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
> > >   42   115.85 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
> > >   43   118.65 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
> > >   44   111.13 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
> > >   45   105.95 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
> > >   46   104.95 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
> > >   47   112.06 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
> > >   48    20.44 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
> > >   49    18.44 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
> > >   50   113.69 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
> > >   51    30.08 fedora:36                     : FAIL gcc version 12.0.1 20220308 (Red Hat 12.0.1-0) (GCC)
> > >       + make PYTHON=python3 ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf
> > >     make: Entering directory '/git/perf-5.18.0-rc1/tools/perf'
> > >       BUILD:   Doing 'make -j32' parallel build
> > >     Makefile.config:728: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
> > >     Makefile.config:1011: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > >     Makefile.config:1118: *** Error: No libtraceevent devel library found, please install libtraceevent-devel.  Stop.
> > >     make[1]: *** [Makefile.perf:240: sub-make] Error 2
> > >
> > >   52   126.52 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220308 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc37)
> > >   53    96.02 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
> > >   54    82.86 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
> > >   55    43.11 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
> > >           yychar = yylex (&yylval, &yylloc, scanner);
> > >                    ^
> > >     #define yylex           parse_events_lex
> > >                             ^
> > >     1 error generated.
> > >     make[3]: *** [/git/perf-5.18.0-rc1/tools/build/Makefile.build:139: util] Error 2
> > >   56   107.45 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
> > >   57     6.58 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC)
> > >     In file included from builtin-bench.c:22:
> > >     bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
> > >        66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
> > >           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     In file included from bench/bench.h:64,
> > >                      from builtin-bench.c:22:
> > >     /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
> > >       394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
> > >           |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
> > >     ld: warning: -r and --icf may not be used together, disabling --icf
> > >     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
> > >     ld: warning: -r and --icf may not be used together, disabling --icf
> > >     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
> > >     ld: warning: -r and --icf may not be used together, disabling --icf
> > >   58     6.48 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC)
> > >     In file included from builtin-bench.c:22:
> > >     bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
> > >        66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
> > >           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     In file included from bench/bench.h:64,
> > >                      from builtin-bench.c:22:
> > >     /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
> > >       394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
> > >           |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
> > >     ld: warning: -r and --icf may not be used together, disabling --icf
> > >     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
> > >     ld: warning: -r and --icf may not be used together, disabling --icf
> > >     ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
> > >     ld: warning: -r and --icf may not be used together, disabling --icf
> > >   59   118.04 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
> > >   60   127.98 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
> > >   61   122.86 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1
> > >   62   133.70 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
> > >   63   133.30 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
> > >   64   158.92 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.0
> > >   65   114.77 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
> > >   66: rockylinux:8
> > >
> > > - Arnaldo
> > >
> > > From 73fb827d72906bd2d78c6ca091b0c74f90183a95 Mon Sep 17 00:00:00 2001
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Fri, 8 Apr 2022 10:08:07 -0300
> > > Subject: [PATCH 1/2] perf python: Fix probing for some clang command line
> > >  options
> > >
> > > The clang compiler complains about some options even without a source
> > > file being available, while others require one, so use the simple
> > > tools/build/feature/test-hello.c file.
> > >
> > > Then check for the "is not supported" string in its output, in addition
> > > to the "unknown argument" already being looked for.
> > >
> > > This was noticed when building with clang-13 where -ffat-lto-objects
> > > isn't supported and since we were looking just for "unknown argument"
> > > and not providing a source code to clang, was mistakenly assumed as
> > > being available and not being filtered to set of command line options
> > > provided to clang, leading to a build failure.
> > >
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Fangrui Song <maskray@google.com>
> > > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: John Keeping <john@metanate.com>
> > > Cc: Leo Yan <leo.yan@linaro.org>
> > > Cc: Michael Petlan <mpetlan@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > > Link: http://lore.kernel.org/lkml/
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/setup.py | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > index 483f05004e682081..6156bb87ee3e34cf 100644
> > > --- a/tools/perf/util/setup.py
> > > +++ b/tools/perf/util/setup.py
> > > @@ -1,12 +1,14 @@
> > > -from os import getenv
> > > +from os import getenv, path
> > >  from subprocess import Popen, PIPE
> > >  from re import sub
> > >
> > >  cc = getenv("CC")
> > >  cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stderr.readline()
> > > +src_feature_tests  = getenv('srctree') + '/tools/build/feature'
> > >
> > >  def clang_has_option(option):
> > > -    return [o for o in Popen([cc, option], stderr=PIPE).stderr.readlines() if b"unknown argument" in o] == [ ]
> > > +    cc_output = Popen([cc, option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> > > +    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> > >
> > >  if cc_is_clang:
> > >      from distutils.sysconfig import get_config_vars
> > > --
> > > 2.35.1
> > >
> > > From e807abf709ee26af99588bd13e725fb45011b167 Mon Sep 17 00:00:00 2001
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date: Thu, 7 Apr 2022 11:04:20 -0300
> > > Subject: [PATCH 2/2] perf build: Don't use -ffat-lto-objects in the python
> > >  feature test when building with clang-13
> > >
> > > Using -ffat-lto-objects in the python feature test when building with
> > > clang-13 results in:
> > >
> > >   clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> > >   error: command '/usr/sbin/clang' failed with exit code 1
> > >   cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
> > >   make[2]: *** [Makefile.perf:639: /tmp/build/perf/python/perf.so] Error 1
> > >
> > > Noticed when building on a docker.io/library/archlinux:base container.
> > >
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Fangrui Song <maskray@google.com>
> > > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: John Keeping <john@metanate.com>
> > > Cc: Leo Yan <leo.yan@linaro.org>
> > > Cc: Michael Petlan <mpetlan@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/Makefile.config | 3 +++
> > >  tools/perf/util/setup.py   | 2 ++
> > >  2 files changed, 5 insertions(+)
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 5b5ba475a5c00c0f..f3bf9297bcc03c5e 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -272,6 +272,9 @@ ifdef PYTHON_CONFIG
> > >    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
> > >    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
> > >    FLAGS_PYTHON_EMBED := $(PYTHON_EMBED_CCOPTS) $(PYTHON_EMBED_LDOPTS)
> > > +  ifeq ($(CC_NO_CLANG), 0)
> > > +    PYTHON_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PYTHON_EMBED_CCOPTS))
> > > +  endif
> > >  endif
> > >
> > >  FEATURE_CHECK_CFLAGS-libpython := $(PYTHON_EMBED_CCOPTS)
> > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > index 6156bb87ee3e34cf..c255a2c90cd672b1 100644
> > > --- a/tools/perf/util/setup.py
> > > +++ b/tools/perf/util/setup.py
> > > @@ -25,6 +25,8 @@ if cc_is_clang:
> > >              vars[var] = sub("-fstack-protector-strong", "", vars[var])
> > >          if not clang_has_option("-fno-semantic-interposition"):
> > >              vars[var] = sub("-fno-semantic-interposition", "", vars[var])
> > > +        if not clang_has_option("-ffat-lto-objects"):
> > > +            vars[var] = sub("-ffat-lto-objects", "", vars[var])
> > >
> > >  from distutils.core import setup, Extension
> > >
> > > --
> > > 2.35.1
> > >
> >
> > Thanks for the followup patches.
> >
> > I have tested with the last 4 commits from [1].
> >
> > [ INSTRUCTIONS ]
> >
> > 1103  2022-04-08 17:14:40 LLVM_MVER="14"
> > 1104  2022-04-08 17:14:40 LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
> > 1105  2022-04-08 17:14:40 ##LLVM_TOOLCHAIN_PATH="/opt/llvm-toolchain/bin"
> > 1106  2022-04-08 17:14:40 if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
> > export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"; fi
> > 1107  2022-04-08 17:14:40 echo $PATH
> > 1108  2022-04-08 17:14:40 PYTHON_VER="3.10"
> > 1109  2022-04-08 17:14:40 MAKE="make"
> > 1110  2022-04-08 17:14:40 MAKE_OPTS="V=1 -j4 HOSTCC=clang
> > HOSTLD=ld.lld HOSTAR=llvm-ar CC=clang LD=ld.lld AR=llvm-ar
> > STRIP=llvm-strip"
> > 1111  2022-04-08 17:14:40 echo $PYTHON_VER $MAKE $MAKE_OPTS
> >
> > 3.10 make V=1 -j4 HOSTCC=clang HOSTLD=ld.lld HOSTAR=llvm-ar CC=clang
> > LD=ld.lld AR=llvm-ar STRIP=llvm-strip
> >
> > 1112  2022-04-08 17:14:50 LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
> > clean 2>&1 | tee ../make-log_perf-clean.txt
> > 1113  2022-04-08 17:15:43 LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
> > PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
> > ../make-log_perf-python${PYTHON_VER}-install_bin_debian-llvm14_perf-urgent-acme-20220408.txt
> >
> > Please feel free to add my...
> >
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v14 (x86-64)
> >
> > My perf build-log is attached.
> >
> > - sed@ -
> >
> > P.S.: I requested to bump perl to version 5.34.1 (see [2]) plus diff from [3].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/urgent
> > [2] https://bugs.debian.org/1009170
> > [3] https://bugs.debian.org/1009149
> 
> [ To: GregKH and Sasha L. ]
> 
> I have seen the linux-stable team is taking perf patches for queue-5.17.
> 
> I have reported build problems with perf + clang + libperl (perl v5.34).
> My original report was against Linux v5.17-rc6 (see [1]).
> 
> So, I would like to see at least the 4 commits I have tested with to
> be in Linux v5.17.y.
> They are now in upstream means Linux v5.18-rc2.
> 
> Here are the upstream commit-ids:
> 
> 3a8a0475861a perf build: Don't use -ffat-lto-objects in the python
> feature test when building with clang-13
> dd6e1fe91cdd perf python: Fix probing for some clang command line options
> 41caff459a5b tools build: Filter out options and warnings not supported by clang
> 541f695cbcb6 tools build: Use $(shell ) instead of `` to get embedded
> libperl's ccopts
> 
> @Arnaldo: If you agree, the linux-stable team should include them in
> the next Linux v5.17.y series.
> ( I can NOT speak for other linux-stable releases. )

All now queued up, thanks.

greg k-h
