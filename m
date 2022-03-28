Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768AA4E8C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiC1DJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiC1DJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:09:51 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA313DDA;
        Sun, 27 Mar 2022 20:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648436891; x=1679972891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhaB1BjSqeLnTDlhAY8eLig+TJPQB28oho+qaR1ktlM=;
  b=eGs7IvsFzXptEoMjqZZ0pS4SiXFNyLo/J4F98BKJyVohOAFSXB+Ay87E
   YLntwq0ixCrYMxnl0zBbb//Q+37pVbJtYpJrNKAAdJrK9NG5GMdnZBraE
   d/2ftILV5ZyYfRqH3M/jA/8pq53aIZqwmneopeIAzdRyAFhUEjGjR2Trd
   s=;
X-IronPort-AV: E=Sophos;i="5.90,216,1643673600"; 
   d="scan'208";a="74412587"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-d14a57da.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 28 Mar 2022 03:08:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-d14a57da.us-west-2.amazon.com (Postfix) with ESMTPS id 2868F1201F8;
        Mon, 28 Mar 2022 03:08:09 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 28 Mar 2022 03:08:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 28 Mar 2022 03:08:07 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Mon, 28 Mar 2022 03:08:07
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 398A72571; Mon, 28 Mar 2022 03:08:06 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <alisaidi@amazon.com>
CC:     <Nick.Forrington@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <andrew.kilroy@arm.com>,
        <benh@kernel.crashing.org>, <german.gomez@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <kjain@linux.ibm.com>, <leo.yan@linaro.org>,
        <lihuafei1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse cores
Date:   Mon, 28 Mar 2022 03:08:05 +0000
Message-ID: <20220328030805.14175-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326194327.32239-1-alisaidi@amazon.com>
References: <20220326194327.32239-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

Thanks for the additional comments.

