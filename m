Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06546BFC5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbhLGPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:50:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:22278 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239048AbhLGPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:50:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="300985523"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="300985523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:47:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="542835501"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:47:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mucfP-003HBs-3l;
        Tue, 07 Dec 2021 17:46:07 +0200
Date:   Tue, 7 Dec 2021 17:46:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] usb: typec: port-mapper: Convert to the component
 framework
Message-ID: <Ya+BvnS8XqW9NpNc@smile.fi.intel.com>
References: <20211207143757.21895-1-heikki.krogerus@linux.intel.com>
 <20211207143757.21895-5-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207143757.21895-5-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:37:56PM +0300, Heikki Krogerus wrote:
> Instead of trying to keep track of the connections to the
> USB Type-C connectors separately, letting the component
> framework take care of that.
> 
> From now on every USB Type-C connector will register itself
> as "aggregate" - component master - and anything that can be
> connected to it can then simply register itself as a generic
> component.
> 
> The matching of the components and the connector shall rely
> on ACPI _PLD initially. Before registering itself as the
> aggregate, the connector will check the list of other
> devices that share the same ACPI _PLD with it, and add a
> component match entry for each one of them. Because only
> ACPI is supported for now, the driver shall only be build
> when ACPI is supported.
> 
> This removes the need for the custom API that the driver
> exposed. The components and the connector can therefore
> exist completely independently of each other. The order in
> which they are registered, as well as are they modules or
> not, is now irrelevant.

...

> +static int typec_port_compare(struct device *dev, void *fwnode)
>  {

> +	return dev_fwnode(dev) == fwnode;
>  }

NIH device_match_fwnode()

...

> +	/* Component match for every device that shares the same _PLD. */
> +	list_for_each_entry(adev, &location->devices, location_list) {

> +		if (adev == ACPI_COMPANION(&con->dev))

	device_match_acpi_dev()

> +			continue;

-- 
With Best Regards,
Andy Shevchenko


