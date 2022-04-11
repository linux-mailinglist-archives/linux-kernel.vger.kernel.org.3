Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47D4FB8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbiDKKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiDKKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:06:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F86BBC10;
        Mon, 11 Apr 2022 03:04:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE54F169C;
        Mon, 11 Apr 2022 03:04:38 -0700 (PDT)
Received: from [10.1.30.132] (e127744.cambridge.arm.com [10.1.30.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E96D3F793;
        Mon, 11 Apr 2022 03:04:34 -0700 (PDT)
Subject: Re: [PATCH v5 5/5] perf mem: Support mem_lvl_num in c2c command
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
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-6-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <3ad0128a-1b3d-37a7-81f6-fd597b565b18@arm.com>
Date:   Mon, 11 Apr 2022 11:04:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220408195344.32764-6-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/04/2022 20:53, Ali Saidi wrote:
> In addition to summarizing data encoded in mem_lvl also support data
> encoded in mem_lvl_num.
>
> Since other architectures don't seem to populate the mem_lvl_num field
> here there shouldn't be a change in functionality.
>
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  tools/perf/util/mem-events.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index ed0ab838bcc5..e5e405185498 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
>  	u64 daddr  = mi->daddr.addr;
>  	u64 op     = data_src->mem_op;
>  	u64 lvl    = data_src->mem_lvl;
> +	u64 lnum   = data_src->mem_lvl_num;
>  	u64 snoop  = data_src->mem_snoop;
>  	u64 lock   = data_src->mem_lock;
>  	u64 blk    = data_src->mem_blk;
> @@ -527,16 +528,18 @@ do {				\
>  			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
>  			if (lvl & P(LVL, IO))  stats->ld_io++;
>  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;

Just for completion, can we also handle LFB as it seems to be being set
in "/arch/x86/events/intel/ds.c"? (Sorry I missed this in the v4)

> -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> -			if (lvl & P(LVL, L3 )) {
> +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> +				stats->ld_l1hit++;
> +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> +				stats->ld_l2hit++;
> +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L3)) {
>  				if (snoop & P(SNOOP, HITM))
>  					HITM_INC(lcl_hitm);
>  				else
>  					stats->ld_llchit++;
>  			}
>  
> -			if (lvl & P(LVL, LOC_RAM)) {
> +			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
>  				stats->lcl_dram++;
>  				if (snoop & P(SNOOP, HIT))
>  					stats->ld_shared++;
