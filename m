Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD6500CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiDNMNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbiDNMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:12:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723E1C91B;
        Thu, 14 Apr 2022 05:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D86B4B82935;
        Thu, 14 Apr 2022 12:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A4AC385A1;
        Thu, 14 Apr 2022 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938197;
        bh=7zeinDDU13Jt5FdoyleWlzNkNA1VLW3WvVhNlJtJLRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRnSB5ImcL0mX/muiv8Z+e8hxaklvlZR0LNgxfaH2VECmj4rJ6KKVE1Qd9z+UFPiJ
         kwaBiFFzqD6KcBbKqIWSwR1Upb9Ejx5iJ1ZcorGi17p8rz1aJ6lnD0I9n3Eb2ytotB
         nK2zbjqsQW732ve0aFPi6P8eE5TPA7/xuikIjO8dwyYQBqnpp/DkLk51+pYWkKIA7X
         VxR+gHwvshYWyIZ6rUq7GcpkAFEeZPQaKMCDafLuXgn74TqzzOo5d6MVZ+9i1HsyyO
         Dv5Ta7Gih7rfuNRjKF9JiqnLBj1006xa9L6wX8AethHbmb0AbdoTNitU3Wn6dAm5QF
         2UT8HxuGlqq0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 115AA40407; Thu, 14 Apr 2022 09:09:55 -0300 (-03)
Date:   Thu, 14 Apr 2022 09:09:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/3] perf cpumap: Switch to using perf_cpu_map API
Message-ID: <YlgPE6aEnGPTIucl@kernel.org>
References: <20220414014642.3308206-1-irogers@google.com>
 <20220414014642.3308206-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414014642.3308206-2-irogers@google.com>
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

Em Wed, Apr 13, 2022 at 06:46:41PM -0700, Ian Rogers escreveu:
> Switch some raw accesses to the cpu map to using the library API. This
> can help with reference count checking.

Thanks, applying to perf/core after what is in perf/urgent, which this
patch depends on, gets merged there.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c          | 13 ++++++------
>  tools/perf/util/bpf_counter_cgroup.c | 31 ++++++++++++++--------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 069825c48d40..a5cf6a99d67f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1011,7 +1011,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
>  
>  	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
>  		if (cpu_map__is_dummy(cpus) ||
> -		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
> +		    test_bit(perf_cpu_map__cpu(cpus, m).cpu, thread_data->mask->maps.bits)) {
>  			if (thread_data->maps) {
>  				thread_data->maps[tm] = &mmap[m];
>  				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
> @@ -3331,13 +3331,14 @@ struct option *record_options = __record_options;
>  
>  static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
>  {
> -	int c;
> +	struct perf_cpu cpu;
> +	int idx;
>  
>  	if (cpu_map__is_dummy(cpus))
>  		return;
>  
> -	for (c = 0; c < cpus->nr; c++)
> -		set_bit(cpus->map[c].cpu, mask->bits);
> +	perf_cpu_map__for_each_cpu(cpu, idx, cpus)
> +		set_bit(cpu.cpu, mask->bits);
>  }
>  
>  static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
> @@ -3404,8 +3405,8 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
>  	pr_debug("nr_threads: %d\n", rec->nr_threads);
>  
>  	for (t = 0; t < rec->nr_threads; t++) {
> -		set_bit(cpus->map[t].cpu, rec->thread_masks[t].maps.bits);
> -		set_bit(cpus->map[t].cpu, rec->thread_masks[t].affinity.bits);
> +		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
> +		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
>  		if (verbose) {
>  			pr_debug("thread_masks[%d]: ", t);
>  			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index ac60c08e8e2a..a4b676920da0 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -47,7 +47,7 @@ static int bperf_load_program(struct evlist *evlist)
>  	struct evsel *evsel;
>  	struct cgroup *cgrp, *leader_cgrp;
>  	__u32 i, cpu;
> -	__u32 nr_cpus = evlist->core.all_cpus->nr;
> +	__u32 nr_cpus = perf_cpu_map__nr(evlist->core.all_cpus);
>  	int total_cpus = cpu__max_cpu().cpu;
>  	int map_size, map_fd;
>  	int prog_fd, err;
> @@ -125,7 +125,7 @@ static int bperf_load_program(struct evlist *evlist)
>  			for (cpu = 0; cpu < nr_cpus; cpu++) {
>  				int fd = FD(evsel, cpu);
>  				__u32 idx = evsel->core.idx * total_cpus +
> -					evlist->core.all_cpus->map[cpu].cpu;
> +					perf_cpu_map__cpu(evlist->core.all_cpus, cpu).cpu;
>  
>  				err = bpf_map_update_elem(map_fd, &idx, &fd,
>  							  BPF_ANY);
> @@ -207,13 +207,13 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
>   */
>  static int bperf_cgrp__sync_counters(struct evlist *evlist)
>  {
> -	int i, cpu;
> -	int nr_cpus = evlist->core.all_cpus->nr;
> +	struct perf_cpu cpu;
> +	int idx;
>  	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
>  
> -	for (i = 0; i < nr_cpus; i++) {
> -		cpu = evlist->core.all_cpus->map[i].cpu;
> -		bperf_trigger_reading(prog_fd, cpu);
> +	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> +		cpu = perf_cpu_map__cpu(evlist->core.all_cpus, i);
> +		bperf_trigger_reading(prog_fd, cpu.cpu);
>  	}
>  
>  	return 0;
> @@ -244,12 +244,10 @@ static int bperf_cgrp__disable(struct evsel *evsel)
>  static int bperf_cgrp__read(struct evsel *evsel)
>  {
>  	struct evlist *evlist = evsel->evlist;
> -	int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
>  	int total_cpus = cpu__max_cpu().cpu;
>  	struct perf_counts_values *counts;
>  	struct bpf_perf_event_value *values;
>  	int reading_map_fd, err = 0;
> -	__u32 idx;
>  
>  	if (evsel->core.idx)
>  		return 0;
> @@ -263,7 +261,10 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		idx = evsel->core.idx;
> +		__u32 idx = evsel->core.idx;
> +		int i;
> +		struct perf_cpu_map cpu;
> +
>  		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
>  		if (err) {
>  			pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
> @@ -271,13 +272,11 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  			goto out;
>  		}
>  
> -		for (i = 0; i < nr_cpus; i++) {
> -			cpu = evlist->core.all_cpus->map[i].cpu;
> -
> +		perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpu) {
>  			counts = perf_counts(evsel->counts, i, 0);
> -			counts->val = values[cpu].counter;
> -			counts->ena = values[cpu].enabled;
> -			counts->run = values[cpu].running;
> +			counts->val = values[cpu.cpu].counter;
> +			counts->ena = values[cpu.cpu].enabled;
> +			counts->run = values[cpu.cpu].running;
>  		}
>  	}
>  
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog

-- 

- Arnaldo
