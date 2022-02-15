Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4784B76EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiBOTkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:40:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiBOTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:40:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59904BF45
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:39:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84E8617A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4A5C340EB;
        Tue, 15 Feb 2022 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644953996;
        bh=hyeQFxPF4CdBXiFyXGkKykn9Hn0RKUeRFFwRPkgFI6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvCo2k3m+zr6Wn3YKEcGhk6sVbStHPLXxzDCueVOXwp04poGlb7G6ItbafR9bLfM6
         LcGLFxhmH8Tdz1I5kqwKMVw2pnABm2xjlr+2mKqlE3BoXeZsfHDGEFLOSXinrTSvPh
         kvIgDi/ySumGDb96ymjgfkQhB/4rOvbt7oFU5sXWYHJGIl0Maa83hddMbZWtL+0Lit
         UG+E+if9pp/UiYNUXu/EYYXgH5kh5OYVqoHpoqWsEX7PwaNeW8qbxQxNUV4sA4PERX
         yckWREygI+em0CnooatbSLMMJ+ZVmC7bMwYUVjO253O4wsmd6rulSV16wKLADxoIa2
         8Cere7zUIKyAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 489A1400FE; Tue, 15 Feb 2022 16:39:54 -0300 (-03)
Date:   Tue, 15 Feb 2022 16:39:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] perf intel-pt: Add support for Event Trace and TNT
 disable
Message-ID: <YgwBim6kCoOGz3rw@kernel.org>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
 <Ygu4VgqvrEyWgMqu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygu4VgqvrEyWgMqu@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 15, 2022 at 11:27:34AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 24, 2022 at 10:41:36AM +0200, Adrian Hunter escreveu:
