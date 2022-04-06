Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641294F6D0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiDFVka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiDFVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:38:45 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3A217982;
        Wed,  6 Apr 2022 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649278833; x=1680814833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/RUYgJiJDHB7xj8zcZPP8Nba0qoMBr1iDzWuUq4ooM=;
  b=BFG+AfrLxKrsTOM2H2eEXEg/F3vjones0/CYf+6wxFzUD1OvyS0Z7x55
   QTUPQUHhuxe2SmUxBcGdRCN74gP/Jbe7bhFb6roVthpcmJFEEEGWiIho4
   K0cF/w9eUBBn64D9cKCduvVWOe/ZLdvVRKEiUo/XixN0Dkvpr2rESB10s
   U=;
X-IronPort-AV: E=Sophos;i="5.90,240,1643673600"; 
   d="scan'208";a="77373843"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 06 Apr 2022 21:00:30 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com (Postfix) with ESMTPS id BF0E7C0271;
        Wed,  6 Apr 2022 21:00:24 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 6 Apr 2022 21:00:24 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 6 Apr 2022 21:00:23 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Wed, 6 Apr 2022 21:00:23 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 134A62510; Wed,  6 Apr 2022 21:00:22 +0000 (UTC)
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
Date:   Wed, 6 Apr 2022 21:00:17 +0000
Message-ID: <20220406210017.11887-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151218.GA898573@leoy-ThinkPad-X240s>
References: <20220404151218.GA898573@leoy-ThinkPad-X240s>
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

On Mon, 4 Apr 2022 15:12:18  +0000, Leo Yan wrote:
> On Sun, Apr 03, 2022 at 08:33:37PM +0000, Ali Saidi wrote:

[...]

> > The latter logic is why I think it's perfectly acceptable to use HITM to
> > indicate a peer cache-to-cache transfer, however since others don't feel that way
> > let me propose a single additional snooping type PERF_MEM_SNOOP_PEER that
> > indicates some peer of the hierarchy below the originating core sourced the
> > data.  This clears up the definition that line came from from a peer and may or
> > may not have been modified, but it doesn't add a lot of implementation dependant
> > functionality into the SNOOP API. 
> > 
> > We could use the mem-level to indicate the level of the cache hierarchy we had
> > to get to before the snoop traveled upward, which seems like what x86 is doing
> > here.
> 
> It makes sense to me that to use the highest cache level as mem-level.
> Please add comments in the code for this, this would be useful for
> understanding the code.

Ok.

> > PEER_CORE -> MEM_SNOOP_PEER + L2
> > PEER_CLSTR -> MEM_SNOOP_PEER + L3
> > PEER_LCL_CLSTR -> MEM_SNOOP_PEER + L3 (since newer neoverse cores don't support
> > the clusters and the existing commercial implementations don't have them).
> 
> Generally, this idea is fine for me.

Great.  

Now the next tricky thing. Since we're not using HITM for recording the memory
events, the question becomes for the c2c output should we output the SNOOP_PEER
events as if they are HITM events with a clarification in the perf-c2c man page
or effectively duplicate all the lcl_hitm logic, which is a fair amount,  in
perf c2c to add a column and sort option? 

> Following your suggestion, if we connect the concepts PoC and PoU in Arm
> reference manual, we can extend the snooping mode with MEM_SNOOP_POU
> (for PoU) and MEM_SNOOP_POC (for PoC), so:
> 
> PEER_CORE -> MEM_SNOOP_POU + L2
> PEER_LCL_CLSTR -> MEM_SNOOP_POU + L3
> PEER_CLSTR -> MEM_SNOOP_POC + L3
> 
> Seems to me, we could consider for this.  If this is over complexity or
> even I said any wrong concepts for this, please use your method.

I think this adds a lot of complexity and reduces clarity. Some systems
implement coherent icaches and the PoU would be the L1 cache, others don't so
that would be the L2 (or wherever there is a unified cache). Similarly, with the
point of coherency, some systems would consider that dram, but other systems
have transparent LLCs and it would be the LLC. 

Thanks,
Ali

