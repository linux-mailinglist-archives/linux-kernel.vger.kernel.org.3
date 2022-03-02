Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91754CA455
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbiCBMAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiCBMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:00:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A63BC33370;
        Wed,  2 Mar 2022 04:00:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58DDE13D5;
        Wed,  2 Mar 2022 04:00:03 -0800 (PST)
Received: from [10.1.26.154] (e127744.cambridge.arm.com [10.1.26.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A9853F70D;
        Wed,  2 Mar 2022 03:59:59 -0800 (PST)
Subject: Re: [PATCH v2 1/2] perf arm-spe: Use SPE data source for neoverse
 cores
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, leo.yan@linaro.org
Cc:     benh@kernel.crashing.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>
References: <20220221224807.18172-1-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <2733b4a4-dd73-0b71-5309-e2bf0cc70d4c@arm.com>
Date:   Wed, 2 Mar 2022 11:59:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220221224807.18172-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On 21/02/2022 22:47, Ali Saidi wrote:
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> the same encoding. I can't find encoding information for any other SPE
> implementations to unify their choices with Arm's thus that is left for
> future work.
>
> This change populates the mem_lvl_num for Neoverse cores instead of the
> deprecated mem_lvl namespace.
>
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
>  tools/perf/util/arm-spe.c                     | 106 +++++++++++++++---
>  3 files changed, 104 insertions(+), 15 deletions(-)
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
> index 69b31084d6be..c81bf90c0996 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -29,6 +29,17 @@ enum arm_spe_op_type {
>  	ARM_SPE_ST		= 1 << 1,
>  };
>  
> +enum arm_spe_neoverse_data_source {
> +	ARM_SPE_NV_L1D        = 0x0,
> +	ARM_SPE_NV_L2         = 0x8,
> +	ARM_SPE_NV_PEER_CORE  = 0x9,
> +	ARM_SPE_NV_LCL_CLSTR  = 0xa,
> +	ARM_SPE_NV_SYS_CACHE  = 0xb,
> +	ARM_SPE_NV_PEER_CLSTR = 0xc,
> +	ARM_SPE_NV_REMOTE     = 0xd,
> +	ARM_SPE_NV_DRAM       = 0xe,
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
> index d2b64e3f588b..e0243c2fed5f 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -34,6 +34,7 @@
>  #include "arm-spe-decoder/arm-spe-decoder.h"
>  #include "arm-spe-decoder/arm-spe-pkt-decoder.h"
>  
> +#include <../../../arch/arm64/include/asm/cputype.h>
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
> @@ -399,33 +401,103 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
>  	return false;
>  }
>  
> -static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
> -{
> -	union perf_mem_data_src	data_src = { 0 };
> +static const struct midr_range neoverse_spe[] = {
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +	{},
> +};
>  
> -	if (record->op == ARM_SPE_LD)
> -		data_src.mem_op = PERF_MEM_OP_LOAD;
> -	else
> -		data_src.mem_op = PERF_MEM_OP_STORE;
>  
> +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> +						union perf_mem_data_src *data_src)
> +{
> +	switch (record->source) {
> +	case ARM_SPE_NV_L1D:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;

I understand mem_lvl is deprecated but shouldn't we add the level bits here as well for backwards compat?

> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +		break;
> +	case ARM_SPE_NV_L2:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		break;
> +	case ARM_SPE_NV_PEER_CORE:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		break;
> +	/*
> +	 * We don't know if this is L1, L2, or even L3 (for the cases the system
> +	 * has an L3, but we do know it was a cache-2-cache transfer, so set
> +	 * SNOOP_HITM
> +	 */
> +	case ARM_SPE_NV_LCL_CLSTR:
> +	case ARM_SPE_NV_PEER_CLSTR:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		break;
> +	/*
> +	 * System cache is assumed to be L4, as cluster cache (if it exists)
> +	 * would be L3 cache on Neoverse platforms
> +	 */
> +	case ARM_SPE_NV_SYS_CACHE:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L4;
> +		break;
> +	/*
> +	 * We don't know what level it hit in, except it came from the other
> +	 * socket
> +	 */
> +	case ARM_SPE_NV_REMOTE:
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		break;
> +	case ARM_SPE_NV_DRAM:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
> +						union perf_mem_data_src *data_src)
> +{
>  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
> -		data_src.mem_lvl = PERF_MEM_LVL_L3;
> +		data_src->mem_lvl = PERF_MEM_LVL_L3;
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
> +	if (record->op & ARM_SPE_LD)
> +		data_src.mem_op = PERF_MEM_OP_LOAD;
> +	else
> +		data_src.mem_op = PERF_MEM_OP_STORE;
> +
> +	if (is_neoverse)
> +		arm_spe__synth_data_source_neoverse(record, &data_src);
> +	else
> +		arm_spe__synth_data_source_generic(record, &data_src);
>  
>  	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
>  		data_src.mem_dtlb = PERF_MEM_TLB_WK;
> @@ -446,7 +518,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  	u64 data_src;
>  	int err;
>  
> -	data_src = arm_spe__synth_data_source(record);
> +	data_src = arm_spe__synth_data_source(record, spe->midr);
>  
>  	if (spe->sample_flc) {
>  		if (record->type & ARM_SPE_L1D_MISS) {
> @@ -796,6 +868,10 @@ static int arm_spe_process_event(struct perf_session *session,
>  	u64 timestamp;
>  	struct arm_spe *spe = container_of(session->auxtrace,
>  			struct arm_spe, auxtrace);
> +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> +	u64 midr = strtol(cpuid, NULL, 16);
> +
> +	spe->midr = midr;

I think this midr setup belongs in the arm_spe_process_auxtrace_info callback instead.

Thanks,
German

>  
>  	if (dump_trace)
>  		return 0;
