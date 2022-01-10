Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F83489FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiAJTEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:04:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57838 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbiAJTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:04:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55CF061371;
        Mon, 10 Jan 2022 19:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF16C36AE9;
        Mon, 10 Jan 2022 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641841449;
        bh=cdjGtgT7hFFoUrAC32QBfLrZvKnHOeTvpFGV2AAGOFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7XMICfaoJ1MVoUOhRdUcUDzBhr76wkrRK6dgRH3uWfb6zHaZM9/flUzmSvoUOPk0
         c2ozT8wl6dGVfPpbfpTQqohi+/NdXCZhe/kyiPo7uZN/M8O34FgZ3b96YKL7GY/tO9
         6Vet8VSpeA+x/0FKRLxEmOTGBCDNJGGyKj62+2SfIscXmcVFP3hqTUThOPyR83SHg1
         tI7/cunPxNR1AWWknYE2G1TZxdVJ7bDI+4FWFBUJZapDVAYtfwX14omWZ3YvdFhhSr
         TlNh4q6W0lbzg8bjDW0Fp978vbi6fmfCRWiq/QaUxYkdDWVx/hA+Ww5J/l//xG5X++
         FfcGc7CmCSysQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 101B540B92; Mon, 10 Jan 2022 16:04:08 -0300 (-03)
Date:   Mon, 10 Jan 2022 16:04:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH v4 17/48] perf cpumap: Remove cpu_map__cpu, use libperf
 function.
Message-ID: <YdyDKAZY+m0rRW2H@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-18-irogers@google.com>
 <YdyC2VdqizF6prb4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdyC2VdqizF6prb4@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 04:02:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 04, 2022 at 10:13:20PM -0800, Ian Rogers escreveu:
> > Switch the remaining few users of cpu_map__cpu to perf_cpu_map__cpu and
> > remove the function.
> > 
> > Reviewed-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> util/bpf_ftrace.c: In function ‘perf_ftrace__latency_prepare_bpf’:
> util/bpf_ftrace.c:66:31: error: implicit declaration of function ‘cpu_map__cpu’; did you mean ‘cpu_map__has’? [-Werror=implicit-function-declaration]
>    66 |                         cpu = cpu_map__cpu(ftrace->evlist->core.cpus, i);
>       |                               ^~~~~~~~~~~~
>       |                               cpu_map__has
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_ftrace.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf/ui/browsers/perf-in.o
>   LD      /tmp/build/perf/ui/perf-in.o
>   LD      /tmp/build/perf/util/scripting-engines/perf-in.o
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> 
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':
> 
>    163,635,422,196      cycles:u                                                    
>    213,602,262,800      instructions:u            #    1.31  insn per cycle         
> 
>        3.804738555 seconds time elapsed
> 
>       40.622581000 seconds user
>        6.589980000 seconds sys
> 
> 
> ⬢[acme@toolbox perf]$ git log --oneline -1
> dfe103e757aeff79 (HEAD) perf cpumap: Remove cpu_map__cpu, use libperf function.
> 
> This is the first breakage, trying to fix now.

⬢[acme@toolbox perf]$ find tools/perf/ -name "*.c" | xargs grep -w cpu_map__cpu
tools/perf/util/bpf_ftrace.c:			cpu = cpu_map__cpu(ftrace->evlist->core.cpus, i);
⬢[acme@toolbox perf]$

Only this one remaining, so just moving to perf_cpu_map__cpu() like done
elsewhere in this patch.

- Arnaldo
