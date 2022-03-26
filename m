Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1CD4E83DF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiCZTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiCZTpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:45:19 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE9DDFFD;
        Sat, 26 Mar 2022 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648323822; x=1679859822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1FZBphk47YQQhiYLMh/z+LEp5ErRcdf5bNmlfeDVblo=;
  b=svwUiXfTLWpWJl9wR72NqRTby3abgZYMj/oHK1bn+4O38aYXUHP3SiHp
   6w4ZqamL7sTJto6HkwuR65jLpIcRFXCvvqOZaEpbhoNHkY6Xjs1LhNVXs
   DGQ86J4P273THgJ20zQ6WevQ1yxQL1+gG1sfTKr5JiPbaIz08kzPZICCt
   Y=;
X-IronPort-AV: E=Sophos;i="5.90,213,1643673600"; 
   d="scan'208";a="184752425"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-a31e1d63.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 26 Mar 2022 19:43:41 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-a31e1d63.us-east-1.amazon.com (Postfix) with ESMTPS id 94E9790C6E;
        Sat, 26 Mar 2022 19:43:35 +0000 (UTC)
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 26 Mar 2022 19:43:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02UWC001.ant.amazon.com (10.43.162.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 26 Mar 2022 19:43:34 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Sat, 26 Mar 2022 19:43:33
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id E786917CB; Sat, 26 Mar 2022 19:43:33 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <leo.yan@linaro.org>
CC:     <Nick.Forrington@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <alisaidi@amazon.com>,
        <andrew.kilroy@arm.com>, <benh@kernel.crashing.org>,
        <german.gomez@arm.com>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@kernel.org>, <kjain@linux.ibm.com>,
        <lihuafei1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse cores
Date:   Sat, 26 Mar 2022 19:43:27 +0000
Message-ID: <20220326194327.32239-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326134754.GD20556@leoy-ThinkPad-X240s>
References: <20220326134754.GD20556@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,
On Sat, 26 Mar 2022 21:47:54 +0800, Leo Yan wrote:
> Hi Ali, German,
> 
> On Thu, Mar 24, 2022 at 06:33:21PM +0000, Ali Saidi wrote:
> 
> [...]
> 
> > +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> > +						union perf_mem_data_src *data_src)
> >  {
> > -	union perf_mem_data_src	data_src = { 0 };
> > +	/*
> > +	 * Even though four levels of cache hierarchy are possible, no known
> > +	 * production Neoverse systems currently include more than three levels
> > +	 * so for the time being we assume three exist. If a production system
> > +	 * is built with four the this function would have to be changed to
> > +	 * detect the number of levels for reporting.
> > +	 */
> >  
> > -	if (record->op == ARM_SPE_LD)
> > -		data_src.mem_op = PERF_MEM_OP_LOAD;
> > -	else
> > -		data_src.mem_op = PERF_MEM_OP_STORE;
> 
> Firstly, apologize that I didn't give clear idea when Ali sent patch sets
> v2 and v3.
> 
> IMHO, we need to consider two kinds of information which can guide us
> for a reliable implementation.  The first thing is to summarize the data
> source configuration for x86 PEBS, we can dive in more details for this
> part; the second thing is we can refer to the AMBA architecture document
> ARM IHI 0050E.b, section 11.1.2 'Crossing a chip-to-chip interface' and
> its sub section 'Suggested DataSource values', which would help us
> much for mapping the cache topology to Arm SPE data source.
> 
> As a result, I summarized the data source configurations for PEBS and
> Arm SPE Neoverse in the spreadsheet:
> https://docs.google.com/spreadsheets/d/11YmjG0TyRjH7IXgvsREFgTg3AVtxh2dvLloRK1EdNjU/edit?usp=sharing

Thanks for putting this together and digging into the details, but you're making
assumptions in neoverse data sources about the core configurations that aren't
correct. The Neoverse cores have all have integrated L1 and L2 cache, so if the
line is coming from a peer-core we don't know which level it's actually coming
from.  Similarly, if it's coming from a local cluster, that could mean a cluster
l3, but it's not the L2. 


> Please see below comments.
> 
> > +	switch (record->source) {
> > +	case ARM_SPE_NV_L1D:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > +		break;
> 
> I think we need to set the field 'mem_snoop' for L1 cache hit:
> 
>         data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> 
> For L1 cache hit, it doesn't involve snooping.
I can't find a precise definition for SNOOP_NONE, but it seemed as though
this would be used for cases where a snoop could have occurred but didn't
not for accesses that by definition don't snoop? I'm happy with either way,
perhaps i just read more into it. 

> > +	case ARM_SPE_NV_L2:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> > +		break;
> 
> Ditto:
> 
>         data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
Same comment as above.

> > +	case ARM_SPE_NV_PEER_CORE:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> 
> Peer core contains its local L1 cache, so I think we can set the
> memory level L1 to indicate this case.
It could be either the L1 or the L2. All the neoverse cores have private L2
caches and we don't know. 

> For this data source type and below types, though they indicate
> the snooping happens, but it doesn't mean the data in the cache line
> is in 'modified' state.  If set flag PERF_MEM_SNOOP_HITM, I personally
> think this will mislead users when report the result.

I'm of the opposite opinion. If the data wasn't modified, it will likely be
found in the lower-level shared cache and the transaction wouldn't require a
cache-to-cache transfer of the modified data, so the most common case when we
source a line out of another cores cache will be if it was "modifiable" in that
cache. 

> 
> I prefer we set below fields for ARM_SPE_NV_PEER_CORE:
> 
>         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L1;
>         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
>         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> 
> > +		break;
> > +	/*
> > +	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
> > +	 * transfer, so set SNOOP_HITM
> > +	 */
> > +	case ARM_SPE_NV_LCL_CLSTR:
> 
> For ARM_SPE_NV_LCL_CLSTR, it fetches the data from the shared cache in
> the cluster level, it should happen in L2 cache:
> 
>         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L2;
>         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
>         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;

We don't know if this is coming from the cluster cache, or the private L1 or L2
core caches. The description above about why we'll be transferring the line from
cache-to-cache applies here too. 

> > +	case ARM_SPE_NV_PEER_CLSTR:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > +		break;
> 
> This type can snoop from L1 or L2 cache in the peer cluster, so it
> makes sense to set cache level as PERF_MEM_LVLNUM_ANY_CACHE.  But here
> should use the snoop type PERF_MEM_SNOOP_HIT, so:
> 
>         data_src->mem_lvl = PERF_MEM_LVL_HIT
>         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
>         data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

Given that we agreed to only focus on the three levels generally used by
the existing implementations LCL and PEER should be the same for now. 

> > +	/*
> > +	 * System cache is assumed to be L3
> > +	 */
> > +	case ARM_SPE_NV_SYS_CACHE:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > +		break;
> 
>         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L3;
>         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
>         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;

I don't think we should set both the deprecated mem_lvl and the mem_lvl_num. 
If we're hitting in the unified L3 cache, we aren't actually snooping anything
which is why I didn't set mem_snoop here.

> > +	/*
> > +	 * We don't know what level it hit in, except it came from the other
> > +	 * socket
> > +	 */
> > +	case ARM_SPE_NV_REMOTE:
> > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> > +		break;
> 
> The type ARM_SPE_NV_REMOTE is a snooping operation and it can happen
> in any cache levels in remote chip:
> 
>         data_src->mem_lvl = PERF_MEM_LVL_HIT;
>         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
>         data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>         data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;

Ok.

> 
> > +	case ARM_SPE_NV_DRAM:
> > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> > +		break;
> 
> We can set snoop as PERF_MEM_SNOOP_MISS for DRAM data source:
> 
>         data_src->mem_lvl = PERF_MEM_LVL_HIT;
>         data_src->mem_snoop = PERF_MEM_SNOOP_MISS;
>         data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> 

Ok.

Thanks,
Ali



