Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11285AD1AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbiIELit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiIELir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:38:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 759705C34C;
        Mon,  5 Sep 2022 04:38:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803B9ED1;
        Mon,  5 Sep 2022 04:38:52 -0700 (PDT)
Received: from [10.57.16.151] (unknown [10.57.16.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20A63F7B4;
        Mon,  5 Sep 2022 04:38:44 -0700 (PDT)
Message-ID: <bbd9ca67-9538-8e0f-28d0-9b73957c8898@arm.com>
Date:   Mon, 5 Sep 2022 12:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 09/13] perf: cs-etm: Update record event to use new
 Trace ID protocol
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com
References: <20220823091009.14121-1-mike.leach@linaro.org>
 <20220823091009.14121-10-mike.leach@linaro.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220823091009.14121-10-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2022 10:10, Mike Leach wrote:
> Trace IDs are now dynamically allocated.
> 
> Previously used the static association algorithm that is no longer
> used. The 'cpu * 2 + seed' was outdated and broken for systems with high
> core counts (>46). as it did not scale and was broken for larger
> core counts.
> 
> Trace ID will now be sent in PERF_RECORD_AUX_OUTPUT_HW_ID record.
> 
> Legacy ID algorithm renamed and retained for limited backward
> compatibility use.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/include/linux/coresight-pmu.h | 30 +++++++++++++++++------------
>  tools/perf/arch/arm/util/cs-etm.c   | 21 ++++++++++++--------
>  2 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index db9c7c0abb6a..307f357defe9 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -10,11 +10,28 @@
>  #include <linux/bits.h>
>  
>  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> -#define CORESIGHT_ETM_PMU_SEED  0x10
> +
> +/*
> + * The legacy Trace ID system based on fixed calculation from the cpu
> + * number. This has been replaced by drivers using a dynamic allocation
> + * system - but need to retain the legacy algorithm for backward comparibility
> + * in certain situations:-
> + * a) new perf running on older systems that generate the legacy mapping
> + * b) older tools e.g. simpleperf in Android, that may not update at the same
> + *    time as the kernel.
> + */
> +#define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
>  
>  /* CoreSight trace ID is currently the bottom 7 bits of the value */
>  #define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
>  
> +/*
> + * perf record will set the legacy meta data values as unused initially.
> + * This allows perf report to manage the decoders created when dynamic
> + * allocation in operation.
> + */
> +#define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
> +
>  /*
>   * Below are the definition of bit offsets for perf option, and works as
>   * arbitrary values for all ETM versions.
> @@ -39,15 +56,4 @@
>  #define ETM4_CFG_BIT_RETSTK	12
>  #define ETM4_CFG_BIT_VMID_OPT	15
>  
> -static inline int coresight_get_trace_id(int cpu)
> -{
> -	/*
> -	 * A trace ID of value 0 is invalid, so let's start at some
> -	 * random value that fits in 7 bits and go from there.  Since
> -	 * the common convention is to have data trace IDs be I(N) + 1,
> -	 * set instruction trace IDs as a function of the CPU number.
> -	 */
> -	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> -}
> -
>  #endif
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 1b54638d53b0..196fe1a77de9 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -421,13 +421,16 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	evlist__to_front(evlist, cs_etm_evsel);
>  
>  	/*
> -	 * In the case of per-cpu mmaps, we need the CPU on the
> -	 * AUX event.  We also need the contextID in order to be notified
> +	 * get the CPU on the sample - need it to associate trace ID in the
> +	 * AUX_OUTPUT_HW_ID event, and the AUX event for per-cpu mmaps.
> +	 */
> +	evsel__set_sample_bit(cs_etm_evsel, CPU);
> +
> +	/*
> +	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
>  	 * when a context switch happened.
>  	 */
>  	if (!perf_cpu_map__empty(cpus)) {
> -		evsel__set_sample_bit(cs_etm_evsel, CPU);
> -
>  		err = cs_etm_set_option(itr, cs_etm_evsel,
>  					BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
>  		if (err)
> @@ -633,8 +636,10 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
>  
>  	/* Get trace configuration register */
>  	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
> -	/* Get traceID from the framework */
> -	data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> +	/* traceID set to legacy version, in case new perf running on older system */
> +	data[CS_ETMV4_TRCTRACEIDR] =
> +		CORESIGHT_LEGACY_CPU_TRACE_ID(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
> +
>  	/* Get read-only information from sysFS */
>  	data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
>  					       metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
> @@ -681,9 +686,9 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>  		magic = __perf_cs_etmv3_magic;
>  		/* Get configuration register */
>  		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
> -		/* Get traceID from the framework */
> +		/* traceID set to legacy value in case new perf running on old system */
>  		info->priv[*offset + CS_ETM_ETMTRACEIDR] =
> -						coresight_get_trace_id(cpu);
> +			CORESIGHT_LEGACY_CPU_TRACE_ID(cpu) | CORESIGHT_TRACE_ID_UNUSED_FLAG;
>  		/* Get read-only information from sysFS */
>  		info->priv[*offset + CS_ETM_ETMCCER] =
>  			cs_etm_get_ro(cs_etm_pmu, cpu,
