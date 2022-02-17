Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691C94BA47C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiBQPhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:37:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbiBQPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:37:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB192B1A98;
        Thu, 17 Feb 2022 07:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAF861ED1;
        Thu, 17 Feb 2022 15:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739B4C340E9;
        Thu, 17 Feb 2022 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645112204;
        bh=cYNS4LA2wQNqGhKQbrNUnu/uOoxbd8wCGdvPeiJWoh8=;
        h=From:To:Cc:Subject:Date:From;
        b=gJFBjIiJeuM4yvwd5xLpya15gOsWstCTVaJyE5ncKqw8LXKvW/ZsQXSN3Lkm+Sn+R
         rnDJNmNb2ljeOMDWkhKBI9rIJ8UXjihI7CiDV9WE6OMUs+L3C0MyVC2iBzaNinNKly
         kJLeOHuT5PcN+zkDX5VOO+/85QW6NPc4eTU5lQaioFIjWVizoPPXiBrwRB7TbxtSbb
         UvSUyx6bO4andG4pquwXacFQ3iLyahx7OdbgirSNJJZyG1lEQqk1rf6Ob9k0CTGM+f
         kkqIvg9V3wXFA1rtj+Nh54ANeyIyDbOv4oe65Ka4KIcxhhZXCjbArQUAinLPsswmmI
         nI34+mfwSZpPA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Kees Kook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.17: 2nd batch
Date:   Thu, 17 Feb 2022 12:36:27 -0300
Message-Id: <20220217153627.308659-1-acme@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Tests at the end of this message.

The following changes since commit d567f5db412ed52de0b3b3efca4a451263de6108:

  Merge tag 'regulator-fix-v5.17-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator (2022-02-14 09:51:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-02-17

for you to fetch changes up to 31ded1535e3182778a1d0e5c32711f55da3bc512:

  perf bpf: Defer freeing string after possible strlen() on it (2022-02-17 07:15:09 -0300)

----------------------------------------------------------------
perf tools fixes for v5.17: 2nd batch

- Fix corrupt inject files when only last branch option is enabled with ARM CoreSight ETM.

- Fix use-after-free for realloc(..., 0) in libsubcmd, found by gcc 12.

- Defer freeing string after possible strlen() on it in the BPF loader, found by gcc 12.

- Avoid early exit in 'perf trace' due SIGCHLD from non-workload processes.

- Fix arm64 perf_event_attr 'perf test's wrt --call-graph initialization.

- Fix libperf 32-bit build for 'perf test' wrt uint64_t printf.

- Fix perf_cpu_map__for_each_cpu macro in libperf, providing access to the CPU iterator.

- Sync linux/perf_event.h UAPI with the kernel sources.

- Update Jiri Olsa's email address in MAINTAINERS.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf bpf: Defer freeing string after possible strlen() on it

Changbin Du (1):
      perf trace: Avoid early exit due SIGCHLD from non-workload processes

German Gomez (1):
      perf test: Fix arm64 perf_event_attr tests wrt --call-graph initialization

James Clark (2):
      perf cs-etm: No-op refactor of synth opt usage
      perf cs-etm: Fix corrupt inject files when only last branch option is enabled

Jiri Olsa (2):
      MAINTAINERS: Update Jiri's email address
      libperf: Fix perf_cpu_map__for_each_cpu macro

Kees Cook (1):
      libsubcmd: Fix use-after-free for realloc(..., 0)

