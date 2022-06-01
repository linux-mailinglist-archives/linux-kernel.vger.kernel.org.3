Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C953A90A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355423AbiFAOSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356635AbiFAOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:16:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59389ABF66;
        Wed,  1 Jun 2022 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654092337; x=1685628337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HyKddHsj7lTqJQFJTK4Q3POUo1M3Pk5TiQZ6U45ektw=;
  b=n+wayL6SmpBdD+Fflmr0opVqnfku385Fj07EbQ7juSIJe1/VTPAabvJ6
   44mnGt37V4WNgCEMXezZwcYB18tjCDYveprZ9JdMJ5j0JzzMdNfgDZat6
   pT/N1YSxJaNDi4QVPm0Q2HxFe3eK37bHf5eJoGlSK0zWoOLzAHkiShaRE
   u6SRoqkLb9kAmTj40MvO+KLhogXJ0tpZQDVaXIz9TIuQOzBQ9Y4uv0Bxk
   GhZTIhS39tnu+eYaV1fiEG8DMwiEC+Cey7/q3Dh/HxKWqJrEouTEx5c/d
   IL9vLzxaU++rYZg4LYmv3bdWCGf0isqNgE2iPQU3DdMb1Y7DHCDkXMPAd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275608635"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275608635"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 07:05:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="707072486"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2022 07:05:03 -0700
Received: from [10.252.214.178] (kliang2-MOBL.ccr.corp.intel.com [10.252.214.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A682E580514;
        Wed,  1 Jun 2022 07:05:00 -0700 (PDT)
Message-ID: <e49505ea-5af2-41d3-23dc-8c01e20f91ee@linux.intel.com>
Date:   Wed, 1 Jun 2022 10:04:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 0/8] perf/amd: Zen4 IBS extensions support (tool
 changes)
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     jolsa@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220601032608.1034-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2022 11:26 PM, Ravi Bangoria wrote:
> Kernel side of changes have already been applied to linus/master
> (except amd-ibs.h header). This series contains perf tool changes.
> 
> Kan, I don't have any machine with heterogeneou cpus. It would be
> helpful if you can check HEADER_PMU_CAPS on Intel ADL machine.
>

I tried the patch 2-5 on a hybrid machine. I didn't see any regression 
with perf report --header-only option.

Without the patch 2-5,
# perf report --header-only | grep capabilities
# cpu_core pmu capabilities: branches=32, max_precise=3, 
pmu_name=alderlake_hybrid
# cpu_atom pmu capabilities: branches=32, max_precise=3, 
pmu_name=alderlake_hybrid

With the patch 2-5,
# ./perf report --header-only | grep capabilities
# cpu_core pmu capabilities: branches=32, max_precise=3, 
pmu_name=alderlake_hybrid
# cpu_atom pmu capabilities: branches=32, max_precise=3, 
pmu_name=alderlake_hybrid


Thanks,
Kan


> v4: https://lore.kernel.org/lkml/20220523033945.1612-1-ravi.bangoria@amd.com
> v4->v5:
>   - Replace HEADER_HYBRID_CPU_PMU_CAPS with HEADER_PMU_CAPS instead of
>     adding new header HEADER_PMU_CAPS. Special care is taken by writing
>     hybrid cpu pmu caps first in the header to make sure old perf tool
>     does not break.
>   - Store HEADER_CPU_PMU_CAPS capabilities in an array instead of single
>     string separated by NULL.
>   - Include "cpu" pmu while searching for capabilities in perf_env.
>   - Rebase on acme/perf/core (9dde6cadb92b5)
> 
> Original cover letter:
> 
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 Miss Filtering capability. Both are
> indicated by CPUID_Fn8000001B_EAX bit 11.
> 
> DataSrc extension provides additional data source details for tagged
> load/store operations. Add support for these new bits in perf report/
> script raw-dump.
> 
> IBS L3 miss filtering works by tagging an instruction on IBS counter
> overflow and generating an NMI if the tagged instruction causes an L3
> miss. Samples without an L3 miss are discarded and counter is reset
> with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
> This helps in reducing sampling overhead when user is interested only
> in such samples. One of the use case of such filtered samples is to
> feed data to page-migration daemon in tiered memory systems.
> 
> Add support for L3 miss filtering in IBS driver via new pmu attribute
> "l3missonly". Example usage:
> 
>    # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5
>    # perf report -D
> 
> Some important points to keep in mind while using L3 miss filtering:
> 1. Hw internally reset sampling period when tagged instruction does
>     not cause L3 miss. But there is no way to reconstruct aggregated
>     sampling period when this happens.
> 2. L3 miss is not the actual event being counted. Rather, IBS will
>     count fetch, cycles or uOps depending on the configuration. Thus
>     sampling period have no direct connection to L3 misses.
> 
> 1st causes sampling period skew. Thus, I've added warning message at
> perf record:
> 
>    # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
>    WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
>    and tagged operation does not cause L3 Miss. This causes sampling period skew.
> 
> User can configure smaller sampling period to get more samples while
> using l3missonly.
> 
> 
> Ravi Bangoria (8):
>    perf record ibs: Warn about sampling period skew
>    perf tool: Parse pmu caps sysfs only once
>    perf headers: Pass "cpu" pmu name while printing caps
>    perf headers: Store pmu caps in an array of strings
>    perf headers: Record non-cpu pmu capabilities
>    perf/x86/ibs: Add new IBS register bits into header
>    perf tool ibs: Sync amd ibs header file
>    perf script ibs: Support new IBS bits in raw trace dump
> 
>   arch/x86/include/asm/amd-ibs.h                |  16 +-
>   tools/arch/x86/include/asm/amd-ibs.h          |  16 +-
>   .../Documentation/perf.data-file-format.txt   |  10 +-
>   tools/perf/arch/x86/util/evsel.c              |  49 +++++
>   tools/perf/builtin-inject.c                   |   2 +-
>   tools/perf/util/amd-sample-raw.c              |  68 +++++-
>   tools/perf/util/env.c                         |  62 +++++-
>   tools/perf/util/env.h                         |  14 +-
>   tools/perf/util/evsel.c                       |   7 +
>   tools/perf/util/evsel.h                       |   1 +
>   tools/perf/util/header.c                      | 196 ++++++++++--------
>   tools/perf/util/header.h                      |   2 +-
>   tools/perf/util/pmu.c                         |  15 +-
>   tools/perf/util/pmu.h                         |   2 +
>   14 files changed, 333 insertions(+), 127 deletions(-)
> 
