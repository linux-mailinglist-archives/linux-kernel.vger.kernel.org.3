Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594EB51BEB2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356383AbiEEMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359350AbiEEMAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:00:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3854FBA;
        Thu,  5 May 2022 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651751807; x=1683287807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dC4dIWf/flXJW9SxjgXzvcJK838ak8PWG9+xKkhGDa4=;
  b=Nvpp2y6vMgM4ujnRaynbnhorhbU8l6INlEUmCqktk1uTHkxbHYUFobMx
   NUEF5q7MeJ/62Lbv+IF2RpZhv5x+4ZZSYnpNiE8VxjaGHvuItft1JCV8a
   xTknG8GwjYhsgqFfleTthONuhgLD1lcEvzHLcMplSXj01iYclw4WPvgIl
   wtErtdAgX39rauE6D0+KpSlPgDKBHAgaRQRzBWvMDKM6kp1wmOnXmlo6J
   fuwoRvfp0B+yluC0P/a0EsmrCJRhrEE/DmXQiFYQ6uQtm5T+54+WGxlJ5
   xN58fi4DCPK8eBVzcQB7XXF9kq8/F9OsWDcCYjw/5JL6UtSRyLVy3fqte
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354520220"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="354520220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 04:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="621263108"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2022 04:56:42 -0700
Received: from [10.252.209.228] (kliang2-MOBL.ccr.corp.intel.com [10.252.209.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4E44B5806C8;
        Thu,  5 May 2022 04:56:38 -0700 (PDT)
Message-ID: <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
Date:   Thu, 5 May 2022 07:56:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] perf evlist: Keep topdown counters in weak group
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220505043846.3165303-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220505043846.3165303-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

Thanks for the patches.

On 5/5/2022 12:38 AM, Ian Rogers wrote:
> On Intel Icelake, topdown events must always be grouped with a slots
> event as leader. When a metric is parsed a weak group is formed and
> retried if perf_event_open fails. The retried events aren't grouped
> breaking the slots leader requirement. This change modifies the weak
> group "reset" behavior so that topdown events aren't broken from the
> group for the retry.
> 
> $ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,baclears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>      47,867,188,483      slots                                                         (92.27%)
>     <not supported>      topdown-bad-spec
>     <not supported>      topdown-be-bound
>     <not supported>      topdown-fe-bound
>     <not supported>      topdown-retiring
>       2,173,346,937      branch-instructions                                           (92.27%)
>          10,540,253      branch-misses             #    0.48% of all branches          (92.29%)
>          96,291,140      bus-cycles                                                    (92.29%)
>           6,214,202      cache-misses              #   20.120 % of all cache refs      (92.29%)
>          30,886,082      cache-references                                              (76.91%)
>      11,773,726,641      cpu-cycles                                                    (84.62%)
>      11,807,585,307      instructions              #    1.00  insn per cycle           (92.31%)
>                   0      mem-loads                                                     (92.32%)
>       2,212,928,573      mem-stores                                                    (84.69%)
>      10,024,403,118      ref-cycles                                                    (92.35%)
>          16,232,978      baclears.any                                                  (92.35%)
>          23,832,633      ARITH.DIVIDER_ACTIVE                                          (84.59%)
> 
>         0.981070734 seconds time elapsed
> 
> After:
> 
> $ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,baclears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>         31040189283      slots                                                         (92.27%)
>          8997514811      topdown-bad-spec          #     28.2% bad speculation         (92.27%)
>         10997536028      topdown-be-bound          #     34.5% backend bound           (92.27%)
>          4778060526      topdown-fe-bound          #     15.0% frontend bound          (92.27%)
>          7086628768      topdown-retiring          #     22.2% retiring                (92.27%)
>          1417611942      branch-instructions                                           (92.26%)
>             5285529      branch-misses             #    0.37% of all branches          (92.28%)
>            62922469      bus-cycles                                                    (92.29%)
>             1440708      cache-misses              #    8.292 % of all cache refs      (92.30%)
>            17374098      cache-references                                              (76.94%)
>          8040889520      cpu-cycles                                                    (84.63%)
>          7709992319      instructions              #    0.96  insn per cycle           (92.32%)
>                   0      mem-loads                                                     (92.32%)
>          1515669558      mem-stores                                                    (84.68%)
>          6542411177      ref-cycles                                                    (92.35%)
>             4154149      baclears.any                                                  (92.35%)
>            20556152      ARITH.DIVIDER_ACTIVE                                          (84.59%)
> 
>         1.010799593 seconds time elapsed
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/arch/x86/util/evsel.c | 12 ++++++++++++
>   tools/perf/util/evlist.c         | 16 ++++++++++++++--
>   tools/perf/util/evsel.c          | 10 ++++++++++
>   tools/perf/util/evsel.h          |  3 +++
>   4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ac2899a25b7a..40b171de2086 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -3,6 +3,7 @@
>   #include <stdlib.h>
>   #include "util/evsel.h"
>   #include "util/env.h"
> +#include "util/pmu.h"
>   #include "linux/string.h"
>   
>   void arch_evsel__set_sample_weight(struct evsel *evsel)
> @@ -29,3 +30,14 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>   
>   	free(env.cpuid);
>   }
> +
> +bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> +{
> +	if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> +	    !pmu_have_event("cpu", "slots"))
> +		return false;
> +

The big core of ADL also supports Perf_metrics. At least, we should 
check both "cpu" and "cpu_core" here.

Thanks,
Kan
> +	return evsel->name &&
> +		(!strcasecmp(evsel->name, "slots") ||
> +		 !strncasecmp(evsel->name, "topdown", 7));
> +}
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 52ea004ba01e..dfa65a383502 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1790,8 +1790,17 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
>   		if (evsel__has_leader(c2, leader)) {
>   			if (is_open && close)
>   				perf_evsel__close(&c2->core);
> -			evsel__set_leader(c2, c2);
> -			c2->core.nr_members = 0;
> +			/*
> +			 * We want to close all members of the group and reopen
> +			 * them. Some events, like Intel topdown, require being
> +			 * in a group and so keep these in the group.
> +			 */
> +			if (!evsel__must_be_in_group(c2) && c2 != leader) {
> +				evsel__set_leader(c2, c2);
> +				c2->core.nr_members = 0;
> +				leader->core.nr_members--;
> +			}
> +
>   			/*
>   			 * Set this for all former members of the group
>   			 * to indicate they get reopened.
> @@ -1799,6 +1808,9 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
>   			c2->reset_group = true;
>   		}
>   	}
> +	/* Reset the leader count if all entries were removed. */
> +	if (leader->core.nr_members)
> +		leader->core.nr_members = 0;
>   	return leader;
>   }
>   
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d38722560e80..b7c0c9775673 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3082,3 +3082,13 @@ int evsel__source_count(const struct evsel *evsel)
>   	}
>   	return count;
>   }
> +
> +bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe_unused)
> +{
> +	return false;
> +}
> +
> +bool evsel__must_be_in_group(const struct evsel *evsel)
> +{
> +	return arch_evsel__must_be_in_group(evsel);
> +}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 45d674812239..0ed2850b7ebb 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -488,6 +488,9 @@ bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>   bool evsel__is_leader(struct evsel *evsel);
>   void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>   int evsel__source_count(const struct evsel *evsel);
> +bool evsel__must_be_in_group(const struct evsel *evsel);
> +
> +bool arch_evsel__must_be_in_group(const struct evsel *evsel);
>   
>   /*
>    * Macro to swap the bit-field postition and size.
