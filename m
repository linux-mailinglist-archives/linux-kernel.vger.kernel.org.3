Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20B508372
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376749AbiDTIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiDTIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:33:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4581DFC3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:31:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z99so1303595ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0MPlsVIHa8BfRUqIbrolSzIGPypi31fdCSpfcEmPSi0=;
        b=kr5GBRGRcZ7DVvI09Sc0FjqP2Re0t6Z3qy6shVqUL96hpieIY6WBVd1edOREJuYmRa
         ufJdWMDQZt5g+ZE/9f374NjfXkQO/WTWtP6Au/pZtN9gcmgkALnpCO7GL+TymaldswKN
         A0hVu/hpwBeX3svdXGpEn6xke9Vt18Sa+P7592S2xUTLuN+itGu7ri79i+ZUNiJKcyH0
         tPbGLUNgqPMgHu1LhiIxYg41aLw/nhMGRc/mljJoXOTo9ebMvVZi4Rk8fVDcw6KVi5bn
         DaRKtvvdUkgSXCzDvLkTJkaqorVikJIH79prtEHWdwgl/2okLTM7v1dgurjnBmWrhytQ
         AR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0MPlsVIHa8BfRUqIbrolSzIGPypi31fdCSpfcEmPSi0=;
        b=YewxKAZ5VrIUqYpq5yClb99JQGs5USB86ff8AL4duH5q39v7VNJqbIpm/+lYUbTbfP
         GdJJCqUAWxj5IiFbsA5o8UVCR+RlSyXEfT49jyT45+jPL0m/l8SVblcL3fdWHQhAKuL+
         z9ZLenGFQ5oCzBB8m4ahrHiFpZVsLluJtg2Am+thwDNtbcWZZXh+FXmd9HQ/iB+dtzzp
         Tsx2l5453vIb5xTbCx8+SWziMHCbB8Qmtl6bIc8wPO8RwpEdIliKukOBUBPrRgxSlBZu
         SWZjNUcXOSPb6OzbJi98gkSv/1YtwWeD6tDNaYQT1eDI+oqkhUzHn2QCKfR5xX6ihS93
         +Afg==
X-Gm-Message-State: AOAM533Zdm7mRzMk1QphKaLIZNQbZiuJkV3XF3PyKOfPtquPJ5wjvd0Q
        ckzcQXR7Adr5vu+jE0UUZwfcvA==
X-Google-Smtp-Source: ABdhPJwkgTC+K9x1O7OW1DdCPyq72UifPTcfM9PcKieEeJ3+r3IxciUJuOmBTCKPengBJoenJkCGTg==
X-Received: by 2002:aa7:c6d7:0:b0:41d:8afe:4a6a with SMTP id b23-20020aa7c6d7000000b0041d8afe4a6amr21893519eds.281.1650443463278;
        Wed, 20 Apr 2022 01:31:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b006efc26c7b1dsm2413337ejb.195.2022.04.20.01.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:31:02 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:30:56 +0800
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
Message-ID: <20220420083056.GC843168@leoy-ThinkPad-X240s>
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

For the store operation, I found we need to use more strictly criteria
to check memory operations, otherwise, we might wrongly synthesize
memory sample even for other types of operations.

To fix the issue, I think we need to add below patch; if this is okay
for you, please consider to include it in the next patch set version.

Thanks,
Leo

From 7f8499d4f44b400d217c01d42059f00e8a1697b0 Mon Sep 17 00:00:00 2001
From: Leo Yan <leo.yan@linaro.org>
Date: Wed, 20 Apr 2022 15:46:21 +0800
Subject: [PATCH] perf arm-spe: Don't set data source if it's not a memory
 operation

Except memory load and store operations, Arm SPE records also can
support other operation types, bug when set the data source field the
current code assumes a record is a either load operation or store
operation, this leads to wrongly synthesize memory samples.

This patch strictly checks the record operation type, it only sets data
source only for the operation types ARM_SPE_LD and ARM_SPE_ST,
otherwise, returns zero for data source.  Therefore, we can synthesize
memory samples only when data source is a non-zero value, the function
arm_spe__is_memory_event() is useless and removed.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d2b64e3f588b..76251825c01d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -387,26 +387,16 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-#define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
-			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
-			 ARM_SPE_REMOTE_ACCESS)
-
-static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
-{
-	if (type & SPE_MEM_TYPE)
-		return true;
-
-	return false;
-}
-
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
 {
 	union perf_mem_data_src	data_src = { 0 };
 
 	if (record->op == ARM_SPE_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
-	else
+	else if (record->op & ARM_SPE_ST)
 		data_src.mem_op = PERF_MEM_OP_STORE;
+	else
+		return 0;
 
 	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
 		data_src.mem_lvl = PERF_MEM_LVL_L3;
@@ -510,7 +500,11 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
-	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
+	/*
+	 * When data_src is zero it means the record is not a memory operation,
+	 * skip to synthesize memory sample for this case.
+	 */
+	if (spe->sample_memory && data_src) {
 		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;
-- 
2.25.1

