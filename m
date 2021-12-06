Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C994695BB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbhLFMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhLFMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:35:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217ECC061746;
        Mon,  6 Dec 2021 04:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30F06125E;
        Mon,  6 Dec 2021 12:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C054DC341C2;
        Mon,  6 Dec 2021 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638793930;
        bh=IsBVq/q1SpfkA1RRdDzcVSDxiaH4krriVfQsPwvc9Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXp8Dal4o2cRR+UcxRUJRUPeDxUT8RqQ5y7JgQxf0BdnmDm7lzwzLhFiA4NzjCi1g
         aCZYc73ZV5sYAlcR+RuAUpqLK/0PA4knSRAOhO2p+EuY8d65B+jMqp3zIMTNTBGRHo
         IGW7rqbe4DVmNASF3cVrv+Zg5pYGwzugVgWi8ZhiwKLJYDiVHb0JKEzgu6HnNIY3Do
         4RTZ3/7ubelVIINxL4MAbtg9bBd/ShSfRAbD6cEk5DJjsC43AywvxmQjxDNcj8VI+k
         UmbqLcKk1Xsus733QmQ3UoR4NVEWzNUf8Vb8uuQuFirOcAdeZy89mCLRRCt6UU7fqb
         swIXwpk/Zu4cQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4346640002; Mon,  6 Dec 2021 09:32:06 -0300 (-03)
Date:   Mon, 6 Dec 2021 09:32:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Message-ID: <Ya4CxsyoyFQVFzoi@kernel.org>
References: <YaoXUrLUZt1scVb0@kernel.org>
 <YaobYKgrTV1Bthi0@kernel.org>
 <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 03, 2021 at 08:05:59PM +0000, Song Liu escreveu:
> > On Dec 3, 2021, at 5:28 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > The failure for fedora:32, which seems to be on the threshold for clang
> > to be considered recent enough for building skels fails differently:

> > clang version 10.0.1 (Fedora 10.0.1-3.fc32)
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> > Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> > Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> > Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> > Candidate multilib: .;@m64
> > Candidate multilib: 32;@m32
> > Selected multilib: .;@m64
> > + '[' '!' ']'
> > + rm -rf /tmp/build/perf
> > + mkdir /tmp/build/perf
> > + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf
> > make: Entering directory '/git/perf-5.16.0-rc3/tools/perf'
> >  BUILD:   Doing 'make -j32' parallel build
> >  HOSTCC  /tmp/build/perf/fixdep.o
> >  HOSTLD  /tmp/build/perf/fixdep-in.o
> >  LINK    /tmp/build/perf/fixdep
> > /bin/sh: -c: line 0: syntax error near unexpected token `('
> > /bin/sh: -c: line 0: `expr bison (GNU Bison) 3.5 \>\= 371'
> > Makefile.config:997: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > 
> > Auto-detecting system features:
> > ...                         dwarf: [ on  ]
> > ...            dwarf_getlocations: [ on  ]
> > ...                         glibc: [ on  ]
> > ...                        libbfd: [ on  ]
> > ...                libbfd-buildid: [ on  ]
> > ...                        libcap: [ on  ]
> > ...                        libelf: [ on  ]
> > ...                       libnuma: [ on  ]
> > ...        numa_num_possible_cpus: [ on  ]
> > ...                       libperl: [ on  ]
> > ...                     libpython: [ on  ]
> > ...                     libcrypto: [ on  ]
> > ...                     libunwind: [ on  ]
> > ...            libdw-dwarf-unwind: [ on  ]
> > ...                          zlib: [ on  ]
> > ...                          lzma: [ on  ]
> > ...                     get_cpuid: [ on  ]
> > ...                           bpf: [ on  ]
> > ...                        libaio: [ on  ]
> > ...                       libzstd: [ on  ]
> > ...        disassembler-four-args: [ on  ]
> > 

<SNIP>

> >  GEN     /tmp/build/perf/util/bpf_skel/vmlinux.h
> >  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
> >  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
> >  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
> >  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
> >  GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
> >  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> > libbpf: elf: skipping unrecognized data section(9) .eh_frame
> > libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_frame
> > libbpf: elf: skipping unrecognized data section(7) .eh_frame
> > libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
> > libbpf: map 'prev_readings': unexpected def kind var.
> > Error: failed to open BPF object file: Invalid argument
> > make[2]: *** [Makefile.perf:1076: /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h] Error 255
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [Makefile.perf:240: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > make: Leaving directory '/git/perf-5.16.0-rc3/tools/perf'
> > + exit 1
> > [perfbuilder@five 32]$
> 
> Cc Andrii. 
> 
> Could you please try the fix below? 
> 
> If it doesn't work, could you please dump btf for debugging?
> 
>   bpftool btf dump file /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o

It fixes the issue on Alpine Linux 3.12 and 3.13, Alt Linux p9 and fedora:32, probably others, still testing.

Can you please provide a cset commit log for me to stamp on it?

- Arnaldo
 
> Thanks,
> Song
> 
> 
> 
> 
> diff --git i/tools/perf/util/bpf_skel/bperf_follower.bpf.c w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> index 4a6acfde14937..bd191c9bc49bc 100644
> --- i/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> +++ w/tools/perf/util/bpf_skel/bperf_follower.bpf.c
> @@ -6,8 +6,19 @@
>  #include "bperf.h"
>  #include "bperf_u.h"
> 
> -reading_map diff_readings SEC(".maps");
> -reading_map accum_readings SEC(".maps");
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(struct bpf_perf_event_value));
> +       __uint(max_entries, 1);
> +} diff_readings SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(struct bpf_perf_event_value));
> +       __uint(max_entries, 1);
> +} accum_readings SEC(".maps");
> 
>  struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
> diff --git i/tools/perf/util/bpf_skel/bperf_leader.bpf.c w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> index 40d962b058634..d52a335e63f0f 100644
> --- i/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> +++ w/tools/perf/util/bpf_skel/bperf_leader.bpf.c
> @@ -12,8 +12,19 @@ struct {
>         __uint(map_flags, BPF_F_PRESERVE_ELEMS);
>  } events SEC(".maps");
> 
> -reading_map prev_readings SEC(".maps");
> -reading_map diff_readings SEC(".maps");
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(struct bpf_perf_event_value));
> +       __uint(max_entries, 1);
> +} prev_readings SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(struct bpf_perf_event_value));
> +       __uint(max_entries, 1);
> +} diff_readings SEC(".maps");
> 
>  SEC("raw_tp/sched_switch")
>  int BPF_PROG(on_switch)
