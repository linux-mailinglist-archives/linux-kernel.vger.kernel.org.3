Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6811650E621
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbiDYQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiDYQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:50:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F81EAC3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650905266; x=1682441266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a9BDJcnlrIQsrCXefta5uSMROAe8pIoioCGuS9ojEX0=;
  b=RO3QuqbN+ocUJcgV4iFoa5ZDxYTKo0vTuWHaTB1pSTh2uLojxfpyRg5q
   sKe0TQA9qSmPKnXPidBtpMebPqQCC6dKPoKE0tKTNQUPycyk/dpBwrdoE
   /Pdtz2DoQdsNUluyHlY+sK7zA4gDEvdZ6sGencmsVg8oFb5/Dz6C6Ha6v
   e2AqfZSoMOi0t10By+H8OSb/yPvh/vHrPNVD8DREwYe0oCllVztLdEgZ7
   V4PPoeJibETE9+m5fYdg4e2FiMvO52Z7gndq/a2Dw/VDJYVxmyfRFlcDc
   az0UR3RavlS2fsPLpBpeHenuegGMNOlepJ30MdgJxBQWqyu7Tge0A2T1D
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265106395"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="265106395"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:47:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="649778889"
Received: from kruparel-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.188.223])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:47:19 -0700
Date:   Mon, 25 Apr 2022 09:47:18 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Message-ID: <YmbQluz5i95fkhn9@iweiny-desk3>
References: <20220424104806.25396-1-fmdefrancesco@gmail.com>
 <8929547.CDJkKcVGEf@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8929547.CDJkKcVGEf@leap>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:47:38AM +0200, Fabio M. De Francesco wrote:
> On domenica 24 aprile 2022 12:48:06 CEST Fabio M. De Francesco wrote:
> > Call VM_BUG_ON() if offset + len > PAGE_SIZE.
> > 
> > This is an RFC patch because I'm not sure if we actually need to 
> BUG_ON(),
> 
> Actually I considered VM_BUG_ON() for consistency with the other functions 
> in highmem.h
> 
> What about VM_WARN_ON_ONCE() here and also in memset_page?

For consistency leave this as a VM_BUG_ON[1]

I've been down a similar path[2] and there was a long discussion about it.[3]

In the end we settled on VM_BUG_ON.[4]

As to the addition of flush_dcache_page().  There was a discussion here.

https://lore.kernel.org/lkml/CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com/

Ira

[1] https://lore.kernel.org/lkml/20210209205249.GB2975576@iweiny-DESK2.sc.intel.com/

[2] https://lore.kernel.org/lkml/20201209022250.GP1563847@iweiny-DESK2.sc.intel.com/

[3] https://lore.kernel.org/lkml/20201208213255.GO1563847@iweiny-DESK2.sc.intel.com/

[4] https://lore.kernel.org/lkml/20210210174928.3156073-1-ira.weiny@intel.com/

> 
> Thanks,
> 
> Fabio
> 
> > so I'd like to know what Maintainers and other developers think about 
> this
> > proposal.
> > 
> > Please note that memset_page() uses VM_BUG_ON() to prevent the same 
> issue.
> > 
> > Furthermore, I also cannot understand why memset_page() does not call
> > flush_dcache_page() after memset() but I suppose that the different
> > implementations of these two functions should be addressed in another 
> RFC.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  include/linux/highmem.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index c3d562b5f0c1..bdb16d5f8148 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -349,6 +349,8 @@ static inline void memcpy_to_page(struct page *page, 
> size_t offset,
> >  static inline void memzero_page(struct page *page, size_t offset, size_t 
> len)
> >  {
> >  	char *addr = kmap_local_page(page);
> > +
> > +	VM_BUG_ON(offset + len > PAGE_SIZE);
> >  	memset(addr + offset, 0, len);
> >  	flush_dcache_page(page);
> >  	kunmap_local(addr);
> > -- 
> > 2.34.1
> > 
> > 
> 
> 
> 
> 
