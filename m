Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9188749CAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiAZNhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:37:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:16346 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240349AbiAZNhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643204268; x=1674740268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmK1OypQwozk6Z81aB2x4jSDvUEaSiuWsKWVh06ZKE4=;
  b=gOnwGs2+M6yxfHhcg0XbJo0y+2K0N+DBJJzyiThFIaYeamwKnGHezoSJ
   zeZJtzg/YLPN3jqUZQ1wb8Jh0ITdrdkBfEGKfrErnFfKajwjSe4sy22dI
   G4ooxUJqJcnxwYKztzllWCZ6TTXZKpFx6H23dc5JQs4QuMpWH/bCR7T9Q
   ZsG6TYuz0bWkziy5NsqAkbz1FKoSCPAySWx6NCeDxxFjpY/IQ6OBrIFQB
   13fl6212xhv9NaEOFJHSmG+mKB+C7w5wZkKpW6zW8dw2aNE544NsDRIDl
   k7ZCJm7/c5K0ZjdOjjeCQ3pWMUhyts0uFCRW25n/d9wcABSHeV/TIQTEH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="226525587"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="226525587"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="674357166"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jan 2022 05:37:45 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 Jan 2022 15:37:45 +0200
Date:   Wed, 26 Jan 2022 15:37:45 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: ulpi: Call of_node_put correctly
Message-ID: <YfFOqXDjwUriOXR1@kuha.fi.intel.com>
References: <20220124173344.874885-1-sean.anderson@seco.com>
 <20220124173344.874885-2-sean.anderson@seco.com>
 <Ye/AUUlnuHBoGxab@kuha.fi.intel.com>
 <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Tue, Jan 25, 2022 at 11:53:58AM -0500, Sean Anderson wrote:
> Hi Heikki,
> 
> On 1/25/22 4:18 AM, Heikki Krogerus wrote:
> > On Mon, Jan 24, 2022 at 12:33:44PM -0500, Sean Anderson wrote:
> >> of_node_put should always be called on device nodes gotten from
> >> of_get_*. Additionally, it should only be called after there are no
> >> remaining users. To address the first issue, call of_node_put if later
> >> steps in ulpi_register fail. To address the latter, call of_node_put
> >> only after calling device_unregister.
> > 
> > This looks like a fix, but you don't have the fix tag.
> 
> You're right this should have
> 
> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
> 
> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> ---
> >> 
> >> Changes in v2:
> >> - New
> >> 
> >>  drivers/usb/common/ulpi.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> >> index 87deb514eb78..c6ba72544f2b 100644
> >> --- a/drivers/usb/common/ulpi.c
> >> +++ b/drivers/usb/common/ulpi.c
> >> @@ -301,11 +301,11 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> >>  
> >>  	ret = ulpi_read_id(ulpi);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err;
> >>  
> >>  	ret = device_register(&ulpi->dev);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err;
> > 
> > I think there is another bug in the code here. Missing put_device().
> 
> So what is the correct way to create a device? Shouldn't device_register
> be paired with device_unregister? And from what I can tell,
> device_unregister does not put the of_node.

I think this is best explained in the documentation. Check the "Rule
of thumb is" section (device_register() is really just a wrapper that
can only fail if device_add() fails):
https://docs.kernel.org/driver-api/infrastructure.html?highlight=device_add#c.device_add

So you just want to drop the reference if device_register() fails.
That will make sure ulpi_dev_release() is called also in this case.

> > If you first fix that, you should then be able to call
> > fwnode_handle_put() (instead of of_node_put())
> 
> Well, we currently only have a ulpi_of_register, so I don't think we
> will have a fwnode here. But I can use that if you wish.
> 
> --Sean
> 
> > from
> > ulpi_dev_release(), and that should cover all cases.
> > 
> >>  	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
> >>  	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
> >> @@ -314,6 +314,10 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> >>  		ulpi->id.vendor, ulpi->id.product);
> >>  
> >>  	return 0;
> >> +
> >> +err:
> >> +	of_node_put(ulpi->dev.of_node);
> >> +	return ret;
> > 
> > So no need for that.
> > 
> >>  }
> >>  
> >>  /**
> >> @@ -357,8 +361,8 @@ void ulpi_unregister_interface(struct ulpi *ulpi)
> >>  {
> >>  	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
> >>  						ULPI_ROOT));
> >> -	of_node_put(ulpi->dev.of_node);
> >>  	device_unregister(&ulpi->dev);
> >> +	of_node_put(ulpi->dev.of_node);
> >>  }
> > 
> > And here you can just remove that of_node_put() call.

Note. Just by calling device_unregister() does not guarantee that
there are no more users left. We can be certain that the last user is
gone only when ulpi_dev_release() is called, so that's the place
where you want to release the fwnode (of_node).

thanks,

-- 
heikki
