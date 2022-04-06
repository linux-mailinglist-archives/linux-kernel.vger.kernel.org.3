Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC07D4F643F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiDFP4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiDFP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:56:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B25AE69C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649251396; x=1680787396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D/2p8w7LqfpUhFjPcN1odO+2muCpehswAzNgoS39MJw=;
  b=Lm1soxImFAsHC9PmiZMCloU4cdO2LvyP5ac0VrpCoOO0Hdk5Sxcv4and
   o/okgQAJvr2i79n24OP/q37BWmU3578qJmpsHiTmCT5dwVjdK0A2+jc/j
   nJFQCqaNUfNzSzLkrHphsbKEzlr+5UFZ8DZXfH6mAAv7S2pGvnlNIWnNz
   ZA4TRCT3WDira1eV6898Jhp2ZmllvbexYRNBBQ/zvSrUKimr9Lpl+SWCO
   OGZkSPKh3aqnMJNttvVtO24wvQFLz+51etczq5H3m8fv5xMvRPzqgunEt
   rXwmhoVvOBTRpadFLi4eSaNMDfIrSkn6b1BrTkYGur6W/E+aVlJCvX7nb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248564684"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="248564684"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:23:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="722511594"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:23:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc5bS-000EVg-Am;
        Wed, 06 Apr 2022 16:21:42 +0300
Date:   Wed, 6 Apr 2022 16:21:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Detlev Casanova <detlev.casanova@collabora.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 1/1] regulator/rpi-panel-attiny: Get rid of duplicate
 of_node assignment
Message-ID: <Yk2T5rjR6Qn0nEFx@smile.fi.intel.com>
References: <20220325184508.45670-1-andriy.shevchenko@linux.intel.com>
 <Yk2PNas3YIGQLZ04@smile.fi.intel.com>
 <Yk2R5el6fUm4FQo5@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk2R5el6fUm4FQo5@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 02:13:09PM +0100, Mark Brown wrote:
> On Wed, Apr 06, 2022 at 04:01:41PM +0300, Andy Shevchenko wrote:
> > On Fri, Mar 25, 2022 at 08:45:08PM +0200, Andy Shevchenko wrote:
> > > GPIO library does copy the of_node from the parent device of
> > > the GPIO chip, there is no need to repeat this in the individual
> > > drivers. Remove these assignment all at once.
> > > 
> > > For the details one may look into the of_gpio_dev_init() implementation.
> > 
> > Any comments on this? Can it be applied now?
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.

Oops, indeed, it has been only 12 days passed with no nothing :-)

-- 
With Best Regards,
Andy Shevchenko


