Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAF657884C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiGRR06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiGRR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:26:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172252A96B;
        Mon, 18 Jul 2022 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658165187; x=1689701187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DtUN5B7jxpyekGCrTuXMCcL4ou9ZK5JJGNt3LwquMZk=;
  b=YMOtUQzln3LeymZ/B4mT4C6Mz4oFu/R8oIzhiAUVCbUNW5YueeX0/dk4
   tsHyIpWqejC5LI1rFik1SS23LGkTb1J8hYjoTkKu7I0wdFEGIMVBLsfea
   u31NrDOjtdffH1U7Ur+BZCexppRhpmU0JbE3+0BAkW4S7a0GZYxrEfj8y
   kPkDfXy1omcKCcKdxQAJ5XrJh3OUH1LsTjtzPFeUyyie3THfUdLW20S+n
   cjUCuSlvOJtU2twKwHuOwuE3uBs+o91vCSxumTwNl9Pp+L64yqV+Ffxn5
   ryF8lC/IA/Q2SXExpQTSpgpuhzduwf0yAx14T8PH8F9XyYB75ISOzBcWN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="311962004"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="311962004"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 10:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="655376612"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2022 10:26:25 -0700
Received: from [10.252.209.6] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7FEE75808A1;
        Mon, 18 Jul 2022 10:26:23 -0700 (PDT)
Message-ID: <6dfdeeee-1c28-666d-1385-c4bcc493cc6a@linux.intel.com>
Date:   Mon, 18 Jul 2022 13:26:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v4 0/3] Add arch TSC frequency information
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220718164312.3994191-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220718164312.3994191-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-18 12:43 p.m., Ian Rogers wrote:
> The first patch adds the #system_tsc_freq literal to expr.c and
> computes it via cpuid. The second patches adds support for "older"
> processors by computing the value via /proc/cpuinfo. The third patch
> adds a test then the computation looks somewhat sensible.
> 
> Such a literal is useful to calculate things like the average
> frequency [1]. The TSC frequency isn't exposed by sysfs although some
> experimental drivers look to add it [2].
> 
> [1] https://github.com/intel/perfmon-metrics/blob/5ad9ef7056f31075e8178b9f1fb732af183b2c8d/SKX/metrics/perf/skx_metric_perf.json#L11
> [2] https://github.com/trailofbits/tsc_freq_khz
> 
> v4. Modified the patch order and separated out the test.
> v3. Added the cpuid approach from Kan Liang.
> v2. Adds warnings to make clear if things have changed/broken on future
>     Intel platforms. It also adds caching and an Intel specific that a
>     value is computed.
> 
> Ian Rogers (2):
>   perf tsc: Add cpuinfo fall back for arch_get_tsc_freq
>   perf test: Add test for #system_tsc_freq in metrics

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
> Kan Liang (1):
>   perf tsc: Add arch TSC frequency information
> 
>  tools/perf/arch/x86/util/cpuid.h  | 34 ++++++++++++++
>  tools/perf/arch/x86/util/header.c | 27 +++++------
>  tools/perf/arch/x86/util/tsc.c    | 77 +++++++++++++++++++++++++++++++
>  tools/perf/tests/expr.c           | 13 ++++++
>  tools/perf/util/expr.c            | 13 ++++++
>  tools/perf/util/tsc.h             |  1 +
>  6 files changed, 149 insertions(+), 16 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/cpuid.h
> 
