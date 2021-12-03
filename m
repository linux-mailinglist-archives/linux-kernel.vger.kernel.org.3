Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE66A467830
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380903AbhLCNb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:31:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53144 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbhLCNb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:31:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 921C962AB1;
        Fri,  3 Dec 2021 13:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C305C53FC7;
        Fri,  3 Dec 2021 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638538084;
        bh=RHfBhf1S7t6JFSPij+o3I2cs4o6vuBsDYzTK6B1w5bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAY2fzbrWjSd2RskF3kCxncmfZlwE9Wz5MBygkXi1o/dMzXJbQ4Nd6ZlCr7Y5mlU7
         ZZ5KFKbVv0KUQaKSeREAHuErlcCKI9cc4ph9WBvOYNzVanKZPugLDhKuEYozO6wSDU
         b4HHOFz1ns0PwAn2OpRKnFOOemWSy4PElgltVPoFzsD80AdYFdA29fl9GMe4CRvMrE
         cQypj0NcESmBsjtz2jUxaGkQ70NqG4ORaB0/jLmcsHQWUgrpXXZ/fmOpH5FY5c+r0R
         +oFN9YsbiVJ1TsZx6cQs4lO3/H0XcsdXr/IKeYKHQWiV0crkdZOBBHgkJy/1EiDI/7
         vtkYdmgJ4drCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9A5140002; Fri,  3 Dec 2021 10:28:00 -0300 (-03)
Date:   Fri, 3 Dec 2021 10:28:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <YaobYKgrTV1Bthi0@kernel.org>
References: <YaoXUrLUZt1scVb0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaoXUrLUZt1scVb0@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 03, 2021 at 10:10:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Song,
> 
> 	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
> to then make this the default, so far older containers fail either
> because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
> env var to disable that in those containers and then there is this other
> case where clang is recent enough but:
> 
>     util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
>             __uint(map_flags, BPF_F_PRESERVE_ELEMS);
> 
> Because the system's /usr/include/linux/bpf.h doesn't have that
> BPF_F_PRESERVE_ELEMS enum entry.
> 
> These are enums to make them available via BTF, but then I can't use
> the:
> 
> #ifdef BPF_F_PRESERVE_ELEMS
> #define BPF_F_PRESERVE_ELEMS (1U << 11)
> #endif
> 
> approach.
> 
> But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
> 
> $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
> 	BPF_F_PRESERVE_ELEMS	= (1U << 11),
> $
> 
> so we need to switch to using it somehow, this way we can build in more
> systems and make bperf and other BPF enabled features.
> 
> From a quick look I couldn't find where to add
> $(sourcedir)/tools/include/uapi/ to the include path used to build
> util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?

The failure for fedora:32, which seems to be on the threshold for clang
to be considered recent enough for building skels fails differently:

clang version 10.0.1 (Fedora 10.0.1-3.fc32)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
+ '[' '!' ']'
+ rm -rf /tmp/build/perf
+ mkdir /tmp/build/perf
+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf
make: Entering directory '/git/perf-5.16.0-rc3/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  /tmp/build/perf/fixdep.o
  HOSTLD  /tmp/build/perf/fixdep-in.o
  LINK    /tmp/build/perf/fixdep
