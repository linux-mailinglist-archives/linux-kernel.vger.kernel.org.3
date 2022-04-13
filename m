Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4F4FEC44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiDMB27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiDMB24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:28:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED537A11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649813194; x=1681349194;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1dFfKAGAqmFb2acfSDAZBnW2rzbquz+sm7/oVTChW8=;
  b=HgzZKJUTp0iZncYBPY5Asxfpaw3CtX6ho7cdqoALZsvG7T4aGcKJ233N
   fz2NOwNOUUG5ykgNPoe2nM+b9ZzhGNiHeBv+4DQMcYmaZ4Mzo65aofNfZ
   g5Say5VTAEHRv86+vmyoaQDPtzYWRIbYVQiMWjOKoeYdbN/LWsOpTQpXs
   5JlOPgUoZkkxFgZ3PmZQad+7J6xdlfpr1zUMiT3e85SkShvPPYtLjhWwx
   PLiohw4M73adV8I//4gcw1aUdUF4kTM+IZbXUIQgrV3lca1NPu8Jy++6F
   XUkEYNpRWUP3tmfDKaUeJMrZj9awfc/SHpm37WfrLL37lNLYbyreQcPB8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="325452967"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="325452967"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 18:26:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="573049417"
Received: from zouyunlo-mobl.ccr.corp.intel.com ([10.254.213.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 18:26:15 -0700
Message-ID: <a90dc108e54e19cf3aa3fd21f6321afa8f194adc.camel@intel.com>
Subject: Re: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page
 check
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        hch@infradead.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>
Date:   Wed, 13 Apr 2022 09:26:13 +0800
In-Reply-To: <b153b758-ce11-364a-2699-753b21250508@redhat.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
         <20220409093500.10329-3-linmiaohe@huawei.com>
         <YlU/h0fdE1L846Bd@localhost.localdomain>
         <7455b680-3d89-5d3e-ba0e-6e4358b114a2@huawei.com>
         <b153b758-ce11-364a-2699-753b21250508@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 16:59 +0200, David Hildenbrand wrote:
> On 12.04.22 15:42, Miaohe Lin wrote:
> > On 2022/4/12 16:59, Oscar Salvador wrote:
> > > On Sat, Apr 09, 2022 at 05:34:53PM +0800, Miaohe Lin wrote:
> > > > We don't need to check can_split_folio() because folio_maybe_dma_pinned()
> > > > is checked before. It will avoid the long term pinned pages to be swapped
> > > > out. And we can live with short term pinned pages. Without can_split_folio
> > > > checking we can simplify the code. Also activate_locked can be changed to
> > > > keep_locked as it's just short term pinning.
> > > 
> > > What do you mean by "we can live with short term pinned pages"?
> > > Does it mean that it was not pinned when we check
> > > folio_maybe_dma_pinned() but now it is?
> > > 
> > > To me it looks like the pinning is fluctuating and we rely on
> > > split_folio_to_list() to see whether we succeed or not, and if not
> > > we give it another spin in the next round?
> > 
> > Yes. Short term pinned pages is relative to long term pinned pages and these pages won't be
> > pinned for a noticeable time. So it's expected to split the folio successfully in the next
> > round as the pinning is really fluctuating. Or am I miss something?
> > 
> 
> Just so we're on the same page. folio_maybe_dma_pinned() only capture
> FOLL_PIN, but not FOLL_GET. You can have long-term FOLL_GET right now
> via vmsplice().

Per my original understanding, folio_maybe_dma_pinned() can be used to
detect long-term pinned pages.  And it seems reasonable to skip the
long-term pinned pages and try short-term pinned pages during page
reclaiming.  But as you pointed out, vmsplice() doesn't use FOLL_PIN. 
So if vmsplice() is expected to pin pages for long time, and we have no
way to detect it, then we should keep can_split_folio() in the original
code.

Copying more people who have worked on long-term pinning for comments.

Best Regards,
Huang, Ying 

> can_split_folio() is more precise then folio_maybe_dma_pinned(), but
> both are racy as long as the page is still mapped.
> 
> 


