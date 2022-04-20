Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EFA508FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381508AbiDTTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbiDTTFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:05:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E42BE5;
        Wed, 20 Apr 2022 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650481367; x=1682017367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kKQBmPp1VZYcgCiUJsleCcUtBP4LxeMiM4JoNgp0U24=;
  b=Lp1Wy1yrBVoud1ipzYG4d2cEALELLPYNVEl1/Zz5GtKCpqE112zZf9OE
   wnZuMNOSS4+tLYBAN4nbXuxQ8ddPY4Gtff78GYbvfeAmIRwt6OksUvNat
   c4oJyQpl/pVRa/HjcBNVxRNpaU4LSEAcfGz66/cicfDDrb+nuHbc0ue1I
   Gbn4gLAjFP4XykYPyI4Q6FQMzWRxer1ZeKtvLlAM4htMzALOQkio3nvp9
   LNvAvy5yw3RNOglNK6m0YqN7tvUq3dnZ24GsoD/Yfxez5witUpBYUlksb
   YtrpQ5PnazMa5sc+osQQ0CkK3Kz0TDZAqYswPkbf/olBBX6asHgGS/87B
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263590874"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="263590874"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 12:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="614545737"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2022 12:02:45 -0700
Received: from [10.209.97.182] (kliang2-MOBL.ccr.corp.intel.com [10.209.97.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3F6DD580AE2;
        Wed, 20 Apr 2022 12:02:43 -0700 (PDT)
Message-ID: <f3aa49ff-958a-df73-f0cb-e48f73f70e8a@linux.intel.com>
Date:   Wed, 20 Apr 2022 15:02:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 5/5] perf mem: Support mem_lvl_num in c2c command
Content-Language: en-US
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        leo.yan@linaro.org, acme@kernel.org
Cc:     benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-6-alisaidi@amazon.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220408195344.32764-6-alisaidi@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2022 3:53 PM, Ali Saidi wrote:
> In addition to summarizing data encoded in mem_lvl also support data
> encoded in mem_lvl_num.
> 
> Since other architectures don't seem to populate the mem_lvl_num field
> here there shouldn't be a change in functionality.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>   tools/perf/util/mem-events.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index ed0ab838bcc5..e5e405185498 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
>   	u64 daddr  = mi->daddr.addr;
>   	u64 op     = data_src->mem_op;
>   	u64 lvl    = data_src->mem_lvl;
> +	u64 lnum   = data_src->mem_lvl_num;
>   	u64 snoop  = data_src->mem_snoop;
>   	u64 lock   = data_src->mem_lock;
>   	u64 blk    = data_src->mem_blk;
> @@ -527,16 +528,18 @@ do {				\
>   			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
>   			if (lvl & P(LVL, IO))  stats->ld_io++;
>   			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
> -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> -			if (lvl & P(LVL, L3 )) {
> +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> +				stats->ld_l1hit++;
> +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> +				stats->ld_l2hit++;
> +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L3)) {
>   				if (snoop & P(SNOOP, HITM))
>   					HITM_INC(lcl_hitm);
>   				else
>   					stats->ld_llchit++;
>   			}
>   
> -			if (lvl & P(LVL, LOC_RAM)) {
> +			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {

I think the PERF_MEM_LVLNUM_RAM only means it's a DRAM.
It doesn't contain the location information. To distinguish the local 
and remote dram, X86 uses PERF_MEM_REMOTE_REMOTE.
Here the remote dram will be mistakenly calculated if you only check the 
PERF_MEM_LVLNUM_RAM.

Actually, it looks like the mem_lvl_num fields supported in this patch 
are also supported by the PERF_MEM_LVL*. Why don't you set both 
PERF_MEM_LVLNUM_* and PERF_MEM_LVL* in your previous patch 4?
Then you can drop this patch.

Thanks,
Kan
>   				stats->lcl_dram++;
>   				if (snoop & P(SNOOP, HIT))
>   					stats->ld_shared++;
