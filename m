Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32D57B407
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiGTJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiGTJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:41:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2428237F3;
        Wed, 20 Jul 2022 02:41:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D992E1576;
        Wed, 20 Jul 2022 02:41:05 -0700 (PDT)
Received: from [10.57.41.17] (unknown [10.57.41.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7E7E3F73D;
        Wed, 20 Jul 2022 02:41:03 -0700 (PDT)
Message-ID: <a6928529-b5fd-0f65-b51c-1dca37716b2b@arm.com>
Date:   Wed, 20 Jul 2022 10:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 13/13] coresight: trace-id: Add debug & test macros to
 Trace ID allocation
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-14-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-14-mike.leach@linaro.org>
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
> Adds in a number of pr_debug macros to allow the debugging and test of
> the trace ID allocation system.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-trace-id.c  | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index dac9c89ae00d..841307e0d899 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -71,6 +71,27 @@ static int coresight_trace_id_find_new_id(struct coresight_trace_id_map *id_map)
>   	return id;
>   }
>   
> +/* #define TRACE_ID_DEBUG 1 */
> +#ifdef TRACE_ID_DEBUG
> +static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
> +					  const char *func_name)
> +{
> +	/* currently 2 u64s are sufficient to hold all the ids */
> +	pr_debug("%s id_map::\n", func_name);
> +	pr_debug("Avial= 0x%016lx%016lx\n", id_map->avail_ids[1], id_map->avail_ids[0]);
> +	pr_debug("Pend = 0x%016lx%016lx\n", id_map->pend_rel_ids[1], id_map->pend_rel_ids[0]);

minor nit: You may use bitmap_print_to_pagebuf() to print the bitmaps.

> +}
> +#define DUMP_ID_MAP(map)   coresight_trace_id_dump_table(map, __func__)
> +#define DUMP_ID_CPU(cpu, id) pr_debug("%s called;  cpu=%d, id=%d\n", __func__, cpu, id)
> +#define DUMP_ID(id)   pr_debug("%s called; id=%d\n", __func__, id)
> +#define PERF_SESSION(n) pr_debug("%s perf count %d\n", __func__, n)
> +#else
> +#define DUMP_ID_MAP(map)
> +#define DUMP_ID(id)
> +#define DUMP_ID_CPU(cpu, id)
> +#define PERF_SESSION(n)
> +#endif
> +
>   /* release all pending IDs for all current maps & clear CPU associations */
>   static void coresight_trace_id_release_all_pending(void)
>   {
> @@ -81,6 +102,7 @@ static void coresight_trace_id_release_all_pending(void)
>   		clear_bit(bit, id_map->avail_ids);
>   		clear_bit(bit, id_map->pend_rel_ids);
>   	}
> +	DUMP_ID_MAP(id_map);
>   
>   	for_each_possible_cpu(cpu) {
>   		if (per_cpu(cpu_ids, cpu).pend_rel) {
> @@ -126,6 +148,8 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>   
>   get_cpu_id_out:
>   	spin_unlock_irqrestore(&id_map_lock, flags);
> +	DUMP_ID_CPU(cpu, id);
> +	DUMP_ID_MAP(id_map);
>   	return id;
>   }
>   
> @@ -151,6 +175,8 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
>   
>    put_cpu_id_out:
>   	spin_unlock_irqrestore(&id_map_lock, flags);
> +	DUMP_ID_CPU(cpu, id);
> +	DUMP_ID_MAP(id_map);
>   }
>   
>   static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
> @@ -164,6 +190,8 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
>   		coresight_trace_id_set_inuse(id, id_map);
>   	spin_unlock_irqrestore(&id_map_lock, flags);
>   
> +	DUMP_ID(id);
> +	DUMP_ID_MAP(id_map);
>   	return id;
>   }
>   
> @@ -174,6 +202,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>   	spin_lock_irqsave(&id_map_lock, flags);
>   	coresight_trace_id_clear_inuse(id, id_map);
>   	spin_unlock_irqrestore(&id_map_lock, flags);
> +
> +	DUMP_ID(id);
> +	DUMP_ID_MAP(id_map);
>   }
>   
>   /* API functions */
> @@ -207,6 +238,7 @@ void coresight_trace_id_perf_start(void)
>   
	int n;

>   	spin_lock_irqsave(&id_map_lock, flags);
>   	perf_cs_etm_session_active++;
	n = perf_cs_etm_session_active++;


>   	spin_unlock_irqrestore(&id_map_lock, flags);

	PERF_SESSION(n);

Not a good idea to print something from within spin_lock.

>   }
>   EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
> @@ -217,6 +249,7 @@ void coresight_trace_id_perf_stop(void)
>   
>   	spin_lock_irqsave(&id_map_lock, flags);
>   	perf_cs_etm_session_active--;
> +	PERF_SESSION(perf_cs_etm_session_active);

Same as above.

>   	if (!perf_cs_etm_session_active)
>   		coresight_trace_id_release_all_pending();
>   	spin_unlock_irqrestore(&id_map_lock, flags);

Suzuki
