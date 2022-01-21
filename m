Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E355F495E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380121AbiAULZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:25:21 -0500
Received: from foss.arm.com ([217.140.110.172]:48958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235434AbiAULZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:25:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 420D21FB;
        Fri, 21 Jan 2022 03:25:20 -0800 (PST)
Received: from [10.57.39.197] (unknown [10.57.39.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3E543F73D;
        Fri, 21 Jan 2022 03:25:17 -0800 (PST)
Subject: Re: [PATCH] perf script: Fix printing 'phys_addr' failure issue
To:     Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, jinyao5@huawei.com
References: <20220121065954.2121900-1-liwei391@huawei.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <1c38c70b-d165-acf9-1c98-eeb234fbbe99@arm.com>
Date:   Fri, 21 Jan 2022 11:24:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220121065954.2121900-1-liwei391@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

This looks good to me. As a followup we could also fix the 'weight'
field, which was introduced recently.

On 21/01/2022 06:59, Wei Li wrote:
> From: Yao Jin <jinyao5@huawei.com>
>
> Perf script was failed to print the phys_addr for SPE profiling.
> One 'dummy' event is added by SPE profiling but it doesn't have PHYS_ADDR
> attribute set, perf script then exits with error.
>
> Now referring to 'addr', use evsel__do_check_stype() to check the type.
>
> Before:
>
>   # perf record -e arm_spe_0/branch_filter=0,ts_enable=1,pa_enable=1,load_filter=1,jitter=0,\
> 		store_filter=0,min_latency=0,event_filter=2/ -p 4064384 -- sleep 3
>   # perf script -F pid,tid,addr,phys_addr
>   Samples for 'dummy:u' event do not have PHYS_ADDR attribute set. Cannot print 'phys_addr' field.
>
> After:
>
>   # perf record -e arm_spe_0/branch_filter=0,ts_enable=1,pa_enable=1,load_filter=1,jitter=0,\
> 		store_filter=0,min_latency=0,event_filter=2/ -p 4064384 -- sleep 3
>   # perf script -F pid,tid,addr,phys_addr
>   4064384/4064384 ffff802f921be0d0      2f921be0d0
>   4064384/4064384 ffff802f921be0d0      2f921be0d0
>
> Signed-off-by: Yao Jin <jinyao5@huawei.com>
> Signed-off-by: Wei Li <liwei391@huawei.com>

Reviewed-by: German Gomez <german.gomez@arm.com>

Also it looks like the SPE samples are also missing the PHYS_ADDR flag.
I think we'll need to fix the consistency of the flags.

Many thanks,
German

> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index ecd4f99a6c14..abae8184e171 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -515,7 +515,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(PHYS_ADDR) &&
> -	    evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR))
> +	    evsel__do_check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR, allow_user_set))
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(DATA_PAGE_SIZE) &&
