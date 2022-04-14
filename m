Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3165017AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbiDNPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352692AbiDNPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:17:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B253939E4;
        Thu, 14 Apr 2022 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649948586; x=1681484586;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/VBlTs3jL1nxbmcrZIkwzXIXkP2p4Qd9Cgidy2UuOOY=;
  b=Yn8zFvGHL+4eYN3VxM/LSQ0xlmE/L8jysmkHJMpv+RVGZGiiJyhbciZi
   btaipoEOC0ISsh/d36HlUBc7Rn/WyuaRfymR52s6RwHT5ICm8DNFA9vwy
   DxPEfRswD3sWYhO64PdAzA0OGtG5zpP2Nb029A6V0bxfbfdwOM11yCJnX
   3cqBckhvcf7oFopQigkb6v+Ke+rGdAuOE8BIrD3f3Sshn1JUhnxcs9Tib
   6gO7sFws0cnH0TE9kyjCvN5K6QzrUpe+tLQ7C19cyVA50m4oy/1MH8VvA
   La+zdQYvjck+cDBnkeEDPgNP/xl7D/fql9B1voYeCKHasxfKJ3bPoNvPa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="263126626"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="263126626"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 08:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="725392121"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2022 08:03:05 -0700
Received: from [10.209.96.223] (kliang2-MOBL.ccr.corp.intel.com [10.209.96.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 811035805BD;
        Thu, 14 Apr 2022 08:03:04 -0700 (PDT)
Message-ID: <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
Date:   Thu, 14 Apr 2022 11:03:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/14] perf vendor events intel: Add sapphirerapids events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220413210503.3256922-1-irogers@google.com>
 <20220413210503.3256922-3-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220413210503.3256922-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 5:04 PM, Ian Rogers wrote:
> Events were generated from 01.org using:
> https://github.com/intel/event-converter-for-linux-perf
> 
> Signed-off-by: Ian Rogers<irogers@google.com>
> ---
>   tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
>   .../arch/x86/sapphirerapids/cache.json        | 1083 ++++++++++++++
>   .../x86/sapphirerapids/floating-point.json    |  218 +++
>   .../arch/x86/sapphirerapids/frontend.json     |  471 ++++++
>   .../arch/x86/sapphirerapids/memory.json       |  415 ++++++
>   .../arch/x86/sapphirerapids/other.json        |  329 +++++
>   .../arch/x86/sapphirerapids/pipeline.json     | 1271 +++++++++++++++++
>   .../x86/sapphirerapids/virtual-memory.json    |  225 +++

Thank you very much Ian for the patches. They all looks good to me.

     Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

BTW: I think the uncore events for SPR are also published in 01.org.
Do you have plan to add them later?

Thanks,
Kan
