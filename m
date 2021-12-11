Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08E47147C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhLKPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:37:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54182 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLKPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:36:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A578CE0956;
        Sat, 11 Dec 2021 15:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64835C004DD;
        Sat, 11 Dec 2021 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639237015;
        bh=eBqrW6vBH3W7E73+Gpy7VQKHGInV4s0ZWKaGtEah8FM=;
        h=From:To:Cc:Subject:Date:From;
        b=AMEZJJQVeMYoDkSc+30TF9nEkJLZPWgfMo7p1xJ/r9hmz0TVqvmqMb9dTcZHA0cKU
         WHf6vdBllaImPgNOrlIcSEXut5ISaK2shNUQ50cdxU/LNtg6TQclAH3Mhc2XrRxVgL
         ic5ROanc0x0tEAD6I156ZgjSJoagO5ZzxXD7HLJVheXPl93/5MR2uZpeUhaFXHjfMz
         gKfW1yGn+CjPyvr/Ehwy0l52ImhL353Qt94iCbq1vIe2J42lwkyaxybNPfT8vyfOlD
         /poWcgbjLNxx8IAnS+pboWH37e+a1W8QQqSPxERsZOTqs+LKWR/Kw2cF85E/M/OkIK
         Uo61GEHj0ChcQ==
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.16: 3rd batch
Date:   Sat, 11 Dec 2021 12:36:49 -0300
Message-Id: <20211211153649.468266-1-acme@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end.

The following changes since commit 6f513529296fd4f696afb4354c46508abe646541:

  Merge tag 'for-5.16-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2021-12-10 17:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-11

for you to fetch changes up to 9937e8daab29d9e20de6b7bc56c76db7a4eeda69:

  perf python: Fix NULL vs IS_ERR_OR_NULL() checking (2021-12-11 08:23:54 -0300)

----------------------------------------------------------------
perf tools fixes for v5.16: 3rd batch

- Prevent out-of-bounds access to per sample registers.

- Fix NULL vs IS_ERR_OR_NULL() checking on the python binding.

- Intel PT fixes, half of those are one-liners:

  - Fix some PGE (packet generation enable/control flow packets) usage.
  - Fix sync state when a PSB (synchronization) packet is found.
  - Fix intel_pt_fup_event() assumptions about setting state type.
  - Fix state setting when receiving overflow (OVF) packet.
  - Fix next 'err' value, walking trace.
  - Fix missing 'instruction' events with 'q' option.
  - Fix error timestamp setting on the decoder error path.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (7):
      perf intel-pt: Fix some PGE (packet generation enable/control flow packets) usage
      perf intel-pt: Fix sync state when a PSB (synchronization) packet is found
      perf intel-pt: Fix intel_pt_fup_event() assumptions about setting state type
      perf intel-pt: Fix state setting when receiving overflow (OVF) packet
      perf intel-pt: Fix next 'err' value, walking trace
      perf intel-pt: Fix missing 'instruction' events with 'q' option
      perf intel-pt: Fix error timestamp setting on the decoder error path

German Gomez (1):
      perf tools: Prevent out-of-bounds access to registers

Miaoqian Lin (1):
      perf python: Fix NULL vs IS_ERR_OR_NULL() checking

 tools/perf/util/event.h                            |  5 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 85 ++++++++++++++--------
 tools/perf/util/intel-pt.c                         |  1 +
 tools/perf/util/perf_regs.c                        |  3 +
 tools/perf/util/python.c                           |  2 +-
 5 files changed, 64 insertions(+), 32 deletions(-)

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

  $ export BUILD_TARBALL=http://192.168.86.14/perf/perf-5.16.0-rc4.tar.xz
  $ time dm
   1    92.80 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    54.48 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    53.28 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    56.38 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    62.60 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    62.62 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    64.61 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8    88.10 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   101.53 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10   107.75 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   113.47 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12   100.83 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   101.04 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14   102.54 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
  15    50.16 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  16    74.04 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  17    72.34 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
  18    50.94 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  19    82.67 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  20    79.36 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  21    93.40 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
  22    48.40 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20211202 releases/gcc-11.2.0-549-g2d5be1fca0 , clang version 11.1.0
  23    63.60 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  24    59.60 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  25    81.05 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  26    83.66 debian:experimental           : Ok   gcc (Debian 11.2.0-12) 11.2.0 , Debian clang version 13.0.0-9+b1
  27    22.96 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  28    18.74 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  29    20.64 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  30    21.34 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  31    21.44 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  32    54.26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  33    64.81 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  34    17.13 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  35    65.80 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  36    77.72 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  37    79.24 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  38    90.18 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  39    94.19 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  40    98.70 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  41    91.67 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  42    84.79 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  43    82.58 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  44    86.29 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  45    19.03 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  46    17.33 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  47    77.55 fedora:35                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  48    84.36 fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7) , clang version 13.0.0 (Fedora 13.0.0-5.fc36)
  49    77.25 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  50    66.80 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  51    37.19 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.16.0-rc4/tools/build/Makefile.build:139: util] Error 2
  52     6.07 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
  53    97.09 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  54   105.52 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55    99.90 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  56   113.04 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  57   110.84 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20210816 [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9] , clang version 13.0.0
  58    91.70 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  59    93.00 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  60    69.12 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  61    18.23 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  62    18.53 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  63    17.93 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  64    18.32 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  65    18.44 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  66    18.23 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  67    73.52 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  68    19.54 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  69    19.84 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  70    16.22 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  71    19.34 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  72    20.75 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    20.84 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    94.30 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  75    17.63 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    19.03 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    17.93 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78    70.62 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 

  79    21.45 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  80    70.33 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  81    81.37 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  82    83.46 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