On Sun, 27 Mar 2022 07:09:19 +0000, Leo Yan wrote:
[snip]
> 
> > > Please see below comments.
> > > 
> > > > +	switch (record->source) {
> > > > +	case ARM_SPE_NV_L1D:
> > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > > > +		break;
> > > 
> > > I think we need to set the field 'mem_snoop' for L1 cache hit:
> > > 
> > >         data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> > > 
> > > For L1 cache hit, it doesn't involve snooping.
> >
> > I can't find a precise definition for SNOOP_NONE, but it seemed as though
> > this would be used for cases where a snoop could have occurred but didn't
> > not for accesses that by definition don't snoop? I'm happy with either way,
> > perhaps i just read more into it.
> 
> I have the same understanding with you that "this would be used for
> cases where a snoop could have occurred but didn't not for accesses
> that by definition don't snoop".
> 
> If we refer to PEBS's data source type 01H: "Minimal latency core cache
> hit.  This request was satisfied by the L1 data cache" and x86 sets
> SNOOP_NONE as the snoop type for this case.

I'm happy to set it if everyone believes it's the right thing.

[snip]
> > Same comment as above.
> > 
> > > > +	case ARM_SPE_NV_PEER_CORE:
> > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > > 
> > > Peer core contains its local L1 cache, so I think we can set the
> > > memory level L1 to indicate this case.
> > It could be either the L1 or the L2. All the neoverse cores have private L2
> > caches and we don't know. 
> 
> How about set both L1 and L2 cache together for this case?
> 
> Although 'L1 | L2' cannot tell the exact cache level, I think it's
> better than use ANY_CACHE, at least this can help us to distinguish
> from other data source types if we avoid to use ANY_CACHE for all of
> them.

This seems much more confusing then the ambiguity of where the line came from
and is only possible with the deprecated mem_lvl enconding.  It will make
perf_mem__lvl_scnprintf() print the wrong thing and anyone who is trying to
attribute a line to a single cache will find that the sum of the number of hits
is greater than the number of accesses which also seems terribly confusing.

> 
> > > For this data source type and below types, though they indicate
> > > the snooping happens, but it doesn't mean the data in the cache line
> > > is in 'modified' state.  If set flag PERF_MEM_SNOOP_HITM, I personally
> > > think this will mislead users when report the result.
> > 
> > I'm of the opposite opinion. If the data wasn't modified, it will likely be
> > found in the lower-level shared cache and the transaction wouldn't require a
> > cache-to-cache transfer of the modified data, so the most common case when we
> > source a line out of another cores cache will be if it was "modifiable" in that
> > cache. 
> 
> Let's still use MOSI protocol as example.  I think there have two
> cases: on case is the peer cache line is in 'Shared' state and another
> case is the peer cache line is in 'Owned' state.
> 
> Quotes the wiki page for these two cases:
> 
> "When the cache block is in the Shared (S) state and there is a
> snooped bus read (BusRd) transaction, then the block stays in the same
> state and generates no more transactions as all the cache blocks have
> the same value including the main memory and it is only being read,
> not written into."
> 
> "While in the Owner (O) state and there is a snooped read request
> (BusRd), the block remains in the same state while flushing (Flush)
> the data for the other processor to read from it."
> 
> Seems to me, it's reasonable to set HTIM flag when the snooping happens
> for the cache line line is in the Modified (M) state.
> 
> Again, my comment is based on the literal understanding; so please
> correct if have any misunderstanding at here.

Per the CMN TRM, "The SLC allocation policy is exclusive for data lines, except
where sharing patterns are detected," so if a line is shared among caches it
will likely also be in the SLC (and thus we'd get an L3 hit). 

If there is one copy of the cache line and that cache line needs to transition
from one core to another core, I don't believe it matters if it was truly
modified or not because the core already had permission to modify it and the
transaction is just as costly (ping ponging between core caches). This is the
one thing I really want to be able to uniquely identify as any cacheline doing
this that isn't a lock is a place where optimization is likely possible. 

> 
> > > I prefer we set below fields for ARM_SPE_NV_PEER_CORE:
> > > 
> > >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L1;
> > >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> > >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > > 
> > > > +		break;
> > > > +	/*
> > > > +	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
> > > > +	 * transfer, so set SNOOP_HITM
> > > > +	 */
> > > > +	case ARM_SPE_NV_LCL_CLSTR:
> > > 
> > > For ARM_SPE_NV_LCL_CLSTR, it fetches the data from the shared cache in
> > > the cluster level, it should happen in L2 cache:
> > > 
> > >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L2;
> > >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> > >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> > 
> > We don't know if this is coming from the cluster cache, or the private L1 or L2
> > core caches. The description above about why we'll be transferring the line from
> > cache-to-cache applies here too. 
> 
> I think a minor difference between PEER_CORE and LCL_CLSTR is:
> if data source is PEER_CORE, the snooping happens on the peer core's
> local cache (Core's L1 or Core's L2 when core contains L2); for the data
> source LCL_CLSTR, the snooping occurs on the cluster level's cache
> (cluster's L2 cache or cluster's L3 cache when cluster contains L3).
> 
> So can we set both 'L2 | L3' for LCL_CLSTR case?

Just as above, I believe setting two options will lead to more confusion.
Additionally, we agreed in the previous discussion that the system cache shall
be the L3, so i don't see how this helps alleviate any confusion. That said, the
systems I'm most familiar with never set LCL_CLSTR as a source. 


> > > > +	case ARM_SPE_NV_PEER_CLSTR:
> > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > > > +		break;
> > > 
> > > This type can snoop from L1 or L2 cache in the peer cluster, so it
> > > makes sense to set cache level as PERF_MEM_LVLNUM_ANY_CACHE.  But here
> > > should use the snoop type PERF_MEM_SNOOP_HIT, so:
> > > 
> > >         data_src->mem_lvl = PERF_MEM_LVL_HIT
> > >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> > >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > 
> > Given that we agreed to only focus on the three levels generally used by
> > the existing implementations LCL and PEER should be the same for now. 
> 
> For PEER_CLSTR, we don't know the snooping happening on CPU's private
> cache or cluster's shared cache, this is why we should use ANY_CACHE
> for cache level.
> 
> But LCL_CLSTR is different from PEER_CLSTR, LCL_CLSTR indicates the
> snooping on the local cluster's share cache, we set 'L2 | L3' for it;
> therefore, we can distinguish between these two cases.

For the same reasons above, I believe we should only set a single value. 

> 
> > > > +	/*
> > > > +	 * System cache is assumed to be L3
> > > > +	 */
> > > > +	case ARM_SPE_NV_SYS_CACHE:
> > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > > > +		break;
> > > 
> > >         data_src->mem_lvl = PERF_MEM_LVL_HIT | PERF_MEM_LVL_L3;
> > >         data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> > >         data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> > 
> > I don't think we should set both the deprecated mem_lvl and the mem_lvl_num. 
> 
> Is this because the decoding flow has any specific requirement that
> only can set mem_lvl_num and not set mem_lvl?

As one example, perf_mem__lvl_scnprintf() breaks if both are set. 

> 
> > If we're hitting in the unified L3 cache, we aren't actually snooping anything
> > which is why I didn't set mem_snoop here.
> 
> I am a bit suspecious for the clarification.  If the system cache is in
> the cache conhernecy domain, then snooping occurs on it; in other words,
> if system cache is connected with a bus (like CCI or CMN), and the bus
> can help for data consistency, I prefer to set SNOOP_HIT flag.
> 
> Could you confirm for this?

Thinking about this more that seems reasonable. 

Thanks,
Ali

