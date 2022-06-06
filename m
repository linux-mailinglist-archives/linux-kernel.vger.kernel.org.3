Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C509853E390
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiFFHY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiFFHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:24:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615F31AF16
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654500292; x=1686036292;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xNNv8f5KLFlwE8E16qBiInBjz2utO9UckXry2wUB1oc=;
  b=W096bTZK6adSx4Fy1Zg0nkqhm1yjBOU76u90E+cYBep6CEhgFMWK9uZ1
   EK1OEo1U/obOC+7X/CZJc3lZIYeUNcwKn24jqQKa7RtwThYmzA/ivq4VM
   DhD9sXlc7YpcbWOfl2cZMsP3yP1rC6P7lNG2SLtmsss19JRm7sR1HHY+H
   qRqmkloh1/2sZFSeBPp72GG/VkuYaTYzZZekIoHMdKY6DAaQll47IoHba
   nYxLG3Tbsg2O8Bqje+DtXx5ao9XtFcihmQOv2LCM2XKvISd1ivPi3RXaU
   kA7sZlwMjoKk41heCB9UOCAXmQo1ajJJXpkv3CJseujVrlp9VplEov97N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="275411503"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="275411503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 00:24:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635461994"
Received: from xingguom-mobl.ccr.corp.intel.com ([10.254.213.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 00:24:43 -0700
Message-ID: <11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com>
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
Date:   Mon, 06 Jun 2022 15:24:38 +0800
In-Reply-To: <f9a26536-05f6-5d12-5c61-cdd35ab33a40@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
         <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
         <f9a26536-05f6-5d12-5c61-cdd35ab33a40@linux.ibm.com>
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

On Mon, 2022-06-06 at 09:22 +0530, Aneesh Kumar K V wrote:
> On 6/6/22 8:41 AM, Ying Huang wrote:
> > On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > > With memory tiers support we can have memory on NUMA nodes
> > > in the top tier from which we want to avoid promotion tracking NUMA
> > > faults. Update node_is_toptier to work with memory tiers. To
> > > avoid taking locks, a nodemask is maintained for all demotion
> > > targets. All NUMA nodes are by default top tier nodes and as
> > > we add new lower memory tiers NUMA nodes get added to the
> > > demotion targets thereby moving them out of the top tier.
> > 
> > Check the usage of node_is_toptier(),
> > 
> > - migrate_misplaced_page()
> >    node_is_toptier() is used to check whether migration is a promotion.
> > We can avoid to use it.  Just compare the rank of the nodes.
> > 
> > - change_pte_range() and change_huge_pmd()
> >    node_is_toptier() is used to avoid scanning fast memory (DRAM) pages
> > for promotion.  So I think we should change the name to node_is_fast()
> > as follows,
> > 
> > static inline bool node_is_fast(int node)
> > {
> > 	return NODE_DATA(node)->mt_rank >= MEMORY_RANK_DRAM;
> > }
> > 
> 
> But that gives special meaning to MEMORY_RANK_DRAM. As detailed in other 
> patches, absolute value of rank doesn't carry any meaning. It is only
> the relative value w.r.t other memory tiers that decide whether it is 
> fast or not. Agreed by default memory tiers get built with 
> MEMORY_RANK_DRAM. But userspace can change the rank value of 'memtier1' 
> Hence to determine a node is consisting of fast memory is essentially 
> figuring out whether node is the top most tier in memory hierarchy and 
> not just the memory tier rank value is >= MEMORY_RANK_DRAM?

In a system with 3 tiers,

HBM	0
DRAM	1
PMEM	2

In your implementation, only HBM will be considered fast.  But what we
need is to consider both HBM and DRAM fast.  Because we use NUMA
balancing to promote PMEM pages to DRAM.  It's unnecessary to scan HBM
and DRAM pages for that.  And there're no requirements to promote DRAM
pages to HBM with NUMA balancing.

I can understand that the memory tiers are more dynamic now.  For
requirements of NUMA balancing, we need the lowest memory tier (rank)
where there's at least one node with CPU.  The nodes in it and the
higher tiers will be considered fast. 


Best Regards,
Huang, Ying