/bin/sh: -c: line 0: syntax error near unexpected token `('
/bin/sh: -c: line 0: `expr bison (GNU Bison) 3.5 \>\= 371'
Makefile.config:997: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                        libbfd: [ on  ]
...                libbfd-buildid: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]


  GEN     /tmp/build/perf/common-cmds.h
  PERF_VERSION = 5.16.rc3.g0c338bcdfdb1
  CC      /tmp/build/perf/exec-cmd.o
  CC      /tmp/build/perf/help.o
  CC      /tmp/build/perf/cpu.o
  CC      /tmp/build/perf/pager.o
  CC      /tmp/build/perf/debug.o
  GEN     perf-archive
  CC      /tmp/build/perf/parse-options.o
  CC      /tmp/build/perf/str_error_r.o
  GEN     perf-with-kcore
  CC      /tmp/build/perf/run-command.o
  CC      /tmp/build/perf/sigchain.o
  GEN     perf-iostat
  MKDIR   /tmp/build/perf/fd/
  MKDIR   /tmp/build/perf/fs/
  CC      /tmp/build/perf/subcmd-config.o
  MKDIR   /tmp/build/perf/jvmti/
  MKDIR   /tmp/build/perf/fs/
  MKDIR   /tmp/build/perf/jvmti/
  CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
  CC      /tmp/build/perf/dlfilters/dlfilter-show-cycles.o
  MKDIR   /tmp/build/perf/jvmti/
  CC      /tmp/build/perf/fd/array.o
  MKDIR   /tmp/build/perf/fs/
  CC      /tmp/build/perf/fs/fs.o
  MKDIR   /tmp/build/perf/jvmti/
  MKDIR   /tmp/build/perf/pmu-events/
  CC      /tmp/build/perf/event-parse.o
  MKDIR   /tmp/build/perf/pmu-events/
  CC      /tmp/build/perf/jvmti/libjvmti.o
  CC      /tmp/build/perf/jvmti/jvmti_agent.o
  CC      /tmp/build/perf/fs/tracing_path.o
  CC      /tmp/build/perf/jvmti/libstring.o
  CC      /tmp/build/perf/fs/cgroup.o
  HOSTCC  /tmp/build/perf/pmu-events/json.o
  CC      /tmp/build/perf/jvmti/libctype.o
  CC      /tmp/build/perf/core.o
  HOSTCC  /tmp/build/perf/pmu-events/jsmn.o
  MKDIR   /tmp/build/perf/pmu-events/
  HOSTCC  /tmp/build/perf/pmu-events/jevents.o
  CC      /tmp/build/perf/cpumap.o
  CC      /tmp/build/perf/plugin_jbd2.o
  CC      /tmp/build/perf/plugin_hrtimer.o
  CC      /tmp/build/perf/plugin_kmem.o
  CC      /tmp/build/perf/threadmap.o
  CC      /tmp/build/perf/plugin_kvm.o
  CC      /tmp/build/perf/evsel.o
  CC      /tmp/build/perf/plugin_mac80211.o
  LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
  CC      /tmp/build/perf/plugin_sched_switch.o
