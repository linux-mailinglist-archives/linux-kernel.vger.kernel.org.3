Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906064733EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhLMSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhLMSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:24:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C7CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:24:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BC50B811E4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F23C34602;
        Mon, 13 Dec 2021 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639419852;
        bh=wVdnHLDh7WlOdER9MCi8u65E4BnXbGUKu4PzTAiRfkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQg1UZSTCdOnsHZJU7d18k3QNTTRrWeHQAStt7Hjo1TpTXlTjesrCoqKnQ+l/1c5L
         ANXRwAoXR+QsJE5nQqEw3ds5e66c7bRSntVznTjicMlgFGvcKh+EoYozOrfBbB9mV0
         53zNbJG4pEO9ExfFpkywjFncRp1MRUjFoYX40xF6QOw+czl3ykhiu6sR0y3woFlo5z
         0tqJhzyNu60aRfBaKfr1Ol6cmzZ8kmUTlvhRRKhZ8akB9qUOvIKHQ4/drESwYR48x8
         6ZdJyBfQuB10p279T530yM2bGY1WLExSp96hDYalQ46iYUFKUreK3mrs+fmTv+IzUN
         snbEcbuv3TKjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71683405D8; Mon, 13 Dec 2021 15:24:10 -0300 (-03)
Date:   Mon, 13 Dec 2021 15:24:10 -0300
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
Message-ID: <YbePytGwg9Kb7hT1@kernel.org>
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

This still applies cleanly, I'll test it later.

- Arnaldo
 
> To handle new subcommands, the existing functionality is moved to
> 'trace' subcommand while preserving backward compatibility of not
> having a subcommand at all (defaults to 'trace').
> 
> The latency subcommand accepts a target (kernel, for now) function
> with -T option and shows a histogram like below:
> 
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
