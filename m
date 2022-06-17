Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029B154FDD0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiFQTl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbiFQTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:41:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6359BB9;
        Fri, 17 Jun 2022 12:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F1C3CE2D03;
        Fri, 17 Jun 2022 19:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA69C3411B;
        Fri, 17 Jun 2022 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655494880;
        bh=p0ZcwhFSC8OqRH2oe565uyqdU/ZOzVbrvBamWZOyRck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCo8/xpHVhkrr1n/nSS7a1J6Y2gJJaM4rQ7iaj0F7j9vi8zCnKL18EtEgQ275Am9L
         vmQO7A2dfu+hN6YdQkTKRuCzixcSPWNlr/qPtgcUZrvjHS7bZt+ttNJmrQeUHtGuzC
         NHZjaFxEQ5yXHf9LFF1XKVaIL8tuEvAfy+swcs0wzDO+0ZLa6ABo5xWfbSDQtvnL9X
         XDiQmB4/tSnZVqY0I6atPpo7cvwx1QUFFdVECSvrFUxBP58EsAzldprT0wzGUPNFwg
         cyvdx2x7qAOLiwzS9BVKITcN9m+u+xKwsPGIDaAPpNYuTvyOFWN7pXyN6foC9dfuM5
         PP1qdOsxM7M1w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF3274096F; Fri, 17 Jun 2022 16:41:17 -0300 (-03)
Date:   Fri, 17 Jun 2022 16:41:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        leo.yan@linaro.org, benh@kernel.crashing.org,
        Nick.Forrington@arm.com, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v9 4/5] perf arm-spe: Don't set data source if it's not a
 memory operation
Message-ID: <YqzY3dAtcbW+HJU9@kernel.org>
References: <20220517020326.18580-1-alisaidi@amazon.com>
 <20220517020326.18580-5-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517020326.18580-5-alisaidi@amazon.com>
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

Em Tue, May 17, 2022 at 02:03:25AM +0000, Ali Saidi escreveu:
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

Thanks, applied.

- Arnaldo
 
> Fixes: e55ed3423c1b ("perf arm-spe: Synthesize memory event")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Ali Saidi <alisaidi@amazon.com>
> Tested-by: Ali Saidi <alisaidi@amazon.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
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
> -- 
> 2.32.0

-- 

- Arnaldo
