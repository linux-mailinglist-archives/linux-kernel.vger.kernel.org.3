Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9209E577776
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGQR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 13:25:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F17101D4;
        Sun, 17 Jul 2022 10:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E85CFB80E12;
        Sun, 17 Jul 2022 17:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00156C3411E;
        Sun, 17 Jul 2022 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658078752;
        bh=19fwdJRIjUdiWpp2edPiJ3XXy2dBCH3K7O4CQjQKoAM=;
        h=From:To:Cc:Subject:Date:From;
        b=LLCNJcOrqjQLZtkpOuX+1sq8hUeRO/G5djFgNvp1nJAz7IcSLyXkeZd26cvGwZjoF
         CUIR7TdkOIr9YOjT3wiU8xk60SN678GaGaohgc0tdWgmpVftvnJLuxGLsgOU80plpD
         LMLu0X8ty/reAhObPdiDpjUlenMoUi3iXxXR2IZ7yD40KDsgeE94LvwH5Yky5D3GAI
         mnvXqNip7E3ZnIqRQ3wh0MebRIU3qJ+c93ijrKOkXb1SDJN+4nzljYLs8NDArVDPEP
         fZLF1ORx2VQQ4pJZw1T6K5TE5ixq5fssDrCVmV/iebIfjFvrDKcEShy0QJryF666xo
         K69nPXVhe7v4g==
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
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.19: 4th batch
Date:   Sun, 17 Jul 2022 14:25:44 -0300
Message-Id: <20220717172544.47204-1-acme@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message.

The following changes since commit 972a278fe60c361eb8f37619f562f092e8786d7c:

  Merge tag 'for-5.19-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2022-07-16 13:48:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.19-2022-07-17

for you to fetch changes up to 4b335e1e0d6f8fa91dac615a44b123c9f26e93d3:

  perf trace: Fix SIGSEGV when processing syscall args (2022-07-17 10:59:52 -0300)

----------------------------------------------------------------
perf tools fixes for v5.19: 4th batch

- Fix SIGSEGV when processing syscall args in perf.data files in 'perf trace'.

- Sync kvm, msr-index and cpufeatures headers with the kernel sources.

- Fix 'convert perf time to TSC' 'perf test':

   - No need to open events twice.
   - Fix finding correct event on hybrid systems.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf tests: Stop Convert perf time to TSC test opening events twice
      perf tests: Fix Convert perf time to TSC test for hybrid

Arnaldo Carvalho de Melo (3):
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources

Naveen N. Rao (1):
      perf trace: Fix SIGSEGV when processing syscall args

 tools/arch/x86/include/asm/cpufeatures.h       | 12 ++++++++++--
 tools/arch/x86/include/asm/disabled-features.h | 21 +++++++++++++++++++-
 tools/arch/x86/include/asm/msr-index.h         |  4 ++++
 tools/include/uapi/linux/kvm.h                 |  1 +
 tools/perf/builtin-trace.c                     |  2 ++
 tools/perf/tests/perf-time-to-tsc.c            | 27 ++++++++++----------------
 6 files changed, 47 insertions(+), 20 deletions(-)

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
Gwith a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

There is also a strange one with openmandriva:4.2 and openmandriva:cooker,
where on the feature build test it doesn't manage to find libpthread, because
the pthread functions (and the ones in librt, IIRC) are on the main libc, so a
test for that is needed to avoid adding '-lpthread and -lrt' in distros where
this is the case. It's in the TODO list.

Ubuntu 20.04 is failing on a corner case where perf links with libllvm and libclang,
which isn't the default perf build.

Cross building on 32-bit MIPS debian is failing due to redefinition of 'struct flock'
on a 'perf trace' beautifier, to be investigated.

Another regression alt:sisyphus, will be eventually on the non-default libllvm build.

