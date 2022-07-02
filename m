Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989185640CD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiGBOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGBOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 10:40:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF52389F;
        Sat,  2 Jul 2022 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656772802; x=1688308802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B6rf/XsGgPRYPW9MIP6DyZelrdINxacxtyD3IRRnWrg=;
  b=RhX47Xg9FY3ChIIB0cDrGFdchATWdhrjM8jXjbs5DgpFPXhUpEK98vE4
   li43bs4HSgtw6RWsKFC9OE9wHCQnHGTIgyxXaMfg+9sVo8X6io9I6GFgd
   LhenALIDCt9qxn7T5TEjFPkvNA/hw3EqYYo3CWMDtYhDvEmbrKwmpdTaM
   YmDi4LOqYs+7nuInrOVKSnicC+6DrnHcup0sCBIt/TeLBOKnK9oI7YRoj
   cF0ImpMvOTZFbnmEsQnVLZoO+w7SGaz6SxoPTUIslYn3dwUpvAiq7QkEM
   i+uZkEIZWGqTicJRMnfV87k3hItdLLJmB3LBAknJv32Mh93AHNHpGxVDU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="263231741"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="263231741"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 07:40:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="624580967"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 07:39:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7eHs-0013hy-1L;
        Sat, 02 Jul 2022 17:39:56 +0300
Date:   Sat, 2 Jul 2022 17:39:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Conall O'Griofa <conall.o'griofa@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device
 properties
Message-ID: <YsBYvPKfZRLygCyz@smile.fi.intel.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
 <20220603183224.540b3808@jic23-huawei>
 <e2efcf6d-ed85-dc6e-64e1-f0efedd4a673@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2efcf6d-ed85-dc6e-64e1-f0efedd4a673@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:58:04PM +0200, Michal Simek wrote:
> On 6/3/22 19:32, Jonathan Cameron wrote:
> > On Tue, 31 May 2022 17:11:17 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.
> > > 
> > > Add mod_devicetable.h include.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > These both seem good to me, but as the driver is fairly actively maintained,
> > I'll let this one sit on the list for a while so others can take a look.
> > 
> > Whilst it 'seems' unlikely anyone will ever use this driver with other firmware
> > I am keen to reduce the number of of-specific drivers in IIO just to avoid
> > any chance of cut and paste.
> > 
> > Who knows, I'm trying to run an aspeed-i2c driver with ACPI at the moment
> > because it's handy for a emulated setup, so maybe the same will one day happen
> > with this device :)  Weirder things have happened.
> 
> Conall: Can you please test these changes and provide your feedback?

Hmm... No news? 

-- 
With Best Regards,
Andy Shevchenko


