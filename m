Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13949F81A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbiA1LTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:19:44 -0500
Received: from foss.arm.com ([217.140.110.172]:37426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348131AbiA1LTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:19:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD95B113E;
        Fri, 28 Jan 2022 03:19:32 -0800 (PST)
Received: from [10.57.86.86] (unknown [10.57.86.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E7163F766;
        Fri, 28 Jan 2022 03:19:30 -0800 (PST)
Message-ID: <b3545a88-4743-db95-4676-b0b193cbea78@arm.com>
Date:   Fri, 28 Jan 2022 11:19:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/6] coresight: Add config flag to enable branch
 broadcast
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
 <20220113091056.1297982-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220113091056.1297982-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 09:10, James Clark wrote:
> When enabled, all taken branch addresses are output, even if the branch
> was because of a direct branch instruction. This enables reconstruction
> of the program flow without having access to the memory image of the
> code being executed.
> 
> Use bit 8 for the config option which would be the correct bit for
> programming ETMv3. Although branch broadcast can't be enabled on ETMv3
> because it's not in the define ETM3X_SUPPORTED_OPTIONS, using the
> correct bit might help prevent future collisions or allow it to be
> enabled if needed.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
>   include/linux/coresight-pmu.h                      |  2 ++
>   3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c039b6ae206f..43bbd5dc3d3b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -52,6 +52,7 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>    * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
>    * now take them as general formats and apply on all ETMs.
>    */
> +PMU_FORMAT_ATTR(branch_broadcast, "config:"__stringify(ETM_OPT_BRANCH_BROADCAST));
>   PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
>   /* contextid1 enables tracing CONTEXTIDR_EL1 for ETMv4 */
>   PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
> @@ -97,6 +98,7 @@ static struct attribute *etm_config_formats_attr[] = {
>   	&format_attr_sinkid.attr,
>   	&format_attr_preset.attr,
>   	&format_attr_configid.attr,
> +	&format_attr_branch_broadcast.attr,

Does it make sense to hide the option if the bb is not supported ? I 
guess it will be tricky as we don't track the common feature set. So,
that said...

>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index bf18128cf5de..04669ecc0efa 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -692,6 +692,16 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
>   	}
>   
> +	/* branch broadcast - enable if selected and supported */
> +	if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
> +		if (!drvdata->trcbb) {
> +			ret = -EINVAL;

Should we fail here ? We could simply ignore this and generate the trace 
normally. This would work on a big.LITTLE system with one set missing 
the branch broadcast, while the others support.

Mike,

Does this affect the trace decoding ? As such the OpenCSD should be able
to decode the packets as they appear in the stream. Correct ?

Suzuki


> +			goto out;
> +		} else {
> +			config->cfg |= BIT(ETM4_CFG_BIT_BB);
> +		}
> +	}
> +
>   out:
>   	return ret;
>   }
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 4ac5c081af93..6c2fd6cc5a98 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
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

