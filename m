Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732BE57B3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiGTJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiGTJaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:30:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B283912D0F;
        Wed, 20 Jul 2022 02:30:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 334571576;
        Wed, 20 Jul 2022 02:30:18 -0700 (PDT)
Received: from [10.57.41.17] (unknown [10.57.41.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3F913F73D;
        Wed, 20 Jul 2022 02:30:15 -0700 (PDT)
Message-ID: <312bce37-8201-e0a7-0122-77ec1ebef556@arm.com>
Date:   Wed, 20 Jul 2022 10:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 12/13] coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID
 used for Trace ID
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-13-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-13-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 09:11, Mike Leach wrote:
> Use the perf_report_aux_output_id() call to output the CoreSight trace ID
> and associated CPU as a PERF_RECORD_AUX_OUTPUT_HW_ID record in the
> perf.data file.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++++++
>   include/linux/coresight-pmu.h                    | 14 ++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index ad3fdc07c60b..531f5d42272b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -4,6 +4,7 @@
>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/coresight.h>
>   #include <linux/coresight-pmu.h>
>   #include <linux/cpumask.h>
> @@ -437,6 +438,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	struct perf_output_handle *handle = &ctxt->handle;
>   	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>   	struct list_head *path;
> +	u64 hw_id;
>   
>   	if (!csdev)
>   		goto fail;
> @@ -482,6 +484,11 @@ static void etm_event_start(struct perf_event *event, int flags)
>   	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>   		goto fail_disable_path;
>   
> +	/* output cpu / trace ID in perf record */
> +	hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK, CS_AUX_HW_ID_CURR_VERSION) |
> +		FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, coresight_trace_id_get_cpu_id(cpu));
> +	perf_report_aux_output_id(event, hw_id);
> +
>   out:
>   	/* Tell the perf core the event is alive */
>   	event->hw.state = 0;
> @@ -600,6 +607,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   
>   	/* Disabling the path make its elements available to other sessions */
>   	coresight_disable_path(path);
> +
> +	/* release the trace ID we read on event start */
> +	coresight_trace_id_put_cpu_id(cpu);
>   }
>   
>   static int etm_event_add(struct perf_event *event, int mode)
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 9f7ee380266b..5572d0e10822 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -7,6 +7,8 @@
>   #ifndef _LINUX_CORESIGHT_PMU_H
>   #define _LINUX_CORESIGHT_PMU_H
>   
> +#include <linux/bits.h>
> +
>   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
>   
>   /*
> @@ -38,4 +40,16 @@
>   #define ETM4_CFG_BIT_RETSTK	12
>   #define ETM4_CFG_BIT_VMID_OPT	15
>   
> +/*
> + * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
> + * Used to associate a CPU with the CoreSight Trace ID.
> + * [63:16] - unused SBZ
> + * [15:08] - Trace ID
> + * [07:00] - Version

Could we please re-arrange the fields, such that it is easier to
comprehend the TraceID looking at the raw trace dump ? Also to
accommodate the future changes.

e.g,
       [15:00] - Trace ID	 /* For future expansion, if at all */
       [59:16] - RES0
       [63:60] - Trace_ID_Version

I think we *might* (not sure yet) end up adding "sinkid" when we have
sink specific allocation, so that we can associate the HW_ID of an event
to the "AUXTRACE" record (i.e., trace buffer).

So if we need to do that we could:

       [15:00] - Trace ID	 /* For future expansion, if at all */
       [47:16] - Trace Pool ID( == 0 if global, == sink_id if sink based)
       [59:48] - RES0
       [63:60] - Trace_ID_Version == 1

Or we could adopt the above straight away.

Thoughts ?

Suzuki

> + */
> +#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(7, 0)
> +#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(15, 8)
> +
> +#define CS_AUX_HW_ID_CURR_VERSION 0


> +
>   #endif

