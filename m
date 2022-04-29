Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE7514111
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiD2DVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiD2DU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:20:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF97506E7;
        Thu, 28 Apr 2022 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651202259; x=1682738259;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=snCnGHa9hZi4XdlwTsNqqPFzYYo2+PjCPbRZGcUX4/g=;
  b=jNKEh/O/E+a/fYEtnccvV2YYcDfJXOr5qNC/sbc0NrMczow9aXln1xJJ
   JjVLEQgHcVs33WvDnZQmB+AdohkVksksZr1Nu7g3qS0qKSrrbnLPSIbV+
   6nS+7vp26iD7ChpDvMipzZnDOLIGC2u6fSFoLtC63ts3brw3HoL1FdQOY
   gniVZC/vrjAOXqed8/Azq7ve9sn2KuT4JuG3djlPKUQIoARfmFKk2tQi2
   F1lZFYKS79rCwTfHJYYbvWVDJa8OHmtbmx50oFSEyOQtec6B6uBOOrG1c
   aVyHpnkNV30cL77xaLGriOHgdXl7pTTCMrakG2hl19eQ4zdMBwS7UVgH9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="352943152"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="352943152"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 20:17:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="581822452"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.170.167]) ([10.249.170.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 20:17:35 -0700
Message-ID: <4ff0ca7c-8f41-374a-9862-3cb30c7d8d66@linux.intel.com>
Date:   Fri, 29 Apr 2022 11:17:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] perf vendor events intel: Add cpuid for
 sapphirerapids
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220428202912.1056444-1-irogers@google.com>
 <20220428202912.1056444-2-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220428202912.1056444-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/2022 4:29 AM, Ian Rogers wrote:
> Fixes compile time warnings:
> 
> pmu-events/pmu-events.c:27238:31: error: ‘pme_sapphirerapids’ defined but not used [-Werror=unused-const-variable=]
> 27238 | static const struct pmu_event pme_sapphirerapids[] = {
>        |                               ^~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 963a76fec277..4b47ac1b806d 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -41,6 +41,7 @@ GenuineIntel-6-A7,v1,icelake,core
>   GenuineIntel-6-6A,v1,icelakex,core
>   GenuineIntel-6-6C,v1,icelakex,core
>   GenuineIntel-6-86,v1,tremontx,core
> +GenuineIntel-6-8F,v1,sapphirerapids,core

In 
https://lore.kernel.org/all/20220413210503.3256922-3-irogers@google.com/, it 
has already added the cpuid for sapphirerapids

>   GenuineIntel-6-96,v1,elkhartlake,core
>   GenuineIntel-6-97,v1,alderlake,core
>   GenuineIntel-6-9A,v1,alderlake,core

-- 
Zhengjun Xing
