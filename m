Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C054AF11A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiBIMLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiBIMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:11:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D158C1038F6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644407777; x=1675943777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Iyisy+Ou0kWFIqDJOqlqTBvzyz5qmeIE9EcOe5udqE=;
  b=MyEni+BT+Q2r3U5v4kVFf6buz/ozJZiTAOCQi3U/yF/NZBe7lD5ju8uT
   pDGnDSHeYVsnUJ7CT95Qq+FnLn8lYedDr7NPKrFbRbVABAKWcTdLn9hxT
   TvSqNJs0CEpC192ZjGTZvaMSvcgWzfb7I/zgpmOwxHGgZm3+rGLbuZoW9
   oabwLeJ7D8hgkCKzzS6P9MNGLudiHGtgHxKCF0IB+5JmuA3C4/qE4bOBu
   yLWIRYslkL4BGV6559OazaQbgdtvYLmwUh1yyWshbpZ/5IKaWiZGduq2h
   wY9+0G4N03D7tZp7gtuNxM3I04eu5jy+7vSrp6dcssShd2+8u4a2jKdzI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335589314"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="335589314"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:56:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="771321954"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:56:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHlZ7-002bIz-6P;
        Wed, 09 Feb 2022 13:55:17 +0200
Date:   Wed, 9 Feb 2022 13:55:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/dma: Use DMA ops setter instead of direct
 assignment
Message-ID: <YgOrpC/Wg2MA7eRy@smile.fi.intel.com>
References: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
 <58e77093-51e2-59a2-e413-164d83ecd9b8@arm.com>
 <YgNoENf1EIFmaeDD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgNoENf1EIFmaeDD@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:06:56PM -0800, Christoph Hellwig wrote:
> On Mon, Feb 07, 2022 at 03:55:32PM +0000, Robin Murphy wrote:
> > On 2022-02-07 14:13, Andy Shevchenko wrote:
> > > Use DMA ops setter instead of direct assignment. Even we know that
> > > this module doesn't perform access to the dma_ops member of struct device,
> > > it's better to use setter to avoid potential problems in the future.
> > 
> > What potential problems are you imagining? This whole file is a DMA ops
> > implementation, not driver code (and definitely not a module); if anyone
> > removes the "select DMA_OPS" from CONFIG_IOMMU_DMA they deserve whatever
> > breakage they get.
> > 
> > I concur that there's no major harm in using the helper here, but I also see
> > no point in pretending that there's any value to abstracting the operation
> > in this particular context.
> 
> Yeah.  Killing off the the wrapper is actually on my todo list, mostly
> because it leads to people doing completely broken things like the VDPA
> private dma ops that should not exist.

Let's abandon this change. (I see that it's kinda 50/50 of the users
with API and without)

-- 
With Best Regards,
Andy Shevchenko


