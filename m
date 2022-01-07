Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB584878F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347768AbiAGO2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:28:02 -0500
Received: from foss.arm.com ([217.140.110.172]:41138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347615AbiAGO2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:28:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 486BA13A1;
        Fri,  7 Jan 2022 06:28:01 -0800 (PST)
Received: from [10.57.38.163] (unknown [10.57.38.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2B943F774;
        Fri,  7 Jan 2022 06:27:58 -0800 (PST)
Subject: Re: [PATCH v1] perf synthetic-events: Return error if procfs isn't
 mounted for PID namespaces
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20211224124014.2492751-1-leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
Message-ID: <e5f242c4-fe64-e214-4b28-c99af684751a@arm.com>
Date:   Fri, 7 Jan 2022 14:27:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211224124014.2492751-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/12/2021 12:40, Leo Yan wrote:
> For perf recording, it retrieves process info by iterating nodes in proc
> fs.  If we run perf in a non-root PID namespace with command:
> 
>   # unshare --fork --pid perf record -e cycles -a -- test_program
> 
> ... in this case, unshare command creates a child PID namespace and
> launches perf tool in it, but the issue is the proc fs is not mounted
> for the non-root PID namespace, this leads to the perf tool gathering
> process info from its parent PID namespace.
> 

I had some concerns that this would prevent use of perf in docker, but docker
does mount /proc so it is still working. And you've added a warning about how
to fix the unshare command so I think this is ok.

Reviewed-by: James Clark <james.clark@arm.com>

> We can use below command to observe the process nodes under proc fs:
> 
>   # unshare --pid --fork ls /proc
> 1    137   1968  2128  3    342  48  62   78	     crypto	  kcore        net	      uptime
> 10   138   2	 2142  30   35	 49  63   8	     devices	  keys	       pagetypeinfo   version
> 11   139   20	 2143  304  36	 50  64   82	     device-tree  key-users    partitions     vmallocinfo
> 12   14    2011  22    305  37	 51  65   83	     diskstats	  kmsg	       self	      vmstat
> 128  140   2038  23    307  39	 52  656  84	     driver	  kpagecgroup  slabinfo       zoneinfo
> 129  15    2074  24    309  4	 53  67   9	     execdomains  kpagecount   softirqs
> 13   16    2094  241   31   40	 54  68   asound     fb		  kpageflags   stat
> 130  164   2096  242   310  41	 55  69   buddyinfo  filesystems  loadavg      swaps
> 131  17    2098  25    317  42	 56  70   bus	     fs		  locks        sys
> 132  175   21	 26    32   43	 57  71   cgroups    interrupts   meminfo      sysrq-trigger
> 133  179   2102  263   329  44	 58  75   cmdline    iomem	  misc	       sysvipc
> 134  1875  2103  27    330  45	 59  76   config.gz  ioports	  modules      thread-self
> 135  19    2117  29    333  46	 6   77   consoles   irq	  mounts       timer_list
> 136  1941  2121  298   34   47	 60  773  cpuinfo    kallsyms	  mtd	       tty
> 
> So it shows many existed tasks, since unshared command has not mounted
> the proc fs for the new created PID namespace, it still accesses the
> proc fs of the root PID namespace.  This leads to two prominent issues:
> 
> - Firstly, PID values are mismatched between thread info and samples.
>   The gathered thread info are coming from the proc fs of the root PID
>   namespace, but samples record its PID from the child PID namespace.
> 
> - The second issue is profiled program 'test_program' returns its forked
>   PID number from the child PID namespace, perf tool wrongly uses this
>   PID number to retrieve the process info via the proc fs of the root
>   PID namespace.
> 
> To avoid issues, we need to mount proc fs for the child PID namespace
> with the option '--mount-proc' when use unshare command:
> 
>   # unshare --fork --pid --mount-proc perf record -e cycles -a -- test_program
> 
> Conversely, when the proc fs of the root PID namespace is used by child
> namespace, perf tool can detect the multiple PID levels and
> nsinfo__is_in_root_namespace() returns false, this patch reports error
> for this case:
> 
>   # unshare --fork --pid perf record -e cycles -a -- test_program
>   Couldn't synthesize bpf events.
>   Perf runs in non-root PID namespace but it tries to gather process info from its parent PID namespace.
>   Please mount the proc file system properly, e.g. add the option '--mount-proc' for unshare command.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/synthetic-events.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 198982109f0f..cf7800347f77 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1784,6 +1784,25 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
>  				  perf_event__handler_t process, bool needs_mmap,
>  				  bool data_mmap, unsigned int nr_threads_synthesize)
>  {
> +	/*
> +	 * When perf runs in non-root PID namespace, and the namespace's proc FS
> +	 * is not mounted, nsinfo__is_in_root_namespace() returns false.
> +	 * In this case, the proc FS is coming for the parent namespace, thus
> +	 * perf tool will wrongly gather process info from its parent PID
> +	 * namespace.
> +	 *
> +	 * To avoid the confusion that the perf tool runs in a child PID
> +	 * namespace but it synthesizes thread info from its parent PID
> +	 * namespace, returns failure with warning.
> +	 */
> +	if (!nsinfo__is_in_root_namespace()) {
> +		pr_err("Perf runs in non-root PID namespace but it tries to ");
> +		pr_err("gather process info from its parent PID namespace.\n");
> +		pr_err("Please mount the proc file system properly, e.g. ");
> +		pr_err("add the option '--mount-proc' for unshare command.\n");
> +		return -EPERM;
> +	}
> +
>  	if (target__has_task(target))
>  		return perf_event__synthesize_thread_map(tool, threads, process, machine,
>  							 needs_mmap, data_mmap);
> 
