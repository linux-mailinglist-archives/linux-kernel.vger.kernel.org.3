Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB20E48A2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiAJWaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345419AbiAJWaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:30:11 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A69C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:30:11 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id l3so19715256iol.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Q26z8z4a4M0tAL2eu3y79fIBATCBY9yrptGAL0QTbY=;
        b=kwK8Rrc1iPChNRgoUecLLbmh7PVrnU1G43krcMUS+ykSs2gcr/1+cfShP/fznSpPux
         pn7+bCOvEQqwVEFsGFbfKJGldDPQxm/H5sdQ9B2AvK5O02314Z2idjDKnkJRtEC3WJF0
         YUr9KrTLL73niMG7lmUtkebAPlOenPEkLverVAo4k6wgOzvq7P6h2nl1DOFOXkQAFd2n
         e8WRKXNvMHEKrXByJgXhAZhH2osRD7AVF4YYPhvemXO/0zxZJNqZmJg+Dp5DlBeQb+Kv
         j7vKQy0j9gNgM8faLnpiWSHCmoCHb3dzngpZ+n7QcU1UrPb45+rbO4/P8M7mg/VMJATF
         Zmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Q26z8z4a4M0tAL2eu3y79fIBATCBY9yrptGAL0QTbY=;
        b=4dWjltI1EPs/Swmca/x0BCtvqR+1ujnuZq94uXcrdGGRbuqZ6bChDseoIQ9xOuFAi0
         nPz+98YmJjLkgpeKD0mn4m/30raxs7rE6HFwQbcR1ywhM6QAvIT0WGIyCVDDwFjHUACJ
         YuEAcFsKtBvvjHaK59K1HyIaf2G44JUgOHH7xRDxpwcAOSnt/FmMagOpVWCXNhTE7QOK
         vJG/BWISHeIaX/iCpZhADlK2mudfm5efkRtztTgLbinNqKSGqZV6Un/iMzbybyWemcbI
         REbg0XhZQ/cUaWNYguwO2Q5IPt/xtXkJskvQVhholTXLb4uEvvVF1wkayIsWHFFKzEDY
         T2Cg==
X-Gm-Message-State: AOAM532gdak1/OZrY0GTG721uRX17G3N16BWFIeEpnmi050pr9Ezu0of
        sMrsdz7p07LzchgJqANgPmGy8jkfd3aBlaZSolYqtA==
X-Google-Smtp-Source: ABdhPJxq6i8JvWs8RAX+bvkimoaH2QVkmwEq01icMIJV5LKQrZy0k+X+bGSkwjj+Fwr0TyM9ZXopDOD4+xQyWBkOw24=
X-Received: by 2002:a02:a414:: with SMTP id c20mr1058351jal.26.1641853810681;
 Mon, 10 Jan 2022 14:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com> <20211230072030.302559-8-irogers@google.com>
 <YdybPJKjqx6zb28/@kernel.org> <YdyfCN1/JWJtJHTO@kernel.org>
 <Ydyjvcma/wMTPwbn@kernel.org> <Ydymdm/PoB0hQVUT@kernel.org>
In-Reply-To: <Ydymdm/PoB0hQVUT@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jan 2022 14:29:58 -0800
Message-ID: <CAP-5=fVAa3JVbdzNZg0LrVfw__9U9Q8PkHcro+TJiFVyvTho+A@mail.gmail.com>
Subject: Re: [PATCH v3 06/48] perf cpumap: Switch cpu_map__build_map to cpu function
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 1:34 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jan 10, 2022 at 06:23:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 10, 2022 at 06:03:04PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Jan 10, 2022 at 05:46:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > At this point we need to remove the now unused perf_env__get_cpu(), and
> > > > then deal with the fallout in the following patches that needlessly
> > > > modify this unused function.
> > > >
> > > > Doing that now.
> > >
> > > Done, force pushed to tmp.perf/perf_cpu, now it is going again thru the
> > > build containers, a better start now:
>
> > So far so good:
>
> perf test ok, just that one that is failing, but before this series as
> well:
>
>  89: perf all metricgroups test                                      : FAILED!

