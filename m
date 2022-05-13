Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFFA525BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377636AbiEMHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiEMHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:04:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76D29BC69
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652425488; x=1683961488;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sawKbh59agg1iUxoGQ2w1FRcN8D+N8ccR6rZnCreP0M=;
  b=ic32GU2kPrbtCaiU996iKmmD46oqQSvnKB1B1B54G/wjNxhh+W5uahM2
   ffSb8D1dXxZX/KTeFocw23QWM/7lPWdxV3EEsmSSTFOA6nttp1V+plTpP
   jqkpBME4bucHXPSrpx2G/nBezpkV3U/5suiof3isLNZMF/JF5MMwb58yo
   eytecqIeA9fP/ZTQcKaupsZOG+vCRHVvtbxo4nvgmiMIaAsMvtFfz7KXq
   PN/QiBDkCoxUAAt9ddaFbpleLRl+KaOFJ68BaWqMT+qvife1IeBuqtUBk
   tGpwtsLb9R8eJiYnqXTKtRpfT4xJLGtjjyRJ1i5HfpCm017satHyh+Ubz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267830499"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="267830499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 00:04:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="595085051"
Received: from jliu69-mobl.ccr.corp.intel.com ([10.254.212.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 00:04:43 -0700
Message-ID: <a3296507be17d99e60d4c1118699aa01268dd7b8.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Date:   Fri, 13 May 2022 15:04:39 +0800
In-Reply-To: <CAAPL-u9endrWf_aOnPENDPdvT-2-YhCAeJ7ONGckGnXErTLOfQ@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
         <69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com>
         <CAAPL-u9endrWf_aOnPENDPdvT-2-YhCAeJ7ONGckGnXErTLOfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 23:36 -0700, Wei Xu wrote:
> On Thu, May 12, 2022 at 8:25 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
> > 
> > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> > > 
> > > Memory Allocation for Demotion
> > > ==============================
> > > 
> > > To allocate a new page as the demotion target for a page, the kernel
> > > calls the allocation function (__alloc_pages_nodemask) with the
> > > source page node as the preferred node and the union of all lower
> > > tier nodes as the allowed nodemask.  The actual target node selection
> > > then follows the allocation fallback order that the kernel has
> > > already defined.
> > > 
> > > The pseudo code looks like:
> > > 
> > >     targets = NODE_MASK_NONE;
> > >     src_nid = page_to_nid(page);
> > >     src_tier = node_tier_map[src_nid];
> > >     for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
> > >             nodes_or(targets, targets, memory_tiers[i]);
> > >     new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);
> > > 
> > > The memopolicy of cpuset, vma and owner task of the source page can
> > > be set to refine the demotion target nodemask, e.g. to prevent
> > > demotion or select a particular allowed node as the demotion target.
> > 
> > Consider a system with 3 tiers, if we want to demote some pages from
> > tier 0, the desired behavior is,
> > 
> > - Allocate pages from tier 1
> > - If there's no enough free pages in tier 1, wakeup kswapd of tier 1 so
> > demote some pages from tier 1 to tier 2
> > - If there's still no enough free pages in tier 1, allocate pages from
> > tier 2.
> > 
> > In this way, tier 0 will have the hottest pages, while tier 1 will have
> > the coldest pages.
> 
> When we are already in the allocation path for the demotion of a page
> from tier 0, I think we'd better not block this allocation to wait for
> kswapd to demote pages from tier 1 to tier 2. Instead, we should
> directly allocate from tier 2.  Meanwhile, this demotion can wakeup
> kswapd to demote from tier 1 to tier 2 in the background.

Yes.  That's what I want too.  My original words may be misleading.

> > With your proposed method, the demoting from tier 0 behavior is,
> > 
> > - Allocate pages from tier 1
> > - If there's no enough free pages in tier 1, allocate pages in tier 2
> > 
> > The kswapd of tier 1 will not be waken up until there's no enough free
> > pages in tier 2.  In quite long time, there's no much hot/cold
> > differentiation between tier 1 and tier 2.
> 
> This is true with the current allocation code. But I think we can make
> some changes for demotion allocations. For example, we can add a
> GFP_DEMOTE flag and update the allocation function to wake up kswapd
> when this flag is set and we need to fall back to another node.
> 
> > This isn't hard to be fixed, just call __alloc_pages_nodemask() for each
> > tier one by one considering page allocation fallback order.
> 
> That would have worked, except that there is an example earlier, in
> which it is actually preferred for some nodes to demote to their tier
> + 2, not tier +1.
> 
> More specifically, the example is:
> 
>                  20
>    Node 0 (DRAM) -- Node 1 (DRAM)
>     |   |           |    |
>     |   | 30    120 |    |
>     |   v           v    | 100
> 100 |  Node 2 (PMEM)     |
>     |    |               |
>     |    | 100           |
>      \   v               v
>       -> Node 3 (Large Mem)
> 
> Node distances:
> node   0    1    2    3
>    0  10   20   30  100
>    1  20   10  120  100
>    2  30  120   10  100
>    3 100  100  100   10
> 
> 3 memory tiers are defined:
> tier 0: 0-1
> tier 1: 2
> tier 2: 3
> 
> The demotion fallback order is:
> node 0: 2, 3
> node 1: 3, 2
> node 2: 3
> node 3: empty
> 
> Note that even though node 3 is in tier 2 and node 2 is in tier 1,
> node 1 (tier 0) still prefers node 3 as its first demotion target, not
> node 2.

Yes.  I understand that we need to support this use case.  We can use
the tier order in allocation fallback list instead of from small to
large.  That is, for node 1, the tier order for demotion is tier 2, tier
1.

Best Regards,
Huang, Ying


