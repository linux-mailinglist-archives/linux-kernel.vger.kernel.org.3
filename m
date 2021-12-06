Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD5046A675
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbhLFUE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLFUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:04:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA82C061746;
        Mon,  6 Dec 2021 12:00:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E52D3CE180A;
        Mon,  6 Dec 2021 20:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC3EC341C2;
        Mon,  6 Dec 2021 20:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638820855;
        bh=wdDGJaB1y/Uuq6ohInx1/adg9/F7U1hB0P/JA/YBD0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzJOwWKDAC7pBydf9jglCUfEblS6CsKc5UCviPR8CC65J+aqBV0HqDUITMAOVBEQu
         RXWcOxjDG1X7BmUjawVayX2kyJDTaxxTxHSWJzvUBWcxGeJcWbT4gcpTilRbBIps9F
         QHFaZG/vnNiXwuZKcuSr3cj3wyO0uU9hwMWjkW1gtUvGbh21xyGyaZm36SOZ7l3wWq
         aqoxzrUS8oH3TJKdoUvzplya6DOxxWETgqHQXCfes5JcRWu9Ul/lVht2GfUQdYlv8v
         E0tTNnMIqv/fdtdyNRxh5kHC/MYy6C76qJg3ARwWhHj18lMQqVTyylmaPUW8rwYLj1
         D+slVJl0stOSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EAF5640002; Mon,  6 Dec 2021 17:00:51 -0300 (-03)
Date:   Mon, 6 Dec 2021 17:00:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <Ya5r81oxLY1Lb/JN@kernel.org>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <YaobYKgrTV1Bthi0@kernel.org>
 <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com>
 <Ya4CxsyoyFQVFzoi@kernel.org>
 <90475C95-0E7E-4212-A390-2FB33E47EC04@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90475C95-0E7E-4212-A390-2FB33E47EC04@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 06, 2021 at 05:08:21PM +0000, Song Liu escreveu:
> 
> 
> > On Dec 6, 2021, at 4:32 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Fri, Dec 03, 2021 at 08:05:59PM +0000, Song Liu escreveu:
> >>> On Dec 3, 2021, at 5:28 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>> The failure for fedora:32, which seems to be on the threshold for clang
> >>> to be considered recent enough for building skels fails differently:
> > 
> >>> clang version 10.0.1 (Fedora 10.0.1-3.fc32)
> >>> Target: x86_64-unknown-linux-gnu
> >>> Thread model: posix
> >>> InstalledDir: /usr/bin
> >>> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> >>> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> >>> Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> >>> Candidate multilib: .;@m64
> >>> Candidate multilib: 32;@m32
> >>> Selected multilib: .;@m64
> >>> + '[' '!' ']'
> >>> + rm -rf /tmp/build/perf
> >>> + mkdir /tmp/build/perf
> >>> + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf
> >>> make: Entering directory '/git/perf-5.16.0-rc3/tools/perf'
> >>> BUILD:   Doing 'make -j32' parallel build
> >>> HOSTCC  /tmp/build/perf/fixdep.o
> >>> HOSTLD  /tmp/build/perf/fixdep-in.o
> >>> LINK    /tmp/build/perf/fixdep
> >>> /bin/sh: -c: line 0: syntax error near unexpected token `('
> >>> /bin/sh: -c: line 0: `expr bison (GNU Bison) 3.5 \>\= 371'
> >>> Makefile.config:997: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> >>> 
> >>> Auto-detecting system features:
> >>> ...                         dwarf: [ on  ]
> >>> ...            dwarf_getlocations: [ on  ]
> >>> ...                         glibc: [ on  ]
> >>> ...                        libbfd: [ on  ]
> >>> ...                libbfd-buildid: [ on  ]
> >>> ...                        libcap: [ on  ]
> >>> ...                        libelf: [ on  ]
> >>> ...                       libnuma: [ on  ]
> >>> ...        numa_num_possible_cpus: [ on  ]
> >>> ...                       libperl: [ on  ]
> >>> ...                     libpython: [ on  ]
> >>> ...                     libcrypto: [ on  ]
> >>> ...                     libunwind: [ on  ]
> >>> ...            libdw-dwarf-unwind: [ on  ]
> >>> ...                          zlib: [ on  ]
> >>> ...                          lzma: [ on  ]
> >>> ...                     get_cpuid: [ on  ]
> >>> ...                           bpf: [ on  ]
> >>> ...                        libaio: [ on  ]
> >>> ...                       libzstd: [ on  ]
> >>> ...        disassembler-four-args: [ on  ]
> >>> 
> > 
> > <SNIP>
> > 
> >>> GEN     /tmp/build/perf/util/bpf_skel/vmlinux.h
> >>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
> >>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
> >>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
> >>> CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
> >>> GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
> >>> GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> >>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> >>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> >>> libbpf: elf: skipping unrecognized data section(7) .eh_frame
> >>> libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
> >>> libbpf: map 'prev_readings': unexpected def kind var.
> >>> Error: failed to open BPF object file: Invalid argument
> >>> make[2]: *** [Makefile.perf:1076: /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h] Error 255
> >>> make[2]: *** Waiting for unfinished jobs....
> >>> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> >>> make: *** [Makefile:70: all] Error 2
> >>> make: Leaving directory '/git/perf-5.16.0-rc3/tools/perf'
> >>> + exit 1
> >>> [perfbuilder@five 32]$
> >> 
> >> Cc Andrii. 
> >> 
> >> Could you please try the fix below? 
> >> 
> >> If it doesn't work, could you please dump btf for debugging?
> >> 
> >>  bpftool btf dump file /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
> > 
> > It fixes the issue on Alpine Linux 3.12 and 3.13, Alt Linux p9 and fedora:32, probably others, still testing.
> > 
> > Can you please provide a cset commit log for me to stamp on it?
> 
> Please see the following commit log. 

