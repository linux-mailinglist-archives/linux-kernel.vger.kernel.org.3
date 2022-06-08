Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E45542FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiFHMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbiFHMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6622BD5;
        Wed,  8 Jun 2022 05:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DAF261796;
        Wed,  8 Jun 2022 12:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CE3C34116;
        Wed,  8 Jun 2022 12:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654689815;
        bh=3Kv1ske3mQCJvHHnTjOiGzX4NxWnEChsCKT/2kNbG2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZyePu6sOZYJTwmttakqqrOsDxRtnjClOHoS1jbaaTlvl/5sI5GxrmS6dZhg5hQ40
         nMV6daNFhXVs8SMA5gqpzP4s7Fk+izoUJb156mGt61uoHf83rF/4R6+5/SAVlJajJV
         2PkgJmClEuvEkCrgsfRJNIbOpB7jyipow3VHIIRk=
Date:   Wed, 8 Jun 2022 14:03:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: Use device_find_first_child() instead of
 custom approach
Message-ID: <YqCQFFRXyaaQNSWv@kroah.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
 <YqCJsRqrCRiIBm1P@kroah.com>
 <YqCMunw+2WHIinOP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqCMunw+2WHIinOP@smile.fi.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:49:14PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 08, 2022 at 01:36:17PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 07, 2022 at 11:20:58PM +0300, Andy Shevchenko wrote:
> > > We have already a helper to get the first child device, use it and
> > > drop custom approach.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/spi/spi.c | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index ea09d1b42bf6..87dc8773108b 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -2613,11 +2613,6 @@ int spi_slave_abort(struct spi_device *spi)
> > >  }
> > >  EXPORT_SYMBOL_GPL(spi_slave_abort);
> > >  
> > > -static int match_true(struct device *dev, void *data)
> > > -{
> > > -	return 1;
> > > -}
> > > -
> > >  static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
> > >  			  char *buf)
> > >  {
> > > @@ -2625,7 +2620,7 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
> > >  						   dev);
> > >  	struct device *child;
> > >  
> > > -	child = device_find_child(&ctlr->dev, NULL, match_true);
> > > +	child = device_find_first_child(&ctlr->dev);
> > >  	return sprintf(buf, "%s\n",
> > >  		       child ? to_spi_device(child)->modalias : NULL);
> > >  }
> > 
> > Horrible naming convention asside, what is this really showing?  I do
> > not see this documented in Documentation/ABI/ anywhere, so can it just
> > be dropped entirely?
> > 
> > Ah, it's in Documentation/spi/spi-summary.rst not where it belongs...
> > 
> > Looks like "any" of the child devices could match here, so it's just
> > finding the first one by default.  So you aren't explicitly asking for
> > the real first device, you could return the last one as well, and it
> > would still work as there is just "one" device in this list from what I
> > can tell.
> > 
> > So is does this really deserve a new driver core api call?
> 
> As I said I noticed more places like this (*) and the problem is that I can't
> simply use device_match_any() because of the different prototype.

Why not exactly?  match_true() above and device_match_any() have the
same signature from what I can tell:
	static int match_true(struct device *dev, void *data)
	int device_match_any(struct device *dev, const void *unused)

What am I missing, the const?

> I agree that all thing should be using _any instead of _first.

Yes, so let's fix it please, don't propagate bad patterns.

thanks,

greg k-h
