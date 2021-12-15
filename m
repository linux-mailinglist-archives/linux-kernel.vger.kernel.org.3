Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33346475C40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbhLOPv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbhLOPvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:51:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06DEC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9408661866
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42A8C340F3;
        Wed, 15 Dec 2021 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639582215;
        bh=1Xfg/+XPyCv0/mU3wm87ixMAPiT8GzAvakRuzAp09iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aa/AW8q+gzdHT/wWCoXCG7UyjWjCgVU2pZBQoAHCm1HliIkDDfgztFgyOGYqnhqlk
         8BOslERkTQH+YcKnK/en4GdeOEQ81yzd1W3RMR/0GshZawHS5v6ksboFXOutDhS6i3
         /u06jJ7kvnXxVcLnHztcR3Cr+IWZT8kbLlclJlm08XBvviHoTvg+PVdue82po4Ivm3
         0N6nAzdHj4ivbR+FQ3S8dGrYtomN4MWDZxD1Gv/gkpQ5joKCGRy1ohSBjV5P7B82MO
         Fdn4pcEXIYQMEOZhJHGY7PhER0RYWoc/rP1FVwTZ1W6GLnl4mZ+vJOQQO83xtzZkjq
         gQj2AAsWG2SXg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D3DE405D8; Wed, 15 Dec 2021 12:30:10 -0300 (-03)
Date:   Wed, 15 Dec 2021 12:30:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
Message-ID: <YboKAvgX7SIiUcoN@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
 <YbePytGwg9Kb7hT1@kernel.org>
 <CAM9d7ciqzb4CArnzMf20x7XccwvmPSzCdk3w7Hhu=qg9TuD4vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciqzb4CArnzMf20x7XccwvmPSzCdk3w7Hhu=qg9TuD4vw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 13, 2021 at 11:40:16AM -0800, Namhyung Kim escreveu:
> On Mon, Dec 13, 2021 at 10:24 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > > Hello,
> > >
> > > I've implemented 'latency' subcommand in the perf ftrace command to
> > > show a histogram of function latency.
> >
> > This still applies cleanly, I'll test it later.
> 
> Thank you Arnaldo!  While I have some small modifications
> but the functionality should be the same.  Please let me know
> if you have any suggestions.

So, it is failing here with:

⬢[acme@toolbox perf]$ m
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  CC      /tmp/build/perf/perf-read-vdso32
  LINK    /tmp/build/perf/libperf-jvmti.so
make[3]: Nothing to be done for 'install_headers'.
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/func_latency.bpf.o
  DESCEND plugins
  PERF_VERSION = 5.16.rc5.g6924c0713d69
  GEN     perf-archive
  GEN     perf-with-kcore
  GEN     perf-iostat
  GEN     /tmp/build/perf/python/perf.so
  INSTALL trace_plugins
  GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
  CC      /tmp/build/perf/builtin-ftrace.o
  CC      /tmp/build/perf/util/header.o
  CC      /tmp/build/perf/util/bpf_ftrace.o
util/bpf_ftrace.c: In function ‘perf_ftrace__latency_prepare_bpf’:
util/bpf_ftrace.c:18:13: error: unused variable ‘fd’ [-Werror=unused-variable]
   18 |         int fd, err;
      |             ^~
util/bpf_ftrace.c: In function ‘perf_ftrace__latency_read_bpf’:
util/bpf_ftrace.c:86:21: error: implicit declaration of function ‘cpu__max_cpu’ [-Werror=implicit-function-declaration]
   86 |         int ncpus = cpu__max_cpu();
      |                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_ftrace.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

     8,018,756,380      cycles:u
    14,452,278,281      instructions:u            #    1.80  insn per cycle

       2.250520538 seconds time elapsed

       1.834706000 seconds user
       0.876410000 seconds sys


⬢[acme@toolbox perf]$

⬢[acme@toolbox perf]$ git log --oneline -5
6924c0713d691a6f (HEAD) perf ftrace: Add -b/--use-bpf option for latency subcommand
c96f789bf6313259 perf ftrace: Add 'latency' subcommand
0c5041e1141b53d3 perf ftrace: Move out common code from __cmd_ftrace
8b4a91a9a0b4fbf6 perf ftrace: Add 'trace' subcommand
6bf2efd9d99f3a14 perf arch: Support register names from all archs
⬢[acme@toolbox perf]$

Fixed with:


diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 1975a6fe73c9fa8b..f5b49fc056ab8b95 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 
+#include "util/cpumap.h"
 #include "util/ftrace.h"
 #include "util/debug.h"
 #include "util/bpf_counter.h"
@@ -15,7 +16,7 @@ static struct func_latency_bpf *skel;
 
 int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 {
-	int fd, err;
+	int err;
 	struct filter_entry *func;
 	struct bpf_link *begin_link, *end_link;
 
