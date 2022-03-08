Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1594D0E93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbiCHESG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCHESF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:18:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EB153BA54;
        Mon,  7 Mar 2022 20:17:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A11FD6E;
        Mon,  7 Mar 2022 20:17:09 -0800 (PST)
Received: from [10.162.17.54] (a077893.blr.arm.com [10.162.17.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736533FA5D;
        Mon,  7 Mar 2022 20:17:06 -0800 (PST)
Message-ID: <9762d42e-d5eb-9ca7-9fdb-89eb85177765@arm.com>
Date:   Tue, 8 Mar 2022 09:47:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] perf: Add error message for unsupported branch stack
 cases
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     german.gomez@arm.com, leo.yan@linaro.com,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220307171917.2555829-1-james.clark@arm.com>
 <20220307171917.2555829-2-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220307171917.2555829-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/7/22 22:49, James Clark wrote:
> EOPNOTSUPP is a possible return value when branch stacks are requested
> but they aren't enabled in the kernel or hardware. It's also returned if
> they aren't supported on the specific event type. The currently printed

specific event type ? Events carrying certain branch sampling/filter flags
which could not be supported in the kernel on a given platform ?

> error message about sampling/overflow-interrupts is not correct in this
> case.
> 
> Add a check for branch stacks before sample_period is checked because
> sample_period is also set (to the default value) when using branch
> stacks.

Makes sense.

> 
> Before this change (when branch stacks aren't supported):
> 
>   perf record -j any
>   Error:
>   cycles: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> 
> After this change:
> 
>   perf record -j any
>   Error:
>   cycles: PMU Hardware or event type doesn't support branch stack sampling.

Indeed better in explaining what went wrong.

> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/evsel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 22d3267ce294..4e10a4ec11c7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2909,6 +2909,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  	 "No such device - did you specify an out-of-range profile CPU?");
>  		break;
>  	case EOPNOTSUPP:
> +		if (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK)
> +			return scnprintf(msg, size,
> +	"%s: PMU Hardware or event type doesn't support branch stack sampling.",
> +					 evsel__name(evsel));

As this is being added right at the beginning for returned EOPNOTSUPP error,
previous fall through behaviour for all other cases will be preserved.

>  		if (evsel->core.attr.aux_output)
>  			return scnprintf(msg, size,
>  	"%s: PMU Hardware doesn't support 'aux_output' feature",

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
