Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B951822E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiECKYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiECKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:24:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EB9717AAD;
        Tue,  3 May 2022 03:20:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC5781042;
        Tue,  3 May 2022 03:20:41 -0700 (PDT)
Received: from [10.1.28.130] (e127744.cambridge.arm.com [10.1.28.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70FC63F73D;
        Tue,  3 May 2022 03:20:37 -0700 (PDT)
Subject: Re: [PATCH v7 4/5] perf arm-spe: Don't set data source if it's not a
 memory operation
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
 <20220426135937.18497-5-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <e75f4ea0-4c8f-a1f2-348d-3ccfbb608e8f@arm.com>
Date:   Tue, 3 May 2022 11:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220426135937.18497-5-alisaidi@amazon.com>
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


On 26/04/2022 14:59, Ali Saidi wrote:
> From: Leo Yan <leo.yan@linaro.org>
>
> Except memory load and store operations, Arm SPE records also can
> support other operation types, bug when set the data source field the
> current code assumes a record is a either load operation or store
> operation, this leads to wrongly synthesize memory samples.
>
> This patch strictly checks the record operation type, it only sets data
> source only for the operation types ARM_SPE_LD and ARM_SPE_ST,
> otherwise, returns zero for data source.  Therefore, we can synthesize
> memory samples only when data source is a non-zero value, the function
> arm_spe__is_memory_event() is useless and removed.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Ali Saidi <alisaidi@amazon.com>
> Tested-by: Ali Saidi <alisaidi@amazon.com>

I think the Fixes tag is missing, right?

Fixes: e55ed3423c1b ("perf arm-spe: Synthesize memory event")
Reviewed-by: German Gomez <german.gomez@arm.com>

Thanks,
German

> ---
>  tools/perf/util/arm-spe.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index d2b64e3f588b..e032efc03274 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -387,26 +387,16 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>  	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>  }
>  
> -#define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
> -			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
> -			 ARM_SPE_REMOTE_ACCESS)
> -
> -static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
> -{
> -	if (type & SPE_MEM_TYPE)
> -		return true;
> -
> -	return false;
> -}
> -
>  static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
>  {
>  	union perf_mem_data_src	data_src = { 0 };
>  
>  	if (record->op == ARM_SPE_LD)
>  		data_src.mem_op = PERF_MEM_OP_LOAD;
> -	else
> +	else if (record->op == ARM_SPE_ST)
>  		data_src.mem_op = PERF_MEM_OP_STORE;
> +	else
> +		return 0;
>  
>  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
>  		data_src.mem_lvl = PERF_MEM_LVL_L3;
> @@ -510,7 +500,11 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  			return err;
>  	}
>  
> -	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
> +	/*
> +	 * When data_src is zero it means the record is not a memory operation,
> +	 * skip to synthesize memory sample for this case.
> +	 */
> +	if (spe->sample_memory && data_src) {
>  		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
>  		if (err)
>  			return err;
