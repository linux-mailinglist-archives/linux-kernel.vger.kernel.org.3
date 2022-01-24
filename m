Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD949869C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbiAXRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:24:44 -0500
Received: from foss.arm.com ([217.140.110.172]:41704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244496AbiAXRYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:24:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08F4D6E;
        Mon, 24 Jan 2022 09:24:29 -0800 (PST)
Received: from [10.57.39.131] (unknown [10.57.39.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47DF13F766;
        Mon, 24 Jan 2022 09:24:27 -0800 (PST)
Subject: Re: [PATCH] perf arm-spe: Use SPE data source for neoverse cores
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@linaro.org>
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
        Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220121182456.13538-1-alisaidi@amazon.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <0ba26f30-6978-36ad-f7d0-7b8465648e54@arm.com>
Date:   Mon, 24 Jan 2022 17:24:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220121182456.13538-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2022 18:24, Ali Saidi wrote:
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> the same encoding. I can't find encoding information for any other SPE
> implementations to unify their choices with Arm's thus that is left for future
> work.
> 
> This changes enables the expected behavior of perf c2c on a system with SPE where
> lines that are shared among multiple cores show up in perf c2c output. 
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com> 
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |  1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 12 +++++
>  tools/perf/util/arm-spe.c                     | 48 ++++++++++++++-----
>  3 files changed, 49 insertions(+), 12 deletions(-)
> 
[...]
> +static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
>  {
>  	union perf_mem_data_src	data_src = { 0 };
> +	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
>  
>  	if (record->op == ARM_SPE_LD)
>  		data_src.mem_op = PERF_MEM_OP_LOAD;
> @@ -409,19 +418,30 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
>  		data_src.mem_op = PERF_MEM_OP_STORE;
>  
>  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
> -		data_src.mem_lvl = PERF_MEM_LVL_L3;
> +		if (is_neoverse && record->source == ARM_SPE_NV_DRAM) {
> +			data_src.mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
> +		} else if (is_neoverse && record->source == ARM_SPE_NV_PEER_CLSTR) {
> +			data_src.mem_snoop = PERF_MEM_SNOOP_HITM;

I'm not following how LLC_ACCESS | LLC_MISS ends up as HITM in this case (ARM_SPE_NV_PEER_CLSTR)?
I thought there was no way to determine a HITM from SPE. Wouldn't one of the other values
like PERF_MEM_SNOOP_MISS be more accurate?

> +			data_src.mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;

This one also adds PERF_MEM_LVL_HIT even though the check of "if (record->type & ARM_SPE_LLC_MISS)"
hasn't happened yet. Maybe some comments would make it a bit clearer, but at the moment it's
not obvious how the result is derived because there are some things that don't add up like
ARM_SPE_LLC_MISS == PERF_MEM_LVL_HIT.

> +		} else {
> +			data_src.mem_lvl = PERF_MEM_LVL_L3;>  
> -		if (record->type & ARM_SPE_LLC_MISS)
> -			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> -		else
> -			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> +			if (record->type & ARM_SPE_LLC_MISS)
> +				data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> +			else
> +				data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> +		}
>  	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
> -		data_src.mem_lvl = PERF_MEM_LVL_L1;
> +		if (is_neoverse && record->source == ARM_SPE_NV_L2) {
> +			data_src.mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		} else {
> +			data_src.mem_lvl = PERF_MEM_LVL_L1;
>  
> -		if (record->type & ARM_SPE_L1D_MISS)
> -			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> -		else
> -			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> +			if (record->type & ARM_SPE_L1D_MISS)
> +				data_src.mem_lvl |= PERF_MEM_LVL_MISS;
> +			else
> +				data_src.mem_lvl |= PERF_MEM_LVL_HIT;
> +		}
>  	}
>  
>  	if (record->type & ARM_SPE_REMOTE_ACCESS)
> @@ -446,7 +466,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  	u64 data_src;
>  	int err;
>  
> -	data_src = arm_spe__synth_data_source(record);
> +	data_src = arm_spe__synth_data_source(record, spe->midr);
>  
>  	if (spe->sample_flc) {
>  		if (record->type & ARM_SPE_L1D_MISS) {
> @@ -796,6 +816,10 @@ static int arm_spe_process_event(struct perf_session *session,
>  	u64 timestamp;
>  	struct arm_spe *spe = container_of(session->auxtrace,
>  			struct arm_spe, auxtrace);
> +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> +	u64 midr = strtol(cpuid, NULL, 16);
> +
> +	spe->midr = midr;
>  
>  	if (dump_trace)
>  		return 0;
> 
