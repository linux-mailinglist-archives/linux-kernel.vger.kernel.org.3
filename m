Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF7526433
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380892AbiEMO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380911AbiEMO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:26:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB644506E3;
        Fri, 13 May 2022 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652451944; x=1683987944;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=9MO4Cg9SWuQ3cY0TApzliKOPUlU3hZ6Zqzm0n1CSgmQ=;
  b=jH37YUvTNIG8JhrJm8Z5bHHrMhGG/C7fJaIw75GrtL1ASiVim3V4mbLn
   BpF3DnCuXgwuskJ4XhVD6zj1RW4Bc6NjJoKL5AN9hzatXhzBkOlKbx2an
   t4RT5HLnFqrb+23ZNBavV/3aUNrP4p7awv9z5ZXxkHOGvp1reY0WVBrDn
   oAaESy5EpiTfmvpDowcqWJKwgyplXT9ypGro8QKpZ0ihWDVxaTtQml3y5
   +j5lDjEH68foidrwCH77ZL47L8NWWPYM/aostHFyyI7hLKZWb+SIH0MFt
   Uw30eyXx7PtXvSekBMEsB0FPitpZXNlXA7ZIYHDmlaNsObziLrW/jmB4V
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295575088"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="295575088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 07:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="659107033"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2022 07:25:43 -0700
Received: from [10.252.212.211] (kliang2-MOBL.ccr.corp.intel.com [10.252.212.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C7C4C580A88;
        Fri, 13 May 2022 07:25:40 -0700 (PDT)
Message-ID: <8ba20985-8116-c7f7-a082-ec30152d9adb@linux.intel.com>
Date:   Fri, 13 May 2022 10:25:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Fix topdown event weak grouping
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
Content-Language: en-US
In-Reply-To: <20220512061308.1152233-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2022 2:13 AM, Ian Rogers wrote:
> Keep topdown events within a group when a weak group is broken. This
> is a requirement as topdown events must form a group.
> 
> Add perf stat testing including for required topdown event group
> behaviors.
> 
> Note: as with existing topdown evsel/evlist code topdown events are
> assumed to be on the PMU "cpu". On Alderlake the PMU "cpu_core" should
> also be tested. Future changes can fix Alderlake.

I will send a follow-up patch to fix the weak grouping for the hybrid 
platform shortly.

For the non-hybrid platform, the patch set looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
> v2. Correct behavior wrt pmu prefixed events and avoid the test using
>      deprecated events: Suggested-by: Liang, Kan <kan.liang@linux.intel.com>
> 
> Ian Rogers (2):
>    perf evlist: Keep topdown counters in weak group
>    perf test: Add basic stat and topdown group test
> 
>   tools/perf/arch/x86/util/evsel.c | 12 ++++++
>   tools/perf/tests/shell/stat.sh   | 67 ++++++++++++++++++++++++++++++++
>   tools/perf/util/evlist.c         | 16 +++++++-
>   tools/perf/util/evsel.c          | 10 +++++
>   tools/perf/util/evsel.h          |  3 ++
>   5 files changed, 106 insertions(+), 2 deletions(-)
>   create mode 100755 tools/perf/tests/shell/stat.sh
> 
