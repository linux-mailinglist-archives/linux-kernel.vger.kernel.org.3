Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5074F0C83
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiDCUfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiDCUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:35:36 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D213BE04;
        Sun,  3 Apr 2022 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649018021; x=1680554021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yry5sisjHSjsPl/LZLim4oE1RCo3IseEsv7pRzQuJcM=;
  b=MtE+KqcODv2hDnvsy2caboegfQ3jUF7LCW43ZPjvUAZOiE5Jlor8Zq+f
   TM7HfUUG/Cba1tpiJALLn6dmFib8Rz6DpTMK8Q03Vd7NwHT6wjprdDdoZ
   G/TYST3+6uvSFv/e3rG9YI+UEcAMk7agcxtBIG1fC3v/rzKAM2zW/Ltqj
   k=;
X-IronPort-AV: E=Sophos;i="5.90,231,1643673600"; 
   d="scan'208";a="1004483214"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 03 Apr 2022 20:33:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-72dc3927.us-west-2.amazon.com (Postfix) with ESMTPS id 42E444163F;
        Sun,  3 Apr 2022 20:33:40 +0000 (UTC)
Received: from EX13D02UWB004.ant.amazon.com (10.43.161.11) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 3 Apr 2022 20:33:39 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D02UWB004.ant.amazon.com (10.43.161.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 3 Apr 2022 20:33:39 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Sun, 3 Apr 2022 20:33:38 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 038A81760; Sun,  3 Apr 2022 20:33:38 +0000 (UTC)
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
Date:   Sun, 3 Apr 2022 20:33:37 +0000
Message-ID: <20220403203337.18927-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331124425.GB1704284@leoy-ThinkPad-X240s>
References: <20220331124425.GB1704284@leoy-ThinkPad-X240s>
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



On Thu, 31 Mar 2022 12:44:3 +0000, Leo Yan wrote:
> 
> On Thu, Mar 31, 2022 at 01:28:58PM +0100, German Gomez wrote:
> > Hi all,
> > 
> > It seems I gave the Review tags a bit too early this time. Apologies for
> > the inconvenience. Indeed there was more interesting discussions to be
> > had :)
> > 
> > (Probably best to remove by tags for the next re-spin)
> 
> Now worries, German.  Your review and testing are very helpful :)
> 
> > On 29/03/2022 15:32, Ali Saidi wrote:
> > > [...]
> > >
> > >> I still think we should consider to extend the memory levels to
> > >> demonstrate clear momory hierarchy on Arm archs, I personally like the
> > >> definitions for "PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE",
> > >> though these cache levels are not precise like L1/L2/L3 levels, they can
> > >> help us to map very well for the cache topology on Arm archs and without
> > >> any confusion.  We could take this as an enhancement if you don't want
> > >> to bother the current patch set's upstreaming.
> > > I'd like to do this in a separate patch, but I have one other proposal. The
> > > Neoverse cores L2 is strictly inclusive of the L1, so even if it's in the L1,
> > > it's also in the L2. Given that the Graviton systems and afaik the Ampere
> > > systems don't have any cache between the L2 and the SLC, thus anything from
> > > PEER_CORE, LCL_CLSTR, or PEER_CLSTR would hit in the L2, perhaps we
> > > should just set L2 for these cases? German, are you good with this for now? 
> > 
> > Sorry for the delay. I'd like to also check this with someone. I'll try
> > to get back asap. In the meantime, if this approach is also OK with Leo,
> > I think it would be fine by me.
> 
> Thanks for the checking internally.  Let me just bring up my another
> thinking (sorry that my suggestion is float): another choice is we set
> ANY_CACHE as cache level if we are not certain the cache level, and
> extend snoop field to indicate the snooping logics, like:
> 
>   PERF_MEM_SNOOP_PEER_CORE
>   PERF_MEM_SNOOP_LCL_CLSTR
>   PERF_MEM_SNOOP_PEER_CLSTR
> 
> Seems to me, we doing this is not only for cache level, it's more
> important for users to know the variant cost for involving different
> snooping logics.

I think we've come full circle :). Going back to what do we want to indicate to
a user about the source of the cache line, I believe there are three things with
an eye toward helping a user of the data improve the performance of their
application:

1. The level below them in the hierarchy it it (L1, L2, LLC, local DRAM).
Depending on the level this directly indicates the expense of the operation. 

2. If it came from a peer of theirs on the same socket. I'm really of the
opinion still that exactly which peer, doesn't matter much as it's a 2nd or 3rd
order concern compared to, it it couldn't be sourced from a cache level below
the originating core, had to come from a local peer and the request went to
that lower levels and was eventually sourced from a peer.  Why it was sourced
from the peer is still almost irrelevant to me. If it was truly modified or the
core it was sourced from only had permission to modify it the snoop filter
doesn't necessarily need to know the difference and the outcome is the same. 

3. For multi-socket systems that it came from a different socket and there it is
probably most interesting if it came from DRAM on the remote socket or a cache.

I'm putting 3 aside for now since we've really been focusing on 1 and 2 in this
discussion and I think the biggest hangup has been the definition of HIT vs
HITM. If someone has a precise definition, that would be great, but AFAIK it
goes back to the P6 bus where HIT was asserted by another core if it had a line
(in any state) and HITM was additionally asserted if a core needed to inhibit
another device (e.g. DDR controller) from providing that line to the requestor. 

The latter logic is why I think it's perfectly acceptable to use HITM to
indicate a peer cache-to-cache transfer, however since others don't feel that way
let me propose a single additional snooping type PERF_MEM_SNOOP_PEER that
indicates some peer of the hierarchy below the originating core sourced the
data.  This clears up the definition that line came from from a peer and may or
may not have been modified, but it doesn't add a lot of implementation dependant
functionality into the SNOOP API. 

We could use the mem-level to indicate the level of the cache hierarchy we had
to get to before the snoop traveled upward, which seems like what x86 is doing
here.

PEER_CORE -> MEM_SNOOP_PEER + L2
PEER_CLSTR -> MEM_SNOOP_PEER + L3
PEER_LCL_CLSTR -> MEM_SNOOP_PEER + L3 (since newer neoverse cores don't support
the clusters and the existing commercial implementations don't have them).

Thanks,
Ali






