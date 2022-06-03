Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3B53D39F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348385AbiFCWb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiFCWbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:31:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F164183;
        Fri,  3 Jun 2022 15:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0CE3B82482;
        Fri,  3 Jun 2022 22:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF7CC385B8;
        Fri,  3 Jun 2022 22:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654295505;
        bh=K/B+k2uCxWpGF96ctvGiGScF/lT1ApijbtpRSLNInFA=;
        h=From:To:Cc:Subject:Date:From;
        b=SJaOws2rsiXADDFjm5YyKx1gbQ/aLz6rEnI3vlKZrypVm6R2pu39dpevgNBlMJoaq
         lHYUncVfpmNngvMp+lD6qubH9k9BYjNpIF3/BG55e+tIjtDrUruIMd/5GN/upcMhsm
         BNAypPUxTTIq0EuPG/JDx0hmZ6s9JojkBOfdqoXpJZei/0w7qYaHz9XefJUF2Vn3j+
         BOXspsPloAy35ijDzWPs/W8LEY6/a5a/5RSoIWXoiiRqkFV1RUDb5uy679dBrkmOqt
         5vD5M/kQbyjewyqScT2SMoB+hHO6RdfeCNyj1nx1ZnrhWb5FjHkArHeFbqLO8TIpQZ
         790rDvF8FYsKQ==
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
        Fangrui Song <maskray@google.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Kevin Nomura <nomurak@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Sebastian Ullrich <sebasti@nullri.ch>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.19: 3rd batch
Date:   Sat,  4 Jun 2022 00:31:36 +0200
Message-Id: <20220603223136.554028-1-acme@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reduced set of tests at the end of this message.

