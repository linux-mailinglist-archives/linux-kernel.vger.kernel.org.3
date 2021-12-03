Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D646795E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381356AbhLCO13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhLCO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:27:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4DFC061751;
        Fri,  3 Dec 2021 06:24:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE87AB82808;
        Fri,  3 Dec 2021 14:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE94AC53FAD;
        Fri,  3 Dec 2021 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638541441;
        bh=bBeNk40gc4SDZJfWu6gPBZP4oHzzRYKDLcwVTZsmQK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K38pkWbMKXNoZSNO7ymyfygsRChwGkZbaxt139j57zUZdtgcR4AR16Waqwt4YQX2F
         PgJPq/Y677vy7PmDdPZJzS5A1FKTNLlDiU5HHo6LwTDnOdiFGyiZ8ULfbF7omLvhyD
         QwrSgkJ+gS1Nof9NVzinSQ4xnQK9etTn8lVFxH82eKSQyMjrM779DcCuHiIjbVf+o1
         SVryQ4slBuKVcgI9v8bOh7AL0MSw97NPGRScaPGxtPjrPm3Ljiq5goRkYcyzE2Ssva
         3DBpKhZWA8azWWc1s3jPatc95T7uQ8bNo+DjFITe6zRzPyHCKZ0AEkagQcarjUhRjv
         A7UrvViqEpbXQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20FD340002; Fri,  3 Dec 2021 11:23:58 -0300 (-03)
Date:   Fri, 3 Dec 2021 11:23:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <YaoofidHLBsuBdWV@kernel.org>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <YaobYKgrTV1Bthi0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaobYKgrTV1Bthi0@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 03, 2021 at 10:28:00AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Dec 03, 2021 at 10:10:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Hi Song,
> > 
> > 	So I'm changing all my containers to build with BUILD_BPF_SKEL=1
> > to then make this the default, so far older containers fail either
> > because the clang available is too old, so I've added a NO_BUILD_BPF_SKEL=1
> > env var to disable that in those containers and then there is this other
> > case where clang is recent enough but:
> > 
> >     util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
> >             __uint(map_flags, BPF_F_PRESERVE_ELEMS);
> > 
> > Because the system's /usr/include/linux/bpf.h doesn't have that
> > BPF_F_PRESERVE_ELEMS enum entry.
> > 
> > These are enums to make them available via BTF, but then I can't use
> > the:
> > 
> > #ifdef BPF_F_PRESERVE_ELEMS
> > #define BPF_F_PRESERVE_ELEMS (1U << 11)
> > #endif
> > 
> > approach.
> > 
> > But then we _have_ it in the tools/include/uapi/linux/bpf.h we ship:
> > 
> > $ grep BPF_F_PRESERVE_ELEMS tools/include/uapi/linux/bpf.h
> > 	BPF_F_PRESERVE_ELEMS	= (1U << 11),
> > $

> > so we need to switch to using it somehow, this way we can build in more
> > systems and make bperf and other BPF enabled features.

> > From a quick look I couldn't find where to add
> > $(sourcedir)/tools/include/uapi/ to the include path used to build
> > util/bpf_skel/bperf_leader.bpf.c, should be easy, can you take a look?
 
> The failure for fedora:32, which seems to be on the threshold for clang
> to be considered recent enough for building skels fails differently:
 
> clang version 10.0.1 (Fedora 10.0.1-3.fc32)

Amazon Linux 2 fails differently:

clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/7
Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/7
Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/7
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
+ '[' '!' ']'
+ rm -rf /tmp/build/perf
+ mkdir /tmp/build/perf
+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf
make: Entering directory `/git/perf-5.16.0-rc3/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  /tmp/build/perf/fixdep.o
  HOSTLD  /tmp/build/perf/fixdep-in.o
  LINK    /tmp/build/perf/fixdep
Makefile.config:780: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
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
...                       libperl: [ OFF ]
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
  GEN     perf-archive
  CC      /tmp/build/perf/cpu.o
  GEN     perf-with-kcore
  MKDIR   /tmp/build/perf/fd/
  CC      /tmp/build/perf/exec-cmd.o
  MKDIR   /tmp/build/perf/fs/
  MKDIR   /tmp/build/perf/jvmti/
  CC      /tmp/build/perf/debug.o
  CC      /tmp/build/perf/help.o
  MKDIR   /tmp/build/perf/fs/
  GEN     perf-iostat
  CC      /tmp/build/perf/str_error_r.o
  CC      /tmp/build/perf/fd/array.o
  CC      /tmp/build/perf/pager.o
  CC      /tmp/build/perf/fs/fs.o
  CC      /tmp/build/perf/jvmti/libjvmti.o
  CC      /tmp/build/perf/parse-options.o
  CC      /tmp/build/perf/fs/tracing_path.o
  CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
  MKDIR   /tmp/build/perf/jvmti/
  CC      /tmp/build/perf/run-command.o
  MKDIR   /tmp/build/perf/fs/
  CC      /tmp/build/perf/event-parse.o
  CC      /tmp/build/perf/jvmti/libstring.o
  CC      /tmp/build/perf/sigchain.o
  MKDIR   /tmp/build/perf/pmu-events/
  CC      /tmp/build/perf/event-plugin.o
  CC      /tmp/build/perf/subcmd-config.o
  CC      /tmp/build/perf/jvmti/jvmti_agent.o
  MKDIR   /tmp/build/perf/pmu-events/
  CC      /tmp/build/perf/trace-seq.o
  CC      /tmp/build/perf/fs/cgroup.o
  CC      /tmp/build/perf/jvmti/libctype.o
  HOSTCC  /tmp/build/perf/pmu-events/json.o
  CC      /tmp/build/perf/core.o
  HOSTCC  /tmp/build/perf/pmu-events/jsmn.o
  CC      /tmp/build/perf/cpumap.o
  CC      /tmp/build/perf/plugin_jbd2.o
  CC      /tmp/build/perf/dlfilters/dlfilter-show-cycles.o
  MKDIR   /tmp/build/perf/pmu-events/
  CC      /tmp/build/perf/parse-filter.o
  CC      /tmp/build/perf/threadmap.o
  HOSTCC  /tmp/build/perf/pmu-events/jevents.o
  CC      /tmp/build/perf/plugin_hrtimer.o
  CC      /tmp/build/perf/parse-utils.o
  CC      /tmp/build/perf/evsel.o
  CC      /tmp/build/perf/plugin_kmem.o
  CC      /tmp/build/perf/kbuffer-parse.o
  LD      /tmp/build/perf/fd/libapi-in.o
  CC      /tmp/build/perf/evlist.o
  CC      /tmp/build/perf/plugin_kvm.o
  CC      /tmp/build/perf/tep_strerror.o
  CC      /tmp/build/perf/mmap.o
  CC      /tmp/build/perf/event-parse-api.o
  CC      /tmp/build/perf/plugin_mac80211.o
  LD      /tmp/build/perf/plugin_jbd2-in.o
  CC      /tmp/build/perf/zalloc.o
  LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
  CC      /tmp/build/perf/plugin_sched_switch.o
  LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
  CC      /tmp/build/perf/plugin_function.o
  CC      /tmp/build/perf/xyarray.o
  LD      /tmp/build/perf/fs/libapi-in.o
  LD      /tmp/build/perf/plugin_hrtimer-in.o
  CC      /tmp/build/perf/plugin_futex.o
  CC      /tmp/build/perf/lib.o
  CC      /tmp/build/perf/plugin_xen.o
  LD      /tmp/build/perf/libapi-in.o
  LD      /tmp/build/perf/plugin_kmem-in.o
make[3]: *** No rule to make target `kernelversion'.  Stop.
  CC      /tmp/build/perf/plugin_scsi.o
  CC      /tmp/build/perf/plugin_cfg80211.o
  CC      /tmp/build/perf/plugin_tlb.o
  LINK    /tmp/build/perf/plugin_jbd2.so
  GEN     /tmp/build/perf/libbpf/bpf_helper_defs.h
  LINK    /tmp/build/perf/plugin_hrtimer.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf.h
  LINK    /tmp/build/perf/plugin_kmem.so
  AR      /tmp/build/perf/libapi.a
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf.h
  LD      /tmp/build/perf/plugin_kvm-in.o
  LD      /tmp/build/perf/plugin_sched_switch-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/btf.h
  LD      /tmp/build/perf/plugin_mac80211-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/xsk.h
  HOSTLD  /tmp/build/perf/pmu-events/jevents-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
  LD      /tmp/build/perf/plugin_function-in.o
  LINK    /tmp/build/perf/plugin_kvm.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
  LINK    /tmp/build/perf/plugin_sched_switch.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
  LINK    /tmp/build/perf/plugin_mac80211.so
  INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
  LINK    /tmp/build/perf/pmu-events/jevents
  LD      /tmp/build/perf/plugin_futex-in.o
  LINK    /tmp/build/perf/plugin_function.so
  LD      /tmp/build/perf/plugin_xen-in.o
  LINK    /tmp/build/perf/plugin_futex.so
  LD      /tmp/build/perf/plugin_cfg80211-in.o
  LD      /tmp/build/perf/plugin_tlb-in.o
  LINK    /tmp/build/perf/plugin_xen.so
  LD      /tmp/build/perf/jvmti/jvmti-in.o
  LINK    /tmp/build/perf/plugin_cfg80211.so
  LINK    /tmp/build/perf/plugin_tlb.so
  LD      /tmp/build/perf/plugin_scsi-in.o
  INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  LINK    /tmp/build/perf/libperf-jvmti.so
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  LINK    /tmp/build/perf/plugin_scsi.so
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  MKDIR   /tmp/build/perf/libbpf/staticobjs/
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf_dump.o
  CC      /tmp/build/perf/libbpf/staticobjs/bpf.o
  CC      /tmp/build/perf/libbpf/staticobjs/nlattr.o
  CC      /tmp/build/perf/libbpf/staticobjs/btf.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/libbpf/staticobjs/str_error.o
  CC      /tmp/build/perf/libbpf/staticobjs/ringbuf.o
  CC      /tmp/build/perf/libbpf/staticobjs/netlink.o
  CC      /tmp/build/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/build/perf/libbpf/staticobjs/xsk.o
  CC      /tmp/build/perf/libbpf/staticobjs/strset.o
  CC      /tmp/build/perf/libbpf/staticobjs/hashmap.o
  CC      /tmp/build/perf/libbpf/staticobjs/linker.o
  CC      /tmp/build/perf/libbpf/staticobjs/gen_loader.o
  CC      /tmp/build/perf/libbpf/staticobjs/relo_core.o
  LD      /tmp/build/perf/libsubcmd-in.o
  GEN     /tmp/build/perf/pmu-events/pmu-events.c
  GEN     /tmp/build/perf/libtraceevent-dynamic-list
  AR      /tmp/build/perf/libsubcmd.a
  LD      /tmp/build/perf/libtraceevent-in.o
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
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/xsk.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/nlattr.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/str_error.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/hashmap.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/netlink.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf_dump.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/ringbuf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/strset.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/linker.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/gen_loader.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/relo_core.o
  LD      /tmp/build/perf/pmu-events/pmu-events-in.o
  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/libbpf/libbpf.a
  LD      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/json_writer.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/xlated_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf_dumper.o
  CC      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/disasm.o
  LINK    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
  GEN     /tmp/build/perf/util/bpf_skel/vmlinux.h
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
util/bpf_skel/bpf_prog_profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
        __uint(value_size, sizeof(struct bpf_perf_event_value));
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/build/perf/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                      ^~~
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:26:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
        __uint(value_size, sizeof(struct bpf_perf_event_value));
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/build/perf/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                      ^~~
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:45:59: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
        err = bpf_perf_event_read_value(&events, key, ptr, sizeof(*ptr));
                                                                 ^~~~~~
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:55:39: error: variable has incomplete type 'struct bpf_perf_event_value'
        struct bpf_perf_event_value *before, diff;
                                             ^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:60:22: error: incomplete definition of type 'struct bpf_perf_event_value'
        if (before && before->counter) {
                      ~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:63:23: error: incomplete definition of type 'struct bpf_perf_event_value'
                diff.counter = after->counter - before->counter;
                               ~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:63:41: error: incomplete definition of type 'struct bpf_perf_event_value'
                diff.counter = after->counter - before->counter;
                                                ~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:64:23: error: incomplete definition of type 'struct bpf_perf_event_value'
                diff.enabled = after->enabled - before->enabled;
                               ~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:64:41: error: incomplete definition of type 'struct bpf_perf_event_value'
                diff.enabled = after->enabled - before->enabled;
                                                ~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:65:23: error: incomplete definition of type 'struct bpf_perf_event_value'
                diff.running = after->running - before->running;
                               ~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:65:41: error: incomplete definition of type 'struct bpf_perf_event_value'
                diff.running = after->running - before->running;
                                                ~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:69:9: error: incomplete definition of type 'struct bpf_perf_event_value'
                        accum->counter += diff.counter;
                        ~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:70:9: error: incomplete definition of type 'struct bpf_perf_event_value'
                        accum->enabled += diff.enabled;
                        ~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:71:9: error: incomplete definition of type 'struct bpf_perf_event_value'
                        accum->running += diff.running;
                        ~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bpf_prog_profiler.bpf.c:79:30: error: variable has incomplete type 'struct bpf_perf_event_value'
        struct bpf_perf_event_value reading;
                                    ^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
15 errors generated.
In file included from util/bpf_skel/bperf_follower.bpf.c:7:
util/bpf_skel/bperf.h:10:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
In file included from util/bpf_skel/bperf_leader.bpf.c:7:
util/bpf_skel/bperf.h:10:        __uint(value_size, sizeof(struct bpf_perf_event_value));21
:                            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'/tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
:13:39: note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                      ^~~
        __uint(value_size, sizeof(struct bpf_perf_event_value));
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/build/perf/libbpf/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                      ^~~
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_follower.bpf.c:62:11: error: incomplete definition of type 'struct bpf_perf_event_value'
        accum_val->counter += diff_val->counter;
        ~~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_follower.bpf.c:62:32: error: incomplete definition of type 'struct bpf_perf_event_value'
        accum_val->counter += diff_val->counter;
                              ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_follower.bpf.c:63:11: error: incomplete definition of type 'struct bpf_perf_event_value'
        accum_val->enabled += diff_val->enabled;
        ~~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_follower.bpf.c:63:32: error: incomplete definition of type 'struct bpf_perf_event_value'
        accum_val->enabled += diff_val->enabled;
                              ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_follower.bpf.c:64:11: error: incomplete definition of type 'struct bpf_perf_event_value'
        accum_val->running += diff_val->running;
        ~~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_follower.bpf.c:64:32: error: incomplete definition of type 'struct bpf_perf_event_value'
        accum_val->running += diff_val->running;
                              ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
        __uint(map_flags, BPF_F_PRESERVE_ELEMS);
                          ^
7 errors generated.
util/bpf_skel/bperf_leader.bpf.c:22:30: error: variable has incomplete type 'struct bpf_perf_event_value'
        struct bpf_perf_event_value val, *prev_val, *diff_val;
                                    ^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_leader.bpf.c:39:10: error: incomplete definition of type 'struct bpf_perf_event_value'
        diff_val->counter = val.counter - prev_val->counter;
        ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_leader.bpf.c:39:44: error: incomplete definition of type 'struct bpf_perf_event_value'
        diff_val->counter = val.counter - prev_val->counter;
                                          ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_leader.bpf.c:40:10: error: incomplete definition of type 'struct bpf_perf_event_value'
        diff_val->enabled = val.enabled - prev_val->enabled;
        ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_leader.bpf.c:40:44: error: incomplete definition of type 'struct bpf_perf_event_value'
        diff_val->enabled = val.enabled - prev_val->enabled;
                                          ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_leader.bpf.c:41:10: error: incomplete definition of type 'struct bpf_perf_event_value'
        diff_val->running = val.running - prev_val->running;
        ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
util/bpf_skel/bperf_leader.bpf.c:41:44: error: incomplete definition of type 'struct bpf_perf_event_value'
        diff_val->running = val.running - prev_val->running;
                                          ~~~~~~~~^
/tmp/build/perf/libbpf/include/bpf/bpf_helper_defs.h:7:8: note: forward declaration of 'struct bpf_perf_event_value'
struct bpf_perf_event_value;
       ^
9 errors generated.
make[2]: *** [/tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [/tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o] Error 1
make[2]: *** [/tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o] Error 1
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
make: Leaving directory `/git/perf-5.16.0-rc3/tools/perf'
+ exit 1
    29.38 amazonlinux:2                 : FAIL clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    util/bpf_skel/bpf_prog_profiler.bpf.c:18:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
            __uint(value_size, sizeof(struct bpf_perf_event_value));
                               ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #define __uint(name, val) int (*name)[val]
                                          ^~~
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:26:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
            __uint(value_size, sizeof(struct bpf_perf_event_value));
                               ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #define __uint(name, val) int (*name)[val]
                                          ^~~
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:45:59: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
            err = bpf_perf_event_read_value(&events, key, ptr, sizeof(*ptr));
                                                                     ^~~~~~
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:55:39: error: variable has incomplete type 'struct bpf_perf_event_value'
            struct bpf_perf_event_value *before, diff;
                                                 ^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:60:22: error: incomplete definition of type 'struct bpf_perf_event_value'
            if (before && before->counter) {
                          ~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:63:23: error: incomplete definition of type 'struct bpf_perf_event_value'
                    diff.counter = after->counter - before->counter;
                                   ~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:63:41: error: incomplete definition of type 'struct bpf_perf_event_value'
                    diff.counter = after->counter - before->counter;
                                                    ~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:64:23: error: incomplete definition of type 'struct bpf_perf_event_value'
                    diff.enabled = after->enabled - before->enabled;
                                   ~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:64:41: error: incomplete definition of type 'struct bpf_perf_event_value'
                    diff.enabled = after->enabled - before->enabled;
                                                    ~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:65:23: error: incomplete definition of type 'struct bpf_perf_event_value'
                    diff.running = after->running - before->running;
                                   ~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:65:41: error: incomplete definition of type 'struct bpf_perf_event_value'
                    diff.running = after->running - before->running;
                                                    ~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:69:9: error: incomplete definition of type 'struct bpf_perf_event_value'
                            accum->counter += diff.counter;
                            ~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:70:9: error: incomplete definition of type 'struct bpf_perf_event_value'
                            accum->enabled += diff.enabled;
                            ~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:71:9: error: incomplete definition of type 'struct bpf_perf_event_value'
                            accum->running += diff.running;
                            ~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bpf_prog_profiler.bpf.c:79:30: error: variable has incomplete type 'struct bpf_perf_event_value'
            struct bpf_perf_event_value reading;
                                        ^
    struct bpf_perf_event_value;
           ^
    15 errors generated.
    In file included from util/bpf_skel/bperf_follower.bpf.c:7:
    util/bpf_skel/bperf.h:10:21: error: invalid application of 'sizeof' to an incomplete type 'struct bpf_perf_event_value'
    In file included from util/bpf_skel/bperf_leader.bpf.c:7:
    util/bpf_skel/bperf.h:10:        __uint(value_size, sizeof(struct bpf_perf_event_value));21
    :                            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    :13:39: note: expanded from macro '__uint'
    #define __uint(name, val) int (*name)[val]
                                          ^~~
            __uint(value_size, sizeof(struct bpf_perf_event_value));
                               ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #define __uint(name, val) int (*name)[val]
                                          ^~~
    struct bpf_perf_event_value;
           ^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_follower.bpf.c:62:11: error: incomplete definition of type 'struct bpf_perf_event_value'
            accum_val->counter += diff_val->counter;
            ~~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_follower.bpf.c:62:32: error: incomplete definition of type 'struct bpf_perf_event_value'
            accum_val->counter += diff_val->counter;
                                  ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_follower.bpf.c:63:11: error: incomplete definition of type 'struct bpf_perf_event_value'
            accum_val->enabled += diff_val->enabled;
            ~~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_follower.bpf.c:63:32: error: incomplete definition of type 'struct bpf_perf_event_value'
            accum_val->enabled += diff_val->enabled;
                                  ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_follower.bpf.c:64:11: error: incomplete definition of type 'struct bpf_perf_event_value'
            accum_val->running += diff_val->running;
            ~~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_follower.bpf.c:64:32: error: incomplete definition of type 'struct bpf_perf_event_value'
            accum_val->running += diff_val->running;
                                  ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
            __uint(map_flags, BPF_F_PRESERVE_ELEMS);
                              ^
    7 errors generated.
    util/bpf_skel/bperf_leader.bpf.c:22:30: error: variable has incomplete type 'struct bpf_perf_event_value'
            struct bpf_perf_event_value val, *prev_val, *diff_val;
                                        ^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_leader.bpf.c:39:10: error: incomplete definition of type 'struct bpf_perf_event_value'
            diff_val->counter = val.counter - prev_val->counter;
            ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_leader.bpf.c:39:44: error: incomplete definition of type 'struct bpf_perf_event_value'
            diff_val->counter = val.counter - prev_val->counter;
                                              ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_leader.bpf.c:40:10: error: incomplete definition of type 'struct bpf_perf_event_value'
            diff_val->enabled = val.enabled - prev_val->enabled;
            ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_leader.bpf.c:40:44: error: incomplete definition of type 'struct bpf_perf_event_value'
            diff_val->enabled = val.enabled - prev_val->enabled;
                                              ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_leader.bpf.c:41:10: error: incomplete definition of type 'struct bpf_perf_event_value'
            diff_val->running = val.running - prev_val->running;
            ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    util/bpf_skel/bperf_leader.bpf.c:41:44: error: incomplete definition of type 'struct bpf_perf_event_value'
            diff_val->running = val.running - prev_val->running;
                                              ~~~~~~~~^
    struct bpf_perf_event_value;
           ^
    9 errors generated.
 2 29.3792

real	0m30.510s
user	0m0.535s
sys	0m0.485s
[perfbuilder@five 2]$ 
[perfbuilder@five 2]$ pwd
/var/home/perfbuilder/git/linux-perf-tools-build/amazonlinux/2
[perfbuilder@five 2]$ 


