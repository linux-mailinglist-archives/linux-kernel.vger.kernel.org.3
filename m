Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13135181D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiECKCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiECKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:02:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982F836B4D;
        Tue,  3 May 2022 02:58:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15F97ED1;
        Tue,  3 May 2022 02:58:42 -0700 (PDT)
Received: from [10.1.28.130] (e127744.cambridge.arm.com [10.1.28.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 222693F73D;
        Tue,  3 May 2022 02:58:37 -0700 (PDT)
Subject: Re: [PATCH v7 5/5] perf arm-spe: Use SPE data source for neoverse
 cores
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, leo.yan@linaro.org,
        acme@kernel.org
Cc:     benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220426135937.18497-1-alisaidi@amazon.com>
 <20220426135937.18497-6-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com>
Date:   Tue, 3 May 2022 10:58:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220426135937.18497-6-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali, Leo

Some minor comments below.

On 26/04/2022 14:59, Ali Saidi wrote:
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> the same encoding. I can't find encoding information for any other SPE
> implementations to unify their choices with Arm's thus that is left for
> future work.
>
> This change populates the mem_lvl_num for Neoverse cores as well as the
> deprecated mem_lvl namespace.
>
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
>  tools/perf/util/arm-spe.c                     | 130 +++++++++++++++---
>  3 files changed, 127 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 5e390a1a79ab..091987dd3966 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -220,6 +220,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  
>  			break;
>  		case ARM_SPE_DATA_SOURCE:
> +			decoder->record.source = payload;
>  			break;
>  		case ARM_SPE_BAD:
>  			break;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 69b31084d6be..46a61df1145b 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -29,6 +29,17 @@ enum arm_spe_op_type {
>  	ARM_SPE_ST		= 1 << 1,
>  };
>  
> +enum arm_spe_neoverse_data_source {
> +	ARM_SPE_NV_L1D		 = 0x0,
> +	ARM_SPE_NV_L2		 = 0x8,
> +	ARM_SPE_NV_PEER_CORE	 = 0x9,
> +	ARM_SPE_NV_LOCAL_CLUSTER = 0xa,
> +	ARM_SPE_NV_SYS_CACHE	 = 0xb,
> +	ARM_SPE_NV_PEER_CLUSTER	 = 0xc,
> +	ARM_SPE_NV_REMOTE	 = 0xd,
> +	ARM_SPE_NV_DRAM		 = 0xe,
> +};
> +
>  struct arm_spe_record {
>  	enum arm_spe_sample_type type;
>  	int err;
> @@ -40,6 +51,7 @@ struct arm_spe_record {
>  	u64 virt_addr;
>  	u64 phys_addr;
>  	u64 context_id;
> +	u16 source;
>  };
>  
>  struct arm_spe_insn;
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index e032efc03274..4065fa180140 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -34,6 +34,7 @@
>  #include "arm-spe-decoder/arm-spe-decoder.h"
>  #include "arm-spe-decoder/arm-spe-pkt-decoder.h"
>  
> +#include "../../arch/arm64/include/asm/cputype.h"
>  #define MAX_TIMESTAMP (~0ULL)
>  
>  struct arm_spe {
> @@ -45,6 +46,7 @@ struct arm_spe {
>  	struct perf_session		*session;
>  	struct machine			*machine;
>  	u32				pmu_type;
> +	u64				midr;
>  
>  	struct perf_tsc_conversion	tc;
>  
> @@ -387,35 +389,128 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
>  
> -static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
> +static const struct midr_range neoverse_spe[] = {
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> +	{},
> +};
> +
> +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> +						union perf_mem_data_src *data_src)
>  {
> -	union perf_mem_data_src	data_src = { 0 };
> +	/*
> +	 * Even though four levels of cache hierarchy are possible, no known
> +	 * production Neoverse systems currently include more than three levels
> +	 * so for the time being we assume three exist. If a production system
> +	 * is built with four the this function would have to be changed to
> +	 * detect the number of levels for reporting.
> +	 */
>  
> -	if (record->op == ARM_SPE_LD)
> -		data_src.mem_op = PERF_MEM_OP_LOAD;
> -	else if (record->op == ARM_SPE_ST)
> -		data_src.mem_op = PERF_MEM_OP_STORE;
> -	else
> -		return 0;
> +	/*
> +	 * We have no data on the hit level or data source for stores in the
> +	 * Neoverse SPE records.
> +	 */
> +	if (record->op & ARM_SPE_ST) {
> +		data_src->mem_lvl = PERF_MEM_LVL_NA;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

Is it correct to use ANY_CACHE as the NA value? The LVLNUM_* enum begins at 1, so it looks like this should be set to 0 instead (like in HOPS_*).

> +		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> +		return;
> +	}
> +
> +	switch (record->source) {
> +	case ARM_SPE_NV_L1D:
> +		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_NV_L2:
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_NV_PEER_CORE:
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	/*
> +	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
> +	 * transfer, so set SNOOPX_PEER
> +	 */
> +	case ARM_SPE_NV_LOCAL_CLUSTER:
> +	case ARM_SPE_NV_PEER_CLUSTER:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		break;
> +	/*
> +	 * System cache is assumed to be L3
> +	 */
> +	case ARM_SPE_NV_SYS_CACHE:
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> +		break;
> +	/*
> +	 * We don't know what level it hit in, except it came from the other
> +	 * socket
> +	 */
> +	case ARM_SPE_NV_REMOTE:
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> +		break;
> +	case ARM_SPE_NV_DRAM:
> +		data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	default:
> +		break;
> +	}
> +}
>  
> +static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
> +					       union perf_mem_data_src *data_src)
> +{
>  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
> -		data_src.mem_lvl = PERF_MEM_LVL_L3;
> +		data_src->mem_lvl = PERF_MEM_LVL_L3;

Thanks for addressing my previous comment about filling both mem_lvl and mem_lvl_num.

I wonder if it's also worth updating for the non-Neoverse cores as well while we're at it. I'll let Leo decide since this patchset is only focused on Neoverse.

Aside from these comments, this change also looks good to me. Thanks for catching the things I missed in my previous review.

Reviewed-by: German Gomez <german.gomez@arm.com>

>  
>  		if (record->type & ARM_SPE_LLC_MISS)
> -			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> +			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
>  		else
> -			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> +			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
>  	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
> -		data_src.mem_lvl = PERF_MEM_LVL_L1;
> +		data_src->mem_lvl = PERF_MEM_LVL_L1;
>  
>  		if (record->type & ARM_SPE_L1D_MISS)
> -			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> +			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
>  		else
> -			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> +			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
>  	}
>  
>  	if (record->type & ARM_SPE_REMOTE_ACCESS)
> -		data_src.mem_lvl |= PERF_MEM_LVL_REM_CCE1;
> +		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
> +}
> +
> +static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
> +{
> +	union perf_mem_data_src	data_src = { 0 };
> +	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
> +
> +	if (record->op == ARM_SPE_LD)
> +		data_src.mem_op = PERF_MEM_OP_LOAD;
> +	else if (record->op == ARM_SPE_ST)
> +		data_src.mem_op = PERF_MEM_OP_STORE;
> +	else
> +		return 0;
> +
> +	if (is_neoverse)
> +		arm_spe__synth_data_source_neoverse(record, &data_src);
> +	else
> +		arm_spe__synth_data_source_generic(record, &data_src);
>  
>  	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
>  		data_src.mem_dtlb = PERF_MEM_TLB_WK;
> @@ -436,7 +531,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  	u64 data_src;
>  	int err;
>  
> -	data_src = arm_spe__synth_data_source(record);
> +	data_src = arm_spe__synth_data_source(record, spe->midr);
>  
>  	if (spe->sample_flc) {
>  		if (record->type & ARM_SPE_L1D_MISS) {
> @@ -1177,6 +1272,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
>  	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
>  	struct perf_record_time_conv *tc = &session->time_conv;
> +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> +	u64 midr = strtol(cpuid, NULL, 16);
>  	struct arm_spe *spe;
>  	int err;
>  
> @@ -1196,6 +1293,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	spe->machine = &session->machines.host; /* No kvm support */
>  	spe->auxtrace_type = auxtrace_info->type;
>  	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	spe->midr = midr;
>  
>  	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
>  