> > Hi
> > 
> > Brief documentation is in the last patch with more technical details in
> > Intel SDM (https://www.intel.com/sdm) version 076.
> > 
> > The patches touch mostly Intel PT and auxtrace code, with a few supporting
> > changes to perf script.
> > 
> > I am not aware of any hardware that has the new capabilities yet.
> > 
> > Patches can also be found here:
> > 
> > 	https://github.com/ahunter6/linux/tree/event-trace
> > 
> 
> Thanks, applied.

So there were some problems in some compilers:

[perfbuilder@five ~]$ grep FAIL dm.log/summary
   1    51.67 almalinux:8                   : FAIL clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    28.48 alpine:3.4                    : FAIL clang version 3.8.0 (tags/RELEASE_380/final)
   3    28.89 alpine:3.5                    : FAIL clang version 3.8.1 (tags/RELEASE_381/final)
   4    30.20 alpine:3.6                    : FAIL clang version 4.0.0 (tags/RELEASE_400/final)
   5    31.39 alpine:3.7                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)
   6    31.59 alpine:3.8                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)
   7    32.90 alpine:3.9                    : FAIL gcc version 8.3.0 (Alpine 8.3.0)
   8    38.92 alpine:3.10                   : FAIL gcc version 8.3.0 (Alpine 8.3.0)
   9    43.02 alpine:3.11                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)
  10    55.58 alpine:3.12                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)
  11    59.70 alpine:3.13                   : FAIL gcc version 10.2.1 20201203 (Alpine 10.2.1_pre1)
  12    56.18 alpine:3.14                   : FAIL gcc version 10.3.1 20210424 (Alpine 10.3.1_git20210424)
  13    55.98 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027)
  14    57.38 alpine:edge                   : FAIL gcc version 11.2.1 20211128 (Alpine 11.2.1_git20211128)
  15    26.99 alt:p8                        : FAIL clang version 3.8.0 (tags/RELEASE_380/final)
  16    44.66 alt:p9                        : FAIL clang version 10.0.0
  17    44.95 alt:p10                       : FAIL clang version 11.0.1
  18    44.74 alt:sisyphus                  : FAIL gcc version 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) (GCC)
  19    27.89 amazonlinux:1                 : FAIL clang version 3.6.2 (tags/RELEASE_362/final)
  20    45.55 amazonlinux:2                 : FAIL clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  21    35.92 archlinux:base                : FAIL clang version 13.0.0
  22    37.83 centos:8                      : FAIL clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  23    51.37 centos:stream                 : FAIL clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
  25    30.89 debian:9                      : FAIL clang version 3.8.1-24 (tags/RELEASE_381/final)
  26    29.59 debian:10                     : FAIL clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  27    41.13 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
  28    47.06 debian:experimental           : FAIL gcc version 11.2.0 (Debian 11.2.0-14)
  34    29.28 fedora:23                     : FAIL clang version 3.7.0 (tags/RELEASE_370/final)
  35    38.12 fedora:24                     : FAIL clang version 3.8.1 (tags/RELEASE_381/final)
  37    33.10 fedora:25                     : FAIL clang version 3.9.1 (tags/RELEASE_391/final)
  38    40.72 fedora:26                     : FAIL clang version 4.0.1 (tags/RELEASE_401/final)
  39    35.32 fedora:27                     : FAIL clang version 5.0.2 (tags/RELEASE_502/final)
  40    38.51 fedora:28                     : FAIL clang version 6.0.1 (tags/RELEASE_601/final)
  41    40.61 fedora:29                     : FAIL clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  42    41.63 fedora:30                     : FAIL clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  43    35.51 fedora:31                     : FAIL clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  44    45.26 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  45    44.66 fedora:33                     : FAIL clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  46    46.36 fedora:34                     : FAIL clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  49    49.97 fedora:35                     : FAIL clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  50     6.78 fedora:rawhide                : FAIL gcc version 12.0.1 20220205 (Red Hat 12.0.1-0) (GCC)
  51    44.84 gentoo-stage3:latest          : FAIL clang version 13.0.0
  52    32.99 mageia:6                      : FAIL clang version 3.9.1 (tags/RELEASE_391/final)
  53    39.01 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  54    47.66 manjaro:base                  : FAIL clang version 13.0.0
  55     6.49 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC)
  56    46.54 opensuse:15.0                 : FAIL clang version 5.0.1 (tags/RELEASE_501/final 312548)
  57    48.74 opensuse:15.1                 : FAIL clang version 7.0.1 (tags/RELEASE_701/final 349238)
  58    54.96 opensuse:15.2                 : FAIL clang version 9.0.1
  59    67.79 opensuse:15.3                 : FAIL clang version 11.0.1
  60    67.69 opensuse:15.4                 : FAIL clang version 11.0.1
  61    75.25 opensuse:tumbleweed           : FAIL clang version 13.0.0
  62    50.15 oraclelinux:8                 : FAIL clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  63    56.68 rockylinux:8                  : FAIL clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  64    38.11 ubuntu:16.04                  : FAIL clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  71    38.11 ubuntu:18.04                  : FAIL clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  82    41.43 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1
  84    30.21 ubuntu:20.10                  : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.10)
  85    39.23 ubuntu:21.04                  : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
  86     1.07 ubuntu:21.04-x-mips64         : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
  87    40.23 ubuntu:21.10                  : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-7ubuntu2)
  88    52.77 ubuntu:22.04                  : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-14ubuntu1)
[perfbuilder@five ~]$

:-)

Sometimes its clang, sometimes its gcc, but mostly is this:

[perfbuilder@five ~]$ tail -25 dm.log/ubuntu\:22.04
  LD      /tmp/build/perf/util/arm-spe-decoder/perf-in.o
  CC      /tmp/build/perf/util/clockid.o
  CC      /tmp/build/perf/util/list_sort.o
  CC      /tmp/build/perf/util/bpf-loader.o
util/intel-pt.c:2213:31: error: field 'cfe' with variable sized type 'struct perf_synth_intel_evt' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
                struct perf_synth_intel_evt cfe;
                                            ^
  CC      /tmp/build/perf/util/bpf_map.o
  CC      /tmp/build/perf/util/bpf-prologue.o
  CC      /tmp/build/perf/util/symbol-elf.o
1 error generated.
  CC      /tmp/build/perf/util/probe-file.o
