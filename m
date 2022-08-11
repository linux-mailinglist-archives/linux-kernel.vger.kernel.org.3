Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D259087A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiHKWBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiHKWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:01:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8CA91D07;
        Thu, 11 Aug 2022 15:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70093B822ED;
        Thu, 11 Aug 2022 22:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA53AC433D6;
        Thu, 11 Aug 2022 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660255266;
        bh=1YmCozBGTlRFKiCqPV3z2QdQjg9YCH+DtRhVqSwDkZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/OuDjsr4kj4URawyCTk6MvUynjqZIXH1BgBSQW0aReXFH9ZtG5D8fdbdCfnOL60n
         /9UBa4iNL1ChWGKr6aU0U9mP8toRboYARgUO8/EZNwnXyyzESgTxgHyEbyBWLZUtrp
         Ab99asEJO7Wh/5H6AAcieJdvJ1G/CK2hRRYky7WgwGSY1eCV6xsOpQpTe3HkJ6kdXj
         b7VKBoKM9LLmvAtj635BaYsroksHyr68yBIhxp/MT5q5jwcYmXMqWPzxOAG6/jks1Q
         a+u5jZ4Ac2GZbbzsJxc7vuLr1ZwaPIe5hrYBVVU9pi2RxLq3DnOeHX91lWwm0Gpi4N
         71/u6IGrKwX+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D6064035A; Thu, 11 Aug 2022 19:01:03 -0300 (-03)
Date:   Thu, 11 Aug 2022 19:01:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 03/15] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <YvV8H8kZ59mr1un4@kernel.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
 <20220811062451.435810-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220811062451.435810-4-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 11, 2022 at 02:24:39PM +0800, Leo Yan escreveu:
> From: Ali Saidi <alisaidi@amazon.com>
> 
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> the same encoding. I can't find encoding information for any other SPE
> implementations to unify their choices with Arm's thus that is left for
> future work.
> 
> This change populates the mem_lvl_num for Neoverse cores as well as the
> deprecated mem_lvl namespace.

So at this point, building on x86_64, I get:

In file included from util/arm-spe.c:37:
util/../../arch/arm64/include/asm/cputype.h:183:10: fatal error: asm/sysreg.h: No such file or directory
  183 | #include <asm/sysreg.h>
      |          ^~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/arm-spe.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf/util/arm-spe-decoder/perf-in.o
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:660: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':

    12,163,704,676      cycles:u
    20,601,569,045      instructions:u                   #    1.69  insn per cycle

       3.733981168 seconds time elapsed

       2.897595000 seconds user
       1.446798000 seconds sys


⬢[acme@toolbox perf]$

I saw a patch floating by that seems related, will check.

- Arnaldo
 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
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
> index d040406f3314..22dcfe07e886 100644
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
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
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
> +		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
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
> @@ -1178,6 +1273,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
>  	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
>  	struct perf_record_time_conv *tc = &session->time_conv;
> +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> +	u64 midr = strtol(cpuid, NULL, 16);
>  	struct arm_spe *spe;
>  	int err;
>  
> @@ -1197,6 +1294,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	spe->machine = &session->machines.host; /* No kvm support */
>  	spe->auxtrace_type = auxtrace_info->type;
>  	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	spe->midr = midr;
>  
>  	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
>  
> -- 
> 2.34.1

-- 

- Arnaldo
