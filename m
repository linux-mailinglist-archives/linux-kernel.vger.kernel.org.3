Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DA564882
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiGCQCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiGCQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 12:02:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C925CB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656864120; x=1688400120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LFCYg06P721k2OS8mT/aIPlNpwZYmhL+24Av+WOtZAk=;
  b=fNvzhX18/oeMoKKrfSXbqgqydUAkXw9OlQ7dUiQCwIF61b4tbedX67Th
   3GQaPp1D4tzRasL0kdqUt2zX94jhSLXn2fFXiWVUNPXgNe71dDi9WvUYS
   qr2GePIayiUdYlOp10KurkxKEZ+tvP0lhPdrmtj+8KSLktvk0iIh8fjC6
   JJbFjgOW0vvM1fMtKtuscpzGplOnihbMUrKXqYVjtO4KJCj7JOr4OdZ3V
   jokg69xuJ4i9z0PTD5Ku8CdM3loDGUhDJcbYbGmX8dKKV7JHvtc1NuE+a
   yQWAi1J7pXBRYovCkGGlU+fYQaUawRAcuTAR/kSEINFt5z+D4OsXCGZk4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="284069554"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="284069554"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 09:01:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="592215902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 09:01:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o822m-0014Rj-0R;
        Sun, 03 Jul 2022 19:01:56 +0300
Date:   Sun, 3 Jul 2022 19:01:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Fei1 <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <YsG9c1vba1Nyrmqf@smile.fi.intel.com>
References: <20220607174120.34981-1-andriy.shevchenko@linux.intel.com>
 <20220615162054.GA571776@louislifei-OptiPlex-7090>
 <YrGx1Bs8Goj3/TLv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrGx1Bs8Goj3/TLv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 02:56:04PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 16, 2022 at 12:20:54AM +0800, Li Fei1 wrote:
> > On Tue, Jun 07, 2022 at 08:41:20PM +0300, Andy Shevchenko wrote:
> > > After the commits for userspace [1][2] the uuid field is not being
> > > used in the ACRN code. Update kernel to reflect these changes.
> > > I.e. we do the following:
> > > - adding a comment explaining that it's not used anymore
> > > - replacing the specific type by a raw buffer
> > > - updating the example code accordingly
> > > 
> > > [1]: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> > > [2]: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> > > 
> > > Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> > > Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Signed-off-by: Fei Li <fei1.li@intel.com>
> 
> Dunno if SoB works for Greg, works for me.
> Thanks!

Greg, can this be applied?

-- 
With Best Regards,
Andy Shevchenko


