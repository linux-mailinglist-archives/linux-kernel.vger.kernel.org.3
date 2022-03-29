Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34ED4EAF49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiC2OeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiC2OeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:34:08 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345371D0CE;
        Tue, 29 Mar 2022 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648564346; x=1680100346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3JsFdDl+un7ffLUD/HA9lrhBJaTGqmFQNbp178PyeGw=;
  b=o17MlotP6+UE/fzjTsT8g1Ju/Pe40KN6x1FeKtPZUbVRoVuNnL5e1IKQ
   66XrmBec1m8SzL0jzf3ti4Wl3/bjfnHmg5hwe82xUmcwZp4O3fyr8C1Yc
   mfZlfy/IWSM/6/WO9Jol8xX36+wT2PkoJIU/DEGhMMEEUnKmAoq76QSPN
   8=;
X-IronPort-AV: E=Sophos;i="5.90,220,1643673600"; 
   d="scan'208";a="185081582"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 29 Mar 2022 14:32:23 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com (Postfix) with ESMTPS id C7F4D81268;
        Tue, 29 Mar 2022 14:32:16 +0000 (UTC)
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 29 Mar 2022 14:32:15 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D02UWC004.ant.amazon.com (10.43.162.236) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 29 Mar 2022 14:32:15 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Tue, 29 Mar 2022 14:32:14
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id CDB13254B; Tue, 29 Mar 2022 14:32:14 +0000 (UTC)
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
Date:   Tue, 29 Mar 2022 14:32:14 +0000
Message-ID: <20220329143214.12707-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220328130547.GA360814@leoy-ThinkPad-X240s>
References: <20220328130547.GA360814@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 28 Mar 2022 21:05:47 +0800, Leo Yan wrote:
> Hi Ali,
> 
> On Mon, Mar 28, 2022 at 03:08:05AM +0000, Ali Saidi wrote:
> 
> [...]
> 
> > > > > > +	case ARM_SPE_NV_PEER_CORE:
> > > > > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > > > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > > > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> > > > > 
> > > > > Peer core contains its local L1 cache, so I think we can set the
> > > > > memory level L1 to indicate this case.
> > > > It could be either the L1 or the L2. All the neoverse cores have private L2
> > > > caches and we don't know. 
> > > 
> > > How about set both L1 and L2 cache together for this case?
> > > 
> > > Although 'L1 | L2' cannot tell the exact cache level, I think it's
> > > better than use ANY_CACHE, at least this can help us to distinguish
> > > from other data source types if we avoid to use ANY_CACHE for all of
> > > them.
> > 
> > This seems much more confusing then the ambiguity of where the line came from
> > and is only possible with the deprecated mem_lvl enconding.  It will make
> > perf_mem__lvl_scnprintf() print the wrong thing and anyone who is trying to
> > attribute a line to a single cache will find that the sum of the number of hits
> > is greater than the number of accesses which also seems terribly confusing.
> 
> Understand.  I considered the potential issue for
> perf_mem__lvl_scnprintf(), actually it supports printing multipl cache
> levels for 'mem_lvl', by conjuncting with 'or' it composes the multiple
> cache levels.  We might need to extend a bit for another field
> 'mem_lvlnum'.
> 
> Agreed that there would have inaccurate issue for statistics, it's fine
> for me to use ANY_CACHE in this patch set.

Thanks!

> 
> I still think we should consider to extend the memory levels to
> demonstrate clear momory hierarchy on Arm archs, I personally like the
> definitions for "PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE",
> though these cache levels are not precise like L1/L2/L3 levels, they can
> help us to map very well for the cache topology on Arm archs and without
> any confusion.  We could take this as an enhancement if you don't want
> to bother the current patch set's upstreaming.

I'd like to do this in a separate patch, but I have one other proposal. The
Neoverse cores L2 is strictly inclusive of the L1, so even if it's in the L1,
it's also in the L2. Given that the Graviton systems and afaik the Ampere
systems don't have any cache between the L2 and the SLC, thus anything from
PEER_CORE, LCL_CLSTR, or PEER_CLSTR would hit in the L2, perhaps we
should just set L2 for these cases? German, are you good with this for now? 