make[3]: *** No rule to make target 'kernelversion'.  Stop.
  CC      /tmp/build/perf/plugin_function.o
  LD      /tmp/build/perf/fd/libapi-in.o
  CC      /tmp/build/perf/event-plugin.o
  GEN     /tmp/build/perf/libbpf/bpf_helper_defs.h
  CC      /tmp/build/perf/plugin_futex.o
  CC      /tmp/build/perf/plugin_xen.o
  CC      /tmp/build/perf/plugin_scsi.o
  CC      /tmp/build/perf/evlist.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf.h
  LD      /tmp/build/perf/plugin_jbd2-in.o
  CC      /tmp/build/perf/plugin_cfg80211.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf.h
  LD      /tmp/build/perf/plugin_hrtimer-in.o
  LD      /tmp/build/perf/fs/libapi-in.o
  LD      /tmp/build/perf/plugin_kmem-in.o
  CC      /tmp/build/perf/plugin_tlb.o
  LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
  CC      /tmp/build/perf/mmap.o
  CC      /tmp/build/perf/zalloc.o
  LINK    /tmp/build/perf/plugin_jbd2.so
  LINK    /tmp/build/perf/plugin_hrtimer.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/btf.h
  CC      /tmp/build/perf/xyarray.o
  CC      /tmp/build/perf/trace-seq.o
  LD      /tmp/build/perf/plugin_mac80211-in.o
  LD      /tmp/build/perf/libapi-in.o
  LD      /tmp/build/perf/plugin_kvm-in.o
  CC      /tmp/build/perf/parse-filter.o
  CC      /tmp/build/perf/parse-utils.o
  LD      /tmp/build/perf/plugin_sched_switch-in.o
  CC      /tmp/build/perf/kbuffer-parse.o
  CC      /tmp/build/perf/tep_strerror.o
  HOSTLD  /tmp/build/perf/pmu-events/jevents-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_legacy.h
  CC      /tmp/build/perf/event-parse-api.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/xsk.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
  AR      /tmp/build/perf/libapi.a
  LD      /tmp/build/perf/plugin_function-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
  LINK    /tmp/build/perf/plugin_kmem.so
  LINK    /tmp/build/perf/plugin_mac80211.so
  LINK    /tmp/build/perf/plugin_kvm.so
  LD      /tmp/build/perf/plugin_xen-in.o
  LINK    /tmp/build/perf/plugin_sched_switch.so
  LD      /tmp/build/perf/plugin_cfg80211-in.o
  CC      /tmp/build/perf/lib.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
  LD      /tmp/build/perf/plugin_futex-in.o
  LD      /tmp/build/perf/plugin_scsi-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
  LINK    /tmp/build/perf/pmu-events/jevents
  LD      /tmp/build/perf/plugin_tlb-in.o
  LINK    /tmp/build/perf/plugin_function.so
  LINK    /tmp/build/perf/plugin_xen.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
  LINK    /tmp/build/perf/plugin_cfg80211.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
  LINK    /tmp/build/perf/plugin_futex.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h
  LINK    /tmp/build/perf/plugin_scsi.so
  LD      /tmp/build/perf/jvmti/jvmti-in.o
  LINK    /tmp/build/perf/plugin_tlb.so
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  LD      /tmp/build/perf/libsubcmd-in.o
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  CC      /tmp/build/perf/libbpf/staticobjs/xsk.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf.o
  LINK    /tmp/build/perf/libperf-jvmti.so
  CC      /tmp/build/perf/libbpf/staticobjs/bpf.o
  CC      /tmp/build/perf/libbpf/staticobjs/nlattr.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/libbpf/staticobjs/hashmap.o
  CC      /tmp/build/perf/libbpf/staticobjs/str_error.o
  CC      /tmp/build/perf/libbpf/staticobjs/netlink.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf_dump.o
  CC      /tmp/build/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/build/perf/libbpf/staticobjs/ringbuf.o
  CC      /tmp/build/perf/libbpf/staticobjs/strset.o
  GEN     /tmp/build/perf/libtraceevent-dynamic-list
  CC      /tmp/build/perf/libbpf/staticobjs/linker.o
  CC      /tmp/build/perf/libbpf/staticobjs/gen_loader.o
  CC      /tmp/build/perf/libbpf/staticobjs/relo_core.o
  AR      /tmp/build/perf/libsubcmd.a
  LD      /tmp/build/perf/libtraceevent-in.o
  GEN     /tmp/build/perf/pmu-events/pmu-events.c
  LINK    /tmp/build/perf/libtraceevent.a
  LD      /tmp/build/perf/libperf-in.o
  AR      /tmp/build/perf/libperf.a
  GEN     /tmp/build/perf/python/perf.so
  CC      /tmp/build/perf/pmu-events/pmu-events.o

Auto-detecting system features:
...                        libbfd: [ on  ]
...        disassembler-four-args: [ on  ]
...                          zlib: [ on  ]
...                        libcap: [ on  ]
...               clang-bpf-co-re: [ on  ]


  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/hashmap.h
  GEN     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/bpf_helper_defs.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/btf.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf_common.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf_legacy.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/xsk.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_helpers.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_tracing.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_endian.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_core_read.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/skel_internal.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/libbpf_version.h
  INSTALL /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf//include/bpf/bpf_helper_defs.h
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf_dump.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/nlattr.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/ringbuf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/str_error.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/netlink.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/strset.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/xsk.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/hashmap.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/linker.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/gen_loader.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/relo_core.o
  LD      /tmp/build/perf/pmu-events/pmu-events-in.o
  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/libbpf/libbpf.a
  LD      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/json_writer.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/xlated_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/disasm.o
  LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
  GEN     /tmp/build/perf/util/bpf_skel/vmlinux.h
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
  GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
libbpf: elf: skipping unrecognized data section(9) .eh_frame
libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: map 'prev_readings': unexpected def kind var.
Error: failed to open BPF object file: Invalid argument
make[2]: *** [Makefile.perf:1076: /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h] Error 255
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-5.16.0-rc3/tools/perf'
+ exit 1
[perfbuilder@five 32]$

