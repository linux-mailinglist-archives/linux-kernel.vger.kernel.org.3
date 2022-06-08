Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59A5542B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiFHJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiFHJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:10:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE841CC628
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654677173; x=1686213173;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G52/nLgCDh+Ek240z5/x7QVUAuqh4G1y5UEKf+oYdBg=;
  b=CVB/ckgAy6sk5RLJoz2I9gtIv8uEC1nPizkjtf6WzQeaSUPJXFkG2t6q
   EfLyXT5PupKWqCG4/OkmQOjjNKRU1t+tbB0TXGaM0ImmaJFWx3zallpYY
   bYOOwacElJdoTFtTDo2BJFjPmcTR2MP6YPAYKhCUG3S0LJ4aTJqlaICd7
   H0oS9QjoxJMTeR/EK3RpCrqaCbXtN9JKcTYX68FFzQiqU9IjY/zBTiCpj
   vibSP6uSTdwp5hRJn5T8KYyF6qwkrsTyCga7BG1U3MIvTAYzHRosvXT7A
   JOxBeimpM07T7qsOrFyPG51kWpqAtDrtjIZAwCIjN08G1cv1i5lukj+Hh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340931070"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="340931070"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:32:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636676678"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:32:48 -0700
Message-ID: <cc9566421dedf10b5b7149d093992797540c31e2.camel@intel.com>
Subject: Re: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with
 memory tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
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
Date:   Wed, 08 Jun 2022 16:32:46 +0800
In-Reply-To: <232817e0-24fd-e022-6c92-c260f7f01f8a@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
         <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
         <f9a26536-05f6-5d12-5c61-cdd35ab33a40@linux.ibm.com>
         <11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com>
         <d2513be5-be87-2957-a0d4-1d99b9e83114@linux.ibm.com>
         <db0200f4467c072470d8ed7e272132bfeb146ac2.camel@intel.com>
         <232817e0-24fd-e022-6c92-c260f7f01f8a@linux.ibm.com>
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

On Wed, 2022-06-08 at 13:58 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 12:56 PM, Ying Huang wrote:
> > On Mon, 2022-06-06 at 14:03 +0530, Aneesh Kumar K V wrote:
> > > On 6/6/22 12:54 PM, Ying Huang wrote:
> > > > On Mon, 2022-06-06 at 09:22 +0530, Aneesh Kumar K V wrote:
> > > > > On 6/6/22 8:41 AM, Ying Huang wrote:
> > > > > > On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > > > > > > With memory tiers support we can have memory on NUMA nodes
> > > > > > > in the top tier from which we want to avoid promotion tracking NUMA
> > > > > > > faults. Update node_is_toptier to work with memory tiers. To
> > > > > > > avoid taking locks, a nodemask is maintained for all demotion
> > > > > > > targets. All NUMA nodes are by default top tier nodes and as
> > > > > > > we add new lower memory tiers NUMA nodes get added to the
> > > > > > > demotion targets thereby moving them out of the top tier.
> > > > > > 
> > > > > > Check the usage of node_is_toptier(),
> > > > > > 
> > > > > > - migrate_misplaced_page()
> > > > > >      node_is_toptier() is used to check whether migration is a promotion.
> > > > > > We can avoid to use it.  Just compare the rank of the nodes.
> > > > > > 
> > > > > > - change_pte_range() and change_huge_pmd()
> > > > > >      node_is_toptier() is used to avoid scanning fast memory (DRAM) pages
> > > > > > for promotion.  So I think we should change the name to node_is_fast()
> > > > > > as follows,
> > > > > > 
> > > > > > static inline bool node_is_fast(int node)
> > > > > > {
> > > > > > 	return NODE_DATA(node)->mt_rank >= MEMORY_RANK_DRAM;
> > > > > > }
> > > > > > 
> > > > > 
> > > > > But that gives special meaning to MEMORY_RANK_DRAM. As detailed in other
> > > > > patches, absolute value of rank doesn't carry any meaning. It is only
> > > > > the relative value w.r.t other memory tiers that decide whether it is
> > > > > fast or not. Agreed by default memory tiers get built with
> > > > > MEMORY_RANK_DRAM. But userspace can change the rank value of 'memtier1'
> > > > > Hence to determine a node is consisting of fast memory is essentially
> > > > > figuring out whether node is the top most tier in memory hierarchy and
> > > > > not just the memory tier rank value is >= MEMORY_RANK_DRAM?
> > > > 
> > > > In a system with 3 tiers,
> > > > 
> > > > HBM	0
> > > > DRAM	1
> > > > PMEM	2
> > > > 
> > > > In your implementation, only HBM will be considered fast.  But what we
> > > > need is to consider both HBM and DRAM fast.  Because we use NUMA
> > > > balancing to promote PMEM pages to DRAM.  It's unnecessary to scan HBM
> > > > and DRAM pages for that.  And there're no requirements to promote DRAM
> > > > pages to HBM with NUMA balancing.
> > > > 
> > > > I can understand that the memory tiers are more dynamic now.  For
> > > > requirements of NUMA balancing, we need the lowest memory tier (rank)
> > > > where there's at least one node with CPU.  The nodes in it and the
> > > > higher tiers will be considered fast.
> > > > 
> > > 
> > > is this good (not tested)?
> > > /*
> > >    * build the allowed promotion mask. Promotion is allowed
> > >    * from higher memory tier to lower memory tier only if
> > >    * lower memory tier doesn't include compute. We want to
> > >    * skip promotion from a memory tier, if any node which is
> > >    * part of that memory tier have CPUs. Once we detect such
> > >    * a memory tier, we consider that tier as top tier from
> > >    * which promotion is not allowed.
> > >    */
> > > list_for_each_entry_reverse(memtier, &memory_tiers, list) {
> > > 	nodes_and(allowed, node_state[N_CPU], memtier->nodelist);
> > > 	if (nodes_empty(allowed))
> > > 		nodes_or(promotion_mask, promotion_mask, allowed);
> > > 	else
> > > 		break;
> > > }
> > > 
> > > and then
> > > 
> > > static inline bool node_is_toptier(int node)
> > > {
> > > 
> > > 	return !node_isset(node, promotion_mask);
> > > }
> > > 
> > 
> > This should work.  But it appears unnatural.  So, I don't think we
> > should avoid to add more and more node masks to mitigate the design
> > decision that we cannot access memory tier information directly.  All
> > these becomes simple and natural, if we can access memory tier
> > information directly.
> > 
> 
> how do you derive whether node is toptier details if we have memtier 
> details in pgdat?

pgdat -> memory tier -> rank

Then we can compare this rank with the fast memory rank.  The fast
memory rank can be calculated dynamically at appropriate places.

Best Regards,
Huang, Ying



