Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE884C1103
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiBWLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiBWLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:09:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C47D51E67;
        Wed, 23 Feb 2022 03:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645614545; x=1677150545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bEi1L6SwVM/6CJVdlUOVjo6ZwWjlnoYanZAzOTomTqU=;
  b=OR+FWQGY01xMPHwuWYMZ+/Gyq8NrmE2PSPIH4+StWiQXmpoYU6TJvdct
   zeOkfKNmUVJAOI+v76L5M5wwDQDjwPQRjjYUuXQu8QhivLM4LMT//Jl15
   ECaXKRi41vWwLbeRwfCdpP1o23kT3jA5zEYNe2kO5d/85UdDDdo4iU6QM
   LK2dYu8AJQECuswVXCqxTGfYMrV1L9LBQ05aaS1KJvkbc6Ac7eRzNpSDC
   mCW75KdrGQi4xHaDUlbFgN4StNd0vDZwOrmCIjHKYi+RzNwiOIqzAhTfY
   GjTvE+Xqx63jSFvjICy8K9RAGwLh27QrtMIXy0a2DBWDKATj2fi7guF53
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252131954"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="252131954"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:09:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="639268315"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:09:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMpVD-007O3U-JA;
        Wed, 23 Feb 2022 13:08:11 +0200
Date:   Wed, 23 Feb 2022 13:08:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Message-ID: <YhYVl9YaoPDwAXO4@smile.fi.intel.com>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
 <Ygy7dNqFLZF9XYiH@infradead.org>
 <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
 <YhUJAl5JpCoXik7X@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhUJAl5JpCoXik7X@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:02:10AM -0800, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 10:14:16AM +0100, Jiri Slaby wrote:
> > On 16. 02. 22, 9:53, Christoph Hellwig wrote:
> > > On Tue, Feb 15, 2022 at 03:43:59PM +0200, Andy Shevchenko wrote:
> > > > The pci_iounmap() doesn't cover all the cases where resource should
> > > > be unmapped. Instead of spreading it more, replace the pci_ioremap_bar()
> > > > with pcim_iomap() which uses managed resource approach.
> > > 
> > > pcim_iomap requires the use of ioreadX/iowriteX and thus runtime
> > > overhead.  So in doubt please add a pcim_ioremap_bar instead of forcing
> > > the legacy iomap/ioread/iowrite API onto modern drivers tht can't
> > > support legacy port I/O.
> > 
> > Hmm, the driver combines pci_ioremap_bar with pci_iounmap. pci_iounmap does
> > the right thing after all, but is that correct? And this driver is not
> > alone, this shows more:
> > git grep -E 'pci_iounmap|pci_ioremap_bar' `git grep -l pci_iounmap \`git
> > grep -l pci_ioremap_bar\``
> 
> I think it is wrong.  It is not actively harmful unlike the the
> combination of pci_iomap and then later use of accessors from the
> ioremap family, but still not exactly a good idea.
> 
> In a perfect world we'd have some different annotation from __iomem
> for the whole iomap family of functions.

So, what would be your suggestion for a) backportable change b) cleanup for
the current and future drivers?

-- 
With Best Regards,
Andy Shevchenko


