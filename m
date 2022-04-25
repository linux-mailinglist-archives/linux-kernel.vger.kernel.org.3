Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56E50DABB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiDYIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiDYH7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:59:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390AFCD2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650873359; x=1682409359;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n+/wbTwudVU2aA3nzC/xFgJqQskv98VvTFPXw2JV4mQ=;
  b=UBtBpH0K/GUlICOaqLI+e74cpEsRkf6NGMzvCjs9gsyGj6joRUQrH8vc
   h4xD9FinqA3D3Yz4LAH6gLIv0CQidNA/gEEwuxqLE+IpyHjf2bDgYP2OV
   7yvPPKJUUNamlx6j5aMnacBz1745G1ASnSeSn02MzuPvLDXYfIyFIYVVC
   Rc21vSbsohC7LgO2f77g6+KWaDQ1r4Ijck3nWjl6NO44l8KOYp0Cxa+Pm
   8aV+r8a/H+mqrVqOEpEDpGQzwuBdpito0j9qgApHYJZMb7q/xORDPACdf
   wa/7xu/loEJiNgBOC2CBJg/l330B8E/rgTtNTyiCoIWLuMwB40cUUrhsS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351622192"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="351622192"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:55:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="579152268"
Received: from wupeng-mobl.ccr.corp.intel.com ([10.254.215.115])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:55:54 -0700
Message-ID: <6c6694965fa3e6d85d78d56703090f227a55bb83.camel@intel.com>
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if
 swap read fails
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tim C Chen <tim.c.chen@intel.com>
Date:   Mon, 25 Apr 2022 15:55:51 +0800
In-Reply-To: <f88412b4-83db-e594-fc48-2f4b8b9f3be8@redhat.com>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
         <20220424091105.48374-2-linmiaohe@huawei.com>
         <8aeebc2f0b2a251d3d70402cd0edf063ba911013.camel@intel.com>
         <f88412b4-83db-e594-fc48-2f4b8b9f3be8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 09:49 +0200, David Hildenbrand wrote:
> On 25.04.22 09:41, ying.huang@intel.com wrote:
> > Hi, Miaohe,
> > 
> > On Sun, 2022-04-24 at 17:11 +0800, Miaohe Lin wrote:
> > > There is a bug in unuse_pte(): when swap page happens to be unreadable,
> > > page filled with random data is mapped into user address space.  In case
> > > of error, a special swap entry indicating swap read fails is set to the
> > > page table.  So the swapcache page can be freed and the user won't end up
> > > with a permanently mounted swap because a sector is bad.  And if the page
> > > is accessed later, the user process will be killed so that corrupted data
> > > is never consumed.  On the other hand, if the page is never accessed, the
> > > user won't even notice it.
> > > 
> > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >  include/linux/swap.h    |  7 ++++++-
> > >  include/linux/swapops.h | 10 ++++++++++
> > >  mm/memory.c             |  5 ++++-
> > >  mm/swapfile.c           | 11 +++++++++++
> > >  4 files changed, 31 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > index 5553189d0215..b82c196d8867 100644
> > > --- a/include/linux/swap.h
> > > +++ b/include/linux/swap.h
> > > @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
> > >   * actions on faults.
> > >   */
> > > 
> > > +#define SWP_SWAPIN_ERROR_NUM 1
> > > +#define SWP_SWAPIN_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
> > > +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
> > > +			     SWP_PTE_MARKER_NUM)
> > > 
> > > 
> > 
> > It appears wasteful to use another swap device number. 
> 
> Do we really care?
> 
> We currently use 5 bits for swap types, so we have a total of 32.
> 
> SWP_HWPOISON_NUM -> 1
> SWP_MIGRATION_NUM -> 3
> SWP_PTE_MARKER_NUM -> 1
> SWP_DEVICE_NUM -> 4
> SWP_SWAPIN_ERROR_NUM -> 1
> 
> Which would leave us with 32 - 10 = 22 swap devices. IMHO that's plenty
> for real life scenarios.

Creating multiple swap partitions on one disk can improve the
scalability of swap subsystem, although we usually don't have so many
disks for swap. 

> I'd prefer reworking this when we really run into trouble (and we could
> think about using more bits for applicable architectures then, for
> select 64bit architectures it might be fairly easily possible).

Best Regards,
Huang, Ying


