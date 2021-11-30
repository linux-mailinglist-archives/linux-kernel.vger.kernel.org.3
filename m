Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098B54636DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhK3Okv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:40:51 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53216 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhK3Okv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:40:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4C7DCE1A11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7A8C53FC7;
        Tue, 30 Nov 2021 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283048;
        bh=T7blJkqLvOnx1FPZFpLlvacS3TAs1x9CjmzocANC1kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgwIK1Mgl65ku+j8glBWwUMSC9GV2TLel76URMZuEAUZ6IZTLSsQQcvGaC3mcNbhZ
         UMGfziQgC207Q1WcO4agROzaZWfXqcs2mdpyQ/tYbvKSbMcou9nhtlU1Bzh4TLpgYU
         p1XvcSjHfAi02qw4KC6/x6wg3eAvmXNyOSTtEIq6z9osteGpNKZYcoCRPPz2k2VQeg
         plxu/JlgZqgRixB3/dp/Drz0XPIPp4zzruOvAWKRLeRaScCKFSnpMsy3IVNpduT2wA
         D4IbcrVKoVlKoDhaA/zxS2MiEnBVi0zrxpOUjP6XUfzLcPf69mo9/RtsRnq7hwQ+eD
         gexrGyH+wNh9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 79C4440002; Tue, 30 Nov 2021 11:37:26 -0300 (-03)
Date:   Tue, 30 Nov 2021 11:37:26 -0300
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
Message-ID: <YaY3JqOQ2XE22VId@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129231830.1117781-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> I've implemented 'latency' subcommand in the perf ftrace command to
> show a histogram of function latency.
> 
> To handle new subcommands, the existing functionality is moved to
> 'trace' subcommand while preserving backward compatibility of not
> having a subcommand at all (defaults to 'trace').
> 
> The latency subcommand accepts a target (kernel, for now) function
> with -T option and shows a histogram like below:

Humm, wouldn't be interesting to shorten this by having a new 'perf
flat' (function latency) tool, on the same level as 'perf ftrace' and
leave 'perf ftrace' to just being a convenient perf interface to what
ftrace provides?

But all around, nice work, cool new toyz! :-)

- Arnaldo
 
>   $ sudo ./perf ftrace latency -a -T mutex_lock sleep 1
>   #   DURATION     |      COUNT | GRAPH                                          |
>        0 - 1    us |       2686 | ######################                         |
>        1 - 2    us |        976 | ########                                       |
>        2 - 4    us |        879 | #######                                        |
>        4 - 8    us |        481 | ####                                           |
>        8 - 16   us |        445 | ###                                            |
>       16 - 32   us |          1 |                                                |
>       32 - 64   us |          0 |                                                |
>       64 - 128  us |          0 |                                                |
>      128 - 256  us |          0 |                                                |
>      256 - 512  us |          0 |                                                |
>      512 - 1024 us |          0 |                                                |
>        1 - 2    ms |          0 |                                                |
>        2 - 4    ms |          0 |                                                |
>        4 - 8    ms |          0 |                                                |
>        8 - 16   ms |          0 |                                                |
>       16 - 32   ms |          0 |                                                |
>       32 - 64   ms |          0 |                                                |
>       64 - 128  ms |          0 |                                                |
>      128 - 256  ms |          0 |                                                |
>      256 - 512  ms |          0 |                                                |
>      512 - 1024 ms |          0 |                                                |
>        1 - ...   s |          0 |                                                |
>   
> It basically use the function graph tracer to extract the duration of
> the function.  But with -b/--use-bpf option, it can use BPF to save
> the histogram in the kernel.  For the same function, it gets:
> 
>   $ sudo ./perf ftrace latency -a -b -T mutex_lock sleep 1
>   #   DURATION     |      COUNT | GRAPH                                          |
>        0 - 1    us |       4682 | #############################################  |
>        1 - 2    us |         11 |                                                |
>        2 - 4    us |          0 |                                                |
>        4 - 8    us |          0 |                                                |
>        8 - 16   us |          7 |                                                |
>       16 - 32   us |          6 |                                                |
>       32 - 64   us |          0 |                                                |
>       64 - 128  us |          0 |                                                |
>      128 - 256  us |          0 |                                                |
>      256 - 512  us |          0 |                                                |
>      512 - 1024 us |          0 |                                                |
>        1 - 2    ms |          0 |                                                |
>        2 - 4    ms |          0 |                                                |
>        4 - 8    ms |          0 |                                                |
>        8 - 16   ms |          0 |                                                |
>       16 - 32   ms |          0 |                                                |
>       32 - 64   ms |          0 |                                                |
>       64 - 128  ms |          0 |                                                |
>      128 - 256  ms |          0 |                                                |
>      256 - 512  ms |          0 |                                                |
>      512 - 1024 ms |          0 |                                                |
>        1 - ...   s |          0 |                                                |
> 
> 
> You can get the patches at 'perf/ftrace-latency-v1' branch on
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (5):
>   perf ftrace: Add 'trace' subcommand
>   perf ftrace: Move out common code from __cmd_ftrace
>   perf ftrace: Add 'latency' subcommand
>   perf ftrace: Add -b/--use-bpf option for latency subcommand
>   perf ftrace: Implement cpu and task filters in BPF
> 
>  tools/perf/Makefile.perf                    |   2 +-
>  tools/perf/builtin-ftrace.c                 | 443 +++++++++++++++++---
>  tools/perf/util/Build                       |   1 +
>  tools/perf/util/bpf_ftrace.c                | 154 +++++++
>  tools/perf/util/bpf_skel/func_latency.bpf.c | 113 +++++
>  tools/perf/util/ftrace.h                    |  81 ++++
>  6 files changed, 724 insertions(+), 70 deletions(-)
>  create mode 100644 tools/perf/util/bpf_ftrace.c
>  create mode 100644 tools/perf/util/bpf_skel/func_latency.bpf.c
>  create mode 100644 tools/perf/util/ftrace.h
> 
> 
> base-commit: 8ab774587903771821b59471cc723bba6d893942
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog

-- 

- Arnaldo