debian experimental has a problem with a change in the prototype of a binutils function
used for disassembling BPF code, a fix is being discussed and will soon be merged.

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ export BUILD_TARBALL=http://192.168.86.14/perf/perf-5.19.0-rc6.tar.xz
  $ time dm
   1   117.37 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    80.45 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   3   109.33 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   4   124.50 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   5   130.02 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
   6   143.66 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
   7   127.60 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
   8   127.90 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
   9   118.38 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  10   118.29 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  11    64.01 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  12    93.60 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  13    92.30 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  14    92.07 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) (GCC) 
      CC      /tmp/build/perf/util/expr.o
      LD      /tmp/build/perf/util/intel-pt-decoder/perf-in.o
      LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
      LINK    /tmp/build/perf/libbpf/libbpf.a
    In file included from /usr/lib/llvm-13.0/include/clang/AST/ExprObjC.h:18,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/ConstructionContext.h:21,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/CFG.h:18,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/AnalysisDeclContext.h:22,
                     from /usr/lib/llvm-13.0/include/clang/Analysis/PathDiagnostic.h:17,
                     from /usr/lib/llvm-13.0/include/clang/StaticAnalyzer/Core/AnalyzerOptions.h:17,
                     from /usr/lib/llvm-13.0/include/clang/Frontend/CompilerInvocation.h:22,
                     from util/c++/clang.cpp:14:
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h: In instantiation of 'void clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::SkipToNextDecl() [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isInstanceProperty]':
    /usr/lib/llvm-13.0/include/clang/AST/DeclBase.h:2242:7:   required from 'clang::DeclContext::filtered_decl_iterator<SpecificDecl, Acceptable>::filtered_decl_iterator(clang::DeclContext::decl_iterator) [with SpecificDecl = clang::ObjCPropertyDecl; bool (SpecificDecl::* Acceptable)() const = &clang::ObjCPropertyDecl::isInstanceProperty]'
    /usr/lib/llvm-13.0/include/clang/AST/DeclObjC.h:984:43:   required from here
  15    66.30 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  16   102.42 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  17   121.58 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  18    15.63 archlinux:base                : FAIL gcc version 12.1.0 (GCC) 
    /usr/lib/perl5/5.36/core_perl/CORE/inline.h: In function ‘Perl_is_utf8_valid_partial_char_flags’:
    /usr/lib/perl5/5.36/core_perl/CORE/handy.h:125:23: error: cast from function call of type ‘STRLEN’ {aka ‘long unsigned int’} to non-matching type ‘_Bool’ [-Werror=bad-function-cast]
      125 | #define cBOOL(cbool) ((bool) (cbool))
          |                       ^
    /usr/lib/perl5/5.36/core_perl/CORE/inline.h:2363:12: note: in expansion of macro ‘cBOOL’
     2363 |     return cBOOL(is_utf8_char_helper_(s0, e, flags));
          |            ^~~~~
    In file included from /usr/lib/perl5/5.36/core_perl/CORE/perl.h:7242:
    /usr/lib/perl5/5.36/core_perl/CORE/inline.h: In function ‘Perl_cop_file_avn’:
    /usr/lib/perl5/5.36/core_perl/CORE/inline.h:3489:5: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     3489 |     const char *file = CopFILE(cop);
          |     ^~~~~
  19   109.16 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  20   109.54 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-13) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
  21    33.18 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220629 releases/gcc-12.1.0-188-g7811663964 , clang version 14.0.4
  22    81.06 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  23    87.50 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  24   102.12 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  25     6.38 debian:experimental           : FAIL gcc version 11.3.0 (Debian 11.3.0-4) 
    util/annotate.c: In function 'symbol__disassemble_bpf':
    util/annotate.c:1765:9: error: too few arguments to function 'init_disassemble_info'
     1765 |         init_disassemble_info(&info, s,
          |         ^~~~~~~~~~~~~~~~~~~~~
    In file included from util/annotate.c:1718:
    /usr/include/dis-asm.h:472:13: note: declared here
      472 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
          |             ^~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.19.0-rc6/tools/build/Makefile.build:139: util] Error 2
    util/annotate.c: In function 'symbol__disassemble_bpf':
    util/annotate.c:1765:9: error: too few arguments to function 'init_disassemble_info'
     1765 |         init_disassemble_info(&info, s,
          |         ^~~~~~~~~~~~~~~~~~~~~
    In file included from util/annotate.c:1718:
    /usr/include/dis-asm.h:472:13: note: declared here
      472 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
          |             ^~~~~~~~~~~~~~~~~~~~~
      CC      /tmp/build/perf/util/config.o
    make[4]: *** [/git/perf-5.19.0-rc6/tools/build/Makefile.build:97: /tmp/build/perf/util/annotate.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
  26    25.07 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0 
  27     7.29 debian:experimental-x-mips    : FAIL gcc version 11.2.0 (Debian 11.2.0-18) 
                     from trace/beauty/fcntl.c:10:
    /git/perf-5.19.0-rc6/tools/include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of 'struct flock'
      188 | struct flock {
          |        ^~~~~
    In file included from /git/perf-5.19.0-rc6/tools/include/uapi/linux/fcntl.h:5,
                     from trace/beauty/fcntl.c:10:
    /usr/mips-linux-gnu/include/asm/fcntl.h:64:8: note: originally defined here
       64 | struct flock {
          |        ^~~~~
    In file included from /usr/mips-linux-gnu/include/asm/fcntl.h:78,
                     from /git/perf-5.19.0-rc6/tools/include/uapi/linux/fcntl.h:5,
                     from trace/beauty/flock.c:5:
  28    24.16 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  29     9.88 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-18) 
                     from trace/beauty/fcntl.c:10:
    /git/perf-5.19.0-rc6/tools/include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of 'struct flock'
      188 | struct flock {
          |        ^~~~~
    In file included from /git/perf-5.19.0-rc6/tools/include/uapi/linux/fcntl.h:5,
                     from trace/beauty/fcntl.c:10:
    /usr/mipsel-linux-gnu/include/asm/fcntl.h:64:8: note: originally defined here
       64 | struct flock {
          |        ^~~~~
    make[3]: *** [/git/perf-5.19.0-rc6/tools/build/Makefile.build:139: trace/beauty] Error 2
      LD      /tmp/build/perf/arch/mips/util/perf-in.o
      CC      /tmp/build/perf/trace/beauty/fcntl.o
      LD      /tmp/build/perf/arch/mips/perf-in.o
      LD      /tmp/build/perf/arch/perf-in.o
    In file included from /usr/mipsel-linux-gnu/include/asm/fcntl.h:78,
                     from /git/perf-5.19.0-rc6/tools/include/uapi/linux/fcntl.h:5,
                     from trace/beauty/fcntl.c:10:
    /git/perf-5.19.0-rc6/tools/include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of 'struct flock'
      188 | struct flock {
          |        ^~~~~
    In file included from /git/perf-5.19.0-rc6/tools/include/uapi/linux/fcntl.h:5,
                     from trace/beauty/fcntl.c:10:
    /usr/mipsel-linux-gnu/include/asm/fcntl.h:64:8: note: originally defined here
       64 | struct flock {
          |        ^~~~~
    make[4]: *** [/git/perf-5.19.0-rc6/tools/build/Makefile.build:97: /tmp/build/perf/trace/beauty/fcntl.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      CC      /tmp/build/perf/bench/kallsyms-parse.o
      CC      /tmp/build/perf/bench/find-bit-bench.o
      CC      /tmp/build/perf/ui/hist.o
      CC      /tmp/build/perf/tests/attr.o
  30    27.50 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  31    82.19 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  32   103.80 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  33    22.15 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  34    86.84 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  35    97.80 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  36   100.61 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  37   110.73 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  38   117.86 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  39   122.06 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  40   113.64 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  41   110.15 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  42   108.77 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  43   116.06 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  44    20.55 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  45    18.54 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  46   114.58 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  47   128.42 fedora:36                     : Ok   gcc (GCC) 12.0.1 20220413 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
  48   129.81 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc37)
  49   101.12 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  50    84.36 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  51    44.11 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
    is not a prototype [-Werror,-Wstrict-prototypes]
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.19.0-rc6/tools/build/Makefile.build:139: util] Error 2
  52   110.85 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  53     6.88 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:66,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
  54     6.88 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:68:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       68 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:66,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
  55   119.34 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  56   127.76 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  57   124.77 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  58   135.11 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  59   137.21 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
  60   157.58 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20220316 [revision 6a1150d1524aeda3381b2171712e1a6611d441d6] , clang version 13.0.1
  61   118.67 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  62   111.45 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.1 (Red Hat 13.0.1-2.module+el8.6.0+987+d36ea6a1)
  63    87.38 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  64    20.04 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  65    19.85 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  66    20.05 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  67    20.35 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  68    95.10 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  69    21.35 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  70    21.66 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  71    17.63 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  72    21.45 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    22.86 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    23.17 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  75   111.05 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    19.75 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    20.55 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78    19.34 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    92.77 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 
      LD      /tmp/build/perf/perf-in.o
      LINK    /tmp/build/perf/perf
    /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
    (.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
    clang: error: linker command failed with exit code 1 (use -v to see invocation)
    make[2]: *** [Makefile.perf:676: /tmp/build/perf/perf] Error 1
    make[1]: *** [Makefile.perf:240: sub-make] Error 2
    make: *** [Makefile:70: all] Error 2
    make: Leaving directory '/git/perf-5.19.0-rc6/tools/perf'
    + exit 1
  80    23.65 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  81    90.08 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  82   104.62 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  83   106.63 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  84   131.72 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
  85   130.82 ubuntu:22.10                  : Ok   gcc (Ubuntu 11.3.0-3ubuntu1) 11.3.0 , Ubuntu clang version 14.0.4-4
  BUILD_TARBALL_HEAD=4b335e1e0d6f8fa91dac615a44b123c9f26e93d3
  86 6800.8

  real	115m14.250s
  user	1m16.058s
  sys	1m0.172s
  $ 



Two newcomers:

  $ dm almalinux:9 rockylinux:9
   2   141.29 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
   1   126.30 rockylinux:9                  : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
BUILD_TARBALL_HEAD=4b335e1e0d6f8fa91dac615a44b123c9f26e93d3
 3 267.584
  $ 

  [acme@quaco perf-urgent]$ uname -a
  Linux quaco 5.18.10-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jul 7 17:21:38 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  [acme@quaco perf-urgent]$ git log --oneline -1
  4b335e1e0d6f8fa9 (HEAD -> perf/urgent, five/perf/urgent) perf trace: Fix SIGSEGV when processing syscall args
  [acme@quaco perf-urgent]$ perf -v
  perf version 5.19.rc6.g4b335e1e0d6f
  [acme@quaco perf-urgent]$ sudo su -
  [sudo] password for acme: 
  [root@quaco ~]# perf -vv
  perf version 5.19.rc6.g4b335e1e0d6f
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
              debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ OFF ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
                 libpfm4: [ OFF ]  # HAVE_LIBPFM
  [root@quaco ~]# perf test
    1: vmlinux symtab matches kallsyms                                 : Ok
    2: Detect openat syscall event                                     : Ok
    3: Detect openat syscall event on all cpus                         : Ok
    4: Read samples using the mmap interface                           : Ok
    5: Test data source output                                         : Ok
    6: Parse event definition strings                                  :
    6.1: Test event parsing                                            : Ok
    6.2: Test parsing of "hybrid" CPU events                           : Skip (not hybrid)
    6.3: Parsing of all PMU events from sysfs                          : Ok
    6.4: Parsing of given PMU events from sysfs                        : Ok
    6.5: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
    6.6: Parsing of aliased events                                     : Ok
    6.7: Parsing of terms (event modifiers)                            : Ok
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
   71: Convert perf time to TSC                                        :
   71.1: TSC support                                                   : Ok
   71.2: Perf time to TSC                                              : Ok
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
   87: perf record tests                                               : Ok
   88: perf record offcpu profiling tests                              : Ok
   89: perf stat CSV output linter                                     : Ok
   90: perf stat csv summary test                                      : Ok
   91: perf stat metrics (shadow stat) test                            : Ok
   92: perf stat tests                                                 : Ok
   93: perf all metricgroups test                                      : Ok
   94: perf all metrics test                                           : FAILED!
   95: perf all PMU test                                               : Ok
   96: perf stat --bpf-counters test                                   : Ok
   97: Check Arm64 callgraphs are complete in fp mode                  : Skip
   98: Check Arm CoreSight trace data recording and synthesized samples: Skip
   99: Check Arm SPE trace data recording and synthesized samples      : Skip
  100: Check Arm SPE doesn't hang when there are forks                 : Skip
  101: Miscellaneous Intel PT testing                                  : Ok
  102: Check open filename arg using perf trace + vfs_getname          : Ok
  [root@quaco ~]#

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  ⬢[acme@toolbox perf-urgent]$ git log --oneline -1 ; time make -C tools/perf build-test
  4b335e1e0d6f8fa9 (HEAD -> perf/urgent) perf trace: Fix SIGSEGV when processing syscall args
  make: Entering directory '/var/home/acme/git/perf-urgent/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.FY2rlfXyzH
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.GnqRt9zssg
         make_with_coresight_O: make CORESIGHT=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
                   make_pure_O: make
                make_no_newt_O: make NO_NEWT=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                 make_perf_o_O: make perf.o
                 make_no_sdt_O: make NO_SDT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_tags_O: make tags
           make_with_libpfm4_O: make LIBPFM4=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
            make_install_bin_O: make install-bin
           make_no_libunwind_O: make NO_LIBUNWIND=1
                  make_debug_O: make DEBUG=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_util_map_o_O: make util/map.o
                   make_help_O: make help
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
              make_clean_all_O: make clean all
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
               make_no_slang_O: make NO_SLANG=1
                    make_doc_O: make doc
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
  OK
  make: Leaving directory '/var/home/acme/git/perf-urgent/tools/perf'
  
  real	4m46.642s
  user	61m17.339s
  sys	14m30.660s
  ⬢[acme@toolbox perf-urgent]$
