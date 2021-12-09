Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6246E566
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhLIJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:24:58 -0500
Received: from foss.arm.com ([217.140.110.172]:52196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232940AbhLIJY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:24:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DF6011FB;
        Thu,  9 Dec 2021 01:21:24 -0800 (PST)
Received: from [10.57.82.128] (unknown [10.57.82.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D31C3F73B;
        Thu,  9 Dec 2021 01:21:22 -0800 (PST)
Message-ID: <b49450ca-5193-5815-8355-41ef133f3015@arm.com>
Date:   Thu, 9 Dec 2021 09:21:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] coresight: Add config flag to enable branch broadcast
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
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20211208160907.749482-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 16:09, James Clark wrote:
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
>   drivers/hwtracing/coresight/coresight-etm-perf.c   | 2 ++
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 +++++++++
>   include/linux/coresight-pmu.h                      | 2 ++
>   3 files changed, 13 insertions(+)
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
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index bf18128cf5de..d2bafb50c66a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -692,6 +692,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
>   	}
>   
> +	/* branch broadcast - enable if selected and supported */
> +	if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
> +		if (!drvdata->trcbb) {
> +			ret = -EINVAL;
> +			goto out;
> +		} else
> +			config->cfg |= BIT(ETM4_CFG_BIT_BB);

nit: For consistent styling, I would recommend to wrap the else case
also in { }.

Otherwise looks good to me.

Suzuki