The following changes since commit 9be4cbd09da820a20d400670a45fc1571f6a13b8:

  driver core: Set default deferred_probe_timeout back to 0. (2022-06-03 11:58:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.19-2022-06-04

for you to fetch changes up to 1bcca2b1bd67f3c0e5c3a88ed16c6389f01a5b31:

  perf vendor events intel: Update metrics for Alderlake (2022-06-03 21:45:32 +0200)

----------------------------------------------------------------
perf tools changes for v5.19: 3rd batch

- Synthesize task events for pre-existing threads when using 'perf lock --threads',
  as we need to show task names.

- Fix unwinding with ld.lld (>= version 10.0) linked objects, where
  .eh_frame_hdr and .text are in different PT_LOAD program headers, which makes
  perf record --call-graph dwarf fail with such obkects.

- Check if 'perf record' hangs in the ARM SPE (Statistical Profiling Extensions)
  'perf test' entry when recording a workload with forks.

- Trace physical address for Arm SPE events, needed for 'perf c2c' to locate
  the memory node for samples.

- Fix sorting in percent_rmt_hitm_cmp() in 'perf c2c'.

- Further support for Intel hybrid systems in the evlist and 'perf record' code.

- Update IBM s/390 vendor event JSON tables.

- Add metrics (JSON) for Intel Sapphirerapids.

- Update metrics for Intel Alderlake.

- Correct typo of sysf 'event_source' directory in the documentation.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Fangrui Song (1):
      perf unwind: Fix segbase for ld.lld linked objects

German Gomez (1):
      perf test arm-spe: Check if perf-record hangs when recording workload with forks

Ian Rogers (1):
      perf docs: Correct typo of event_sources

Leo Yan (2):
      perf mem: Trace physical address for Arm SPE events
      perf c2c: Fix sorting in percent_rmt_hitm_cmp()

Namhyung Kim (1):
      perf lock: Change to synthesize task events

Thomas Richter (7):
      perf list: Add IBM z16 event description for s390
      perf list: Update event description for IBM z10 to latest level
      perf list: Update event description for IBM z13 to latest level
      perf list: Update event description for IBM z14 to latest level
      perf list: Update event description for IBM z15 to latest level
      perf list: Update event description for IBM z196/z114 to latest level
      perf list: Update event description for IBM zEC12/zBC12 to latest level

Zhengjun Xing (4):
      perf evlist: Extend arch_evsel__must_be_in_group to support hybrid systems
      perf record: Support sample-read topdown metric group for hybrid platforms
      perf vendor events intel: Add metrics for Sapphirerapids
      perf vendor events intel: Update metrics for Alderlake

 tools/perf/Documentation/perf-record.txt           |   2 +-
 tools/perf/Documentation/perf-stat.txt             |   2 +-
 tools/perf/Documentation/perf-top.txt              |   2 +-
 tools/perf/arch/arm64/util/mem-events.c            |   6 +-
 tools/perf/arch/x86/util/evsel.c                   |   5 +-
 tools/perf/arch/x86/util/evsel.h                   |   7 +
 tools/perf/arch/x86/util/topdown.c                 |  21 +-
 tools/perf/builtin-c2c.c                           |   4 +-
 tools/perf/builtin-lock.c                          |   2 +-
 tools/perf/pmu-events/arch/s390/cf_z10/basic.json  |  48 +-
 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json |  64 +--
 .../perf/pmu-events/arch/s390/cf_z10/extended.json |  36 +-
 tools/perf/pmu-events/arch/s390/cf_z13/basic.json  |  48 +-
 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json |  64 +--
 .../perf/pmu-events/arch/s390/cf_z13/extended.json | 100 ++--
 tools/perf/pmu-events/arch/s390/cf_z14/basic.json  |  32 +-
 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json |  64 +--
 .../perf/pmu-events/arch/s390/cf_z14/extended.json | 102 ++--
 tools/perf/pmu-events/arch/s390/cf_z15/basic.json  |  32 +-
 tools/perf/pmu-events/arch/s390/cf_z15/crypto.json | 114 -----
 .../perf/pmu-events/arch/s390/cf_z15/crypto6.json  | 112 +++++
 .../perf/pmu-events/arch/s390/cf_z15/extended.json | 108 ++---
 tools/perf/pmu-events/arch/s390/cf_z16/basic.json  |  58 +++
 .../perf/pmu-events/arch/s390/cf_z16/crypto6.json  | 142 ++++++
 .../perf/pmu-events/arch/s390/cf_z16/extended.json | 492 +++++++++++++++++++
 .../pmu-events/arch/s390/cf_z16/transaction.json   |   7 +
 tools/perf/pmu-events/arch/s390/cf_z196/basic.json |  48 +-
 .../perf/pmu-events/arch/s390/cf_z196/crypto.json  |  64 +--
 .../pmu-events/arch/s390/cf_z196/extended.json     |  44 +-
 .../perf/pmu-events/arch/s390/cf_zec12/basic.json  |  48 +-
 .../perf/pmu-events/arch/s390/cf_zec12/crypto.json |  64 +--
 .../pmu-events/arch/s390/cf_zec12/extended.json    |  66 +--
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 .../pmu-events/arch/x86/alderlake/adl-metrics.json | 163 +++++--
 .../arch/x86/sapphirerapids/spr-metrics.json       | 530 +++++++++++++++++++++
 tools/perf/tests/shell/test_arm_spe_fork.sh        |  92 ++++
 tools/perf/util/dso.h                              |   2 +
 tools/perf/util/unwind-libunwind-local.c           | 105 ++--
 38 files changed, 2163 insertions(+), 738 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/evsel.h
 delete mode 100644 tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/crypto6.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
 create mode 100755 tools/perf/tests/shell/test_arm_spe_fork.sh

Test results:

The container based builds will return when I get back home.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

  $ uname -a
  Linux quaco 5.17.11-300.fc36.x86_64 #1 SMP PREEMPT Wed May 25 15:04:05 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  1bcca2b1bd67f3c0 (HEAD -> perf/core) perf vendor events intel: Update metrics for Alderlake
  $ perf -v
  perf version 5.18.g1bcca2b1bd67
  $ sudo su -
  # perf -vv
  perf version 5.18.g1bcca2b1bd67
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
  # perf test
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
   89: perf stat CSV output linter                                     : Skip
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
  #

The CORESIGHT=1 build is failing, being investigated, couldn't reproduce it
building it out of 'make -C tools/perf build-test', as below.

Also LIBBPF_DYNAMIC=1 fails on fedora:36, as libbpf-devel is old, should work
with 0.8.0, that is in fedora:rawhide and should be on 36 soon according to
Jiri Olsa.

  $ cat /proc/cpuinfo | grep "model name" -m1
  model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  $ git log --oneline -1 ; time make -C tools/perf/ build-test
  1bcca2b1bd67f3c0 (HEAD -> perf/core, acme.korg/tmp.perf/core) perf vendor events intel: Update metrics for Alderlake
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j8  DESTDIR=/tmp/tmp.x5DTDzzkiO
                make_with_gtk2: make GTK2=1 -j8  DESTDIR=/tmp/tmp.3FlErTijHh
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
                make_no_newt_O: make NO_NEWT=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                  make_debug_O: make DEBUG=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_tags_O: make tags
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                 make_no_sdt_O: make NO_SDT=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_perf_o_O: make perf.o
                 make_cscope_O: make cscope
                make_install_O: make install
               make_no_slang_O: make NO_SLANG=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
              make_no_libelf_O: make NO_LIBELF=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_demangle_O: make NO_DEMANGLE=1
            make_install_bin_O: make install-bin
         make_install_prefix_O: make install prefix=/tmp/krava
              make_clean_all_O: make clean all
                   make_pure_O: make
             make_no_libnuma_O: make NO_LIBNUMA=1
                    make_doc_O: make doc
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_help_O: make help
                make_no_gtk2_O: make NO_GTK2=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_util_map_o_O: make util/map.o
           make_with_libpfm4_O: make LIBPFM4=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  
  real	18m58.348s
  user	112m8.915s
  sys	15m59.473s
  $
