Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F653DF1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351888AbiFFAoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 20:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351840AbiFFAoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:44:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BE25286
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654476251; x=1686012251;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v72JwO4ZEs4E4qmYCJBQG3/w1N1+brvvHURcuUQL7aA=;
  b=M/i3Dg3lbIX4IkcvfoZP+hOKK5cymsfQ362/QdR7n0jslm1nz1PJDQNx
   jZAoUk34cWgtDepGoKoSZ8dKqnBt+tRJIMzGynZMWubRAh2NUUlWGECcd
   c8h/tVSOKLIR/oNvWEWr+bim3gwWG95nny8Q8sc8H4OALhReG1NR7560n
   LZU7eCGmncmTISvyux1xMYkvTArn22/F1BrF0mGXDBJP0G7jntOBYXndW
   rDiYpZCwIF2+9fVka6mVXsFjOHvrwZg0cTw2HNi1fmrViqxEcK2aTSYeE
   j653t06GVI0hnaeF15lpb7MkMH5NfKpUoPmJxdR55Euq0rdewMrMS3WrC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="339729384"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="339729384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 17:44:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583354699"
Received: from xingguom-mobl.ccr.corp.intel.com ([10.254.213.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 17:44:06 -0700
Message-ID: <9f6e60cc8be3cbde4871458c612c5c31d2a9e056.camel@intel.com>
Subject: Re: [RFC PATCH v4 7/7] mm/demotion: Demote pages according to
 allocation fallback order
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Mon, 06 Jun 2022 08:43:44 +0800
In-Reply-To: <046c373a-f30b-091d-47a1-e28bfb7e9394@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-8-aneesh.kumar@linux.ibm.com>
         <b102d5773bffd6391283773044f756e810c1f044.camel@intel.com>
         <046c373a-f30b-091d-47a1-e28bfb7e9394@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 20:39 +0530, Aneesh Kumar K V wrote:
> On 6/2/22 1:05 PM, Ying Huang wrote:
> > On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> > > From: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > 
> > > currently, a higher tier node can only be demoted to selected
> > > nodes on the next lower tier as defined by the demotion path,
> > > not any other node from any lower tier.  This strict, hard-coded
> > > demotion order does not work in all use cases (e.g. some use cases
> > > may want to allow cross-socket demotion to another node in the same
> > > demotion tier as a fallback when the preferred demotion node is out
> > > of space). This demotion order is also inconsistent with the page
> > > allocation fallback order when all the nodes in a higher tier are
> > > out of space: The page allocation can fall back to any node from any
> > > lower tier, whereas the demotion order doesn't allow that currently.
> > > 
> > > This patch adds support to get all the allowed demotion targets mask
> > > for node, also demote_page_list() function is modified to utilize this
> > > allowed node mask by filling it in migration_target_control structure
> > > before passing it to migrate_pages().
> > 
> 
> ...
> 
> > >    * Take pages on @demote_list and attempt to demote them to
> > >    * another node.  Pages which are not demoted are left on
> > > @@ -1481,6 +1464,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
> > >   {
> > >   	int target_nid = next_demotion_node(pgdat->node_id);
> > >   	unsigned int nr_succeeded;
> > > +	nodemask_t allowed_mask;
> > > +
> > > +	struct migration_target_control mtc = {
> > > +		/*
> > > +		 * Allocate from 'node', or fail quickly and quietly.
> > > +		 * When this happens, 'page' will likely just be discarded
> > > +		 * instead of migrated.
> > > +		 */
> > > +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> > > +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> > > +		.nid = target_nid,
> > > +		.nmask = &allowed_mask
> > > +	};
> > 
> > IMHO, we should try to allocate from preferred node firstly (which will
> > kick kswapd of the preferred node if necessary).  If failed, we will
> > fallback to all allowed node.
> > 
> > As we discussed as follows,
> > 
> > https://lore.kernel.org/lkml/69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com/
> > 
> > That is, something like below,
> > 
> > static struct page *alloc_demote_page(struct page *page, unsigned long node)
> > {
> > 	struct page *page;
> > 	nodemask_t allowed_mask;
> > 	struct migration_target_control mtc = {
> > 		/*
> > 		 * Allocate from 'node', or fail quickly and quietly.
> > 		 * When this happens, 'page' will likely just be discarded
> > 		 * instead of migrated.
> > 		 */
> > 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> > 			    __GFP_THISNODE  | __GFP_NOWARN |
> > 			    __GFP_NOMEMALLOC | GFP_NOWAIT,
> > 		.nid = node
> > 	};
> > 
> > 	page = alloc_migration_target(page, (unsigned long)&mtc);
> > 	if (page)
> > 		return page;
> > 
> > 	mtc.gfp_mask &= ~__GFP_THISNODE;
> > 	mtc.nmask = &allowed_mask;
> > 
> > 	return alloc_migration_target(page, (unsigned long)&mtc);
> > }
> 
> I skipped doing this in v5 because I was not sure this is really what we 
> want.

I think so.  And this is the original behavior.  We should keep the
original behavior as much as possible, then make changes if necessary.

> I guess we can do this as part of the change that is going to 
> introduce the usage of memory policy for the allocation?

Like the memory allocation policy, the default policy should be local
preferred.  We shouldn't force users to use explicit memory policy for
that.

And the added code isn't complex.

Best Regards,
Huang, Ying

