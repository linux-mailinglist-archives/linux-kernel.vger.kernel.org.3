Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380E34D77EE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiCMTUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCMTUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:20:46 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F949915;
        Sun, 13 Mar 2022 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647199177; x=1678735177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ve+oXaOgu6qvGAolk5Rb1X8uZUgs41sB9uCGpnnALzQ=;
  b=jyFmOz+n4JvzeL/caUaghqkWSnrdRQ4Gg16NIT9At6R4PHB07f0jg9yt
   Zn66/gBj+LhVPuxqd550U7r7XmZYtr5UfVhOM3rsN0pUWieA5b2oZOF1l
   B/nNTeKswmi093AYa1KnAa+u6N8lq9gjcR2uNgGflsnYiQEDs3ShF8F7o
   I=;
X-IronPort-AV: E=Sophos;i="5.90,179,1643673600"; 
   d="scan'208";a="999060961"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 13 Mar 2022 19:19:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com (Postfix) with ESMTPS id 54BE041995;
        Sun, 13 Mar 2022 19:19:36 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 13 Mar 2022 19:19:36 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 13 Mar 2022 19:19:35 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Sun, 13 Mar 2022 19:19:35
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 867CB76A; Sun, 13 Mar 2022 19:19:34 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <leo.yan@linaro.org>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <alisaidi@amazon.com>, <andrew.kilroy@arm.com>,
        <benh@kernel.crashing.org>, <german.gomez@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <kjain@linux.ibm.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>, <yao.jin@linux.intel.com>
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is used
Date:   Sun, 13 Mar 2022 19:19:33 +0000
Message-ID: <20220313191933.26621-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220313124427.GB143848@leoy-ThinkPad-X240s>
References: <20220313124427.GB143848@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Sun, 13 Mar 2022 12:46:02 +0000, Leo Yan wrote:
> On Wed, Mar 02, 2022 at 03:39:04PM +0000, German Gomez wrote:
> > 
> > On 21/02/2022 22:48, Ali Saidi wrote:
> > > Current code only support HITM statistics for last level cache (LLC)
> > > when mem_lvl encodes the level. On existing Arm64 machines there are as
> > > many as four levels cache and this change supports decoding l1, l2, and
> > > llc hits from the mem_lvl_num data. Given that the mem_lvl namespace is
> > > being deprecated take this opportunity to encode the neoverse data into
> > > mem_lvl_num.
> > 
> > Since Neoverse is mentioned in the commit message, I think there should be a comment somewhere in the code as well.
> >
> 
> > > For loads that hit in a the LLC snoop filter and are fullfilled from a
> > > higher level cache, it's not usually clear what the true level of the
> > > cache the data came from (i.e. a transfer from a core could come from
> > > it's L1 or L2). Instead of making an assumption of where the line came
> > > from, add support for incrementing HITM if the source is CACHE_ANY.
> > >
> > > Since other architectures don't seem to populate the mem_lvl_num field
> > > here there shouldn't be a change in functionality.
> > >
> > > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > > ---
> > >  tools/perf/util/mem-events.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> > > index ed0ab838bcc5..6c3fd4aac7ae 100644
> > > --- a/tools/perf/util/mem-events.c
> > > +++ b/tools/perf/util/mem-events.c
> > > @@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
> > >  	u64 daddr  = mi->daddr.addr;
> > >  	u64 op     = data_src->mem_op;
> > >  	u64 lvl    = data_src->mem_lvl;
> > > +	u64 lnum   = data_src->mem_lvl_num;
> > >  	u64 snoop  = data_src->mem_snoop;
> > >  	u64 lock   = data_src->mem_lock;
> > >  	u64 blk    = data_src->mem_blk;
> > > @@ -527,16 +528,18 @@ do {				\
> > >  			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
> > >  			if (lvl & P(LVL, IO))  stats->ld_io++;
> > >  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
> > > -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> > > -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> > > -			if (lvl & P(LVL, L3 )) {
> > > +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> > > +				stats->ld_l1hit++;
> > > +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> > > +				stats->ld_l2hit++;
> 
> It's good to split into two patches: one patch is to add statistics for
> field 'mem_lvl_num', the second patch is to handle HITM tags.
> 
> > > +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {
> 
> It's a bit weird that we take either PERF_MEM_LVL_L3 or
> PERF_MEM_LVLNUM_L4 as the last level local cache in the same condition
> checking.
> 
> > According to a comment in the previous patch, using L4 is specific to Neoverse, right?
> > 
> > Maybe we need to distinguish the Neoverse case from the generic one here as well
> > 
> > if (is_neoverse)
> > // treat L4 as llc
> > else
> > // treat L3 as llc
> 
> I personally think it's not good idea to distinguish platforms in the decoding code.

I agree here. The more we talk about this, the more I'm wondering if we're
spending too much code solving a problem that doesn't exist. I know of no
Neoverse systems that actually have 4 cache levels, they all actually have three
even though it's technically possible to have four.  I have some doubts anyone
will actually build four levels of cache and perhaps the most prudent path here
is to assume only three levels (and adjust the previous patch) until someone 
actually produces a system with four levels instead of a lot of code that is
never actually exercised?

Thanks,
Ali

