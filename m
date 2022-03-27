Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003E34E8710
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiC0JLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiC0JLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 05:11:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B97222A6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 02:09:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qa43so23003673ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 02:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5YjjLJ4YFspfsiwu2Vo37LE7g0QtUAIZgPVwuTiW9ew=;
        b=AahxxGNYy0SmV46mQCDQV9SFiZkFM+0r7OMs8aBulNYHr8XdfG2aFNHLVT6T4fk3zm
         r1e9bH2eDwsDImoB8l5wfgCDAvieEd7uXJYJTsLfdcMhFEvsVISuhuaPtVpkSBYJaO39
         fFTRKDGpQmVMEcTTMIfn8bGDrAO338UD3PFxe9TLhbjRYkGm6sArbI+iEYIF0uC0p7HC
         ld3/qigNOFVf+6LqdriIPojYDL4eJVbN1CiFq4NOlL1xzo7FdO/sS9MSqVKntwKeS8pq
         5CtQjrUIPhW96twEIIWjAbHYLIMS1USUG1mM71pnmw5tRrQ9FBmZxT2yRNIcX3gQrke0
         T4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5YjjLJ4YFspfsiwu2Vo37LE7g0QtUAIZgPVwuTiW9ew=;
        b=K9KPr07P3S9UVNVJRA+YzspU9vcIB3RlxYyIY+pi7B7z3AepiuLSEGE3paOq/sOaUO
         SZEDr2xXVweeSl/puk5XOpAEC6taPxVt+hO8zyoehLxm+yZTivrO/aEgDCGEy8ZGx7u+
         74ancHgEuruaOLf5ynNPn0LZ0LsIcqIVTUfs+01bO2yDneRPbBDYqMrgevFDFhcoYFg0
         6ZnHvbuSrnEKhVbFa1OHdHMNe+W3Z2Wagf5hLCoIncP+FHQwQ9DZE/y7EGUH1FBGBgWX
         ij53K+aTGeU7ycvghJAfAH4nl53rCPmdisb9i5nxES+K6oijiFC+N7xnEgjhULtNbbgx
         eAbQ==
X-Gm-Message-State: AOAM530JAeXO87Kh/IXumY4Cbb2CN2I0zDBzdi+I19RdCjdZdGKTXDlZ
        TvWRiIPKa7Smrtck63jXx7lhrg==
X-Google-Smtp-Source: ABdhPJxFJ5ZCyB3G/oeVmioAknOp+K7lmSm+xPLEe7iHD79RYukOLcAzGCj0qAt2vv+aMBo0wfOrPA==
X-Received: by 2002:a17:906:1e94:b0:6cc:4382:f12e with SMTP id e20-20020a1709061e9400b006cc4382f12emr20756980ejj.482.1648372160560;
        Sun, 27 Mar 2022 02:09:20 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906748300b006df6a2816e9sm4356105ejl.138.2022.03.27.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 02:09:19 -0700 (PDT)
Date:   Sun, 27 Mar 2022 17:09:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220327090912.GF20556@leoy-ThinkPad-X240s>
References: <20220326134754.GD20556@leoy-ThinkPad-X240s>
 <20220326194327.32239-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326194327.32239-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 07:43:27PM +0000, Ali Saidi wrote:
