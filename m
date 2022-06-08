Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD9542F79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiFHLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiFHLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:51:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3991567C7;
        Wed,  8 Jun 2022 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654689088; x=1686225088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SagvKZQEJ2pNnaIJVkZeYl9QuT+5kEEO307X9m8u5cc=;
  b=ek9+2Plc/F1SKCYZybtiL73ydG+3Z0E/9x1Ki9VUpJI8Km/Ypp/NRr54
   /aZFS1cxKasD7oRv7KalVqcU8AQtVPrqVUK1W+TQP3ELM1jKCLvd4hZhh
   mwLME5rY8SbrYuJ6rlgiXDVKLEahp35MNewrEXKiF/j8ieCduU9/3xKOn
   aSMzgP10pD+VSgfAqpY5RdNM+0tmSkxIjpIjfBO+H/MQ8G2vfYzHD+/YF
   mzwDutYUTw730n6EnCVlDemOoMWgfrel86/GYzwQAGqPooxLSYm+dhK1Y
   JxkT0oPPXWdDIgI3hJy2EmjdV9EdCJ57RPQJNFgWbz8mooHvSOn2WJ3iy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257299706"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="257299706"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 04:51:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="648571840"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 04:51:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyuBW-000Wjj-Hm;
        Wed, 08 Jun 2022 14:49:14 +0300
Date:   Wed, 8 Jun 2022 14:49:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: Use device_find_first_child() instead of
 custom approach
Message-ID: <YqCMunw+2WHIinOP@smile.fi.intel.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
 <YqCJsRqrCRiIBm1P@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqCJsRqrCRiIBm1P@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 01:36:17PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 07, 2022 at 11:20:58PM +0300, Andy Shevchenko wrote:
> > We have already a helper to get the first child device, use it and
> > drop custom approach.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/spi/spi.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index ea09d1b42bf6..87dc8773108b 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -2613,11 +2613,6 @@ int spi_slave_abort(struct spi_device *spi)
> >  }
> >  EXPORT_SYMBOL_GPL(spi_slave_abort);
> >  
> > -static int match_true(struct device *dev, void *data)
> > -{
> > -	return 1;
> > -}
> > -
> >  static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
> >  			  char *buf)
> >  {
> > @@ -2625,7 +2620,7 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
> >  						   dev);
> >  	struct device *child;
> >  
> > -	child = device_find_child(&ctlr->dev, NULL, match_true);
> > +	child = device_find_first_child(&ctlr->dev);
> >  	return sprintf(buf, "%s\n",
> >  		       child ? to_spi_device(child)->modalias : NULL);
> >  }
> 
> Horrible naming convention asside, what is this really showing?  I do
> not see this documented in Documentation/ABI/ anywhere, so can it just
> be dropped entirely?
> 
> Ah, it's in Documentation/spi/spi-summary.rst not where it belongs...
> 
> Looks like "any" of the child devices could match here, so it's just
> finding the first one by default.  So you aren't explicitly asking for
> the real first device, you could return the last one as well, and it
> would still work as there is just "one" device in this list from what I
> can tell.
> 
> So is does this really deserve a new driver core api call?

As I said I noticed more places like this (*) and the problem is that I can't
simply use device_match_any() because of the different prototype.

I agree that all thing should be using _any instead of _first.

*) e.g. ptp_ocp.

-- 
With Best Regards,
Andy Shevchenko


