Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471E551BEF3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376272AbiEEMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359821AbiEEMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:16:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A966554;
        Thu,  5 May 2022 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651752750; x=1683288750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BDDXxqsvFnMtjcWPwW5YtPVWaElUGdAmuf74+sGPYyk=;
  b=cDYB8TyBogrUIkoOnyzyg+Hc6MWMlvfRp0W9EcHK1Tqc0JdDy6p3PBiz
   ajLKoTQa+U+JRKhhcGzgb8HvSnP9K1pe/UARG2aI7RjQfUUmoDd9aMJxE
   7a1R4ixLUXCaUzzNu4oVnquPpGnBCHvphVr+TjlU7h9je4VveoU81/QSg
   8tHjwQcf5hleC2sPJRZzma+no/IFYQhMnDBkQ66Vl+2+ofrL6nxMq5U9F
   60d25uFyAkZdE2kX9Fsq8YGjAJOSfFaQ8KU9lU/IwJNeij7y7ZTVwYxws
   mVNq6Td5Abe/tOK8M/pBu46BTK0Kk9eOzlVWHE/ghLctzVwBmycDzKs6R
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247999298"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="247999298"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 05:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="568570346"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 05 May 2022 05:12:28 -0700
Received: from [10.252.209.228] (kliang2-MOBL.ccr.corp.intel.com [10.252.209.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C1E3A58093E;
        Thu,  5 May 2022 05:12:25 -0700 (PDT)
Message-ID: <cb6065af-7e3f-53fa-5d82-67be04ca833f@linux.intel.com>
Date:   Thu, 5 May 2022 08:12:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] perf test: Add basic stat and topdown group test
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220505043846.3165303-1-irogers@google.com>
 <20220505043846.3165303-2-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220505043846.3165303-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2022 12:38 AM, Ian Rogers wrote:
> Add a basic stat test.
> Add two tests of grouping behavior for topdown events. Topdown events
> are special as they must be grouped with the slots event first.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/stat.sh | 65 ++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100755 tools/perf/tests/shell/stat.sh
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> new file mode 100755
> index 000000000000..80869ea6debc
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +# perf stat tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +test_default_stat() {
> +  echo "Basic stat command test"
> +  if ! perf stat true 2>&1 | egrep -q "Performance counter stats for 'true':"
> +  then
> +    echo "Basic stat command test [Failed]"
> +    err=1
> +    return
> +  fi
> +  echo "Basic stat command test [Success]"
> +}
> +
> +test_topdown_groups() {
> +  # Topdown events must be grouped with the slots event first. Test that
> +  # parse-events reorders this.
> +  echo "Topdown event group test"
> +  if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
> +  then
> +    echo "Topdown event group test [Skipped event parsing failed]"
> +    return
> +  fi
> +  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | egrep -q "<not supported>"
> +  then
> +    echo "Topdown event group test [Failed events not supported]"
> +    err=1
> +    return
> +  fi
> +  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | egrep -q "<not supported>"
> +  then
> +    echo "Topdown event group test [Failed slots not reordered first]"
> +    err=1
> +    return
> +  fi
> +  echo "Topdown event group test [Success]"
> +}
> +
> +test_topdown_weak_groups() {
> +  # Weak groups break if the perf_event_open of multiple grouped events
> +  # fails. Breaking a topdown group causes the events to fail. Test a very large
> +  # grouping to see that the topdown events aren't broken out.
> +  echo "Topdown weak groups test"
> +  if ! perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring},branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,baclears.any,ARITH.DIVIDER_ACTIVE' true > /dev/null 2>&1
> +  then
> +    echo "Topdown weak groups test [Skipped event parsing failed]"
> +    return
> +  fi
> +  if perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,baclears.any,ARITH.DIVIDER_ACTIVE}:W' true 2>&1 | egrep -q "<not supported>"
> +  then
> +    echo "Topdown weak groups test [Failed events not supported]"
> +    err=1
> +    return
> +  fi
> +  echo "Topdown weak groups test [Success]"
> +}
> +

Should we check the existence of the slots event before the test?
The perf metrics feature only be available on the new platform after 
ICL. It doesn't work on Atom.

Also, I think the test may fails on the hybrid platform, since big core 
and small core have different formula for the topdown. I think we should 
avoid the test for the hybrid platform for now.
+Zhengjun, who is fixing the topdown gap for the hybrid platform. I 
think he may take care of the hybrid support later.

Thanks,
Kan
> +test_default_stat
> +test_topdown_groups
> +test_topdown_weak_groups
> +exit $err
