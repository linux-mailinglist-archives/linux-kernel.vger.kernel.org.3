Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434E04836D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiACSaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:30:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47888 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiACSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B98C6B80EA6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 18:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30322C36AED;
        Mon,  3 Jan 2022 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641234609;
        bh=JiJ0kRlEDD23EMwuCEQ3RdEGZ5EoU6/izItJCJbfS5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCxbeCGOejN8kk255FoHH7xFSA4ow5a26t2gzCTRSqYjn3MkXnFVKJvVgDRvTYKyR
         vtf6LUzz/Y3f1pf9hNGyEFYhrZY3P+gyMDDNbyHe9XrX+hwAMr6GnoC5caiq772Cnh
         iEHtwm0XYx8j5o7dW8P+YMdxgZk+s6qzuYBQALAv6NsBiJcZ/BVXj+UmmjtbnueleS
         BZhigt5L+3kYrWKfLA0NzbjlpKSbVEhR9nUvvRvaDZPiz3vgEZK9X6kuIr+tTEcQb5
         xPuyHTSFH9yFedPjbSK9KsjL1hznreCxxMnBX71zDl+f84DsavC+IpBItTYSspJ5j1
         vtY9cGyauOspw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2DA3D40B92; Mon,  3 Jan 2022 15:30:07 -0300 (-03)
Date:   Mon, 3 Jan 2022 15:30:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>, chang.seok.bae@intel.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/6] x86/insn: Add instructions to instruction decoder
Message-ID: <YdNArxYU25LfrS52@kernel.org>
References: <20211202095029.2165714-1-adrian.hunter@intel.com>
 <20211223153808.cddab56b114e5ddf755bd2d0@kernel.org>
 <c5737eb6-383b-13ea-20d1-af597c69a21d@intel.com>
 <YdMOiFDdEny4Jicc@kernel.org>
 <YdMP5vmU+uqMz04d@kernel.org>
 <c7ac518e-82fb-eb51-7778-5e9b1aaed9a9@intel.com>
 <YdM/A3pWcQi87DbT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdM/A3pWcQi87DbT@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 03, 2022 at 03:22:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 03, 2022 at 05:40:00PM +0200, Adrian Hunter escreveu:
> > On 03/01/2022 17:01, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Jan 03, 2022 at 11:56:08AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > So since this needs rebasing, could you please split it into two
> > > patchsets, one for tools/ and another for arch and send two batches?
> > > This way I'll pick the tools/ one, the x86 maintainers the other bits.

> > > Otherwise the x86 maintainers would have to test if the tools/ bits
> > > works as expected, etc.

> > It seems not to be happening for me.  What tree/branch is it?

> tmp.perf/core

> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core

> I merged torvalds/master today, but it should work as that file was last
> changed looong ago:

> ⬢[acme@toolbox perf]$ git log arch/x86/lib/x86-opcode-map.txt | head
> commit 5790921bc18b1eb5c0c61371e31114fd4c4b0154
> Author: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Date:   Tue Feb 4 09:14:24 2020 -0800
> 
>     x86/insn: Add Control-flow Enforcement (CET) instructions to the opcode map
> 
>     Add the following CET instructions to the opcode map:
> 
>     INCSSP:
>         Increment Shadow Stack pointer (SSP).
> ⬢[acme@toolbox perf]$
> 
> Perhaps related to b4? I'll try updating it and retrying...

Now it should work:

⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers c7ac518e-82fb-eb51-7778-5e9b1aaed9a9@intel.com
<SNIP>
Cover: ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.cover
 Link: https://lore.kernel.org/r/20211202095029.2165714-1-adrian.hunter@intel.com
 Base: applies clean to current tree
       git checkout -b 20211202_adrian_hunter_intel_com HEAD
       git am ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.mbx
⬢[acme@toolbox perf]$

Lets see...

⬢[acme@toolbox perf]$        git am ./20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.mbx
Applying: perf tests: Add AMX instructions to x86 instruction decoder test
Applying: x86/insn: Add AMX instructions to x86 instruction decoder
Applying: perf tests: Add misc instructions to x86 instruction decoder test
Applying: x86/insn: Add misc instructions to x86 instruction decoder
Applying: perf tests: Add AVX512-FP16 instructions to x86 instruction decoder test
Applying: x86/insn: Add AVX512-FP16 instructions to x86 instruction decoder
⬢[acme@toolbox perf]$

Yeah, it works, builds and the 'perf test instr' test case succeeds, so
if Peter or Borislav so wishes please process this patchkit as-is:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

But please consider sending separate patchkits in the future, one for
kernel stuff, the other for tools/.

Thanks,

- Arnaldo

⬢[acme@toolbox perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ;
⬢[acme@toolbox perf]$ m
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  /tmp/build/perf/fixdep.o
  HOSTLD  /tmp/build/perf/fixdep-in.o
  LINK    /tmp/build/perf/fixdep
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

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
  CC      /tmp/build/perf/help.o
  CC      /tmp/build/perf/pager.o
  CC      /tmp/build/perf/parse-options.o
  CC      /tmp/build/perf/sigchain.o
  CC      /tmp/build/perf/exec-cmd.o
  PERF_VERSION = 5.16.rc8.g0f0a5b2d75a4
<SNIP>
  CC      /tmp/build/perf/util/thread-stack.o
  CC      /tmp/build/perf/util/intel-pt.o
  CC      /tmp/build/perf/util/arm-spe.o
  MKDIR   /tmp/build/perf/util/arm-spe-decoder/
  MKDIR   /tmp/build/perf/util/intel-pt-decoder/
  MKDIR   /tmp/build/perf/util/intel-pt-decoder/
  CC      /tmp/build/perf/util/s390-cpumsf.o
  CC      /tmp/build/perf/util/parse-branch-options.o
  MKDIR   /tmp/build/perf/util/intel-pt-decoder/
  MKDIR   /tmp/build/perf/util/cs-etm-decoder/
  CC      /tmp/build/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC      /tmp/build/perf/util/dump-insn.o
  CC      /tmp/build/perf/util/cs-etm.o
  CC      /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN     /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
  MKDIR   /tmp/build/perf/util/intel-pt-decoder/
  CC      /tmp/build/perf/util/parse-sublevel-options.o
  CC      /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
  CC      /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC      /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
<SNIP>
  LD      /tmp/build/perf/util/intel-pt-decoder/perf-in.o
<SNIP>
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

    59,896,945,805      cycles:u
    54,732,597,938      instructions:u            #    0.91  insn per cycle

      17.699684374 seconds time elapsed

      14.750269000 seconds user
      12.750256000 seconds sys


On branch perf/core
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.cover
	20211202_adrian_hunter_x86_insn_add_instructions_to_instruction_decoder.mbx

nothing added to commit but untracked files present (use "git add" to track)
 19: 'import perf' in python                                         : Ok
⬢[acme@toolbox perf]$ perf test instr
 76: x86 instruction decoder - new instructions                      : Ok
⬢[acme@toolbox perf]$


