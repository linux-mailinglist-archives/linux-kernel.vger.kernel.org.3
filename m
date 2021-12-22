Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966F347CD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbhLVG4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:56:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:32311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242846AbhLVG4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640156200; x=1671692200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XWSmsUTqKDWedpZrNjDZUikX/jl3lS2gYyjbsE7ov4A=;
  b=BLoz5/AtP2Bfz1pKxLGSI9vTROdPJ9Cew+c1lVwJYhaPcW+94ZIT6avh
   VxnNmP4vecs4Q11Z8qCI2r/bX4f+l56TWyTtS+3J9JmiXZKFDTKkKWk6d
   ph5aEuF6YBeOB93rqImrxdazvvkU3TVwoXnnbVNDtus2+S2Hl6qpvdKMk
   XGfq5bvxJTfyu6GWEZr5am8IZHn5B7wgyDQ5j3EkWaFS2B7FKmG/UlNmR
   BLw3W7j3E6ibN2oV6eJ4pSLKkoO8VtF4tMRt5VrifCCmaUazIpdGS9oNa
   QLF3BvMckZAowF4q9ndol89T0zAksZJ9xANVZLaY1WrkTGWv5JTJUhflr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="238095855"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="238095855"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 22:56:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="521562091"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.155]) ([10.238.4.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 22:56:37 -0800
Message-ID: <70e34e8f-6acb-1406-c67e-20280f9f4946@linux.intel.com>
Date:   Wed, 22 Dec 2021 14:56:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] perf pmu: Fix alias events list
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1640103090-140490-1-git-send-email-john.garry@huawei.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <1640103090-140490-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2021 12:11 AM, John Garry wrote:
> Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> changes the event list for uncore PMUs or arm64 heterogeneous CPU systems,
> such that duplicate aliases are incorrectly listed per PMU (which they
> should not be), like:
> 
> ./perf list
> ...
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> ...
> 
> Notice how the events are listed twice.
> 
> The named commit changed how we remove duplicate events, in that events
> for different PMUs are not treated as duplicates. I suppose this is to
> handle how "Each hybrid pmu event has been assigned with a pmu name".
> 
> Fix PMU alias listing by restoring behaviour to remove duplicates for
> non-hybrid PMUs.
> 
> Fixes: 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> 
> Difference in v2:
> - Change duplicate check to explicitly check for hybrid PMU
> 
> @Zhengjun Xing, Can you please check this new version? Thanks!

Tested this new version patch on both hybrid and non-hybrid PMU x86 
systems, it works OK with no duplicate events for the uncore.

Tested-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6ae58406f4fc..8dfbba15aeb8 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1659,6 +1659,21 @@ bool is_pmu_core(const char *name)
>   	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
>   }
>   
> +static bool pmu_alias_is_duplicate(struct sevent *alias_a,
> +				   struct sevent *alias_b)
> +{
> +	/* Different names -> never duplicates */
> +	if (strcmp(alias_a->name, alias_b->name))
> +		return false;
> +
> +	/* Don't remove duplicates for hybrid PMUs */
> +	if (perf_pmu__is_hybrid(alias_a->pmu) &&
> +	    perf_pmu__is_hybrid(alias_b->pmu))
> +		return false;
> +
> +	return true;
> +}
> +
>   void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>   			bool long_desc, bool details_flag, bool deprecated,
>   			const char *pmu_name)
> @@ -1744,12 +1759,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>   	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>   	for (j = 0; j < len; j++) {
>   		/* Skip duplicates */
> -		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
> -			if (!aliases[j].pmu || !aliases[j - 1].pmu ||
> -			    !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
> -				continue;
> -			}
> -		}
> +		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
> +			continue;
>   
>   		if (name_only) {
>   			printf("%s ", aliases[j].name);

-- 
Zhengjun Xing