make[4]: *** [/git/perf-5.17.0-rc3/tools/build/Makefile.build:97: /tmp/build/perf/util/intel-pt.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/libbpf/libbpf.a
  LD      /tmp/build/perf/util/scripting-engines/perf-in.o
  LD      /tmp/build/perf/util/intel-pt-decoder/perf-in.o
make[3]: *** [/git/perf-5.17.0-rc3/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-5.17.0-rc3/tools/perf'
+ exit 1
[perfbuilder@five ~]$[perfbuilder@five ~]$ tail -25 dm.log/ubuntu\:22.04
  LD      /tmp/build/perf/util/arm-spe-decoder/perf-in.o
  CC      /tmp/build/perf/util/clockid.o
  CC      /tmp/build/perf/util/list_sort.o
  CC      /tmp/build/perf/util/bpf-loader.o
util/intel-pt.c:2213:31: error: field 'cfe' with variable sized type 'struct perf_synth_intel_evt' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
                struct perf_synth_intel_evt cfe;
                                            ^
  CC      /tmp/build/perf/util/bpf_map.o
  CC      /tmp/build/perf/util/bpf-prologue.o
  CC      /tmp/build/perf/util/symbol-elf.o
1 error generated.
  CC      /tmp/build/perf/util/probe-file.o
make[4]: *** [/git/perf-5.17.0-rc3/tools/build/Makefile.build:97: /tmp/build/perf/util/intel-pt.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/build/perf/libbpf/libbpf.a
  LD      /tmp/build/perf/util/scripting-engines/perf-in.o
  LD      /tmp/build/perf/util/intel-pt-decoder/perf-in.o
make[3]: *** [/git/perf-5.17.0-rc3/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-5.17.0-rc3/tools/perf'
+ exit 1
[perfbuilder@five ~]$

I'm trying to fix this now, lets see...

- Arnaldo


>  
> > Adrian Hunter (25):
> >       perf intel-pt: pkt-decoder-test: Fix scope of test_data
> >       perf intel-pt: pkt-decoder: Remove misplaced linebreak
> >       perf intel-pt: pkt-decoder: Add CFE and EVD packets
> >       perf intel-pt: pkt-decoder: Add MODE.Exec IFLAG bit
> >       perf intel-pt: decoder: Add config bit definitions
> >       perf intel-pt: decoder: Factor out clearing of FUP event variables
> >       perf intel-pt: decoder: Add CFE and EVD processing
> >       perf intel-pt: decoder: Add MODE.Exec IFLAG processing
> >       perf tools: Define Intel PT CFE / EVD event
> >       perf tools: Define Intel PT iflag synthesized event
> >       perf tools: Define new D and t flags
> >       perf auxtrace: Add itrace option "I"
> >       perf intel-pt: Record Event Trace capability flag
> >       perf intel-pt: Synthesize CFE / EVD event
> >       perf intel-pt: Synthesize iflag event
> >       perf intel-pt: Synthesize new D and t flags
> >       perf intel-pt: Force 'quick' mode when TNT is disabled
> >       perf script: Display Intel PT CFE / EVD synthesized event
> >       perf script: Display Intel PT iflag synthesized event
> >       perf script: Display new D and t flags
> >       perf scripts python: intel-pt-events.py: Add Event Trace
> >       perf scripting python: Add all sample flags to DB export
> >       perf scripts python: export-to-sqlite.py: Export all sample flags
> >       perf scripts python: export-to-postgresql.py: Export all sample flags
> >       perf intel-pt: Add documentation for Event Trace and TNT disable
> > 
> >  tools/perf/Documentation/itrace.txt                |   2 +
> >  tools/perf/Documentation/perf-intel-pt.txt         | 104 ++++++++-
> >  tools/perf/Documentation/perf-script.txt           |  13 +-
> >  .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |  17 +-
> >  tools/perf/arch/x86/util/intel-pt.c                |   7 +
> >  tools/perf/builtin-script.c                        |  78 ++++++-
> >  tools/perf/scripts/python/export-to-postgresql.py  |  17 +-
> >  tools/perf/scripts/python/export-to-sqlite.py      |  19 +-
> >  tools/perf/scripts/python/intel-pt-events.py       |  55 ++++-
> >  tools/perf/util/auxtrace.c                         |   4 +
> >  tools/perf/util/auxtrace.h                         |   4 +
> >  tools/perf/util/event.h                            |  45 +++-
> >  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 245 +++++++++++++++++++--
> >  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  21 ++
> >  .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  47 +++-
> >  .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |   3 +
> >  tools/perf/util/intel-pt.c                         | 164 +++++++++++++-
> >  .../util/scripting-engines/trace-event-python.c    |   3 +-
> >  18 files changed, 779 insertions(+), 69 deletions(-)
> > 
> > 
> > Regards
> > Adrian
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