Could you add the verbose output? I suspect it is fixed by this:
https://lore.kernel.org/lkml/20211223183948.3423989-1-irogers@google.com/

Thanks,
Ian

> [acme@quaco perf]$ uname -a
> Linux quaco 5.15.7-200.fc35.x86_64 #1 SMP Wed Dec 8 19:00:47 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> [acme@quaco perf]$ git log --oneline -1
> 16ed0580fb4d64bd (HEAD -> perf/core, seventh/perf/core, five/perf/core, acme.korg/tmp.perf/perf_cpu) perf cpumap: Give CPUs their own type
> [acme@quaco perf]$ perf -v
> perf version 5.16.g16ed0580fb4d
> [acme@quaco perf]$ sudo su -
> [sudo] password for acme:
> [root@quaco ~]# perf -vv
> perf version 5.16.g16ed0580fb4d
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ OFF ]  # HAVE_LIBPFM
> [root@quaco ~]# perf test
>   1: vmlinux symtab matches kallsyms                                 : Ok
>   2: Detect openat syscall event                                     : Ok
>   3: Detect openat syscall event on all cpus                         : Ok
>   4: Read samples using the mmap interface                           : Ok
>   5: Test data source output                                         : Ok
>   6: Parse event definition strings                                  : Ok
>   7: Simple expression parser                                        : Ok
>   8: PERF_RECORD_* events & perf_sample fields                       : Ok
>   9: Parse perf pmu format                                           : Ok
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : Ok
>  10.2: PMU event map aliases                                         : Ok
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
>  11: DSO data read                                                   : Ok
>  12: DSO data cache                                                  : Ok
>  13: DSO data reopen                                                 : Ok
>  14: Roundtrip evsel->name                                           : Ok
>  15: Parse sched tracepoints fields                                  : Ok
>  16: syscalls:sys_enter_openat event fields                          : Ok
>  17: Setup struct perf_event_attr                                    : Ok
>  18: Match and link multiple hists                                   : Ok
>  19: 'import perf' in python                                         : Ok
>  20: Breakpoint overflow signal handler                              : Ok
>  21: Breakpoint overflow sampling                                    : Ok
>  22: Breakpoint accounting                                           : Ok
>  23: Watchpoint                                                      :
>  23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
>  23.2: Write Only Watchpoint                                         : Ok
>  23.3: Read / Write Watchpoint                                       : Ok
>  23.4: Modify Watchpoint                                             : Ok
>  24: Number of exit events of a simple workload                      : Ok
>  25: Software clock events period values                             : Ok
>  26: Object code reading                                             : Ok
>  27: Sample parsing                                                  : Ok
>  28: Use a dummy software event to keep tracking                     : Ok
>  29: Parse with no sample_id_all bit set                             : Ok
>  30: Filter hist entries                                             : Ok
>  31: Lookup mmap thread                                              : Ok
>  32: Share thread maps                                               : Ok
>  33: Sort output of hist entries                                     : Ok
>  34: Cumulate child hist entries                                     : Ok
>  35: Track with sched_switch                                         : Ok
>  36: Filter fds with revents mask in a fdarray                       : Ok
>  37: Add fd to a fdarray, making it autogrow                         : Ok
>  38: kmod_path__parse                                                : Ok
>  39: Thread map                                                      : Ok
>  40: LLVM search and compile                                         :
>  40.1: Basic BPF llvm compile                                        : Ok
>  40.2: kbuild searching                                              : Ok
>  40.3: Compile source for BPF prologue generation                    : Ok
>  40.4: Compile source for BPF relocation                             : Ok
>  41: Session topology                                                : Ok
>  42: BPF filter                                                      :
>  42.1: Basic BPF filtering                                           : Ok
>  42.2: BPF pinning                                                   : Ok
>  42.3: BPF prologue generation                                       : Ok
>  43: Synthesize thread map                                           : Ok
>  44: Remove thread map                                               : Ok
>  45: Synthesize cpu map                                              : Ok
>  46: Synthesize stat config                                          : Ok
>  47: Synthesize stat                                                 : Ok
>  48: Synthesize stat round                                           : Ok
>  49: Synthesize attr update                                          : Ok
>  50: Event times                                                     : Ok
>  51: Read backward ring buffer                                       : Ok
>  52: Print cpu map                                                   : Ok
>  53: Merge cpu map                                                   : Ok
>  54: Probe SDT events                                                : Ok
>  55: is_printable_array                                              : Ok
>  56: Print bitmap                                                    : Ok
>  57: perf hooks                                                      : Ok
>  58: builtin clang support                                           :
>  58.1: builtin clang compile C source to IR                          : Skip (not compiled in)
>  58.2: builtin clang compile C source to ELF object                  : Skip (not compiled in)
>  59: unit_number__scnprintf                                          : Ok
>  60: mem2node                                                        : Ok
>  61: time utils                                                      : Ok
>  62: Test jit_write_elf                                              : Ok
>  63: Test libpfm4 support                                            :
>  63.1: test of individual --pfm-events                               : Skip (not compiled in)
>  63.2: test groups of --pfm-events                                   : Skip (not compiled in)
>  64: Test api io                                                     : Ok
>  65: maps__merge_in                                                  : Ok
>  66: Demangle Java                                                   : Ok
>  67: Demangle OCaml                                                  : Ok
>  68: Parse and process metrics                                       : Ok
>  69: PE file support                                                 : Ok
>  70: Event expansion for cgroups                                     : Ok
>  71: Convert perf time to TSC                                        : Ok
>  72: dlfilter C API                                                  : Ok
>  73: Sigtrap                                                         : Ok
>  74: x86 rdpmc                                                       : Ok
>  75: Test dwarf unwind                                               : Ok
>  76: x86 instruction decoder - new instructions                      : Ok
>  77: Intel PT packet decoder                                         : Ok
>  78: x86 bp modify                                                   : Ok
>  79: x86 Sample parsing                                              : Ok
>  80: build id cache operations                                       : Ok
>  81: daemon operations                                               : Ok
>  82: perf pipe recording and injection test                          : Ok
>  83: Add vfs_getname probe to get syscall args filenames             : Ok
>  84: probe libc's inet_pton & backtrace it with ping                 : Ok
>  85: Use vfs_getname probe to get syscall args filenames             : Ok
>  86: Zstd perf.data compression/decompression                        : Ok
>  87: perf stat csv summary test                                      : Ok
>  88: perf stat metrics (shadow stat) test                            : Ok
>  89: perf all metricgroups test                                      : FAILED!
>  90: perf all metrics test                                           : Ok
>  91: perf all PMU test                                               : Ok
>  92: perf stat --bpf-counters test                                   : Ok
>  93: Check Arm CoreSight trace data recording and synthesized samples: Skip
>  94: Check Arm SPE trace data recording and synthesized samples      : Skip
>  95: Check open filename arg using perf trace + vfs_getname          : Ok
> [root@quaco ~]#
>
> And the containers are ok so far:
>
> [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.16.0.tar.xz
> [perfbuilder@five ~]$ time dm
>    1    95.61 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
>    2    56.18 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
>    3    54.98 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
>    4    57.69 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
>    5    63.62 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    6    64.52 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    7    66.54 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    8    91.91 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>    9   104.93 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>   10   107.97 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>   11   115.98 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
>   12   101.73 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
>   13   103.35 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
>   14   104.43 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
>   15    51.06 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
>   16    75.95 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
>   17    75.26 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
>   18    74.85 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
>   19    52.87 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
>   20    85.98 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
>   21    79.77 archlinux:base                : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
>   22    83.56 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
>   23    98.02 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
>   24    27.67 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20211228 releases/gcc-11.2.0-618-g3b2b18144c , clang version 11.1.0
>   25    65.92 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
>   26    62.20 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
>   27: debian:11
>
