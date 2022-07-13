Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCED573AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiGMQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiGMQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:10:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0D3F31B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657728646; x=1689264646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YaTZAb4onP27jQNy4FL6qTy43D/CKE44lCvGOyD7eXI=;
  b=iUNPIGc/O72QWS2AfXOnCVTWi+3MMkoh9YZvl0GrR2lc54YjoXvbb4v5
   izATsUzCnC0+zr8THYEa9VmOlN1eF0YXBQ9snuAgzPNFSXowjtofHvva5
   MxW+2UnEr3dDUrrMPDPJjQZ9SLaBWhL0uXxo9nL0pHOvS0TA64fa4dE/a
   /h8jD1knKafzVCdX1SvUtVsoDd07Izk0iel8eE0xf56Sj40+UgJgbKZRy
   OiFMco/RpSOxE7d8ci5xVBKzvMDK8bOG89xp0lVyaEkuL2KiQKXwy5X5Q
   FtPOHhMa4uLsTz1d3lLtwlMC/WLfSPZad52iDnmwp5q9yJxnuUrGYPWhl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286013180"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="286013180"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:10:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="545912177"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:10:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBeue-001CSM-1N;
        Wed, 13 Jul 2022 19:08:32 +0300
Date:   Wed, 13 Jul 2022 19:08:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Provide an SSP type to the SPI
 driver
Message-ID: <Ys7uAFAXqczXm6Se@smile.fi.intel.com>
References: <20220702211903.9093-1-andriy.shevchenko@linux.intel.com>
 <Ys593spfcFtoILhS@google.com>
 <Ys6lFqm4/T/Kb3et@smile.fi.intel.com>
 <Ys7Eu72Xf5EnGDWM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7Eu72Xf5EnGDWM@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:12:27PM +0100, Lee Jones wrote:
> On Wed, 13 Jul 2022, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 09:10:06AM +0100, Lee Jones wrote:
> > > On Sun, 03 Jul 2022, Andy Shevchenko wrote:

...

> > > > +static const struct property_entry spt_spi_properties[] = {
> > > > +	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_SPT_SSP),
> > > > +	{ }
> > > > +};
> > > > +
> > > > +static const struct software_node spt_spi_node = {
> > > > +	.properties = spt_spi_properties,
> > > > +};
> > > > +
> > > >  static const struct intel_lpss_platform_info spt_info = {
> > > >  	.clk_rate = 120000000,
> > > > +	.swnode = &spt_spi_node,
> > > >  };
> > > 
> > > IMHO, this is a rubbish interface.
> > > 
> > > The amount of 10-line changes required to store a 32-bit value is
> > > depressing.  Is there not a reduced interface for storing small pieces
> > > of data that doesn't require arrays of structs?
> > 
> > The part of it that makes it longer because of differentiating the hardware,
> > but see the difference here:
> > 
> > In this change:
> > 	95 insertions(+), 46 deletions(-)
> > 
> > In the follow up SPI driver cleaning (not yet submitted):
> > 	14 insertions(+), 121 deletions(-)
> 
> Not sure we are understanding each other.
> 
> The patch is fine.  I'm referring to the software_node interface.

Ah, I see, sorry for the confusion.

-- 
With Best Regards,
Andy Shevchenko


