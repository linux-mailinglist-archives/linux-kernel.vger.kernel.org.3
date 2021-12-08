Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2846D218
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhLHL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:27:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:3531 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhLHL1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:27:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="235322839"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="235322839"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 03:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="658155269"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 08 Dec 2021 03:23:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Dec 2021 13:23:41 +0200
Date:   Wed, 8 Dec 2021 13:23:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] usb: typec: port-mapper: Convert to the component
 framework
Message-ID: <YbCVvVMjf7Q9Y0og@kuha.fi.intel.com>
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
 <20211207143757.21895-5-heikki.krogerus@linux.intel.com>
 <Ya+BvnS8XqW9NpNc@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya+BvnS8XqW9NpNc@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:46:06PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 07, 2021 at 05:37:56PM +0300, Heikki Krogerus wrote:
> > Instead of trying to keep track of the connections to the
> > USB Type-C connectors separately, letting the component
> > framework take care of that.
> > 
> > From now on every USB Type-C connector will register itself
> > as "aggregate" - component master - and anything that can be
> > connected to it can then simply register itself as a generic
> > component.
> > 
> > The matching of the components and the connector shall rely
> > on ACPI _PLD initially. Before registering itself as the
> > aggregate, the connector will check the list of other
> > devices that share the same ACPI _PLD with it, and add a
> > component match entry for each one of them. Because only
> > ACPI is supported for now, the driver shall only be build
> > when ACPI is supported.
> > 
> > This removes the need for the custom API that the driver
> > exposed. The components and the connector can therefore
> > exist completely independently of each other. The order in
> > which they are registered, as well as are they modules or
> > not, is now irrelevant.
> 
> ...
> 
> > +static int typec_port_compare(struct device *dev, void *fwnode)
> >  {
> 
> > +	return dev_fwnode(dev) == fwnode;
> >  }
> 
> NIH device_match_fwnode()
> 
> ...
> 
> > +	/* Component match for every device that shares the same _PLD. */
> > +	list_for_each_entry(adev, &location->devices, location_list) {
> 
> > +		if (adev == ACPI_COMPANION(&con->dev))
> 
> 	device_match_acpi_dev()

Ah, both look like great helpers. I'll this in v2. Thanks.

-- 
heikki
