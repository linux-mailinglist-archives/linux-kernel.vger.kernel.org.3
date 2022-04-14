Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F8500CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbiDNMOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiDNMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:14:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9624E1DA7A;
        Thu, 14 Apr 2022 05:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D8C7B82930;
        Thu, 14 Apr 2022 12:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF48CC385A1;
        Thu, 14 Apr 2022 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938303;
        bh=yq4Inui/1X0vvUnwwEOZAfKxPHOlTJEN4naHS4UCfpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nq5AhZ8omX6oS/4LvhB4e+c8egQy/zKBFySE7dI7QkrvviOnT3TSmRUOTCmVRSact
         5x6NoFFWv9/LMFC9a5xqvxzXqbLwoyoyKDaXP8jIb4VjskqGLPHVKROaWIdjM4fREE
         Tmbr2eILYX+k7SyvhS8Tg49fKWjUph28lov2knBq2rg4Q9DjerXXvXaZOLqTvawNpn
         nK17pHmL1wKa4qN075lFhT5V610etTpbnQZ3nJg4CKY1N814jP9cxsQlmyhp1NVDeI
         eE0mibFc8xR22QokRWQL6sRXOB5tjJY7daJdrfw/grtIf98tOIG2MSTYXCzdYw11IC
         VoC0dQxvUU2tQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7B2E40407; Thu, 14 Apr 2022 09:11:40 -0300 (-03)
Date:   Thu, 14 Apr 2022 09:11:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/14] perf vendor events intel: Fix icelake cstate
 metrics
Message-ID: <YlgPfGlbnsmd6RJW@kernel.org>
References: <20220413210503.3256922-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 13, 2022 at 02:04:50PM -0700, Ian Rogers escreveu:
> Apply cstate fix from:
> https://github.com/intel/event-converter-for-linux-perf/
> so that metrics for cstates that exist on the particular architecture
> are generated. This corrects issues with metric testing.
> 
> Also correct topic of ASSISTS.ANY event.

I would really appreciate acks/reviewed-by tags for these,

Thanks!

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../arch/x86/icelake/icl-metrics.json         | 24 ++++++++++++++-----
>  .../pmu-events/arch/x86/icelake/other.json    | 14 +----------
>  .../pmu-events/arch/x86/icelake/pipeline.json | 14 ++++++++++-
>  3 files changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> index 4af23c04dc18..ea73bc1889ba 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> @@ -408,12 +408,6 @@
>          "MetricGroup": "Branches;OS",
>          "MetricName": "IpFarBranch"
>      },
> -    {
> -        "BriefDescription": "C3 residency percent per core",
> -        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
> -        "MetricGroup": "Power",
> -        "MetricName": "C3_Core_Residency"
> -    },
>      {
>          "BriefDescription": "C6 residency percent per core",
>          "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
> @@ -449,5 +443,23 @@
>          "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
>          "MetricGroup": "Power",
>          "MetricName": "C7_Pkg_Residency"
> +    },
> +    {
> +        "BriefDescription": "C8 residency percent per package",
> +        "MetricExpr": "(cstate_pkg@c8\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C8_Pkg_Residency"
> +    },
> +    {
> +        "BriefDescription": "C9 residency percent per package",
> +        "MetricExpr": "(cstate_pkg@c9\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C9_Pkg_Residency"
> +    },
> +    {
> +        "BriefDescription": "C10 residency percent per package",
> +        "MetricExpr": "(cstate_pkg@c10\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C10_Pkg_Residency"
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf/pmu-events/arch/x86/icelake/other.json
> index 08f6321025e8..2e177f95a9cb 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
> @@ -1,16 +1,4 @@
>  [
> -    {
> -        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0xc1",
> -        "EventName": "ASSISTS.ANY",
> -        "PEBScounters": "0,1,2,3,4,5,6,7",
> -        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x7"
> -    },
>      {
>          "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the Non-AVX turbo schedule.",
>          "CollectPEBSRecord": "2",
> @@ -407,4 +395,4 @@
>          "Speculative": "1",
>          "UMask": "0x1"
>      }
> -]
> \ No newline at end of file
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> index 573ac7ac8879..2b58cfaaaf39 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> @@ -12,6 +12,18 @@
>          "Speculative": "1",
>          "UMask": "0x9"
>      },
> +    {
> +        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xc1",
> +        "EventName": "ASSISTS.ANY",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x7"
> +    },
>      {
>          "BriefDescription": "All branch instructions retired.",
>          "CollectPEBSRecord": "2",
> @@ -1102,4 +1114,4 @@
>          "SampleAfterValue": "1000003",
>          "UMask": "0x2"
>      }
> -]
> \ No newline at end of file
> +]
> -- 
> 2.36.0.rc0.470.gd361397f0d-goog

-- 

- Arnaldo
