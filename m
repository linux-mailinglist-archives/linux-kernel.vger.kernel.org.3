Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E2059D2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiHWH6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiHWH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:58:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B760D6580D;
        Tue, 23 Aug 2022 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661241480; x=1692777480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g/qFrIw80eV8aAKPCdwXA+FMeOS0C1mvsE+pHsY02Hs=;
  b=ARPx/FFiZVaxml+DkH+DLd9FdvGs2+GJ1N5Z3cipN+iMlWSBMV959UBq
   COpUhwf0Aed7Q4KX64eYZMnigTC4eg6/clLIZO3QAokQ/QoRnf2vr1xLc
   p4fo9TteWb86Hf6Vf4zttZCbufobP2CnWBOgeh0erawjESdRTITAHDJKi
   Ndg0fbMgj+cEZ7CodeJSlilJTRsKSIvEedfjkNl00qjAU/lePUHZ1RO1N
   rwJAZflKc+P8PhQPlXAzMWpcbM1sl7wzYDQeoVwIiDTl4wQkOZDrp9j9H
   mz7Xm1E0fxb+N6dla8hKAp+R2mopvp9SdWC4ReeoJbIHTsH1+2ZYUvih/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357599977"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="357599977"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:58:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="669914778"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.113]) ([10.238.4.113])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:57:56 -0700
Message-ID: <532d89be-63b1-acc2-ae20-8577f064e977@linux.intel.com>
Date:   Tue, 23 Aug 2022 15:57:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/2] perf stat: Clear reset_group for each stat run
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220822213352.75721-1-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220822213352.75721-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2022 5:33 AM, Ian Rogers wrote:
> If a weak group is broken then the reset_group flag remains set for
> the next run. Having reset_group set means the counter isn't created
> and ultimately a segfault.
> 
> A simple reproduction of this is:
> perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W

It is better to change to a full command:
perf stat -r2 -e 
'{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W' 
true
> which will be added as a test in the next patch.
> 
> Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> Signed-off-by: Ian Rogers <irogers@google.com>

I test the two patches on both non-hybrid and hybrid machines, and the 
"Segmentation fault" disappeared.

Tested-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   tools/perf/builtin-stat.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7fb81a44672d..54cd29d07ca8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -826,6 +826,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   	}
>   
>   	evlist__for_each_entry(evsel_list, counter) {
> +		counter->reset_group = false;
>   		if (bpf_counter__load(counter, &target))
>   			return -1;
>   		if (!evsel__is_bpf(counter))

-- 
Zhengjun Xing
