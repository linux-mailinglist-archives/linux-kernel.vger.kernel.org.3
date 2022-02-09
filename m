Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38484AF5B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiBIPsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiBIPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:48:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B9FC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:48:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF385616A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0BBC340E7;
        Wed,  9 Feb 2022 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644421698;
        bh=ydI6wA0BIuYvOXrXY9CUl5qi1UHpv72mNeIvpa+eqPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZQaSpMx0kjFhT/ei7BdBsGVR/rjZfx9rELeh35bisczGkBsk3LRFiQq+RtJCqfiY
         MLbz3G7gzKvQvVNmd1OBQK90IMqohtICWL3jAj3Y8lj0TQaBD2/fDH2JBnVx7e8FRc
         q3tu2XPcunDEAzGFYLst7zwVjTi4lgeMyr1XSwsuE80CH7dWXnIXr1yusLdJXvm3iM
         RYzlWkv0cdWGxNuqWHEEwh23T0kVKLVFTtzwMoEqaTbPwZfysfmRD9J34kTNhJ4GsO
         h3gBr0vQaaGiDpsyuIfOE2bVocjeXGJ6SX+aXFjlH5NT5ElunLhMn2yYKhgmkphFLX
         E5OIXxs7VnWbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17222400FE; Wed,  9 Feb 2022 12:47:46 -0300 (-03)
Date:   Wed, 9 Feb 2022 12:47:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
Message-ID: <YgPiItRLaEJ75dUU@kernel.org>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-11-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208211637.2221872-11-eranian@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 08, 2022 at 01:16:35PM -0800, Stephane Eranian escreveu:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> improve the error message returned on failed perf_event_open() on AMD when
> using IBS.
> 
> Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
> 
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
> /bin/dmesg | grep -i perf may provide additional information.

Humm, here on a

  $ grep -m1 'model name' /proc/cpuinfo
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  $ ls -la /sys/devices/ibs_op
  total 0
  drwxr-xr-x.  4 root root    0 Feb  9 07:12 .
  drwxr-xr-x. 21 root root    0 Feb  9 07:12 ..
  drwxr-xr-x.  2 root root    0 Feb  9 12:17 format
  -rw-r--r--.  1 root root 4096 Feb  9 12:21 perf_event_mux_interval_ms
  drwxr-xr-x.  2 root root    0 Feb  9 12:21 power
  lrwxrwxrwx.  1 root root    0 Feb  9 07:12 subsystem -> ../../bus/event_source
  -r--r--r--.  1 root root 4096 Feb  9 12:17 type
  -rw-r--r--.  1 root root 4096 Feb  9 07:12 uevent
  $ cat /sys/devices/ibs_op/type
  9
  $

Running without this patch:

  $ uname -a
  Linux five 5.15.14-100.fc34.x86_64 #1 SMP Tue Jan 11 16:53:51 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
  $

  $ cat /etc/redhat-release
  Fedora release 34 (Thirty Four)
  $

  $ perf record -e ibs_op// true
  Error:
  Invalid event (ibs_op//u) in per-thread mode, enable system wide with '-a'.
  $

Trying with system wide:

  $ perf record -a -e ibs_op// true
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//u).
  /bin/dmesg | grep -i perf may provide additional information.
  
  $

So you're missing -a in all examples? Am I missing something?

> Output after:
> 
> AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.
> 
> Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:
> 
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
> /bin/dmesg | grep -i perf may provide additional information.

Here, as root:

[root@five ~]# perf record -e ibs_op// true
Error:
Invalid event (ibs_op//) in per-thread mode, enable system wide with '-a'.
[root@five ~]# perf record -a -e ibs_op// true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.482 MB perf.data (175 samples) ]
[root@five ~]#

- Arnaldo
 
> Output after:
> 
> Error:
> AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 22d3267ce294..d42f63a484df 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2847,9 +2847,22 @@ static bool find_process(const char *name)
>  	return ret ? false : true;
>  }
>  
> +static bool is_amd(const char *arch, const char *cpuid)
> +{
> +	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
> +}
> +
> +static bool is_amd_ibs(struct evsel *evsel)
> +{
> +	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
> +}
> +
>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			 int err, char *msg, size_t size)
>  {
> +	struct perf_env *env = evsel__env(evsel);
> +	const char *arch = perf_env__arch(env);
> +	const char *cpuid = perf_env__cpuid(env);
>  	char sbuf[STRERR_BUFSIZE];
>  	int printed = 0, enforced = 0;
>  
> @@ -2949,6 +2962,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			return scnprintf(msg, size,
>  	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
>  					evsel__name(evsel));
> +		if (is_amd(arch, cpuid)) {
> +			if (is_amd_ibs(evsel)) {
> +				if (evsel->core.attr.exclude_kernel)
> +					return scnprintf(msg, size,
> +	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> +				if (!evsel->core.system_wide)
> +					return scnprintf(msg, size,
> +	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
> +			}
> +		}
> +
>  		break;
>  	case ENODATA:
>  		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> -- 
> 2.35.0.263.gb82422642f-goog

-- 

- Arnaldo
