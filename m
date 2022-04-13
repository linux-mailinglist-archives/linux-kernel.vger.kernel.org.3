Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F174FEC67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiDMBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiDMBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:44:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64699FF7;
        Tue, 12 Apr 2022 18:42:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w19so885696lfu.11;
        Tue, 12 Apr 2022 18:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zOGSRiq7V6W6wTu4+wCWDwi0wGVo+ygFKUekXm7WFx4=;
        b=mHUYcZl3AJxjv8p2fXXOHlHRE8eJNRrPn8BzZZogdrtuGu3v8K3Ptmn30fEt7WmVYj
         24Tr7l+VPefHYYldfFT4LQSCIkuu89zQMOgLt7i/yUBC38EvkIToBQOvN4Kr5kC5G0pc
         PfuUwJ6C2XyvFUi7Ma5nJ+97FKhiWKw9fNeLSIXhDJNyObT/Up0fyIHLxzQpIzmRVdV6
         ym1084g4PT0Ppx07jN0kkcUBx7nsTxxMaHx1gVbHxzeWQ1fXuBKS0pxLBfEB9iGn6DSV
         O9n/JxzhbuXinoHmpNxS2h8Ib9QQxAjxerX1uzs9UcGUAiUSS+So7zLYYeRM17RdXMkb
         r+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zOGSRiq7V6W6wTu4+wCWDwi0wGVo+ygFKUekXm7WFx4=;
        b=KzU+gnjCZuHVpQHOLgvw5mCBz3d9MG4IRheSgMvyyTR0OBK4VE3iWebZFDd9N6Jfxl
         HC6tD2XlWsEJl3XlEV8CGXUXxqq9jjRZSAU3GE0KYh1j6GTvficzUUfcICitGkU+VW6X
         TitHNUcFTYznfkuomTUjOaNxKY/W/x1c9cS7nBSBoAzPsWSwnkEOilyAzAvn3pcG2/X3
         7jE+weS+123g+Ct8FH4nAy4nuZoNw9BglEm5C2TlBERAIP/IqHoIhBDMc6SaQMMIp8jw
         hqZ7fh/T8uHN7mto9r59HJ2p0TYkAykqrW/WmGHAbkIQygPywKzEdBIYMjcK4bIgnKZ6
         303Q==
X-Gm-Message-State: AOAM531xMdK8+TvGn7092DTEqf8N5nnhFbqmheSZz4IlhMekPUtPBPCQ
        UhwnED7BpW5eaCtW6r9bIcY=
X-Google-Smtp-Source: ABdhPJwFJbmjsFhyL3o0ox0otvSX1b+ZzP/n06QIjuJQvMqB2dULvtRiLaD4qUwlMZeNnR+ETZOOMw==
X-Received: by 2002:a05:6512:b28:b0:44a:9b62:3212 with SMTP id w40-20020a0565120b2800b0044a9b623212mr27197994lfu.320.1649814128929;
        Tue, 12 Apr 2022 18:42:08 -0700 (PDT)
Received: from [192.168.0.229] (213-177-122-2.dynamic.mts-nn.ru. [213.177.122.2])
        by smtp.gmail.com with ESMTPSA id h8-20020ac24da8000000b0046b8a03301bsm1544300lfe.137.2022.04.12.18.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 18:42:08 -0700 (PDT)
Message-ID: <e1ce0d93-88cc-af79-e67e-d3c79d166ca6@gmail.com>
Date:   Wed, 13 Apr 2022 04:42:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/3] perf record: Fix per-thread option.
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220412062133.2546080-1-irogers@google.com>
From:   Alexey Bayduraev <alexey.bayduraev@gmail.com>
In-Reply-To: <20220412062133.2546080-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.2022 09:21, Ian Rogers wrote:

> From: Alexey Bayduraev <alexey.bayduraev@gmail.com>

Thanks,

The tag
Signed-off-by: Alexey Bayduraev <alexey.bayduraev@gmail.com>
can be added to this patch.

Regards,
Alexey

> 
> Per-thread mode doesn't have specific CPUs for events, add checks for
> this case.
> 
> Minor fix to a pr_debug by Ian Rogers <irogers@google.com> to avoid an
> out of bound array access.
> 
> Reported-by: Ian Rogers <irogers@google.com>
> Fixes: 7954f71689f9 ("perf record: Introduce thread affinity and mmap masks")
> Signed-off-by: Ian Rogers <irogers@google.com>
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
> 

