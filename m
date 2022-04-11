Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C14FB96D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbiDKKZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345454AbiDKKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:24:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E9843AF7;
        Mon, 11 Apr 2022 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649672490; x=1681208490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=amumK3yMKSrAOE1LG8R18fhmudBi/m9hSWqv87hC1hI=;
  b=dQrnYfwCQ888lhk66aoVxfsGNp0c04ILBnNC2zVF/0i8lwCDSCmv6Gig
   tnz9GEvCibWFSzZ/t0xNx1Nho0JMPO9ys+dmCUVQG+t5qcIMoElHU4Tcj
   +mnuv1deWbdwrvlMyDaMBMM9fM9UdHUZxhZjY0z2toLREZ2O5lh23UwZI
   WCCeAdtR+psfTKhRusCq9o+o4/utqzozE0SFtluXRFb4I52Z1qP8B0hvr
   t+ODUAfoG+dIY1Blj91U32Mv4BBvFauR1W4sRddUaczKJkFnTQkK9y3FF
   1r60VlR93mfPE6WsshsiYm42TI5G1iv5DS443Ql7jAVZVd9qqRYFLo60G
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261827070"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="261827070"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:21:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="589827163"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:21:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndr6x-001B6F-MI;
        Mon, 11 Apr 2022 13:17:31 +0300
Date:   Mon, 11 Apr 2022 13:17:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com,
        kuba@kernel.org, saravanak@google.com,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl355: use fwnode_irq_get_byname()
Message-ID: <YlQAO7jHzUwRUvEU@smile.fi.intel.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
 <20211109200840.135019-3-puranjay12@gmail.com>
 <YflfEpKj0ilHnQQm@smile.fi.intel.com>
 <20220227124134.4d4e4644@jic23-huawei>
 <20220410181306.23202f25@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410181306.23202f25@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 06:13:06PM +0100, Jonathan Cameron wrote:
> On Sun, 27 Feb 2022 12:41:34 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 1 Feb 2022 18:25:54 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > On Wed, Nov 10, 2021 at 01:38:40AM +0530, Puranjay Mohan wrote:  
> > > > Use the generic fwnode_irq_get_byname() in place of of_irq_get_byname()
> > > > to get the IRQ number from the interrupt pin.    
> > > 
> > > Heads up, the fwnode_irq_get_byname() is in I2C tree and if Jonathan wants to
> > > apply this one, the PR [1] can be used.
> > > 
> > > [1]: https://lore.kernel.org/linux-i2c/YfRiGR3AT8tzyweG@shikoro/T/#u
> > >   
> > 
> > Thanks Andy. 
> > 
> > I'm going to let this go the slow way and pick up this patch after the
> > merge window when I can avoid pulling in that PR.
> > 
> > Basically I'm feeling lazy today :)
> 
> Now applied to the togreg branch of iio.git and pushed out as testing to
> see if 0-day can find any problems.

Thanks for keeping an eye on it!

-- 
With Best Regards,
Andy Shevchenko


