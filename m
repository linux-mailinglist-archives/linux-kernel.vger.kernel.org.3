Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662E4E8129
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiCZNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiCZNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:49:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388885B3F7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 06:48:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bi12so20364118ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kzg1uYqiremGAbXIJz6CVw8cfKKAkqZDujuGE6X3obg=;
        b=F9uTdBg6KYZDuchIJwmwO640VisZ4QptqPlPK3DJaoKMPN9JE4EC6j5cg+6T66Yl1i
         qrp4E5cR6dTcEDueSpgYJjsNHNtnh3KD9WHCmhklv2RyoWjyeauXmmMa0DPR+4ks4fU8
         p5R49jKt4PZKkDFfa4+cLiCqDGCjmdHPf3qN/nEiHptvyQQlaBX8fIYpbnu8NA/0prbU
         4Kx5ecPgUPOX2UZ2eMqWu2PbMAy4eJ03sKvDCDLvcHB/FArYQM1dULrpRmnhNnr6gXB7
         Qx9yDOgDcj2O3tfocJabYTu5NkMT/NNqZcjR9IP0xjkcJvdeB8R8MazGruGAG0oaHJNJ
         N84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kzg1uYqiremGAbXIJz6CVw8cfKKAkqZDujuGE6X3obg=;
        b=n6AWkL/QzrTpc4pbnDlHcxHf4fN87bOvjL1mYa6W51mB4LkJtx/ulRB/mseqShz7Yh
         xcZkXkU7NY3qwq+e5S6vraqSWWA9GCr7AkTkaYmgr9DYMa0h+irCH/o3a262ePRgupMb
         6hUUYe4jUOXi+/S6ZGZY1s/rUJ9OiRbWenC+zFFLDI4HDvBC7ZqqPUtgxUkXkyNYPH5q
         8K8Z40jiHORmhsMLc1G2Ko7f9aIJAOdaJrlJYW6r97xhohWAXNbnwSCL+cquqBe270sy
         yYP6erbZmH2QEwXxn4ljffLLmq7VH/ie3c3uI38OFMT8z3BN1xGdyITOxuv2UWj23cim
         KcUg==
X-Gm-Message-State: AOAM532YDW1o3vfCemfUC4mGC31uvdfInV59UQN/mZfTJodnMAktxiHA
        FnSPl7q68CXuG9JhChCAExJmnw==
X-Google-Smtp-Source: ABdhPJy94pXm1QMjo503THCPefEYy/QWy28c0Km+aUM9EjLdjs81UxbGXez1K6WdbJK9tfE92XgDUQ==
X-Received: by 2002:a17:906:a1c2:b0:6d6:d54d:4fb1 with SMTP id bx2-20020a170906a1c200b006d6d54d4fb1mr17771900ejb.490.1648302485284;
        Sat, 26 Mar 2022 06:48:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709066b8200b006bbea7e566esm3381889ejr.55.2022.03.26.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 06:48:04 -0700 (PDT)
Date:   Sat, 26 Mar 2022 21:47:54 +0800
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
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220326134754.GD20556@leoy-ThinkPad-X240s>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-3-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324183323.31414-3-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali, German,

On Thu, Mar 24, 2022 at 06:33:21PM +0000, Ali Saidi wrote:

[...]

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

Firstly, apologize that I didn't give clear idea when Ali sent patch sets
v2 and v3.

IMHO, we need to consider two kinds of information which can guide us
for a reliable implementation.  The first thing is to summarize the data
source configuration for x86 PEBS, we can dive in more details for this
part; the second thing is we can refer to the AMBA architecture document
ARM IHI 0050E.b, section 11.1.2 'Crossing a chip-to-chip interface' and
its sub section 'Suggested DataSource values', which would help us
much for mapping the cache topology to Arm SPE data source.

As a result, I summarized the data source configurations for PEBS and
Arm SPE Neoverse in the spreadsheet:
https://docs.google.com/spreadsheets/d/11YmjG0TyRjH7IXgvsREFgTg3AVtxh2dvLloRK1EdNjU/edit?usp=sharing

Please see below comments.

> +	switch (record->source) {
> +	case ARM_SPE_NV_L1D:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +		break;

I think we need to set the field 'mem_snoop' for L1 cache hit:

        data_src->mem_snoop = PERF_MEM_SNOOP_NONE;

For L1 cache hit, it doesn't involve snooping.

> +	case ARM_SPE_NV_L2:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> +		break;

Ditto:

        data_src->mem_snoop = PERF_MEM_SNOOP_NONE;

> +	case ARM_SPE_NV_PEER_CORE:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

Peer core contains its local L1 cache, so I think we can set the
memory level L1 to indicate this case.

For this data source type and below types, though they indicate
the snooping happens, but it doesn't mean the data in the cache line
is in 'modified' state.  If set flag PERF_MEM_SNOOP_HITM, I personally
think this will mislead users when report the result.

I prefer we set below fields for ARM_SPE_NV_PEER_CORE:

        data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L1;
        data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
        data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;

> +		break;
> +	/*
> +	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
> +	 * transfer, so set SNOOP_HITM
> +	 */
> +	case ARM_SPE_NV_LCL_CLSTR:

For ARM_SPE_NV_LCL_CLSTR, it fetches the data from the shared cache in
the cluster level, it should happen in L2 cache:

        data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L2;
        data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
        data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;

> +	case ARM_SPE_NV_PEER_CLSTR:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		break;

This type can snoop from L1 or L2 cache in the peer cluster, so it
makes sense to set cache level as PERF_MEM_LVLNUM_ANY_CACHE.  But here
should use the snoop type PERF_MEM_SNOOP_HIT, so:

        data_src->mem_lvl = PERF_MEM_LVL_HIT
        data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
        data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

> +	/*
> +	 * System cache is assumed to be L3
> +	 */
> +	case ARM_SPE_NV_SYS_CACHE:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +		break;

        data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L3;
        data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
        data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;

> +	/*
> +	 * We don't know what level it hit in, except it came from the other
> +	 * socket
> +	 */
> +	case ARM_SPE_NV_REMOTE:
> +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> +		break;

The type ARM_SPE_NV_REMOTE is a snooping operation and it can happen
in any cache levels in remote chip:

        data_src->mem_lvl = PERF_MEM_LVL_HIT;
        data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
        data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
        data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

> +	case ARM_SPE_NV_DRAM:
> +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> +		break;

We can set snoop as PERF_MEM_SNOOP_MISS for DRAM data source:

        data_src->mem_lvl = PERF_MEM_LVL_HIT;
        data_src->mem_snoop = PERF_MEM_SNOOP_MISS;
        data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;

The rest of this patch looks good to me.

Thanks,
Leo

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
> @@ -446,7 +525,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  	u64 data_src;
>  	int err;
>  
> -	data_src = arm_spe__synth_data_source(record);
> +	data_src = arm_spe__synth_data_source(record, spe->midr);
>  
>  	if (spe->sample_flc) {
>  		if (record->type & ARM_SPE_L1D_MISS) {
> @@ -1183,6 +1262,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
>  	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
>  	struct perf_record_time_conv *tc = &session->time_conv;
> +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> +	u64 midr = strtol(cpuid, NULL, 16);
>  	struct arm_spe *spe;
>  	int err;
>  
> @@ -1202,6 +1283,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	spe->machine = &session->machines.host; /* No kvm support */
>  	spe->auxtrace_type = auxtrace_info->type;
>  	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	spe->midr = midr;
>  
>  	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
>  
> -- 
> 2.32.0
> 
