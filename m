Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2800346E733
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhLILES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:04:18 -0500
Received: from foss.arm.com ([217.140.110.172]:54212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhLILER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:04:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DCD61FB;
        Thu,  9 Dec 2021 03:00:44 -0800 (PST)
Received: from [10.57.82.128] (unknown [10.57.82.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C30863F73B;
        Thu,  9 Dec 2021 03:00:41 -0800 (PST)
Message-ID: <b52ef2f3-9e30-59a6-2aea-e46c93915868@arm.com>
Date:   Thu, 9 Dec 2021 11:00:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] coresight: Fail to open with return stacks if they
 are unavailable
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20211208160907.749482-1-james.clark@arm.com>
 <20211208160907.749482-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20211208160907.749482-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 16:09, James Clark wrote:
> Maintain consistency with the other options by failing to open when they
> aren't supported. For example ETM_OPT_TS, ETM_OPT_CTXTID2 and the newly
> added ETM_OPT_BRANCH_BROADCAST all return with -EINVAL if they are
> requested but not supported by hardware.
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
> index d2bafb50c66a..0a9bb943a5e5 100644
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

nit: While at this, please could you change the hard coded value
to ETM4_CFG_BIT_RETSTK ?

Otherwise, looks good to me

Suzuki