This is for the other one, where I stamped this:

commit ce71038e673ee8291c64631359e56c48c8616dc7 (HEAD -> perf/urgent)
Author: Song Liu <songliubraving@fb.com>
Date:   Fri Dec 3 19:32:34 2021 +0000

    perf bpf: Fix building perf with BUILD_BPF_SKEL=1 by default in more distros

    Arnaldo reported that building all his containers with BUILD_BPF_SKEL=1
    to then make this the default he found problems in some distros where
    the system linux/bpf.h file was being used and lacked this:

       util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared identifier 'BPF_F_PRESERVE_ELEMS'
               __uint(map_flags, BPF_F_PRESERVE_ELEMS);

    So use instead the vmlinux.h file generated by bpftool from BTF info.

    This fixed these as well, getting the build back working on debian:11,
    debian:experimental and ubuntu:21.10:

      In file included from In file included from util/bpf_skel/bperf_leader.bpf.cutil/bpf_skel/bpf_prog_profiler.bpf.c::33:
      :
      In file included from In file included from /usr/include/linux/bpf.h/usr/include/linux/bpf.h::1111:
      :
      /usr/include/linux/types.h/usr/include/linux/types.h::55::1010:: In file included from  util/bpf_skel/bperf_follower.bpf.c:3fatal errorfatal error:
      : : In file included from /usr/include/linux/bpf.h:'asm/types.h' file not found11'asm/types.h' file not found:

      /usr/include/linux/types.h:5:10: fatal error: 'asm/types.h' file not found
      #include <asm/types.h>#include <asm/types.h>

               ^~~~~~~~~~~~~         ^~~~~~~~~~~~~

      #include <asm/types.h>
               ^~~~~~~~~~~~~
      1 error generated.

    Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Signed-off-by: Song Liu <song@kernel.org>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: http://lore.kernel.org/lkml/CF175681-8101-43D1-ABDB-449E644BE986@fb.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

For this patch:

diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index b8fa3cb2da230803..4a6acfde14937704 100644
--- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
-#include <linux/bpf.h>
-#include <linux/perf_event.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bperf.h"
diff --git a/tools/perf/util/bpf_skel/bperf_leader.bpf.c b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
index 4f70d1459e86cb99..40d962b05863421e 100644
--- a/tools/perf/util/bpf_skel/bperf_leader.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
-#include <linux/bpf.h>
-#include <linux/perf_event.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bperf.h"
diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
index ab12b4c4ece21a9a..97037d3b3d9fa4cd 100644
--- a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
+++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2020 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>


But what I asked now was a commit log message for this other one:

diff --git a/tools/perf/util/bpf_skel/bperf_follower.bpf.c b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
index 4a6acfde14937704..ace00ebbd8e5701f 100644
--- a/tools/perf/util/bpf_skel/bperf_follower.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_follower.bpf.c
@@ -6,8 +6,19 @@
 #include "bperf.h"
 #include "bperf_u.h"
 
-reading_map diff_readings SEC(".maps");
-reading_map accum_readings SEC(".maps");
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} diff_readings SEC(".maps");
+
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} accum_readings SEC(".maps");
 
 struct {
        __uint(type, BPF_MAP_TYPE_HASH);
diff --git a/tools/perf/util/bpf_skel/bperf_leader.bpf.c b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
index 40d962b05863421e..22ef924f8396f8e0 100644
--- a/tools/perf/util/bpf_skel/bperf_leader.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_leader.bpf.c
@@ -12,8 +12,19 @@ struct {
        __uint(map_flags, BPF_F_PRESERVE_ELEMS);
 } events SEC(".maps");
 
-reading_map prev_readings SEC(".maps");
-reading_map diff_readings SEC(".maps");
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} prev_readings SEC(".maps");
+
+struct {
+       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+       __uint(key_size, sizeof(__u32));
+       __uint(value_size, sizeof(struct bpf_perf_event_value));
+       __uint(max_entries, 1);
+} diff_readings SEC(".maps");
 
 SEC("raw_tp/sched_switch")
 int BPF_PROG(on_switch)
 
> Thanks,
> Song
> 
> ====================================== 8< ========================================
> 
> perf/bpf_skel: use vmlinux.h in skeletons
> 
> When building bpf_skel in perf on a system with older linux/bpf.h header,
> we got errors like:
> 
>    util/bpf_skel/bperf_leader.bpf.c:13:20: error: use of undeclared
>    identifier 'BPF_F_PRESERVE_ELEMS'
>            __uint(map_flags, BPF_F_PRESERVE_ELEMS);
> 
> Fix this by using vmlinux.h instead. Also remove include of perf_event.h,
> as it redefines structs in vmlinux.h.
> 
> Fixes: fa853c4b839e ("perf stat: Enable counting events for BPF programs")
> Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> 

-- 

- Arnaldo
