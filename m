Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6045265E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381854AbiEMPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381924AbiEMPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:19:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCD66C8A;
        Fri, 13 May 2022 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652455169; x=1683991169;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ILnv32Y4KW3e6en/eXkF78JI0qhV509E/SOG9iNNSsQ=;
  b=ema3e628yuMvYOqfQGeJTTpISsKWwd7AG60LxdLRDin/lnTpHj7K7nBh
   m52Tphe3FtXDRwR7VaH3mZlxNxc4zeGUkGTockLzRcF/ADl2mP9/kF1+R
   4weVt7y06txYlnIbRLlFMsEzITQ4lvmuTsj9w5T0iOJEYhfj0tG6jPcYW
   6nYal4vLjbfgm2aYKlCNBfA11FlU0xeZSvxQWiUd6vEpDAENQUBu/RmmO
   za7xplQbL7Kls4c285rFp2Ob8KbsruSYG06GFy1eJE4abQ/JGg4C1GOnG
   Saig9BlcHOcS2tE2CfQLdb6/HstSadpnkGx5aTBoN3lxiUmPpL2OQJVga
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270461295"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270461295"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="637320487"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2022 08:19:28 -0700
Received: from [10.252.212.211] (kliang2-MOBL.ccr.corp.intel.com [10.252.212.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EBC78580A88;
        Fri, 13 May 2022 08:19:25 -0700 (PDT)
Message-ID: <200b08cf-bdae-3d14-011e-fe2ae8173926@linux.intel.com>
Date:   Fri, 13 May 2022 11:19:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/2] Fix topdown event weak grouping
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220512061308.1152233-1-irogers@google.com>
 <8ba20985-8116-c7f7-a082-ec30152d9adb@linux.intel.com>
In-Reply-To: <8ba20985-8116-c7f7-a082-ec30152d9adb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2022 10:25 AM, Liang, Kan wrote:
> 
> 
> On 5/12/2022 2:13 AM, Ian Rogers wrote:
>> Keep topdown events within a group when a weak group is broken. This
>> is a requirement as topdown events must form a group.
>>
>> Add perf stat testing including for required topdown event group
>> behaviors.
>>
>> Note: as with existing topdown evsel/evlist code topdown events are
>> assumed to be on the PMU "cpu". On Alderlake the PMU "cpu_core" should
>> also be tested. Future changes can fix Alderlake.
> 
> I will send a follow-up patch to fix the weak grouping for the hybrid 
> platform shortly.
> 

Here it is.
https://lore.kernel.org/all/20220513151554.1054452-1-kan.liang@linux.intel.com/

Thanks,
Kan

> For the non-hybrid platform, the patch set looks good to me.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Thanks,
> Kan
> 
>>
>> v2. Correct behavior wrt pmu prefixed events and avoid the test using
>>      deprecated events: Suggested-by: Liang, Kan 
>> <kan.liang@linux.intel.com>
>>
>> Ian Rogers (2):
>>    perf evlist: Keep topdown counters in weak group
>>    perf test: Add basic stat and topdown group test
>>
>>   tools/perf/arch/x86/util/evsel.c | 12 ++++++
>>   tools/perf/tests/shell/stat.sh   | 67 ++++++++++++++++++++++++++++++++
>>   tools/perf/util/evlist.c         | 16 +++++++-
>>   tools/perf/util/evsel.c          | 10 +++++
>>   tools/perf/util/evsel.h          |  3 ++
>>   5 files changed, 106 insertions(+), 2 deletions(-)
>>   create mode 100755 tools/perf/tests/shell/stat.sh
>>
