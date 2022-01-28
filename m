Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63E849F83B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiA1LY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:24:27 -0500
Received: from foss.arm.com ([217.140.110.172]:37672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbiA1LYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:24:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5332C113E;
        Fri, 28 Jan 2022 03:24:18 -0800 (PST)
Received: from [10.57.86.86] (unknown [10.57.86.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C28993F766;
        Fri, 28 Jan 2022 03:24:15 -0800 (PST)
Message-ID: <50e5ff63-ae00-f04b-fc5b-f294742cb13a@arm.com>
Date:   Fri, 28 Jan 2022 11:24:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 2/6] coresight: Fail to open with return stacks if they
 are unavailable
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        mike.leach@linaro.org
Cc:     Leo Yan <leo.yan@linaro.org>, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220113091056.1297982-1-james.clark@arm.com>
 <20220113091056.1297982-3-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220113091056.1297982-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On 13/01/2022 09:10, James Clark wrote:
> Maintain consistency with the other options by failing to open when they
> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
> requested but not supported by hardware.

Looking at this again (with similar comment to the Branch Broadcast),
won't it disable using retstack on all CPUs, even when some of them
support it ?

i.e., CPU0 - supports retstack, CPU1 - doesn't

A perf run with retstack will fail, as CPU1 doesn't support it (even
though we advertise it, unconditionally).

So, if we ignore the failure, this would still allow CPU0 to use
the feature and as long as the OpenCSD is able to decode the trace
we should ignore the failure ?

I think we may also need to tune the etm4x_enable_hw() to skip
updating the TRCCONFIGR with features not supported by the ETM

Suzuki


> 
> The consequence of not doing this is that the user may not be
> aware that they are not enabling the feature as it is silently disabled.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 04669ecc0efa..a93c1a5fe045 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -674,10 +674,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   	}
>   
>   	/* return stack - enable if selected and supported */
> -	if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
> -		/* bit[12], Return stack enable bit */
> -		config->cfg |= BIT(12);
> -
> +	if (attr->config & BIT(ETM_OPT_RETSTK)) {
> +		if (!drvdata->retstack) {
> +			ret = -EINVAL;
> +			goto out;
> +		} else {
> +			/* bit[12], Return stack enable bit */
> +			config->cfg |= BIT(12);
> +		}
> +	}
>   	/*
>   	 * Set any selected configuration and preset.
>   	 *

