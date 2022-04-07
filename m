Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF904F71A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiDGBon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbiDGBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:44:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F212C269;
        Wed,  6 Apr 2022 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649295602; x=1680831602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D0WRSzNQWw6rXo4ORoZh1NsPHO0DeyRTI/AM0fyWzNQ=;
  b=cSFkR5jCoZdutjGTwjNNjr7g/UXf7lTV0gz7sO33jC1a9xqyo2ItpHdi
   BASfeHjj3z9Gbh8XFCP7Vnyf0YPTZf9zNPx0ltSuTlP9sx3WxdwrRfRUu
   Oe1OH5k9UU6iaTsMHp3XfeO6pVkXLx0qGskKE0/Hnr0CyZXzJPuyhnHbw
   wisjk+QS0lFz0zOfDbk5wWb38lNpr5QqfktA60JLPOTbYc4ku2HpG7UD0
   2vz52HNP3meG6+jbTQm1ogpBRFdJIUbWTlcer1AcGElwC69SGUyaTHS3Q
   IHGSnooDxCSqAZAGJUYNMT9N3oGFa667YyYje6Yu4PKbwO3r2KcA0j3lO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248725933"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="248725933"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:40:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="570829283"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.165]) ([10.255.31.165])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:39:59 -0700
Message-ID: <69656438-8b9a-000b-0702-02dc480639f9@linux.intel.com>
Date:   Thu, 7 Apr 2022 09:39:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] perf stat: add rusage utime and stime events
Content-Language: en-US
To:     Florian Fischer <florian.fischer@muhq.space>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Florian Schmaus <flow@cs.fau.de>
References: <YkybjsCKyWkDZGX+@kernel.org>
 <20220406072839.107519-1-florian.fischer@muhq.space>
 <20220406072839.107519-3-florian.fischer@muhq.space>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220406072839.107519-3-florian.fischer@muhq.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2022 3:28 PM, Florian Fischer wrote:
> It bothered me that during benchmarking using perf stat (to collect
> for example CPU cache events) I could not simultaneously retrieve the
> times spend in user or kernel mode in a machine readable format.
> 
> When running perf stat the output for humans contains the times
> reported by rusage and wait4.
> 
> $ perf stat -e cache-misses:u -- true
> 
>   Performance counter stats for 'true':
> 
>               4,206      cache-misses:u
> 
>         0.001113619 seconds time elapsed
> 
>         0.001175000 seconds user
>         0.000000000 seconds sys
> 
> But perf stat's machine-readable format does not provide this information.
> 
> $ perf stat -x, -e cache-misses:u -- true
> 4282,,cache-misses:u,492859,100.00,,
> 
> I found no way to retrieve this information using the available events
> while using machine-readable output.
> 
> This patch adds two new tool internal events 'rusage_user_time'
> and 'rusage_system_time' as well as their aliases 'ru_utime' and
> 'ru_stime', similarly to the already present 'duration_time' event.
> 
> Both events use the already collected rusage information obtained by wait4
> and tracked in the global ru_stats.
> 
> Examples presenting cache-misses and rusage information in both human and
> machine-readable form:
> 
> $ ./perf stat -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> 
>   Performance counter stats for 'grep -q -r duration_time .':
> 
>          67,422,542 ns   duration_time:u
>              50,517 us   ru_utime:u
>              16,839 us   ru_stime:u
>              30,937      cache-misses:u

Duration_time unit is "ns", while "ru_utime" and "ru_stime" unit is 
"us",  I think they should use the same time unit.

> 
>         0.067422542 seconds time elapsed
> 
>         0.050517000 seconds user
>         0.016839000 seconds sys
> 
> $ ./perf stat -x, -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> 72134524,ns,duration_time:u,72134524,100.00,,
> 65225,us,ru_utime:u,65225,100.00,,
> 6865,us,ru_stime:u,6865,100.00,,
> 38705,,cache-misses:u,71189328,100.00,,
> 
> Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
> ---
>   tools/perf/builtin-stat.c      | 36 ++++++++++++++++++++++++++--------
>   tools/perf/util/evsel.h        |  3 +++
>   tools/perf/util/parse-events.l |  2 ++
>   3 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 61faffb535f5..c73afc8f6da5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -342,15 +342,35 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
>   static int read_single_counter(struct evsel *counter, int cpu_map_idx,
>   			       int thread, struct timespec *rs)
>   {
> -	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
> -		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
> -		struct perf_counts_values *count =
> -			perf_counts(counter->counts, cpu_map_idx, thread);
> -		count->ena = count->run = val;
> -		count->val = val;
> -		return 0;
> +	switch(counter->tool_event) {
> +		case PERF_TOOL_DURATION_TIME: {
> +			u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
> +			struct perf_counts_values *count =
> +				perf_counts(counter->counts, cpu_map_idx, thread);
> +			count->ena = count->run = val;
> +			count->val = val;
> +			return 0;
> +		}
> +		case PERF_TOOL_RU_UTIME:
> +		case PERF_TOOL_RU_STIME: {
> +			u64 val;
> +			struct perf_counts_values *count =
> +				perf_counts(counter->counts, cpu_map_idx, thread);
> +			if (counter->tool_event == PERF_TOOL_RU_UTIME)
> +				val = ru_stats.ru_utime_usec_stat.mean;
> +			else
> +				val = ru_stats.ru_stime_usec_stat.mean;
> +			count->ena = count->run = val;
> +			count->val = val;
> +			return 0;
> +		}
> +		default:
> +		case PERF_TOOL_NONE:
> +			return evsel__read_counter(counter, cpu_map_idx, thread);
> +		case PERF_TOOL_LAST:
> +			/* this case should never be reached */
> +			return 0;
>   	}
> -	return evsel__read_counter(counter, cpu_map_idx, thread);
>   }
>   
>   /*
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 041b42d33bf5..e89b1224ae61 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -30,6 +30,9 @@ typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
>   enum perf_tool_event {
>   	PERF_TOOL_NONE		= 0,
>   	PERF_TOOL_DURATION_TIME = 1,
> +	PERF_TOOL_RU_UTIME = 2,
> +	PERF_TOOL_RU_STIME = 3,
> +	PERF_TOOL_LAST
>   };
>   
>   /** struct evsel - event selector
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 5b6e4b5249cf..3c7227b8035c 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -353,6 +353,8 @@ alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_AL
>   emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
>   dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
>   duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
> +rusage_user_time|ru_utime	{ return tool(yyscanner, PERF_TOOL_RU_UTIME); }
> +rusage_system_time|ru_stime	{ return tool(yyscanner, PERF_TOOL_RU_STIME); }
>   bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
>   cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
>   

-- 
Zhengjun Xing