Rob Herring (1):
      libperf: Fix 32-bit build for tests uint64_t printf

 MAINTAINERS                                        |  2 +-
 tools/include/uapi/linux/perf_event.h              |  2 ++
 tools/lib/perf/include/internal/cpumap.h           |  6 +-----
 tools/lib/perf/include/perf/cpumap.h               |  5 +++++
 tools/lib/perf/libperf.map                         |  1 +
 tools/lib/perf/tests/test-cpumap.c                 | 11 +++++++++++
 tools/lib/perf/tests/test-evlist.c                 |  5 +++--
 tools/lib/subcmd/subcmd-util.h                     | 11 ++---------
 tools/perf/builtin-trace.c                         | 23 +++++++++++++++++-----
 tools/perf/tests/attr/README                       |  2 ++
 tools/perf/tests/attr/test-record-graph-default    |  2 ++
 .../tests/attr/test-record-graph-default-aarch64   |  9 +++++++++
 tools/perf/tests/attr/test-record-graph-fp         |  2 ++
 tools/perf/tests/attr/test-record-graph-fp-aarch64 |  9 +++++++++
 tools/perf/util/bpf-loader.c                       |  3 ++-
 tools/perf/util/cs-etm.c                           | 16 +++++++--------
 16 files changed, 77 insertions(+), 32 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-graph-default-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-graph-fp-aarch64

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

There is also a strange one with openmandriva:cooker, where on the feature build
test it doesn't manage to find libpthread, looks like a distro problem, will keep
it there to see if a refreshed container cures this soon. This has been the case
for quite a while, probably time to drop building for those distros?

Ubuntu 20.04 is failing on a corner case where perf links with libllvm and libclang,
which isn't the default perf build.

