Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0FB500CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbiDNMLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbiDNMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB0F218E;
        Thu, 14 Apr 2022 05:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9E261F15;
        Thu, 14 Apr 2022 12:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97284C385A1;
        Thu, 14 Apr 2022 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938159;
        bh=gq/D+Mkzw9tcvLZwoAzZSJCZAQ+Lu0I2TXKxw6zM0SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2Y9vEGL3UbVQhH276MK9EwWeX6UQljcb/Hbp0uCzSWGQ4gPvvLU5Wo1uB0DqMQEa
         CdM7j/OkqdZ3sGzitlFOuUR1HEUZ1U0QAnqJgQyJjsTjxp9136wVjFqMQHsmAvlfro
         JhZ7ts7MstIGXjunk8ttEVkNujNWmVipC3a0L/x62Ow1JbQ2hpCY5LhS+K/TpnCdb6
         RFHnJMTaPNqyYaq9Lm/wzP/TkoI9e+0VfDOM2/vffO35INcjn3uk9TXCVzo69C+SuM
         bKjpfbE/MkO0bINu82rVvxtKgJEt0Uc2NMCjVjxrN2Y2KFCaSQ059B0mWglewcs6dr
         kAfle6405SQSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C908D40407; Thu, 14 Apr 2022 09:09:16 -0300 (-03)
Date:   Thu, 14 Apr 2022 09:09:16 -0300
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
Subject: Re: [PATCH v2 1/3] perf record: Fix per-thread option.
Message-ID: <YlgO7Dz/siOeDMTm@kernel.org>
References: <20220414014642.3308206-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414014642.3308206-1-irogers@google.com>
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

Em Wed, Apr 13, 2022 at 06:46:40PM -0700, Ian Rogers escreveu:
> From: Alexey Bayduraev <alexey.bayduraev@gmail.com>
> 
> Per-thread mode doesn't have specific CPUs for events, add checks for
> this case.
> 
> Minor fix to a pr_debug by Ian Rogers <irogers@google.com> to avoid an
> out of bound array access.

Thanks, applied to perf/urgent.

- Arnaldo

 
> Reported-by: Ian Rogers <irogers@google.com>
> Fixes: 7954f71689f9 ("perf record: Introduce thread affinity and mmap masks")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Alexey Bayduraev <alexey.bayduraev@gmail.com>
> ---
>  tools/perf/builtin-record.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba74fab02e62..069825c48d40 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -989,8 +989,11 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
>  	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
>  	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
>  
> -	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
> -					      thread_data->mask->maps.nbits);
> +	if (cpu_map__is_dummy(cpus))
> +		thread_data->nr_mmaps = nr_mmaps;
> +	else
> +		thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
> +						      thread_data->mask->maps.nbits);
>  	if (mmap) {
>  		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
>  		if (!thread_data->maps)
> @@ -1007,16 +1010,17 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
>  		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
>  
>  	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
> -		if (test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
> +		if (cpu_map__is_dummy(cpus) ||
> +		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
>  			if (thread_data->maps) {
>  				thread_data->maps[tm] = &mmap[m];
>  				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
> -					  thread_data, cpus->map[m].cpu, tm, m);
> +					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
>  			}
>  			if (thread_data->overwrite_maps) {
>  				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
>  				pr_debug2("thread_data[%p]: cpu%d: ow_maps[%d] -> ow_mmap[%d]\n",
> -					  thread_data, cpus->map[m].cpu, tm, m);
> +					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
>  			}
>  			tm++;
>  		}
> @@ -3329,6 +3333,9 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
>  {
>  	int c;
>  
> +	if (cpu_map__is_dummy(cpus))
> +		return;
> +
>  	for (c = 0; c < cpus->nr; c++)
>  		set_bit(cpus->map[c].cpu, mask->bits);
>  }
> @@ -3680,6 +3687,11 @@ static int record__init_thread_masks(struct record *rec)
>  	if (!record__threads_enabled(rec))
>  		return record__init_thread_default_masks(rec, cpus);
>  
> +	if (cpu_map__is_dummy(cpus)) {
> +		pr_err("--per-thread option is mutually exclusive to parallel streaming mode.\n");
> +		return -EINVAL;
> +	}
> +
>  	switch (rec->opts.threads_spec) {
>  	case THREAD_SPEC__CPU:
>  		ret = record__init_thread_cpu_masks(rec, cpus);
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog

-- 

- Arnaldo
