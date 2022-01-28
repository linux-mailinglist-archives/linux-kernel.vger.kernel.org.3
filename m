Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946EA49F841
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiA1LZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:25:30 -0500
Received: from foss.arm.com ([217.140.110.172]:37750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232001AbiA1LZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:25:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1FD113E;
        Fri, 28 Jan 2022 03:25:28 -0800 (PST)
Received: from [10.57.86.86] (unknown [10.57.86.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE14D3F766;
        Fri, 28 Jan 2022 03:25:25 -0800 (PST)
Message-ID: <25b85560-dd95-2569-d1bc-872902d6343f@arm.com>
Date:   Fri, 28 Jan 2022 11:25:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 3/6] perf cs-etm: Update deduction of TRCCONFIGR
 register for branch broadcast
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
 <20220113091056.1297982-4-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220113091056.1297982-4-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 09:10, James Clark wrote:
> Now that a config flag for branch broadcast has been added, take it into
> account when trying to deduce what the driver would have programmed the
> TRCCONFIGR register to.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/include/linux/coresight-pmu.h | 2 ++
>   tools/perf/arch/arm/util/cs-etm.c   | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 4ac5c081af93..6c2fd6cc5a98 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -18,6 +18,7 @@
>    * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>    * directly use below macros as config bits.
>    */
> +#define ETM_OPT_BRANCH_BROADCAST 8
>   #define ETM_OPT_CYCACC		12
>   #define ETM_OPT_CTXTID		14
>   #define ETM_OPT_CTXTID2		15
> @@ -25,6 +26,7 @@
>   #define ETM_OPT_RETSTK		29
>   
>   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> +#define ETM4_CFG_BIT_BB         3
>   #define ETM4_CFG_BIT_CYCACC	4
>   #define ETM4_CFG_BIT_CTXTID	6
>   #define ETM4_CFG_BIT_VMID	7
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 293a23bf8be3..c7ef4e9b4a3a 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -527,6 +527,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
>   	if (config_opts & BIT(ETM_OPT_CTXTID2))
>   		config |= BIT(ETM4_CFG_BIT_VMID) |
>   			  BIT(ETM4_CFG_BIT_VMID_OPT);
> +	if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
> +		config |= BIT(ETM4_CFG_BIT_BB);
> +
>   	return config;

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>   }
>   