> > > > > For this data source type and below types, though they indicate
> > > > > the snooping happens, but it doesn't mean the data in the cache line
> > > > > is in 'modified' state.  If set flag PERF_MEM_SNOOP_HITM, I personally
> > > > > think this will mislead users when report the result.
> > > > 
> > > > I'm of the opposite opinion. If the data wasn't modified, it will likely be
> > > > found in the lower-level shared cache and the transaction wouldn't require a
> > > > cache-to-cache transfer of the modified data, so the most common case when we
> > > > source a line out of another cores cache will be if it was "modifiable" in that
> > > > cache. 
> > > 
> > > Let's still use MOSI protocol as example.  I think there have two
> > > cases: on case is the peer cache line is in 'Shared' state and another
> > > case is the peer cache line is in 'Owned' state.
> > > 
> > > Quotes the wiki page for these two cases:
> > > 
> > > "When the cache block is in the Shared (S) state and there is a
> > > snooped bus read (BusRd) transaction, then the block stays in the same
> > > state and generates no more transactions as all the cache blocks have
> > > the same value including the main memory and it is only being read,
> > > not written into."
> > > 
> > > "While in the Owner (O) state and there is a snooped read request
> > > (BusRd), the block remains in the same state while flushing (Flush)
> > > the data for the other processor to read from it."
> > > 
> > > Seems to me, it's reasonable to set HTIM flag when the snooping happens
> > > for the cache line line is in the Modified (M) state.
> > > 
> > > Again, my comment is based on the literal understanding; so please
> > > correct if have any misunderstanding at here.
> > 
> > Per the CMN TRM, "The SLC allocation policy is exclusive for data lines, except
> > where sharing patterns are detected," so if a line is shared among caches it
> > will likely also be in the SLC (and thus we'd get an L3 hit). 
> > 
> > If there is one copy of the cache line and that cache line needs to transition
> > from one core to another core, I don't believe it matters if it was truly
> > modified or not because the core already had permission to modify it and the
> > transaction is just as costly (ping ponging between core caches). This is the
> > one thing I really want to be able to uniquely identify as any cacheline doing
> > this that isn't a lock is a place where optimization is likely possible. 
> 
> I understood that your point that if big amount of transitions within
> multiple cores hit the same cache line, it would be very likely caused
> by the cache line's Modified state so we set PERF_MEM_SNOOP_HITM flag
> for easier reviewing.

And that from a dataflow perspective if the line is owned (and could be
modifiable) vs. was actually modified is really the less interesting bit. 

> Alternatively, I think it's good to pick up the patch series "perf c2c:
> Sort cacheline with all loads" [1], rather than relying on HITM tag, the
> patch series extends a new option "-d all" for perf c2c, so it displays
> the suspecious false sharing cache lines based on load/store ops and
> thread infos.  The main reason for holding on th patch set is due to we
> cannot verify it with Arm SPE at that time point, as the time being Arm
> SPE trace data was absent both store ops and data source packets.

Looking at examples I don't, at least from my system, data-source isn't set for
stores, only for loads. 

> I perfer to set PERF_MEM_SNOOP_HIT flag in this patch set and we can
> upstream the patch series "perf c2c: Sort cacheline with all loads"
> (only needs upstreaming patches 01, 02, 03, 10, 11, the rest patches
> have been merged in the mainline kernel).
> 
> If this is fine for you, I can respin the patch series for "perf c2c".
> Or any other thoughts?

I think this is a nice option to have in the tool-box, but from my point of
view, I'd like someone who is familiar with c2c output on x86 to come to an
arm64 system and be able to zero in on a ping-ponging line like they would
otherwise. Highlighting a line that is moving between cores frequently which is
likely in the exclusive state by tagging it an HITM accomplishes this and will
make it easier to find these cases.  Your approach also has innaccurancies and
wouldn't be able to differentiate between core X accessing a line a lot followed
by core Y acessing a line alot vs the cores ping-ponging.  Yes, I agree that we
will "overcount" HITM, but I don't think this is particularly bad and it does
specifically highlight the core-2-core transfers that are likely a performance
issue easily and it will result in easier identification of areas of false or
true sharing and improve performance.

Thanks,
Ali