> Hi Leo,
> On Sat, 26 Mar 2022 21:47:54 +0800, Leo Yan wrote:
> > Hi Ali, German,
> > 
> > On Thu, Mar 24, 2022 at 06:33:21PM +0000, Ali Saidi wrote:
> > 
> > [...]
> > 
> > > +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> > > +						union perf_mem_data_src *data_src)
> > >  {
> > > -	union perf_mem_data_src	data_src = { 0 };
> > > +	/*
> > > +	 * Even though four levels of cache hierarchy are possible, no known
> > > +	 * production Neoverse systems currently include more than three levels
> > > +	 * so for the time being we assume three exist. If a production system
> > > +	 * is built with four the this function would have to be changed to
> > > +	 * detect the number of levels for reporting.
> > > +	 */
> > >  
> > > -	if (record->op == ARM_SPE_LD)
> > > -		data_src.mem_op = PERF_MEM_OP_LOAD;
> > > -	else
> > > -		data_src.mem_op = PERF_MEM_OP_STORE;
> > 
> > Firstly, apologize that I didn't give clear idea when Ali sent patch sets
> > v2 and v3.
> > 
> > IMHO, we need to consider two kinds of information which can guide us
> > for a reliable implementation.  The first thing is to summarize the data
> > source configuration for x86 PEBS, we can dive in more details for this
> > part; the second thing is we can refer to the AMBA architecture document
> > ARM IHI 0050E.b, section 11.1.2 'Crossing a chip-to-chip interface' and
> > its sub section 'Suggested DataSource values', which would help us
> > much for mapping the cache topology to Arm SPE data source.
> > 
> > As a result, I summarized the data source configurations for PEBS and
> > Arm SPE Neoverse in the spreadsheet:
> > https://docs.google.com/spreadsheets/d/11YmjG0TyRjH7IXgvsREFgTg3AVtxh2dvLloRK1EdNjU/edit?usp=sharing
> 
> Thanks for putting this together and digging into the details, but you're making
> assumptions in neoverse data sources about the core configurations that aren't
> correct. The Neoverse cores have all have integrated L1 and L2 cache, so if the
> line is coming from a peer-core we don't know which level it's actually coming
> from.  Similarly, if it's coming from a local cluster, that could mean a cluster
> l3, but it's not the L2. 

I remembered before you have mentioned this, and yes, these concerns are
valid for me.  Please see below comments.

> > Please see below comments.
> > 
> > > +	switch (record->source) {
> > > +	case ARM_SPE_NV_L1D:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > > +		break;
> > 
> > I think we need to set the field 'mem_snoop' for L1 cache hit:
> > 
> >         data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> > 
> > For L1 cache hit, it doesn't involve snooping.
>
> I can't find a precise definition for SNOOP_NONE, but it seemed as though
> this would be used for cases where a snoop could have occurred but didn't
> not for accesses that by definition don't snoop? I'm happy with either way,
> perhaps i just read more into it.

I have the same understanding with you that "this would be used for
cases where a snoop could have occurred but didn't not for accesses
that by definition don't snoop".

If we refer to PEBS's data source type 01H: "Minimal latency core cache
hit.  This request was satisfied by the L1 data cache" and x86 sets
SNOOP_NONE as the snoop type for this case.

If we connect with snooping protocol, let's use MOIS protocol as an
example (here simply use the MOIS protocol for discussion, but I
don't have any knowledge for implementation of CPUs actually), as
described in the wiki page [1], when a cache line is in Owned (O)
state or Shared (S) state, "a processor read (PrRd) does not generate
any snooped signal".  In these cases, I think we should use snoop type
PERF_MEM_SNOOP_NONE.

> > > +	case ARM_SPE_NV_L2:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> > > +		break;
> > 
> > Ditto:
> > 
> >         data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> Same comment as above.
> 
> > > +	case ARM_SPE_NV_PEER_CORE:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > 
> > Peer core contains its local L1 cache, so I think we can set the
> > memory level L1 to indicate this case.
> It could be either the L1 or the L2. All the neoverse cores have private L2
> caches and we don't know. 

How about set both L1 and L2 cache together for this case?

Although 'L1 | L2' cannot tell the exact cache level, I think it's
better than use ANY_CACHE, at least this can help us to distinguish
from other data source types if we avoid to use ANY_CACHE for all of
them.

> > For this data source type and below types, though they indicate
> > the snooping happens, but it doesn't mean the data in the cache line
> > is in 'modified' state.  If set flag PERF_MEM_SNOOP_HITM, I personally
> > think this will mislead users when report the result.
> 
> I'm of the opposite opinion. If the data wasn't modified, it will likely be
> found in the lower-level shared cache and the transaction wouldn't require a
> cache-to-cache transfer of the modified data, so the most common case when we
> source a line out of another cores cache will be if it was "modifiable" in that
> cache. 

Let's still use MOSI protocol as example.  I think there have two
cases: on case is the peer cache line is in 'Shared' state and another
case is the peer cache line is in 'Owned' state.

Quotes the wiki page for these two cases:

"When the cache block is in the Shared (S) state and there is a
snooped bus read (BusRd) transaction, then the block stays in the same
state and generates no more transactions as all the cache blocks have
the same value including the main memory and it is only being read,
not written into."

"While in the Owner (O) state and there is a snooped read request
(BusRd), the block remains in the same state while flushing (Flush)
the data for the other processor to read from it."

Seems to me, it's reasonable to set HTIM flag when the snooping happens
for the cache line line is in the Modified (M) state.

Again, my comment is based on the literal understanding; so please
correct if have any misunderstanding at here.

> > I prefer we set below fields for ARM_SPE_NV_PEER_CORE:
> > 
> >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L1;
> >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > 
> > > +		break;
> > > +	/*
> > > +	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
> > > +	 * transfer, so set SNOOP_HITM
> > > +	 */
> > > +	case ARM_SPE_NV_LCL_CLSTR:
> > 
> > For ARM_SPE_NV_LCL_CLSTR, it fetches the data from the shared cache in
> > the cluster level, it should happen in L2 cache:
> > 
> >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L2;
> >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> 
> We don't know if this is coming from the cluster cache, or the private L1 or L2
> core caches. The description above about why we'll be transferring the line from
> cache-to-cache applies here too. 

I think a minor difference between PEER_CORE and LCL_CLSTR is:
if data source is PEER_CORE, the snooping happens on the peer core's
local cache (Core's L1 or Core's L2 when core contains L2); for the data
source LCL_CLSTR, the snooping occurs on the cluster level's cache
(cluster's L2 cache or cluster's L3 cache when cluster contains L3).

So can we set both 'L2 | L3' for LCL_CLSTR case?

> > > +	case ARM_SPE_NV_PEER_CLSTR:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > > +		break;
> > 
> > This type can snoop from L1 or L2 cache in the peer cluster, so it
> > makes sense to set cache level as PERF_MEM_LVLNUM_ANY_CACHE.  But here
> > should use the snoop type PERF_MEM_SNOOP_HIT, so:
> > 
> >         data_src->mem_lvl = PERF_MEM_LVL_HIT
> >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> 
> Given that we agreed to only focus on the three levels generally used by
> the existing implementations LCL and PEER should be the same for now. 

For PEER_CLSTR, we don't know the snooping happening on CPU's private
cache or cluster's shared cache, this is why we should use ANY_CACHE
for cache level.

But LCL_CLSTR is different from PEER_CLSTR, LCL_CLSTR indicates the
snooping on the local cluster's share cache, we set 'L2 | L3' for it;
therefore, we can distinguish between these two cases.

> > > +	/*
> > > +	 * System cache is assumed to be L3
> > > +	 */
> > > +	case ARM_SPE_NV_SYS_CACHE:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > > +		break;
> > 
> >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L3;
> >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> 
> I don't think we should set both the deprecated mem_lvl and the mem_lvl_num. 

Is this because the decoding flow has any specific requirement that
only can set mem_lvl_num and not set mem_lvl?

> If we're hitting in the unified L3 cache, we aren't actually snooping anything
> which is why I didn't set mem_snoop here.

I am a bit suspecious for the clarification.  If the system cache is in
the cache conhernecy domain, then snooping occurs on it; in other words,
if system cache is connected with a bus (like CCI or CMN), and the bus
can help for data consistency, I prefer to set SNOOP_HIT flag.

Could you confirm for this?

> > > +	/*
> > > +	 * We don't know what level it hit in, except it came from the other
> > > +	 * socket
> > > +	 */
> > > +	case ARM_SPE_NV_REMOTE:
> > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> > > +		break;
> > 
> > The type ARM_SPE_NV_REMOTE is a snooping operation and it can happen
> > in any cache levels in remote chip:
> > 
> >         data_src->mem_lvl = PERF_MEM_LVL_HIT;
> >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> >         data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> 
> Ok.
> 
> > 
> > > +	case ARM_SPE_NV_DRAM:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> > > +		break;
> > 
> > We can set snoop as PERF_MEM_SNOOP_MISS for DRAM data source:
> > 
> >         data_src->mem_lvl = PERF_MEM_LVL_HIT;
> >         data_src->mem_snoop = PERF_MEM_SNOOP_MISS;
> >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
> > 
> 
> Ok.

Thanks a lot for your work!

Leo

[1] https://en.wikipedia.org/wiki/MOSI_protocol
