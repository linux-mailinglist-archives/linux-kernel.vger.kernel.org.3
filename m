Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910F4CA947
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiCBPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiCBPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:40:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97CC0CB640;
        Wed,  2 Mar 2022 07:40:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4857A13D5;
        Wed,  2 Mar 2022 07:40:02 -0800 (PST)
Received: from [10.1.26.154] (e127744.cambridge.arm.com [10.1.26.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ACAE3F73D;
        Wed,  2 Mar 2022 07:39:58 -0800 (PST)
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is
 used
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
 <20220221224807.18172-2-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <d5f9bd40-1f32-9847-33b1-fe7304acf29b@arm.com>
Date:   Wed, 2 Mar 2022 15:39:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220221224807.18172-2-alisaidi@amazon.com>
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


On 21/02/2022 22:48, Ali Saidi wrote:
> Current code only support HITM statistics for last level cache (LLC)
> when mem_lvl encodes the level. On existing Arm64 machines there are as
> many as four levels cache and this change supports decoding l1, l2, and
> llc hits from the mem_lvl_num data. Given that the mem_lvl namespace is
> being deprecated take this opportunity to encode the neoverse data into
> mem_lvl_num.

Since Neoverse is mentioned in the commit message, I think there should be a comment somewhere in the code as well.

>
> For loads that hit in a the LLC snoop filter and are fullfilled from a
> higher level cache, it's not usually clear what the true level of the
> cache the data came from (i.e. a transfer from a core could come from
> it's L1 or L2). Instead of making an assumption of where the line came
> from, add support for incrementing HITM if the source is CACHE_ANY.
>
> Since other architectures don't seem to populate the mem_lvl_num field
> here there shouldn't be a change in functionality.
>
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  tools/perf/util/mem-events.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index ed0ab838bcc5..6c3fd4aac7ae 100644
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
> -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> -			if (lvl & P(LVL, L3 )) {
> +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> +				stats->ld_l1hit++;
> +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> +				stats->ld_l2hit++;
> +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {

According to a comment in the previous patch, using L4 is specific to Neoverse, right?

Maybe we need to distinguish the Neoverse case from the generic one here as well

if (is_neoverse)
// treat L4 as llc
else
// treat L3 as llc

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
> @@ -564,6 +567,9 @@ do {				\
>  				HITM_INC(rmt_hitm);
>  		}
>  
> +		if (lnum == P(LVLNUM, ANY_CACHE) && snoop & P(SNOOP, HITM))
> +			HITM_INC(lcl_hitm);
> +
>  		if ((lvl & P(LVL, MISS)))
>  			stats->ld_miss++;
>  