The fedora rawhide problem with -Werror=use-after-free ended up being a real bug,
fixed in this series.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.17.0-rc4.tar.xz
  $ time dm
     1   101.03 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
     2    57.50 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
     3    56.10 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
     4   106.87 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
     5    76.56 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
     6    65.14 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
     7    68.34 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     8    91.51 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     9   104.64 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
    10   111.57 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
    11   118.81 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
    12   106.25 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
    13   106.25 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
    14   107.95 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
    15    53.49 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
    16    81.77 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
    17    89.99 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
    18    79.27 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
    19    54.28 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
    20    89.10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    21    81.47 archlinux:base                : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
    22    84.47 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
    23   101.34 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
    24    51.13 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20220209 releases/gcc-11.2.0-744-gec01f11091 , clang version 13.0.0
    25    68.34 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
    26    63.51 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    27    89.29 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    28   102.46 debian:experimental           : Ok   gcc (Debian 11.2.0-14) 11.2.0 , Debian clang version 13.0.1-+rc3-1~exp1+b1
    29    24.57 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
    30    30.48 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    31    21.75 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    32    22.66 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
    33    22.76 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
    34    58.30 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
    35    69.32 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
    36    18.15 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
    37    70.72 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
    38    83.17 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
    39    83.46 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
    40    96.70 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    41   101.62 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    42   105.12 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    43    96.91 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    44    92.21 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    45    88.31 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    46    93.62 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    47    20.35 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
    48    18.45 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
    49    97.04 fedora:35                     : Ok   gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
    50   107.46 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220205 (Red Hat 12.0.1-0) , clang version 13.0.0 (Fedora 13.0.0-5.fc36)
    51    84.07 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
    52    71.83 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
    53    40.31 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
            yychar = yylex (&yylval, &yylloc, scanner);
                     ^
      #define yylex           parse_events_lex
                              ^
      1 error generated.
      make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: util] Error 2
    54    92.80 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
    55     6.19 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
      In file included from builtin-bench.c:22:
      bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
         66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
            |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      In file included from bench/bench.h:64,
                       from builtin-bench.c:22:
      /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
        394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
            |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
    56   104.49 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
    57   112.23 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    58   107.21 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    59   126.08 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    60   119.54 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    61   136.64 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.0
    62    99.74 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
    63   100.43 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
    64    74.05 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    65    19.54 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    66    24.96 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    67    19.55 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    68    19.55 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    69    19.75 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    70    19.85 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    71    79.15 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    72    20.85 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    73    21.27 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    74    17.24 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    75    20.76 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    76    22.06 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    77    22.16 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    78   105.24 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    79    18.94 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    80    19.85 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    81    19.05 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    82    76.04 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
  
    83    22.77 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
    84    87.68 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
    85    87.70 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
    86    91.62 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
    87   118.50 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-14ubuntu1) 11.2.0 , Ubuntu clang version 13.0.0-9
  BUILD_TARBALL_HEAD=31ded1535e3182778a1d0e5c32711f55da3bc512
  88 6041.23
  
  real	102m31.164s
  user	1m38.734s
  sys	0m57.576s
  $

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ git log --oneline -1 ; time make -C tools/perf build-test
  31ded1535e318277 (HEAD -> perf/urgent, seventh/perf/urgent, quaco/perf/urgent, acme/tmp.perf/urgent) perf bpf: Defer freeing string after possible strlen() on it
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.lTHLzwg2ek
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.KOoWSLWUCN
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_clean_all_O: make clean all
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                 make_perf_o_O: make perf.o
                make_no_newt_O: make NO_NEWT=1
                    make_doc_O: make doc
         make_with_coresight_O: make CORESIGHT=1
                   make_pure_O: make
            make_no_demangle_O: make NO_DEMANGLE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_with_libpfm4_O: make LIBPFM4=1
                make_install_O: make install
           make_no_libpython_O: make NO_LIBPYTHON=1
         make_install_prefix_O: make install prefix=/tmp/krava
            make_no_libaudit_O: make NO_LIBAUDIT=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
            make_install_bin_O: make install-bin
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_tags_O: make tags
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                  make_debug_O: make DEBUG=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_util_map_o_O: make util/map.o
              make_no_libelf_O: make NO_LIBELF=1
               make_no_slang_O: make NO_SLANG=1
                   make_help_O: make help
         make_with_clangllvm_O: make LIBCLANGLLVM=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                 make_no_sdt_O: make NO_SDT=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	4m35.244s
  user	56m50.715s
  sys	13m42.592s
  $

  $ uname -a
  Linux quaco 5.15.18-200.fc35.x86_64 #1 SMP Sat Jan 29 13:54:17 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  31ded1535e318277 (HEAD -> perf/urgent, five/perf/urgent, acme.korg/tmp.perf/urgent) perf bpf: Defer freeing string after possible strlen() on it
  $ perf -v
  perf version 5.17.rc4.g31ded1535e31
  # perf -vv
  perf version 5.17.rc4.g31ded1535e31
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
                 libpfm4: [ OFF ]  # HAVE_LIBPFM
  # perf test
    1: vmlinux symtab matches kallsyms                                 : Ok
    2: Detect openat syscall event                                     : Ok
    3: Detect openat syscall event on all cpus                         : Ok
    4: Read samples using the mmap interface                           : Ok
    5: Test data source output                                         : Ok
    6: Parse event definition strings                                  : Ok
    7: Simple expression parser                                        : Ok
    8: PERF_RECORD_* events & perf_sample fields                       : Ok
    9: Parse perf pmu format                                           : Ok
   10: PMU events                                                      :
   10.1: PMU event table sanity                                        : Ok
   10.2: PMU event map aliases                                         : Ok
   10.3: Parsing of PMU event table metrics                            : Ok
   10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
   11: DSO data read                                                   : Ok
   12: DSO data cache                                                  : Ok
   13: DSO data reopen                                                 : Ok
   14: Roundtrip evsel->name                                           : Ok
   15: Parse sched tracepoints fields                                  : Ok
   16: syscalls:sys_enter_openat event fields                          : Ok
   17: Setup struct perf_event_attr                                    : Ok
   18: Match and link multiple hists                                   : Ok
   19: 'import perf' in python                                         : Ok
   20: Breakpoint overflow signal handler                              : Ok
   21: Breakpoint overflow sampling                                    : Ok
   22: Breakpoint accounting                                           : Ok
   23: Watchpoint                                                      :
   23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
   23.2: Write Only Watchpoint                                         : Ok
   23.3: Read / Write Watchpoint                                       : Ok
   23.4: Modify Watchpoint                                             : Ok
   24: Number of exit events of a simple workload                      : Ok
   25: Software clock events period values                             : Ok
   26: Object code reading                                             : Ok
   27: Sample parsing                                                  : Ok
   28: Use a dummy software event to keep tracking                     : Ok
   29: Parse with no sample_id_all bit set                             : Ok
   30: Filter hist entries                                             : Ok
   31: Lookup mmap thread                                              : Ok
   32: Share thread maps                                               : Ok
   33: Sort output of hist entries                                     : Ok
   34: Cumulate child hist entries                                     : Ok
   35: Track with sched_switch                                         : Ok
   36: Filter fds with revents mask in a fdarray                       : Ok
   37: Add fd to a fdarray, making it autogrow                         : Ok
   38: kmod_path__parse                                                : Ok
   39: Thread map                                                      : Ok
   40: LLVM search and compile                                         :
   40.1: Basic BPF llvm compile                                        : Ok
   40.2: kbuild searching                                              : Ok
   40.3: Compile source for BPF prologue generation                    : Ok
   40.4: Compile source for BPF relocation                             : Ok
   41: Session topology                                                : Ok
   42: BPF filter                                                      :
   42.1: Basic BPF filtering                                           : Ok
   42.2: BPF pinning                                                   : Ok
   42.3: BPF prologue generation                                       : Ok
   43: Synthesize thread map                                           : Ok
   44: Remove thread map                                               : Ok
   45: Synthesize cpu map                                              : Ok
   46: Synthesize stat config                                          : Ok
   47: Synthesize stat                                                 : Ok
   48: Synthesize stat round                                           : Ok
   49: Synthesize attr update                                          : Ok
   50: Event times                                                     : Ok
   51: Read backward ring buffer                                       : Ok
   52: Print cpu map                                                   : Ok
   53: Merge cpu map                                                   : Ok
   54: Probe SDT events                                                : Ok
   55: is_printable_array                                              : Ok
   56: Print bitmap                                                    : Ok
   57: perf hooks                                                      : Ok
   58: builtin clang support                                           :
   58.1: builtin clang compile C source to IR                          : Skip (not compiled in)
   58.2: builtin clang compile C source to ELF object                  : Skip (not compiled in)
   59: unit_number__scnprintf                                          : Ok
   60: mem2node                                                        : Ok
   61: time utils                                                      : Ok
   62: Test jit_write_elf                                              : Ok
   63: Test libpfm4 support                                            :
   63.1: test of individual --pfm-events                               : Skip (not compiled in)
   63.2: test groups of --pfm-events                                   : Skip (not compiled in)
   64: Test api io                                                     : Ok
   65: maps__merge_in                                                  : Ok
   66: Demangle Java                                                   : Ok
   67: Demangle OCaml                                                  : Ok
   68: Parse and process metrics                                       : Ok
   69: PE file support                                                 : Ok
   70: Event expansion for cgroups                                     : Ok
   71: Convert perf time to TSC                                        : Ok
   72: dlfilter C API                                                  : Ok
   73: Sigtrap                                                         : Ok
   74: x86 rdpmc                                                       : Ok
   75: Test dwarf unwind                                               : Ok
   76: x86 instruction decoder - new instructions                      : Ok
   77: Intel PT packet decoder                                         : Ok
   78: x86 bp modify                                                   : Ok
   79: x86 Sample parsing                                              : Ok
   80: build id cache operations                                       : Ok
   81: daemon operations                                               : Ok
   82: perf pipe recording and injection test                          : Ok
   83: Add vfs_getname probe to get syscall args filenames             : Ok
   84: probe libc's inet_pton & backtrace it with ping                 : Ok
   85: Use vfs_getname probe to get syscall args filenames             : Ok
   86: Zstd perf.data compression/decompression                        : Ok
   87: perf stat csv summary test                                      : Ok
   88: perf stat metrics (shadow stat) test                            : Ok
   89: perf all metricgroups test                                      : Ok
   90: perf all metrics test                                           : Ok
   91: perf all PMU test                                               : Ok
   92: perf stat --bpf-counters test                                   : Ok
   93: Check Arm CoreSight trace data recording and synthesized samples: Skip
   94: Check Arm SPE trace data recording and synthesized samples      : Skip
   95: Check open filename arg using perf trace + vfs_getname          : Ok
  # 
