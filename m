Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653065083B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376834AbiDTIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376816AbiDTIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:45:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21493B03B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:42:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v4so1331153edl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MVCMmRDupWVNp3EektJX9PkYrpmkhE+GVak1SDvod4s=;
        b=Z+Fg+M32NBiEVbQoBiuviPChWxOW0h+dqN5hlHC8pitQtK+k1M+fgW34j9uiVvIWEG
         E5gBbUqeaBL6PhIWrlus/Fn90V+tVSvoRfC5RXK3GKiZuQ5yuoom618SH2AWzPowvKTm
         Y9tevSi7LVtSfP/RCgn96XUAX4R7ZtPJpGrvomwprD0ARWN5vCvx9LSq3g7MGB2jJEd2
         jkQnvi9xRkI7M5BTFhQRuzQTa2XUe+zu/7mU6dsAFOJ1z8MX0tn19rxmVS2UmD+ThaD/
         yH1rojDNZIF6IBs/hvPHWbtZDXPR67OiqeSUGwchaEwhSqNkRNLvtgJsOhVPO1K2qpYu
         Pa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MVCMmRDupWVNp3EektJX9PkYrpmkhE+GVak1SDvod4s=;
        b=PTL4O7WFQCwu/UsRGifBu+Q8AYFlqfzJ4l4gvnYnmOy44mWD+aJhOMCtbwA4Z4SnBH
         2pydZtrbpJSbpmuKeiX3nDAfCOnOv9HZ60nQCMIuTEru0WkPB426+Avc8M+H2SjJbllB
         1W8mG+JT4uFojwzi+vq5I3l8m2KdMTvuWIOlx5J/FsBZI036AuPvdrg7sQXwVcB46cwt
         WuYLE7TD/fVfUlsAh4zFIK4FA+A0fk+C8KeghmRCIavuO0a4Cn/SAjuJjHxyiP1844W1
         SwwG6W8Yu2pEdqFnze2RlqPxQYUWptdB/xifs33CqpqA+LC5gVEArquxvuBJZGZyQnGM
         gy0g==
X-Gm-Message-State: AOAM531MxqkLSkHDLPkLTKTqTodHAHz9S+/CCMPZEQqikNgvnO+XKH9T
        qi9nkwzHXN14QsuHGpIBPAC6sm4z6njmbpDBreJXEg==
X-Google-Smtp-Source: ABdhPJzq+UmiGH73w3WVb5N/f0UxlU+a3ZjIu42E1R9z8JmIzVcN5CFnOiOVzq7f9t99+Tm82GSmzQ==
X-Received: by 2002:a05:6402:34c9:b0:423:deb7:f69e with SMTP id w9-20020a05640234c900b00423deb7f69emr17014053edc.335.1650444165378;
        Wed, 20 Apr 2022 01:42:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm9529157edt.92.2022.04.20.01.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:42:44 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:42:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        acme@kernel.org, benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 4/5] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220420084237.GD843168@leoy-ThinkPad-X240s>
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-5-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408195344.32764-5-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:53:43PM +0000, Ali Saidi wrote:
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
>  tools/perf/util/arm-spe.c                     | 127 ++++++++++++++++--
>  3 files changed, 126 insertions(+), 14 deletions(-)
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
> index d2b64e3f588b..a20285cf98e3 100644
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
> @@ -399,33 +401,127 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
>  	return false;
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
> -	else
> -		data_src.mem_op = PERF_MEM_OP_STORE;
> +	/*
> +	 * We have no data on the hit level or data source for stores in the
> +	 * Neoverse SPE records.
> +	 */
> +	if (record->op & ARM_SPE_ST) {
> +		data_src->mem_lvl = PERF_MEM_LVL_NA;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> +		return;
> +	}
> +
> +

Redundant new line.

> +	switch (record->source) {
> +	case ARM_SPE_NV_L1D:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_NV_L2:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	case ARM_SPE_NV_PEER_CORE:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		break;
> +	/*
> +	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
> +	 * transfer, so set SNOOPX_PEER
> +	 */
> +	case ARM_SPE_NV_LOCAL_CLUSTER:
> +	case ARM_SPE_NV_PEER_CLUSTER:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;

As a side topic, it's better to use a new patch to dump snooping flag
PERF_MEM_SNOOPX_PEER, some code like below:

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f8f234251f92..66d44280a4ea 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -410,6 +410,11 @@ static const char * const snoop_access[] = {
 	"HitM",
 };
 
+static const char * const snoopx_access[] = {
+	"Fwd",
+	"Peer",
+};
+
 int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l = 0;
@@ -430,13 +435,18 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 		}
 		l += scnprintf(out + l, sz - l, snoop_access[i]);
 	}
-	if (mem_info &&
-	     (mem_info->data_src.mem_snoopx & PERF_MEM_SNOOPX_FWD)) {
+
+	if (mem_info)
+		m = mem_info->data_src.mem_snoopx;
+
+	for (i = 0; m && i < ARRAY_SIZE(snoopx_access); i++, m >>= 1) {
+		if (!(m & 0x1))
+			continue;
 		if (l) {
 			strcat(out, " or ");
 			l += 4;
 		}
-		l += scnprintf(out + l, sz - l, "Fwd");
+		l += scnprintf(out + l, sz - l, snoopx_access[i]);
 	}
 

> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		break;
> +	/*
> +	 * System cache is assumed to be L3
> +	 */
> +	case ARM_SPE_NV_SYS_CACHE:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> +		break;
> +	/*
> +	 * We don't know what level it hit in, except it came from the other
> +	 * socket
> +	 */
> +	case ARM_SPE_NV_REMOTE:
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> +		break;
> +	case ARM_SPE_NV_DRAM:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		break;
> +	default:
> +		break;
> +	}
> +}
>
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
> @@ -446,7 +542,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  	u64 data_src;
>  	int err;
>  
> -	data_src = arm_spe__synth_data_source(record);
> +	data_src = arm_spe__synth_data_source(record, spe->midr);
>  
>  	if (spe->sample_flc) {
>  		if (record->type & ARM_SPE_L1D_MISS) {
> @@ -1183,6 +1279,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
>  	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
>  	struct perf_record_time_conv *tc = &session->time_conv;
> +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> +	u64 midr = strtol(cpuid, NULL, 16);
>  	struct arm_spe *spe;
>  	int err;
>  
> @@ -1202,6 +1300,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	spe->machine = &session->machines.host; /* No kvm support */
>  	spe->auxtrace_type = auxtrace_info->type;
>  	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	spe->midr = midr;

Except the redundant line, the patch is good for me and I tested it at
my side:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

>  
>  	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
>  
> -- 
> 2.32.0
> 