BUILD_TARBALL_HEAD=9937e8daab29d9e20de6b7bc56c76db7a4eeda69
83 5035.39

real	85m43.007s
user	1m0.361s
sys	0m43.368s
[perfbuilder@five ~]$


  $ uname -a
  Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  $ grep -m1 "model name" /proc/cpuinfo 
  model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  $ git log --oneline -1
  9937e8daab29d9e2 (HEAD -> perf/urgent, seventh/perf/urgent, five/perf/urgent, acme.korg/tmp.perf/urgent) perf python: Fix NULL vs IS_ERR_OR_NULL() checking
  $ perf -v
  perf version 5.16.rc4.g9937e8daab29
  $ sudo su -
  # perf -vv
  perf version 5.16.rc4.g9937e8daab29
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
  73: x86 rdpmc                                                       : Ok
  74: Test dwarf unwind                                               : Ok
  75: x86 instruction decoder - new instructions                      : Ok
  76: Intel PT packet decoder                                         : Ok
  77: x86 bp modify                                                   : Ok
  78: x86 Sample parsing                                              : Ok
  79: build id cache operations                                       : Ok
  80: daemon operations                                               : Ok
  81: perf pipe recording and injection test                          : Ok
  82: Add vfs_getname probe to get syscall args filenames             : Ok
  83: probe libc's inet_pton & backtrace it with ping                 : Ok
  84: Use vfs_getname probe to get syscall args filenames             : Ok
  85: Zstd perf.data compression/decompression                        : Ok
  86: perf stat csv summary test                                      : Ok
  87: perf stat metrics (shadow stat) test                            : Ok
  88: perf all metricgroups test                                      : FAILED!
  89: perf all metrics test                                           : Ok
  90: perf all PMU test                                               : Ok
  91: perf stat --bpf-counters test                                   : Ok
  92: Check Arm CoreSight trace data recording and synthesized samples: Skip
  93: Check Arm SPE trace data recording and synthesized samples      : Skip
  94: Check open filename arg using perf trace + vfs_getname          : Ok
  # 

  $ git log --oneline -1 ; grep "model name" -m1 /proc/cpuinfo ; time make -C tools/perf build-test
  9937e8daab29 (HEAD -> perf/urgent, five/perf/urgent) perf python: Fix NULL vs IS_ERR_OR_NULL() checking
  model name	: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j4  DESTDIR=/tmp/tmp.pfuxvwobbu
                make_with_gtk2: make GTK2=1 -j4  DESTDIR=/tmp/tmp.PCN67MuZHc
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_clean_all_O: make clean all
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
        make_with_babeltrace_O: make LIBBABELTRACE=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
                    make_doc_O: make doc
                   make_pure_O: make
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_debug_O: make DEBUG=1
                make_install_O: make install
               make_no_slang_O: make NO_SLANG=1
                make_no_gtk2_O: make NO_GTK2=1
         make_with_coresight_O: make CORESIGHT=1
              make_no_libbpf_O: make NO_LIBBPF=1
              make_no_libelf_O: make NO_LIBELF=1
                 make_no_sdt_O: make NO_SDT=1
                 make_cscope_O: make cscope
            make_install_bin_O: make install-bin
                make_no_newt_O: make NO_NEWT=1
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_with_libpfm4_O: make LIBPFM4=1
                 make_perf_o_O: make perf.o
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_tags_O: make tags
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  
  real	20m51.611s
  user	52m21.920s
  sys	12m43.521s
  $
